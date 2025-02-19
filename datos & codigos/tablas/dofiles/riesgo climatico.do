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
save `temp2'

// Unir el resultado con TMODULO
use `temp2', clear
merge 1:m llaveviv llavehog using TMODULO.dta
keep if _merge == 3
drop _merge
sort llaveviv llavehog
save cambio_climatico.dta, replace  // Guardar resultado final








**** notas para continuar
* Averiguar como hacer bien los pegados de tablas para generar variables


* usar una base de datos con altura sobre nivel de mar y niveles de precipitación en México controlados por AGEBs

* Pegar la base anterior a las tablas de 



