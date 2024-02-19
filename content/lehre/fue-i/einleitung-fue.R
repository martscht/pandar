knitr::opts_chunk$set(echo = TRUE, fig.align = "center")

## load("C:/Users/Musterfrau/Desktop/Schulleistungen.rda")

load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))

head(Schulleistungen)

# Namen der Variablen abfragen
names(Schulleistungen)

# Anzahl der Zeilen
nrow(Schulleistungen)
# Anzahl der Spalten
ncol(Schulleistungen)

# Anzahl der Zeilen und Spalten kombiniert
dim(Schulleistungen)

# Struktur des Datensatzes - Informationen zu Variablentypen
str(Schulleistungen)

Schulleistungen$IQ

# Summe
sum(Schulleistungen$IQ)

# Mittelwert
mean(Schulleistungen$IQ)
1/100*sum(Schulleistungen$IQ) # auch der Mittelwert

# Varianz
var(Schulleistungen$IQ)

# SD
sd(Schulleistungen$IQ)
sqrt(var(Schulleistungen$IQ)) # die Wurzel aus der Varianz ist die SD, hier: sqrt() ist die Wurzel Funktion

summary(Schulleistungen$IQ)

colMeans(Schulleistungen)
