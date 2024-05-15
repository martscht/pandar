## install.packages('ggplot2')
## library(ggplot2)

## setwd('...') # statt '...' einen Ordner-Pfad festlegen

a <- read.table('multiTimeline.csv', header = TRUE, sep= ',')
b <- read.table('multiTimeline(1).csv', header = TRUE, sep = ',')

head(a)
head(b)

## Datensatz <- cbind("Datensatz_A","Datensatz_B")

## class(Variablenname)

names(a)
names(b)

b <- b[, -c(1, 2)]
names(b)

c <- cbind(a, b)

str(c)

# Daten einlesen
a <- read.table('multiTimeline.csv',header = T, sep= ',' , na = '<1')
b <- read.table('multiTimeline(1).csv', header = T , sep = ',' , na = '<1')

# Daten zusammenführen
b <- b[, -c(1, 2)]
c <- cbind(a, b)

# Struktur untersuchen
str(c)

c[is.na(c)] <- 0

names(c)
names(c) <- c('Monat', 'AfD', 'SPD', 'FDP', 'DieGrüne', 'DieLinke', 'Tierschutzpartei', 'CDU', 'MLPD', 'NPD')

## langer_Datensatz <- reshape(Datensatz, varying = ...,
##                             v.names = ..., timevar = ...,
##                             idvar = ..., times = ...,
##                             direction = "long")

## ggplot(data = Datensatz)

## ggplot(data = Datensatz, mapping = aes(x = ..., y = ..., group = ...))

## geom_line(aes(colour = ...))

library(ggplot2)

c_long <- reshape(c,      # Ausgansdaten
  varying =  c('AfD', 'SPD', 'FDP', 'DieGrüne', 'DieLinke', 'Tierschutzpartei', 'CDU', 'MLPD', 'NPD'),
                          # alle Variablen, die hinterher eine einzige Variable sein sollen
  v.names = 'Prozent',    # Name der neuen Variable
  idvar = 'Monat',        # Variable, die über alle Parteien gleich bleibt
  timevar = 'Partei',     # Name der Variable, die verschiedene Gruppen unterscheidet
  times = c('AfD', 'SPD', 'FDP', 'DieGrüne', 'DieLinke', 'Tierschutzpartei', 'CDU', 'MLPD', 'NPD'),
                          # Kodierung der Parteien auf dieser Gruppierungsvariable
  direction = 'long')     # Richtung der Umwandlung

ggplot(data = c_long, aes(x = Monat, y = Prozent, group = Partei)) +
  geom_line(aes(colour = Partei)) +      # Liniendiagramm
  xlab('Zeitraum') +                     # Beschriftung x-Achse
  ylab('Anfragen (in % des Maximums)') + # Beschriftung y-Achse
  ggtitle('Suchanfragen')                # Überschrift

paste0('Ich will', ' Kuchen.')

class(c_long$Monat)

c_long$nMonat <- as.character(c_long$Monat)

c_long$nMonat <- paste0(c_long$nMonat, '-01')
head(c_long$nMonat)

c_long$nMonat <- strptime(c_long$nMonat,
  format="%Y-%m-%d")    # Format des Datums

class(c$nMonat)

c_long$nMonat <- as.POSIXct(c_long$nMonat)

ggplot(data = c_long, aes(x = nMonat, y = Prozent, group = Partei)) +
  geom_line(aes(colour = Partei)) +      # Liniendiagramm
  xlab('Zeitraum') +                     # Beschriftung x-Achse
  ylab('Anfragen (in % des Maximums)') + # Beschriftung y-Achse
  ggtitle('Suchanfragen')                # Überschrift

wahl_2013 <- subset(c_long, subset = (nMonat < '2014-07-01' & nMonat > '2012-01-01'))

ggplot(data = wahl_2013, aes(x = nMonat, y = Prozent, group = Partei)) +
  geom_line(aes(colour = Partei)) +      # Liniendiagramm
  xlab('Zeitraum') +                     # Beschriftung x-Achse
  ylab('Anfragen (in % des Maximums)') + # Beschriftung y-Achse
  ggtitle('Suchanfragen')                # Überschrift

farben <- c('AfD' = 'deepskyblue', 'CDU' = 'black', 'DieGrüne' = 'green3',
            'DieLinke' = 'magenta', 'FDP' = 'gold', 'MLPD' = 'orange',
            'NPD' = 'brown', 'SPD' = 'red', 'Tierschutzpartei' = 'darkblue')

ggplot(data = wahl_2013, aes(x = nMonat, y = Prozent, group = Partei)) +
  geom_line(aes(colour = Partei)) +      # Liniendiagramm
  xlab('Zeitraum') +                     # Beschriftung x-Achse
  ylab('Anfragen (in % des Maximums)') + # Beschriftung y-Achse
  ggtitle('Suchanfragen') +              # Überschrift
  scale_color_manual(values = farben)
