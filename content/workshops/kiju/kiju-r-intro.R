library(knitr)

#### Überschrift ----
# Kommentar

2 * 3 # Multiplikation
2 / 3 # Division
2 ^ 3 # Potenz

2 == 3 # ist gleich?
2 != 3 # ist ungleich?
2 < 3  # ist kleiner?

## funktion(argument1, argument2, ...)

log(x = 2, base = 3)
log(3, 2)
log(base = 3, x = 2)

## help(log)

num <- log(x = 2, base = 3)

num_sqrt <- sqrt(num)
num_sqrt

## # Installation Für Einladen SPSS Datensätze
## install.packages('haven', dependencies = TRUE)

library(haven)

## getwd()
## setwd("~/Pfad/zu/Ordner")

## rstudioapi::getActiveDocumentContext()$path |>
##   dirname() |>
##   setwd()

## data <- read_sav(file = "fb22_mod.sav")

data <- read_sav(file = "../../daten/fb22_mod.sav")

dim(data)
names(data)

data$extra

class(data$extra)

## data$grund
## class(data$grund)

data$grund[1:10]
class(data$grund)

data$geschl
class(data$geschl)

data$geschl_faktor <- factor(data$geschl,                                   # Ausgangsvariable
                             levels = c(1, 2, 3),                           # Faktorstufen
                             labels = c("weiblich", "männlich", "anderes")) # Label für Faktorstufen


data$geschl_faktor
class(data$geschl_faktor)

data[1:5,]
data[,1:3]
data[,c("prok1", "prok2", "prok3")]

data[data$geschl_faktor == "weiblich" | data$geschl_faktor == "männlich",]

table(data$geschl_faktor)   # Häufigkeiten
mean(data$extra)            # Mittelwert
cor(data$prok1, data$prok2) # Korrelation

data$nr_ges <- rowMeans(data[,c("nr1", "nr2", "nr3", "nr4", "nr5", "nr6")])

class(data$wohnen)

data$wohnen_faktor <- factor(data$wohnen,                                   
                             levels = c(1, 2, 3, 4),                                
                             labels = c("WG", "bei Eltern", "alleine", "sonstiges")) 

str(data$wohnen_faktor)

data_WG <- subset(data, 
                  subset = wohnen_faktor == "WG"
                  )

data$prok <- rowMeans(data[,c("prok1", "prok4", "prok6", "prok9", "prok10")])

mean(data$prok)
min(data$prok)
max(data$prok)
