---
title: "Tests für abhängige Stichproben - Aufgaben" 
type: post
date: '2019-10-18' 
slug: gruppenvergleiche-abhaengig-aufgaben
categories: [] 
tags: ["Statistik I Übungen"] 
subtitle: ''
summary: '' 
authors: [koehler, buchholz]
weight:
lastmod: '2023-10-13'
featured: no
banner:
  image: "/header/BSc2_test_abh_stpr.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/449195)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/gruppenvergleiche-abhaengig
  - icon_pack: fas
    icon: star
    name: Lösungen
    url: /lehre/statistik-i/gruppenvergleiche-abhaengig-loesungen
output:
  html_document:
    keep_md: true
---





## Vorbereitung



> Laden Sie zunächst den Datensatz `fb22` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb22.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/gruppenvergleiche-abhaengig/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb22)
```

```
## [1] 159  47
```

```r
str(fb22)
```

```
## 'data.frame':	159 obs. of  47 variables:
##  $ prok1        : int  1 4 3 1 2 2 2 3 2 4 ...
##  $ prok2        : int  3 3 3 3 1 4 2 1 3 3 ...
##  $ prok3        : int  4 2 2 4 4 2 3 2 2 2 ...
##  $ prok4        : int  2 4 4 NA 3 2 2 3 3 4 ...
##  $ prok5        : int  3 1 2 4 2 3 3 3 4 2 ...
##  $ prok6        : int  4 4 4 3 1 2 2 3 2 4 ...
##  $ prok7        : int  3 2 2 4 2 3 3 3 3 3 ...
##  $ prok8        : int  3 4 3 4 4 2 3 3 4 2 ...
##  $ prok9        : int  1 4 4 2 1 1 2 2 3 4 ...
##  $ prok10       : int  3 4 3 2 1 3 1 4 1 4 ...
##  $ nr1          : int  1 1 4 2 1 1 1 5 2 1 ...
##  $ nr2          : int  3 2 5 4 5 4 3 5 4 4 ...
##  $ nr3          : int  5 1 5 4 1 3 3 5 5 4 ...
##  $ nr4          : int  4 2 5 4 2 4 4 5 3 5 ...
##  $ nr5          : int  4 2 5 4 2 3 4 5 4 4 ...
##  $ nr6          : int  3 1 5 3 2 1 1 5 2 4 ...
##  $ lz           : num  5.4 6 3 6 3.2 5.8 4.2 NA 5.4 4.6 ...
##  $ extra        : num  2.75 3.75 4.25 4 2.5 3 2.75 3.5 4.75 5 ...
##  $ vertr        : num  3.75 4.75 4.5 4.75 4.75 3 3.25 5 4.5 4.5 ...
##  $ gewis        : num  4.25 2.75 3.75 4.25 5 4.25 4 4.75 4.5 3 ...
##  $ neuro        : num  4.25 5 4 2.25 3.75 3.25 3 3.5 4 4.5 ...
##  $ intel        : num  4.75 4 5 4.75 3.5 3 4 4 5 4.25 ...
##  $ nerd         : num  2.67 4 4.33 3.17 4.17 ...
##  $ grund        : chr  "Interesse" "Allgemeines Interesse schon seit der Kindheit" "menschliche Kognition wichtig und rätselhaft; Interesse für Psychoanalyse; Schnittstelle zur Linguistik" "Psychoanalyse, Hilfsbereitschaft, Lebenserfahrung" ...
##  $ fach         : Factor w/ 5 levels "Allgemeine","Biologische",..: 5 4 1 4 2 NA 1 4 3 4 ...
##  $ ziel         : Factor w/ 4 levels "Wirtschaft","Therapie",..: 2 2 3 2 2 NA 1 2 2 2 ...
##  $ lerntyp      : num  1 1 1 1 1 NA 3 2 3 1 ...
##  $ geschl       : int  1 2 2 2 1 NA 2 1 1 1 ...
##  $ job          : int  1 2 1 1 1 NA 2 1 1 1 ...
##  $ ort          : int  1 1 1 2 2 NA 2 1 1 1 ...
##  $ ort12        : int  1 1 1 1 1 NA 1 1 1 1 ...
##  $ wohnen       : Factor w/ 4 levels "WG","bei Eltern",..: 2 2 3 4 2 NA 2 1 1 3 ...
##  $ uni1         : num  0 0 0 0 0 0 0 1 1 1 ...
##  $ uni2         : num  1 1 0 1 1 0 0 1 1 1 ...
##  $ uni3         : num  0 0 0 0 0 0 0 1 1 1 ...
##  $ uni4         : num  0 0 1 0 0 0 0 0 0 0 ...
##  $ geschl_faktor: Factor w/ 3 levels "weiblich","männlich",..: 1 2 2 2 1 NA 2 1 1 1 ...
##  $ prok2_r      : num  2 2 2 2 4 1 3 4 2 2 ...
##  $ prok3_r      : num  1 3 3 1 1 3 2 3 3 3 ...
##  $ prok5_r      : num  2 4 3 1 3 2 2 2 1 3 ...
##  $ prok7_r      : num  2 3 3 1 3 2 2 2 2 2 ...
##  $ prok8_r      : num  2 1 2 1 1 3 2 2 1 3 ...
##  $ prok_ges     : num  2 3.3 3.1 NA 2 2.1 2 2.8 2 3.3 ...
##  $ nr_ges       : num  3.33 1.5 4.83 3.5 2.17 ...
##  $ nr_ges_z     : num [1:159, 1] 0.0964 -2.1534 1.9372 0.3009 -1.3353 ...
##   ..- attr(*, "scaled:center")= num 3.25
##   ..- attr(*, "scaled:scale")= num 0.815
##  $ nerd_std     : num [1:159, 1] -0.7059 1.3395 1.8509 0.0611 1.5952 ...
##   ..- attr(*, "scaled:center")= num 3.13
##   ..- attr(*, "scaled:scale")= num 0.652
##  $ neuro_std    : num [1:159, 1] 0.869 1.912 0.521 -1.914 0.173 ...
##   ..- attr(*, "scaled:center")= num 3.63
##   ..- attr(*, "scaled:scale")= num 0.719
```

Der Datensatz besteht aus 159 Zeilen (Beobachtungen) und 47 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.


## Aufgabe 1
Unterscheidet sich im Durchschnitt die Angabe von Psychologiestudierenden zu ihrer Prokrastinationstendenz, wenn sie positiv formulierte Items (prok1, prok4, prok6, prok9, prok10) beantworten im Vergleich zu negativ formulierten Items (prok2, prok3, prok5, prok7 und prok8)? 

## Aufgabe 2
Ein Therapeut behauptet, dass eine von ihm entwickelte Meditation die Zufriedenheit von Menschen positiv beeinflusst. Er möchte dies mit wissenschaftlichen Methoden zeigen und misst die Zufriedenheit vor und nach der Meditation. Es ergeben sich folgende Werte für 18 Personen:   


| Vpn| Vorher| Nachher|
|---:|------:|-------:|
|   1|    4.1|     4.0|
|   2|    5.9|     7.2|
|   3|    4.4|     8.1|
|   4|    7.8|     6.2|
|   5|    2.4|     4.1|
|   6|    8.8|     7.7|
|   7|    3.1|     5.5|
|   8|    5.0|     6.9|
|   9|    6.0|     8.2|
|  10|    4.5|     5.4|
|  11|    5.8|     9.1|
|  12|    4.4|     5.6|
|  13|    3.2|     6.8|
|  14|    7.3|     7.5|
|  15|    7.4|     6.4|
|  16|    6.3|     4.9|
|  17|    4.3|     6.1|
|  18|    7.1|     7.9|


Wirkt die Meditation positiv auf die Zufriedenheit?

**Denken Sie bei der Bearbeitung der Aufgabe an Folgendes:**

*	Deskriptivstatistische Beantwortung der Fragestellung  
*	Voraussetzungsprüfungen   
*	Spezifikation der Hypothesen und des Signifikanzniveaus  
*	Ggf. Berechnung der Effektstärke  
*	Formales Berichten des Ergebnisses    

