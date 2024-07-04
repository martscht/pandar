#demographische Daten:
geschlecht <- c(1, 2, 2, 1, 1, 1, 3, 2, 1, 2)   
alter <- c(20, 21, 19, 19, 20, 23, 22, 21, 19, 25)
stadt <- c(2, 1, 1, 4, 3, 2, 5, 4, 1, 3) 

#Lebenszufriedenheit:
lz_items <- data.frame(lz1 = c(3, 4, 4, 2, 1, 4, 3, 5, 4, 3), lz2 = c(2, 2, 3, 2, 4, 1, 2, 3, 2, 2), lz3 = c(5, 3, 4, 4, 3, 5, 2, 4, 3, 4), lz4 = c(2, 1, 3, 2, 2, 3, 2, 4, 2, 1), lz5 = c(4, 4, 3, 3, 1, 4, 3, 4, 5, 3)) 

class(geschlecht)
class(alter)
class(stadt)
dim(lz_items)

data <- data.frame(geschlecht, alter, stadt, lz_items)
dim(data)

data$geschlecht <- factor(data$geschlecht, levels = 1:3, labels = c("weiblich", "männlich", "divers"))
str(data$geschlecht)

data$stadt <- factor(data$stadt, levels = 1:5, labels = c("Berlin", "Hamburg", "München", "Frankfurt", "Dresden"))
str(data$stadt)

data[4, "stadt"]
data[c(7, 8), "geschlecht"]
data[c(2, 3), c(4:8)]

data[3, "lz2"] <- 2
data[3, "lz4"] <- 1

data[6, "alter"]

data[6, "alter"] <- 24

data$lz2 <- -1 * (data$lz2 - 6)
data$lz4 <- -1 * (data$lz4 - 6)

data[1, c("alter", "geschlecht")] == data[5, c("alter", "geschlecht")]
data[2, c("geschlecht", "stadt")] == data[10, c("geschlecht", "stadt")]

data[1, "alter"] == data[5,"alter"] & data[1, "geschlecht"] == data[5, "geschlecht"]
data[2, "geschlecht"] == data[10, "geschlecht"] & data[2,  "stadt"] == data[10, "stadt"]

farbe <- c(1, 2, 1, 1, 3, 4, 2, 2, 1, 4)  #1 = blau, 2 = rot, 3 = grün, 4 = schwarz

data$farbe <- farbe
data$farbe <- factor(data$farbe, levels = 1:4, labels = c("blau", "rot", "grün", "schwarz"))
str(data$farbe)

## c("weiblich", 21, "Frankfurt", 4, 4, 3, 4, 4, "blau")
## c("männlich", 19, "Dresden", 2, 5, 2, 4, 3, "schwarz")
## c("weiblich", 20, "Berlin", 1, 5, 1, 5, 1, "blau")

data[11, ] <- c("weiblich", 21, "Frankfurt", 4, 4, 3, 4, 4, "blau")
data[12, ] <- c("männlich", 19, "Dresden", 2, 5, 2, 4, 3, "schwarz")
data[13, ] <- c("weiblich", 20, "Berlin", 1, 5, 1, 5, 1, "blau")

str(data)

data$alter <- as.numeric(data$alter)
data$lz1 <- as.numeric(data$lz1)
data$lz2 <- as.numeric(data$lz2)
data$lz3 <- as.numeric(data$lz3)
data$lz4 <- as.numeric(data$lz4)
data$lz5 <- as.numeric(data$lz5)

data$lz_ges <- rowMeans(data[, 4:8])
data$lz_ges   

## getwd()
## setwd("...")
## save(data, file = "Data_lz.rda")

table(data$farbe)            # Häufigkeiten
which.max(table(data$farbe)) # Modus
max(table(data$farbe))       # Ausprägung

pie(table(data$geschlecht))

prop.table(table(data$geschlecht))

bruch <- -(1/log(5))
hj <- prop.table(table(data$stadt))
summe <- sum(hj * log(hj))
bruch * summe

median(data$lz3)
quantile(data$lz3, c(.25, .75))
boxplot(data$lz3)
quantile(data$lz3, .75) - quantile(data$lz3, .25)

mean(data$lz_ges)
#Varianz (beide Wege)
var(data$lz_ges) * (12 / 13)
sum((data$lz_ges - mean(data$lz_ges))^2) / 13

# rm(list = ls())
load(url('https://pandar.netlify.app/daten/fb22.rda'))

fb22$lerntyp <- factor(fb22$lerntyp, levels = 1:3, labels = c("alleine", "Gruppe", "Mischtyp"))

str(fb22$lerntyp)

# rm(list = ls())
source(url("https://pandar.netlify.app/daten/nature_zusatz_processing.R"))

nature$urban <- factor(nature$urban, levels = 1:3, labels = c("laendlich", "vorstaedtisch", "staedtisch"))

str(nature$urban)

colours <- c("#CFB1B3", "#BC7B7D", "#DAB457")  #HEX-Werte (Paletten auf Pinterest)
colours2 <- c("#B7C5D5", "#D6EDEC", "#E7E8ED")

table_lerntyp <- table(fb22$lerntyp)

barplot(table_lerntyp, main = "Lerntypen Jahrgang 2022", ylab = "Anzahl Studierende", col = colours)
barplot(table_lerntyp, main = "Lerntypen Jahrgang 2022", ylab = "Anzahl Studierende", col = colours2)

colours <- c("#CFB1B3", "#BC7B7D", "#DAB457")  #HEX-Werte (Paletten auf Pinterest)
colours2 <- c("#B7C5D5", "#D6EDEC", "#E7E8ED")

table_urban <- table(nature$urban)

barplot(table_urban, main = "Wohngegend als Kind", ylab = "Anzahl ProbandInnen", col = colours)
barplot(table_urban, main = "Wohngegend als Kind", ylab = "Anzahl ProbandInnen", col = colours2)

sum(is.na(fb22$prok4))
sum(is.na(fb22$prok10))

sum(is.na(nature$Q1))
sum(is.na(nature$Q5))

median(fb22$prok4, na.rm = T)
median(fb22$prok10)

quantile(fb22$prok4, c(.25, .75), na.rm = T)
quantile(fb22$prok10, c(.25, .75))

boxplot(fb22$prok4)
boxplot(fb22$prok10)

median(nature$Q1, na.rm = T)
median(nature$Q5)

quantile(nature$Q1, c(.25, .75), na.rm = T)
quantile(nature$Q5, c(.25, .75))

boxplot(nature$Q1)

boxplot(nature$Q5)

range(fb22$gewis)
mean(fb22$gewis)

range(nature$age)
mean(nature$age)

sum(is.na(fb22$gewis))
sum(is.na(fb22$extra))

mean(fb22$gewis)
mean(fb22$extra)

var(fb22$gewis) * (158/159)
var(fb22$extra) * (158/159)

# rm(list = ls())
source('/home/zarah/pandar.git/content/daten/SD3_zusatz_processing.R')
# source(url("https://pandar.netlify.app/daten/SD3_zusatz_processing.R"))

SD3$N2 <- -1 * (SD3$N2 - 6)
SD3$N6 <- -1 * (SD3$N6 - 6)
SD3$N8 <- -1 * (SD3$N8 - 6)

SD3$P2 <- -1 * (SD3$P2 - 6)
SD3$P7 <- -1 * (SD3$P7 - 6)

sum(is.na(SD3))

SD3$M_ges <- rowMeans(SD3[, 1:9])
SD3$N_ges <- rowMeans(SD3[, 10:18])  
SD3$P_ges <- rowMeans(SD3[, 19:27]) 

mean(SD3$M_ges)
mean(SD3$N_ges)

n <- nrow(SD3)
var(SD3$M_ges) * ((n-1)/n)
var(SD3$N_ges) * ((n-1)/n)

hist(fb22$vertr)

fb22$vertr_z <- scale(fb22$vertr, scale = F)
hist(fb22$vertr_z)

fb22$vertr_st <- scale(fb22$vertr, scale = T)
hist(fb22$vertr_st)

hist(SD3$P_ges)

SD3$P_z <- scale(SD3$P_ges, scale = F)
hist(SD3$P_z)

SD3$P_st <- scale(SD3$P_ges, scale = T)
hist(SD3$P_st)

fb22_alleine <- subset(fb22, subset = lerntyp == "alleine")
fb22_gruppe <- subset(fb22, subset = lerntyp == "Gruppe")

## fb22_alleine <- fb22[fb22$lerntyp == "alleine",]
## fb22_gruppe <- fb22[fb22$lerntyp == "Gruppe",]

mean(fb22_alleine$extra, na.rm = T)
mean(fb22_gruppe$extra, na.rm = T)

mean(fb22_alleine$nerd, na.rm = T)
mean(fb22_gruppe$nerd, na.rm = T)

nature_atheist <- subset(nature, subset = religion == 2)
nature_hindu <- subset(nature, subset = religion == 8)

## nature_atheist <- nature[nature$religion == 2,]
## nature_hindu <- nature[nature$religion == 8,]

mean(nature_atheist$Q_ges, na.rm = T)
mean(nature_hindu$Q_ges, na.rm = T)

dbinom(9, 15, 0.75)

1- pbinom(10, 15, 0.75)
#Alternativ:
pbinom(10, 15, 0.75, lower.tail = F)

X <- 0:15
wk <- pbinom(X, 15, 0.75)
plot(x = X, y = wk, typ = "h", xlab = "Anzahl Frauen", ylab = "kummulierte Wahrscheinlichkeit")

load(url('https://pandar.netlify.app/daten/fb22.rda'))
is.factor(fb22$geschl)
fb22$geschl <- factor(fb22$geschl,
                      levels = 1:3, 
                      labels = c("weiblich", "männlich", "anderes"))

fb22_frauen <- subset(fb22, geschl == "weiblich")

t.test(fb22_frauen$gewis, mu = 3.73, alternative = "greater", conf.level = .99)

t.test1 <- t.test(fb22_frauen$gewis, mu = 3.73, alternative = "greater", conf.level = .99)
conf.int1 <- t.test1$conf.int

mean_gewis_frauen <- mean(fb22_frauen$gewis, na.rm = T)
sd_gewis_frauen <- sd(fb22_frauen$gewis, na.rm = T)
mean_gewis_population <- 3.73
d <- abs((mean_gewis_frauen - mean_gewis_population)/sd_gewis_frauen)

is.factor(fb22$lerntyp)
fb22$lerntyp <- factor(fb22$lerntyp, 
                       levels = 1:3, 
                       labels = c("alleine", "Gruppe", "Mischtyp"))

fb22$lerntyp_neu <- fb22$lerntyp == "alleine"
fb22$lerntyp_neu <- as.numeric(fb22$lerntyp_neu) #Umwandlung in Numeric, da der Variablen Typ nun Logical ist
fb22$lerntyp_neu <- factor(fb22$lerntyp_neu, 
                           levels = 0:1, 
                           labels = c("Gruppe oder Mischtyp", "alleine"))

boxplot(fb22$extra ~ fb22$lerntyp_neu, xlab = "Lerntyp", ylab = "Extraversion") 

library(car)
qqPlot(fb22$extra[fb22$lerntyp_neu == "alleine"])
qqPlot(fb22$extra[fb22$lerntyp_neu == "Gruppe oder Mischtyp"])

shapiro.test(fb22$extra[fb22$lerntyp_neu == "alleine"])
shapiro.test(fb22$extra[fb22$lerntyp_neu == "Gruppe oder Mischtyp"])

leveneTest(fb22$extra ~ fb22$lerntyp_neu)

t.test(fb22$extra ~ fb22$lerntyp_neu, var.equal = T)

# load(url('https://pandar.netlify.app/daten/zusatz.rda'))
load('/home/zarah/pandar.git/content/daten/zusatz.rda')

is.factor(zusatz$diet)
zusatz$diet <- factor(zusatz$diet, 
                       levels = 1:3, 
                       labels = c("nicht-vegetarisch", "vegetarisch", "vegan"))

zusatz$diet_neu <- zusatz$diet == "nicht-vegetarisch"
zusatz$diet_neu <- as.numeric(zusatz$diet_neu) #Umwandlung in Numeric, da der Variablen Typ nun Logical ist
zusatz$diet_neu <- factor(zusatz$diet_neu, 
                           levels = 0:1, 
                           labels = c("vegetarisch oder vegan", "nicht-vegetarisch"))

boxplot(zusatz$happiness ~ zusatz$diet_neu, xlab = "Diet", ylab = "Happiness") 

library(car)
qqPlot(zusatz$happiness[zusatz$diet_neu == "nicht-vegetarisch"])
qqPlot(zusatz$happiness[zusatz$diet_neu == "vegetarisch oder vegan"])

shapiro.test(zusatz$happiness[zusatz$diet_neu == "nicht-vegetarisch"])
shapiro.test(zusatz$happiness[zusatz$diet_neu == "vegetarisch oder vegan"])

leveneTest(zusatz$happiness ~ zusatz$diet_neu)

t.test(zusatz$happiness ~ zusatz$diet_neu, var.equal = T)

is.factor(fb22$wohnen)
is.factor(fb22$job)

fb22$wohnen <- factor(fb22$wohnen, levels = 1:4, labels = c("WG", "bei Eltern", "alleine", "sonstiges"))
fb22$job <- factor(fb22$job, levels = 1:2, labels = c("nein", "ja"))

fb22$wohnen_bei_Eltern <- fb22$wohnen == "bei Eltern" #wir erstellen eine Variable, die angibt, ob eine Personen bei den Eltern wohnt oder nicht

tab <- table(fb22$wohnen_bei_Eltern, fb22$job)
tab


tab_mar <- addmargins(tab)
tab_mar


n <- tab_mar[3,3]

erwartet_11 <- (tab_mar[1,3]*tab_mar[3,1])/n
erwartet_12 <- (tab_mar[1,3]*tab_mar[3,2])/n
erwartet_21 <- (tab_mar[2,3]*tab_mar[3,1])/n
erwartet_22 <- (tab_mar[2,3]*tab_mar[3,2])/n

erwartet <- data.frame(nein = c(erwartet_11, erwartet_21), ja = c(erwartet_12, erwartet_22))
erwartet


chi_quadrat_Wert <- (tab[1,1]-erwartet[1,1])^2/erwartet[1,1]+
  (tab[1,2]-erwartet[1,2])^2/erwartet[1,2]+
  (tab[2,1]-erwartet[2,1])^2/erwartet[2,1]+
  (tab[2,2]-erwartet[2,2])^2/erwartet[2,2]

chi_quadrat_Wert

pchisq(chi_quadrat_Wert, 1, lower.tail = F) #Freiheitsgrad beträgt 1

chisq.test(tab, correct = F)

is.factor(zusatz$living)
is.factor(zusatz$pet)

zusatz$living <- factor(zusatz$living, levels = 1:2, labels = c("nicht-alleine", "alleine"))
zusatz$pet <- factor(zusatz$pet, levels = 1:4, labels = c("keins", "Katze", "Hund", "anderes"))

zusatz$pet_owner <- zusatz$pet %in% c("Katze", "Hund", "anderes")  #wir erstellen eine Variable, die angibt, ob eine Personen bei den Eltern wohnt oder nicht

tab <- table(zusatz$pet_owner, zusatz$living)
tab

tab_mar <- addmargins(tab)
tab_mar

n <- tab_mar[3,3]

erwartet_11 <- (tab_mar[1,3]*tab_mar[3,1])/n
erwartet_12 <- (tab_mar[1,3]*tab_mar[3,2])/n
erwartet_21 <- (tab_mar[2,3]*tab_mar[3,1])/n
erwartet_22 <- (tab_mar[2,3]*tab_mar[3,2])/n

erwartet <- data.frame(nein = c(erwartet_11, erwartet_21), ja = c(erwartet_12, erwartet_22))
erwartet


chi_quadrat_Wert <- (tab[1,1]-erwartet[1,1])^2/erwartet[1,1]+
  (tab[1,2]-erwartet[1,2])^2/erwartet[1,2]+
  (tab[2,1]-erwartet[2,1])^2/erwartet[2,1]+
  (tab[2,2]-erwartet[2,2])^2/erwartet[2,2]

chi_quadrat_Wert

pchisq(chi_quadrat_Wert, 1, lower.tail = F) #Freiheitsgrad beträgt 1

chisq.test(tab, correct = F)

#Wir überprüfen erst wieder, ob die Variable Nebenjob als Faktor vorliegt
is.factor(fb22$job)

library(car)
qqPlot(fb22$intel[fb22$job == "nein"])
qqPlot(fb22$intel[fb22$job == "ja"])
shapiro.test(fb22$intel[fb22$job == "nein"])
shapiro.test(fb22$intel[fb22$job == "ja"])

hist(fb22$intel[fb22$job == "ja"])
hist(fb22$intel[fb22$job == "nein"])

leveneTest(fb22$intel ~ fb22$job)

wilcox.test(fb22$lz ~ fb22$ort)

#Wir überprüfen erst wieder, ob die Variable Nebenjob als Faktor vorliegt
is.factor(zusatz$school)

zusatz$school <- factor(zusatz$school, levels = 1:2, labels = c("öffentlich", "privat"))

library(car)
qqPlot(zusatz$intel[zusatz$school == "privat"])
qqPlot(zusatz$intel[zusatz$school == "öffentlich"])
shapiro.test(zusatz$intel[zusatz$school == "privat"])
shapiro.test(zusatz$intel[zusatz$school == "öffentlich"])

hist(zusatz$intel[zusatz$school == "privat"])
hist(zusatz$intel[zusatz$school == "öffentlich"])

leveneTest(zusatz$intel ~ zusatz$school)

wilcox.test(zusatz$intel ~ zusatz$school)

#Wir überprüfen erst wieder, ob die Variable Nebenjob als Faktor vorliegt
is.factor(zusatz$school)

# zusatz$school <- factor(zusatz$school, levels = 1:2, labels = c("öffentlich", "privat"))

library(car)
qqPlot(zusatz$intel[zusatz$school == "privat"])
qqPlot(zusatz$intel[zusatz$school == "öffentlich"])
shapiro.test(zusatz$intel[zusatz$school == "privat"])
shapiro.test(zusatz$intel[zusatz$school == "öffentlich"])

hist(zusatz$intel[zusatz$school == "privat"])
hist(zusatz$intel[zusatz$school == "öffentlich"])

leveneTest(zusatz$intel ~ zusatz$school)

wilcox.test(zusatz$intel ~ zusatz$school)

t.test(fb22$nerd, fb22$intel, paired = T)


library("effsize")
cohen.d(fb22$nerd, fb22$intel, paired = T, within = F)

t.test(SD3$M_ges, SD3$N_ges, paired = T)

library("effsize")
cohen.d(SD3$M_ges, SD3$N_ges, paired = T, within = F)

library(stringr) #falls noch nicht installiert: install.packages("stringr")
str_count("Wie viele Wörter hat dieser Satz?", "\\w+")

fb22$woerter_grund <- str_count(fb22$grund, "\\w+")

plot(x = fb22$woerter_grund, y = fb22$gewis)

library(car)
qqPlot(fb22$gewis)
qqPlot(fb22$woerter_grund)

cor.test(fb22$woerter_grund, fb22$gewis, method = "spearman", alternative = "greater")

plot(x = zusatz$caffeine, y = zusatz$stress)

library(car)
qqPlot(zusatz$caffeine)
qqPlot(zusatz$stress)

shapiro.test(zusatz$caffeine)
shapiro.test(zusatz$stress)

cor.test(zusatz$caffeine, zusatz$stress, method = "spearman", alternative = "greater")

fb22$prok2_r <- -1 * (fb22$prok2 - 5)
fb22$prok3_r <- -1 * (fb22$prok3 - 5)
fb22$prok5_r <- -1 * (fb22$prok5 - 5)
fb22$prok7_r <- -1 * (fb22$prok7 - 5)
fb22$prok8_r <- -1 * (fb22$prok8 - 5)

fb22$prok_ges <- fb22[, c('prok1', 'prok2_r', 'prok3_r',
                          'prok4', 'prok5_r', 'prok6',
                          'prok7_r', 'prok8_r', 'prok9', 
                          'prok10')] |> rowMeans()

plot(fb22$gewis, fb22$prok_ges, xlab = "Gewissenhaftigkeit", ylab = "Prokrastination", 
     main = "Zusammenhang zwischen Gewissenhaftigkeit und Prokrastination", pch = 19)
lines(loess.smooth(fb22$gewis, fb22$prok_ges), col = 'blue')

fm <- lm(prok_ges ~ 1 + gewis, data = fb22)

par(mfrow = c(2, 2)) #vier Abbildungen gleichzeitig
plot(fm)

fm

confint(fm, level = .99)

summary(fm)
summary(fm)$r.squared

fm$coefficients[1] + 3.2*fm$coefficients[2]

#Alternativ:
predict(fm, newdata = data.frame(gewis = 3.2))

plot(zusatz$selfesteem, zusatz$empathy, xlab = "Selbstwertgefühl", ylab = "Empathie", 
     main = "Zusammenhang zwischen Selbstwertgefühl und Empathie", pch = 19)
lines(loess.smooth(zusatz$selfesteem, zusatz$empathy), col = 'blue')

fm <- lm(empathy ~ 1 + selfesteem, data = zusatz)

par(mfrow = c(2, 2)) #vier Abbildungen gleichzeitig
plot(fm)

fm

confint(fm, level = .99)

summary(fm)
summary(fm)$r.squared

fm$coefficients[1] + 3.2*fm$coefficients[2]

#Alternativ:
predict(fm, newdata = data.frame(selfesteem = 3.2))

d <- -0.56 #Effektstärke
N <- 159 #Anzahl der Teilnehmenden von fb22
set.seed(4321)
tH1 <- replicate(n = 10^4, expr = {X <- rnorm(159) 
                                   Y <- rnorm(159) + d #Normalverteilte Stichproben mit Mittelwertsunterschied von d Standardabweichungen
                                   ttestH1 <- t.test(X, Y, var.equal = TRUE, paired = T) #Paired = T, da es sich um einen t-Test für abhängige Stichproben handelt
                                   ttestH1$p.value})
mean(tH1 < .05 )

1 - mean(tH1 < .05 )

set.seed(4321)
tH1 <- replicate(n = 10^4, expr = {X <- rnorm(N) 
                                   Y <- rnorm(N) + d 
                                   ttestH1 <- t.test(X, Y, var.equal = TRUE, paired = T)
                                   ttestH1$statistic})
power <- c(mean(abs(tH1) > qt(p = 1- 0.001/2, df = N)), mean(abs(tH1) > qt(p = 1- 0.01/2, df = N)), mean(abs(tH1) > qt(p = 1- 0.025/2, df = N)), mean(abs(tH1) > qt(p = 1- 0.05/2, df = N)), mean(abs(tH1) > qt(p = 1- 0.1/2, df = N)))

x <- c(.001, 0.01, 0.025, 0.05, 0.1)
plot(x = x, y = power, type = "b", main = "Power vs. Alpha")

d <- cohen.d(SD3$M_ges, SD3$N_ges, paired = T, within = F)$estimate #Effektstärke
N <- nrow(SD3) #Anzahl der Teilnehmenden von SD3
set.seed(4321)
tH1 <- replicate(n = 10^4, expr = {X <- rnorm(N) 
                                   Y <- rnorm(N) + d #Normalverteilte Stichproben mit Mittelwertsunterschied von d Standardabweichungen
                                   ttestH1 <- t.test(X, Y, var.equal = TRUE, paired = T) #Paired = T, da es sich um einen t-Test für abhängige Stichproben handelt
                                   ttestH1$p.value})
mean(tH1 < .05 )

1 - mean(tH1 < .05 )

set.seed(4321)
tH1 <- replicate(n = 10^4, expr = {X <- rnorm(N) 
                                   Y <- rnorm(N) + d 
                                   ttestH1 <- t.test(X, Y, var.equal = TRUE, paired = T)
                                   ttestH1$statistic})
power <- c(mean(abs(tH1) > qt(p = 1- 0.001/2,  df  = N)), mean(abs(tH1) > qt(p = 1- 0.01/2, df = N)), mean(abs(tH1) > qt(p = 1- 0.025/2, df = N)), mean(abs(tH1) > qt(p = 1- 0.05/2, df = N)), mean(abs(tH1) > qt(p = 1- 0.1/2, df = N)))

x <- c(.001, 0.01, 0.025, 0.05, 0.1)
plot(x = x, y = power, type = "b", main = "Power vs. Alpha")
