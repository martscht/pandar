---
title: "Einleitung und Wiederholung" 
type: post
date: '2020-10-06' 
slug: einleitung-fue
categories: ["FuE I"] 
tags: ["Einführung","Grundlagen"] 
subtitle: ''
summary: '' 
authors: [irmer] 
weight: 1
lastmod: '2024-02-19'
featured: no
banner:
  image: "/header/chalkboard_equation.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/562631)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/fue-i/einleitung-fue
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/fue-i/einleitung-fue.R
  - icon_pack: fas
    icon: pen-to-square
    name: Übungsdaten
    url: /lehre/fue-i/msc1-daten#Sitzung1
output:
  html_document:
    keep_md: true
---



## Einleitung
Im Verlauf des Seminars _Forschungsmethoden und Evaluation I_ soll neben der Einführung in die Theorie und Hintergründe multivariater Verfahren auch eine Einführung in deren Umsetzung gegeben werden, sodass Sie in der Lage sind, diese Verfahren in Ihrem zukünftigen akademischen und beruflichen Werdegang zu benutzen. `R` ist eine freie Software, die vor allem für (statistische) Datenanalysen verwendet wird. Bevor wir uns die Regressionsanalyse in `R` ansehen wollen, sollten Sie sich etwas mit `R` vertraut gemacht sowie die nötige Software (`R` als Programmiersprache und `R`-Studio als schöneres Interface) installiert haben. Hierzu eignet sich hervorragend der ebenfalls auf [{{< icon name="graduation-cap" pack="fas" >}} Pandar](https://pandar.netlify.com/) zu findende [{{< icon name="graduation-cap" pack="fas" >}}R-Crash Kurs](/lehre/statistik-i/crash-kurs). Dort gibt es die Intro und Installationsanweisung sowohl in deutscher als auch in englischer Sprache. _Wir gehen davon aus, dass Sie diese durchgearbeitetet haben und schauen uns als Einführung zunächst ein paar zentrale Befehle für das Dateneinlesen und -verarbeiten noch einmal an._

Nach dem Ende der Übung finden Sie in dem zu dieser Veranstaltung gehörenden OLAT Kurs Aufgaben (ein Quiz), die die Inhalte dieser Sitzung ergänzen. 


## Daten einlesen und verarbeiten
Falls Sie an der Goethe-Universität studiert haben, kennen Sie den Datensatz, den wir in dieser Sitzung untersuchen wollen, vielleicht aus dem Bachelorstudium: Eine Stichprobe von 100 Schülerinnen und Schülern hat einen Lese- und einen Mathematiktest, sowie zusätzlich einen allgemeinen Intelligenztest, bearbeitet. Im Datensatz enthalten ist zudem das Geschlecht (`female`, 0=m, 1=w). Sie können den [`{{< icon name="download" pack="fas" >}}` Datensatz "Schulleistungen.rda" hier herunterladen](/daten/Schulleistungen.rda).

### Daten laden
Der Datensatz ist im `R`-internen ".rda" Format abgespeichert - einem datensatzspezifischen Dateiformat. Wir können diesen Datensatz einfach mit der `load` Funktion laden. Wir müssen `R` nur mitteilen, wo der Datensatz liegt und è vola, er wird uns zur Verfügung gestellt. Liegt der Datensatz bspw. auf dem Desktop, so müssen wir den Dateipfad dorthin legen und können dann den Datensatz laden (wir gehen hier davon aus, dass Ihr PC "Musterfrau" heißt):


```r
load("C:/Users/Musterfrau/Desktop/Schulleistungen.rda")
```

Nun sollte in `R`-Studio oben rechts in dem Fenster unter der Rubrik "Data" unser Datensatz mit dem Namen "_Schulleistungen_" erscheinen. 

Bei Dateipfaden ist darauf zu achten, dass bei  Linux {{< icon name="linux" pack="fab" >}} oder Mac OS Rechnern {{< icon name="apple" pack="fab" >}} immer Front-Slashes ("/") zum Anzeigen von Hierarchien zwischen Ordnern verwendet werden, während auf Windows Rechnern {{< icon name="windows" pack="fab" >}} im System aber bei Dateipfaden mit Back-Slashes gearbeitet wird ("\\"). `R` nutzt auf Windows Rechnern {{< icon name="windows" pack="fab" >}} ebenfalls Front-Slashes ("/").  Das bedeutet, dass, wenn wir auf Windows Rechnern {{< icon name="windows" pack="fab" >}} den Dateipfad aus dem Explorer kopieren, wir die Slashes "umdrehen" müssen.

Genauso sind Sie in der Lage, den Datensatz direkt aus dem Internet zu laden. Hierzu brauchen Sie nur die URL und müssen `R` sagen, dass es sich bei dieser um eine URL handelt, indem Sie die Funktion `url` auf den Link anwenden. Der funktionierende Befehl sieht so aus (wobei die URL in Anführungszeichen geschrieben werden muss):


```r
load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))
```

An diesem Link erkennen wir, dass Websiten im Grunde auch nur schön dargestellte Ordnerstrukturen sind. So liegt auf der Pandar-Seite, die auf *netlify.app* gehostet wird, ein Ordner namens *daten*, in welchem wiederum das `Schulleistungen.rda` liegt.

### Ein Überblick über die Daten
Wir können uns die ersten (6) Zeilen des Datensatzes mit der Funktion `head` ansehen. Dazu müssen wir diese Funktion auf den Datensatz (das Objekt) `Schulleistungen` anwenden:


```r
head(Schulleistungen)
```

```
##   female        IQ  reading     math
## 1      1  81.77950 449.5884 451.9832
## 2      1 106.75898 544.8495 589.6540
## 3      0  99.14033 331.3466 509.3267
## 4      1 111.91499 531.5384 560.4300
## 5      1 116.12682 604.3759 659.4524
## 6      0 106.14127 308.7457 602.8577
```

Wir erkennen die 4 Spalten mit dem Geschlecht, dem IQ, der Lese- und der Mathematikleistung. Außerdem sehen wir, dass die Variablen mit den Namen `IQ`, `reading` und `math` einige Dezimalstellen aufweisen, was daran liegt, dass diese Daten simuliert wurden (allerdings echten Daten nachempfunden sind). Da es sich bei unserem Datensatz um ein Objekt vom Typ `data.frame` handelt, können wir die Variablennamen des Datensatzes außerdem mit der `names` Funktion abfragen. Weitere interessante Funktionen sind die `nrow` und `ncol` Funktion, die, wie Sie sich sicher schon gedacht haben, die Zeilen- und die Spaltenanzahl wiedergeben (wir könnten auch `dim` verwenden, was diese beiden Informationen auf einmal ausgibt). 


```r
# Namen der Variablen abfragen
names(Schulleistungen)
```

```
## [1] "female"  "IQ"      "reading" "math"
```

```r
# Anzahl der Zeilen
nrow(Schulleistungen)
```

```
## [1] 100
```

```r
# Anzahl der Spalten
ncol(Schulleistungen)
```

```
## [1] 4
```

```r
# Anzahl der Zeilen und Spalten kombiniert
dim(Schulleistungen)
```

```
## [1] 100   4
```

```r
# Struktur des Datensatzes - Informationen zu Variablentypen
str(Schulleistungen)
```

```
## 'data.frame':	100 obs. of  4 variables:
##  $ female : num  1 1 0 1 1 0 1 1 1 1 ...
##  $ IQ     : num  81.8 106.8 99.1 111.9 116.1 ...
##  $ reading: num  450 545 331 532 604 ...
##  $ math   : num  452 590 509 560 659 ...
```

Wir entnehmen dem Output, dass die Variablen im Datensatz `female`, `IQ`, `reading` und `math` heißen, dass insgesamt $n = 100$ Schulkinder zu 4 Merkmalen befragt/untersucht wurden und dass alle diese Variablen "_numerisch_", also als Zahlen, vorliegen. Eine einzelne Variable eines Datensatzes (vom Typ `data.frame`) können wir ansprechen, indem wir hinter den Datensatz `$` schreiben und anschließend den Variablennamen. Zugriff auf den `IQ` der Kinder erhalten wir mit:


```r
Schulleistungen$IQ
```

```
##   [1]  81.77950 106.75898  99.14033 111.91499 116.12682 106.14127  85.44854  93.24323 135.19738  89.90152
##  [11]  92.72073 115.90123 114.54088  83.28294 126.41670 107.20436  90.03418  98.34044 117.06874 115.55140
##  [21]  68.11351 125.64776  93.34804 106.93651  98.78466  78.93267 113.05378  92.86905  86.44483  70.17249
##  [31] 111.44613  93.78654  87.54754  87.01957  69.32581  92.85801  70.56712  74.17486 105.61195 110.63901
##  [41]  91.54624 105.73141 125.26215 101.14873 111.09582  79.99545  84.45429  84.50532  96.60821 103.90556
##  [51]  81.03395 126.12813  89.47650  80.78064 106.48847 103.58060  84.88878 115.90930  97.28407  91.60586
##  [61] 121.77877 110.26187 100.32137 112.65157 122.84032  96.45124  75.48471  91.27550 111.85776  92.72890
##  [71]  76.84326  92.93814 103.25579  81.15462  92.27190 106.40950  96.70280 104.06385 107.98499  60.76781
##  [81]  94.55947 103.55973 101.83276 113.06302  76.56824  97.56684 104.28662 106.08550 120.97759  82.65717
##  [91] 108.41181 103.38963 100.59534 122.79791  97.91853  92.96729  77.51862 105.01989  54.05485 106.12641
```
_**Tipp:** In `R`-Studio können Sie sich Ihren Umgang mit der Software in vielen Dingen vereinfachen, indem Sie die automatische Vervollständigung der Software nutzen. Dies tun Sie, indem Sie bspw. `Schulleistungen$` tippen und dann den Tabulator [oder "Strg" + "Leertaste" auf Windows {{< icon name="windows" pack="fab" >}} oder Linux Rechner {{< icon name="linux" pack="fab" >}} oder "Control" + "Leertaste" auf Mac OS Rechnern {{< icon name="apple" pack="fab" >}}] auf Ihrer Tastatur drücken. Ihnen werden dann Vorschläge für mögliche Argumente aufgezeigt. Das gleiche funktioniert auch in Funktionen. Hier müssen Sie zunächst den Funktionsnamen schreiben und die Klammern öffnen. Mit dem Tabulator erhalten Sie anschließend Vorschläge für mögliche Argumente, die Sie der Funktion übergeben können. Schauen Sie sich dies doch einmal an! Dies funktioniert übrigens auch für das Vervollständigen von Dateipfaden. Hierbei muss allerdings darauf geachtet werden, dass diese in Anführungsstrichen geschrieben werden und Sie müssen beachten, wo ihr aktuelles Working-Directory liegt. Sie können allerdings auch den vollständigen Pfad eingeben, indem Sie auf Windows PCs {{< icon name="windows" pack="fab" >}} mit "C:/Users/" und auf Mac OS Rechnern {{< icon name="apple" pack="fab" >}} mit "/Users/" beginnen und dann den Tabulator drücken und den jeweilig richtigen Ordner auswählen, bis Sie an Ihrer Zieldatei angekommen sind!_


### Einfache Deskriptivstatistiken
Bevor wir jetzt direkt zu komplexeren Analysen springen, wollen wir uns noch schnell mit dem Bestimmen einfacher deskriptivstatistischer Größen vertraut machen. Mit der Funktion `sum` können wir die Summe und mit `mean` können wir den Mittelwert einer Variable bestimmen. Eine Schätzung für die Populationsvarianz erhalten wir mit `var`. Die zugehörige Populationsschätzung für die Standardabweichung, Sie vermuten es vielleicht, erhalten wir mit `sd`. _Es handelt sich hierbei um Populations- und nicht um Stichprobenschätzungen, da in diesen Funktionen der Vorfaktor $\frac{1}{n-1}$ genutzt wird, um einen unverzerrten Schätzer für eben die Variation in der Population zu erhalten (für mehr Informationen siehe bspw. [Eid, Gollwitzer und Schmitt, 2017](https://ubffm.hds.hebis.de/Record/HEB366849158), S. 162-163 in Kapitel 6.4.4 und S. 246-247 in Kapitel 8.5.1 oder [Agresti, & Finlay, 2013](https://ubffm.hds.hebis.de/Record/HEB369761391), Kapitel 3.2 und folgend)._


```r
# Summe
sum(Schulleistungen$IQ)
```

```
## [1] 9813.425
```

```r
# Mittelwert
mean(Schulleistungen$IQ)
```

```
## [1] 98.13425
```

```r
1/100*sum(Schulleistungen$IQ) # auch der Mittelwert
```

```
## [1] 98.13425
```

```r
# Varianz
var(Schulleistungen$IQ)
```

```
## [1] 248.1075
```

```r
# SD
sd(Schulleistungen$IQ)
```

```
## [1] 15.75143
```

```r
sqrt(var(Schulleistungen$IQ)) # die Wurzel aus der Varianz ist die SD, hier: sqrt() ist die Wurzel Funktion
```

```
## [1] 15.75143
```

Mit `summary` können wir uns die Zusammenfassung einer Variable ansehen. 

```r
summary(Schulleistungen$IQ)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   54.05   87.42   98.56   98.13  108.09  135.20
```
Als Ausgabe erhalten wir den kleinsten Wert 54.05 (das Minimum, welches hier bspw. auf 2 Nachkommastellen gerundet ist; Originalwert = 54.0548457), das erste Quartil 87.42, also den 25.-Prozentrang (25% PR), den Median 98.56 (2. Quartil; 50% PR),  den Mittelwert 98.13, das 3. Quartil 108.09 (75% PR) und den größten Wert 135.2 (Maximum). Wenden wir diese Funktion auf ein `R`-Objekt an, so gibt uns diese eine Zusammenfassung dieses Objekts aus, was häufig auch einfach die Zusammenfassung einer Analyse ist. Dies schauen wir uns später nochmals genauer an.

Als letztes gucken wir uns noch den Befehl `colMeans` an, welcher Mittelwerte eines Datensatzes über die Spalten (also pro Variable über alle Personen) bestimmt. Somit lassen sich ganz einfach für alle Variablen eines Datensatzes auf einmal die Mittelwerte bestimmen (`rowMeans` bestimmt, wie Sie sich wahrscheinlich denken, die Mittelwerte pro Zeile, also die Mittelwerte über alle Variablen pro Person):


```r
colMeans(Schulleistungen)
```

```
##    female        IQ   reading      math 
##   0.54000  98.13425 496.06605 561.46446
```

Da `female` 0-1 kodiert ist und `1` für Mädchen steht, bedeutet die hier beobachtete Zahl von .54, dass gerade ca. 54% der Proband*innen weiblich waren. 

## Der $t$-Test
Ein sehr einfacher statistischer Test, ist der $t$-Test (für eine Wiederholung siehe bspw. [Eid, et al., 2017](https://ubffm.hds.hebis.de/Record/HEB366849158), Kapitel 11.1 oder [Agresti, & Finlay, 2013,](https://ubffm.hds.hebis.de/Record/HEB369761391) Kapitel 6.2 und folgend). Mit Hilfe dieses Tests soll untersucht werden, ob die Mittelwerte in zwei Gruppen gleich sind. Dazu brauchen wir drei wichtige Annahmen: 

  1) die Beobachtungen stammen aus einer _independent and identically distributed_ (i.i.d., deutsch: unabhängig und identisch verteilt) Population (dies bedeutet, dass alle Beobachtungen unabhängig sind und den gleichen Verteilungs- und Modellannahmen unterliegen), 
  2) die Daten in beiden Gruppen sind normalverteilt mit 
  3) gleicher Varianz (Varianzhomogenität). 

Die 1. Annahme ist sehr kritisch und lässt sich leider nicht prüfen. Sie lässt sich aber durch das Studiendesign zumindest plausibilisieren. Für die anderen beiden Annahmen gibt es verschiedene Tests und deskriptive Verfahren, um ein Gefühl für ihr Vorliegen zu erhalten - diese schauen wir uns in der nächsten Sitzung zur Regression an. Unter diesen Annahmen stellen wir die folgenden Null-Hypothese auf - die Gleichheit der Mittelwerte in den beiden Gruppen:
$$H_0: \mu_1=\mu_2$$
