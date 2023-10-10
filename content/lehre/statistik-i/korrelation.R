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


tab <- table(fb22$fach)               #Absolut
tab

prop.table(tab)                       #Relativ

tab<-table(fb22$fach,fb22$ziel)       #Kreuztabelle
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

var(fb22$vertr, na.rm = TRUE)            #Varianz Verträglichkeit

var(fb22$gewis, na.rm = TRUE)            #Varianz Gewissenhaftigkeit

cov(fb22$vertr, fb22$gewis)              #Kovarianz Verträglichkeit und Gewissenhaftigkeit

drei <- fb22[, c('vertr','gewis','lz')]         #Datensatzreduktion
cov(drei)                                       #Kovarianzmatrix   

fb22$vertr_neu <- fb22$vertr                     # erstelle neue Variable vertr_neu
fb22[c(50,72), 'vertr_neu'] <- NA               # setze vertr_neu in den Zeilen 50 und 72 auf fehlend
drei_neu <- fb22[, c('vertr_neu','gewis','lz')]         #Datensatzreduktion
cov(drei_neu)                                       #Kovarianzmatrix   

cov(drei_neu, use = 'pairwise')             #Paarweiser Fallausschluss

cov(drei_neu, use = 'complete')             #Listenweiser Fallausschluss

plot(x = fb22$vertr, y = fb22$gewis, xlim = c(1,5) , ylim = c(1,5))

cor(x = fb22$vertr, y = fb22$gewis, use = 'pairwise')

cor(drei, use = 'pairwise')

cor(fb22$vertr, fb22$gewis, use = "pairwise", method = "pearson")

#QQ
qqnorm(fb22$vertr)
qqline(fb22$vertr)

qqnorm(fb22$gewis)
qqline(fb22$gewis)

#Histogramm

hist(fb22$vertr, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb22$vertr, na.rm = T), sd = sd(fb22$vertr, na.rm = T)), col = "blue", add = T)  
hist(fb22$gewis, prob = T, ylim = c(0,1))
curve(dnorm(x, mean = mean(fb22$gewis, na.rm = T), sd = sd(fb22$gewis, na.rm = T)), col = "blue", add = T)

#Shapiro
shapiro.test(fb22$vertr)
shapiro.test(fb22$gewis)

r1 <- cor(fb22$vertr,fb22$gewis,
          method = "spearman",     #Pearson ist default
          use = "complete") 

r1


cor(fb22$vertr, fb22$gewis, use = 'complete', method = 'kendall')

cor <- cor.test(fb22$vertr, fb22$gewis, 
         alternative = "two.sided", 
         method = "spearman",      #Da Voraussetzungen für Pearson verletzt
         use = "complete")
cor$p.value      #Gibt den p-Wert aus

cor.test(fb22$vertr, fb22$gewis, 
         alternative = "two.sided", 
         method = "pearson",       
         use = "complete")


## install.packages('rococo')          #installieren

library(rococo)                     #laden

## ??rococo

## ?rococo

rococo(fb22$prok1, fb22$prok9)

rococo.test(fb22$prok1, fb22$prok9)

roc.test <- rococo.test(fb22$prok1, fb22$prok2)
roc.test
