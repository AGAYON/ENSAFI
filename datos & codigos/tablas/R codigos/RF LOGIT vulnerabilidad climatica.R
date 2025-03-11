#MODELO LOGIT ENSAFI

#librerias
#necesario para correr el codigo tener la dirección del csv "viviendas" de la ENIGH en setwd()
library(tidyverse)
library(tidymodels)
library(duckdb)
library(themis)

setwd("C:/SEM 8/bloque multidisciplinar/datos & codigos/tablas")


#creando un duckdb para generar la base 
#######################################
#establecer conexion a duckdb
conexion = dbConnect(
  drv = duckdb::duckdb(),
  dbdir = 'ENSAFI.duckdb'
)

#nos devuelve una base vacía
dbListTables(conn = conexion)

#lista de archivos en carpeta (concetradohogar & hogares)
# Lista de archivos en la carpeta
archivos <- list.files(pattern = '.csv')

# Leer y crear tablas para cada archivo CSV
for (archivo in archivos) {
  nombre_tabla <- archivo %>%
    str_remove('.csv') %>%
    tolower()
 
    query <- sprintf(
      fmt = "CREATE TABLE %s AS SELECT * FROM read_csv_auto('%s');",
      nombre_tabla,
      archivo
    )
  # Ejecutar el query 
  print(query)
  dbExecute(conn = conexion, statement = query)
}

#visualizar tablas creadas: 
dbListTables(conn = conexion)

#desconectar el db
dbDisconnect(conexion)
#######################################


#CREAR VARIABLES DE RESILIENCIA FINANCIERA
#######################################
#establecer conexion a duckdb
conexion = dbConnect(
  drv = duckdb::duckdb(),
  dbdir = 'ENSAFI.duckdb'
)
#extraer las variables necesarias de la tabla viviendas
query = "
SELECT
  p6_4 AS monto_ahorro,
  p6_8 AS nivel_deuda,
  p6_9 AS cubre_gastos,
  p6_13 AS max_deuda,
  p7_6_1 AS fin_deuda_1,
  p7_6_2 AS fin_deuda_2,
  p7_6_3 AS fin_deuda_3,
  p7_6_4 AS fin_deuda_4,
  p7_6_5 AS fin_deuda_5,
  p7_6_6 AS fin_deuda_6,
  p7_6_7 AS fin_deuda_7,
  p7_6_8 AS fin_deuda_8,
  p5_19 AS monto_ingreso,
  p5_19A AS frecuencia_ingreso,
  ent,
  fac_ele
FROM tmodulo ;
  "

variables_resiliencia = dbGetQuery(conexion, query)
dbDisconnect(conexion)



#si tienen seguros e indicador de salud financieras
      # + mas variables que hemos generado para crear el logit
#pronóstico de clasificación logit: puede hacer frente a una contingencia mayor a un 
#mes de salario si o no


##MODELO LOGIT

# Definir lista de variables explicativas
variables_explicativas <- c("")

# Asegurar que demanda_vivienda es un factor
modelo <- resiliencia_final %>% #Cambiar variable de acuerdo al modelo 1 o 2 (independencia o dueno )
  mutate(demanda_vivienda = factor(dueno, levels = c(0, 1), labels = c("No", "Si")))

# Separar los datos en entrenamiento y prueba
data_split <- modelo %>%
  initial_split(strata = demanda_vivienda) # Estratificar por la variable objetivo
train <- training(data_split) # Datos de entrenamiento
test <- testing(data_split)   # Datos de prueba

# Seleccionar solo las columnas relevantes en los datos
train <- train %>%
  select(all_of(c("demanda_vivienda", variables_explicativas)))

test <- test %>%
  select(all_of(c("demanda_vivienda", variables_explicativas)))

# Crear pliegues de validación cruzada
folds <- vfold_cv(train, v = 5)

# Crear una receta
receta <- recipe(demanda_vivienda ~ ., data = train) %>%
  update_role(all_of(variables_explicativas), new_role = "predictor") %>%
  update_role(demanda_vivienda, new_role = "outcome") %>%
  step_mutate(sexo = as.factor(sexo)) %>%        # Convertir sexo en factor
  step_dummy(all_nominal_predictors()) %>%       # Crear variables dummies
  step_impute_median(all_predictors()) %>%       # Imputar valores faltantes con la mediana
  step_smote(demanda_vivienda) %>%               # Aplicar SMOTE después de manejar NAs
  step_log(ingreso_mensual, offset = 0.001)                    # Remover predictores con varianza cero

# Definir el modelo logístico con glmnet
reg_logistica <- logistic_reg() %>%
  set_engine("glmnet") %>%
  set_mode("classification") %>%
  set_args(penalty = tune(), mixture = tune()) # Hiperparámetros a tunear

# Crear el flujo de trabajo
modelo_logistico_glmnet <- workflow() %>%
  add_recipe(receta) %>%
  add_model(reg_logistica)

# Ajuste de hiperparámetros mediante validación cruzada
parametros <- modelo_logistico_glmnet %>%
  extract_parameter_set_dials()

calibracion <- modelo_logistico_glmnet %>%
  tune_grid(
    resamples = folds,
    param_info = parametros,
    grid = 300,                                # 100 combinaciones de hiperparámetros
    metrics = metric_set(roc_auc, accuracy),   # Métricas de desempeño
    control = control_grid(verbose = TRUE)    # Barra de progreso
  )



# Obtener las métricas de calibración
metricas_calibracion <- calibracion %>%
  collect_metrics()

# Seleccionar el mejor modelo basado en ROC
mejor_modelo <- calibracion %>%
  select_best(metric = "roc_auc")

# Ajuste final con los datos completos
ajuste_final <- modelo_logistico_glmnet %>%
  finalize_workflow(mejor_modelo) %>%
  last_fit(data_split)

# Evaluar el modelo final
resultados_finales <- ajuste_final %>%
  collect_metrics()

# Mostrar las métricas
print(resultados_finales)

# Matriz de confusión
ajuste_final %>%
  collect_predictions() %>%
  conf_mat(truth = demanda_vivienda, estimate = .pred_class)

# Interpretación del modelo: predicciones y probabilidades
resultados <- ajuste_final %>%
  extract_workflow() %>%  # Extraer el flujo de trabajo final ajustado
  augment(new_data = test)  # Especificar los datos sobre los cuales quieres las predicciones
