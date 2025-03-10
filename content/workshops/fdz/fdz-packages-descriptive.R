## #### Datensatz einlesen (vorbereiten) ----
## # Installation eines Paketes Für Einladen Excel Dateien
## install.packages('readxl')

library(readxl) # Paket aktivieren

## # Working Directory auf den Ort setzen, an dem das Skript abgespeichert ist
## rstudioapi::getActiveDocumentContext()$path |>
##   dirname() |>
##   setwd()

## # Aus einer Excel Datei ein Worksheet einlesen
## data <- read_excel("Pennington_2021.xlsx", sheet = "Study 1 Year 7 Data")

# Daten anhand vorbereitetem Skript aus dem OSF einlesen
source("https://pandar.netlify.app/workshops/fdz/fdz_data_prep.R")

#### Arbeit mit Datensatz ----
##### Übersicht über den Datensatz -----
dim(data)      # Anzahl Zeilen und Spalten
names(data)    # Spaltennamen

data$Year  # spezifische Spalte anzeigen lassen

class(data$Year)   # Typ der Variable anzeigen lassen

class(data$Total_Competence_Maths)   # Typ der Variable anzeigen lassen

data[3,]    # fünfte Zeile anzeigen lassen
data[,1]    # erste Spalte anzeigen lassen

data[ , "Year"]    # Spalte Year anzeigen lassen

## install.packages('dplyr') # Installation des Pakets

library(dplyr)   # Laden des Pakets

data %>% select(Year)   # dplyr Funktion zur Auswahl einer Spalte (Year)

data %>% slice(3)   # dplyr Funktion zur Auswahl der dritten Zeile

#### Deskriptivstatistiken ----
##### Faktoren am Beispiel absolute Häufigkeiten -----
table(data$Gender)   # Absolute Häufigkeiten

# Faktor erstellen für das Geschlecht
data$Gender <- factor(data$Gender, 
                         levels = c(1, 2),
                         labels = c("weiblich", "männlich"))

class(data$Gender)   # Typ der Variable anzeigen lassen

table(data$Gender)   # Absolute Häufigkeiten für den Faktor

table(data$Year)   # Absolute Häufigkeiten für die Klassenstufen

data$Year <- as.factor(data$Year)  # Umwandlung in Faktor
class(data$Year)                   # Typ der Variable anzeigen lassen

## install.packages('forcats') # Installation des Pakets

library(forcats)            # Laden des Pakets

# Faktorstufen umbenennen
data$Year <- fct_recode(data$Year, 
                        "7. Schuljahr" = "Year7",
                        "8. Schuljahr" = "Year8")

table(data$Year)    # Absolute Häufigkeiten 

##### Fehlende Werte am Beispiel Mittelwert -----
table(data$Total_Competence_Maths)   # Absolute Häufigkeiten

min(data$Total_Competence_Maths)     # Minimum der Variable

# Wert als fehlend rekodieren
data$Total_Competence_Maths <- data$Total_Competence_Maths %>% 
  na_if(-9)

table(data$Total_Competence_Maths)  # Absolute Häufigkeiten

mean(data$Total_Competence_Maths)   # Default Mittelwert bei Vorliegen fehlender Werte

mean(data$Total_Competence_Maths, na.rm = TRUE) # Mittelwert unter Ausschluss fehlender Werte

is.na(data$Total_Competence_Maths) # Überprüfung auf fehlende Werte

sum(is.na(data$Total_Competence_Maths)) # Anzahl fehlender Werte

#### Erstellung neuer Variablen ----

##### Bilden von Fragebogenscores -----
table(data$Total_Competence_Science)    # Betrachten der absoluten Häufigkeiten
# fehlende Werte -9 sind vorhanden und müssen behandelt werden
data$Total_Competence_Science <- data$Total_Competence_Science %>% 
  na_if(-9)



4:25    # Vektor von 4 bis 25

colMeans(data[,4:25])    # Mittelwert aller Variablen von Spalte 4 bis 25

# Mittelwerte aller Zeilen für drei Variablen
rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")])

# Skalenmittelwert mit dplyr erstellen
data <- data %>%
  mutate(Total_Competence = rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")]))

data$Total_Competence   # Anzeigen der neuen Variable

##### Bilden einer neuen kategorialen Variable -----

# Neue Variable erstellen
data <- data %>%
  mutate(Achiever = case_when(
    Total_Competence_Maths >= 4 & 
    Total_Competence_English >= 4 & 
    Total_Competence_Science >= 4 ~ "High Achiever",
    
    Total_Competence_Maths == 1 & 
    Total_Competence_English == 1 & 
    Total_Competence_Science == 1 ~ "Low Achiever",
    
    TRUE ~ "Medium Achiever"  # Alle anderen Fälle
  ))

table(data$Achiever)   # Absolute Häufigkeiten der neuen Variable

#### Mehrfache Durchführung von Operationen ----
# Ersetzen von -9 durch NA
data <- data %>%
  mutate(across(everything(), ~ na_if(.x, -9)))

class(data$Year)   # Check des Typen von Year
is.numeric(data$Year)   # Überprüfung auf numerische Variable - nicht numerisch
class(data$Total_Competence_Maths)   # Check des Typen von Total_Competence_Maths
is.numeric(data$Total_Competence_Maths)   # Überprüfung auf numerische Variable - numerisch

# Ersetzen von -9 durch NA auf numerischen Variablen
data <- data %>%
  mutate(across(where(is.numeric), ~ na_if(.x, -9)))

#### Erstellen Gruppierter Deskriptivstatistiken ----
# Gruppierung nach Achiever
data %>%
  group_by(Achiever) 

# Gruppierung nach Achiever und Berechnung des Mittelwerts
data %>%
  group_by(Achiever) %>%
  summarise(mean(Total_SelfEsteem))

# Gruppierung nach Achiever und Berechnung des Mittelwerts samt Benennung
data %>%
  group_by(Achiever) %>%
  summarise(Mean_SelfEsteem = mean(Total_SelfEsteem))
