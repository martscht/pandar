knitr::opts_chunk$set(error = TRUE)
knitr::knit_hooks$set(purl = knitr::hook_purl)
library(knitr)

load(url('https://pandar.netlify.app/post/fb22.rda'))   # Daten laden
names(fb22)        # Namen der Variablen
dim(fb22)          # Anzahl Zeile und Spalten

str(fb22$geschl)
fb22$geschl

fb22$geschl_faktor <- factor(fb22$geschl,                                   # Ausgangsvariable
                             levels = 1:3,                                  # Faktorstufen
                             labels = c("weiblich", "männlich", "anderes")) # Label für Faktorstufen
str(fb22$geschl_faktor)
head(fb22$geschl_faktor)

fb22$fach

fb22$fach <- factor(fb22$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
str(fb22$fach)

str(fb22$grund)                            # Ursprungsvariable: Character
fb22$grund_faktor <- as.factor(fb22$grund) # Umwandlung in Faktor
str(fb22$grund_faktor)                     # neue Variable: Faktor

levels(fb22$fach)         # Abruf

fb22$fach <- relevel(
  fb22$fach,              # Bezugskategorie wechseln
  'Diag./Meth.')          # Neue Bezugskategorie

table(fb22$fach)

tab <- table(fb22$fach) # Absolute Haeufigkeiten
sum(tab)                # Gesamtzahl
tab / sum(tab)          # Relative Haeufigkeiten

tab <- table(fb22$fach) # Absolute
prop.table(tab)         # Relative

library("RXKCD")
invisible(getXKCD(373))

## barplot(tab)

barplot(tab)

pie(tab)

colors()[1:20]

rainbow(5)

barplot(tab,
        col = rainbow(5),                        # Farbe
        ylab = 'Anzahl Studierende',             # y-Achse Bezeichnung
        main = 'Lieblingsfach im 1. Semester',   # Überschrift der Grafik
        las = 2,                                 # Ausrichtung der Labels
        cex.names = 0.8)                         # Schriftgröße der Labels

## jpeg("Mein-Barplot.jpg", width=15, height=10, units="cm", res=150) # Eröffnung Bilderstellung
## barplot(tab,
##  col = rainbow(5),
##  ylab = 'Anzahl Studierende',
##  main = 'Lieblingsfach im 1. Semester',
##  las = 2,
##  cex.names = 0.8)
## dev.off()                                                         # Abschluss Bilderstellung

tab            # Tabelle ausgeben
max(tab)       # Größte Häufigkeit
which.max(tab) # Modus

hj <- prop.table(tab)       # hj erstellen
ln_hj <- log(hj)            # Logarithmus bestimmen
ln_hj                       # Ergebnisse für jede Kategorie
summand <- ln_hj * hj       # Berechnung für jede Kategorie
summe <- sum(summand)       # Gesamtsumme
k <- dim(tab)               # Anzahl Kategorien
relinf <- -1/log(k) * summe # Relativer Informationsgehalt
relinf

relinf <- (ln_hj * hj) |> sum() * (-1/log(k))  # Relativer Informationsgehalt
relinf

- 1/log(dim(table(fb22$fach))) * sum(prop.table(table(fb22$fach)) * log(prop.table(table(fb22$fach))))

fb22$prok4

table(fb22$prok4)               # Absolute Haeufigkeiten
prop.table(table(fb22$prok4))   # Relative Haeufigkeiten
which.max(table(fb22$prok4))    # Modus

median(fb22$prok4)                 # Ohne Argument für NA: funktioniert nicht
median(fb22$prok4, na.rm = TRUE)   # Expliziter Ausschluss: funktioniert

quantile(fb22$prok4,
         c(.25, .5, .75),                   # Quartile anfordern
         na.rm = T)

quantile(fb22$prok4, .75, na.rm=T) - quantile(fb22$prok4, .25, na.rm=T)

IQR(fb22$prok4, na.rm = TRUE)

boxplot(fb22$prok4)

boxplot(fb22$nr6)

boxplot(fb22$nr6,
        horizontal = TRUE,                # Ausrichtung des Boxplots
        main = "WS 2022/2023: Item Nr6",  # Überschrift der Grafik
        xlab = "Ausprägung",              # x-Achse Bezeichnung 
        las = 1,                          # Ausrichtung der Labels
        border = "red",                   # Farbe der Linien im Boxplot
        col = "pink1")                    # Farbe der Fläche innerhalb der Box
