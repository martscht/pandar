load(url("https://pandar.netlify.app/daten/fb24.rda")) # Daten laden
names(fb24) # Namen der Variablen
dim(fb24) # Anzahl Zeile und Spalten

str(fb24$hand)
fb24$hand

fb24$hand_factor <- factor(fb24$hand, # Ausgangsvariable
  levels = 1:2, # Faktorstufen
  labels = c("links", "rechts")
) # Label für Faktorstufen
str(fb24$hand_factor)
head(fb24$hand_factor)

fb24$fach

fb24$fach <- factor(fb24$fach,
  levels = 1:5,
  labels = c("Allgemeine", "Biologische", "Entwicklung", "Klinische", "Diag./Meth.")
)
str(fb24$fach)

str(fb24$grund) # Ursprungsvariable: Character
fb24$grund_faktor <- as.factor(fb24$grund) # Umwandlung in Faktor
str(fb24$grund_faktor) # neue Variable: Faktor

levels(fb24$fach) # Abruf

fb24$fach <- relevel(
  fb24$fach, # Bezugskategorie wechseln
  "Diag./Meth."
) # Neue Bezugskategorie

table(fb24$fach)

tab <- table(fb24$fach) # Absolute Haeufigkeiten
sum(tab) # Gesamtzahl
tab / sum(tab) # Relative Haeufigkeiten

tab <- table(fb24$fach) # Absolute
prop.table(tab) # Relative

# ---- basic-barplot ----
barplot(tab)

# ---- basic-pie ----
pie(tab)

colors()[1:20]

rainbow(5)

# ---- colored-barplot----------- ----
barplot(tab,
  col = rainbow(5), # Farbe
  ylab = "Anzahl Studierende", # y-Achse Bezeichnung
  main = "Lieblingsfach im 1. Semester", # Überschrift der Grafik
  las = 2, # Ausrichtung der Labels
  cex.names = 0.8
) # Schriftgröße der Labels

# ---- Beispielspeicherung ----
## Kommentare entfernen (##) zum Ausführen!
## jpeg("Mein-Barplot.jpg", width=15, height=10, units="cm", res=150) # Eröffnung Bilderstellung
## barplot(tab,
##  col = rainbow(5),
##  ylab = 'Anzahl Studierende',
##  main = 'Lieblingsfach im 1. Semester',
##  las = 2,
##  cex.names = 0.8)
## dev.off()                                                         # Abschluss Bilderstellung

tab # Tabelle ausgeben
max(tab) # Größte Häufigkeit
which.max(tab) # Modus

hj <- prop.table(tab) # hj erstellen
ln_hj <- log(hj) # Logarithmus bestimmen
ln_hj # Ergebnisse für jede Kategorie
summand <- ln_hj * hj # Berechnung für jede Kategorie
summe <- sum(summand) # Gesamtsumme
k <- dim(tab) # Anzahl Kategorien
relinf <- -1 / log(k) * summe # Relativer Informationsgehalt
relinf

relinf <- (ln_hj * hj) |> sum() * (-1 / log(k)) # Relativer Informationsgehalt
relinf

-1 / log(dim(table(fb24$fach))) * sum(prop.table(table(fb24$fach)) * log(prop.table(table(fb24$fach))))

fb24$wissen

table(fb24$wissen) # Absolute Haeufigkeiten
prop.table(table(fb24$wissen)) # Relative Haeufigkeiten
which.max(table(fb24$wissen)) # Modus

median(fb24$wissen) # Ohne Argument für NA: funktioniert nicht
median(fb24$wissen, na.rm = TRUE) # Expliziter Ausschluss: funktioniert

quantile(fb24$wissen,
  c(.25, .5, .75), # Quartile anfordern
  na.rm = TRUE
)

quantile(fb24$wissen, .75, na.rm = TRUE) - quantile(fb24$wissen, .25, na.rm = TRUE)

IQR(fb24$wissen, na.rm = TRUE)

# ---- basic-boxplot-one--------- ----
boxplot(fb24$wissen)

# ---- colored-boxplot----------- ----
boxplot(fb24$wissen,
  horizontal = TRUE, # Ausrichtung des Boxplots
  main = "WS 2024/2025: Interesse an der Wissenschaft", # Überschrift der Grafik
  xlab = "Ausprägung", # x-Achse Bezeichnung
  las = 1, # Ausrichtung der Labels
  border = "red", # Farbe der Linien im Boxplot
  col = "pink1"
) # Farbe der Fläche innerhalb der Box
