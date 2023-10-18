load(url('https://pandar.netlify.app/daten/fb23.rda'))   # Daten laden
names(fb23)        # Namen der Variablen
dim(fb23)          # Anzahl Zeile und Spalten

str(fb23$hand)
fb23$hand

fb23$hand_factor <- factor(fb23$hand,                                   # Ausgangsvariable
                             levels = 1:2,                                  # Faktorstufen
                             labels = c("links", "rechts")) # Label für Faktorstufen
str(fb23$hand_factor)
head(fb23$hand_factor)

fb23$fach

fb23$fach <- factor(fb23$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
str(fb23$fach)

str(fb23$grund)                            # Ursprungsvariable: Character
fb23$grund_faktor <- as.factor(fb23$grund) # Umwandlung in Faktor
str(fb23$grund_faktor)                     # neue Variable: Faktor

levels(fb23$fach)         # Abruf

fb23$fach <- relevel(
  fb23$fach,              # Bezugskategorie wechseln
  'Diag./Meth.')          # Neue Bezugskategorie

table(fb23$fach)

tab <- table(fb23$fach) # Absolute Haeufigkeiten
sum(tab)                # Gesamtzahl
tab / sum(tab)          # Relative Haeufigkeiten

tab <- table(fb23$fach) # Absolute
prop.table(tab)         # Relative





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

- 1/log(dim(table(fb23$fach))) * sum(prop.table(table(fb23$fach)) * log(prop.table(table(fb23$fach))))

fb23$wissen

table(fb23$wissen)               # Absolute Haeufigkeiten
prop.table(table(fb23$wissen))   # Relative Haeufigkeiten
which.max(table(fb23$wissen))    # Modus

median(fb23$wissen)                 # Ohne Argument für NA: funktioniert nicht
median(fb23$wissen, na.rm = TRUE)   # Expliziter Ausschluss: funktioniert

quantile(fb23$wissen,
         c(.25, .5, .75),                   # Quartile anfordern
         na.rm = TRUE)

quantile(fb23$wissen, .75, na.rm=TRUE) - quantile(fb23$wissen, na.rm=TRUE)

IQR(fb23$wissen, na.rm = TRUE)



boxplot(fb23$wissen)

boxplot(fb23$wissen,
        horizontal = TRUE,                # Ausrichtung des Boxplots
        main = "WS 2023/2024: Interesse an der Wissenschaft",  # Überschrift der Grafik
        xlab = "Ausprägung",              # x-Achse Bezeichnung 
        las = 1,                          # Ausrichtung der Labels
        border = "red",                   # Farbe der Linien im Boxplot
        col = "pink1")                    # Farbe der Fläche innerhalb der Box
