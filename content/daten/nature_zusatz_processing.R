
# Datensatz nature aufbereiten für die Zusatzaufgaben in BSc2

load(url("https://pandar.netlify.app/daten/nature_origin.rda"))

nature <- nature_origin[, c("Q1A", "Q2A", "Q3A", "Q4A", "Q5A", "Q6A", "country", "TIPI1", "TIPI2", "TIPI3",
                       "TIPI4", "TIPI5", "TIPI6", "TIPI7", "TIPI8", "TIPI9", "TIPI10", "education",
                       "urban", "gender", "engnat", "age", "hand", "religion", "orientation", "married",
                       "familysize")]

names(nature)[names(nature)=="Q1A"] <- "Q1"
names(nature)[names(nature)=="Q2A"] <- "Q2"
names(nature)[names(nature)=="Q3A"] <- "Q3"
names(nature)[names(nature)=="Q4A"] <- "Q4"
names(nature)[names(nature)=="Q5A"] <- "Q5"
names(nature)[names(nature)=="Q6A"] <- "Q6"

nature$Q1[57] <- NA
nature$Q1[1003] <- NA
nature$Q4[1478] <- NA

#### Naturverbundenheitswerte von Personen, die in städtischer oder vorstädtischer Gegend aufgewachsen sind, kleiner machen.

#nature[(nature$urban == 2 | nature$urban == 3) & nature$Q1 > 1, "Q1"] <- nature[(nature$urban == 2 | nature$urban == 3) & nature$Q1 > 1, "Q1"] - 1
#nature[nature$urban == 2 | nature$urban == 3, "Q3"] <- nature[nature$urban == 2 | nature$urban == 3, "Q1"] - 1

nature$Q_ges <- rowMeans(nature[, 1:6], na.rm=T)

rm(nature_origin)

