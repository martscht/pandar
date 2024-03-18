load(url('https://pandar.netlify.app/daten/fb23.rda'))   # Daten laden

dim(fb23)
str(fb23)

fb23$ziel <- factor(fb23$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
levels(fb23$ziel)

table(fb23$ziel)              # absolut
prop.table(table(fb23$ziel))  # relativ

# Modus
which.max(table(fb23$ziel))

#relativer Informationsgehalt
hj <- prop.table(table(fb23$ziel))  # hj erstellen
ln_hj <- log(hj)                    # Logarithmus bestimmen
summand <- ln_hj * hj               # Berechnung fuer jede Kategorie
summe <- sum(summand)               # Gesamtsumme
k <- length(hj)                     # Anzahl Kategorien bestimmen
relInf <- -1/log(k) * summe         # Relativer Informationsgehalt
relInf

which.max(table(fb23$therap))

table(fb23$therap)
prop.table(table(fb23$therap))

boxplot(fb23$therap)

quantile(fb23$therap, c(.25,.5,.75), na.rm=T)

fb23$wohnen <- factor(fb23$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

par(mfrow=c(1,2))

# Default
barplot(table(fb23$wohnen))

# Überarbeitet
barplot(
  # wichtig: Funktion auf Häufigkeitstabelle, nicht die Variable selbst anwenden:
  table(fb23$wohnen),                               
  # aussagekräftiger Titel, inkl. Zeilenumbruch ("\n") 
  main = "Befragung Erstis im WS 23/24:\nAktuelle Wohnsituation", 
  # y-Achsen-Beschriftung:
  ylab = "Häufigkeit",
  # Farben aus einer Farbpalette:
  col = rainbow(10),
  # Platz zwischen Balken minimieren:
  space = 0.1,
  # graue Umrandungen der Balken:
  border = "grey2",
  # Unterscheidlich dichte Schattierungen (statt Füllung) für die vier Balken:
  density = c(50, 75, 25, 50),
  # Richtung, in dem die Schattierung in den vier Balken verläuft
  angle = c(-45, 0, 45, 90),
  # Schriftausrichtung der Achsen horizontal:
  las=2,
  #y-Achse erweitern, sodass mehr Platz zum Titel bleibt:
  ylim = c(0,60))

jpeg("Befragung-fb23.jpg", width=20, height=10, units="cm", res=200)
barplot(
  table(fb23$wohnen),                               
  main = "Befragung Erstis im WS 23/24:\nAktuelle Wohnsituation", 
  ylab = "Häufigkeit",
  col = rainbow(10),
  space = 0.1,
  border = "grey2",
  density = c(50,75,25,50),
  angle = c(-45,0,45,90),
  las=2,
  ylim = c(0,60))
dev.off()
