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
save cambio_climatico.dta, replace  // Guardar resultado final


//Creación de nombre de estado
gen estado=ent
label define estado_ent 1 "Aguascalientes" 2 "Baja California" 3 "Baja California Sur" 4 "Campeche" 5 "Coahuila" 6 "Colima" 7 "Chiapas" 8 "Chihuahua" 9 "Ciudad de México" 10 "Durango" 11 "Guanajuato" 12 "Guerrero" 13 "Hidalgo" 14 "Jalisco" 15 "México" 16 "Michoacán" 17 "Morelos" 18 "Nayarit" 19 "Nuevo León" 20 "Oaxaca" 21 "Puebla" 22 "Querétaro" 23 "Quintana Roo" 24 "San Luis Potosí" 25 "Sinaloa" 26 "Sonora" 27 "Tabasco" 28 "Tamaulipas" 29 "Tlaxcala"  30 "Veracruz" 31 "Yucatán" 32 "Zacatecas"
label values estado estado_ent
save cambio_climatico.dta, replace  // Guardar resultado final

//////////////////////////////////////////
// Filtrado de la tabla y creacion de variables
//////////////////////////////////////////
use cambio_climatico.dta, clear
preserve //guardar el estado original en la memoria
rename p6_2_09 seguro
rename p6_4 monto_ahorro
rename p6_12 monto_max_deuda
rename p7_6_1 puede_emergencia_ahorros // puede pagar el equivalente a un mes de sueldo con ahorros?

// Reemplazar los valores 2 (respuesta = no) por 0
replace puede_emergencia_ahorros = 0 if puede_emergencia_ahorros == 2
replace seguro = 0 if seguro == 2

//mantener las variables necesarias
keep llaveviv llavehog llavesde llavemod estado ent sexo edad_v ingreso_m fac_ele seguro monto_ahorro monto_max_deuda puede_emergencia_ahorros

//generar variables de vulnerabilidad según el criterio
gen ent_vul_cambio_climatico = inlist(ent, 7, 12, 20, 30, 27)
//con base en los municipios concentrados identificados por el gobierno de mexico en https://www.gob.mx/inafed/articulos/el-20-de-los-municipios-son-vulnerables-al-cambio-climatico-que-acciones-de-mitigacion-y-adaptacion-implementa-municipio#:~:text=Cabe%20destacar%20que%20estos%20municipios,de%20vulnerabilidad%20al%20cambio%20clim%C3%A1tico

gen ent_vul_inundaciones = inlist(ent, 4, 7, 23, 27, 28, 30, 31)
gen ent_vul_ciclones = inlist(ent, 3, 4, 23, 28, 25, 31)
gen ent_vul_sequia = inlist(ent, 2, 3, 8, 5, 25, 26, 10)
// con base en el mapa de inundaciones, ciclones y sequía en: http://www.atlasnacionalderiesgos.gob.mx/

//guardar el nuevo dataset
save vulnerabilidades_estados.dta, replace
restore //recupera el dataset original sin cambios en la memoria



//////////////////////////////////////////
// % de personas que no pueden afrontar emergencias con ahorros por estado
//////////////////////////////////////////

use vulnerabilidades_estados.dta, clear
preserve //guardar el estado original en la memoria

// Crear una variable de porcentaje de personas sin ahorros por entidad
gen no_puede_ahorrar = (puede_emergencia_ahorros == 0)
collapse (mean) no_puede_ahorrar, by(ent estado)

// Convertir a porcentaje
replace no_puede_ahorrar = no_puede_ahorrar * 100

// Crear variables separadas para diferenciar colores en el gráfico
gen riesgo_climatico = no_puede_ahorrar if inlist(ent, 7, 12, 20, 30, 27)
gen otros_estados = no_puede_ahorrar if !inlist(ent, 7, 12, 20, 30, 27)

// Ordenar los datos de mayor a menor porcentaje
gsort -no_puede_ahorrar

// Graficar barras con ajustes de espacio y legibilidad
graph bar (asis) otros_estados riesgo_climatico, ///
    over(estado, sort(no_puede_ahorrar) label(angle(60) size(small))) /// Aumentar ángulo y reducir tamaño de etiquetas
    bar(1, color(gs8) lcolor(black)) /// Color gris para entidades normales
    bar(2, color(red) lcolor(black)) /// Color rojo para estados con riesgo climático
    blabel(bar, format(%9.1f) size(vsmall)) /// Hacer más pequeñas las etiquetas de valores
    barwidth(0.7) /// Hacer las barras más delgadas para mayor separación
    title("Porcentaje de personas sin ahorros para emergencias") ///
    subtitle("Ante contingencias equivalentes a un mes de ingresos") ///
    ytitle("Porcentaje") ///
    ylabel(, angle(0)) ///
    legend(order(2 "Estados con concentración de riesgo climático" 1 "Otros estados")) ///
    ysize(8) /// Aumentar la altura de la imagen
    graphregion(margin(l=10 r=10 t=5 b=5)) /// Agregar margen para evitar etiquetas cortadas



restore // recupera el dataset original en la memoria


//////////////////////////////////////////
// Distribución monto máximo de deuda mensual
//////////////////////////////////////////


**** notas para continuar
* Averiguar como hacer bien los pegados de tablas para generar variables


* usar una base de datos con altura sobre nivel de mar y niveles de precipitación en México controlados por AGEBs

* Pegar la base anterior a las tablas de 



