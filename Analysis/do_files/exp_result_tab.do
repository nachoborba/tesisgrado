
***********************************************************************************************
***********************************************************************************************
* Title: Experiment result table
* Author: Ignacio Borba
* Date: 13/10/2021
***********************************************************************************************
***********************************************************************************************


use "/Users/macbook/Dropbox/Documents/Facultad/7.Tesis/Encuesta/Analysis/bases/base_v2.dta", clear


***********************************************************************************************

* tabla en word

asdoc, row(Tratamiento, N, Media, SD) title(Resultado por tratamiento)
sum t1
asdoc, accum(`r(N)', `r(mean)', `r(sd)')
asdoc, row( Cannabis, $accum)
sum t2
asdoc, accum(`r(N)', `r(mean)', `r(sd)')
asdoc, row( Pasta base, $accum)
sum t3
asdoc, accum(`r(N)', `r(mean)', `r(sd)')
asdoc, row( Alcohol, $accum)
sum t4
asdoc, accum(`r(N)', `r(mean)', `r(sd)')
asdoc, row( Tabaco, $accum)
