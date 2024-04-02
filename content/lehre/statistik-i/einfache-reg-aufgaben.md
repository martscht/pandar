---
title: "Einfache Lineare Regression - Aufgaben" 
type: post
date: '2019-10-18' 
slug: einfache-reg-aufgaben 
categories: [] 
tags: ["Statistik I Übungen"] 
subtitle: ''
summary: '' 
authors: [winkler, neubauer, walter]
weight:
lastmod: '2024-04-02'
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

Laden Sie zunächst den Datensatz `fb23` von der pandar-Website und führen Sie die Ergänzungen vor, die in zurückliegenden Tutorials vorgenommen wurden. 


```r
#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb23.rda'))  

# Nominalskalierte Variablen in Faktoren verwandeln
fb23$hand_factor <- factor(fb23$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb23$fach <- factor(fb23$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb23$ziel <- factor(fb23$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb23$wohnen <- factor(fb23$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))
fb23$fach_klin <- factor(as.numeric(fb23$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))
fb23$ort <- factor(fb23$ort, levels=c(1,2), labels=c("FFM", "anderer"))
fb23$job <- factor(fb23$job, levels=c(1,2), labels=c("nein", "ja"))
fb23$unipartys <- factor(fb23$uni3,
                             levels = 0:1,
                             labels = c("nein", "ja"))

# Rekodierung invertierter Items
fb23$mdbf4_pre_r <- -1 * (fb23$mdbf4_pre - 4 - 1)
fb23$mdbf11_pre_r <- -1 * (fb23$mdbf11_pre - 4 - 1)
fb23$mdbf3_pre_r <-  -1 * (fb23$mdbf3_pre - 4 - 1)
fb23$mdbf9_pre_r <-  -1 * (fb23$mdbf9_pre - 4 - 1)
fb23$mdbf5_pre_r <- -1 * (fb23$mdbf5_pre - 4 - 1)
fb23$mdbf7_pre_r <- -1 * (fb23$mdbf7_pre - 4 - 1)

# Berechnung von Skalenwerten
fb23$wm_pre  <- fb23[, c('mdbf1_pre', 'mdbf5_pre_r', 
                        'mdbf7_pre_r', 'mdbf10_pre')] |> rowMeans()
fb23$gs_pre  <- fb23[, c('mdbf1_pre', 'mdbf4_pre_r', 
                        'mdbf8_pre', 'mdbf11_pre_r')] |> rowMeans()
fb23$ru_pre <-  fb23[, c("mdbf3_pre_r", "mdbf6_pre", 
                         "mdbf9_pre_r", "mdbf12_pre")] |> rowMeans()

# z-Standardisierung
fb23$ru_pre_zstd <- scale(fb23$ru_pre, center = TRUE, scale = TRUE)
```

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb23)
```

```
## [1] 179  53
```

```r
str(fb23)
```

```
## 'data.frame':	179 obs. of  53 variables:
##  $ mdbf1_pre   : int  4 2 4 NA 3 3 2 3 3 2 ...
##  $ mdbf2_pre   : int  2 2 3 3 3 2 3 2 2 1 ...
##  $ mdbf3_pre   : int  3 4 2 2 2 3 3 1 2 2 ...
##  $ mdbf4_pre   : int  2 2 1 2 1 1 3 2 3 3 ...
##  $ mdbf5_pre   : int  3 2 3 2 2 1 3 3 2 4 ...
##  $ mdbf6_pre   : int  2 1 2 2 2 2 2 3 2 2 ...
##  $ mdbf7_pre   : int  4 3 3 1 1 2 2 3 3 3 ...
##  $ mdbf8_pre   : int  3 2 3 2 3 3 2 3 3 2 ...
##  $ mdbf9_pre   : int  2 4 1 2 3 3 4 2 2 3 ...
##  $ mdbf10_pre  : int  3 2 3 3 2 4 2 2 2 2 ...
##  $ mdbf11_pre  : int  3 2 1 2 2 1 3 1 2 4 ...
##  $ mdbf12_pre  : int  1 1 2 3 2 2 2 3 3 2 ...
##  $ lz          : num  5.4 3.4 4.4 4.4 6.4 5.6 5.4 5 4.8 6 ...
##  $ extra       : num  3.5 3 4 3 4 4.5 3.5 3.5 2.5 3 ...
##  $ vertr       : num  1.5 3 3.5 4 4 4.5 4 4 3 3.5 ...
##  $ gewis       : num  4.5 4 5 3.5 3.5 4 4.5 2.5 3.5 4 ...
##  $ neuro       : num  5 5 2 4 3.5 4.5 3 2.5 4.5 4 ...
##  $ offen       : num  5 5 4.5 3.5 4 4 5 4.5 4 3 ...
##  $ prok        : num  1.8 3.1 1.5 1.6 2.7 3.3 2.2 3.4 2.4 3.1 ...
##  $ nerd        : num  4.17 3 2.33 2.83 3.83 ...
##  $ grund       : chr  "Berufsziel" "Interesse am Menschen" "Interesse und Berufsaussichten" "Wissenschaftliche Ergänzung zu meinen bisherigen Tätigkeiten (Arbeit in der psychiatrischen Akutpflege, Gestalt"| __truncated__ ...
##  $ fach        : Factor w/ 5 levels "Allgemeine","Biologische",..: 4 4 4 4 4 4 NA 4 4 NA ...
##  $ ziel        : Factor w/ 4 levels "Wirtschaft","Therapie",..: 2 2 2 2 2 2 NA 4 2 2 ...
##  $ wissen      : int  5 4 5 4 2 3 NA 4 3 3 ...
##  $ therap      : int  5 5 5 5 4 5 NA 3 5 5 ...
##  $ lerntyp     : num  3 3 1 3 3 1 NA 1 3 3 ...
##  $ hand        : int  2 2 2 2 2 2 NA 2 1 2 ...
##  $ job         : Factor w/ 2 levels "nein","ja": 1 1 1 1 2 2 NA 2 1 2 ...
##  $ ort         : Factor w/ 2 levels "FFM","anderer": 2 1 1 1 1 2 NA 1 1 2 ...
##  $ ort12       : int  2 1 2 2 2 1 NA 2 2 1 ...
##  $ wohnen      : Factor w/ 4 levels "WG","bei Eltern",..: 4 1 1 1 1 2 NA 3 3 2 ...
##  $ uni1        : num  0 1 0 1 0 0 0 0 0 0 ...
##  $ uni2        : num  1 1 1 1 1 1 0 1 1 1 ...
##  $ uni3        : num  0 1 0 0 1 0 0 1 1 0 ...
##  $ uni4        : num  0 1 0 1 0 0 0 0 0 0 ...
##  $ attent_pre  : int  6 6 6 6 6 6 NA 4 5 5 ...
##  $ gs_post     : num  3 2.75 4 2.5 3.75 NA 4 2.75 3.75 2.5 ...
##  $ wm_post     : num  2 1 3.75 2.75 3 NA 3.25 2 3.25 2 ...
##  $ ru_post     : num  2.25 1.5 3.75 3.5 3 NA 3.5 2.75 2.75 2.75 ...
##  $ attent_post : int  6 5 6 6 6 NA 6 4 5 3 ...
##  $ hand_factor : Factor w/ 2 levels "links","rechts": 2 2 2 2 2 2 NA 2 1 2 ...
##  $ fach_klin   : Factor w/ 2 levels "nicht klinisch",..: 2 2 2 2 2 2 NA 2 2 NA ...
##  $ unipartys   : Factor w/ 2 levels "nein","ja": 1 2 1 1 2 1 1 2 2 1 ...
##  $ mdbf4_pre_r : num  3 3 4 3 4 4 2 3 2 2 ...
##  $ mdbf11_pre_r: num  2 3 4 3 3 4 2 4 3 1 ...
##  $ mdbf3_pre_r : num  2 1 3 3 3 2 2 4 3 3 ...
##  $ mdbf9_pre_r : num  3 1 4 3 2 2 1 3 3 2 ...
##  $ mdbf5_pre_r : num  2 3 2 3 3 4 2 2 3 1 ...
##  $ mdbf7_pre_r : num  1 2 2 4 4 3 3 2 2 2 ...
##  $ wm_pre      : num  2.5 2.25 2.75 NA 3 3.5 2.25 2.25 2.5 1.75 ...
##  $ gs_pre      : num  3 2.5 3.75 NA 3.25 3.5 2 3.25 2.75 1.75 ...
##  $ ru_pre      : num  2 1 2.75 2.75 2.25 2 1.75 3.25 2.75 2.25 ...
##  $ ru_pre_zstd : num [1:179, 1] -0.9749 -2.3095 0.0261 0.0261 -0.6412 ...
##   ..- attr(*, "scaled:center")= num 2.73
##   ..- attr(*, "scaled:scale")= num 0.749
```

Der Datensatz besteht aus 179 Zeilen (Beobachtungen) und 53 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.

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

