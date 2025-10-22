load(url('https://pandar.netlify.app/daten/fb25.rda'))   # Daten laden
names(fb25)        # Namen der Variablen
dim(fb25)          # Anzahl Zeile und Spalten

#### Nominalskalierte Variablen ----

str(fb25$hand)
fb25$hand

fb25$hand_factor <- factor(fb25$hand,                       # Ausgangsvariable
                           levels = 1:2,                  # Faktorstufen
                           labels = c("links", "rechts")) # Label für Faktorstufen
str(fb25$hand_factor)
head(fb25$hand_factor)

fb25$fach

fb25$fach <- factor(fb25$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 
                               'Klinische', 'Diag./Meth.'))
str(fb25$fach)

levels(fb25$fach)         # Abruf

fb25$fach <- relevel(
  fb25$fach,              # Bezugskategorie wechseln
  'Diag./Meth.')          # Neue Bezugskategorie

table(fb25$fach)

table(fb25$fach) |> sum()

table(fb25$fach, useNA = "ifany")

tab <- table(fb25$fach, useNA = "ifany") # Absolute Haeufigkeiten
sum(tab)         # Gesamtzahl
tab / sum(tab)   # Relative Haeufigkeiten

tab <- table(fb25$fach, useNA = "ifany")  # Absolute
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
- 1/log(dim(table(fb25$fach))) * sum(prop.table(table(fb25$fach)) * log(prop.table(table(fb25$fach))))

fb25$sicher

table(fb25$sicher, useNA = "ifany")              # Absolute Haeufigkeiten (ohne NA)
prop.table(table(fb25$sicher, useNA = "ifany"))  # Relative Haeufigkeiten
which.max(table(fb25$sicher))                    # Modus

median(fb25$sicher)                 # Ohne Argument für NA: funktioniert nicht
median(fb25$sicher, na.rm = TRUE)   # Expliziter Ausschluss: funktioniert

quantile(fb25$sicher,
         c(.25, .5, .75),                   # Quartile anfordern
         na.rm = TRUE)

quantile(fb25$sicher, .75, na.rm=TRUE) - quantile(fb25$sicher, .25, na.rm=TRUE)

IQR(fb25$sicher, na.rm = TRUE)



## Basic Boxplot

boxplot(fb25$sicher)

## Farbiger Boxplot

boxplot(fb25$sicher,
        horizontal = TRUE,                # Ausrichtung des Boxplots
        main = "WS 2025/26: Sicherheit in der Studienwahl",  # Überschrift der Grafik
        xlab = "Ausprägung",              # x-Achse Bezeichnung 
        las = 1,                          # Ausrichtung der Labels
        border = "red",                   # Farbe der Linien im Boxplot
        col = "pink1",                    # Farbe der Fläche innerhalb der Box
        xaxt = "n")                       # x-Achsenbeschriftung unterdrücken
axis(1, at = 1:4)                         # Bessere x-Achsenbeschriftung
