

***********************************************************************************************
***********************************************************************************************
* Title: Cap 4
* Author: Ignacio Borba
* Date: 18/10/2021
* Update: 19/10/2021
***********************************************************************************************
***********************************************************************************************


use "/Users/macbook/Dropbox/Documents/Facultad/7.Tesis/Encuesta/Analysis/bases/base_v2.dta", clear


***********************************************************************************************


tab pal8_1 edad4, col nofreq
tab pal9_1 edad4, col nofreq
tab pal10_1 edad4, col nofreq
tab pal12_1 edad4, col nofreq
tab pal15_1 edad4, col nofreq


tab pal8_1 edad4 if cons2 == 1, col nofreq
tab pal9_1 edad4 if cons2 == 1, col nofreq
tab pal10_1 edad4 if cons2 == 1, col nofreq
tab pal12_1 edad4 if cons2 == 1, col nofreq
tab pal15_1 edad4 if cons2 == 1, col nofreq



tab pal1_1 edad4, col nofreq
tab pal2_1 edad4, col nofreq
tab pal3_1 edad4, col nofreq
tab pal4_1 edad4, col nofreq
tab pal5_1 edad4, col nofreq
tab pal6_1 edad4, col nofreq


tab pal1_1 edad4 if cons2 == 1, col nofreq
tab pal2_1 edad4 if cons2 == 1, col nofreq
tab pal3_1 edad4 if cons2 == 1, col nofreq
tab pal4_1 edad4 if cons2 == 1, col nofreq
tab pal5_1 edad4 if cons2 == 1, col nofreq
tab pal6_1 edad4 if cons2 == 1, col nofreq



tab pal8_1 autidrec, col nofreq
tab pal9_1 autidrec, col nofreq
tab pal10_1 autidrec, col nofreq
tab pal12_1 autidrec, col nofreq
tab pal15_1 autidrec, col nofreq


tab pal8_1 autidrec if cons2 == 1, col nofreq
tab pal9_1 autidrec if cons2 == 1, col nofreq
tab pal10_1 autidrec if cons2 == 1, col nofreq
tab pal12_1 autidrec if cons2 == 1, col nofreq
tab pal15_1 autidrec if cons2 == 1, col nofreq


tab cons4 edad4, col nofreq

tab cons6

tab cons4 joven if cons5 == 1, col nofreq


tab leg1
tab leg2

tab leg1 user, col nofreq
tab leg2 user, col nofreq


tab pal21_1
tab pal22_1
tab pal23_1
tab pal24_1

glo pal_a "pal21_1 pal22_1 pal23_1 pal24_1"

foreach var in $pal_a {
	asdoc tab `var', save (Tabla3)
}


tab pal8_1 joven, col nofreq
tab pal9_1 joven, col nofreq
tab pal10_1 joven, col nofreq
tab pal12_1 joven, col nofreq
tab pal15_1 joven, col nofreq

tab pal8_1 autidrec, col nofreq
tab pal9_1 autidrec, col nofreq
tab pal10_1 autidrec, col nofreq
tab pal12_1 autidrec, col nofreq
tab pal15_1 autidrec, col nofreq


tab pal1_1
tab pal2_1
tab pal3_1
tab pal4_1
tab pal5_1
tab pal6_1

tab pal3_1 autidrec, col nofreq


gen norm_can = 0
replace norm_can = 1 if pal1_1 == 1 | pal2_1 == 1 | pal3_1 == 1 | pal4_1 == 1 | pal5_1 == 1 | pal6_1 == 1

gen norm_pbc = 0
replace norm_pbc = 1 if pal1_2 == 1 | pal2_2 == 1 | pal3_2 == 1 | pal4_2 == 1 | pal5_2 == 1 | pal6_2 == 1

gen norm_alc = 0
replace norm_alc = 1 if pal1_3 == 1 | pal2_3 == 1 | pal3_3 == 1 | pal4_3 == 1 | pal5_3 == 1 | pal6_3 == 1

gen norm_tbc = 0
replace norm_tbc = 1 if pal1_4 == 1 | pal2_4 == 1 | pal3_4 == 1 | pal4_4 == 1 | pal5_4 == 1 | pal6_4 == 1

tab norm_can
tab norm_pbc
tab norm_alc
tab norm_tbc

gen norm_leg = 0
replace norm_leg = 1 if pal1_3 == 1 | pal2_3 == 1 | pal3_3 == 1 | pal4_3 == 1 | pal5_3 == 1 | pal6_3 == 1 | pal1_4 == 1 | pal2_4 == 1 | pal3_4 == 1 | pal4_4 == 1 | pal5_4 == 1 | pal6_4 == 1

tab norm_leg


tab pal8_2 norm_pbc, col nofreq
tab pal9_2 norm_pbc, col nofreq
tab pal10_2 norm_pbc, col nofreq
tab pal12_2 norm_pbc, col nofreq
tab pal15_2 norm_pbc, col nofreq

glo pal_a_pbc "pal21_2 pal22_2 pal23_2 pal24_2"

foreach var in $pal_a_pbc {
	asdoc tab `var', save (Tabla5)
}

***********************************************************************************************

save "/Users/macbook/Dropbox/Documents/Facultad/7.Tesis/Encuesta/Analysis/bases/base_v3.dta", replace

***********************************************************************************************



