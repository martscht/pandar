#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb24.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb24$hand_factor <- factor(fb24$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb24$fach <- factor(fb24$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb24$ziel <- factor(fb24$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb24$wohnen <- factor(fb24$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

# Rekodierung invertierter Items
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf11_r <- -1 * (fb24$mdbf11 - 5)
fb24$mdbf3_r <-  -1 * (fb24$mdbf3 - 5)
fb24$mdbf9_r <-  -1 * (fb24$mdbf9 - 5)

# Berechnung von Skalenwerten
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb24$ru_pre <-  fb24[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb24$ru_pre_zstd <- scale(fb24$ru_pre, center = TRUE, scale = TRUE)


dim(fb24)

## install.packages("psych")
## install.packages("car")

library(psych)
library(car)

mean_lz <- mean(fb24$lz, na.rm = TRUE) #Mittlere Lebenszufriedenheit
mean_lz

sd_lz <- sd(fb24$lz, na.rm = TRUE) #Standardabweichung (Populationsschätzer)
sd_lz

n_lz <- length(na.omit(fb24$lz)) #Stichprobengröße

se_lz <- sd_lz / sqrt(n_lz) #Standardfehler
se_lz

describe(fb24$lz) #Funktion aus Paket "psych"

#Histogramm zur Veranschaulichung der Normalverteilung
hist(fb24$lz, xlim = c(1,7), main = "Histogramm", xlab = "Score", ylab = "Dichte", freq = FALSE)
curve(dnorm(x, mean = mean(fb24$lz, na.rm = TRUE), sd = sd(fb24$lz, na.rm = TRUE)), add = TRUE)

#geeigneter Plot: QQ-Plot. Alle Punkte sollten auf einer Linie liegen.
qqnorm(fb24$lz)
qqline(fb24$lz)

#Die qqPlot-Funktion zeichnet ein Konfidenzintervall in den QQ-Plot. Dies macht es für Betrachter:innen einfacher zu entscheiden, ob alle Punkte in etwa auf einer Linie liegen. Die Punkte sollten nicht außerhalb der blauen Linien liegen.
qqPlot(fb24$lz)


t.test(fb24$lz, mu=4.4)
t.test(fb24$lz, mu=4.4, conf.level = 0.99) #Default ist 95%, deshalb erhöhen wir auf 99%

wilcox.test(fb24$lz, mu = 4.4, conf.level = 0.99) #gleiche Argumente wie beim t-Test

## Erste Schritte

anyNA(fb24$extra) #NA's vorhanden

mean_extra_pop <- 3.5 #Mittelwert der Population

sd_extra_pop <- 1.2 #empirische Standardabweichung der Population

se_extra <- sd_extra_pop / sqrt(length(na.omit(fb24$extra))) #Standardfehler

mean_extra_smpl <- mean(fb24$extra, na.rm = TRUE) #Mittelwert der Stichprobe


z_extra <- (mean_extra_smpl - mean_extra_pop) / se_extra #empirischer z-Wert

2 * pnorm(z_extra) #p < .05, signifikant

z_krit <- qnorm(1 - 0.05/2) #kritischer z-Wert, zweiseitig

abs(z_extra) > z_krit #signifikant, kann als zusätzliche Überprüfung genutzt werden

t.test(fb24$offen, mu = 3.6, alternative = "greater")

t_test2 <- t.test(fb24$offen, mu = 3.6, alternative = "greater")
p_test2 <- t_test2$p.value

t_emp <- (mean(fb24$offen, na.rm = TRUE)-3.6) / (sd(fb24$offen, na.rm = TRUE)/sqrt(length(na.omit(fb24$offen)))) # (Mittelwert Stichprobe - Mittelwert Population) / Standardfehler des Mittelwerts
t_krit <- qt(0.05, df = (length(na.omit(fb24$offen))-1), lower.tail = FALSE) # Bei "Default" des vorigen Tests gehen wir von 5% beim Alphafehler aus - Alternativhypothese Größer, daher lower.tail = F
t_emp > t_krit #Vergleich

anyNA(fb24$vertr) # NAs vorhanden !

mean_vertr <- mean(fb24$vertr, na.rm = TRUE) #Mittlere Verträglichkeit der Stichprobe

sd_vertr <- sd(fb24$vertr, na.rm = TRUE) #Stichproben SD (Populationsschätzer)

mean_pop_vertr <- 3.3 #Mittlere Verträglichkeit der Grundgesamtheit

t_quantil_einseitig_vertr <- qt(0.01, df = length(na.omit(fb24$vertr))-1, lower.tail = FALSE)

t_lower_vertr <- mean_vertr - t_quantil_einseitig_vertr * (sd_vertr / sqrt(length(na.omit(fb24$vertr)))) # Formel für N muss angepasst werden an NAs -> Wir nehmen die Länge des Vektors der Variable ohne NA statt nrow! Siehe Deskriptivstatistik für Intervallskalen

d3 <- abs((mean_vertr - mean_pop_vertr) / sd_vertr) #abs(), da Betrag
d3

anyNA(fb24$gewis) #NA's vorhanden


mean_gewis_pop <- mean(fb24$gewis, na.rm = TRUE) #Mittelwert der Population

mean_gewis_smpl1 <- 3.6 #Mittelwert der Stichprobe

sd_gewis_pop <- sd(fb24$gewis, na.rm = TRUE) * sqrt((length(na.omit(fb24$gewis)) - 1) / length(na.omit(fb24$gewis))) #empirische Standardabweichung der Population

se_gewis <- sd_gewis_pop / sqrt(42) #Standardfehler des Mittelwerts 

z_gewis1 <- (mean_gewis_smpl1 - mean_gewis_pop) / se_gewis #empirischer z-Wert

z_krit <- qnorm(1 - 0.05/2) #kritischer z-Wert, zweiseitig

abs(z_gewis1) > z_krit #nicht signifikant

2 * pnorm(z_gewis1, lower.tail = FALSE) #p Wert

upper_conf_gewis <- mean_gewis_smpl1 + z_krit * se_gewis
lower_conf_gewis <- mean_gewis_smpl1 - z_krit * se_gewis

conf_int <- c(lower_conf_gewis, upper_conf_gewis)
conf_int

fb24_red <- fb24[!is.na(fb24$gewis),] #NA's entfernen
set.seed(1234) #erlaubt Reproduzierbarkeit
fb24_sample <- fb24_red[sample(nrow(fb24_red), size = 31), ] #zieht eine Stichprobe mit n = 31

fb24_red <- fb24[!is.na(fb24$gewis),] #NA's entfernen

set.seed(1234) #erlaubt Reproduzierbarkeit
fb24_sample <- fb24_red[sample(nrow(fb24_red), size = 31), ] #zieht eine Stichprobe mit n = 31

anyNA(fb24$gewis) # NA's vorhanden
anyNA(fb24_red$gewis) # keine NA's vorhanden durch Reduzierung
anyNA(fb24_sample$gewis) # keine NA's vorhanden da Stichprobe aus fb24_red

mean_gewis_pop <- mean(fb24_red$gewis) # Mittelwert der Population

sd_gewis_pop <- sd(fb24_red$gewis) * sqrt((length(fb24_red$gewis) - 1) / length(fb24_red$gewis)) # empirische Standardabweichung der Population - ist also die Populationsvarianz

se_gewis <- sd_gewis_pop / sqrt(length(fb24_sample$gewis)) # Standardfehler des Mittelwerts

mean_gewis_smpl2 <- mean(fb24_sample$gewis) # Mittelwert der Stichprobe

z_gewis2 <- (mean_gewis_smpl2 - mean_gewis_pop) / se_gewis #empirischer z-Wert

z_krit <- qnorm(1 - 0.05/2) # kritischer z-Wert, zweiseitig

abs(z_gewis2) > z_krit # nicht signifikant

2 * pnorm(z_gewis2, lower.tail = FALSE) #p > .05, nicht signifikant
