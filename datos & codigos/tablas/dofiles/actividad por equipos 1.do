	/////////////////////////////////////////////////////////////////////////
//Actividad por equipo: ahorros por region (montos promedio por region)
// Cargar la base de datos p6_3
use BASE_ENSAFI2023_2.dta, clear

// Convertir p6_3 en variable binaria (1 = Sí, 0 = No)
gen tiene_ahorros = (p6_3 == 1)

// Calcular el porcentaje de personas con ahorros por región
collapse (mean) tiene_ahorros, by(region)

// Convertir a porcentaje
replace tiene_ahorros = tiene_ahorros * 100

// Asignar etiquetas a la variable "region"
label define region_lbl 1 "Norte" 2 "Centro-Norte" 3 "Centro" 4 "Sur"
label values region region_lbl

// Ordenar de mayor a menor porcentaje
gsort -tiene_ahorros

// Graficar el porcentaje de personas con ahorros por región con etiquetas corregidas
graph bar (asis) tiene_ahorros, ///
    over(region, sort(tiene_ahorros) descending label(angle(45) labsize(small))) /// Etiquetas corregidas con nombres
    bar(1, color(blue) lcolor(black)) /// Color azul para las barras
    blabel(bar, format(%9.1f) size(vsmall)) /// Etiquetas dentro de las barras con valores porcentuales
    title("Porcentaje de personas con ahorros por región", size(medium)) ///
    ytitle("Porcentaje", size(medium)) ///
    ylabel(, angle(0)) ///
    ysize(6) xsize(10) /// Ajustar dimensiones para mejor visibilidad
    graphregion(margin(l=10 r=10 t=5 b=10)) /// Márgenes adecuados
    plotregion(margin(l=5 r=5)) /// Espacio adicional en la gráfica
