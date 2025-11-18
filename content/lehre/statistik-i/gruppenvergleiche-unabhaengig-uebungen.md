---
title: Tests für unabhängige Stichproben - Übungen
type: post
date: '2024-11-29'
slug: gruppenvergleiche-unabhaengig-uebungen
categories: Statistik I Übungen
tags: []
subtitle: ''
summary: ''
authors:
- koehler
- buchholz
weight: 1
lastmod: '2025-11-13'
featured: no
banner:
  image: /header/writing_math.jpg
  caption: '[Courtesy of pxhere](https://pxhere.com/en/photo/662606)'
projects: []
reading_time: no
share: no
links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-i/gruppenvergleiche-unabhaengig
- icon_pack: fas
  icon: star
  name: Lösungen
  url: /lehre/statistik-i/gruppenvergleiche-unabhaengig-loesungen
output:
  html_document:
    keep_md: yes
private: 'true'
---





## Vorbereitung

> Laden Sie zunächst den Datensatz `fb25` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb25.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/gruppenvergleiche-unabhaengig/#prep) vorausgesetzt werden, teils inklusive derer, die erst im Beitrag vorgenommen werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

**Datenaufbereitung**


``` r
#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb25.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb25$hand_factor <- factor(fb25$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb25$fach <- factor(fb25$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb25$ziel <- factor(fb25$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb25$wohnen <- factor(fb25$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))
fb25$fach_klin <- factor(as.numeric(fb25$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))
fb25$ort <- factor(fb25$ort, levels=c(1,2), labels=c("FFM", "anderer"))
fb25$job <- factor(fb25$job, levels=c(1,2), labels=c("nein", "ja"))
fb25$unipartys <- factor(fb25$uni3,
                             levels = 0:1,
                             labels = c("nein", "ja"))

# Rekodierung invertierter Items
fb25$mdbf4_r <- -1 * (fb25$mdbf4 - 4 - 1)
fb25$mdbf11_r <- -1 * (fb25$mdbf11 - 4 - 1)
fb25$mdbf3_r <-  -1 * (fb25$mdbf3 - 4 - 1)
fb25$mdbf9_r <-  -1 * (fb25$mdbf9 - 4 - 1)
fb25$mdbf5_r <- -1 * (fb25$mdbf5 - 4 - 1)
fb25$mdbf7_r <- -1 * (fb25$mdbf7 - 4 - 1)

# Berechnung von Skalenwerten
fb25$wm_pre  <- fb25[, c('mdbf1', 'mdbf5_r', 
                        'mdbf7_r', 'mdbf10')] |> rowMeans()
fb25$gs_pre  <- fb25[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb25$ru_pre <-  fb25[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb25$ru_pre_zstd <- scale(fb25$ru_pre, center = TRUE, scale = TRUE)
```

**Untersuchen Sie folgende Fragestellungen anhand des fb25-Datensatzes**

**Denken Sie dabei an Folgendes:**

*	Deskriptivstatistische Beantwortung der Fragestellung  
*	Voraussetzungsprüfungen (Normalverteilung bitte optisch überprüfen und den Test dementsprechend wählen - auch wenn n > 30 gegeben ist)  
*	Spezifikation der Hypothesen und des Signifikanzniveaus  
*	Ggf. Berechnung der Effektstärke  
*	Formales Berichten des Ergebnisses    

## Aufgabe 1
 
Unterscheiden sich Studierende, die sich für Allgemeine Psychologie (Variable "fach") interessieren, im Persönlichkeitsmerkmal Offenheit für neue Erfahrungen (auch Intellekt, Variable "offen") von Studierenden, die sich für Klinische Psychologie interessieren? Normalverteilung des Merkmals in der Population darf angenommen werden. 

## Aufgabe 2
Sind Studierende, die außerhalb von Frankfurt wohnen ("ort"), zufriedener im Leben ("lz") als diejenigen, die innerhalb von Frankfurt wohnen?  

## Aufgabe 3

Ist die Wahrscheinlichkeit dafür, neben dem Studium einen Job zu haben ("job"), die gleiche für Erstsemesterstudierende der Psychologie die in einer Wohngemeinschaft wohnen wie für Studierenden die bei ihren Eltern wohnen ("wohnen")? 
