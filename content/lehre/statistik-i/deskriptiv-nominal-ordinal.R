load(url('https://pandar.netlify.app/daten/fb26.rda'))   # Daten laden
names(fb26)        # Namen der Variablen
dim(fb26)          # Anzahl Zeile und Spalten

#### Nominalskalierte Variablen ----

str(fb26$hand)
fb26$hand

fb26$hand_factor <- factor(fb26$hand,                     # Ausgangsvariable
                           levels = 1:2,                  # Faktorstufen
                           labels = c("links", "rechts")) # Label für Faktorstufen
str(fb26$hand_factor)
head(fb26$hand_factor)

fb26$fach

fb26$fach <- factor(fb26$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 
                               'Klinische', 'Diag./Meth.'))
str(fb26$fach)

levels(fb26$fach)         # Abruf

fb26$fach <- relevel(
  fb26$fach,              # Bezugskategorie wechseln
  'Diag./Meth.')          # Neue Bezugskategorie

table(fb26$fach)

table(fb26$fach) |> sum()

table(fb26$fach, useNA = "ifany")

tab <- table(fb26$fach, useNA = "ifany") # Absolute Haeufigkeiten
sum(tab)         # Gesamtzahl
tab / sum(tab)   # Relative Haeufigkeiten

tab <- table(fb26$fach, useNA = "ifany")  # Absolute
prop.table(tab)                           # Relative



# Säulen- oder Balkendiagramm
barplot(tab)

# Tortendiagramm
pie(tab)

colors()[1:20]

rainbow(5)

# Farbiger Barplot
barplot(tab,
        col = rainbow(5),                        # Farbe
        ylab = 'Anzahl Studierende',             # y-Achse Bezeichnung
        main = 'Lieblingsfach im 1. Semester',   # Überschrift der Grafik
        las = 2,                                 # Ausrichtung der Labels
        cex.names = 0.8)                         # Schriftgröße der Labels

# jpeg("Mein-Barplot.jpg", width=15, height=10, units="cm", res=150) # Eröffnung Bilderstellung
# barplot(tab,
#  col = rainbow(5),
#  ylab = 'Anzahl Studierende',
#  main = 'Lieblingsfach im 1. Semester',
#  las = 2,
#  cex.names = 0.8)
# dev.off()                                                         # Abschluss Bilderstellung

## Deskriptivstatistische Kennwerte 

tab            # Tabelle ausgeben
max(tab)       # Größte Häufigkeit
which.max(tab) # Modus

## Relativer Informationsgehalt

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

# Verschachtelte Version
- 1/log(dim(table(fb26$fach))) * sum(prop.table(table(fb26$fach)) * log(prop.table(table(fb26$fach))))

fb26$sicher

table(fb26$sicher, useNA = "ifany")              # Absolute Haeufigkeiten (ohne NA)
prop.table(table(fb26$sicher, useNA = "ifany"))  # Relative Haeufigkeiten
which.max(table(fb26$sicher))                    # Modus

median(fb26$sicher)                 # Ohne Argument für NA: funktioniert nicht
median(fb26$sicher, na.rm = TRUE)   # Expliziter Ausschluss: funktioniert

quantile(fb26$sicher,
         c(.25, .5, .75),                   # Quartile anfordern
         na.rm = TRUE)

quantile(fb26$sicher, .75, na.rm=TRUE) - quantile(fb26$sicher, .25, na.rm=TRUE)

IQR(fb26$sicher, na.rm = TRUE)



## Basic Boxplot

boxplot(fb26$sicher)

## Farbiger Boxplot

boxplot(fb26$sicher,
        horizontal = TRUE,                # Ausrichtung des Boxplots
        main = "WS 2026/27: Sicherheit in der Studienwahl",  # Überschrift der Grafik
        xlab = "Ausprägung",              # x-Achse Bezeichnung 
        las = 1,                          # Ausrichtung der Labels
        border = "red",                   # Farbe der Linien im Boxplot
        col = "pink1",                    # Farbe der Fläche innerhalb der Box
        xaxt = "n")                       # x-Achsenbeschriftung unterdrücken
axis(1, at = 1:4)                         # Bessere x-Achsenbeschriftung
