

***********************************************************************************************
***********************************************************************************************
* Title: Experiment
* Author: Ignacio Borba
* Date: 26/10/2021
* Update: 16/11/2021
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

label variable can "Cannabis"
label variable pbc "Pasta base"
label variable alc "Alcohol"
label variable tbc "Tabaco"


gen result = .
replace result = can if can !=.
replace result = pbc if pbc !=.
replace result = alc if alc !=.
replace result = tbc if tbc !=.



egen mean_can = mean(can)
egen mean_pbc = mean(pbc)
egen mean_alc = mean(alc)
egen mean_tbc = mean(tbc)

gen mean_treat = .
replace mean_treat = mean_can if can != .
replace mean_treat = mean_pbc if pbc != .
replace mean_treat = mean_alc if alc != .
replace mean_treat = mean_tbc if tbc != .

tab mean_treat


gen treat = .
replace treat = 1 if can != .
replace treat = 2 if pbc != .
replace treat = 3 if alc != .
replace treat = 4 if tbc != .

label define treat 1 "Cannabis" 2 "Pasta base" 3 "Alcohol" 4 "Tabaco"
label values treat treat

tab treat


egen median = median(result), by(treat)
egen upq = pctile(result), p(75) by(treat)
egen loq = pctile(result), p(25) by(treat)
egen iqr = iqr(result), by(treat)
egen upper = max(min(result, upq + 1.5 * iqr)), by(treat)
egen lower = min(max(result, loq - 1.5 * iqr)), by(treat)


twoway rbar median upq treat, pstyle(p1) blc(gs15) bfc(gs8) barw(0.35) || ///
	rbar median loq treat, pstyle(p1) blc(gs15) bfc(gs8) barw(0.35) || ///
	rspike upq upper treat, pstyle(p1) || ///
	rspike loq lower treat, pstyle(p1) || ///
	rcap upper upper treat, pstyle(p1) msize(*2) || ///
	rcap lower lower treat, pstyle(p1) msize(*2) || ///
	scatter result treat if !inrange(result, lower, upper), ms(Oh) legend(off) xla(1 "Cannabis" 2 "Pasta base" 3 "Alcohol" 4 "Tabaco", noticks) || ///
	scatter mean_treat treat ||



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

twoway lfit can stigma_can2 || lfit pbc stigma_pbc2 ||  lfit alc stigma_alc2 || lfit tbc stigma_tbc2, scheme(s2mono) legend(label (1 "Cannabis") label (2 "Pasta base") label (3 "Alcohol") label (4 "Tabaco")) ytitle("Nivel de incomodidad") xtitle("Nivel de estigma pœblico percibido")

asdoc corr stigma_can2 can, replace save(TablaA4.doc)
asdoc corr stigma_pbc2 pbc, save (TablaA4.doc)
asdoc corr stigma_alc2 alc, save (TablaA4.doc)
asdoc corr stigma_tbc2 tbc, save (TablaA4.doc)

***********************************************************************************************


mean can
estimates store mc

mean pbc
estimates store pb

mean alc
estimates store al

mean tbc
estimates store tb

coefplot mc pb al tb, vertical mlabel(cond(@pval<.001, "***", cond(@pval<.01, "**", cond(@pval<.05, "*", cond(@pval<.1, "+", ""))))) scheme(s1mono)

***********************************************************************************************




egen mean_can_usr = mean(can), by(user)
egen mean_pbc_usr = mean(pbc), by(user)
egen mean_alc_usr = mean(alc), by(user)
egen mean_tbc_usr = mean(tbc), by(user)

gen mean_treat_usr = .
replace mean_treat_usr = mean_can_usr if can != .
replace mean_treat_usr = mean_pbc_usr if pbc != .
replace mean_treat_usr = mean_alc_usr if alc != .
replace mean_treat_usr = mean_tbc_usr if tbc != .

tab mean_treat_usr


gen treat_usr = .
replace treat_usr = 1 if can != . & user == 1
replace treat_usr = 2 if can != . & user == 0
replace treat_usr = 3 if pbc != . & user == 1
replace treat_usr = 4 if pbc != . & user == 0
replace treat_usr = 5 if alc != . & user == 1
replace treat_usr = 6 if alc != . & user == 0
replace treat_usr = 7 if tbc != . & user == 1
replace treat_usr = 8 if tbc != . & user == 0

label define treat_usr 1 "Cannabis - Usuario" 2 "Cannabis - No usuario" 3 "Pasta base - Usuario" 4 "Pasta base - No usuario" 5 "Alcohol - Usuario" 6 "Alcohol - No usuario" 7 "Tabaco - Usuario" 8 "Tabaco - No usuario"
label values treat_usr treat_usr

tab treat_usr



egen median2 = median(result), by(treat_usr)
egen upq2 = pctile(result), p(75) by(treat_usr)
egen loq2 = pctile(result), p(25) by(treat_usr)
egen iqr2 = iqr(result), by(treat_usr)
egen upper2 = max(min(result, upq2 + 1.5 * iqr2)), by(treat_usr)
egen lower2 = min(max(result, loq2 - 1.5 * iqr2)), by(treat_usr)


twoway rbar median2 upq2 treat_usr, pstyle(p1) blc(gs15) bfc(gs8) || ///
	rbar median2 loq2 treat_usr, pstyle(p1) blc(gs15) bfc(gs8) || ///
	rspike upq2 upper2 treat_usr, pstyle(p1) || ///
	rspike loq2 lower2 treat_usr, pstyle(p1) || ///
	rcap upper2 upper2 treat_usr, pstyle(p1) msize(*2) || ///
	rcap lower2 lower2 treat_usr, pstyle(p1) msize(*2) || ///
	scatter result treat_usr if !inrange(result, lower2, upper2), ms(Oh) legend(off) xla(1 "Cannabis (Usr)" 2 "Cannabis (No usr)" 3 "Pasta base (Usr)" 4 "Pasta base (No usr)" 5 "Alcohol (Usr)" 6 "Alcohol (No usr)" 7 "Tabaco (Usr)" 8 "Tabaco (No usr)", noticks) || ///
	scatter mean_treat_usr treat_usr ||

	
	
ci can if user == 1
ci can if user == 0
ci pbc if user == 1
ci pbc if user == 0
ci alc if user == 1
ci alc if user == 0
ci tbc if user == 1
ci tbc if user == 0


mean can if user == 1
estimates store mcanusr

mean can if user == 0
estimates store mcan

mean pbc if user == 1
estimates store mpbcusr

mean pbc if user == 0
estimates store mpbc

mean alc if user == 1
estimates store malcusr

mean alc if user == 0
estimates store malc

mean tbc if user == 1
estimates store mtbcusr

mean tbc if user == 0
estimates store mtbc


coefplot mcanusr mcan mpbcusr mpbc malcusr malc mtbcusr mtbc, vertical mlabel(cond(@pval<.001, "***", cond(@pval<.01, "**", cond(@pval<.05, "*", cond(@pval<.1, "+", ""))))) scheme(s1mono)



***********************************************************************************************


reg can mujer edad region educa stigma_can stigma_can2 norm_can user
estimates store can

reg pbc mujer edad region educa stigma_pbc stigma_pbc2 norm_pbc user
estimates store pbc

reg alc mujer edad region educa stigma_alc stigma_alc2 norm_alc user
estimates store alc

reg tbc mujer edad region educa stigma_tbc stigma_tbc2 norm_tbc user
estimates store tbc


coefplot can, bylabel(Cannabis) xsc(r(-2 1)) ///
	|| pbc, bylabel(Pasta base) xsc(r(-2 1)) ///
	|| alc, bylabel(Alcohol) xsc(r(-2 1)) ///
	|| tbc, bylabel(Tabaco) xsc(r(-2 1)) ///
	||, mlabel(cond(@pval<.001, "***", cond(@pval<.01, "**", cond(@pval<.05, "*", cond(@pval<.1, "+", ""))))) xline(0) drop(_cons) scheme(s1mono) nolabels
	



***********************************************************************************************

save "/Users/macbook/Dropbox/Documents/Facultad/7.Tesis/Encuesta/Analysis/bases/base_v4.dta", replace

***********************************************************************************************






