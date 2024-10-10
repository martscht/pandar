---
title: "Übungen" 
type: post
date: '2024-10-09' 
slug: refresher-uebungen 
categories: ["refresheR Übungen"] 
tags: ["refresheR"] 
subtitle: ''
summary: '' 
authors: [stephan, gruetzner, vogler] 
weight: 
lastmod: '2024-10-10'
featured: no
banner:
  image: "/header/syntax.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1172040)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: pen-to-square
    name: Lösungen
    url: /workshops/refresheR/uebungen-loesungen


output:
  html_document:
    keep_md: true
    
---
  

## Übung 1 - Datenhandling 

### Aufgabe 1

Laden Sie den Datensatz edu_exp in ihr enviroment.
Die URL lautet: https://pandar.netlify.app/daten/edu_exp.rda


### Aufgabe 2

Machen Sie einen Faktor aus der Variable Wealth und ordnen sie die Levels so, dass die höchste Wohlstandsstufe Level 1 erhält.



### Aufgabe 3

Entfernen Sie die Beobachtungen, die NA's auf der Variable `Income` haben.



### Aufgabe 4

Bauen sie ein `data.frame` aus `country` + `primary` + `secondary` + `tertiary`

EXTRA: nur Länder mit `Primary` > 30



### Aufgabe 5

Welche Fuktion nutzt man um data.frames zusammenzuführen?



***

## Übung 2 - t-Tests

### Aufgabe 1

Testen Sie folgende Hypothesen auf statistische Signifikanz. Die Hypothesen und Variablen sind frei erfunden. Schreibe Sie die korrekte R-Syntax für diese fiktiven Beispiele.


$H_1$: Personen mit akademischem Abschluss (`edu`) zeigen im Mittel eine höhere Umweltsensibilität (`sens`) als Personen ohne akademischen Abschluss.

Normalverteilung: gegeben

Homoskedastizität: gegeben



***

$H_1$: Nicht-Führungskräfte (`lead`) weisen eine geringere Stressresistenz (`stress`) auf als Führungskräfte.

Normalverteilung: gegeben

Homoskedastizität: gegeben



***

$H_1$: Personen, die Haustiere besitzen (`pet`), berichten von einer höheren emotionalen Bindung (`emo`) zu ihren Mitmenschen als Personen ohne Haustiere.

Normalverteilung: gegeben

Homoskedastizität: nicht gegeben



***

$H_1$: Es besteht ein Unterschied in den Reaktionszeiten (`react`) zwischen Personen, die regelmäßig Videospiele spielen (`game`), und Personen, die keine Videospiele spielen.

Normalverteilung: nicht gegeben

Homoskedastizität: gegeben



***

$H_1$: Ältere Geschwister (`respons_old`) zeigen im Durchschnitt eine höhere Verantwortungsübernahme als jüngere Geschwister (`respons_young`).

Normalverteilung: gegeben

Homoskedastizität: gegeben



***

$H_1$: Nichtraucher und Raucher (`smoke`) unterscheiden sich in ihrer sportlichen Leistungsfähigkeit (`athl`).

Normalverteilung: gegeben

Homoskedastizität: nicht gegeben



***

$H_1$: Die Stressbelastung (`stress`) unterscheidet sich zwischen vor und nach einer Sporteinheit (`time`).

Normalverteilung: nicht gegeben

Homoskedastizität: nicht gegeben



***

$H_1$: Extravertierte Personen (`int_extra`) haben im Schnitt mehr tägliche soziale Interaktionen als introvertierte Personen (`int_intro`).

Normalverteilung: nicht gegeben

Homoskedastizität: nicht gegeben



***


### Aufgabe 2

Laden Sie den Datensatz `distort` ein, wenn noch nicht geschehen. Informationen zu den Variablen finden Sie [hier](/daten/datensaetze/#distorted-news).

<details>
  <summary>**Tipp**</summary>


``` r
source("https://pandar.netlify.app/daten/Data_Processing_distort.R")
```
  
</details>  

Testen Sie folgende Hypothese auf statistische Signifikanz. Vergessen Sie nicht zuvor die Voraussetzungen zu überprüfen.

$H_1$: Männer und Frauen unterscheiden sich in ihrer wahrgenommenen Marginalisierung.



***


## Übung 3 - Abschlussaufgabe

### Vorbereitungen:
Zuerst laden wir den Datensatz "Bullyingprävention bei Jugendlichen (fairplayer)" ein:


``` r
load(url("https://pandar.netlify.app/daten/fairplayer.rda"))
```
Der Datensatz stammt aus einer Studie von Bull, Schultze & Scheithauer (2009), in der die Effektivität eines Interventionsprogramms zur Bullyingprävention bei Jugendlichen untersucht wurde. Das Codebook können sie dem folgenden Link entnehmen: https://pandar.netlify.app/daten/datensaetze/

1.) Beschreibung des Datensatzes
a) Wie viele Beobachtungen auf wie vielen Variablen gibt es? 
b) Existieren fehlende Daten? 
c) Wie viele Beobachtungen verlieren Sie, wenn sie alle Beobachtungen mit fehlenden Werten herauswerfen? 


``` r
# Aufgabe 1:
## a)
dim(fairplayer)
```

```
## [1] 155  31
```

``` r
## b)
sum(is.na(fairplayer))
```

```
## [1] 830
```

``` r
## c) 
fairplayer_NA <- na.omit(fairplayer)
dim(fairplayer_NA)
```

```
## [1] 106  31
```
2.) Datenaufbereitung
a) Entfernen Sie den Messzeitpunkt T3. 
b) Passen Sie die Reihennamen an: ID, Klassenstufe, Interventiosgruppe, Geschlecht. Die Items können gleich benannt bleiben (Tipp: trotzdem müssen sie bei dem Befehl der Namen mit angesprochen werden)
c) Fassen Sie die Items der Skalen Relationale Angst, Empathie und Soziale Intelligenz. Achten Sie dabei darauf immer nur Items der gleichen Messzeitpunkte zusammenzufassen.
d) Ergänzen Sie einen Faktor, der die Klassenstufen mit den Namen Schulanfänger, Zweitklässler und Drittklässler enthält.


3.) Deskriptivstatistik:
a) Erstellen Sie eine Tabelle, die die Kennwerte der demografischen Variablen Klasse, Gruppe und Geschlecht beinhalten.
b) Erstellen Sie eine Tabelle, die die Kennwerte der Skalen relationale Angst, Empathie und Soziale Intelligenz zu T1 und T2 enthalten.

4.) T-Test:
a) Gibt es signifikante Gruppenunterschiede in der Skala soziale Intelligenz zu T1 zwischen Mädchen und Jungen?
b) Zeigen sich Gruppenunterschiede zwischen den Interventionsgruppen im Hinblick auf die relationale Angst zu T2? 
c) Erstellen Sie GGPlots, die die Gruppenunterschiede verbildlichen. 

5.) Regression:
a) Sagen die Prädiktoren Geschlecht, Gruppe, Wert zu T1 (Relationale Angst) und Klassenstufe den Wert im Bereich relationale Angst zu T2 voraus? Erstellen Sie ein entsprechendes Regressionsmodell und rechnen sie dieses? 

6.) GGPlot:
a) Erstellen Sie einen Plot, der den Zusammenhang zwischen relationaler Angst und sozialer Intelligenz zu T1 darstellt. Fügen Sie eine lineare Trendlinie hinzu und berichten sie die Korrelation und ihre Signifikant.
