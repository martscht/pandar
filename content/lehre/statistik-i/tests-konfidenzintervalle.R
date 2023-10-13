#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb22.rda'))  

# Nominalskalierte Variablen in Faktoren verwandeln
fb22$geschl_faktor <- factor(fb22$geschl,
                             levels = 1:3,
                             labels = c("weiblich", "männlich", "anderes"))
fb22$fach <- factor(fb22$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb22$ziel <- factor(fb22$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb22$wohnen <- factor(fb22$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

# Skalenbildung

fb22$prok2_r <- -1 * (fb22$prok2 - 5)
fb22$prok3_r <- -1 * (fb22$prok3 - 5)
fb22$prok5_r <- -1 * (fb22$prok5 - 5)
fb22$prok7_r <- -1 * (fb22$prok7 - 5)
fb22$prok8_r <- -1 * (fb22$prok8 - 5)

# Prokrastination
fb22$prok_ges <- fb22[, c('prok1', 'prok2_r', 'prok3_r',
                          'prok4', 'prok5_r', 'prok6',
                          'prok7_r', 'prok8_r', 'prok9', 
                          'prok10')] |> rowMeans()
# Naturverbundenheit
fb22$nr_ges <-  fb22[, c('nr1', 'nr2', 'nr3', 'nr4', 'nr5',  'nr6')] |> rowMeans()
fb22$nr_ges_z <- scale(fb22$nr_ges) # Standardisiert

# Weitere Standardisierugen
fb22$nerd_std <- scale(fb22$nerd)
fb22$neuro_std <- scale(fb22$neuro)


mean_IQ <- 100 #Mean Grundgesamtheit
sd_IQ <- 15 #SD der Grundgesamtheit
sample_size <- 75 #Stichprobengröße
se_IQ <- sd_IQ/sqrt(sample_size) #standard error (SE), also Standardfehler
new_mean_IQ <- 105 #Stichprobenmittelwert
new_sd_IQ <- 17 #SD der Stichprobe (Populationsschätzer)

z_IQ <- abs((new_mean_IQ-mean_IQ)/(sd_IQ/sqrt(sample_size))) #abs() berechnet den Betrag des Ergebnisses
z_IQ

z_IQ <- abs((new_mean_IQ-mean_IQ)/se_IQ)
z_IQ

z_krit <- qnorm(1-.05) #bei einer zweiseitigen Testung würden wir qnorm(1-(.05/2)) verwenden
z_krit

z_IQ > z_krit

p_z_IQ_oneside <- pnorm(z_IQ, lower.tail = FALSE)
p_z_IQ_oneside

p_z_IQ_twoside <- 2*pnorm(z_IQ, lower.tail = FALSE) #verdoppeln, da zweiseitig
p_z_IQ_twoside

z_quantil_zweiseitig <- qnorm(p = 1-(.05/2), mean = 0, sd = 1)
z_quantil_zweiseitig

positive_mean_IQ <- new_mean_IQ+((z_quantil_zweiseitig*sd_IQ)/sqrt(sample_size))
positive_mean_IQ

negative_mean_IQ <- new_mean_IQ-((z_quantil_zweiseitig*sd_IQ)/sqrt(sample_size))
negative_mean_IQ

conf_interval_IQ <- c(negative_mean_IQ, positive_mean_IQ )
conf_interval_IQ

z_quantil_einseitig <- qnorm(p = 1-.05, mean = 0, sd = 1)
z_quantil_einseitig

new_mean_IQ-((z_quantil_einseitig*sd_IQ)/sqrt(sample_size))

men_height <- c(183, 178, 175, 186, 185, 179, 181, 179, 182, 177)

qqnorm(men_height) 
qqline(men_height)

mean_men_height <- mean(men_height)
mean_men_height

sd_men_height <- sd(men_height)
sd_men_height

n_men_height <- length(men_height)
se_men_height <- sd_men_height/sqrt(n_men_height)

average_men_height <- 180

t_men_height <- abs((mean_men_height-average_men_height)/se_men_height)
t_men_height

krit_t_men_height <- qt(0.95, df=n_men_height-1) 
krit_t_men_height

t_men_height > krit_t_men_height

p_t_men_height <- pt(t_men_height, n_men_height-1, lower.tail = F) #einseitige Testung
p_t_men_height

height_test <- t.test(men_height, mu=180, alternative="greater") #alternative bestimmt, ob die Hypothese gerichtet ist oder nicht. Siehe hierzu ?t.test.

t.test(men_height, mu=180, alternative="greater") #alternative bestimmt, ob die Hypothese gerichtet ist oder nicht. Siehe hierzu ?t.test.

## install.packages('psych')          # installieren

library(psych)                     # laden

## ??psych                          # Hilfe

describe(fb22$neuro)

t.test(fb22$neuro, mu=3.3) #ungerichtet
t.test(fb22$neuro, mu=3.3, alternative="less") #gerichtet, Stichprobenmittelwert geringer
t.test(fb22$neuro, mu=3.3, alternative="greater") #gerichtet, Stichprobenmittelwert höher

t.test(fb22$neuro, mu=3.3, conf.level=0.99) #99%-iges Konfidenzintervall für die ungerichtete Hypothese
t.test(fb22$neuro, mu=3.3, alternative="less", conf.level=0.99) #99%-iges Konfidenzintervall für die gerichtete Hypothese (Stichprobenmittelwert geringer)
t.test(fb22$neuro, mu=3.3, alternative="greater", conf.level=0.99) #99%-iges Konfidenzintervall für die gerichtete Hypothese (Stichprobenmittelwert höher)

mean_Neuro <- mean(fb22$neuro) #Neurotizismuswert der Stichprobe
sd_Neuro <- sd(fb22$neuro, na.rm = T) #Stichproben SD (Populationsschätzer)
mean_Popu_Neuro <- 3.3 #Neurotizismuswert der Grundgesamtheit
d <- abs((mean_Neuro-mean_Popu_Neuro)/sd_Neuro) #abs(), da Betrag
d
