

***********************************************************************************************
***********************************************************************************************
* Title: Experiment
* Author: Ignacio Borba
* Date: 26/10/2021
* Update: 3/11/2021
***********************************************************************************************
***********************************************************************************************


use "/Users/macbook/Dropbox/Documents/Facultad/7.Tesis/Encuesta/Analysis/bases/base_v3.dta", clear


***********************************************************************************************


* LIMPIEZA

rename t1 can
rename t2 pbc
rename t3 alc
rename t4 tbc

replace can = . if can == 6
replace pbc = . if pbc == 6
replace alc = . if alc == 6
replace tbc = . if tbc == 6

sum can
sum pbc
sum alc
sum tbc


***********************************************************************************************


* MEDIA POR T

asdoc, row(Tratamiento, N, Media, SD), replace save(mean_treat.doc)
sum can
asdoc, accum(`r(N)', `r(mean)', `r(sd)'), save(mean_treat.doc)
asdoc, row( Cannabis, $accum), save(mean_treat.doc)
sum pbc
asdoc, accum(`r(N)', `r(mean)', `r(sd)'), save(mean_treat.doc)
asdoc, row( Pasta base, $accum), save(mean_treat.doc)
sum alc
asdoc, accum(`r(N)', `r(mean)', `r(sd)'), save(mean_treat.doc)
asdoc, row( Tabaco, $accum), save(mean_treat.doc)
sum tbc
asdoc, accum(`r(N)', `r(mean)', `r(sd)'), save(mean_treat.doc)
asdoc, row( Alcohol, $accum), save(mean_treat.doc)

***********************************************************************************************

* CODIFICACION DE VARIABLES PARA LOS MODELOS

gen region = depto
replace region = 0 if depto != 21
replace region = 1 if depto == 21

label define region 0 "Interior" 1 "Montevideo"

label value region region

tab region


gen mujer = .
replace mujer = 1 if sex == 2
replace mujer = 0 if sex == 1

label define mujer 0 "Hombre" 1 "Mujer"

label value mujer mujer

tab mujer



tab educa
tab educa, nolab

replace educa = 6 if educa == 10
replace educa = 7 if educa == 9

label define educa2 1 "Primaria incompleta" 2 "Primaria completa" 3 "Secundaria incompleta" 4 "Secundaria completa" 5 "Universitario o Terciario incompleto" 6 "Universitario o Terciario completo" 7 "Formaci—n de posgrado" 8 "No sabe, no contesta"

label value educa educa2
tab educa



***********************************************************************************************


* MODELOS SIMPLES PARA CADA UNO DE LOS T

asdoc reg can mujer edad region educa, replace nest save(models.doc)
asdoc reg pbc mujer edad region educa, nest save(models.doc)
asdoc reg alc mujer edad region educa, nest save(models.doc)
asdoc reg tbc mujer edad region educa, nest save(models.doc)



* CONSTRUYO EL INDICE DE PALAMAR PARA LOS MODELOS

label define stigma 1 "Muy en desacuerdo" 2 "2" 3 "3" 4 "4" 5 "Muy de acuerdo"

glo stigma_can "pal21_1 pal22_1 pal23_1 pal24_1"

foreach var in $stigma_can{
	replace `var' = 6 if `var' == .
	replace `var' = 6 - `var'
	label value `var' stigma
	tab `var'
}


gen stigma_can = (pal21_1 + pal22_1 + pal23_1 + pal24_1) / 4


glo stigma_pbc "pal21_2 pal22_2 pal23_2 pal24_2"

foreach var in $stigma_pbc{
	replace `var' = 6 if `var' == .
	replace `var' = 6 - `var'
	label value `var' stigma
	tab `var'
}


gen stigma_pbc = (pal21_2 + pal22_2 + pal23_2 + pal24_2) / 4


glo stigma_alc "pal21_3 pal22_3 pal23_3 pal24_3"

foreach var in $stigma_alc{
	replace `var' = 6 if `var' == .
	replace `var' = 6 - `var'
	label value `var' stigma
	tab `var'
}


gen stigma_alc = (pal21_3 + pal22_3 + pal23_3 + pal24_3) / 4


glo stigma_tbc "pal21_4 pal22_4 pal23_4 pal24_4"

foreach var in $stigma_tbc{
	replace `var' = 6 if `var' == .
	replace `var' = 6 - `var'
	label value `var' stigma
	tab `var'
}


gen stigma_tbc = (pal21_4 + pal22_4 + pal23_4 + pal24_4) / 4


glo stigma_all "stigma_can stigma_pbc stigma_alc stigma_tbc"

foreach var in $stigma_all{
	sum `var'
}




glo stigma_can2 "pal8_1 pal9_1 pal10_1 pal12_1 pal15_1"

foreach var in $stigma_can2{
	replace `var' = 6 if `var' == .
	replace `var' = 6 - `var'
	label value `var' stigma
	tab `var'
}


gen stigma_can2 = (pal8_1 + pal9_1 + pal10_1 + pal12_1 + pal15_1) / 5


glo stigma_pbc2 "pal8_2 pal9_2 pal10_2 pal12_2 pal15_2"

foreach var in $stigma_pbc2{
	replace `var' = 6 if `var' == .
	replace `var' = 6 - `var'
	label value `var' stigma
	tab `var'
}


gen stigma_pbc2 = (pal8_2 + pal9_2 + pal10_2 + pal12_2 + pal15_2) / 5


glo stigma_alc2 "pal8_3 pal9_3 pal10_3 pal12_3 pal15_3"

foreach var in $stigma_alc2{
	replace `var' = 6 if `var' == .
	replace `var' = 6 - `var'
	label value `var' stigma
	tab `var'
}


gen stigma_alc2 = (pal8_3 + pal9_3 + pal10_3 + pal12_3 + pal15_3) / 5


glo stigma_tbc2 "pal8_4 pal9_4 pal10_4 pal12_4 pal15_4"

foreach var in $stigma_tbc2{
	replace `var' = 6 if `var' == .
	replace `var' = 6 - `var'
	label value `var' stigma
	tab `var'
}


gen stigma_tbc2 = (pal8_4 + pal9_4 + pal10_4 + pal12_4 + pal15_4) / 5


glo stigma_all2 "stigma_can2 stigma_pbc2 stigma_alc2 stigma_tbc2"

foreach var in $stigma_all2{
	sum `var'
}




label define norm 0 "No" 1 "Si"

glo norm_can "pal1_1 pal2_1 pal3_1 pal4_1 pal5_1 pal6_1"

foreach var in $norm_can{
	replace `var' = 0 if `var' == .
	replace `var' = 0 if `var' == 2
	replace `var' = 0 if `var' == 3
	label value `var' norm
	tab `var'
}


gen norm_can = (pal1_1 + pal2_1 + pal3_1 + pal4_1 + pal5_1 + pal6_1) / 6


glo norm_pbc "pal1_2 pal2_2 pal3_2 pal4_2 pal5_2 pal6_2"

foreach var in $norm_pbc{
	replace `var' = 0 if `var' == .
	replace `var' = 0 if `var' == 2
	replace `var' = 0 if `var' == 3
	label value `var' norm
	tab `var'
}


gen norm_pbc = (pal1_2 + pal2_2 + pal3_2 + pal4_2 + pal5_2 + pal6_2) / 6


glo norm_alc "pal1_3 pal2_3 pal3_3 pal4_3 pal5_3 pal6_3"

foreach var in $norm_alc{
	replace `var' = 0 if `var' == .
	replace `var' = 0 if `var' == 2
	replace `var' = 0 if `var' == 3
	label value `var' norm
	tab `var'
}


gen norm_alc = (pal1_3 + pal2_3 + pal3_3 + pal4_3 + pal5_3 + pal6_3) / 6


glo norm_tbc "pal1_4 pal2_4 pal3_4 pal4_4 pal5_4 pal6_4"

foreach var in $norm_tbc{
	replace `var' = 0 if `var' == .
	replace `var' = 0 if `var' == 2
	replace `var' = 0 if `var' == 3
	label value `var' norm
	tab `var'
}


gen norm_tbc = (pal1_4 + pal2_4 + pal3_4 + pal4_4 + pal5_4 + pal6_4) / 6



glo norm_all "norm_can norm_pbc norm_alc norm_tbc"

foreach var in $norm_all{
	sum `var'
}



* MODELOS CON INDICE PALMAR

asdoc reg can mujer edad region educa stigma_can, replace nest save(models2.doc)
asdoc reg can mujer edad region educa stigma_can stigma_can2, nest save(models2.doc)
asdoc reg can mujer edad region educa stigma_can stigma_can2 norm_can, nest save(models2.doc)
asdoc reg pbc mujer edad region educa stigma_pbc, nest save(models2.doc)
asdoc reg pbc mujer edad region educa stigma_pbc stigma_pbc2, nest save(models2.doc)
asdoc reg pbc mujer edad region educa stigma_pbc stigma_pbc2 norm_pbc, nest save(models2.doc)
asdoc reg alc mujer edad region educa stigma_alc, nest save(models2.doc)
asdoc reg alc mujer edad region educa stigma_alc stigma_alc2, nest save(models2.doc)
asdoc reg alc mujer edad region educa stigma_alc stigma_alc2 norm_alc, nest save(models2.doc)
asdoc reg tbc mujer edad region educa stigma_tbc, nest save(models2.doc)
asdoc reg tbc mujer edad region educa stigma_tbc stigma_tbc2, nest save(models2.doc)
asdoc reg tbc mujer edad region educa stigma_tbc stigma_tbc2 norm_tbc, nest save(models2.doc)


asdoc reg can mujer edad region educa stigma_can stigma_can2 norm_can user, replace nest save(models3.doc)
asdoc reg pbc mujer edad region educa stigma_pbc stigma_pbc2 norm_pbc user, nest save(models3.doc)
asdoc reg alc mujer edad region educa stigma_alc stigma_alc2 norm_alc user, nest save(models3.doc)
asdoc reg tbc mujer edad region educa stigma_tbc stigma_tbc2 norm_tbc user, nest save(models3.doc)


* MODELOS PARA USUARIOS DE CANNABIS

asdoc reg can mujer edad region educa stigma_can stigma_can2 norm_can if user == 1, replace nest save(models4.doc)
asdoc reg can mujer edad region educa stigma_can stigma_can2 norm_can if user == 0, nest save(models4.doc)
asdoc reg pbc mujer edad region educa stigma_pbc stigma_pbc2 norm_pbc if user == 1, nest save(models4.doc)
asdoc reg pbc mujer edad region educa stigma_pbc stigma_pbc2 norm_pbc if user == 0, nest save(models4.doc)
asdoc reg alc mujer edad region educa stigma_alc stigma_alc2 norm_alc if user == 1, nest save(models4.doc)
asdoc reg alc mujer edad region educa stigma_alc stigma_alc2 norm_alc if user == 0, nest save(models4.doc)
asdoc reg tbc mujer edad region educa stigma_tbc stigma_tbc2 norm_tbc if user == 1, nest save(models4.doc)
asdoc reg tbc mujer edad region educa stigma_tbc stigma_tbc2 norm_tbc if user == 0, nest save(models4.doc)


** TODOS LOS MODELOS PARA CADA DROGA:

* cannabis
asdoc reg can mujer edad region educa, replace nest save(models5.doc)
asdoc reg can mujer edad region educa stigma_can, nest save(models5.doc)
asdoc reg can mujer edad region educa stigma_can stigma_can2, nest save(models5.doc)
asdoc reg can mujer edad region educa stigma_can stigma_can2 norm_can, nest save(models5.doc)
asdoc reg can mujer edad region educa stigma_can stigma_can2 norm_can user, nest save(models5.doc)
asdoc reg can mujer edad region educa stigma_can stigma_can2 norm_can if user == 1, nest save(models5.doc)
asdoc reg can mujer edad region educa stigma_can stigma_can2 norm_can if user == 0, nest save(models5.doc)

* pasta base
asdoc reg pbc mujer edad region educa, replace nest save(models6.doc)
asdoc reg pbc mujer edad region educa stigma_pbc, nest save(models6.doc)
asdoc reg pbc mujer edad region educa stigma_pbc stigma_pbc2, nest save(models6.doc)
asdoc reg pbc mujer edad region educa stigma_pbc stigma_pbc2 norm_pbc, nest save(models6.doc)
asdoc reg pbc mujer edad region educa stigma_pbc stigma_pbc2 norm_pbc user, nest save(models6.doc)
asdoc reg pbc mujer edad region educa stigma_pbc stigma_pbc2 norm_pbc if user == 1, nest save(models6.doc)
asdoc reg pbc mujer edad region educa stigma_pbc stigma_pbc2 norm_pbc if user == 0, nest save(models6.doc)

* alcohol
asdoc reg alc mujer edad region educa, replace nest save(models7.doc)
asdoc reg alc mujer edad region educa stigma_alc, nest save(models7.doc)
asdoc reg alc mujer edad region educa stigma_alc stigma_alc2, nest save(models7.doc)
asdoc reg alc mujer edad region educa stigma_alc stigma_alc2 norm_alc, nest save(models7.doc)
asdoc reg alc mujer edad region educa stigma_alc stigma_alc2 norm_alc user, nest save(models7.doc)
asdoc reg alc mujer edad region educa stigma_alc stigma_alc2 norm_alc if user == 1, nest save(models7.doc)
asdoc reg alc mujer edad region educa stigma_alc stigma_alc2 norm_alc if user == 0, nest save(models7.doc)

* tabaco
asdoc reg tbc mujer edad region educa, replace nest save(models8.doc)
asdoc reg tbc mujer edad region educa stigma_tbc, nest save(models8.doc)
asdoc reg tbc mujer edad region educa stigma_tbc stigma_tbc2, nest save(models8.doc)
asdoc reg tbc mujer edad region educa stigma_tbc stigma_tbc2 norm_tbc, nest save(models8.doc)
asdoc reg tbc mujer edad region educa stigma_tbc stigma_tbc2 norm_tbc user, nest save(models8.doc)
asdoc reg tbc mujer edad region educa stigma_tbc stigma_tbc2 norm_tbc if user == 1, nest save(models8.doc)
asdoc reg tbc mujer edad region educa stigma_tbc stigma_tbc2 norm_tbc if user == 0, nest save(models8.doc)



** CON AUTID

asdoc reg can mujer edad region educa stigma_can stigma_can2 norm_can user autid_12, replace nest save(models9.doc)
asdoc reg pbc mujer edad region educa stigma_pbc stigma_pbc2 norm_pbc user autid_12, nest save(models9.doc)
asdoc reg alc mujer edad region educa stigma_alc stigma_alc2 norm_alc user autid_12, nest save(models9.doc)
asdoc reg tbc mujer edad region educa stigma_tbc stigma_tbc2 norm_tbc user autid_12, nest save(models9.doc)

***********************************************************************************************

save "/Users/macbook/Dropbox/Documents/Facultad/7.Tesis/Encuesta/Analysis/bases/base_v4.dta", replace

***********************************************************************************************






