// ANALISIS ESTADÍSTICO: RESILIENCIA DE ESTADOS VULNERABLES

use cambio_climatico.dta, clear
preserve //guardar el estado original en la memoria




//guardar el nuevo dataset
save vulnerabilidades_estados.dta, replace
restore //recupera el dataset original sin cambios en la memoria