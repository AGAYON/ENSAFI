clear all
set more off

* Especifica la carpeta donde están los archivos CSV
local carpeta "C:/SEM 8/bloque multidisciplinar/datos/tablas"

* Obtiene la lista de archivos CSV en la carpeta
local archivos: dir "`carpeta'" files "*.csv"

* Recorre cada archivo CSV en la carpeta
foreach archivo in `archivos' {

    * Obtiene el nombre base del archivo sin la extensión
    local nombre = subinstr("`archivo'", ".csv", "", .)

    * Importa el archivo CSV
    import delimited "`carpeta'/`archivo'", clear

    * Opcional: genera una variable con el nombre del archivo
    generate fuente = "`nombre'"

    * Guarda el dataset en formato .dta en la misma carpeta
    save "`carpeta'/`nombre'.dta", replace

    * Muestra mensaje de confirmación
    di "Archivo `archivo' importado y guardado como `nombre'.dta"
}

* Mensaje final
di "Todos los archivos han sido convertidos a .dta y guardados en `carpeta'"

