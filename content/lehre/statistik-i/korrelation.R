
#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb25.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb25$hand_factor <- factor(fb25$hand,
                           levels = 1:2,
                           labels = c("links", "rechts"))
fb25$fach <- factor(fb25$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb25$ziel <- factor(fb25$ziel,
                    levels = 1:4,
                    labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb25$wohnen <- factor(fb25$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))
fb25$ort <- factor(fb25$ort, 
                   levels=c(1,2), 
                   labels=c("FFM", "anderer"))
fb25$job <- factor(fb25$job, 
                   levels=c(1,2), 
                   labels=c("nein", "ja"))

# Rekodierung invertierter Items
fb25$mdbf4_r <- -1 * (fb25$mdbf4 - 5)
fb25$mdbf11_r <- -1 * (fb25$mdbf11 - 5)
fb25$mdbf3_r <- -1 * (fb25$mdbf3 - 5)
fb25$mdbf9_r <- -1 * (fb25$mdbf9 - 5)

# Berechnung von Skalenwerten
fb25$gs_pre  <- fb25[, c('mdbf1', 'mdbf4_r', 
                         'mdbf8', 'mdbf11_r')] |> rowMeans()
fb25$ru_pre <-  fb25[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb25$ru_pre_zstd <- scale(fb25$ru_pre, center = TRUE, scale = TRUE)


## Grafische Darstellung

plot(x = fb25$extra, y = fb25$gewis, xlim = c(1,5) , ylim = c(1,5))

## Varianz, Kovarianz und Korrelation

cov(fb25$extra, fb25$gewis)     # Kovarianz Extraversion und Gewissenhaftigkeit

cov(fb25$extra, fb25$gewis, use = "pairwise") # Kovarianz Extraversion und Gewissenhaftigkeit

## Produkt-Moment-Korrelation

cor(x = fb25$extra, y = fb25$gewis, use = 'pairwise') # Bestimmung Pearson-Korrelation



# Histogramme
hist(fb25$extra, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb25$extra, na.rm = T), sd = sd(fb25$extra, na.rm = T)), col = "blue", add = T)  
hist(fb25$gewis, prob = T, ylim = c(0,1))
curve(dnorm(x, mean = mean(fb25$gewis, na.rm = T), sd = sd(fb25$gewis, na.rm = T)), col = "blue", add = T)

# car-Paket laden
library(car)

# qq-Plots
qqPlot(fb25$extra)
qqPlot(fb25$gewis)

# Shapiro
shapiro.test(fb25$extra)
shapiro.test(fb25$gewis)

## Inferenzstatistische Prüfung der Spearman-Rangkorrelation

cor(x = fb25$extra, y = fb25$gewis, use = 'pairwise', method = "spearman") # Bestimmung Spearman-Rangkorrelation

# Durchführung Testung der Spearman-Rangkorrelation
cor.test(fb25$extra, fb25$gewis, 
         alternative = "two.sided", 
         method = "spearman",      
         use = "complete")

## Kovarianz- und Korrelationsmatrizen

cov(fb25[, c('vertr', 'gewis', 'extra')], use = "pairwise")  # Kovarianzmatrix

cor(fb25[, c('vertr', 'gewis', 'extra')], use = "pairwise")  # Korrelationsmatrix

cor(fb25[, c('vertr', 'gewis', 'extra')])  # Nutzung aller Beobachtungen
cor(fb25[, c('vertr', 'gewis', 'extra')], use = "everything")  # Nutzung aller Beobachtungen

cor(fb25[, c('vertr', 'gewis', 'extra')], use = 'pairwise')  # Paarweiser Fallausschluss

cor(fb25[, c('vertr', 'gewis', 'extra')], use = 'complete')  # Listenweiser Fallausschluss

## Dichotome Zusammenhangsmaße 

is.factor(fb25$ort)
is.factor(fb25$job)

tab <- table(fb25$ort, fb25$job)
tab

addmargins(tab)                       #Randsummen hinzufügen

prop.table(tab)                       #Relative Häufigkeiten

prop.table(tab, margin = 1)           #relativiert an Zeilen

prop.table(tab, margin = 2)           #relativiert an Spalten

addmargins(prop.table(tab))      # als geschachtelte Funktion
prop.table(tab) |> addmargins()  # als Pipe

## Balkendiagramm

barplot(tab,
        beside = TRUE,
        col = c('mintcream','olivedrab'),
        legend = rownames(tab))

# psych-Paket laden
library(psych)
phi(tab, digits = 4)                   #Korrelationskoeffizient phi

# Numerische Variablen erstellen
ort_num <- as.numeric(fb25$ort)
job_num <- as.numeric(fb25$job)

cor(ort_num, job_num, use = 'pairwise')

cor.test(ort_num, job_num)

Yule(tab)                   # Yules Q

phi <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
  sqrt((tab[1,1]+tab[1,2])*(tab[1,1]+tab[2,1])*(tab[1,2]+tab[2,2])*(tab[2,1]+tab[2,2]))
phi

YulesQ <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
                 (tab[1,1]*tab[2,2]+tab[1,2]*tab[2,1])
YulesQ

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





rococo(fb25$mdbf2, fb25$mdbf3)

rococo.test(fb25$mdbf2, fb25$mdbf3)
