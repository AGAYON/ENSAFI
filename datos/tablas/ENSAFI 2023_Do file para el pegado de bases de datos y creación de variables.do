****TRABAJANDO CON LA ENSAFI 2023

****PROGRAMA PARA EL PEGADO DE LAS BASES DE DATOS
cd "C:/SEM 8/bloque multidisciplinar/datos/tablas"
/*Permite que Stata acceda directamente a los archivos ubicados en esa carpeta sin necesidad de escribir la ruta completa en cada comando.
Es útil para organizar el trabajo y asegurarse de que los archivos de entrada y salida (como bases de datos, do-files o logs) se guarden en el lugar correcto.
Si después de ejecutar este comando ejecutas dir, Stata te mostrará los archivos disponibles en esa carpeta.*/
dir


**pegando la base de datos TVIVIENDA y TSDEM
use "TSDEM.dta"
sort llaveviv 
save "TSDEM.dta", replace
*base activa
use "TVIVIENDA.dta"
sort llaveviv
merge 1:m llaveviv using "TSDEM.dta"
/*El comando merge m:m en Stata realiza una combinación (merge) de dos bases de datos en una relación de "muchos a muchos" (many-to-many). Esto significa que en ambas bases de datos puede haber múltiples observaciones que coincidan para una misma clave.
1:m significa que una observación en la base activa coincide con varias en la base using.
m:1 significa que varias observaciones en la base activa coinciden con una en la base using.
*/
keep if _merge==3
tab _merge
drop _merge
sort llavehog llaveviv
*Se salva la nueva base con el nombre "BASE_ENSAFI2023"
save "BASE_ENSAFI2023.dta", replace

**pegando la base de datos BASE_ENSAFI2023 con la base THOGAR
use "THOGAR.dta"
sort llaveviv llavehog
save "THOGAR.dta", replace
*base activa
use "BASE_ENSAFI2023.dta"
sort llaveviv llavehog
merge m:1 llaveviv llavehog using "THOGAR.dta"
keep if _merge==3
tab _merge
drop _merge
sort llavehog llaveviv
*Se salva la nueva base con el nombre "BASE_ENSAFI2023"
save "BASE_ENSAFI2023.dta", replace

/*si se quieren eliminar los duplicados para quedarse únicamente con las observaciones de la persona elegida,
un integrante del hogar de 18 años o más, cuyo cumpleaños era el siguiente a la fecha de la entrevista, n=20,448 
*/
duplicates report llaveviv llavehog
duplicates drop llaveviv llavehog, force
sort llaveviv llavehog
save "BASE_ENSAFI2023_2.dta", replace

**pegando la base de datos BASE_ENSAFI2023 con la base TMODULO
use "TMODULO.dta"
sort llaveviv llavehog
save "TMODULO.dta", replace
use "BASE_ENSAFI2023_2.dta"
sort llaveviv llavehog
merge 1:1 llaveviv llavehog using "TMODULO.dta"
keep if _merge==3
tab _merge
drop _merge
sort llavehog llaveviv
*Se salva la nueva base con el nombre "BASE_ENSAFI2023"
save "BASE_ENSAFI2023_2.dta", replace

*******************************************************
****GENERANDO LAS VARIABLES PARA COMPROBAR LOS RESULTADOS DE LA PRESENTACIÓN DE RESULTADOS
use "C:/SEM 8/bloque multidisciplinar/datos/tablas/BASE_ENSAFI2023_2.dta"
*generando la variable rangos de edad
gen rango_edad=1 if edad_v<=29
replace rango_edad=2 if edad_v>29 & edad_v<=49
replace rango_edad=3 if edad_v>49 & edad_v<=64
replace rango_edad=4 if edad_v>=65 & edad_v<=98
label define grupos_edad_lbl 1 "18-29 años" 2 "30-49 años" 3 "50-64 años" 4 "65 años o más"
label values rango_edad grupos_edad_lbl
*generando la variable ahorros
gen ahorros=1 if p6_1_1==1 | p6_1_2==1 | p6_1_3==1 | p6_1_4==1 | p6_1_5==1 | p6_1_6==1 | p6_3==1
recode ahorros .=0
tab ahorros [w= fac_ele]
tab rango_edad ahorros [w= fac_ele], row
tab sexo ahorros [w= fac_ele], row
* Graficar el porcentaje de personas con ahorros por rango de edad
gen porcentaje_ahorros = ahorros * 100
graph bar porcentaje_ahorros [w=fac_ele], over(rango_edad, label(angle(Vertical))) ///
    bar(1, color(teal)) ytitle("Porcentaje de personas con ahorros") ///
    blabel(bar, size(large) format(%9.1f)) ///
    title("Porcentaje de personas con ahorros por grupo de edad")