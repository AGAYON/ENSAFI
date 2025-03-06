// ANALISIS ESTADÍSTICO: RESILIENCIA DE ESTADOS VULNERABLES
cd "C:/SEM 8/bloque multidisciplinar/datos & codigos/tablas/dtas"



// crear variables categóricas 

//
//p6_4 (categórica)= equivalencias de monto de ahorro - revisar controlando por estados
//p6_8 (categórica)= nivel de endeudamiento autopercibido
//p6_9 (binaria)= cubre sus gastos con sus ingresos si o no
//p6_13 (nivel)= monto maximo de deudas a pagar sin afectar patrimonio
//p7_6_1 - p7_6_8 (binarias)= si tuviera una emergencia equivalente a un mes de ingreso podría pagarlo?

//p7_8_1 (categorica)= capacidad de hacer frente a un implrevisto fuerte




//p6_4 (categórica)= equivalencias de monto de ahorro - revisar controlando por estados
use cambio_climatico.dta, clear
preserve // Guardar el estado original en la memoria


// Crear la variable "ahorro_menor_mes" basada en los valores de p6_4
gen ahorro_menor_mes = .
replace ahorro_menor_mes = 1 if inlist(p6_4, 1, 2)  // Ahorros de hasta un mes
replace ahorro_menor_mes = 0 if inlist(p6_4, 3, 4, 5)  // Ahorros de más de un mes

// Convertir a NA (.) cualquier otro valor que no sea 1,2,3,4,5
replace ahorro_menor_mes = . if !inlist(p6_4, 1, 2, 3, 4, 5)

// Verificar la nueva variable
tabulate p6_4 ahorro_menor_mes, missing



//////////////////////////////////////////////////



// Distribución de ingresos 
use cambio_climatico.dta, clear
preserve

// Filtrar solo los estados de interés
keep if inlist(ent, 7, 12, 20, 30, 27)

// Expandir los datos usando el factor de expansión
collapse (sum) fac_ele, by(p4_3)

// Graficar la distribución de respuestas
graph bar fac_ele, ///
    over(p4_3, sort(fac_ele) descending label(angle(45) labsize(small))) ///
    bar(1, color(blue) lcolor(black)) /// Color azul para las barras
    blabel(bar, format(%9.1f) size(vsmall)) /// Etiquetas de las frecuencias
    title("Frecuencia de respuestas en P4_3 (Estados seleccionados)", size(medium)) ///
    ytitle("Frecuencia expandida", size(medium)) ///
    ylabel(, angle(0)) ///
    ysize(6) xsize(10) /// Ajustar dimensiones para mejor visibilidad
    graphregion(margin(l=10 r=10 t=5 b=5)) /// Márgenes adecuados
    plotregion(margin(l=5 r=5)) /// Espacio adicional dentro de la gráfica

restore



//////////////////////////////////////////////////





