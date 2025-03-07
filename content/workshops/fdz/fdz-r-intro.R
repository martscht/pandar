library(knitr)

3 + 4

3 + 4 # Addition

#### R als Taschenrechner ----

2 * 3 # Multiplikation
2 / 3 # Division
2 ^ 3 # Potenz

2 == 3 # ist gleich?
2 != 3 # ist ungleich?
2 < 3  # ist kleiner?

2 == 3 & 2 < 3 # ist gleich UND ist kleiner?
2 == 3 | 2 < 3 # ist gleich ODER ist kleiner?

## funktion(argument1, argument2, ...)

log(x = 2, base = 3)  # Logarithmus von 2 zur Basis 3

log(2, 3)           # keine Namen in korrekter Reihenfolge

log(base = 2, x = 3) # Reihenfolge vertauscht, aber Namen verwendet
log(3, 2)            # Reihenfolge vertauscht und keine Namen

log(x = 100) # Logarithmus von 100 zur Basis 10

args(log)   # Argumente der Funktion log

## help(log)   # Hilfe zur Funktion log

log(-1)

## log(base = 10)


num <- log(x = 2, base = 3)  # Erstellung eines Objekts

num_sqrt <- sqrt(num)   # Weiterverwendung des Objekts
num_sqrt                # Ausgabe des Ergebnisses 

vec <- c(3, 4, 1, 2)    # Erstellung eines Vektors

sqrt(log(x = 2, base = 3)) # Schachtelung von Funktionen

sum(3, 4, 1, 2) |> sqrt() # Schachtelung anhand der Pipe

3 |> sqrt() |> log(base = _, x = 2) # Schachtelung mit Platzhalter

## setwd("C:/Users/nehler/Documents/Workshop_FDZ")

save(num, file = "num.RData") # Speichern des Objekts

load("num.RData") # Laden des Objekts
