library(knitr)
data <- data.frame(
  Einstellung = c("Font Size", "Theme", "Rainbow Parentheses", "Indentation Guidelines"),
  Änderung = c("Tools>Global Options>Appearance>Font Size","Tools>Global Options>Appearance>Theme", "Tools>Global Options>Code>Display>Syntax>Use Rainbow Parentheses", "Tools>Global Options>Code>Display>General>Indentation Guidelines"),
  Beschreibung = c("Anpassen der Schriftgröße", "Themes beeinflussen Hintergrund- und Schriftfarbe.Idealerweise sollte ein Theme gewählt werden, welches hilft, den Syntax besser zu überblicken.", "Zusammengehörige Klammern erhalten dieselbe Farbe. Hilft bei der Übersichtlichkeit.", "Die eingerückte Fläche wird farbig markiert. Hilft beim Überblick.")
)
kable(data)

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

library(knitr)
data4 <- data.frame(
  Typ = c("logical", "numeric", "character", "integer"),
  Kurzform = c("logi","num", "char", "int"),
  Inhalt = c("wahr (TRUE) oder falsch (FALSE)", "Beliebige Zahlen", "Kombinationen aus Zahlen und Buchstaben", "ganze Zahlen"),
  Beispiel = c("TRUE, FALSE", "10.5, -5, 0", "\"Hallo Welt\", \"A1B2\"", "1L, -5L, 0L")
)

kable(data4)

(34+47+23+90+23+45+89+98)/8
mean(c(34,47,23,90,23,45,89,98))

# funktion(argument1, argument2, argument3, ...)
# Beispiele:
# mean(x = c(10, 20, 30), trim = 0.1)
# data.frame(spalte1, spalte2, spalte3, ...)

library(knitr)
data3 <- data.frame(
  Beschreibung = c("Funktionen schachteln", "Objekt im Environment anlegen", "Ergebnis-Pipe"),
  `Code-Stil` = c("funktion1(funktion2(argument))", "objekt <- funktion1(argument)", "funktion1(argument) |> funktion2()"),
  Beispiel = c(
    "round(mean(c(1.1, 1.9, 2.5)))",
    "mittelwert <- mean(c(1, 2, 3, 4))",
    "c(1, 2, 3, 4) |> mean()"
  )
)
kable(data3)

Mittelwert <- mean(c(34,47,23,90,23,45,89,98))
Mittelwert # oder auch: print(Mittelwert)

x <- c(100, 20, 24, 89, 40)
mean(x) == Mittelwert  # prüft, ob der Mittelwert von x gleich dem Objekte "Mittelwert" ist


# Beispiel mit Verschachtelung
var(c(89,48,38,29,39,49,54))

# Beispiel Pipe
c(89,48,38,29,39,49,54) |> var()


# Berechnung der Standardabweichung aus Varianz heraus
c(89, 48, 38, 29, 39, 49, 54) |> var() |> sqrt()

ls()

rm(Mittelwert)
ls()             # Environment ohne Mittelwert erscheint.

rm(list = ls())  # Enviroment vollständig leeren
ls()

# install.packages('psych')
message('Installiere Paket nach ‘C:/Users/Acer/AppData/Local/R/win-library/4.5’
(da ‘lib’ nicht spezifiziert)')
message('Hallo ich bin eine Nachricht. Ich benachrichtige dich über irgendwas, was grad abgeht.')

log(-2)
mean(c("a","b","x","y"))
warning('Ich bin eine Warnmeldung. Über mir steht Warnmeldung und ich weise dich auf etwas hin, was ich mache, was aber vielleicht nicht so von dir gewollt ist.')


try({

2+'a'
lm(NA~NA)
stop('Ich bin ein Fehler. Vor mir steht Fehler und irgendwas ist so falsch, dass ich den Code nicht sinnvoll ausführen kann oder das was du von mir verlangst ist unmöglich. Mich solltest du definitiv beachten und dich um mich kümmern! (Bitte 🥺)')


})

library(knitr)
data2 <- data.frame(
  Abschnitt = c("Description", "Usage", "Arguments", "Details", "Values","See also", "Examples"),
  Inhalt = c("Beschreibung der Funktion","Zeigt die Argumente an, die die Funktion entgegennimmt. Argumente auf die ein = folgt haben Standardeinstellungen und müssen nicht jedes mal aufs Neue definiert werden, Argumente ohne = jedoch schon.", "Liste der Argumente mit Beschreibung", "Zusatzinformationen zur Funktion","Übersicht über die möglichen Ergebnisinhalte der Funktion", "Ähnliche Funktionen", "Praxisbeispiel, Funktion wird angewendet")
)
kable(data2)

knitr::opts_chunk$set(echo = TRUE)
library(ggplot2)
library(gridExtra)


# Plot 1: Flanker Test - Target unterstrichen
stimulus1 <- data.frame(
  position = -2:2,
  symbol = c(">", ">", ">", ">", ">")
)

plot1 <- ggplot(stimulus1, aes(x = position, y = 0, label = symbol)) +
  geom_text(size = 10) +
  annotate("segment", x = 0.5, xend = -0.5, y = -0.2, yend = -0.2, color = "black", size = 1) +
  theme_void() +
  xlim(-3, 3) +
  ylim(-1, 1) +
  ggtitle("Flanker Test: Target unterstrichen") +
  theme(plot.background = element_rect(color = "black", size = 1))  # Schwarzer Rahmen

# Plot 2: Flanker Test - Incongruent Stimulus
stimulus2 <- data.frame(
  position = -2:2,
  symbol = c(">", ">", "<", ">", ">")
)

plot2 <- ggplot(stimulus2, aes(x = position, y = 0, label = symbol)) +
  geom_text(size = 10) +
  theme_void() +
  xlim(-3, 3) +
  ylim(-1, 1) +
  ggtitle("Flanker Test: Incongruent Stimulus") +
  theme(plot.background = element_rect(color = "black", size = 1))  # Schwarzer Rahmen

# Plot 3: Flanker Test - Congruent Stimulus
stimulus3 <- data.frame(
  position = -2:2,
  symbol = c(">", ">", ">", ">", ">")
)

plot3 <- ggplot(stimulus3, aes(x = position, y = 0, label = symbol)) +
  geom_text(size = 10) +
  theme_void() +
  xlim(-3, 3) +
  ylim(-1, 1) +
  ggtitle("Congruent Flanker Test Stimulus") +
  theme(plot.background = element_rect(color = "black", size = 1))  # Schwarzer Rahmen

# Alle drei Plots nebeneinander darstellen
grid.arrange(plot1, plot2, plot3, ncol = 3)

# Reaktionszeiten als numerischen Vektor
reaction <- c(600, 520, 540, 680, 560, 590, 620, 630) 

# Vektor Klasse anzeigen
class(reaction) 

str(reaction) 

flankers <- c("<","<",">","<",">",">",">","<")

is.character(flankers) 

reaction_as_char <- as.character(reaction)
reaction_as_char

flankers_as_numeric <- as.numeric(flankers) 


#  Zielzeichen erstellen
target <- c(">", ">", ">", "<", "<", "<", ">", ">")
# Vergleich von Vektoren (Kongruenz)

cong <- flankers == target 

cong #logischer Vektor

is.logical(cong) 

flankers_factorial <- as.factor(flankers) 
#  Ausgabe des Factors
str(flankers_factorial) 

levels(flankers_factorial) 

releveled_flankers_factorial <- relevel(flankers_factorial, '>') 
releveled_flankers_factorial 

numeric_from_flankers <- as.numeric(flankers_factorial) 
numeric_from_flankers 

char_from_flankers <- as.character(flankers_factorial) 
char_from_flankers 

library(knitr)
data5 <- data.frame(
  Typ = c("Matrix", "Array", "Data.Frame", "List"),
  Dimensionen = c("2","n", "2", "1"),
  Zusammensetzung = c("Vektoren des gleichen Typs", "Vektoren des gleichen Typs", "Vektoren der gleichen Länge", "Beliebige Objekte"),
  Anmerkungen = c("Bietet sich v.a. für große Datensätze an. Ist eine Sonderform des Arrays.", "-", "Häufigst genutzte Variante in der Psychologie. Ist eine Sonderform der List", "-")
)
kable(data5)

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

df1 <- data.frame(age1,job,burnout)
df1
##Listet Variablen und Typ auf
str(df1)

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


getwd()

# setwd('Pfad/Zum/Ordner')

# dir()

library(knitr)
data6 <- data.frame(
  Dateiformat = c("RDA", "RDS", "Klartextformate", "CSV"),
  Dateiendung = c(".rda", ".rds", ".txt oder .dat", ".csv"),
                  Speichern = c("save()", "saveRDS()", "write.table()", "write.csv()"),
                  Laden = c("load()","readRDS()", "read.table()", "read.csv()"),
                  Einsatzort = c("gemeinsames Speichern mehrerer Objekte", "Speichern einzelner Objekte (z.B. Datensätze)","Textbasierte Speicherung und Laden", "Tabellendaten im CSV-Format")
)
kable(data6)

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

nrow(work)    # Anzahl der Zeilen
ncol(work)    # Anzahl der Spalten
dim(work)     # Alle Dimensionen
names(work)   # Namen der Variablen

# 
# install.packages("psych")
# library(psych)
# 


library(readxl)
workshopfb<-read_excel( 
  path = "../../daten/pretest.xlsx",
  sheet = 1, # Läd das erste Arbeitsblatt. Ändere dies, falls nötig.
  col_names = TRUE # Geht davon aus, dass die erste Zeile die Variablennamen enthält
)

library(dplyr) 
workshopfb <- workshopfb %>% select(-REF,
                          -MODE,
                          -SERIAL,
                          -QUESTNNR,
                          -TIME_RSI,
                          -STARTED,
                          -MAILSENT,
                          -LASTDATA,
                          -STATUS,
                          -FINISHED,
                          -Q_VIEWER,
                          -LASTPAGE,
                          -MAXPAGE,
                          -TIME001,
                          -TIME002,
                          -TIME003,
                          -TIME004,
                          -TIME005,
                          -TIME006,
                          -MISSING,
                          -MISSREL,
                          -TIME_SUM,
                          -T002,##Alter: kann nur ja sein
                          -T003)##Einverständnis: kann nur ja sein


# Stellen Sie sicher, dass das dplyr-Paket geladen ist
library(dplyr) 

workshopfb <- workshopfb%>%
  rename(
    auge = F001,
    rumination = F011_01,
    worry = F011_02,
    belastungt1 = F011_03,
    belastungt2 = F011_04,
    kompetenz = F011_05,
    hartnäckigkeit = F011_06,
    nerd = F004_01,
    intelligenz = F004_02,
    extraversion = F004_03,
    narz = F004_04,
    mach = F004_05,
    psycho = F004_06,
    ffm = F002_01,         
    spick = F002_02,       
    intoleranz = F002_03,  
    allergie = F002_04,    
    heimat = F003_01,      
    akku = F013_01,
    highscore = F014_01,
    entscheidung = F012,     
    dioptrien_links = F006_01,
    dioptrien_rechts = F006_02
  )

# Ausgabe der neuen Spaltennamen zur Überprüfung:
names(workshopfb)

str(workshopfb$heimat)

workshopfb <- workshopfb %>%
  mutate(across(everything(), ~as.numeric(trimws(.))))
str(workshopfb)


#Faktoren und numerical erstellen aus den dichotomen Variablen
workshopfb <- workshopfb %>%
  mutate(
    ffm_num = ifelse(ffm == 1, 1, ifelse(ffm == 2, 0, NA)),
    ffm_fac = factor(ffm_num, levels = c(0, 1), labels = c("Nein", "Ja")),
    
    spick_num = ifelse(spick == 1, 1, ifelse(spick == 2, 0, NA)),
    spick_fac = factor(spick_num, levels = c(0, 1), labels = c("Nein", "Ja")),
    
    intoleranz_num = ifelse(intoleranz == 1, 1, ifelse(intoleranz == 2, 0, NA)),
    intoleranz_fac = factor(intoleranz_num, levels = c(0, 1), labels = c("Nein", "Ja")),
    
    allergie_num = ifelse(allergie == 1, 1, ifelse(allergie == 2, 0, NA)),
    allergie_fac = factor(allergie_num, levels = c(0, 1), labels = c("Nein", "Ja"))
  )

# Die Variable 'entscheidung' in einen Faktor umwandeln
workshopfb$entscheidung <- factor(
  case_when(
    workshopfb$entscheidung == 1 ~ "Intuition und Bauchgefühl",
    workshopfb$entscheidung == 2 ~ "Logik, Analyse und Abwägen von Fakten",
    workshopfb$entscheidung == -1 ~ "ChatGPT",
    workshopfb$entscheidung == -9 ~ NA_character_
  ),
  levels = c(
    "Intuition und Bauchgefühl",
    "Logik, Analyse und Abwägen von Fakten",
    "ChatGPT"
  )
)
str(workshopfb$entscheidung)
table(workshopfb$entscheidung, useNA = "ifany") 


range(workshopfb$akku, na.rm=T)

workshopfb$nerd <- workshopfb$nerd - 1
workshopfb$intelligenz <- workshopfb$intelligenz - 1
workshopfb$worry <- workshopfb$worry - 1
workshopfb$rumination <- workshopfb$rumination - 1
workshopfb$mach <- workshopfb$mach - 1
workshopfb$narz <- workshopfb$narz - 1
workshopfb$psycho<- workshopfb$psycho - 1
workshopfb$extraversion<- workshopfb$extraversion - 1
workshopfb$belastungt1<- workshopfb$belastungt1 - 1
workshopfb$belastungt2<- workshopfb$belastungt2 - 1
workshopfb$hartnäckigkeit<- workshopfb$hartnäckigkeit - 1
workshopfb$kompetenz<- workshopfb$kompetenz - 1

# workshopfb$auge <- factor(workshopfb$auge,
#                         levels = c("braun", "blau", "grün", "andere"),
#                         labels = c("braun", "blau", "grün", "andere")

##allen sagen, dass sie bei Legalisierung gar nicht antworten sollen wenn es 0 gramm sind
# gibt NA zurück
mean(workshopfb$dioptrien_rechts)

# Lade das knitr-Paket
library(knitr)

# Erstelle den Data Frame
data8 <- data.frame(
  Ebene = c("global(Datensatz)", "lokal(Variable)"),
  Funktion = c("na.omit", "na.rm = TRUE"),
  Beschreibung = c(
    "Entfernt jede Beobachtung, die mind. ein NA enthält.",
    "Das Argument na.rm ist in vielen Funktionen für univariate Statistiken enthalten. Per Voreinstellung wird NA als Ergebnis produziert, wenn fehlende Werte vorliegen. Fehlende Werte werden nur für diese eine Analyse ausgeschlossen, wenn sie auf der darin untersuchten Variable keinen Wert haben - Datensatz bleibt erhalten."
  ),
  Beispiel = c(
    "Jeder Proband, der mind. eine Frage nicht beantwortet, wird ausgeschlossen.",
    "Beispiel: Ein Proband hat zwar seine Dioptrien nicht angegeben, wird aber dennoch bei der Korrelation zwischen Nerdiness und Intoleranz mit einbezogen."
  ),
  stringsAsFactors = FALSE  # Setze dies, um sicherzustellen, dass Zeichenfolgen nicht automatisch in Faktoren umgewandelt werden.
)

# Zeige den Data Frame als Tabelle an
kable(data8)

# # Unterschiedliche Möglichkeiten NA's abzufragen
# is.na(workshopfb)          # gibt TRUE/FALSE für jede einzelne Zelle aus
# anyNA(workshopfb)          # gibt es mindestens ein NA?
# sum(is.na(workshopfb))     # wieviele NA's gibt es insgesamt im Datensatz?
# complete.cases(workshopfb) # Welche Zeilen sind vollständig?

# Zeigt die Anzahl fehlender Werte pro Spalte an
colSums(is.na(workshopfb))

# Entfernt alle Zeilen, die NAs enthalten
workshopfb_clean1 <- na.omit(workshopfb)
dim(workshopfb_clean1)

# Nur Zeilen mit fehlenden Werten in einer bestimmten Spalte entfernen:
workshopfb_clean2 <- workshopfb[!is.na(workshopfb$dioptrien_links), ]
dim(workshopfb_clean2) # behält mehr observations bei

# Subset von XX
workshopfb_subset <- workshopfb[workshopfb$ffm == 1, ]

# Ergebnis anzeigen
workshopfb_subset

# mehr als 50 narz mio UND FFM
workshopfb_subset2 <- workshopfb[workshopfb$narz> 49 & workshopfb$ffm == 1, ]
workshopfb_subset2

table(workshopfb$auge)

table(workshopfb$auge) |> prop.table()

table(workshopfb$auge)

table(workshopfb$auge) |> which.max()

workshopfb_no_into <- subset(workshopfb, subset = intoleranz == 1)

median(workshopfb_no_into$akku)

workshopfb_no_into$akku <- as.numeric(workshopfb_no_into$akku)
quantile((workshopfb_no_into$akku),
         c(0.25, 0.5, 0.75),
         na.rm = TRUE)

mean(workshopfb_no_into$akku)

var(workshopfb_no_into$akku)
sd(workshopfb_no_into$akku)

# Speichert das Data Frame "workshopfb" in einer Datei
# Der Dateiname sollte den Stand und das Datum widerspiegeln.
saveRDS(workshopfb, file = "workshopfb_bereinigt_2025-10-07.rds")

# Optional: Kurzer Check, ob die Datei existiert
list.files(pattern = ".rds")
