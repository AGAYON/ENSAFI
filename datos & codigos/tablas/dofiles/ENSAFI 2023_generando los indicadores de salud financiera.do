****TRABAJANDO CON LA ENSAFI 2023

****PROGRAMA PARA GENERAR LOS INDICADORES DE SALUD FINANCIERA
cd "C:\SEM 8\bloque multidisciplinar\datos & codigos\tablas\dtas"
use "BASE_ENSAFI2023_2.dta"



*******************************************************
*****LA SALUD FINANCIERA
/*La Salud financiera es la capacidad de una persona para administrar gastos, prepararse y recuperarse de crisis financieras, tener una deuda mínima y generar riqueza. Drexel Univeristy. 
La salud financiera es la capacidad de administrar los recursos personales y familiares para hacer frente a imprevistos y cumplir con metas. (La Condusef, Comisión Nacional para la Protección y Defensa de los Usuarios de Servicios Financieros).

La salud financiera consta de 4 indicadores: 1) Seguridad Financiera, 2) Resiliencia financiera, 3) control financiero, 4) libertad financiera 
1) La seguridad financiera es la capacidad de cumplir con los compromisos actuales y en curso, incluidas las necesidades básicas y los gastos planificados, como los de alimentación, alquiler, pago de facturas, pago de deudas y atención médica a corto plazo. 
2) La capacidad de gestionar eventos inesperados o adversos, como averías de automóviles, pérdida de empleo o emergencias de salud repentinas. Este componente se denomina "resiliencia financiera" o capacidad para responder a los choques y recuperarse de estos. 
3) La capacidad de sentirse en control de las finanzas, sin dificultades financieras o con limitadas dificultades. El control financiero es una medida subjetiva de la salud financiera porque la sensación de "tener el control" (o no tenerlo) puede variar entre las distintas personas y hogares, a pesar de vivir bajo condiciones financieras similares.
4) La condición que refleja la capacidad de una persona de alcanzar metas financieras futuras y aprovechar las oportunidades. Corresponde a un plano de mayor subjetividad que la seguridad financiera, que acentúa el enfoque en metas financieras individuales y la valoración que se otorga de manera particular a las cosas.
Fuente: Fondo de las Naciones Unidas para el Desarrollo de la Capitalización (UNCDF)-Centro para la Salud Financiera y MetLife Foundation)

La escala del Indicador de Bienestar Financiero propuesta e incluida en el cuestionario de la ENSAFI 2023, corresponde a la Financial Well-Being Scale, elaborada y validada originalmente por la Oficina de Protección Financiera del Consumidor (CFPB por sus siglas en inglés) publicada en 2015 en Estados Unidos de América. Mediante el uso de análisis factorial y técnicas de la teoría de respuesta al ítem, la CFPB realizó un trabajo para llegar a obtener un instrumento que consta de 10 preguntas. Las respuestas de una persona a cada uno de estos 10 ítems se convierten en una puntuación entre 0 y 100, la cual indica el nivel de bienestar financiero de una persona e involucra las cuatro dimensiones de salud financiera:
• tener control sobre las finanzas diarias y mensuales (Control financiero)
• tener la capacidad de absorber un shock financiero (Resiliencia financiera) 
• estar encaminado para alcanzar sus metas financieras (Seguridad financiera)
• tener la libertad financiera y capacidad de tomar decisiones que le permitan disfrutar la vida (Libertad financiera) 
Los 10 items en la ENSAFI son los siguientes:
1) p7_7_1 ¿Con qué frecuencia puede comprar un regalo sin que sea un problema para sus finanzas?	(control)
1	Siempre (recodificando =4)
2	Casi siempre (recodificando =3)
3	A veces (recodificando =2)
4	Casi nunca (recodificando =1)
5	Nunca (recodificando =0)
2) p7_7_2 ¿Con qué frecuencia le sobra dinero al final del mes?	(c0ntrol)
1	Siempre (recodificando =4)
2	Casi siempre (recodificando =3)
3	A veces (recodificando =2)
4	Casi nunca (recodificando =1)
5	Nunca (recodificando =0)
3) p7_7_3 ¿Con qué frecuencia paga sus cuentas a tiempo?	(control)
1	Siempre (recodificando =4)
2	Casi siempre (recodificando =3)
3	A veces (recodificando =2)
4	Casi nunca (recodificando =1)
5	Nunca (recodificando =0)
4) p7_7_4 ¿Con qué frecuencia siente que puede manejar sus finanzas sin problema?	(control)
1	Siempre (recodificando =4)
2	Casi siempre (recodificando =3)
3	A veces (recodificando =2)
4	Casi nunca (recodificando =1)
5	Nunca (recodificando =0)
5) p7_8_1 Ahora, usted me responderá en qué medida le describen las siguientes frases. Puede hacer frente a un gasto imprevisto importante	(resiliencia)
1	Completamente (recodificando =4) 
2	Muy bien (recodificando =3)
3	Algo (recodificando =2)
4	Poco (recodificando =1)
5	Nada (recodificando =0)
6) p7_8_2 Ahora, usted me responderá en qué medida le describen las siguientes frases. Está asegurando su futuro financiero	(seguridad)
1	Completamente (recodificando =4)
2	Muy bien (recodificando =3)
3	Algo (recodificando =2)
4	Poco (recodificando =1)
5	Nada (recodificando =0)
7) p7_8_3 Ahora, usted me responderá en qué medida le describen las siguientes frases. Dada su situación financiera, siente que tendrá las cosas que desea	(libertad)
1	Completamente (recodificando =4)
2	Muy bien (recodificando =3)
3	Algo (recodificando =2)
4	Poco (recodificando =1)
5	Nada (recodificando =0)
8) p7_8_4 Ahora, usted me responderá en qué medida le describen las siguientes frases. Puede disfrutar la vida debido a la manera en que maneja su dinero (libertad)	
1	Completamente (recodificando =4)
2	Muy bien (recodificando =3)
3	Algo (recodificando =2)
4	Poco (recodificando =1)
5	Nada (recodificando =0)
9) p7_8_5 Ahora, usted me responderá en qué medida le describen las siguientes frases. Le alcanza bien el dinero para cubrir sus gastos	
1	Completamente (recodificando =4) (seguridad)
2	Muy bien (recodificando =3)
3	Algo (recodificando =2)
4	Poco (recodificando =1)
5	Nada (recodificando =0)
10) p7_8_6 Ahora, usted me responderá en qué medida le describen las siguientes frases. Se siente tranquila(o) de que su dinero ahorrado sea suficiente	(seguridad)
1	Completamente (recodificando =4)
2	Muy bien (recodificando =3)
3	Algo (recodificando =2)
4	Poco (recodificando =1)
5	Nada (recodificando =0)

Se usan puntuación obtenidas a través de la Teoría de Respuesta al Ítem (IRT), es una alternativa psicométricamente que permite tener en cuenta la relación de cada ítem con el concepto (por ejemplo, bienestar financiero) y el grado de gravedad, así como las propiedades del grupo de encuestados (por ejemplo, edad), al momento de la puntuación. Lo cual produce una medida (indicador) de algo que no es directamente observable, como una actitud o habilidad (el bienestar financiero para la ENSAFI).

La escala se creó para que fuera utilizada tanto por personas en edad laboral como por personas adultas mayores, incluidas las jubiladas. Con base en las investigaciones y pruebas, la CFPB encontró diferencias sustanciales según la edad de la persona (es decir, "adultos en edad de trabajar": menores de 62 años, y "personas mayores": 62 años o más). Así, la escala utiliza el corte de 62 años como punto de referencia para diferenciar la puntuación en cada una de estas poblaciones; otra de las características que la oficina dentro de su análisis menciona (que resultó ser significativa y recomienda dar un tratamiento diferenciado), la forma en que se contesta el instrumento (autollenado o aplicado por otra persona).

Las puntuaciones basadas en la IRT siguen la distribución normal estándar, es decir, una curva en forma de campana que tiene una media de cero y desviación estándar de uno. Las puntuaciones de la Escala de bienestar financiero de la CFPB son números enteros entre 0 y 100. 

*Cuestionario administrado por otra persona
*Valor de las respuestas 	18 a 61 años 	62 años y más
0 16 18
1 21 23
2 24 26
3 27 28
4 29 30
5 31 32
6 33 33
7 34 35
8 36 36
9 38 38
10 39 39
11 40 40
12 42 41
13 43 43
14 44 44
15 45 45
16 47 46
17 48 47
18 49 48
19 50 49
20 52 50
21 53 52
22 54 53
23 55 54
24 57 55
25 58 56
26 59 57
27 60 58
28 62 60
29 63 61
30 65 62
31 66 64
32 68 65
33 70 67
34 71 68
35 73 70
36 76 72
37 78 75
38 81 77
39 85 81
40 91 87

*generando los valores del indicador de salud financiera
Niveles de bienestar financiero ENSAFI
Alto (4) 			Mayor a 62 puntos
Medio alto (3) 		de 53 a 62 puntos
Medio bajo (2) 		de 44 a 52 puntos
Bajo (1) 			Igual o menor a 43 puntos 
*/

****GENERANDO LOS NIVELES DE BIENESTAR O SALUD FINANCIERA ENSAFI 2023
*generando las variables a usar para la creación del índice
gen fh_p7_7_1=p7_7_1
gen fh_p7_7_2=p7_7_2
gen fh_p7_7_3=p7_7_3
gen fh_p7_7_4=p7_7_4
gen fh_p7_8_1=p7_8_1
gen fh_p7_8_2=p7_8_2
gen fh_p7_8_3=p7_8_3
gen fh_p7_8_4=p7_8_4
gen fh_p7_8_5=p7_8_5
gen fh_p7_8_6=p7_8_6
*recodificando la variable
recode fh_p7_7_1 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_7_2 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_7_3 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_7_4 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_8_1 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_8_2 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_8_3 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_8_4 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_8_5 (1=4) (2=3) (3=2) (4=1) (5=0)
recode fh_p7_8_6 (1=4) (2=3) (3=2) (4=1) (5=0)
*Nota, los missing values siempre deben ser tratados como missing "."
*para graficar la pregunta y conocer su distribución
graph bar (count), over(p7_7_1, label(angle(45))) ///
    bar(1, color(blue)) ytitle(Frecuencia) ///
    title(Distribución de respuestas a p7_7_1)
*Los grupos de análisis son: grupo 1 (18 a 61 años), grupo 2 (62 años y más)
*generando grupo 1 son los entrevistados con edad de 18 a 61 años
gen grupo1=1 if edad_v>=18 &  edad_v<62
*generando grupo 2 son los entrevistados con edad de 62 años y más
gen grupo2=1 if edad_v>=62
*para verificar si en efecto me generó los grupos
br edad_v grupo1 grupo2
*generando el indicador de salud financiera 1 que corresponde a la suma de la 10 preguntas recodificadas del grupo de edad de 18 a 61 años
egen indicador1 = rowtotal(fh_p7_7_1 fh_p7_7_2 fh_p7_7_3 fh_p7_7_4 fh_p7_8_1 fh_p7_8_2 fh_p7_8_3 fh_p7_8_4 fh_p7_8_5 fh_p7_8_6) if grupo1 == 1
*para verificar que hizo lo deseado
br indicador1 fh_p7_7_1 fh_p7_7_2 fh_p7_7_3 fh_p7_7_4 fh_p7_8_1 fh_p7_8_2 fh_p7_8_3 fh_p7_8_4 fh_p7_8_5 fh_p7_8_6
*generando el indicador de salud financiera 2 que corresponde a la suma de la 10 preguntas recodificadas del grupo de edad de 62 años y más
egen indicador2 = rowtotal(fh_p7_7_1 fh_p7_7_2 fh_p7_7_3 fh_p7_7_4 fh_p7_8_1 fh_p7_8_2 fh_p7_8_3 fh_p7_8_4 fh_p7_8_5 fh_p7_8_6) if grupo2 == 1
*para verificar que hizo lo deseado
br indicador2 fh_p7_7_1 fh_p7_7_2 fh_p7_7_3 fh_p7_7_4 fh_p7_8_1 fh_p7_8_2 fh_p7_8_3 fh_p7_8_4 fh_p7_8_5 fh_p7_8_6
*para graficar el indicador1 y conocer su distribución
graph bar (count), over(indicador1, label(angle(45))) ///
    bar(1, color(blue)) ytitle(Frecuencia) ///
    title(Distribución de respuestas a indicador1)
*para graficar el indicador2 y conocer su distribución
graph bar (count), over(indicador2, label(angle(45))) ///
    bar(1, color(blue)) ytitle(Frecuencia) ///
    title(Distribución de respuestas a indicador2)
*dada la distribución las asignaciones deben extenderse de -z a z en cada dimensión, es decir 6 y se redondean al r más cercano. El valor predeterminado es 1 (redondeo al entero más cercano). Se reasignan los valores a partir del documento conceptual de la ENSAFI 2023.
gen indicador_FH1=indicador1
recode indicador_FH1 (0=16) (1=21) (2=24) (3=27) (4=29) (5=31) (6=33) (7=34) (8=36) (9=38) (10=39) (11=40) (12=42) (13=43) (14=44) (15=45) (16=47) (17=48) (18=49) (19=50) (20=52) (21=53) (22=54) (23=55) (24=57) (25=58) (26=59) (27=60) (28=62) (29=63) (30=65) (31=66) (32=68) (33=70) (34=71) (35=73) (36=76) (37=78) (38=81) (39=85) (40=91)
gen indicador_FH2=indicador2
recode indicador_FH2 (0=18) (1=23) (2=26) (3=28) (4=30) (5=32) (6=33) (7=35) (8=36) (9=38) (10=39) (11=40) (12=41) (13=43) (14=44) (15=45) (16=46) (17=47) (18=48) (19=49) (20=50) (21=52) (22=53) (23=54) (24=55) (25=56) (26=57) (27=58) (28=60) (29=61) (30=62) (31=64) (32=65) (33=67) (34=68) (35=70) (36=72) (37=75) (38=77) (39=81) (40=87)

*graficando el indicador_FH1
graph bar (count), over(indicador_FH1, label(angle(45))) ///
    bar(1, color(blue)) ytitle(Frecuencia) ///
    title(Distribución de respuestas a indicador_FH1)
*graficando el indicador_FH2
graph bar (count), over(indicador_FH2, label(angle(45))) ///
    bar(1, color(blue)) ytitle(Frecuencia) ///
    title(Distribución de respuestas a indicador_FH2)

/*generando los valores del indicador de salud financiera
Niveles de bienestar financiero ENSAFI
Alto (4) 			Mayor a 62 puntos
Medio alto (3) 		de 53 a 62 puntos
Medio bajo (2) 		de 44 a 52 puntos
Bajo (1) 			Igual o menor a 43 puntos */

egen indicador_FH = rowtotal(indicador_FH1 indicador_FH2) 
gen indice_FH=4 if indicador_FH>62 
replace indice_FH=3 if (indicador_FH>=53 & indicador_FH<=62) 
replace indice_FH=2 if (indicador_FH>=44 & indicador_FH<=52) 
replace indice_FH=1 if indicador_FH<=43 
*label asigna los nombres a las categorías de las variables creadas
label define indice_FH_n 4 "Alto" 3 "Medio alto" 2 "Medio Bajo" 1 "Bajo"
label values indice_FH indice_FH_n

*¿Qué grado de salud financiera tiene cada región (4 regiones) del país?
tab ... indice_FH [w=fac_ele], ro

*¿Qué grado de salud financiera tiene cada región (rural/urbano) del país?
tab ... indice_FH [w=fac_ele], co

*¿Qué entidad federativa del país tiene la salud financiera más alta?
tab ... indice_FH [w=fac_ele], co

*¿Quién tiene la salud financiera más alta, los hombres o las mujeres?
tab ... indice_FH [w=fac_ele], ro

*¿Quién tiene la salud financiera más alta, los adultos mayores o los jóvenes?
tab ...indice_FH [w=fac_ele], ro

*¿Quién tiene la salud financiera más alta, los de mayor escolaridad o los de menor escolaridad?
tab .... indice_FH [w=fac_ele], ro

*¿Quién tiene la salud financiera más alta, los solteros o los que viven en pareja?
tab .... indice_FH [w=fac_ele], ro

*¿Quién tiene la salud financiera más alta, las personas con adscripción etnica?
tab .... indice_FH [w=fac_ele], ro

*¿Quién tiene la salud financiera más alta, las personas con discapacidad?
tab .... indice_FH [w=fac_ele], ro

*¿Quién tiene la salud financiera más alta, las personas en el primer o en el último quintil?
tab .... indice_FH [w=fac_ele], ro

*¿Quién tiene la salud financiera más alta, las personas con disponibilidad de tecnología?
tab .... indice_FH [w=fac_ele], ro

*generando las regresiones
ologit indice_FH ing_hog discap  depend quintil rural  gob_prog  due_viv seg_soc tecnol ahorros, vce(robust)
ologit indice_FH educ educ2 ing_hog discap  depend quintil rural  gob_prog  due_viv seg_soc tecnol ahorros , vce(robust)

/*ologit indice_FH edad_v educacion ing_hog discap  depend quintil rural  gob_prog	due_viv	seg_soc tecnol ahorros , vce(robust)
Iteration 0:   log pseudolikelihood = -17090.241  
Iteration 1:   log pseudolikelihood = -15289.812  
Iteration 2:   log pseudolikelihood = -15252.651  
Iteration 3:   log pseudolikelihood = -15252.577  
Iteration 4:   log pseudolikelihood = -15252.577  

Ordered logistic regression                            Number of obs =  12,654
														Wald chi2(12) = 3314.34
														Prob > chi2   =  0.0000
Log pseudolikelihood = -15252.577                      Pseudo R2     =  0.1075

Robust
indice_FH  Coefficient  std. err.      z    P>z     [95% conf. interval]
edad_v   	-.0176758   .0013814   -12.80   0.000    -.0203832   -.0149683
educacion    .0419856   .0070661     5.94   0.000     .0281363     .055835
ing_hog    	 .0000188   1.82e-06    10.30   0.000     .0000152    .0000223
discap   	-.4611213   .0596311    -7.73   0.000    -.5779961   -.3442465
depend   	-.4554116   .0359636   -12.66   0.000     -.525899   -.3849242
quintil        .33274    .015373    21.64   0.000     .3026095    .3628705
rural   	-.1169206   .0361425    -3.23   0.001    -.1877586   -.0460826
gob_prog     .2040336   .0546481     3.73   0.000     .0969254    .3111419
due_viv    	 .1164451   .0386985     3.01   0.003     .0405975    .1922927
seg_soc    	 .1234631   .0387534     3.19   0.001     .0475079    .1994183
tecnol    	 .3900626   .0980689     3.98   0.000     .1978512    .5822741
ahorros    	 1.054607   .0358634    29.41   0.000     .9843156    1.124898
/cut1   -.6352014   .1256092                      -.881391   -.3890118
/cut2    1.195636   .1259604                      .9487581    1.442514
/cut3    2.983527   .1281075                      2.732441    3.234613

INTERPRETACION
Un coeficiente positivo indica que un aumento en esa variable está asociado con una mayor probabilidad de estar en una categoría más alta del índice indice_FH.
Un coeficiente negativo indica que un aumento en la variable reduce la probabilidad de estar en categorías más altas.
Por ejemplo: Edad (edad_v) (-0.0177, p < 0.001): A medida que aumenta la edad, la probabilidad de estar en categorías más altas del índice indice_FH disminuye, lo que sugiere que el acceso o uso de ciertos servicios financieros se reduce con la edad.
Educación (educacion) (0.0419, p < 0.001): Un mayor nivel educativo aumenta la probabilidad de estar en categorías más altas del índice indice_FH, lo que sugiere que la educación mejora el acceso y uso de servicios financieros.
Ingreso del hogar (ing_hog) (0.0000188, p < 0.001): Aunque el coeficiente es pequeño, indica que mayores ingresos están asociados con un mayor nivel en el índice indice_FH.
Wald Chi2(12) = 3314.34, p < 0.001: El modelo es estadísticamente significativo.
Pseudo R² = 0.1075, indica que el modelo explica en 10% la variabilidad del índice indice_FH, pero hay otros factores no incluidos que también influyen.
los cortes (/cut) determinan los umbrales entre las diferentes categorías del índice indice_FH. No se interpretan como coeficientes de variables explicativas, sino que ayudan a dividir las categorías del resultado.
En general, estos resultados muestran que la educación, el ingreso, el acceso a tecnología y el hábito del ahorro son factores clave para mejorar la salud financiera, mientras que la edad, la discapacidad, la dependencia económica y vivir en zonas rurales representan barreras.
*/

