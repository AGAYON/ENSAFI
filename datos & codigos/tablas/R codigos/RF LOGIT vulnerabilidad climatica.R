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
  ent,
  fac_ele
FROM tmodulo ;
  "

variables_resiliencia = dbGetQuery(conexion, query)
dbDisconnect(conexion)
