# Vorbereitungen
knitr::opts_chunk$set(echo = TRUE, fig.align = "center")
library(ggplot2) # ggplot2 und dplyr werden nur für Grafiken benötigt

library(corrplot) # Korrelationsmatrix grafisch darstellen
library(psych) # EFA durchführen
library(GPArotation) # EFA Lösung rotieren

library(htmlTable)
output <- c(c("E1", "I am the life of the party.",
"E2", "I don't talk a lot.",
"E3", "I feel comfortable around people.",
"N1", "I get stressed out easily.",
"N2", "I am relaxed most of the time.",
"N3", "I worry about things.",
"A1", "I feel little concern for others.",
"A2", "I am interested in people.",
"A3", "I insult people.",
"C1", "I am always prepared.",
"C2", "I leave my belongings around.",
"C3", "I pay attention to details.",
"O1", "I have a rich vocabulary.",
"O2", "I have difficulty understanding abstract ideas.",
"O3", "I have a vivid imagination."))
output <- matrix(output, ncol = 2, nrow = 3*5, byrow = T)
htmlTable(output, header =  paste(c("Item Nr.", "Item")),
         caption="Itemwortlaut", align = "cl")

## load("C:/Users/Musterfrau/Desktop/Big5_EFA.rda")

load(url("https://pandar.netlify.app/daten/Big5_EFA.rda"))
load("../../daten/Big5_EFA.rda")

head(Big5, n = 10) # gebe die ersten 10 Zeilen aus

dim(Big5)
data_France <- Big5[Big5$country == "FR", ]
dim(data_France)

dataFR <- data_France[, -c(1:4)] # entferne demografische Daten und speichere als "dataFR"

#### Visualisierte Korrelationsmatrix in dataFR
corrplot(corr = cor(dataFR), # Korrelationsmatrix (Datengrundlage)
         method = "color", # zeichne die Ausprägung der Korrelation farblich kodiert
         addCoef.col = "black", # schreibe die Korrelationskoeffizienten in schwarz in die Grafik
         number.cex = 0.7) # stelle die Schriftgröße der Koeffizienten ein


dataFR2 <- dataFR[,1:6] # Zunächst wählen wir die ersten 6 Items: E1 bis E3 und N1 bis N3
head(dataFR2)
# zum gleichen Ergebnis würde auch Folgendes kommen (besonders von Relevanz,
# wenn wir bspw. nicht die Position sondern nur die Namen der Variablen kennen!):
head(dataFR[, c("E1", "E2", "E3", "N1", "N2", "N3")])

# Visualisierte Korrelationsmatrix
corrplot(corr = cor(dataFR2), # Korrelationsmatrix (Datengrundlage)
         method = "color", # Zeichne die Ausprägung der Korrelation farblich kodiert
         addCoef.col = "black", # schreibe die Korrelationskoeffizienten in schwarz in die Grafik
         number.cex = 1) # Stelle die Schriftgröße der Koeffizienten ein

fa.parallel(dataFR2)

fa.parallel(dataFR2, fa = "fa")

fa(dataFR2, nfactors = 2, rotate = "varimax")

two_factor <- fa(dataFR2, nfactors = 2, rotate = "varimax")
names(two_factor) # mögliche Informationen

two_factor$loadings

two_factor$loadings[,] # ohne seltsames Runden

two_factor$Structure[,]

two_factor_oblimin <- fa(dataFR2, nfactors = 2, rotate = "oblimin")

two_factor$Vaccounted
two_factor_oblimin$Vaccounted

two_factor_oblimin$loadings[,] # Ladungsmatrix

two_factor_oblimin$Phi

two_factor_oblimin$loadings[,]
two_factor_oblimin$Structure[,]

two_factor_ML <- fa(dataFR2, nfactors = 2, rotate = "oblimin", fm = "ml")
two_factor_ML

two_factor_ML$STATISTIC # Likelihood basierter Chi²-Wert
two_factor_ML$PVAL # p-Wert

one_factor_ML <- fa(dataFR2, nfactors = 1, rotate = "oblimin", fm = "ml")
one_factor_ML$STATISTIC # Chi²-Wert
one_factor_ML$PVAL # p-Wert

## anova(one_factor_ML, two_factor_ML)

knitr::kable(anova(one_factor_ML, two_factor_ML), row.names = T)

# Passt auch eines mit 3 Faktor?
three_factor_ML <- fa(dataFR2, nfactors = 3, rotate = "oblimin", fm = "ml")
three_factor_ML$STATISTIC # Chi²-Wert
three_factor_ML$PVAL # p-Wert

## anova(two_factor_ML, three_factor_ML)

knitr::kable(anova(two_factor_ML, three_factor_ML), row.names = T)

## data_full <- read.table("BIG5/data.csv", header = T, sep = "\t") # nach entpacken des .zip liegen die Daten in einem Ordner namens Big5
## 
## ### Entferne leere Zeilen und Zeilen mit Missings aus dem Datensatz
## ind <- apply(data_full, 1, FUN = function(x) any(is.na(x))) # erzeuge eine Variable, welche TRUE ist, wenn mindestens ein Eintrag pro Zeile fehlt und ansonsten FALSE anzeigt
## data_full <- data_full[!ind, ] # Wähle nur diejenigen Zeilen, in denen unsere Indikatorvariable "ind" NICHT TRUE anzeigt, also wo alle Einträge vorhanden sind
## # !ind (Ausrufezeichen vor ind) negiert die Einträge in ind (Prüfe bspw. !FALSE == TRUE, nicht false ist gleich true)
## 
## ### Shorten Data Set
## Big5 <- data_full[, c(2:4,7,7+rep(1:3,5)+sort(rep(seq(0,40,10),3)))]
##  # Verwende nur 3 Items pro Skala plus einige demografische Items
## Big5 <- data.frame(Big5) # Schreibe Datensatz als data.frame
## save(list = c("Big5"), file = "Big5.rda")
## # Speichere gekürzten Datensatz in .rda file (dem R-internen Datenformat)
## ## --> Das ist auch der Datensatz, den wir weiter verwendet haben!

fa.parallel(x = dataFR,fa = "fa")

five_factor_ML <- fa(dataFR, nfactors = 5, rotate = "oblimin", fm = "ml")
five_factor_ML$STATISTIC
five_factor_ML$PVAL # Modell wird durch die Daten nicht verworfen

five_factor_ML$loadings # auch nochmal ohne [,] um die Ausblendehilfe von psych als Unterstützung für die Zuordnung zu nutzen
five_factor_ML$loadings[,] # alle Dezimalstellen anzeigen

fa(dataFR, nfactors = 5, rotate = "varimax", fm = "ml")$loadings[,]

round(five_factor_ML$Phi, 2) # runde auf 2 Nachkommastellen
fa(dataFR, nfactors = 5, rotate = "varimax", fm = "ml")$Phi

diag(5) # Einheitsmatrix der Dimension 5x5.

four_factor_ML <- fa(dataFR, nfactors = 4, rotate = "oblimin", fm = "ml")
four_factor_ML$STATISTIC
four_factor_ML$PVAL

## anova(four_factor_ML, five_factor_ML)

knitr::kable(anova(four_factor_ML, five_factor_ML), row.names = T)

six_factor_ML <- fa(dataFR, nfactors = 6, rotate = "oblimin", fm = "ml")
six_factor_ML$STATISTIC
six_factor_ML$PVAL # Modell wird durch die Daten nicht verworfen

## anova(five_factor_ML, six_factor_ML)

knitr::kable(anova(five_factor_ML, six_factor_ML), row.names = T)

## anova(four_factor_ML, five_factor_ML, six_factor_ML)

knitr::kable(anova(four_factor_ML, five_factor_ML, six_factor_ML), row.names = T)

two_factor$loadings[1, 1] # volle Formel für ersten Eintrag in Strukutrmatrix, da Kovarianz der Faktoren = 0
two_factor$Structure[1, 1] # erster Eintrag in der Strukturmatrix

two_factor_oblimin$loadings[1, 1] # erste Faktorladung im obliquen Modell (unterscheidet sich von dem ersten Eintrag der Strukturmatrix)
two_factor_oblimin$loadings[1, 1] + two_factor_oblimin$loadings[1, 2]*two_factor_oblimin$Phi[2, 1] # volle Formel für ersten Eintrag in Strukutrmatrix
two_factor_oblimin$Structure[1, 1] # erster Eintrag in der Strukturmatrix

two_factor_oblimin$loadings[,] %*% two_factor_oblimin$Phi[,] # Matrixprodukt
two_factor_oblimin$Structure[,] # Strukturmatrix

five_factor_ML$loadings[,] %*% five_factor_ML$Phi[,] # Matrixprodukt
five_factor_ML$Structure[,] # Strukturmatrix

five_factor_ML$loadings[,] %*% five_factor_ML$Phi[,] - five_factor_ML$Structure[,]

two_factor_ML$communality
diag(two_factor_ML$loadings[,] %*% two_factor_ML$Phi[,] %*% t(two_factor_ML$loadings[,]))
diag(two_factor_ML$Structure[,] %*% t(two_factor_ML$loadings[,]))

two_factor_ML$Vaccounted # Eigenwerte nach Rotation und Extraktion in SS loadings
diag(two_factor_ML$Phi[,] %*% t(two_factor_ML$loadings[,])  %*% two_factor_ML$loadings[,])
diag(t(two_factor_ML$Structure[,]) %*% two_factor_ML$loadings[,])

Mahalanobis_Distanz <- mahalanobis(x = dataFR, cov = cov(dataFR), center = colMeans(dataFR)) # Berechnen der Mahalanobisdistanz
hist(Mahalanobis_Distanz, col = "skyblue", border = "blue", freq = F, breaks = 15) # Histogramm
lines(x = seq(0, max(Mahalanobis_Distanz), 0.01), y = dchisq(x = seq(0, max(Mahalanobis_Distanz), 0.01), df = 15), col = "darkblue", lwd = 4) # Einzeichnen der Dichte

colMeans(dataFR)

library(MVN)
mvn(data = dataFR, mvnTest = "mardia")

cat('## $multivariateNormality
##              Test        Statistic              p value Result
## 1 Mardia Skewness 814.236119391994 0.000288124299329737     NO
## 2 Mardia Kurtosis 1.53049602635342    0.125893996300673    YES
## 3             MVN             <NA>                 <NA>     NO
## ')
