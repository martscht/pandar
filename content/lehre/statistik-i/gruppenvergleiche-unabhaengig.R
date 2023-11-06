knitr::opts_chunk$set(error = TRUE,warning = FALSE, message = FALSE)
library(knitr)

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


is.factor(fb22$geschl)

is.factor(fb22$geschl_faktor)

levels(fb22$geschl_faktor)

table(fb22$geschl_faktor)

# nur Männer und Frauen auswählen:
dataB <- fb22[ (fb22$geschl_faktor=="männlich"|fb22$geschl_faktor=="weiblich"), ]  
dataB$geschl_faktor <- droplevels(dataB$geschl_faktor) # levels aus den Datensatz entfernen, die keine Erhebungen haben

# Gruppierter Boxplot :
boxplot(dataB$nerd ~ dataB$geschl_faktor, 
        xlab="Geschlecht", ylab="Nerdiness", 
        las=1, cex.lab=1.5, 
        main="Nerdiness je nach Geschlecht")

# Je ein Histogramm pro Gruppe, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert
par(mfrow=c(2,1), mar=c(3,2,2,0))
hist(dataB[(dataB$geschl_faktor=="weiblich"), "nerd"], main="Testwert (weiblich)", 
     xlim=c(0,6), xlab="", ylab="", las=1)
abline(v=mean(dataB[(dataB$geschl_faktor=="weiblich"), "nerd"], na.rm=T), col="aquamarine3", lwd=3)
hist(dataB[(dataB$geschl_faktor=="männlich"), "nerd"], main="Testwert (männlich)", 
     xlim=c(0,6), xlab="", ylab="", las=1)
abline(v=mean(dataB[(dataB$geschl_faktor=="männlich"), "nerd"], na.rm=T), col="darksalmon", lwd=3)

dev.off()

# umständlich:
summary(dataB$nerd[(dataB$geschl_faktor=="weiblich")])  # Gruppe 1: Studentinnen
summary(dataB$nerd[(dataB$geschl_faktor=="männlich")]) # Gruppe 2: Studenten

# komfortabler:
library(psych)
describeBy(x = dataB$nerd, group = dataB$geschl_faktor)        # beide Gruppen im Vergleich 

nerd_weiblich <- dataB$nerd[(dataB$geschl_faktor=="weiblich")]
sigma_weiblich <- sd(nerd_weiblich, na.rm = T)
n_weiblich <- length(nerd_weiblich[!is.na(nerd_weiblich)])
sd_weiblich <- sigma_weiblich * sqrt((n_weiblich-1) / n_weiblich)
sd_weiblich

nerd_männlich <- dataB$nerd[(dataB$geschl_faktor=="männlich")]
sigma_männlich <- sd(nerd_männlich, na.rm = T)
n_männlich <- length(nerd_männlich[!is.na(nerd_männlich)])
sd_männlich <- sigma_männlich * sqrt((n_männlich-1) / n_männlich)
sd_männlich

# Gruppe 1 (weiblich) 
par(mfrow=c(1,2))
nerd_weiblich <- dataB[(dataB$geschl_faktor=="weiblich"), "nerd"]
hist(nerd_weiblich, xlim=c(0,6), ylim=c(0,.8), main="Nerdiness Testwert (weiblich)", xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, mean=mean(nerd_weiblich, na.rm=T), sd=sd(nerd_weiblich, na.rm=T)), col="blue", lwd=2, add=T)
qqnorm(nerd_weiblich)
qqline(nerd_weiblich, col="blue")

# Gruppe 2 (männlich)
par(mfrow=c(1,2))
nerd_männlich <- dataB[(dataB$geschl_faktor=="männlich"), "nerd"]
hist(nerd_männlich, xlim=c(0,6), ylim=c(0,.8), main="Nerdiness Testwert (männlich)", xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, mean=mean(nerd_männlich, na.rm=T), sd=sd(nerd_männlich, na.rm=T)), col="blue", lwd=2, add=T)
qqnorm(nerd_männlich)
qqline(nerd_männlich, col="blue")

dev.off()

library(car)
leveneTest(dataB$nerd ~ dataB$geschl_faktor)

levene <- leveneTest(dataB$nerd ~ dataB$geschl_faktor)
f <- round(levene$`F value`[1], 2)
p <- round(levene$`Pr(>F)`[1], 3)

t.test(dataB$nerd ~ dataB$geschl_faktor,       # abhängige Variable ~ unabhängige Variable
      paired = FALSE,                   # Stichproben sind unabhängig 
      alternative = "two.sided",        # zweiseitige Testung (Default)
      var.equal = TRUE,                 # Homoskedastizität liegt vor (-> Levene-Test)
      conf.level = .95)                 # alpha = .05 (Default)

ttest <- t.test(dataB$nerd ~ dataB$geschl_faktor, paired = FALSE, alternative = "two.sided", var.equal = TRUE, conf.level = .95)

nerd_weiblich <- dataB[(dataB$geschl_faktor=="weiblich"), "nerd"]
mw_weiblich <- mean(nerd_weiblich, na.rm=T)
n_weiblich <- length(nerd_weiblich[!is.na(nerd_weiblich)])
sigma_qu_weiblich <- var(nerd_weiblich, na.rm=T) 

nerd_männlich <- dataB[(dataB$geschl_faktor=="männlich"), "nerd"]
mw_männlich <- mean(nerd_männlich, na.rm=T)
n_männlich <- length(nerd_männlich[!is.na(nerd_männlich)])
sigma_qu_männlich <- var(nerd_männlich, na.rm=T) 

sigma_inn <- sqrt((sigma_qu_weiblich* (n_weiblich - 1) + sigma_qu_männlich* (n_männlich - 1)) / (n_weiblich-1 + n_männlich-1))

d1 <- (mw_weiblich - mw_männlich) / sigma_inn
d1

#alternativ:
#install.packages("effsize")
library("effsize")

d2 <- cohen.d(dataB$nerd, dataB$geschl_faktor, na.rm=T)
d2

# Gruppierter Boxplot:
boxplot(dataB$nr2 ~ dataB$geschl_faktor, 
        xlab="Geschlecht", ylab="nr2", 
        las=1, cex.lab=1.5, 
        main="nr2 nach Geschlecht")

describeBy(dataB$nr2, dataB$geschl_faktor) # beide Gruppen im Vergleich

# Interquartilsbereich (IBQ) über summary()
summary( dataB[(dataB$geschl_faktor=="weiblich"), "nr2"])
summary( dataB[(dataB$geschl_faktor=="männlich"), "nr2"]) 

deskr <- describeBy(dataB$nr2, dataB$geschl_faktor)

# Interquartilsbereich (IBQ) über summary()
weibl <- summary( dataB[(dataB$geschl_faktor=="weiblich"), "nr2"])
maennl <- summary( dataB[(dataB$geschl_faktor=="männlich"), "nr2"]) 

#Gruppe 1 (weiblich) 
par(mfrow=c(1,2))

nr2_w <- dataB[(dataB$geschl_faktor=="weiblich"), "nr2"]
hist(nr2_w, xlim=c(0,6), ylim=c(0,.6), main="Item nr2 (weiblich)", xlab="", ylab="", las=1, probability=T, breaks = c(.5:5.5))

nr2_m <- dataB[(dataB$geschl_faktor=="männlich"), "nr2"]
hist(nr2_m, xlim=c(0,6), ylim=c(0,.6), main="Item nr2 (männlich)", xlab="", ylab="", las=1, probability=T, breaks = c(.5:5.5))


library(car)
leveneTest(dataB$nr2 ~ dataB$geschl_faktor)

levene2 <- leveneTest(dataB$nr2 ~ dataB$geschl_faktor)
f2 <- round(levene2$`F value`[1], 2)
p2 <- round(levene2$`Pr(>F)`[1], 3)

levels(dataB$geschl_faktor) # wichtig zu wissen: die erste der beiden Faktorstufen ist "weiblich" 

wilcox.test(dataB$nr2 ~ dataB$geschl_faktor,     # abhängige Variable ~ unabhängige Variable
            paired = FALSE,               # Stichproben sind unabhängig
            alternative = "greater",      # einseitige Testung, und zwar so, dass Gruppe1(w)-Gruppe2(m) > 0
            conf.level = .95)             # alpha = .05


wilcox <- wilcox.test(dataB$nr2 ~ dataB$geschl_faktor, paired = FALSE, alternative = "greater", conf.level = .95)

is.factor(fb22$ort)
is.factor(fb22$job)

# Achtung, nur einmal durchführen (ansonsten Datensatz neu einladen und Code erneut durchlaufen lassen!)
fb22$ort <- factor(fb22$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb22$job <- factor(fb22$job, levels=c(1,2), labels=c("nein", "ja"))


tab <- table(fb22$ort, fb22$job)
tab

tab_mar <- addmargins(tab) # Randsummen zu Tabelle hinzufügen
tab_mar

expected <- data.frame(nein=c((tab_mar[1,3]*tab_mar[3,1])/tab_mar[3,3],
                              (tab_mar[2,3]*tab_mar[3,1])/tab_mar[3,3]),
                       ja=c((tab_mar[1,3]*tab_mar[3,2])/tab_mar[3,3],
                            (tab_mar[2,3]*tab_mar[3,2])/tab_mar[3,3]))
expected

chi_quadrat_Wert <- (tab[1,1]-expected[1,1])^2/expected[1,1]+
                    (tab[1,2]-expected[1,2])^2/expected[1,2]+
                    (tab[2,1]-expected[2,1])^2/expected[2,1]+
                    (tab[2,2]-expected[2,2])^2/expected[2,2]
chi_quadrat_Wert

qchisq(.95, 1) # kritischer Wert
pchisq(chi_quadrat_Wert, 1, lower.tail = FALSE) # p-Wert

chisq.test(tab,        # Kreuztabelle
           correct=F)  # keine Kontinuinitätskorrektur nach Yates

effekt_YulesQ <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
                 (tab[1,1]*tab[2,2]+tab[1,2]*tab[2,1])
effekt_YulesQ

effekt_phi <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
  sqrt((tab[1,1]+tab[1,2])*(tab[1,1]+tab[2,1])*(tab[1,2]+tab[2,2])*(tab[2,1]+tab[2,2]))
effekt_phi

# alternativ mit psych Paket
library(psych)
phi(tab, digits = 8)
Yule(tab)

# Äquivalentes Ergebnis mittels Pearson-Korrelation (kommt in den nächsten Sitzungen)
# (dichotome Variablen)
ort_num <- as.numeric(fb22$ort)
job_num <- as.numeric(fb22$job)
cor(ort_num, job_num, use="pairwise")
