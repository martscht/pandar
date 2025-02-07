---
title: "Multiple Regression - Aufgaben" 
type: post
date: '2024-02-06' 
slug: multiple-reg-aufgaben
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [vogler]
weight:
lastmod: '2025-02-07'
featured: no
banner:
  image: "/header/stormies.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/89134)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/multiple-reg
  - icon_pack: fas
    icon: star
    name: Lösungen
    url: /lehre/statistik-i/multiple-reg-loesungen
output:
  html_document:
    keep_md: true
---



## Vorbereitung



> Laden Sie zunächst den Datensatz `fb24` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb24.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/multiple-reg/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb24)
```

```
## [1] 192  44
```

Der Datensatz besteht aus 192 Zeilen (Beobachtungen) und 44 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.


***

## Aufgabe 1

Ihr womöglich erstes Semester des Psychologie Studiums neigt sich dem Ende entgegen und die Klausuren rücken somit immer näher. Als vorbildliche\*r Student\*in sind Sie bereits fleißig am Lernen.
Jedoch beobachten Sie in manchen Kommilitoninnen und Kommilitonen, dass diese nicht so fleißig sind und eher vor sich hin prokrastinieren.
Sie vermuten, dass bestimmte Persönlichkeitsmerkmale die Prokrastinationstendenz (`prok`) vorhersagen könnten. Konkret vermuten Sie einen positiven Zusammenhang mit Neurotizismus (`neuro`) und einen negativen Zusammenhang mit Gewissenhaftigkeit (`gewis`). Im weiteren Verlauf sollen aber alle Eigenschaften aus dem Big Five Modell überprüft werden.

Dafür reduzieren Sie zunächst Ihren Datensatz auf die relevanten Variablen und entfernen sämtliche fehlende Werte:


```r
fb24_short <- subset(fb24, select = c("extra", "vertr", "gewis", "neuro", "offen", "prok"))

fb24_short <- na.omit(fb24_short)
```

<details>

<summary>Exkurs: Warum machen wir das?</summary>

Zum einen fällt es uns so leichter den Überblick über unsere Daten zu behalten.
Zum anderen ist uns bereits im Kapitel [Multiple Regression](/lehre/statistik-i/multiple-reg) eine Fehlermeldung bei der Verwendung des Befehls `anova()` in Kombination mit fehlenden Werten (`NA`) begegnet.
Da wir im Folgenden erneut mit den Big Five Variablen arbeiten, gehen wir dieser Fehlermeldung bereits im Vorhinein aus dem Weg.


```r
#Gibt es mindestens ein fehlenden Wert auf den 6 Variablen?
anyNA(fb24[, c("extra", "vertr", "gewis", "neuro", "offen", "prok")])
```

```
## [1] TRUE
```

```r
#Auf welcher Variable und wie viele NA's gibt es?
summary(fb24[, c("extra", "vertr", "gewis", "neuro", "offen", "prok")])
```

```
##      extra           vertr           gewis          neuro           offen            prok      
##  Min.   :1.000   Min.   :1.000   Min.   :1.50   Min.   :1.000   Min.   :1.000   Min.   :2.100  
##  1st Qu.:2.500   1st Qu.:3.000   1st Qu.:3.00   1st Qu.:3.000   1st Qu.:3.000   1st Qu.:2.500  
##  Median :3.500   Median :3.500   Median :3.50   Median :3.500   Median :4.000   Median :2.700  
##  Mean   :3.277   Mean   :3.484   Mean   :3.49   Mean   :3.408   Mean   :3.809   Mean   :2.685  
##  3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:4.00   3rd Qu.:4.000   3rd Qu.:4.500   3rd Qu.:2.900  
##  Max.   :5.000   Max.   :5.000   Max.   :5.00   Max.   :5.000   Max.   :5.000   Max.   :3.200  
##  NA's   :1       NA's   :1       NA's   :1      NA's   :1       NA's   :1       NA's   :2
```

```r
#ein NA auf vertr
```

</details>

*   Stellen Sie das oben beschriebene lineare Regressionsmodell auf.

*   Überprüfen Sie die Voraussetzungen für die multiple lineare Regression.

*   Neurotizismus (`neuro`) und Gewissenhaftigkeit (`gewis`) bilden bereits zwei der fünf Persönlichkeitsdimensionen nach dem Big Five Modell ab. Gibt es unter den verbleibenden drei Dimensionen einen weiteren signifikanten Prädiktor für die Prokrastinationstendenz (`prok`)? Gehen Sie schrittweise vor, indem Sie Ihr vorhandenes Modell um eine Persönlichkeitsdimension erweitern und dann testen, ob deren Inkrement signifikant ist.

*   Interpretieren Sie das Regressionsgewicht von Gewissenhaftigkeit (`gewis`).

*   Wie viel Varianz (in %) erklärt das finale Modell?


## Aufgabe 2

Gehen Sie für die folgende Aufgabe von dem finalen Modell aus Aufgabe 1 aus.

Falls Sie dort Schwierigkeiten hatten, benutzen Sie das Kontrollergebnis.

<details>

<summary>Kontrollergebnis</summary>


```r
mod_final <- lm(prok ~ neuro + gewis + extra, data = fb24_short)
```

</details>

*   Welcher Prädiktor trägt am meisten zur Prognose der Prokrastinationstendenz (`prok`) bei?

*   Welche Prokrastinationstendenz (`prok`) sagt das finale Modell für eine Person hervor, die auf allen inkludierten Prädiktoren genau in der Mitte der Stichprobe (`fb24`) liegt (Mittelwerte)?


***



