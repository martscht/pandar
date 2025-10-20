
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

fb24$ort <- factor(fb24$ort, levels=c(1,2), labels=c("FFM", "anderer"))
fb24$job <- factor(fb24$job, levels=c(1,2), labels=c("nein", "ja"))

# Rekodierung invertierter Items
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf11_r <- -1 * (fb24$mdbf11 - 5)
fb24$mdbf3_r <- -1 * (fb24$mdbf3 - 5)
fb24$mdbf9_r <- -1 * (fb24$mdbf9 - 5)

# Berechnung von Skalenwerten
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb24$ru_pre <-  fb24[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb24$ru_pre_zstd <- scale(fb24$ru_pre, center = TRUE, scale = TRUE)


## Häufigkeitstabellen

tab <- table(fb24$fach)               #Absolut
tab

prop.table(tab)                       #Relativ

tab<-table(fb24$fach,fb24$ziel)       #Kreuztabelle
tab

addmargins(tab)                       #Randsummen hinzufügen

prop.table(tab)                       #Relative Häufigkeiten

prop.table(tab, margin = 1)           #relativiert an Zeilen

prop.table(tab, margin = 2)           #relativiert an Spalten

addmargins(prop.table(tab))      # als geschachtelte Funktion
prop.table(tab) |> addmargins()  # als Pipe

## Balkendiagramm

barplot (tab,
         beside = TRUE,
         col = c('mintcream','olivedrab','peachpuff','steelblue','maroon'),
         legend = rownames(tab))

## Korrelationsfunktionen

var(fb24$neuro, na.rm = TRUE)            #Varianz Neurotizismus

var(fb24$gewis, na.rm = TRUE)            #Varianz Gewissenhaftigkeit

cov(fb24$neuro, fb24$gewis)              #Kovarianz Neurotizismus und Gewissenhaftigkeit

big5 <- fb24[,c('extra', 'vertr', 'gewis', 'neuro', 'offen')] #Datensatzreduktion
cov(big5)                                       #Kovarianzmatrix   

summary(big5)

cov(big5, use = "everything")         # Kovarianzmatrix mit Argument   

cov(big5, use = 'pairwise')             #Paarweiser Fallausschluss

cov(big5, use = 'complete')             #Listenweiser Fallausschluss

big5[1, 1] <- NA

cov(big5, use = 'complete')             #Listenweiser Fallausschluss
cov(big5, use = 'pairwise')             #Paarweiser Fallausschluss

## Grafische Darstellung

plot(x = fb24$neuro, y = fb24$gewis, xlim = c(1,5) , ylim = c(1,5))

## Produkt-Moment-Korrelation

cor(x = fb24$neuro, y = fb24$gewis, use = 'pairwise')

cor(big5, use = 'pairwise')

cor(fb24$neuro, fb24$gewis, use = "pairwise", method = "pearson")

## Normalverteilungsvoraussetzungen

# car-Paket laden
library(car)

#QQ
qqPlot(fb24$neuro)
qqPlot(fb24$gewis)

#Histogramm

hist(fb24$neuro, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb24$neuro, na.rm = T), sd = sd(fb24$neuro, na.rm = T)), col = "blue", add = T)  
hist(fb24$gewis, prob = T, ylim = c(0,1))
curve(dnorm(x, mean = mean(fb24$gewis, na.rm = T), sd = sd(fb24$gewis, na.rm = T)), col = "blue", add = T)

#Shapiro
shapiro.test(fb24$neuro)
shapiro.test(fb24$gewis)

## Rangkorrelation

r1 <- cor(fb24$neuro,fb24$gewis,
          method = "spearman",     #Pearson ist default
          use = "complete") 

r1


## Kendall-Tau

cor(fb24$neuro, fb24$gewis, use = 'complete', method = 'kendall')

## Signifikanztestung

cor <- cor.test(fb24$neuro, fb24$gewis, 
         alternative = "two.sided", 
         method = "spearman",      #Da Voraussetzungen für Pearson verletzt
         use = "complete")
cor$p.value      #Gibt den p-Wert aus

cor.test(fb24$neuro, fb24$gewis, 
         alternative = "two.sided", 
         method = "pearson",       
         use = "complete")


## Dichotome Zusammenhangsmaße 

is.factor(fb24$ort)
is.factor(fb24$job)

tab <- table(fb24$ort, fb24$job)
tab

korr_phi <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
  sqrt((tab[1,1]+tab[1,2])*(tab[1,1]+tab[2,1])*(tab[1,2]+tab[2,2])*(tab[2,1]+tab[2,2]))
korr_phi

# Numerische Variablen erstellen
ort_num <- as.numeric(fb24$ort)
job_num <- as.numeric(fb24$job)

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

## Ordinalskalierte Zusammenhänge

if (!requireNamespace("rococo", quietly = TRUE)) {
  install.packages("rococo")
}

library(rococo)                     #laden





rococo(fb24$mdbf2, fb24$mdbf3)

rococo.test(fb24$mdbf2, fb24$mdbf3)
