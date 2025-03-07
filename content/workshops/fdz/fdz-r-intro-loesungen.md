---
title: R und RStudio - Aufgaben
type: post
date: '2025-02-28' 
slug: fdz-r-intro-loesungen 
categories: [] 
tags: [] 
subtitle: ''
summary: '' 
authors: [nehler] 
lastmod: '2025-02-28'
featured: no
banner:
  image: "/header/toy_car_crash.jpg"
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
    url: /workshops/fdz/fdz-r-intro
  - icon_pack: fas
    icon: star
    name: Lösungen
    url: /workshops/fdz/fdz-r-intro-aufgaben

_build:
  list: never
output:
  html_document:
    keep_md: true
---





Denken Sie bei allen Aufgaben daran, den Code im R-Skript sinnvoll zu gliedern und zu kommentieren.

1. Bestimmen Sie das Ergebnis von $2 + 60 \div 5$

<details><summary>Lösung</summary>


``` r
#### Aufgaben des Tutorials zur Einführung von RStudio und R ----
##### Aufgabe 1 -----
2 + 60 / 5 # Ausführung Rechenoperation
```

```
## [1] 14
```

</details>


2. Prüfen Sie mit logischen Operatoren, ob das Ergebnis aus der letzten Aufgabe dasselbe ist, wie $3 \cdot 29$ oder $ 70 \div 5$.

<details><summary>Lösung</summary>

Bei der Lösung kommen die logischen Operatoren `==` zum Einsatz, um zwei Rechenoperationen miteinander zu vergleichen. Hier muss besonders darauf geachtet werden, dass die Berechnung zuerst durchgeführt wird und dann der Vergleich stattfindet. Dies erreicht man, indem man die Berechnung in Klammern setzt.


``` r
##### Aufgabe 2 -----
(2 + 60 / 5) == (3 * 29) # logischer Vergleich zweier Rechenoperationen
```

```
## [1] FALSE
```

``` r
(2 + 60 / 5) == (70 / 5) # logischer Vergleich zweier Rechenoperationen
```

```
## [1] TRUE
```

</details>



3. Bestimmen Sie $\sqrt{115}$ und legen Sie das (ganzzahlig) gerundete Ergebnis in einem Objekt namens `zahl` ab. Die zugehörige Funktion für das Runden heißt `round()`. Nutzen Sie die Hilfe, um die passenden Argumente einzugeben.

<details><summary>Lösung</summary>


``` r
##### Aufgabe 3 -----
zahl <- round(sqrt(115), digits = 0) # Berechnung und Rundung der Quadratwurzel von 115
```

</details>

4. Sie wollen den Betrag der Zahl -5 bestimmen. Wie können Sie dies in R umsetzen? Nutzen Sie für das Suchen einer geeigneten Funktion die Hilfe oder das Internet.

<details><summary>Lösung</summary>
Die einfachste Funktion zum Bestimmen des Betrags einer Zahl ist `abs()`. 


``` r
##### Aufgabe 4 -----
abs(-5) # Berechnung des Betrags einer Zahl
```

```
## [1] 5
```

</details>

5. Folgende Syntax verursacht ein Warning: `sqrt(-1)`. Wodurch kommt diese Warning zu Stande?

<details><summary>Lösung</summary>


``` r
##### Aufgabe 5 -----
sqrt(-1)  # Betrachten der Warnung
```

```
## Warning in sqrt(-1): NaNs produced
```

```
## [1] NaN
```

Die Warnung entsteht, da die Quadratwurzel von negativen Zahlen in der reellen Zahlenmenge nicht definiert ist. Hier gibt R ähnlich wie im Tutorial aus, dass die Lösung `NaN` - also "Not a Number" ist.

</details>

6. Folgende Syntax verursacht einen Fehler: `6 * 1,56`. Wodurch kommt dieser Fehler zustande? Kann dieser Fehler behoben werden?

<details><summary>Lösung</summary>


``` r
##### Aufgabe 6 -----
6 * 1,56    # Betrachten des Fehlers
```

```
## Error: <text>:2:6: unexpected ','
## 1: ##### Aufgabe 6 -----
## 2: 6 * 1,
##         ^
```

In der Syntax wird fälschlicherweise das Komma als Dezimaltrennzeichen genutzt. Wenn man das Komma durch einen Punkt ersetzt, funktioniert die Syntax problemlos:


``` r
6 * 1.56     # Korrekte Syntax
```

```
## [1] 9.36
```

</details>

