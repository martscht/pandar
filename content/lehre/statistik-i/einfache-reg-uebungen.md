---
title: "Einfache Lineare Regression - Übungen" 
type: post
date: '2019-10-18' 
slug: einfache-reg-uebungen
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [winkler, neubauer, walter]
weight:
lastmod: '2025-04-07'
featured: no
banner:
  image: "/header/modern_buildings.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/411588)"
projects: []
reading_time: false
share: false

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
    keep_md: true
---






## Vorbereitung

Laden Sie zunächst den Datensatz `fb24` von der pandar-Website und führen Sie die Ergänzungen vor, die in zurückliegenden Tutorials vorgenommen wurden. 


``` r
#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb24.rda'))  

# Nominalskalierte Variablen in Faktoren verwandeln
fb24$hand_factor <- factor(fb24$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb24$fach <- factor(fb24$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb24$ziel <- factor(fb24$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb24$wohnen <- factor(fb24$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))
fb24$fach_klin <- factor(as.numeric(fb24$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))
fb24$ort <- factor(fb24$ort, levels=c(1,2), labels=c("FFM", "anderer"))
fb24$job <- factor(fb24$job, levels=c(1,2), labels=c("nein", "ja"))
fb24$unipartys <- factor(fb24$uni3,
                             levels = 0:1,
                             labels = c("nein", "ja"))

# Rekodierung invertierter Items
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 4 - 1)
fb24$mdbf11_r <- -1 * (fb24$mdbf11 - 4 - 1)
fb24$mdbf3_r <-  -1 * (fb24$mdbf3 - 4 - 1)
fb24$mdbf9_r <-  -1 * (fb24$mdbf9 - 4 - 1)
fb24$mdbf5_r <- -1 * (fb24$mdbf5 - 4 - 1)
fb24$mdbf7_r <- -1 * (fb24$mdbf7 - 4 - 1)

# Berechnung von Skalenwerten
fb24$wm_pre  <- fb24[, c('mdbf1', 'mdbf5_r', 
                        'mdbf7_r', 'mdbf10')] |> rowMeans()
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb24$ru_pre <-  fb24[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb24$ru_pre_zstd <- scale(fb24$ru_pre, center = TRUE, scale = TRUE)
```

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


``` r
dim(fb24)
```

```
## [1] 192  55
```

``` r
str(fb24)
```

```
## 'data.frame':	192 obs. of  55 variables:
##  $ mdbf1      : num  4 3 3 3 3 2 4 2 3 4 ...
##  $ mdbf2      : num  3 2 3 1 2 2 4 3 3 4 ...
##  $ mdbf3      : num  1 1 1 2 3 1 1 2 2 1 ...
##  $ mdbf4      : num  1 1 1 2 1 3 1 1 1 1 ...
##  $ mdbf5      : num  3 1 3 3 2 4 1 2 1 1 ...
##  $ mdbf6      : num  3 3 3 2 2 3 3 3 3 4 ...
##  $ mdbf7      : num  3 3 2 3 2 4 1 4 1 1 ...
##  $ mdbf8      : num  4 4 3 3 3 2 4 3 4 4 ...
##  $ mdbf9      : num  1 2 1 2 3 2 3 3 2 1 ...
##  $ mdbf10     : num  3 3 3 3 3 2 3 2 4 4 ...
##  $ mdbf11     : num  1 1 1 2 3 2 2 1 2 1 ...
##  $ mdbf12     : num  3 4 3 3 2 2 3 2 3 4 ...
##  $ time_pre   : num  49 68 107 38 45 100 61 40 36 40 ...
##  $ lz         : num  6.6 4 5.2 4 5 4.4 6.4 4 4.6 6 ...
##  $ extra      : num  5 4 3 1.5 2.5 4.5 4 2.5 4 3 ...
##  $ vertr      : num  4 3 3 3 3.5 2.5 4 2.5 4.5 3 ...
##  $ gewis      : num  4 4.5 4 3.5 2.5 4 3.5 3.5 4 5 ...
##  $ neuro      : num  1.5 3 3.5 3.5 4.5 3.5 2.5 3.5 5 2.5 ...
##  $ offen      : num  4 4 4 3.5 4.5 4 4 4 4.5 3 ...
##  $ prok       : num  2.7 2.5 2.9 2.8 2.9 2.7 2.4 2.5 2.7 2.6 ...
##  $ nerd       : num  2.5 2.33 2.83 4 3.67 ...
##  $ uni1       : num  0 0 0 0 0 0 0 0 1 0 ...
##  $ uni2       : num  1 1 1 1 1 1 1 1 1 1 ...
##  $ uni3       : num  0 0 1 0 0 1 0 1 1 1 ...
##  $ uni4       : num  0 0 1 0 0 0 0 0 1 0 ...
##  $ grund      : chr  "Interesse an Menschen, Verhalten und Sozialdynamiken" "Ich will die Menschliche Psyche und menschliches Handeln, Denken verstehen." NA "Um Therapeutin zu werden und Menschen aus meiner früheren Situatuon zu helfen " ...
##  $ fach       : Factor w/ 5 levels "Allgemeine","Biologische",..: 1 3 1 4 4 3 1 3 1 4 ...
##  $ ziel       : Factor w/ 4 levels "Wirtschaft","Therapie",..: 3 2 3 2 2 3 1 4 4 2 ...
##  $ wissen     : int  4 3 5 5 4 3 3 4 5 3 ...
##  $ therap     : int  5 4 5 5 5 5 4 5 4 5 ...
##  $ lerntyp    : num  3 1 1 1 1 1 3 3 3 1 ...
##  $ hand       : num  1 2 2 2 2 2 2 2 1 2 ...
##  $ job        : Factor w/ 2 levels "nein","ja": 2 1 2 1 1 1 1 1 2 2 ...
##  $ ort        : Factor w/ 2 levels "FFM","anderer": 2 2 1 1 1 1 1 2 1 1 ...
##  $ ort12      : num  1 2 1 1 2 2 2 1 2 2 ...
##  $ wohnen     : Factor w/ 4 levels "WG","bei Eltern",..: 2 3 3 3 3 3 1 2 1 1 ...
##  $ attent     : num  5 4 5 5 5 5 5 4 4 5 ...
##  $ gs_post    : num  NA 3 3.5 2.75 2.5 3 NA 3.25 3 3.25 ...
##  $ wm_post    : num  NA 2.25 3 2.25 2.5 2.25 NA 2.5 3 3.25 ...
##  $ ru_post    : num  NA 2.25 2.25 2.25 2 2.25 NA 2.25 2.75 1.75 ...
##  $ time_post  : num  NA 34 37 37 51 40 NA 40 30 27 ...
##  $ attent_post: num  NA 5 5 5 5 5 NA 5 5 5 ...
##  $ hand_factor: Factor w/ 2 levels "links","rechts": 1 2 2 2 2 2 2 2 1 2 ...
##  $ fach_klin  : Factor w/ 2 levels "nicht klinisch",..: 1 1 1 2 2 1 1 1 1 2 ...
##  $ unipartys  : Factor w/ 2 levels "nein","ja": 1 1 2 1 1 2 1 2 2 2 ...
##  $ mdbf4_r    : num  4 4 4 3 4 2 4 4 4 4 ...
##  $ mdbf11_r   : num  4 4 4 3 2 3 3 4 3 4 ...
##  $ mdbf3_r    : num  4 4 4 3 2 4 4 3 3 4 ...
##  $ mdbf9_r    : num  4 3 4 3 2 3 2 2 3 4 ...
##  $ mdbf5_r    : num  2 4 2 2 3 1 4 3 4 4 ...
##  $ mdbf7_r    : num  2 2 3 2 3 1 4 1 4 4 ...
##  $ wm_pre     : num  2.75 3 2.75 2.5 3 1.5 3.75 2 3.75 4 ...
##  $ gs_pre     : num  4 3.75 3.5 3 3 2.25 3.75 3.25 3.5 4 ...
##  $ ru_pre     : num  3.5 3.5 3.5 2.75 2 3 3 2.5 3 4 ...
##  $ ru_pre_zstd: num [1:192, 1] 1.0554 1.0554 1.0554 -0.0402 -1.1357 ...
##   ..- attr(*, "scaled:center")= num 2.78
##   ..- attr(*, "scaled:scale")= num 0.685
```

Der Datensatz besteht aus 192 Zeilen (Beobachtungen) und 55 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.

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

