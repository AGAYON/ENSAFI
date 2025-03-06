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
keep llaveviv llavehog llavesde llavemod estado ent sexo edad_v ingreso_m fac_ele seguro monto_ahorro monto_max_deuda puede_emergencia_ahorros fac_ele

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
preserve  // Guardar el estado original en memoria

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

// Graficar barras con etiquetas del nombre del estado y colores diferenciados
graph bar (asis) riesgo_climatico otros_estados, /// Cambié el orden para que los valores más altos queden a la izquierda
    over(estado, sort(no_puede_ahorrar) descending label(angle(45) labsize(vsmall))) /// Reducí el ángulo a 45° para mejor lectura
    bar(1, color(red) lcolor(black)) /// Color rojo para estados con concentración de riesgo climático
    bar(2, color(gs8) lcolor(black)) /// Color gris para otros estados
    blabel(bar, format(%9.1f) size(vsmall)) /// Hacer más visibles las etiquetas de valores
    title("Porcentaje de personas sin ahorros para emergencias", size(medium)) /// Tamaño medio para mejor distribución
    subtitle("Ante contingencias equivalentes a un mes de ingresos", size(small)) ///
    ytitle(" ", size(medium)) ///
    ylabel(, angle(0)) ///
    legend(order(1 "Estados con concentración de riesgo climático") size(small)) /// Ajuste en tamaño de leyenda
    ysize(6) xsize(12) /// Aumentar el ancho para más espacio horizontal
    graphregion(margin(l=15 r=15 t=5 b=10)) /// Agregar más margen lateral para evitar etiquetas cortadas
    plotregion(margin(l=5 r=5)) /// Espacio adicional dentro del área de la gráfica

restore  // Recuperar el dataset original



//////////////////////////////////////////
// % de personas en los estados mecionados que no tienen una
//////////////////////////////////////////

use vulnerabilidades_estados.dta, clear
preserve  // Guardar el estado original en memoria

// Filtrar solo las observaciones donde ent es 7, 12, 20, 30 o 27
keep if inlist(ent, 7, 12, 20, 30, 27)

// Crear una tabla de frecuencia de la variable seguro
gen seguro_categoria = "No tiene seguro" if seguro == 0  // INVERTIDO
replace seguro_categoria = "Sí tiene seguro" if seguro == 1  // INVERTIDO

// Contar la cantidad de personas con y sin seguro
contract seguro_categoria, freq(frecuencia)

// Graficar el pie chart
graph pie frecuencia, ///
    over(seguro_categoria) ///
    plabel(_all percent, size(vsmall)) ///
    title("Distribución del seguro en regiones seleccionadas", size(medium)) ///
    legend(order(1 "No tiene seguro" 2 "Sí tiene seguro") size(small)) /// INVERTIDO
    graphregion(margin(l=10 r=10 t=5 b=5)) /// Márgenes para evitar etiquetas cortadas
    pie(1, color(red)) pie(2, color(green)) /// Rojo = No tiene seguro, Verde = Sí tiene seguro

restore  // Recuperar el dataset original

















