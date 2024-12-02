knitr::opts_chunk$set(error = TRUE)
library(psych)
library(car)
library(effsize)

load(url('https://pandar.netlify.app/daten/fb24.rda')) 


is.factor(fb24$fach)
is.factor(fb24$ort)
is.factor(fb24$job)
is.factor(fb24$wohnen)

# Lieblingsfach als Faktor - falls es noch keiner war
fb24$fach <- factor(fb24$fach, 
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung',
                               'Klinische', 'Diag./Meth.'))

# Wohnort als Faktor - falls es noch keiner war
fb24$ort <- factor(fb24$ort, 
                   levels = c(1, 2),
                   labels = c('Frankfurt', 'anderer'))


# Job als Faktor - falls es noch keiner war
fb24$job <- factor(fb24$job, 
                      levels=c(1,2), 
                      labels=c('Job', 'kein Job'))

#Wohnsituation als Faktor - falls es noch keiner war
fb24$wohnen <- factor(fb24$wohnen,
                      levels = 1:4,
                      labels = c("in einer Wohngemeinschaft", "bei den Eltern", "alleine", "sonstiges"))


data1 <- fb24[ (which(fb24$fach=="Allgemeine"|fb24$fach=="Klinische")), ]
data1$fach <- droplevels(data1$fach)
boxplot(data1$offen ~ data1$fach,
        xlab="Interessenfach", ylab="Offenheit für neue Erfahrungen", 
        las=1, cex.lab=1.5, 
        main="Interessenfach und Offenheit")

# Überblick

library(psych)
describeBy(data1$offen, data1$fach)


# Berechnung der empirischen Standardabweichung, da die Funktion describeBy() nur Populationsschätzer für Varianz und Standardabweichung berichtet

offen.A <- data1$offen[(data1$fach=="Allgemeine")]
sigma.A <- sd(offen.A)
n.A <- length(offen.A[!is.na(offen.A)])
sd.A <- sigma.A * sqrt((n.A-1) / n.A)
sd.A 

offen.B <- data1$offen[(data1$fach=="Klinische")]
sigma.B <- sd(offen.B)
n.B <- length(offen.B[!is.na(offen.B)])
sd.B <- sigma.B * sqrt((n.B-1) / n.B)
sd.B

library(car)
leveneTest(data1$offen ~ data1$fach)
levene <- leveneTest(data1$offen ~ data1$fach)
f <- round(levene$`F value`[1], 2)
p <- round(levene$`Pr(>F)`[1], 3)

t.test(data1$offen ~ data1$fach,           # abhängige Variable ~ unabhängige Variable
       #paired = F,                   # Stichproben sind unabhängig 
       alternative = "two.sided",         # zweiseitige Testung
       var.equal = T,                # Varianzhomogenität ist gegeben (-> Levene-Test)
       conf.level = .95)             # alpha = .05 

ttest <- t.test(data1$offen ~ data1$fach, alternative = "two.sided", var.equal = T, conf.level = .95) 

boxplot(fb24$lz ~ fb24$ort,
        xlab="Wohnort", ylab="Lebenszufriedenheit", 
        las=1, cex.lab=1.5, 
        main="Wohnort und Lebenszufriedenheit")

library(psych)
describeBy(fb24$lz, fb24$ort)
summary(fb24[which(fb24$ort=="Frankfurt"), "lz"])
summary(fb24[which(fb24$ort=="anderer"), "lz"])

deskr <- describeBy(fb24$lz, fb24$ort)
fra <- summary(fb24[which(fb24$ort=="Frankfurt"), "lz"])
and <- summary(fb24[which(fb24$ort=="anderer"), "lz"])

par(mfrow=c(1,2))
lz.F <- fb24[which(fb24$ort=="Frankfurt"), "lz"]
hist(lz.F, xlim=c(1,9), ylim=c(0,0.5), main="Lebenzufriedenheit\n(Frankfurter)", xlab="", ylab="", las=1, prob=T)
curve(dnorm(x, mean=mean(lz.F, na.rm=T), sd=sd(lz.F, na.rm=T)), col="red", lwd=2, add=T)
qqnorm(lz.F)
qqline(lz.F, col="red")

par(mfrow=c(1,2))
lz.a <- fb24[which(fb24$ort=="anderer"), "lz"]
hist(lz.a, xlim=c(1,9), main="Lebenszufriedenheit\n(Nicht-Frankfurter)", xlab="", ylab="", las=1, prob=T)
curve(dnorm(x, mean=mean(lz.a, na.rm=T), sd=sd(lz.a, na.rm=T)), col="red", lwd=2, add=T)
qqnorm(lz.a)
qqline(lz.a, col="red")

wilcox.test(fb24$lz ~ fb24$ort,           # abhängige Variable ~ unabhängige Variable
       #paired = F,                   # Stichproben sind unabhängig (Default)
       alternative = "less",         # einseitige Testung: Gruppe1 (Frankfurter:innen) < Gruppe2 (Nicht-Frankfurter:innen) 
       conf.level = .95)             # alpha = .05 

wilcox <- wilcox.test(fb24$lz ~ fb24$ort, alternative = "less",  conf.level = .95)

wohnsituation <- fb24[(which(fb24$wohnen=="in einer Wohngemeinschaft"|fb24$wohnen=="bei den Eltern")),] # Neuer Datensatz der nur Personen beinhaltet, die entweder bei den Eltern oder in einer WG wohnen
levels(wohnsituation$wohnen)
wohnsituation$wohnen <- droplevels(wohnsituation$wohnen) 
# Levels "alleine" und "sonstiges" wurden eliminiert
levels(wohnsituation$wohnen)

tab <- table(wohnsituation$wohnen, wohnsituation$job)
tab

chisq.test(tab, correct=FALSE)

chi2 <- chisq.test(tab, correct=FALSE)


library(psych)
phi(tab)
