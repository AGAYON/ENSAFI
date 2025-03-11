//CODIGO DE REGRESION SEMILOG
// encontrar el cambio en salud financiera promedio
// al poder financiarse de alguna forma


**** UTILIZANDO ENSAFI 2023
cd "C:/SEM 8/bloque multidisciplinar/datos & codigos/tablas/dtas"


**** GENERAMOS LAS TABLAS A PARTIR DE LOS DTAs CREADOS
dir 

clear
set more off

// Definir archivos temporales
tempfile temp1 temp2 temp3

// Unir TVIVIENDA con THOGAR
use TVIVIENDA.dta, clear
merge 1:m llaveviv using THOGAR.dta
keep if _merge == 3  // Mantener solo las coincidencias
drop _merge
save `temp1'

// Unir el resultado con TSDEM
use `temp1', clear
merge 1:m llaveviv llavehog using TSDEM.dta
keep if _merge == 3
drop _merge
duplicates drop llaveviv llavehog, force
sort llaveviv llavehog
save `temp2'

// Unir el resultado con TMODULO
use `temp2', clear
merge 1:m llaveviv llavehog using TMODULO.dta
keep if _merge == 3
drop _merge
sort llaveviv llavehog llavemod
save semilog.dta, replace  // Guardar resultado final


//Creación de nombre de estado
gen estado=ent
label define estado_ent 1 "Aguascalientes" 2 "Baja California" 3 "Baja California Sur" 4 "Campeche" 5 "Coahuila" 6 "Colima" 7 "Chiapas" 8 "Chihuahua" 9 "Ciudad de México" 10 "Durango" 11 "Guanajuato" 12 "Guerrero" 13 "Hidalgo" 14 "Jalisco" 15 "México" 16 "Michoacán" 17 "Morelos" 18 "Nayarit" 19 "Nuevo León" 20 "Oaxaca" 21 "Puebla" 22 "Querétaro" 23 "Quintana Roo" 24 "San Luis Potosí" 25 "Sinaloa" 26 "Sonora" 27 "Tabasco" 28 "Tamaulipas" 29 "Tlaxcala"  30 "Veracruz" 31 "Yucatán" 32 "Zacatecas"
label values estado estado_ent
save semilog.dta, replace  // Guardar resultado final



//////////////////////////////////////////
// Filtrado de la tabla y creacion de variables
//////////////////////////////////////////

// usamos p7_6_1 - p7_6_8 para financiamiento de cualquier tipo (equivalente a un mes de sueldo)

use semilog.dta, clear
preserve //guardar el estado original en la memoria


// puede pagar el equivalente a un mes de sueldo con X opcion?
rename p7_6_1 puede_emergencia_ahorros 
rename p7_6_2 puede_emergencia_adelanto
rename p7_6_3 puede_emergencia_empeño
rename p7_6_4 puede_emergencia_familia
rename p7_6_5 puede_emergencia_credito
rename p7_6_6 puede_emergencia_trabajo
rename p7_6_7 puede_emergencia_agiotistas
rename p7_6_8 puede_emergencia_otro


// Reemplazar los valores 2 (respuesta = no) por 0
replace puede_emergencia_ahorros = 0 if puede_emergencia_ahorros == 2
replace puede_emergencia_adelanto = 0 if puede_emergencia_adelanto == 2
replace puede_emergencia_empeño = 0 if puede_emergencia_empeño == 2
replace puede_emergencia_familia = 0 if puede_emergencia_familia == 2
replace puede_emergencia_credito = 0 if puede_emergencia_credito == 2
replace puede_emergencia_trabajo = 0 if puede_emergencia_trabajo == 2
replace puede_emergencia_agiotistas = 0 if puede_emergencia_agiotistas == 2
replace puede_emergencia_otro = 0 if puede_emergencia_otro == 2


// Crear la variable binaria "puede_emergencia"
gen puede_emergencia = (puede_emergencia_ahorros == 1 | puede_emergencia_adelanto == 1 | ///
                        puede_emergencia_empeño == 1 | puede_emergencia_familia == 1 | ///
                        puede_emergencia_credito == 1 | puede_emergencia_trabajo == 1 | ///
                        puede_emergencia_agiotistas == 1 | puede_emergencia_otro == 1)

// Verificar la distribución de la nueva variable
tab puede_emergencia

//Modificando la variable de educacion "niv"
* Convertir la variable 'niv' de string a numérica (si es necesario)
destring niv, replace force

* Convertir los valores al rango 0-11 y cambiar 99 y "b" a missing values
replace niv = . if niv == 99 | niv == .

* Mostrar resumen de los cambios
tab niv, missing


////////////////////////////////////////////////
// Generando índice de salud financiera

// Crear las variables a usar en el índice
gen fh_p7_7_1 = p7_7_1
gen fh_p7_7_2 = p7_7_2
gen fh_p7_7_3 = p7_7_3
gen fh_p7_7_4 = p7_7_4
gen fh_p7_8_1 = p7_8_1
gen fh_p7_8_2 = p7_8_2
gen fh_p7_8_3 = p7_8_3
gen fh_p7_8_4 = p7_8_4
gen fh_p7_8_5 = p7_8_5
gen fh_p7_8_6 = p7_8_6

// Recodificar las variables de salud financiera
recode fh_p7_7_1 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_7_2 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_7_3 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_7_4 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_8_1 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_8_2 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_8_3 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_8_4 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_8_5 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_8_6 (1=4) (2=3) (3=2) (4=1) (5=0)

// Generar el indicador de salud financiera como la suma de todas las preguntas recodificadas
egen indicador_FH = rowtotal(fh_p7_7_1 fh_p7_7_2 fh_p7_7_3 fh_p7_7_4 ///
                             fh_p7_8_1 fh_p7_8_2 fh_p7_8_3 fh_p7_8_4 ///
                             fh_p7_8_5 fh_p7_8_6)

// Reasignar valores según ENSAFI 2023
recode indicador_FH (0=16) (1=21) (2=24) (3=27) (4=29) (5=31) (6=33) (7=34) (8=36) (9=38) (10=39) ///
                    (11=40) (12=42) (13=43) (14=44) (15=45) (16=47) (17=48) (18=49) (19=50) (20=52) ///
                    (21=53) (22=54) (23=55) (24=57) (25=58) (26=59) (27=60) (28=62) (29=63) (30=65) ///
                    (31=66) (32=68) (33=70) (34=71) (35=73) (36=76) (37=78) (38=81) (39=85) (40=91)

// Verificar la distribución del indicador
tab indicador_FH


//MODELO SEMILOG

// Aplicar logaritmo natural a la variable objetivo "indicador_FH"
gen log_indicador_FH = log(indicador_FH)

//aligeramos la memoria antes de expandir
keep log_indicador_FH puede_emergencia ingreso_m edad_v niv fac_ele

// Expandir la base de datos con el factor de expansión
expand fac_ele

// Ejecutar la regresión semilogarítmica
reg log_indicador_FH puede_emergencia ingreso_m edad_v niv


// Verificar la distribución de log_indicador_FH
hist log_indicador_FH, normal title(Distribución de log(indicador_FH))



restore //recupera el dataset original sin cambios en la memoria


