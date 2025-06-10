#### conspiracy Daten auf Skalenebene importieren ####
#### Datenquelle: https://openpsychometrics.org/_rawdata/

# Zip in temporary directory runterladen
download.file("https://openpsychometrics.org/_rawdata/GCBS.zip",
  paste0(tempdir(), "/GCBS.zip"))

# Zip entpacken und Daten importieren
conspiracy_tmp <- read.csv(unzip(paste0(tempdir(), "/GCBS.zip"), 'data/data.csv'))

# Datensatz bauen
conspiracy <- conspiracy_tmp[, NULL]
conspiracy$edu <- factor(conspiracy_tmp$education,
  levels = 0:4,
  labels = c('not highschool', 'not highschool', 'highschool', 'college', 'college'))

conspiracy$urban <- factor(conspiracy_tmp$urban,
  levels = 1:3,
  labels = c('rural', 'suburban', 'urban'))

conspiracy$gender <- factor(conspiracy_tmp$gender,
  levels = 1:3,
  labels = c('male', 'female', 'other'))

conspiracy$age <- conspiracy_tmp$age

conspiracy <- cbind(conspiracy, conspiracy_tmp[, paste0('Q', 1:15)])

rm(conspiracy_tmp)