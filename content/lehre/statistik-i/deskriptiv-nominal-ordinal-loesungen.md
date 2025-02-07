---
title: "Deskriptivstatistik für Nominal- und Ordinalskalen - Lösungen" 
type: post
date: '2020-11-26' 
slug: deskriptiv-nominal-ordinal-loesungen
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [buchholz, nehler, sinn] 
lastmod: '2025-02-07'
featured: no
banner:
  image: "/header/frogs_on_phones.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1227907)"
projects: []
expiryDate: ''
publishDate: ''
_build:
  list: never
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/deskriptiv-nominal-ordinal
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/deskriptiv-nominal-ordinal-aufgaben

output:
  html_document:
    keep_md: true
---



Die Lösungen sind exemplarische Möglichkeiten. In `R` gibt es immer viele Wege, die zum Ziel führen. Wenn Sie einen anderen mit dem korrekten Ergebnis gewählt haben, kann dieser genauso richtig sein wie die hier präsentierten Ansätze.

### Vorbereitung

> Laden Sie die Daten aus [<i class="fas fa-download"></i> `fb24.rda`](/daten/fb24.rda) oder direkt von der Website über die gelernten Befehle. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

<details><summary>Lösung</summary>

Daten laden:


```r
load(url('https://pandar.netlify.app/daten/fb24.rda'))  
```


Überblick über den Datensatz verschaffen:


```r
dim(fb24)
```

```
## [1] 192  42
```

```r
str(fb24)
```

```
## 'data.frame':	192 obs. of  42 variables:
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
##  $ fach       : num  1 3 1 4 4 3 1 3 1 4 ...
##  $ ziel       : num  3 2 3 2 2 3 1 4 4 2 ...
##  $ wissen     : int  4 3 5 5 4 3 3 4 5 3 ...
##  $ therap     : int  5 4 5 5 5 5 4 5 4 5 ...
##  $ lerntyp    : num  3 1 1 1 1 1 3 3 3 1 ...
##  $ hand       : num  1 2 2 2 2 2 2 2 1 2 ...
##  $ job        : num  2 1 2 1 1 1 1 1 2 2 ...
##  $ ort        : num  2 2 1 1 1 1 1 2 1 1 ...
##  $ ort12      : num  1 2 1 1 2 2 2 1 2 2 ...
##  $ wohnen     : num  2 3 3 3 3 3 1 2 1 1 ...
##  $ attent     : num  5 4 5 5 5 5 5 4 4 5 ...
##  $ gs_post    : num  NA 3 3.5 2.75 2.5 3 NA 3.25 3 3.25 ...
##  $ wm_post    : num  NA 2.25 3 2.25 2.5 2.25 NA 2.5 3 3.25 ...
##  $ ru_post    : num  NA 2.25 2.25 2.25 2 2.25 NA 2.25 2.75 1.75 ...
##  $ time_post  : num  NA 34 37 37 51 40 NA 40 30 27 ...
##  $ attent_post: num  NA 5 5 5 5 5 NA 5 5 5 ...
```

Der Datensatz besteht aus 192 Zeilen (Beobachtungen) und 42 Spalten (Variablen).

</details>



## Aufgabe 1

Untersuchen Sie, welche Arbeitsbranche Sie und Ihre Kommiliton:innen nach dem Studium anstreben!  

* Vergeben Sie zunächst die korrekten Wertelabels an die Ausprägungen der Variable.  
* Lassen Sie sich absolute und relative Häufigkeiten ausgeben.  
* Untersuchen Sie mit den geeigneten Maßen die zentrale Tendenz und Dispersion dieser Variable.  


<details><summary>Lösung</summary>

**Faktor erstellen**


```r
fb24$ziel <- factor(fb24$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
levels(fb24$ziel)
```

```
## [1] "Wirtschaft" "Therapie"   "Forschung"  "Andere"
```

**Absolute und relative Häufigkeiten anfordern**  


```r
table(fb24$ziel)              # absolut
```

```
## 
## Wirtschaft   Therapie  Forschung     Andere 
##         24        108         27         29
```

```r
prop.table(table(fb24$ziel))  # relativ
```

```
## 
## Wirtschaft   Therapie  Forschung     Andere 
##  0.1276596  0.5744681  0.1436170  0.1542553
```

**Zentrale Tendenz und Dispersion für nominalskalierte Variablen: Modus, relativer Informationsgehalt**


```r
# Modus
which.max(table(fb24$ziel))
```

```
## Therapie 
##        2
```


```r
#relativer Informationsgehalt
hj <- prop.table(table(fb24$ziel))  # hj erstellen
ln_hj <- log(hj)                    # Logarithmus bestimmen
summand <- ln_hj * hj               # Berechnung fuer jede Kategorie
summe <- sum(summand)               # Gesamtsumme
k <- length(hj)                     # Anzahl Kategorien bestimmen
relInf <- -1/log(k) * summe         # Relativer Informationsgehalt
relInf
```

```
## [1] 0.8282775
```

Der Modus der Variable lautet Therapie - die meisten Ihres Jahrgangs (*n* = 108 bzw. 57.45%) streben einen Job in diesem Bereich an. Der relative Informationsgehalt der Variable beträgt 0.83. Sie sehen hier, dass wir im Code einen kleinen Unterschied zum Tutorial eingebaut haben. Die Anzahl der Kategorien wird nicht mehr durch `dim(tab)` sondern durch `length(hj)` bestimmt. Das Resultat ist nicht verschieden - die Anzahl der Kategorien wird gezählt. Wir wollen somit aber nochmal deutlich machen, dass es in `R` immer sehr viele Wege zu einem Ziel geben kann.

</details>



## Aufgabe 2

Die Variable `therap` enthält die Angaben über das Ausmaß, in dem sich Sie und Ihre Kommilitonen:innen für anwendungsbezogene Aspekte interessieren.

* Bestimmen Sie für diese Variable den Modus.     
* Untersuchen Sie die Streuung für diese Variable optisch, indem Sie einen Boxplot erstellen.  
* Bestimmen Sie die Quartile, den Interquartilsbereich (IQB) und den Interquartilsabstand auch als Zahlen.

<details><summary>Lösung</summary>

**Modus**


```r
which.max(table(fb24$therap))
```

```
## 5 
## 4
```

**Häufigkeiten**


```r
table(fb24$therap)
```

```
## 
##   2   3   4   5 
##   2  10  57 119
```

```r
prop.table(table(fb24$therap))
```

```
## 
##          2          3          4          5 
## 0.01063830 0.05319149 0.30319149 0.63297872
```

Der Modus der Variable `therap` beträgt 4, d.h. diese Antwortkategorie wurde am häufigsten genannt (*n* = 119 bzw. 63.3%).

**Boxplot**


```r
boxplot(fb24$therap)
```

![](/deskriptiv-nominal-ordinal-loesungen_files/unnamed-chunk-9-1.png)<!-- -->

**Quartile**


```r
quantile(fb24$therap, c(.25,.5,.75), na.rm=T)
```

```
## 25% 50% 75% 
##   4   5   5
```

Der Median beträgt 5. Das 1. und 3. Quartil betragen 4 bzw. 5. Folglich sind die Grenzen des Interquartilsbereich (IQB) 4 und 5. Der Interquartilsabstand (IQA) beträgt 1.

</details>


## Aufgabe 3

Erstellen Sie für die Variable `wohnen` eine geeignete Abbildung.   

* Stellen Sie sicher, dass die einzelnen Ausprägungen der Variable in der Darstellung interpretierbar benannt sind!  
* Dekorieren Sie diese Abbildung nach eigenen Wünschen (z.B. mit einer Farbpalette und Achsenbeschriftungen).
* Speichern Sie die Grafik per Syntax als .jpg-Datei mit dem Namen "Befragung-fb24.jpg" ab.

<details><summary>Lösung</summary>

**Faktor erstellen**


```r
fb24$wohnen <- factor(fb24$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))
```

**Ansprechende Grafik erstellen**

Um eine ansprechende Grafik zu erhalten, können wir einige Argumente anpassen. Hier ist natürlich nur eine beispielhafte Lösung abgebildet.


```r
# Ansprechende Darstellung
barplot(
  # wichtig: Funktion auf Häufigkeitstabelle, nicht die Variable selbst anwenden:
  table(fb24$wohnen),                               
  # aussagekräftiger Titel, inkl. Zeilenumbruch ("\n") 
  main = "Befragung Erstis im WS 24/25:\nAktuelle Wohnsituation", 
  # y-Achsen-Beschriftung:
  ylab = "Häufigkeit",
  # Farben aus einer Farbpalette:
  col = rainbow(10),
  # Platz zwischen Balken minimieren:
  space = 0.1,
  # graue Umrandungen der Balken:
  border = "grey2",
  # Unterscheidlich dichte Schattierungen (statt Füllung) für die vier Balken:
  density = c(50, 75, 25, 50),
  # Richtung, in dem die Schattierung in den vier Balken verläuft
  angle = c(-45, 0, 45, 90),
  # Schriftausrichtung der Achsen horizontal:
  las=2,
  #y-Achse erweitern, sodass mehr Platz zum Titel bleibt:
  ylim = c(0,60))
```

![](/deskriptiv-nominal-ordinal-loesungen_files/unnamed-chunk-12-1.png)<!-- -->

**Speichern (per Syntax)**


```r
jpeg("Befragung-fb24.jpg", width=20, height=10, units="cm", res=200)
barplot(
  table(fb24$wohnen),                               
  main = "Befragung Erstis im WS 24/25:\nAktuelle Wohnsituation", 
  ylab = "Häufigkeit",
  col = rainbow(10),
  space = 0.1,
  border = "grey2",
  density = c(50,75,25,50),
  angle = c(-45,0,45,90),
  las=2,
  ylim = c(0,60))
dev.off()
```

Im Arbeitsverzeichnis sollte die Datei nun vorliegen.


</details>



