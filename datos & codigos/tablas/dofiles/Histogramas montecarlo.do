clear all
set more off

* Cargar el archivo CSV (modifica la ruta según tu caso)
import delimited "C:/SEM 8/bloque multidisciplinar/datos & codigos/tablas/proyecciones montecarlo.csv", clear

* Crear un histograma de "tir" con 13 clases
histogram tir, bin(19) frequency title("TIR") xlabel(, angle(45))

* Crear un histograma de "vpn_ajuste" con 13 clases
histogram vpn_ajuste, bin(19) frequency title("VPN") xlabel(, angle(45))
