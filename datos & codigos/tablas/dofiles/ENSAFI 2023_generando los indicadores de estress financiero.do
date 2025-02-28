****TRABAJANDO CON LA ENSAFI 2023

****PROGRAMA PARA GENERAR LOS INDICADORES DE SALUD FINANCIERA
cd "C:\SEM 8\bloque multidisciplinar\datos & codigos\tablas\dtas"
use "BASE_ENSAFI2023_2.dta"



*******************************************************
*****STRESS FINANCIERO
/*
p8_1_1 ¿Qué tanta preocupación siente actualmente por pedir un préstamo?	
1	Mucha
2	Alguna
3	Poca
4	Nada
p8_1_2 ¿Qué tanta preocupación siente actualmente por gastar más de lo que tenía planeado?	
1	Mucha
2	Alguna
3	Poca
4	Nada
p8_1_3  ¿Qué tanta preocupación siente actualmente por que las deudas se acumulen?	
1	Mucha
2	Alguna
3	Poca
4	Nada
p8_1_4  ¿Qué tanta preocupación siente actualmente por que el dinero sea insuficiente para sus actividades de entretenimiento?	
1	Mucha
2	Alguna
3	Poca
4	Nada
p8_1_5 ¿Qué tanta preocupación siente actualmente por tener que gastar dinero en imprevistos (enfermedades, accidentes, reparación de vehículo)?	
1	Mucha
2	Alguna
3	Poca
4	Nada
p8_1_6 ¿Qué tanta preocupación siente actualmente por la dificultad de guardar dinero para metas futuras?	P8_1_6	Alfanumérico	
1	Mucha
2	Alguna
3	Poca
4	Nada


*/

****GENERANDO LOS NIVELES DE BIENESTAR O SALUD FINANCIERA ENSAFI 2023
*generando las variables a usar para la creación del índice
gen fs_p8_1_1=p8_1_1
gen fs_p8_1_2=p8_1_2
gen fs_p8_1_3=p8_1_3
gen fs_p8_1_4=p8_1_4
gen fs_p8_1_5=p8_1_5
gen fs_p8_1_6=p8_1_6
*recodificando la variable
recode fs_p8_1_1 (1=3) (2=2) (3=1) (4=0)
recode fs_p8_1_2 (1=3) (2=2) (3=1) (4=0) 
recode fs_p8_1_3 (1=3) (2=2) (3=1) (4=0) 
recode fs_p8_1_4 (1=3) (2=2) (3=1) (4=0) 
recode fs_p8_1_5 (1=3) (2=2) (3=1) (4=0) 
recode fs_p8_1_6 (1=3) (2=2) (3=1) (4=0)  


*generando el indicador de salud financiera 1 que corresponde a la suma de la 10 preguntas recodificadas del grupo de edad de 18 a 61 años
egen indicador_fs1 = rowtotal(fs_p8_1_1 fs_p8_1_2 fs_p8_1_3 fs_p8_1_4 fs_p8_1_5 fs_p8_1_6) 
*normalizando
gen indicador_fs2=indicador_fs1
recode indicador_fs2 (0=0) (1=6) (2=11) (3=17) (4=22) (5=28) (6=33) (7=39) (8=44) (9=50) (10=56) (11=61) (12=67) (13=72) (14=78) (15=83) (16=89) (17=94) (18=100) 



/*generando los valores del indicador de salud financiera
Niveles de bienestar financiero ENSAFI
Alto (3) 			Mayor a 72 puntos
Moderado (2) 		de 40 a 72 puntos
Bajo o nada (1) 			Igual o menor a 39 puntos */


gen indice_fs=3 if indicador_fs2>72 
replace indice_fs=2 if (indicador_fs2>=40 & indicador_fs2<=72) 
replace indice_fs=1 if indicador_fs2<=39 
*label asigna los nombres a las categorías de las variables creadas
label define indice_fs_n 3 "Alto" 2 "Moderado" 1 "Bajo o nada"
label values indice_fs indice_fs_n

