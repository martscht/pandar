# Vektoren ----

## Flanker Test ----

# Reaktionszeiten als numerischen Vektor
reaction <- c(600, 520, 540, 680, 560, 590, 620, 630)

# Vektor Klasse anzeigen
class(reaction) 

# Vektor Struktur
str(reaction) 

# flankierenden Zeichen erstellen
flankers <- c("<","<",">","<",">",">",">","<")

# Vektor Klasse anzeigen
is.character(flankers) 

# Vektor Umwandlung
reaction_as_char <- as.character(reaction)
reaction_as_char

flankers_as_numeric <- as.numeric(flankers)

#  Zielzeichen erstellen
target <- c(">", ">", ">", "<", "<", "<", ">", ">")

# Vergleich von Vektoren (Kongruenz)
cong <- flankers == target 

cong #logischer Vektor

is.logical(cong) 

# Faktorisierung
flankers_factorial <- as.factor(flankers) 

str(flankers_factorial) 

levels(flankers_factorial) 

# Relevel
releveled_flankers_factorial <- relevel(flankers_factorial, '>') 
releveled_flankers_factorial 

numeric_from_flankers <- as.numeric(flankers_factorial) 
numeric_from_flankers 

char_from_flankers <- as.character(flankers_factorial) 
char_from_flankers 

# Funktionen ----

(34+47+23+90+23+45+89+98)/8
mean(c(34,47,23,90,23,45,89,98))

# Objekte ----

Mittelwert <- mean(c(34,47,23,90,23,45,89,98))
Mittelwert # oder auch: print(Mittelwert)

x <- c(100, 20, 24, 89, 40)
mean(x) == Mittelwert  # prüft, ob der Mittelwert von x gleich dem Objekte "Mittelwert" ist

# Pipe ----

# Beispiel mit Verschachtelung
var(c(89,48,38,29,39,49,54))

# Beispiel Pipe
c(89,48,38,29,39,49,54) |> var()

# Berechnung der Standardabweichung aus Varianz heraus
c(89, 48, 38, 29, 39, 49, 54) |> var() |> sqrt()


# Environment ----

ls()

rm(Mittelwert)
ls()             # Environment ohne Mittelwert erscheint.

rm(list = ls())  # Enviroment vollständig leeren
ls()

# Arithmetische und Logische Operatoren ----

# Addition
1 + 2
# Subtraktion
1 - 2
# Multiplikation
1 * 2
# Division
(1 + 4) / (2 + 8)
# Potenz
2 ^ 3

# Logische Abfragen
1 == 2 # Ist gleich
1 != 2 # Ist ungleich
1 < 2 # Ist kleiner als
1 > 2 # Ist größer als
1 <= 2 # Ist kleiner/gleich
1 >= 2 # Ist größer/gleich
!(1 == 2) # Ist Klammerinhalt NICHT gleich?


# Messages, Warnings und Errors ----

# Warning
log(-1)

# Error
x <- numeric(0)  # Ein leerer Vektor für x
y <- numeric(0)  # Ein leerer Vektor für y

#lm(y ~ x)  # Versucht eine lineare Regression durchzuführen


# Datentypen ----

## Matrix ----

# Erstellen von 2 Vektoren des gleichen Typs
age1 <- c(30,71,33,28,19)
age2 <- c(98,4,67,43,21)
matrix1 <- cbind(age1, age2)
matrix2 <- rbind(age1, age2)
matrix3 <- matrix(data= c(age1, age2), ncol=2, byrow=TRUE)

matrix1 # die Vektoren werden als columns angeordnet
matrix2 # die Vektoren werden als rows angeordnet
matrix3 # design wird durch Argumente ncol, nrow und byrow im Matrix-Befehl bestimmt

job <- c("Pfegefachkraft", "Elektroniker","Grundschullehrer","Rettungssanitäter","Redakteur")
burnout <- c(TRUE,FALSE,FALSE,FALSE,TRUE)

matrix4 <- cbind(age1,job,burnout)

# Alle 3 Vektoren nun char, also keine mathematischen Berechnungen nun mehr möglich
matrix4


## Data.Frame ----

df1 <- data.frame(age1,job,burnout)
df1
##Listet Variablen und Typ auf
str(df1)


# Indizieren ----

# Zugriff auf den 4. Eintrag der Spalte age1
df1[4, 'age1'] 

# Der vierte Eintrag der Spalte 'age1' auf 20 setzen (verändert Ursprungsdateb)
df1[4, 'age1'] <- 20 

# Ganze Spalte 'age1' anzeigen, um die Änderung zu sehen
df1[,'age1'] 

# Erstellen einer neuen Spalte 'no_burnout', die das Gegenteil der Spalte 'burnout' darstellt - über die Sinnhaftigkeit machen wir uns hier mal lieber keine Gedanken
df1$no_burnout <- !df1$burnout


# Hinzufügen einer sechsten Zeile (Änderung am Datensatz)
df1[6,] <- data.frame(
  age1 = 42, 
  job = "Friseur", 
  burnout = TRUE, 
  no_burnout = TRUE)

# Entfernen dieser eben geschaffenen sechsten Zeile
df1 <- df1[-6,]
# Zugriff auf die 5. Zeile und die 4. Spalte (ohne Extraktion)
df1[5, 4]

# Zugriff auf die gesamte 1. Zeile
df1[1, ]

# Zugriff auf die 1. Spalte
df1[, 1]

# Zugriff auf die 2. und 3. Zeile, 3. Spalte
df1[c(2, 3), 3]

# Zugriff auf alle Zeilen, in denen 'burnout' TRUE ist
df1[df1$burnout, ]


# Datenextraktion ----

# age1 ausgeben lassen
str(age1)

# das 5.Element von age1 ausgeben lassen- jedoch nicht verändern
age1[5]

# age1 ohne Element 5 ausgeben lassen
age1[-5]

# sich eine Auswahl ausgeben lassen
auswahl <- c(1, 3, 5)
age1[auswahl]

# Auswahl in neuem Objekt abspeichern
age_select<-age1[auswahl]

# verschachtelt eine Auswahl ausgeben lassen
age1[c(1, 3, 5)]

!(df1$burnout)
# Abrufen der Job-Bezeichnungen für die Personen, die einen Burnout haben (TRUE)
df1$job[df1$burnout]

# Abrufen der Job-Bezeichnungen für Personen ohne Burnout (FALSE)
df1$job[!df1$burnout]

# Auch dies kann wieder in Objekte abgelegt werden
job_nburn <- df1$job[!df1$burnout]

# 5. Zeile, 4. Spalte ausgeben lassen
df1[5, 4]

df1[1, ]          # 1. Zeile, alle Spalten
df1[, 1]          # Alle Zeilen, 1. Spalte

df1[c(2, 3), 3]   # 2. und 3. Zeile, 3. Spalte
df1[burnout, ]    # Alle kongruenten Zeilen, alle Spalten

nrow(df1)    # Anzahl der Zeilen
ncol(df1)    # Anzahl der Spalten
dim(df1)     # Alle Dimensionen

names(df1)   # Namen der Variablen

df1[, 'age1']                # Einzelne Variable auswählen
df1[, c('age1', 'burnout')]  # Mehrere Variable auswählen


df1$age1                     # eine Variable indizieren


# Daten Import und Export ----

getwd()

dir()

save(df1, file = 'df1.rda')

rm(list = ls())
ls()

load('df1.rda')
ls()

saveRDS(df1, 'df1.rds')
rm(list = ls())
ls()

work <- readRDS('df1.rds')
work

## Dateninspektion ----

nrow(work)    # Anzahl der Zeilen
ncol(work)    # Anzahl der Spalten
dim(work)     # Alle Dimensionen
names(work)   # Namen der Variablen

## CSV Datei einlesen ----

osf <- read.csv(file = url("https://osf.io/zc8ut/download"))

# riesiger Datensatz, wir wollen nur 6 Variablen
osf <- osf[, c("ID", "group", "stratum", "bsi_post", "swls_post", "pas_post")]

# Datenhandling ----

load(url('https://pandar.netlify.app/daten/edu_exp.rda'))

str(edu_exp$Year)

# Verwende cut() um die Jahre in Kategorien einzuteilen
edu_exp$Decade <- cut(edu_exp$Year, 
                      breaks = c(1990, 2000, 2010, 2020), 
                      labels = c("90s", "2000s", "2010s"),
                      right = FALSE)

str(edu_exp$Decade)

# NA's ----

mean(edu_exp$Primary)

# Unterschiedliche Möglichkeiten NA's abzufragen
is.na(edu_exp)          # gibt TRUE/FALSE für jede einzelne Zelle aus
anyNA(edu_exp)          # gibt es mindestens ein NA?
sum(is.na(edu_exp))     # wieviele NA's gibt es insgesamt im Datensatz?
complete.cases(edu_exp) # Welche Zeilen sind vollständig?

# Zeigt die Anzahl fehlender Werte pro Spalte an
colSums(is.na(edu_exp))

# Entfernt alle Zeilen, die NAs enthalten
edu_exp_clean1 <- na.omit(edu_exp)
dim(edu_exp_clean1)

# Nur Zeilen mit fehlenden Werten in einer bestimmten Spalte entfernen:
edu_exp_clean2 <- edu_exp[!is.na(edu_exp$Expectancy), ]
str(edu_exp_clean2) #behält mehr observations bei


# Subsets ----

# Subset von Pbn aus Ländern mit mehr als 10 Mio einwohnern
edu_exp_subset <- edu_exp[edu_exp$Population > 10000000, ]

# Ergebnis anzeigen
edu_exp_subset

# mehr als 10 mio UND EUROPA
edu_exp_subset2 <- edu_exp[edu_exp$Population > 10000000 & edu_exp$Region == "europe", ]
edu_exp_subset2

# Pakete ----

#install.packages("psych")
library(psych)


# Einfache Deskriptivstatistik ----

# Häufigkeitstabellen
table(edu_exp$Wealth)

table(edu_exp$Wealth) |> prop.table()

table(edu_exp$Wealth) |> which.max()

edu_2003 <- subset(edu_exp, subset = Year == 2003)

# Median
median(edu_2003$Population)

# IQB
quantile(edu_2003$Population,
         c(0.25, 0.5, 0.75))

# Mittelwert
mean(edu_2003$Population)

# Varianz und Standardabweichung
var(edu_2003$Population)
sd(edu_2003$Population)