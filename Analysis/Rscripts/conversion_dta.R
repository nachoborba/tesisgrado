

base <- haven::read_sav("/Users/macbook/Dropbox/Documents/Facultad/7.Tesis/Encuesta/Analysis/base/base.sav")

write_dta(base, "/Users/macbook/Dropbox/Documents/Facultad/7.Tesis/Encuesta/Analysis/base/base.dta", version = 13)

