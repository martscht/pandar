knitr::opts_chunk$set(error = TRUE)
# knitr::knit_hooks$set(purl = knitr::hook_purl)

3 + 4

#### R als Taschenrechner ----

3 + 4   # Addition
3 - 4   # Subtraktion
3 * 4   # Multiplikation
3 / 4   # Division
3 ^ 4   # Potenz

#### Logische Abfragen ----

3 == 4   # Ist gleich?
3 != 4   # Ist ungleich?
3 > 4    # Ist größer?
3 < 4    # Ist kleiner?
3 >= 4   # Ist größer/gleich?
3 <= 4   # Ist kleiner/gleich?

!(3 == 4)

3 + 4 + 1 + 2

sum(3, 4, 1, 2)

log(100)

log(100, 10)

log(x = 100, base = 10)

log(base = 10, x = 100)

args(log)

exp(1)

## help(log)

log(-1)

log(argument = 10)

my_num <- sum(3, 4, 1, 2)

my_num

sqrt(my_num)

sqrt(sum(3, 4, 1, 2))

sum(3, 4, 1, 2) |> sqrt()

sum(3, 4, 1, 2) |> sqrt() |> log()

sum(3, 4, 1, 2) |> sqrt() |> log(x = _)

my_root <- sqrt(my_num)

ls()

ls(pattern = 'num')

rm(my_num)
ls()

rm(list = ls())

my_num <- sum(3, 4, 1, 2) |> sqrt() |> log()
my_num

react <- c(510, 897, 647, 891, 925, 805, 443, 778)

class(react)

str(react)

color <- c('gruen', 'gelb', 'blau', 'gruen', 'gelb', 'blau', 'rot', 'rot')

is.character(color)

as.character(react)
as.numeric(color)

text <- c('gruen', 'blau', 'blau', 'rot', 'gelb', 'gruen', 'rot', 'gelb')

cong <- color == text
cong

is.logical(cong)

color_fac <- as.factor(color)
str(color_fac)

levels(color_fac)

relevel(color_fac, 'gruen')

as.numeric(color_fac)
as.character(color_fac)

ls()

class(color)
class(text)
class(color) == class(text)

mat <- cbind(color, text)
mat

class(mat)

is.array(mat)
is.data.frame(mat)
is.list(mat)

mat <- cbind(color, text, cong, react)
mat

dat <- data.frame(color, text, cong, react)
dat
str(dat)

three <- c(1, 2, 3)
data.frame(color, text, cong, react, three)

four <- c(three, 4)
data.frame(color, text, cong, react, four)

str(react)

react[5]

react[-5]

sel <- c(1, 3, 5)
react[sel]

react[c(1, 3, 5)]

react[cong]

react[!cong]

dat

dat[5, 4]

dat[1, ]   # 1. Zeile, alle Spalten
dat[, 1]   # Alle Zeilen, 1. Spalte

dat[c(2, 3), 3]   # 2. und 3. Zeile, 3. Spalte
dat[cong, ]       # Alle kongruenten Zeilen, alle Spalten

nrow(dat)    # Anzahl der Zeilen
ncol(dat)    # Anzahl der Spalten
dim(dat)     # Alle Dimensionen

names(dat)

dat[, 'react']                # Einzelne Variable auswählen
dat[, c('react', 'cong')]     # Mehrere Variable auswählen

dat$react

dat[5, 'react']           # Aktuellen Inhalt abfragen
dat[5, 'react'] <- 725    # Aktuellen Inhalt überschreiben
dat[, 'react']            # Alle Reaktionszeiten abfragen

dat$incong <- !dat$cong
dat

dat[9, ] <- c('gelb', 'gruen', FALSE, 824, TRUE)
dat

dat <- dat[-9, ]    # Datensatz ohne die 9. Zeile
dat

## getwd()

## setwd('Pfad/Zum/Ordner')

## dir()

save(dat, file = 'dat.rda')

rm(list = ls())
ls()

load('dat.rda')
ls()

saveRDS(dat, 'dat.rds')
rm(list = ls())
ls()

stroop <- readRDS('dat.rds')
stroop

cat(paste(readLines('fb22.csv')[1:5], collapse = '\n'))

args(read.table)

fb22 <- read.table('fb22.csv')

fb22 <- read.table('fb22.csv', header = TRUE)

fb22 <- read.table('fb22.csv', header = TRUE, sep = ",")

head(fb22)    # Kopfzeilen
str(fb22)     # Struktur des Datensatzes

fb22 <- read.table('https://pandar.netlify.app/daten/fb22.csv', header = TRUE, sep = ",")

write.table(fb22,     # zu speichernder Datensatz
  'fb22.txt'          # Dateiname
  )

cat(paste(readLines('fb22.txt')[1:5], collapse = '\n'))
