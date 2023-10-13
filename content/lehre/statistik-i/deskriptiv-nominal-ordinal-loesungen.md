---
title: "Deskriptivstatistik für Nominal- und Ordinalskalen - Lösungen" 
type: post
date: '2020-11-26' 
slug: deskriptiv-nominal-ordinal-loesungen
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [buchholz, nehler] 
lastmod: '2023-10-13'
featured: no
banner:
  image: "/header/descriptive_post.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1227907)"
projects: []
reading_time: false
share: false
_build:
  list: never
output:
  html_document:
    keep_md: true
---

Die Lösungen sind exemplarische Möglichkeiten. In `R` gibt es immer viele Wege ans Ziel. Wenn Sie einen anderen mit dem korrekten Ergebnis gewählt haben, kann dieser genauso richtig sein wie die hier präsentierten Ansätze.

### Vorbereitung

<details><summary>Lösung</summary>

Laden Sie zunächst den Datensatz `fb22` von der pandar-Website herunter und dann ein.


```r
load(url('https://pandar.netlify.app/daten/fb22.rda'))   # Daten laden
```

Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

Verschaffen Sie sich nun einen Überblick über den Datensatz:


```r
dim(fb22)
```

```
## [1] 159  36
```

```r
str(fb22)
```

```
## 'data.frame':	159 obs. of  36 variables:
##  $ prok1  : int  1 4 3 1 2 2 2 3 2 4 ...
##  $ prok2  : int  3 3 3 3 1 4 2 1 3 3 ...
##  $ prok3  : int  4 2 2 4 4 2 3 2 2 2 ...
##  $ prok4  : int  2 4 4 NA 3 2 2 3 3 4 ...
##  $ prok5  : int  3 1 2 4 2 3 3 3 4 2 ...
##  $ prok6  : int  4 4 4 3 1 2 2 3 2 4 ...
##  $ prok7  : int  3 2 2 4 2 3 3 3 3 3 ...
##  $ prok8  : int  3 4 3 4 4 2 3 3 4 2 ...
##  $ prok9  : int  1 4 4 2 1 1 2 2 3 4 ...
##  $ prok10 : int  3 4 3 2 1 3 1 4 1 4 ...
##  $ nr1    : int  1 1 4 2 1 1 1 5 2 1 ...
##  $ nr2    : int  3 2 5 4 5 4 3 5 4 4 ...
##  $ nr3    : int  5 1 5 4 1 3 3 5 5 4 ...
##  $ nr4    : int  4 2 5 4 2 4 4 5 3 5 ...
##  $ nr5    : int  4 2 5 4 2 3 4 5 4 4 ...
##  $ nr6    : int  3 1 5 3 2 1 1 5 2 4 ...
##  $ lz     : num  5.4 6 3 6 3.2 5.8 4.2 NA 5.4 4.6 ...
##  $ extra  : num  2.75 3.75 4.25 4 2.5 3 2.75 3.5 4.75 5 ...
##  $ vertr  : num  3.75 4.75 4.5 4.75 4.75 3 3.25 5 4.5 4.5 ...
##  $ gewis  : num  4.25 2.75 3.75 4.25 5 4.25 4 4.75 4.5 3 ...
##  $ neuro  : num  4.25 5 4 2.25 3.75 3.25 3 3.5 4 4.5 ...
##  $ intel  : num  4.75 4 5 4.75 3.5 3 4 4 5 4.25 ...
##  $ nerd   : num  2.67 4 4.33 3.17 4.17 ...
##  $ grund  : chr  "Interesse" "Allgemeines Interesse schon seit der Kindheit" "menschliche Kognition wichtig und rätselhaft; Interesse für Psychoanalyse; Schnittstelle zur Linguistik" "Psychoanalyse, Hilfsbereitschaft, Lebenserfahrung" ...
##  $ fach   : num  5 4 1 4 2 NA 1 4 3 4 ...
##  $ ziel   : num  2 2 3 2 2 NA 1 2 2 2 ...
##  $ lerntyp: num  1 1 1 1 1 NA 3 2 3 1 ...
##  $ geschl : int  1 2 2 2 1 NA 2 1 1 1 ...
##  $ job    : int  1 2 1 1 1 NA 2 1 1 1 ...
##  $ ort    : int  1 1 1 2 2 NA 2 1 1 1 ...
##  $ ort12  : int  1 1 1 1 1 NA 1 1 1 1 ...
##  $ wohnen : num  2 2 3 4 2 NA 2 1 1 3 ...
##  $ uni1   : num  0 0 0 0 0 0 0 1 1 1 ...
##  $ uni2   : num  1 1 0 1 1 0 0 1 1 1 ...
##  $ uni3   : num  0 0 0 0 0 0 0 1 1 1 ...
##  $ uni4   : num  0 0 1 0 0 0 0 0 0 0 ...
```

Der Datensatz besteht aus 159 Zeilen (Beobachtungen) und 36 Spalten (=Variablen).

</details>



## Aufgabe 1

Untersuchen Sie, welche Arbeitsbranche Sie und Ihre Kommiliton:innen nach dem Studium anstreben!  

* Vergeben Sie zunächst die korrekten Wertelabels an die Ausprägungen der Variable.  
* Lassen Sie sich absolute und relative Häufigkeiten ausgeben.  
* Untersuchen Sie mit den geeigneten Maßen die zentrale Tendenz und Dispersion dieser Variable.  


<details><summary>Lösung</summary>

**Faktor erstellen**


```r
fb22$ziel <- factor(fb22$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
levels(fb22$ziel)
```

```
## [1] "Wirtschaft" "Therapie"   "Forschung"  "Andere"
```

**Absolute und relative Häufigkeiten anfordern**  


```r
table(fb22$ziel)              # absolut
```

```
## 
## Wirtschaft   Therapie  Forschung     Andere 
##         20         80         32         17
```

```r
prop.table(table(fb22$ziel))  # relativ
```

```
## 
## Wirtschaft   Therapie  Forschung     Andere 
##  0.1342282  0.5369128  0.2147651  0.1140940
```

**Zentrale Tendenz und Dispersion für nominalskalierte Variablen: Modus, relativer Informationsgehalt**


```r
# Modus
which.max(table(fb22$ziel))
```

```
## Therapie 
##        2
```


```r
#relativer Informationsgehalt
hj <- prop.table(table(fb22$ziel))  # hj erstellen
ln_hj <- log(hj)                    # Logarithmus bestimmen
summand <- ln_hj * hj               # Berechnung fuer jede Kategorie
summe <- sum(summand)               # Gesamtsumme
k <- length(hj)                     # Anzahl Kategorien bestimmen
relInf <- -1/log(k) * summe         # Relativer Informationsgehalt
relInf
```

```
## [1] 0.8522699
```

Der Modus der Variable lautet Therapie - die meisten Ihres Jahrgangs (*n* = 80 bzw. 53.69%) streben einen Job in diesem Bereich an. Der relative Informationsgehalt der Variable beträgt 0.85. Sie sehen hier, dass wir im Code einen kleinen Unterschied zum Tutorial eingebaut haben. Die Anzahl der Kategorien wird nicht mehr durch `dim(tab)` sondern durch `length(hj)` bestimmt. Das Resultat ist nicht verschieden - die Anzahl der Kategorien wird gezählt. Wir wollen somit aber nochmal deutlich machen, dass es in `R` immer sehr viele Wege zu einem Ziel geben kann.

</details>



## Aufgabe 2

Die Variable `nr3` enthält die Angaben über das Ausmaß, in dem Sie und Ihre Kommilitonen:innen Ihre Verbindung zur Natur als Teil Ihrer Spiritualität ansehen.

* Bestimmen Sie für diese Variable den Modus.     
* Untersuchen Sie die Streuung für diese Variable optisch, indem Sie einen Boxplot erstellen.  
* Bestimmen Sie die Quartile und den Interquartilsbereich (IQB) auch als Zahlen.

<details><summary>Lösung</summary>

**Modus**


```r
which.max(table(fb22$nr3))
```

```
## 3 
## 3
```

**Häufigkeiten**


```r
table(fb22$nr3)
```

```
## 
##  1  2  3  4  5 
## 19 28 47 40 23
```

```r
prop.table(table(fb22$nr3))
```

```
## 
##         1         2         3         4         5 
## 0.1210191 0.1783439 0.2993631 0.2547771 0.1464968
```

Der Modus der Variable "nr3" beträgt 3, d.h. diese Antwortkategorie wurde am häufigsten genannt (*n* = 47 bzw. 29.94%).

**Boxplot**


```r
boxplot(fb22$nr3)
```

![](/lehre/statistik-i/deskriptiv-nominal-ordinal-loesungen_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

**Quartile**


```r
quantile(fb22$nr3, c(.25,.5,.75), na.rm=T)
```

```
## 25% 50% 75% 
##   2   3   4
```

Der Median beträgt 3. Das 1. und 3. Quartil betragen 2 bzw. 4. Folglich sind die Grenzen des Interquartilsbereich (IQB) 2 und 4. Der Interquartilsabstand (IQA) beträgt 2.

</details>


## Aufgabe 3

Erstellen Sie für die Variable `wohnen` eine geeignete Abbildung.   

* Stellen Sie sicher, dass die einzelnen Ausprägungen der Variable in der Darstellung interpretierbar benannt sind!  
* Dekorieren Sie diese Abbildung nach eigenen Wünschen (z.B. mit einer Farbpalette und Achsenbeschriftungen).
* Speichern Sie die Grafik per Syntax als .jpg-Datei mit dem Namen "Befragung-fb22.jpg" ab.

<details><summary>Lösung</summary>

**Faktor erstellen**


```r
fb22$wohnen <- factor(fb22$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))
```

**Default Darstellung und überarbeitete Grafik**

Um die Vergleichbarkeit zu erhöhen, wird im folgenden Code ein kleiner Trick angewendet. Die beiden Histogramme sollten am besten gleichzeitig unter **Plots** angezeigt werden. Durch die verwendete Funktion `par()` kann man verschiedene Plots gemeinsam in einem Fenster zeichnen. Das Argument bestimmt dabei, dass es eine Zeile und zwei Spalten für die Plots gibt.


```r
par(mfrow=c(1,2))

# Default
barplot(table(fb22$wohnen))

# Überarbeitet
barplot(
  # wichtig: Funktion auf Häufigkeitstabelle, nicht die Variable selbst anwenden:
  table(fb22$wohnen),                               
  # aussagekräftiger Titel, inkl. Zeilenumbruch ("\n") 
  main = "Befragung Erstis im WS 20/21:\nAktuelle Wohnsituation", 
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

![](/lehre/statistik-i/deskriptiv-nominal-ordinal-loesungen_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

**Speichern (per Syntax)**


```r
jpeg("Befragung-fb22.jpg", width=20, height=10, units="cm", res=200)
barplot(
  table(fb22$wohnen),                               
  main = "Befragung Erstis im WS 21/22:\nAktuelle Wohnsituation", 
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



