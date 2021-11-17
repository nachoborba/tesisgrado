

***********************************************************************************************
***********************************************************************************************
* Title: Cap 4
* Author: Ignacio Borba
* Date: 18/10/2021
* Update: 06/11/2021
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
tab cons5 leg1, row nofreq

tab cons6

tab cons4 joven, col nofreq
tab cons4 cons5, col nofreq
tab cons4 cons5 if joven == 1, col nofreq
tab cons4 cons5 if joven == 0, col nofreq


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



tab pal21_1 autidrec, col nofreq
tab pal22_1 autidrec, col nofreq
tab pal23_1 autidrec, col nofreq
tab pal24_1 autidrec, col nofreq


tab pal1_1
tab pal2_1
tab pal3_1
tab pal4_1
tab pal5_1
tab pal6_1

tab pal1_1 autidrec, col nofreq
tab pal2_1 autidrec, col nofreq
tab pal3_1 autidrec, col nofreq
tab pal4_1 autidrec, col nofreq
tab pal5_1 autidrec, col nofreq
tab pal6_1 autidrec, col nofreq


gen norm_can0 = 0
replace norm_can0 = 1 if pal2_1 == 1 | pal3_1 == 1 | pal4_1 == 1 | pal5_1 == 1 | pal6_1 == 1

gen norm_pbc0 = 0
replace norm_pbc0 = 1 if pal2_2 == 1 | pal3_2 == 1 | pal4_2 == 1 | pal5_2 == 1 | pal6_2 == 1

gen norm_alc0 = 0
replace norm_alc0 = 1 if pal2_3 == 1 | pal3_3 == 1 | pal4_3 == 1 | pal5_3 == 1 | pal6_3 == 1

gen norm_tbc0 = 0
replace norm_tbc0 = 1 if pal2_4 == 1 | pal3_4 == 1 | pal4_4 == 1 | pal5_4 == 1 | pal6_4 == 1

tab norm_can0
tab norm_pbc0
tab norm_alc0
tab norm_tbc0

gen norm_leg = 0
replace norm_leg = 1 if pal1_3 == 1 | pal2_3 == 1 | pal3_3 == 1 | pal4_3 == 1 | pal5_3 == 1 | pal6_3 == 1 | pal1_4 == 1 | pal2_4 == 1 | pal3_4 == 1 | pal4_4 == 1 | pal5_4 == 1 | pal6_4 == 1

tab norm_leg


tab pal8_2 norm_pbc0, col nofreq
tab pal9_2 norm_pbc0, col nofreq
tab pal10_2 norm_pbc0, col nofreq
tab pal12_2 norm_pbc0, col nofreq
tab pal15_2 norm_pbc0, col nofreq

glo pal_a_pbc "pal21_2 pal22_2 pal23_2 pal24_2"

foreach var in $pal_a_pbc {
	asdoc tab `var', save (Tabla5)
}




tab pal21_4 user, col nofreq
tab pal22_4 user, col nofreq
tab pal23_4 user, col nofreq
tab pal24_4 user, col nofreq

tab pal8_4 user, col nofreq
tab pal9_4 user, col nofreq
tab pal10_4 user, col nofreq
tab pal12_4 user, col nofreq
tab pal15_4 user, col nofreq


***********************************************************************************************

save "/Users/macbook/Dropbox/Documents/Facultad/7.Tesis/Encuesta/Analysis/bases/base_v3.dta", replace

***********************************************************************************************



