---
title: Basisfunktionen zur Grafikerstellung und lineare Modelle - Aufgaben
type: post
date: '2025-02-28' 
slug: fdz-plots-lm-aufgaben
categories: [] 
tags: [] 
subtitle: ''
summary: '' 
authors: [nehler] 
lastmod: '2025-03-12'
featured: no
banner:
  image: "/header/rice-field.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1217289)"
projects: []

expiryDate: ''
publishDate: ''
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /workshops/fdz/fdz-plots-lm
  - icon_pack: fas
    icon: star
    name: Lösungen
    url: /workshops/fdz/fdz-plots-lm-loesungen
_build:
  list: never
output:
  html_document:
    keep_md: true
---





Denken Sie bei allen Aufgaben daran, den Code im R-Skript sinnvoll zu gliedern und zu kommentieren.


## Vorbereitung

Zunächst müssen wir das `readxl`, `forcats` und das `dplyr` Paket wieder aktivieren und einen Teil des Code aus dem letzten Tutorial und den letzten Aufgaben wieder durchführen.


``` r
# Paket einladen
library(readxl)
library(dplyr)
library(forcats)
# Pfad setzen
rstudioapi::getActiveDocumentContext()$path |>
  dirname() |>
  setwd()
# Daten einladen
data <- read_excel("Pennington_2021.xlsx", sheet = "Study_Data")
# Faktoren erstellen
data$Gender <- factor(data$Gender, 
                         levels = c(1, 2),
                         labels = c("weiblich", "männlich"))
data$Year <- as.factor(data$Year)
# Faktoren Rekodieren
data$Year <- fct_recode(data$Year, 
                        "7. Schuljahr" = "Year7",
                        "8. Schuljahr" = "Year8")
data$Ethnicity <- as.factor(data$Ethnicity)
# NA-Werte ersetzen
data <- data %>%
  mutate(across(where(is.numeric), ~ na_if(.x, -9)))
# Skalenwerte erstellen
data <- data %>%
  mutate(Total_Competence = rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")]))
data$Total_SelfConcept <- rowMeans(data[, c("Total_SelfConcept_Maths", "Total_SelfConcept_Science", "Total_SelfConcept_English")]) 
# Gruppierungsvariablen erstellen
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
data <- data %>%
  mutate(Career_Recommendation = case_when(
    Maths_AttainmentData > 10 |
    Science_AttainmentData > 10 |
    Eng_AttainmentData > 10 |
    Computing_AttainmentData > 10 ~ "Empfohlen",
    
    TRUE ~ "Nicht empfohlen"
  ))  # Erstellen der neuen Variable
```
Falls Sie nicht am Workshop teilnehmen und daher keine lokale Version des Datensatzes haben, verwenden Sie diesen Code.


``` r
# Paket einladen
library(readxl)
library(dplyr)
library(forcats)
# Daten einladen
source("https://pandar.netlify.app/workshops/fdz/fdz_data_prep.R")
# Faktoren erstellen
data$Gender <- factor(data$Gender, 
                         levels = c(1, 2),
                         labels = c("weiblich", "männlich"))
data$Year <- as.factor(data$Year)
# Faktoren Rekodieren
data$Year <- fct_recode(data$Year, 
                        "7. Schuljahr" = "Year7",
                        "8. Schuljahr" = "Year8")
data$Ethnicity <- as.factor(data$Ethnicity)
# NA-Werte ersetzen
data <- data %>%
  mutate(across(where(is.numeric), ~ na_if(.x, -9)))
# Skalenwerte erstellen
data <- data %>%
  mutate(Total_Competence = rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")]))
data$Total_SelfConcept <- rowMeans(data[, c("Total_SelfConcept_Maths", "Total_SelfConcept_Science", "Total_SelfConcept_English")])
# Gruppierungsvariablen erstellen
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
data <- data %>%
  mutate(Career_Recommendation = case_when(
    Maths_AttainmentData > 10 |
    Science_AttainmentData > 10 |
    Eng_AttainmentData > 10 |
    Computing_AttainmentData > 10 ~ "Empfohlen",
    
    TRUE ~ "Nicht empfohlen"
  ))  # Erstellen der neuen Variable
```



## Teil 1 - Grafikerstellung


1. Zeichnen Sie ein Histogramm für die Variable `Total_Mindset` und passen Sie die Grenzen der x-Achse an. Die Farbe der Umrandung der einzelnen Balekn soll Türkis sein. Finden Sie heraus, wie Sie sich alle voreingestellten Farben (wie `red` und `blue`) anzeigen lassen können und wählen Sie ein Türkis, das Ihnen gefällt.
2. Zeichnen Sie ein Balkendiagramm für die Variable `Achiever`. Färben Sie dabei jeden Balken in einer der Regenbogenpalette `rainbow()`.
3. In der Funktion `boxplot()` kann die Ausrichtung des Boxplots (vertikal, horizontal) und auch die Darstellung der Ausreißer verändert werden. Zeichnen Sie einen horizontalen Boxplot für die Variable `Total_Competence_Maths` und unterdrücken Sie die Darstellung der Ausreißer.
4. Zeichnen Sie einen Scatterplot für den Zusammenhang der Variablen `Total_Mindset` und `Total_SelfConcept`. Passen Sie die Form (Dreiecke) und Farbe der (Grün) der Punkte an.



## Teil 2 - Lineare Modelle

1. In Teil 1 haben wir gelernt, dass die Funktion `boxplot()` genutzt werden kann, um Boxplots zu erstellen. Erstellen Sie im Zusammenspiel mit der Syntax, die Sie in Teil 2 gelernt haben einen gruppierten Boxplot, der die Verteilung von `Total_Competence_Maths` in den Gruppen von `Gender` zeigt.
2. Erstellen Sie eine multiple Regression mit `Science_AttainmentData` als abhängiger Variable. Prädiktoren sollen `Total_Competence` und `Total_Mindset` sein. Wie ist das Regressionsgewicht von `Total_Competence` in diesem Fall und welcher p-Wert wird ihm zugeschrieben?  
3. Finden Sie mit Hilfe des Internets heraus, wie standardisierte Regressionsparameter mit Hilfe einer Funktion aus einem noch nicht verwendeten Paket ausgegeben werden können.
4. Diese Aufgabe ist nur zur Veranschaulichung der Syntax - keine Empfehlung für solch ein Modell: Als zuästzlicher Prädiktor soll `Total_SelfConcept` hinzugefügt werden. Außerdem soll die Dreifachinteraktion der Prädiktoren aufgenommen werden, aber keine Interaktionen zwischen zwei Prädiktoren.

