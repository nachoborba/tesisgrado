
***********************************************************************************************
***********************************************************************************************
* Title: Descriptives Tesis
* Author: Ignacio Borba
* Date: 13/10/2021
* Update: 19/10/2021
***********************************************************************************************
***********************************************************************************************


use "/Users/macbook/Dropbox/Documents/Facultad/7.Tesis/Encuesta/Analysis/bases/base.dta",  clear


***********************************************************************************************

** Cleaning

drop if consent == 2


** Descriptives


* edad
mean edad

gen edad4 = .
replace edad4 = 1 if edad <= 29
replace edad4 = 2 if edad <= 49 & edad >= 30
replace edad4 = 3 if edad <= 64 & edad >= 50
replace edad4 = 4 if edad >= 65

label define edad4 1 "29 a–os y menos" 2 "30 a 49 a–os" 3 "50 a 64 a–os" 4 "65 a–os y m‡s"
label val edad4 edad4

tab edad4


gen edad3 = .
replace edad3 = 1 if edad <= 39
replace edad3 = 2 if edad >= 40 & edad <=64
replace edad3 = 3 if edad >= 65

label define edad3 1 "18 a 39 a–os" 2 "40 a 64 a–os" 3 "65 y m‡s a–os"
label values edad3 edad3 

tab edad3


gen joven = .
replace joven = 1 if edad4 == 1
replace joven = 0 if edad4 != 1

label define joven 0 "Adulto" 1 "Joven"
label values joven joven

tab joven

* sexo
tab sex

* creo cruce sexedad (edad en 3)

gen sexedad = .
replace sexedad = 1 if sex == 1 & edad3 == 1
replace sexedad = 2 if sex == 2 & edad3 == 1
replace sexedad = 3 if sex == 1 & edad3 == 2
replace sexedad = 4 if sex == 2 & edad3 == 2
replace sexedad = 5 if sex == 1 & edad3 == 3
replace sexedad = 6 if sex == 2 & edad3 == 3		

label define sexedad 1 "18 a 39 a–os Hombre" 2 "18 a 39 a–os Mujer" 3 "40 a 64 a–os Hombre" 4 "40 a 64 a–os Mujer" 5 "65 o m‡s a–os Hombre" 6 "65 o m‡s a–os Mujer"
label values sexedad sexedad

tab sexedad	
			
* desajuste grande en sexedad, creo un pond por esto? Si bien no me interesa mucho la representatividad puede ser œtil al menos ponderar por estos dos par‡metros


* autid

gen autidrec = autid / 2
replace autidrec = round(autidrec,1)

label define autidrec 1 "Izquierda" 2 "Centro Izquierda" 3 "Centro" 4 "Centro Derecha" 5 "Derecha"
label values autidrec autidrec


* usuario

gen user = .
replace user = 1 if cons2 == 1
replace user = 0 if cons2 != 1

label define user 0 "No usuario" 1 "Usuario"
label values user user

tab user

***********************************************************************************************

save "/Users/macbook/Dropbox/Documents/Facultad/7.Tesis/Encuesta/Analysis/bases/base_v2.dta", replace

***********************************************************************************************


