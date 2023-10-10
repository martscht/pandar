#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/post/fb22.rda'))  

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

fb22$ort <- factor(fb22$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb22$job <- factor(fb22$job, levels=c(1,2), labels=c("nein", "ja"))
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

# Weitere Standardisierungen
fb22$nerd_std <- scale(fb22$nerd)
fb22$neuro_std <- scale(fb22$neuro)


# Je ein Histogramm pro Skala, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert
par(mfrow=c(2,1), mar=c(3,3,2,0))
hist(fb22$neuro, 
     xlim=c(1,5),
     ylim = c(0,50),
     main="Neurotizismus", 
     xlab="", 
     ylab="", 
     las=1)
abline(v=mean(fb22$neuro), 
       lty=2, 
       lwd=2)

hist(fb22$extra, 
     xlim=c(1,5),
     ylim = c(0,50),
     main="Extraversion", 
     xlab="", 
     ylab="", 
     las=1)
abline(v=mean(fb22$extra), 
       lty=2, 
       lwd=2)
par(mfrow=c(1,1)) #Zurücksetzen des Plotfensters, zuvor hatten wir "dev.off()" kennengelernt

summary(fb22$neuro)
summary(fb22$extra)
#alternativ
library(psych)
describe(fb22$neuro)
describe(fb22$extra)
desctip_neuro <- describe(fb22$neuro)
desctip_extra <- describe(fb22$extra)

difference <- fb22$neuro-fb22$extra
hist(difference, 
     xlim=c(-3,3), 
     ylim = c(0,1),
     main="Verteilung der Differenzen", 
     xlab="Differenzen", 
     ylab="", 
     las=1,
     probability = T)
curve(dnorm(x, mean=mean(difference), sd=sd(difference)), 
      col="blue", 
      lwd=2, 
      add=T)
qqnorm(difference)
qqline(difference, col="blue")

t.test(x = fb22$extra, y = fb22$neuro, # die beiden abhaengigen Variablen
      paired = T,                      # Stichproben sind abhaengig
      conf.level = .95)   


ttest <- t.test(x = fb22$neuro, y = fb22$extra,
       paired = T, conf.level = .95)

mean_d <- mean(difference)
sd.d.est <- sd(difference)
d_Wert <- mean_d/sd.d.est
d_Wert

#alternativ:
#install.packages("effsize")
library("effsize")

d2 <- cohen.d(fb22$neuro, fb22$extra, 
      paired = T,  #paired steht fuer 'abhaengig'
      within = F)   #wir brauchen nicht die Varianz innerhalb
d2

# Datensatz generieren
dataKooperation <- data.frame(Paar = 1:10,  Juenger = c(0.49,0.25,0.51,0.55,0.35,0.54,0.24,0.49,0.38,0.50), Aelter = c(0.4,0.25,0.31,0.44,0.25,0.33,0.26,0.38,0.23,0.35))
dataKooperation # überprüfen, ob alles geklappt hat

# Je ein Histogramm pro Gruppe, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert
par(mfrow=c(2,1), mar=c(3,3,2,0))
hist(dataKooperation[, "Juenger"], 
     xlim=c(0,1), 
     main="Kooperationsbereitschaft jüngeres Geschwisterteil", 
     xlab="", 
     ylab="", 
     las=1)
abline(v=mean(dataKooperation[, "Juenger"]), 
       lty=2, 
       lwd=2)

hist(dataKooperation[, "Aelter"], 
     xlim=c(0,1), 
     main="Kooperationsbereitschaft älteres Geschwisterteil", 
     xlab="", 
     ylab="", 
     las=1)
abline(v=mean(dataKooperation[, "Aelter"]), 
       lty=2, 
       lwd=2)

par(mfrow=c(1,1)) #Zurücksetzen des Plotfensters

summary(dataKooperation[, "Juenger"])
summary(dataKooperation[, "Aelter"])
#alternativ
library(psych)
describe(dataKooperation[, "Juenger"])
describe(dataKooperation[, "Aelter"])
jung <- describe(dataKooperation[, "Juenger"])
alt <- describe(dataKooperation[, "Aelter"])

difference <- dataKooperation[, "Juenger"]-dataKooperation[, "Aelter"]
hist(difference, 
     xlim=c(-.3,.3), 
     ylim = c(0,5.5),
     main="Verteilung der Differenzen", 
     xlab="Differenzen", 
     ylab="", 
     las=1)
curve(dnorm(x, mean=mean(difference), sd=sd(difference)), 
      col="blue", 
      lwd=2, 
      add=T)
qqnorm(difference)
qqline(difference, col="blue")

wilcox.test(x = dataKooperation[, "Juenger"], 
            y  = dataKooperation[, "Aelter"], # die beiden abhängigen Gruppen
            paired = T,      # Stichproben sind abhängig
            alternative = "greater", # gerichtete Hypothese
            conf.level = .95)                 # alpha = .05

wilcox <- wilcox.test(x = dataKooperation[, "Juenger"], y  = dataKooperation[, "Aelter"], paired = T, alternative = "greater", conf.level = .95)
