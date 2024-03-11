# Datensatz nature aufbereiten für die Zusatzaufgaben in BSc2

load("/home/zarah/pandar.git/content/daten/SD3_origin.rda")
# load(url("https://pandar.netlify.app/daten/SD3_origin.rda"))

SD3 <- SD3_origin

SD3 <- SD3[SD3$country == "CA", ]

set.seed(23)
SD3 <- SD3[sample(nrow(SD3), 44), ]

rm(SD3_origin)

