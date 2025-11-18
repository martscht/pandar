---
title: Einfache Lineare Regression - Übungen
type: post
date: '2019-10-18'
slug: einfache-reg-uebungen
categories: Statistik I Übungen
tags: []
subtitle: ''
summary: ''
authors:
- winkler
- neubauer
- walter
weight: ~
lastmod: '2025-11-13'
featured: no
banner:
  image: /header/modern_buildings.jpg
  caption: '[Courtesy of pxhere](https://pxhere.com/de/photo/411588)'
projects: []
reading_time: no
share: no
links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-i/einfache-reg
- icon_pack: fas
  icon: star
  name: Lösungen
  url: /lehre/statistik-i/einfache-reg-loesungen
output:
  html_document:
    keep_md: yes
private: 'true'
---






## Vorbereitung

Laden Sie zunächst den Datensatz `fb25` von der pandar-Website und führen Sie die Ergänzungen vor, die in zurückliegenden Tutorials vorgenommen wurden. 


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

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


``` r
dim(fb25)
```

```
## [1] 211  56
```

``` r
str(fb25)
```

```
## 'data.frame':	211 obs. of  56 variables:
##  $ mdbf1      : num  3 3 3 4 4 3 3 3 2 3 ...
##  $ mdbf2      : num  3 2 3 1 3 3 3 2 3 2 ...
##  $ mdbf3      : num  1 2 2 3 1 1 1 1 3 3 ...
##  $ mdbf4      : num  1 2 2 1 1 1 1 1 1 2 ...
##  $ mdbf5      : num  1 2 2 2 1 1 1 3 2 3 ...
##  $ mdbf6      : num  3 2 3 1 3 2 1 3 4 2 ...
##  $ mdbf7      : num  1 3 2 3 2 2 2 4 2 3 ...
##  $ mdbf8      : num  3 3 3 4 4 3 3 3 3 3 ...
##  $ mdbf9      : num  1 3 2 2 1 4 2 1 3 4 ...
##  $ mdbf10     : num  3 3 2 1 3 3 2 2 3 3 ...
##  $ mdbf11     : num  1 2 2 1 1 1 2 1 3 2 ...
##  $ mdbf12     : num  3 2 2 3 3 2 2 3 2 1 ...
##  $ time_pre   : num  43 55 79 53 28 35 44 29 30 52 ...
##  $ lz         : num  5 3 5 6 5.8 5.2 4.6 4.8 6.8 2.6 ...
##  $ extra      : num  3.5 4 2.5 4 4.5 3 2.5 2.5 3.5 2 ...
##  $ vertr      : num  4 3 4 3 2 4.5 2.5 4 3 2.5 ...
##  $ gewis      : num  2.5 4.5 3.5 4.5 3 3.5 2.5 2 4 5 ...
##  $ neuro      : num  2 2 3 4 4 5 4.5 1 4.5 5 ...
##  $ offen      : num  2.5 4.5 4.5 5 4.5 4.5 3.5 4 5 4.5 ...
##  $ prok       : num  2.6 2.5 2.8 3 2.5 2.9 3 3.4 3.2 2.7 ...
##  $ trust      : num  3.33 3.83 3.83 3.67 3.67 ...
##  $ uni1       : num  0 0 1 0 0 0 0 0 0 1 ...
##  $ uni2       : num  1 1 1 1 1 1 1 1 1 1 ...
##  $ uni3       : num  1 0 0 1 0 1 0 0 0 0 ...
##  $ uni4       : num  0 0 0 0 0 0 0 1 0 1 ...
##  $ sicher     : int  3 4 4 4 4 3 NA 3 4 3 ...
##  $ angst      : int  2 2 3 4 3 3 2 2 2 4 ...
##  $ fach       : Factor w/ 5 levels "Allgemeine","Biologische",..: 4 4 4 4 4 4 4 2 2 2 ...
##  $ ziel       : Factor w/ 4 levels "Wirtschaft","Therapie",..: 2 2 2 2 2 2 2 1 1 3 ...
##  $ wissen     : int  NA 3 5 NA NA NA 4 NA 3 5 ...
##  $ therap     : int  NA 5 5 NA NA NA 5 NA 5 4 ...
##  $ lerntyp    : int  3 3 3 3 1 3 1 3 2 1 ...
##  $ hand       : int  2 2 2 2 2 2 2 2 1 2 ...
##  $ job        : Factor w/ 2 levels "nein","ja": 2 1 2 2 1 1 1 1 2 2 ...
##  $ ort        : Factor w/ 2 levels "FFM","anderer": 1 2 2 1 2 1 1 2 2 1 ...
##  $ ort12      : int  2 3 1 3 2 2 2 1 1 1 ...
##  $ wohnen     : Factor w/ 4 levels "WG","bei Eltern",..: 3 2 3 1 4 3 1 2 4 1 ...
##  $ attent_pre : num  4 5 4 5 5 5 5 5 5 4 ...
##  $ gs_post    : num  3 NA 2.75 3.25 3 3.25 NA 3 2.75 2.25 ...
##  $ wm_post    : num  3.25 NA 2.75 3.25 2.75 3.25 NA 2.25 1.75 2.25 ...
##  $ ru_post    : num  2.25 NA 2.25 2.75 2.25 2.5 NA 2 2 2.75 ...
##  $ time_post  : num  18 NA 71 17 21 51 NA 31 27 34 ...
##  $ attent_post: num  5 NA 5 5 5 5 NA 5 5 5 ...
##  $ hand_factor: Factor w/ 2 levels "links","rechts": 2 2 2 2 2 2 2 2 1 2 ...
##  $ fach_klin  : Factor w/ 2 levels "nicht klinisch",..: 2 2 2 2 2 2 2 1 1 1 ...
##  $ unipartys  : Factor w/ 2 levels "nein","ja": 2 1 1 2 1 2 1 1 1 1 ...
##  $ mdbf4_r    : num  4 3 3 4 4 4 4 4 4 3 ...
##  $ mdbf11_r   : num  4 3 3 4 4 4 3 4 2 3 ...
##  $ mdbf3_r    : num  4 3 3 2 4 4 4 4 2 2 ...
##  $ mdbf9_r    : num  4 2 3 3 4 1 3 4 2 1 ...
##  $ mdbf5_r    : num  4 3 3 3 4 4 4 2 3 2 ...
##  $ mdbf7_r    : num  4 2 3 2 3 3 3 1 3 2 ...
##  $ wm_pre     : num  3.5 2.75 2.75 2.5 3.5 3.25 3 2 2.75 2.5 ...
##  $ gs_pre     : num  3.5 3 3 4 4 3.5 3.25 3.5 2.75 3 ...
##  $ ru_pre     : num  3.5 2.25 2.75 2.25 3.5 2.25 2.5 3.5 2.5 1.5 ...
##  $ ru_pre_zstd: num [1:211, 1] 0.976 -0.893 -0.145 -0.893 0.976 ...
##   ..- attr(*, "scaled:center")= num 2.85
##   ..- attr(*, "scaled:scale")= num 0.669
```

Der Datensatz besteht aus 211 Zeilen (Beobachtungen) und 56 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.

***
## Aufgabe 1
Welche der fünf Persönlichkeitsdimensionen Extraversion (`extra`), Verträglichkeit (`vertr`), Gewissenhaftigkeit (`gewis`), Neurotizsimus (`neuro`) und Offenheit für neue Erfahrungen (`offen`) zeigt den höchsten linearen Zusammenhang mit der Lebenszufriedenheit (`lz`)?

  * Erstellen Sie für jeden Zusammenhang je ein Streudiagramm. 
  * Schätzen Sie für jeden Zusammenhang je ein Modell. 
  * Interpretieren Sie den standardisierten Koeffizienten des linearen Zusammenhangs zwischen Extraversion und Lebenszufriedenheit. Wie verändert sich `lz`, wenn sich `extra` um eine Standardabweichung erhöht?

## Aufgabe 2
Betrachten Sie nun den Zusammenhang von Neurotizismus (`neuro`) und Lebenszufriedenheit (`lz`) etwas genauer:

  * Erstellen Sie ein Streu-Punkt-Diagramm  mit Regressionsgerade für den linearen Zusammenhang zwischen Neurotizismus und Lebenszufriedenheit.
  * Wie viel Prozent der Varianz werden durch das Modell erklärt?
  * Ein paar Studierende wurden nachträglich zum Studiengang Psychologie zugelassen und befinden sich daher nicht im Datensatz. Die neuen Studierenden wurden nachträglich befragt und weisen auf der Skala Neurotizismus folgende Werte auf: 1.25; 2.75; 3.5; 4.25; 3.75; 2.15. Machen Sie eine Vorhersage für die Lebenszufriedenheit für die neuen Studierenden.

