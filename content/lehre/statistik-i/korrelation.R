#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb23.rda')) 

# Nominalskalierte Variablen in Faktoren verwandeln

fb23$fach <- factor(fb23$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb23$ziel <- factor(fb23$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))

fb23$wohnen <- factor(fb23$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

fb23$ort <- factor(fb23$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb23$job <- factor(fb23$job, levels=c(1,2), labels=c("nein", "ja"))

# Weitere Standardisierungen
fb23$nerd_std <- scale(fb23$nerd)
fb23$neuro_std <- scale(fb23$neuro)


tab <- table(fb23$fach)               #Absolut
tab

prop.table(tab)                       #Relativ

tab<-table(fb23$fach,fb23$ziel)       #Kreuztabelle
tab

addmargins(tab)                       #Randsummen hinzufügen

prop.table(tab)                       #Relative Häufigkeiten

prop.table(tab, margin = 1)           #relativiert an Zeilen

prop.table(tab, margin = 2)           #relativiert an Spalten

addmargins(prop.table(tab))      # als geschachtelte Funktion
prop.table(tab) |> addmargins()  # als Pipe

barplot (tab,
         beside = TRUE,
         col = c('mintcream','olivedrab','peachpuff','steelblue','maroon'),
         legend = rownames(tab))

var(fb23$neuro, na.rm = TRUE)            #Varianz Neurotizismus

var(fb23$gewis, na.rm = TRUE)            #Varianz Gewissenhaftigkeit

cov(fb23$neuro, fb23$gewis)              #Kovarianz Neurotizismus und Gewissenhaftigkeit

cov(fb23$vertr, fb23$lz)              #Kovarianz Verträglichkeit und Lebenszufriedenheit

na_test <- fb23[, c('vertr','gewis',"neuro",'lz')] #Datensatzreduktion
cov(na_test)                                       #Kovarianzmatrix   

cov(na_test, use = "everything")         # Kovarianzmatrix mit Argument   

cov(na_test, use = 'pairwise')             #Paarweiser Fallausschluss

cov(na_test, use = 'complete')             #Listenweiser Fallausschluss

plot(x = fb23$neuro, y = fb23$gewis, xlim = c(1,5) , ylim = c(1,5))

cor(x = fb23$neuro, y = fb23$gewis, use = 'pairwise')

cor(na_test, use = 'pairwise')

cor(fb23$neuro, fb23$gewis, use = "pairwise", method = "pearson")

#QQ
qqnorm(fb23$neuro)
qqline(fb23$neuro)

qqnorm(fb23$gewis)
qqline(fb23$gewis)

#Histogramm

hist(fb23$neuro, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb23$neuro, na.rm = T), sd = sd(fb23$neuro, na.rm = T)), col = "blue", add = T)  
hist(fb23$gewis, prob = T, ylim = c(0,1))
curve(dnorm(x, mean = mean(fb23$gewis, na.rm = T), sd = sd(fb23$gewis, na.rm = T)), col = "blue", add = T)

#Shapiro
shapiro.test(fb23$neuro)
shapiro.test(fb23$gewis)

r1 <- cor(fb23$neuro,fb23$gewis,
          method = "spearman",     #Pearson ist default
          use = "complete") 

r1


cor(fb23$neuro, fb23$gewis, use = 'complete', method = 'kendall')

cor <- cor.test(fb23$neuro, fb23$gewis, 
         alternative = "two.sided", 
         method = "spearman",      #Da Voraussetzungen für Pearson verletzt
         use = "complete")
cor$p.value      #Gibt den p-Wert aus

cor.test(fb23$neuro, fb23$gewis, 
         alternative = "two.sided", 
         method = "pearson",       
         use = "complete")


is.factor(fb23$ort)
is.factor(fb23$job)

tab <- table(fb23$ort, fb23$job)
tab

korr_phi <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
  sqrt((tab[1,1]+tab[1,2])*(tab[1,1]+tab[2,1])*(tab[1,2]+tab[2,2])*(tab[2,1]+tab[2,2]))
korr_phi

# Numerische Variablen erstellen
ort_num <- as.numeric(fb23$ort)
job_num <- as.numeric(fb23$job)

cor(ort_num, job_num, use = 'pairwise')

cor.test(ort_num, job_num)

YulesQ <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
                 (tab[1,1]*tab[2,2]+tab[1,2]*tab[2,1])
YulesQ

# alternativ mit psych Paket
library(psych)
phi(tab, digits = 8)
Yule(tab)

tab

Odds_FFM = tab[1,1]/tab[1,2]
Odds_FFM

Odds_anderer = tab[2,1]/tab[2,2]
Odds_anderer

OR = Odds_anderer/Odds_FFM
OR

## install.packages('rococo')          #installieren

library(rococo)                     #laden

## ??rococo

## ?rococo

rococo(fb23$mdbf2_pre, fb23$mdbf3_pre)

rococo.test(fb23$mdbf2_pre, fb23$mdbf3_pre)

roc.test <- rococo.test(fb23$mdbf2_pre, fb23$mdbf3_pre)
