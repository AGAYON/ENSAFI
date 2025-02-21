****TRABAJANDO CON LA ENSAFI 2023

****PROGRAMA PARA GENERAR LAS VARIABLES DE LOS GRUPOS ETARIOS Y OTROS GRUPOS POBLACIONALES
cd "C:\SEM 8\bloque multidisciplinar\datos & codigos\tablas\dtas"
use "BASE_ENSAFI2023_2.dta"
/*Permite que Stata acceda directamente a los archivos ubicados en esa carpeta sin necesidad de escribir la ruta completa en cada comando.
Es útil para organizar el trabajo y asegurarse de que los archivos de entrada y salida (como bases de datos, do-files o logs) se guarden en el lugar correcto.
Si después de ejecutar este comando ejecutas dir, Stata te mostrará los archivos disponibles en esa carpeta.*/

*Nota la persona elegida en la ENSAFI 2023 fue un integrante del hogar de 18 años o más, cuyo cumpleaños era el siguiente a la fecha de la entrevista. 



*******************************************************
****GENERANDO LOS GRUPOS ETARIOS Y OTROS GRUPOS POBLACIONALES

*generando la variable mujer=2 y hombre=1 "mujer u hombre"
gen mujer=1 if sexo==2
recode mujer .=0
gen hombre=1 if sexo==1
recode hombre .=0

*generando la variable rangos de edad de la persona elegida (1=18-29 años; 2=30-49 años; 3=50-64 años; 4=65 años o más) "rango_edad"
*ojo es la edad reportada por los miembros del hogar desde la información que proporciona la persona elegida entrevistada
gen rango_edad=1 if edad_v<=29
replace rango_edad=2 if edad_v>29 & edad_v<=49
replace rango_edad=3 if edad_v>49 & edad_v<=64
replace rango_edad=4 if edad_v>=65 & edad_v<=98
*label asigna los nombres a las categorías de las variables creadas
label define grupos_edad_lbl 1 "18-29 años" 2 "30-49 años" 3 "50-64 años" 4 "65 años o más"
label values rango_edad grupos_edad_lbl

*generando la variable educación "educacion"
/*3.8 ¿Hasta qué año o grado aprobó (NOMBRE) en la escuela?		
00	Ninguno
01	Preescolar o kínder
02	Primaria
03	Secundaria
04	Normal básica
05	Estudios técnicos con secundaria terminada
06	Preparatoria o bachillerato
07	Estudios técnicos con preparatoria terminada
08	Licenciatura o ingenieria (profesional)
09	Especialidad
10	Maestría
11	Doctorado
99	No sabe  
b	Blanco por secuencia*/
gen educacion=.
replace educacion=0 if niv==0
replace educacion=1 if niv==1
replace educacion=2 if niv==2
replace educacion=3 if niv==3
replace educacion=4 if niv==4
replace educacion=5 if niv==5
replace educacion=6 if niv==6
replace educacion=7 if niv==7
replace educacion=8 if niv==8
replace educacion=9 if niv==9
replace educacion=10 if niv==10
replace educacion=11 if niv==11
	
*generando la variable rural (menor de 15 mil habitantes) y urbana (mayor de 15 mil habitantes) "rural o urbano"
/*Tamaño de localidad	TLOC	
1	100 000 y más habitantes
2	15 000 a 99 999 habitantes
3	2 500 a 14 999 habitantes
4	menor a 2 500 habitantes*/
gen rural=1 if tloc==3 | tloc==4
recode rural .=0
gen urbano=1 if tloc==1 | tloc==2
recode urbano .=0

*poniendo levels a la variable región "region"
/*Norte (1): Baja California, Chihuahua, Coahuila, Nuevo León, Sonora y Tamaulipas
Centro-Norte (2): Aguascalientes, Baja California Sur, Colima, Durango, Jalisco, Michoacán, Nayarit, San Luis Potosí, Sinaloa y Zacatecas.
Centro (3): Ciudad de México, Estado de México, Guanajuato, Hidalgo, Morelos, Puebla, Querétaro y Tlaxcala
Sur (4): Campeche, Chiapas, Guerrero, Oaxaca, Quintana Roo, Tabasco, Veracruz y Yucatán*/
label define region_ent 1 "Norte" 2 "Centro_Norte" 3 "Centro" 4 "Sur"
label values region region_ent

*generando la variable estado (entidad federativa) "estado"
gen estado=ent
label define estado_ent 1 "Aguascalientes" 2 "Baja California" 3 "Baja California Sur" 4 "Campeche" 5 "Coahuila" 6 "Colima" 7 "Chiapas" 8 "Chihuahua" 9 "Ciudad de México" 10 "Durango" 11 "Guanajuato" 12 "Guerrero" 13 "Hidalgo" 14 "Jalisco" 15 "México" 16 "Michoacán" 17 "Morelos" 18 "Nayarit" 19 "Nuevo León" 20 "Oaxaca" 21 "Puebla" 22 "Querétaro" 23 "Quintana Roo" 24 "San Luis Potosí" 25 "Sinaloa" 26 "Sonora" 27 "Tabasco" 28 "Tamaulipas" 29 "Tlaxcala"  30 "Veracruz" 31 "Yucatán" 32 "Zacatecas"
label values estado estado_ent

*generando la variable autodenominación indígena "etnia"
/* p5_5 Por sus costumbres y tradiciones, ¿usted se considera indígena?	1=si 2=no 9=no sabe
p5_1 ¿Usted habla algún dialecto o lengua indígena?1=si 2=no*/
gen etnia=1 if p5_5==1 | p5_1==1 
recode etnia .=0

*generando la variable discapacidad "discap"
/*  p5_2_1 En su vida diaria, ¿usted cuánta dificultad tiene para ver, aun usando lentes?
p5_2_2 En su vida diaria, ¿usted cuánta dificultad tiene para oír, aun usando aparato auditivo?
p5_2_3 En su vida diaria, ¿usted cuánta dificultad tiene para mover o usar sus brazos o manos?
p5_2_4 En su vida diaria, ¿usted cuánta dificultad tiene para caminar, subir o bajar usando sus piernas?
p5_2_5 En su vida diaria, ¿usted cuánta dificultad tiene para recordar o concentrarse?
p5_2_6 En su vida diaria, ¿usted cuánta dificultad tiene para bañarse, vestirse o comer?
p5_2_7 En su vida diaria, ¿usted cuánta dificultad tiene para hablar o comunicarse (por ejemplo, entender o ser entendido por otros)?
p5_2_8 En su vida diaria, ¿usted cuánta dificultad tiene para realizar sus actividades diarias por problemas emocionales o mentales (con autonomía e independencia)? Problemas como autismo, depresión, bipolaridad, esquizofrenia, etcétera
1	No tiene dificultad
2	Lo hace con poca dificultad
3	Lo hace con mucha dificultad
4	No puede hacerlo
9	No sabe */
gen discap=1 if p5_2_1==3 | p5_2_1==4 | p5_2_2==3 | p5_2_2==4 | p5_2_3==3 | p5_2_3==4 | p5_2_4==3 | p5_2_4==4 | p5_2_5==3 | p5_2_5==4 | p5_2_6==3 | p5_2_6==4 | p5_2_7==3 | p5_2_7==4 | p5_2_8==3 | p5_2_8==4
recode discap .=0

*generando la variable soltero o con pareja "single o couple"
/*p5_3 ¿Actualmente usted ...	P5_3	
1	vive con su pareja en unión libre?
2	está separada(o)?
3	está divorciada(o)? 
4	es viuda(o)?
5	está casada(o)?
6	está soltera(o)? 
p5_4 ¿Su cónyuge o pareja forma parte de este hogar?	
1	Sí
2	No
b	Blanco por secuencia */
gen single=1 if p5_3==2 | p5_3==3 | p5_3==4 | p5_3==6 | p5_4==2 
recode single .=0
gen couple=1 if p5_3==1 | p5_3==5 | p5_4==1 
recode couple .=0


*generando la variable dependientes económicos "depend"
/* p5_7 Considerando hijastras(os), hijas(os) adoptivas(os) o reconocidas(os), y a las(os) propias(os), ¿usted tiene hijas o hijos? 1=Sí 2=No 9=No sabe
p5_8 ¿Cuántas de sus hijas o hijos son dependientes económicos dentro del hogar? Número de hijas(os) en el hogar dependientes económicos (00 - 08) No especificado (99) Blanco por secuencia (b)
p5_9_1 ¿Tiene hijas o hijos fuera del hogar que sean sus dependientes económicos? 1=Sí, 2=No, b=Blanco por secuencia 
p5_10_1 ¿Tiene alguna (otra) persona que dependa económicamente de usted como cónyuge o pareja, padres, suegros, nietas, nietos, entre otras? Vivan o no en el hogar 1=Sí 2=No
*/
gen depend=1 if (p5_7==1 & (p5_8>0 & p5_8<=8)) | p5_9_1==1 | p5_10_1==1 
recode depend .=0

*generando la variable recepción de programas/apoyos de gobierno "gob_prog"
/* p5_11 ¿Usted recibe algún apoyo económico o programa Bienestar de gobierno como personas adultas mayores, Becas Benito Juárez, Jóvenes Construyendo el Futuro, entre otros? 1=Sí, 2=No*/
gen gob_prog=1 if p5_11==1 
recode gob_prog .=0

*generando la variable es económicamente activo con pago de la persona seleccionada "eco_act"
/*p5_14 ¿La semana pasada usted...
1	trabajó por lo menos una hora?
2	tenía trabajo, pero no trabajó?
3	buscó trabajo?
4	hizo gestiones o realizó trámites para iniciar un negocio o actividad por su cuenta?
5	¿Es persona pensionada o jubilada?
6	¿Es estudiante?
7	¿Se dedica a los quehaceres del hogar o al cuidado de algún familiar?
8	¿Tiene una limitación física o mental permanente que le impide trabajar?
9	Estaba en otra situación diferente a las anteriores
p5_16 Aunque ya me dijo que usted (CONDICIÓN DE 5.14), ¿la semana pasada...
1	ayudó en un negocio (familiar o no familiar)?
2	vendió algún producto?
3	hizo algún producto para vender?
4	ayudó en las labores del campo o en la cría de animales?
5	a cambio de un pago realizó otro tipo de actividad (por ejemplo: lavó o planchó ajeno, cuidó niñas y niños)?
6	estuvo de aprendiz o haciendo su servicio social?
7	No hizo alguna actividad por un ingreso
b	Blanco por secuencia
p5_17 En ese trabajo (actividad) de la semana pasada, ¿usted fue...	
1	empleada(o) u obrera(o)?
2	jornalera(o) o peón(a)?
3	ayudante con pago?
4	patrón(a) o empleador(a) (tiene trabajadores por un sueldo)?
5	trabajador(a) por su cuenta (no tiene trabajadores por un sueldo)?
6	trabajador(a) sin pago (en un negocio familiar o no familiar)?
b	Blanco por secuencia  */
gen eco_act=1 if (p5_14==1 | p5_14==2 | p5_14==3 | p5_14==4 | p5_16==1 | p5_16==2 | p5_16==3 | p5_16==4 | p5_16==5 | p5_16==6) & (p5_17!=6 | p5_16!=7)
recode eco_act .=0

*generando la variable dueño de su vivienda "due_viv"
/*filtro_s5_2 ¿EN LA VIVIENDA VIVE LA PERSONA QUE ES DUEÑA O PROPIETARIA? 1=Sí, 2=No
p5_12¿Es usted la persona dueña de esta vivienda?	1=Sí, 2=No, 9=No especificado, b=Blanco por secuencia */
gen due_viv=1 if filtro_s5_2==1 & p5_12==1  
recode due_viv .=0


*generando la variable cuenta con seguro social "seg_soc"
/*p5_18_1 Por parte de su trabajo, ¿usted cuenta con servicio médico (IMSS, ISSSTE, PEMEX u otro)?
p5_18_2 Por parte de su trabajo, ¿usted cuenta con seguro privado para gastos médicos?
p5_18_3 Por parte de su trabajo, ¿usted cuenta con crédito para vivienda (INFONAVIT, FOVISSSTE)?
p5_18_4 Por parte de su trabajo, ¿usted cuenta con fondo de retiro (SAR o AFORE)?
1=Sí
2=No
9=No sabe
b=Blanco por secuencia */
gen seg_soc=1 if p5_18_1==1 | p5_18_2==1 | p5_18_3==1 | p5_18_4==1 
recode seg_soc .=0
 
*generando la variable quintiles de ingreso mensual laboral considerando temporalidad "ing_lab" "quintil"
/*p5_19 ¿Cuánto gana o recibe usted por trabajar (su actividad)?	
00000	No recibe ingresos
00050 - 92000	Ingresos por trabajo y periodo
98000	$98,000 y más
99999	No sabe
b	Blanco por secuencia
p5_19a ¿Cada cuándo?	
1	A la semana
2	A la quincena
3	Al mes
4	Al año
b	Blanco por secuencia*/
gen ing_lab=p5_19 if p5_19!=99999
replace ing_lab=ing_lab*4 if p5_19a==1
replace ing_lab=ing_lab*2 if p5_19a==2
replace ing_lab=ing_lab/12 if p5_19a==4 
**para crear deciles
xtile quintil=ing_lab, nq(5) 
tabstat ing_lab, by(quintil) s(n sum mean min max)
tabstat ing_lab [w= fac_ele], by(quintil) s(n sum mean min max)

*generando la variable quintiles de ingreso mensual del hogar "ing_hog" "quintil_hog"
/*p4_2 ¿Cuál es el ingreso total mensual del hogar considerando a todas las personas que lo integran? Sume los ingresos por trabajo, propinas, jubilación o pensión, dinero enviado por familiares, personas conocidas y de programas sociales.	
00200 - 96999	Ingresos mensuales del hogar
98000	$98 000 y más
99999	No sabe
*/
gen ing_hog=p4_2 if p4_2!=99999
**para crear deciles
xtile quintil_hog=ing_hog, nq(5) 
tabstat ing_hog, by(quintil_hog) s(n sum mean min max)
tabstat ing_hog [w= fac_ele], by(quintil_hog) s(n sum mean min max)

*generando la variable rangos de ingreso 
/* p4_3 Ahora seleccione el rango del ingreso mensual total del hogar.
01	Hasta $3600
02	De $3601 a $6100
03	De $6101 a $8100
04	De $8101 a $9900
05	De $9901 a $12100
06	De $12101 a $14500
07	De $14501 a $17600
08	De $17601 a $21900
09	De $21901 a $29100
10	De $29101 a $45100
11	Más de $45100 */
gen rango_ing=p4_3 
label define rango_ing_2 1 "Hasta $3600" 2 "De $3601 a $6100" 3 "De $6101 a $8100" 4 "De $8101 a $9900" 5 "De $9901 a $12100" 6 "De $12101 a $14500" 7 "De $14501 a $17600" 8 "De $17601 a $21900" 9 "De $21901 a $29100" 10 "De $29101 a $45100" 11 "Más de $45100" 
label values rango_ing rango_ing_2

*generando la variable disposición de tecnología para realizar transacciones bancarias "tecnol"
/* p1_4_05 ¿En esta vivienda tienen computadora, laptop o tablet?	
p1_4_06 ¿En esta vivienda tienen línea telefónica fija?	
p1_4_07 ¿En esta vivienda tienen teléfono celular?	
p1_4_08 ¿En esta vivienda tienen internet?	
 */
gen tecnol=1 if p1_4_05==1 | p1_4_06==1 | p1_4_07==1 | p1_4_08==1 
recode tecnol .=0

*generando la variable ahorros
/*p6_1_1 Actualmente, ¿usted ahorra prestando dinero?	
p6_1_2 Actualmente, ¿usted ahorra comprando propiedades animales o bienes?	
p6_1_3 Actualmente, ¿usted tiene dinero guardado en una caja de ahorro del trabajo o de personas conocidas?	
p6_1_4 Actualmente, ¿usted tiene dinero guardado con familiares o personas conocidas?	
p6_1_5 Actualmente, ¿usted participa en una tanda?	
p6_1_6 Actualmente, ¿usted ahorra dinero en su casa?
1=Sí
2=No
p6_3 Actualmente, ¿usted tiene ahorros en alguna de esas cuentas que mencionó?	
1=Sí
2=No
b=Blanco por secuencia  */
gen ahorros=1 if p6_1_1==1 | p6_1_2==1 | p6_1_3==1 | p6_1_4==1 | p6_1_5==1 | p6_1_6==1 | p6_3==1
recode ahorros .=0
tab ahorros [w= fac_ele]
tab rango_edad ahorros [w= fac_ele], row
tab sexo ahorros [w= fac_ele], row

*generando el % de mujeres solteras del primer quintil del ingreso del hogar en zonas rurales "m_s_pd_zr"
gen m_s_pd_zr=1 if mujer==1 & single==1 & rural==1 & quintil_hog==1 
recode m_s_pd_zr .=0
tab m_s_pd_zr [w= fac_ele]
tab m_s_pd_zr ahorros [w= fac_ele], row
tab m_s_pd_zr tecnol [w= fac_ele], row


* Graficar el porcentaje de personas con ahorros por rango de edad
gen porcentaje_ahorros = ahorros * 100
graph bar porcentaje_ahorros [w=fac_ele], over(rango_edad, label(angle(Vertical))) ///
    bar(1, color(teal)) ytitle("Porcentaje de personas con ahorros") ///
    blabel(bar, size(large) format(%9.1f)) ///
    title("Porcentaje de personas con ahorros por grupo de edad")
	
* Graficar el porcentaje de mujeres solteras del primer quintil del ingreso del hogar en zonas rurales "m_s_pd_zr" por rango de edades
gen porcentaje_m_s_pd_zr = m_s_pd_zr * 100
graph bar porcentaje_m_s_pd_zr [w=fac_ele], over(rango_edad, label(angle(90))) ///
    bar(1, color(blue)) ytitle("Porcentaje") ///
    blabel(bar, size(large) format(%9.1f)) ///
    title("Porcentaje de mujeres solteras del primer quintil del ingreso del hogar en zonas rurales") ///
    subtitle("Por grupos de edad")
	
* Graficar el porcentaje de mujeres solteras del primer quintil del ingreso del hogar en zonas rurales "m_s_pd_zr" de la variable dicotómica
histogram m_s_pd_zr, discrete percent ///
    barwidth(0.5) color(blue) ///
    xlabel(0 1, valuelabel) ///
    ytitle("Porcentaje") ///
    title("Distribución de mujeres solteras en el primer quintil en zonas rurales")
	
	
	
	
	
	/////////////////////////////////////////////////////////////////////////
//Actividad por equipo: ahorros por region (montos promedio por region)
// Cargar la base de datos
use BASE_ENSAFI2023_2.dta, clear

// Calcular el promedio de P6_4 por región
collapse (mean) p6_4, by(region)

// Graficar el promedio de P6_4 por región
graph bar p6_4, over(region) ///
    title("Ahorros promedio por región") ///
    ylabel(, angle(0)) ///
    bar(1, color(blue)) ///
    blabel(bar, format(%9.2f)) 

// Mostrar la tabla de valores para verificar
list region p6_4



