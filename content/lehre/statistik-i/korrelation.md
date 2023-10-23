---
title: "Korrelation" 
type: post
date: '2021-01-04'
slug: korrelation 
categories: ["Statistik I"] 
tags: ["Korrelation", "Grundlagen", "Hilfe"] 
subtitle: ''
summary: '' 
authors: [nehler, winkler, schroeder, neubauer]
weight: 8
lastmod: '2023-10-23'
featured: no
banner:
  image: "/header/BSc2_Korrelation.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1217289)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/korrelation
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-i/korrelation.R
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/korrelation-aufgaben
output:
  html_document:
    keep_md: true
---




{{< spoiler text = "Kernfragen dieses Beitrags" >}}
* Wie können [Kreuztabellen](#Kreuztabellen) in R erstellt werden? Welche Varianten gibt es, [relative Häufigkeitstabellen](#Relativtabelle) zu erstellen?
* Wie kann ein gemeinsames [Balkendiagramm](#Balkendiagramm) für zwei Variablen erstellt werden?
* Welche zwei Varianten gibt es, [Varianzen und Kovarianzen](#Ko_Varianz) zu bestimmen?
* Wie kann die [Produkt-Moment-Korrelation](#PMK), die [Rang-Korrelation nach Spearman](#Rs) und [Kendalls $\tau$](#tau) bestimmt werden?
* Wie wird bei der Berechnung von [Korrelationen mit fehlenden Werten](#NA) umgegangen?
{{< /spoiler >}}

***


## Vorbereitende Schritte {#prep}

Zu Beginn laden wir wie gewohnt den Datensatz und verteilen die relevanten Labels. Beachten Sie, dass diese Befehle bereits angewendet wurden. Wenn Sie die veränderten Daten abgespeichert oder noch aktiv haben, sind die folgenden Befehle natürlich nicht nötig.


```r
#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb23.rda')) 

# Nominalskalierte Variablen in Faktoren verwandeln

fb23$fach <- factor(fb23$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb23$ziel <- factor(fb23$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))

fb23$wohnen <- factor(fb23$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

fb23$ort <- factor(fb23$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb23$job <- factor(fb23$job, levels=c(1,2), labels=c("nein", "ja"))

# Weitere Standardisierungen
fb23$nerd_std <- scale(fb23$nerd)
fb23$neuro_std <- scale(fb23$neuro)
```

****

## Häufigkeitstabellen

Die Erstellung von *Häufigkeitstabellen* zur Darstellung univariater Häufigkeiten haben Sie schon kennengelernt. Dies funktioniert mit einfachen Befehlen für die Häufigkeiten und die zugehörigen relativen Prozentzahlen.



```r
tab <- table(fb23$fach)               #Absolut
tab
```

```
## 
##  Allgemeine Biologische Entwicklung   Klinische Diag./Meth. 
##          30          31          19          82           5
```

```r
prop.table(tab)                       #Relativ
```

```
## 
##  Allgemeine Biologische Entwicklung   Klinische Diag./Meth. 
##  0.17964072  0.18562874  0.11377246  0.49101796  0.02994012
```

{{<intext_anchor Kreuztabellen>}}

Die Erweiterung für den bivariaten Fall ist dabei nicht schwierig und wird als *Kreuztabelle* bezeichnet. Sie liefert die Häufigkeit von Kombinationen von Ausprägungen in mehreren Variablen. In den Zeilen wird die erste Variable abgetragen und in den Spalten die zweite. Im Unterschied zum univariaten Fall muss im `table()`-Befehl nur die zweite interessierende Variable zusätzlich genannt werden. Tabellen können beliebig viele Dimensionen haben, werden dann aber sehr unübersichtlich.


```r
tab<-table(fb23$fach,fb23$ziel)       #Kreuztabelle
tab
```

```
##              
##               Wirtschaft Therapie Forschung Andere
##   Allgemeine           7       12         7      4
##   Biologische          5       10        13      3
##   Entwicklung          1        9         3      6
##   Klinische            1       72         3      4
##   Diag./Meth.          1        0         3      1
```

In eine Kreuztabelle können Randsummen mit dem `addmargins()` Befehl hinzugefügt werden. Randsummen erzeugen in der letzten Spalte bzw. Zeile die univariaten Häufigkeitstabellen der Variablen.


```r
addmargins(tab)                       #Randsummen hinzufügen
```

```
##              
##               Wirtschaft Therapie Forschung Andere Sum
##   Allgemeine           7       12         7      4  30
##   Biologische          5       10        13      3  31
##   Entwicklung          1        9         3      6  19
##   Klinische            1       72         3      4  80
##   Diag./Meth.          1        0         3      1   5
##   Sum                 15      103        29     18 165
```

{{<intext_anchor Relativtabelle>}}

Auch für die Kreuztabelle ist die Möglichkeit der Darstellung der Häufigkeiten in Relation zur Gesamtzahl der Beobachtungen gegeben. 


```r
prop.table(tab)                       #Relative Häufigkeiten
```

```
##              
##                Wirtschaft    Therapie   Forschung      Andere
##   Allgemeine  0.042424242 0.072727273 0.042424242 0.024242424
##   Biologische 0.030303030 0.060606061 0.078787879 0.018181818
##   Entwicklung 0.006060606 0.054545455 0.018181818 0.036363636
##   Klinische   0.006060606 0.436363636 0.018181818 0.024242424
##   Diag./Meth. 0.006060606 0.000000000 0.018181818 0.006060606
```

72 von insgesamt 165 (43.64%)  wollen therapeutisch arbeiten *und* interessieren sich bisher am meisten für die klinische Psychologie.


`prob.table()` kann allerdings nicht nur an der Gesamtzahl relativiert werden, sondern auch an der jeweiligen Zeilen- oder Spaltensumme. Dafür gibt man im Argument `margin` für Zeilen `1` oder für Spalten `2` an.


```r
prop.table(tab, margin = 1)           #relativiert an Zeilen
```

```
##              
##               Wirtschaft   Therapie  Forschung     Andere
##   Allgemeine  0.23333333 0.40000000 0.23333333 0.13333333
##   Biologische 0.16129032 0.32258065 0.41935484 0.09677419
##   Entwicklung 0.05263158 0.47368421 0.15789474 0.31578947
##   Klinische   0.01250000 0.90000000 0.03750000 0.05000000
##   Diag./Meth. 0.20000000 0.00000000 0.60000000 0.20000000
```

Von 80 Personen, die sich am meisten für klinische Psychologie interessieren, wollen 90% (nämlich 72 Personen) später therapeutisch arbeiten.


```r
prop.table(tab, margin = 2)           #relativiert an Spalten
```

```
##              
##               Wirtschaft   Therapie  Forschung     Andere
##   Allgemeine  0.46666667 0.11650485 0.24137931 0.22222222
##   Biologische 0.33333333 0.09708738 0.44827586 0.16666667
##   Entwicklung 0.06666667 0.08737864 0.10344828 0.33333333
##   Klinische   0.06666667 0.69902913 0.10344828 0.22222222
##   Diag./Meth. 0.06666667 0.00000000 0.10344828 0.05555556
```

Von 103 Personen, die später therapeutisch arbeiten wollen, interessieren sich 69.9% (nämlich 72 Personen) für die klinische Psychologie.


`addmargins()`und `prop.table()` können beliebig kombiniert werden.
`prop.table(addmargins(tab))` behandelt die Randsummen als eigene Kategorie (inhaltlich meist unsinnig!).
`addmargins(prop.table(tab))` liefert die Randsummen der relativen Häufigkeiten.


```r
addmargins(prop.table(tab))      # als geschachtelte Funktion
```

```
##              
##                Wirtschaft    Therapie   Forschung      Andere         Sum
##   Allgemeine  0.042424242 0.072727273 0.042424242 0.024242424 0.181818182
##   Biologische 0.030303030 0.060606061 0.078787879 0.018181818 0.187878788
##   Entwicklung 0.006060606 0.054545455 0.018181818 0.036363636 0.115151515
##   Klinische   0.006060606 0.436363636 0.018181818 0.024242424 0.484848485
##   Diag./Meth. 0.006060606 0.000000000 0.018181818 0.006060606 0.030303030
##   Sum         0.090909091 0.624242424 0.175757576 0.109090909 1.000000000
```

```r
prop.table(tab) |> addmargins()  # als Pipe
```

```
##              
##                Wirtschaft    Therapie   Forschung      Andere         Sum
##   Allgemeine  0.042424242 0.072727273 0.042424242 0.024242424 0.181818182
##   Biologische 0.030303030 0.060606061 0.078787879 0.018181818 0.187878788
##   Entwicklung 0.006060606 0.054545455 0.018181818 0.036363636 0.115151515
##   Klinische   0.006060606 0.436363636 0.018181818 0.024242424 0.484848485
##   Diag./Meth. 0.006060606 0.000000000 0.018181818 0.006060606 0.030303030
##   Sum         0.090909091 0.624242424 0.175757576 0.109090909 1.000000000
```

****

## Balkendiagramme {#Balkendiagramm .anchorheader}

Grafisch kann eine solche Kreuztabelle durch gruppierte Balkendiagramme dargestellt werden. Das Argument `beside` sorgt für die Anordnung der Balken (bei `TRUE` nebeneinander, bei `FALSE` übereinander). Das Argument `legend` nimmt einen Vektor für die Beschriftung entgegen. Die Zeilen des Datensatzes bilden dabei stets eigene Balken, während die Spalten die Gruppierungsvariable bilden. Deshalb müssen als Legende die Namen der Reihen `rownames()` unserer Tabelle `tab` ausgewählt werden.


```r
barplot (tab,
         beside = TRUE,
         col = c('mintcream','olivedrab','peachpuff','steelblue','maroon'),
         legend = rownames(tab))
```

![](/lehre/statistik-i/korrelation_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

****

## Varianz, Kovarianz und Korrelation {#Ko_Varianz .anchorheader}

In der Vorlesungen haben Sie gelernt, dass es für *Kovarianzen* und *Varianzen* empirische und geschätzte Werte gibt. R berechnet standardmäßig für die Varianz und Kovarianz die *Populationsschätzer*, verwendet also folgende Formeln für Varianz

{{< math >}}
<div class="big-maths">
\begin{equation}
\small
\hat{\sigma}^2_{X} = \frac{\sum_{m=1}^n (y_m - \bar{y})^2}{n-1}
\end{equation}
</div>
{{< /math >}}


und Kovarianz.

{{< math >}}
<div class="big-maths">
\begin{equation}
\small
\hat{\sigma}_{XY} = \frac{\sum_{m=1}^n (x_m - \bar{x}) \cdot (y_m - \bar{y})}{n-1}
\end{equation}
</div>
{{< /math >}}

### Funktionen und Behandlung fehlender Werte

Die Funktionen für die Varianz ist dabei `var()`. Im Folgenden wird diese für die Variablen `neuro` (Neurotizismus) und `gewis` (Gewissenhaftigkeit) aus dem Datensatz bestimmt. Als Argumente müssen jeweils die Variablennamen verwendet werden.
Wie bereits in vergangenen Sitzungen gesehen, führen fehlende Werte zu der Ausgabe `NA`. Um dies vorzubeugen, wird im univariaten Fall `na.rm = TRUE` zum Ausschluss verwendet. 


```r
var(fb23$neuro, na.rm = TRUE)            #Varianz Neurotizismus
```

```
## [1] 0.9591206
```

```r
var(fb23$gewis, na.rm = TRUE)            #Varianz Gewissenhaftigkeit
```

```
## [1] 0.5875337
```


Die Funktion `cov()` wird für die Kovarianz verwendet und benötigt als Argumente die Variablen. 


```r
cov(fb23$neuro, fb23$gewis)              #Kovarianz Neurotizismus und Gewissenhaftigkeit
```

```
## [1] -0.02219729
```
Da Kovarianzen unstandardisierte Kennzahlen sind, können wir Kovarianzen nicht pauschal nach ihrer Höhe beurteilen. Die Höhe hängt beispielsweise von der Antwortskala ab. 

{{<intext_anchor NA>}}

Natürlich können auch bei der Kovarianzberechnung fehlende Werte zu einem Problem werden. Hier demonstriert am Beispiel der Lebenszufriedenheit (`lz`) und der Verträglichkeit (`vertr`).


```r
cov(fb23$vertr, fb23$lz)              #Kovarianz Verträglichkeit und Lebenszufriedenheit
```

```
## [1] NA
```

Zur Bewältigung des Problems gibt es das Argument `use`, das mehr Flexibilität bietet, als `na.rm` bei der univariaten Betrachtung. Diese Flexibilität setzt aber nur deutlich ein, wenn mehr als zwei Variablen gleichzeitig betrachtet werden. Wir werden gleich also alle vier bisher betrachteten Variablen in eine Analyse zusammenlegen. Zunächst aber eine kurze Zusammenfassung von den drei häufigsten Optionen:

* *Nutzung aller Beobachtungen*: Alle Zeilen (also Personen) gehen in die Berechnung aller Werte mit ein.
* *Listenweiser Fallausschluss*: Personen, die auf (mindestens) einer von **allen** Variablen `NA` haben, werden von der Berechnung ausgeschlossen.
* *Paarweiser Fallausschluss*: Personen, die auf (mindestens) einer von **zwei** Variablen `NA` haben, werden von der Berechnung ausgeschlossen.

Am besten lässt sich der Unterschied in einer *Kovarianzmatrix* veranschaulichen. Hier werden alle Varianzen und Kovarianzen von einer Menge an Variablen berechnet und in einer Tabelle darstellt. Dafür kann ein Datensatz erstellt werden, der nur die interessierenden Variablen enthält. Wir nehmen alle vier Variablen aus unseren Beispielen zur Kovarianzen auf.


```r
na_test <- fb23[, c('vertr','gewis',"neuro",'lz')] #Datensatzreduktion
cov(na_test)                                       #Kovarianzmatrix   
```

```
##       vertr       gewis       neuro lz
## vertr    NA          NA          NA NA
## gewis    NA  0.58753374 -0.02219729 NA
## neuro    NA -0.02219729  0.95912058 NA
## lz       NA          NA          NA NA
```

Hier können wir ein deutliches Muster erkennen. Da sowohl `gewis` als auch `neuro` keine fehlenden Werte enthalten, wird die Kovarianz und die Varianz (auf der Diagonalen, da die Kovarianz einer Variable mit sich selbst die Varianz ist) ausgegeben. Für die Variablen mit fehlenden Werten (`lz` und `vertr`) bekommen wir jedoch nur `NA` zurück. 

Das Argument `use` haben wir innerhalb unserer `cov()` Funktion gar nicht angegeben. Das deutet darauf hin, dass es hier einen Default gibt. Nach dem Muster können wir uns erschließen, dass dieser `"everything"` entsprechen muss. Da alle Zeilen einfach in die Berechnung eingehen, werden `NA`-Werte nicht ausgeschlossen und für manche Zusammenhänge daher keine Kennwerte erzeugt. Wir können diese Schlussfolgerug auch nochmal überprüfen.


```r
cov(na_test, use = "everything")         # Kovarianzmatrix mit Argument   
```

```
##       vertr       gewis       neuro lz
## vertr    NA          NA          NA NA
## gewis    NA  0.58753374 -0.02219729 NA
## neuro    NA -0.02219729  0.95912058 NA
## lz       NA          NA          NA NA
```

Die Ergebnisse sind exakt gleich mit den vorherigen - `"everything"` ist also der Default für diese Funktion. Nach dieser ersten Erkenntnis können wir die verschiedenen Argumente für die Behandlung von `NA` in der `cov()` Funktion ausprobieren. 

Beginnen wir mit dem *paarweisem Fallausschluss*, der mit `"pairwise"` angesprochen werden kann. 


```r
cov(na_test, use = 'pairwise')             #Paarweiser Fallausschluss
```

```
##              vertr        gewis       neuro         lz
## vertr  0.675212658 -0.008752301  0.10793976  0.1530909
## gewis -0.008752301  0.587533739 -0.02219729  0.1068984
## neuro  0.107939758 -0.022197288  0.95912058 -0.2757704
## lz     0.153090909  0.106898433 -0.27577042  1.1127992
```

Wie wir sehen, werden nun die Personen mit fehlenden Werten auf einer Variable ignoriert, wenn für die Variable mit fehlendem Wert ein Zusammenhangsmaß berechnet wird. Ansonsten werden Personen aber nicht aus der Berechnung ausgeschlossen, was man vor allem daran sieht, dass sich die Kovarianzen (und Varianzen) von Variablen ohne fehlende Werte (`gewis` und `neuro`) nicht verändert haben. 

Vergleichen wir nun dieses Ergebnis noch mit dem Ergebnis des *listenweisem Fallausschluss*.

```r
cov(na_test, use = 'complete')             #Listenweiser Fallausschluss
```

```
##             vertr       gewis       neuro         lz
## vertr  0.67061688 -0.02180195  0.11443182  0.1530909
## gewis -0.02180195  0.58291396 -0.01890422  0.1076104
## neuro  0.11443182 -0.01890422  0.96031656 -0.2736364
## lz     0.15309091  0.10761039 -0.27363636  1.1178390
```

Wie wir sehen, unterscheiden sich die Werte von dem paarweise Fallausschluss. Das liegt daran, dass hier Personen mit fehlenden Werten aus der kompletten Berechnung ausgeschlossen werden. Selbst wenn sie nur auf der Lebenszufriedenheit (`lz`) einen fehlenden Wert haben, gehen sie nicht in die Berechnung des Zusammenhangs zwischen bspw. Verträglichkeit und Neurotizismus (`vertr` und `neuro`) ein. 

Nochmal deutlicher wird das Verhalten, wenn wir uns die Werte für die eigentlich komplett beobachteten Variablen Gewissenhaftigkeit und Neurotizismus (`gewis` und `neuro`) anschauen. Auch hier verändern sich die Werte im Vergleich zu den beiden bisherigen Ergebnissen, denn die Regel sagt nunmal, dass Personen mit einem fehlenden Wert auf irgendeiner der interessierenden Variablen ausgeschlossen werden - also natürlich auch an dieser Stelle. 

### Grafische Darstellung

Der Zusammenhang zwischen zwei Variablen kann in einem *Scatterplot* bzw. *Streupunktdiagramm* dargestellt werden. Dafür kann man die `plot()` Funktion nutzen. Als Argumente können dabei `x` für die Variable auf der x-Achse, `y` für die Variable auf der y-Achse, `xlim`, `ylim` für eventuelle Begrenzungen der Achsen und `pch` für die Punktart angegeben werden.


```r
plot(x = fb23$neuro, y = fb23$gewis, xlim = c(1,5) , ylim = c(1,5))
```

![](/lehre/statistik-i/korrelation_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

{{<intext_anchor PMK>}}

Wie in der Vorlesung besprochen, sind für verschiedene Skalenniveaus verschiedene Zusammenhangsmaße verfügbar, die im Gegensatz zur Kovarianz auch eine Vergleichbarkeit zwischen zwei Zusammenhangswerten sicherstellen. Für zwei metrisch skalierte Variablen gibt es dabei die *Produkt-Moment-Korrelation*. In der Funktion `cor()` werden dabei die Argumente `x` und `y` für die beiden betrachteten Variablen benötigt. `use` beschreibt weiterhin den Umgang mit fehlenden Werten.


```r
cor(x = fb23$neuro, y = fb23$gewis, use = 'pairwise')
```

```
## [1] -0.0295697
```

Bei einer positiven Korrelation gilt „je mehr Variable x... desto mehr Variable y" bzw. umgekehrt, bei einer negativen Korrelation „je mehr Variable x... desto weniger Variable y" bzw. umgekehrt. Korrelationen sind immer ungerichtet, das heißt, sie enthalten keine Information darüber, welche Variable eine andere vorhersagt - beide Variablen sind gleichberechtigt. Korrelationen (und Regressionen, die wir später [in einem Tutorial](/post/regression) kennen lernen werden) liefern *keine* Hinweise auf Kausalitäten. Sie sagen beide etwas über den (linearen) Zusammenhang zweier Variablen aus.

In R können wir uns auch eine *Korrelationsmatrix* ausgeben lassen. Dies geschieht äquivalent zu der Kovarianzmatrix mit dem Datensatz als Argument in der `cor()` Funktion. In der Diagonale stehen die Korrelationen der Variable mit sich selbst - also 1 - und in den restlichen Feldern die Korrelationen der Variablen untereinander.


```r
cor(na_test, use = 'pairwise')
```

```
##             vertr       gewis      neuro         lz
## vertr  1.00000000 -0.01385684  0.1344812  0.1768164
## gewis -0.01385684  1.00000000 -0.0295697  0.1331052
## neuro  0.13448117 -0.02956970  1.0000000 -0.2660864
## lz     0.17681640  0.13310524 -0.2660864  1.0000000
```


Die Stärke des korrelativen Zusammenhangs wird mit dem Korrelationskoeffizienten ausgedrückt, der zwischen -1 und +1 liegt. 
Die default-Einstellung bei `cor()`ist die *Produkt-Moment-Korrelation*, also die Pearson-Korrelation.


```r
cor(fb23$neuro, fb23$gewis, use = "pairwise", method = "pearson")
```

```
## [1] -0.0295697
```


Achtung! Die inferenzstatistische Testung der Pearson-Korrelation hat gewisse Voraussetzungen, die vor der Durchführung überprüft werden sollten!

### Voraussetzungen Pearson-Korrelation

1. *Skalenniveau*: intervallskalierte Daten $\rightarrow$ ok (Ratingskalen werden meist als intervallskaliert aufgefasst, auch wenn das nicht 100% korrekt ist)  
2. *Linearität*: Zusammenhang muss linear sein $\rightarrow$ grafische Überprüfung (siehe  Scatterplot)  
3. *Normalverteilung*: Variablen müssen normalverteilt sein $\rightarrow$ QQ-Plot, Histogramm oder Shapiro-Wilk-Test  

#### zu 3. Normalverteilung

$\rightarrow$ QQ-Plot, Histogramm & Shapiro-Wilk-Test


```r
#QQ
qqnorm(fb23$neuro)
qqline(fb23$neuro)
```

![](/lehre/statistik-i/korrelation_files/figure-html/unnamed-chunk-21-1.png)<!-- -->

```r
qqnorm(fb23$gewis)
qqline(fb23$gewis)
```

![](/lehre/statistik-i/korrelation_files/figure-html/unnamed-chunk-21-2.png)<!-- -->

```r
#Histogramm

hist(fb23$neuro, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb23$neuro, na.rm = T), sd = sd(fb23$neuro, na.rm = T)), col = "blue", add = T)  
```

![](/lehre/statistik-i/korrelation_files/figure-html/unnamed-chunk-21-3.png)<!-- -->

```r
hist(fb23$gewis, prob = T, ylim = c(0,1))
curve(dnorm(x, mean = mean(fb23$gewis, na.rm = T), sd = sd(fb23$gewis, na.rm = T)), col = "blue", add = T)
```

![](/lehre/statistik-i/korrelation_files/figure-html/unnamed-chunk-21-4.png)<!-- -->

```r
#Shapiro
shapiro.test(fb23$neuro)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb23$neuro
## W = 0.9603, p-value = 5.928e-05
```

```r
shapiro.test(fb23$gewis)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb23$gewis
## W = 0.95577, p-value = 2.097e-05
```

$p < \alpha$ $\rightarrow$ H1: Normalverteilung kann nicht angenommen werden. Somit ist diese Voraussetzung verletzt. Eine Möglichkeit damit umzugehen, ist die Rangkorrelation nach Spearman. Diese ist nicht an die Voraussetzung der Normalverteilung gebunden. Das Verfahren kann über `method = "spearman"` angewendet werden.

{{<intext_anchor Rs>}}

#### Rangkorrelation in R


```r
r1 <- cor(fb23$neuro,fb23$gewis,
          method = "spearman",     #Pearson ist default
          use = "complete") 

r1
```

```
## [1] -0.02323815
```


#### Interpretation des deskriptiven Zusammenhangs:
Es handelt sich um eine positive Korrelation von _r_ = -0.02. Der Effekt ist nach Cohens (1988) Konvention als schwach bis mittelstark zu bewerten. Je höher die Ausprägung in Neurotizismus, desto höher ist die Ausprägung in der Gewissenhaftigkeit und anders herum. 

#### Cohens (1988) Konvention zur Interpretation von $|r|$

* ~ .10: schwacher Effekt  
* ~ .30: mittlerer Effekt  
* ~ .50: starker Effekt 

{{<intext_anchor tau>}}

Als weitere Variante der Rangkorrelation gibt es noch Kendalls $\tau$. Diese kann man mit `method = "kendall"` angesprochen werden.


```r
cor(fb23$neuro, fb23$gewis, use = 'complete', method = 'kendall')
```

```
## [1] -0.02173303
```
Die Interpretation erfolgt wie bei Spearman's Rangkorrelation. 

**Signifikanztestung des Korrelationskoeffizienten:**
Nachdem der Korrelationskoeffizient berechnet wurde, kann dieser noch auf Signifikanz geprüft werden. Dazu verwenden wir die `cor.test()`-Funktion.

* *H0*: $\rho = 0$ $\rightarrow$ es gibt keinen Zusammenhang zwischen Neurotizismus und Gewissenhaftigkeit
* *H1*: $\rho \neq 0$ $\rightarrow$  es gibt einen Zusammenhang zwischen Neurotizismus und Gewissenhaftigkeit


```r
cor <- cor.test(fb23$neuro, fb23$gewis, 
         alternative = "two.sided", 
         method = "spearman",      #Da Voraussetzungen für Pearson verletzt
         use = "complete")
```

```
## Warning in cor.test.default(fb23$neuro, fb23$gewis, alternative =
## "two.sided", : Cannot compute exact p-value with ties
```

```r
cor$p.value      #Gibt den p-Wert aus
```

```
## [1] 0.7574974
```

Anmerkung: Bei der Rangkorrelation kann der exakte p-Wert nicht berechnet werden, da gebundene Ränge vorliegen. Das Ergebnis ist allerdings sehr eindeutig: $p > \alpha$ $\rightarrow$ H1. Die Korrelation ist mit einer Irrtumswahrscheinlichkeit von 5% signifikant von 0 verschieden. Daraus würde sich die folgende Interpretation ergeben:

**Ergebnisinterpretation:**
Es wurde untersucht, ob Neurotizismus und Gewissenhaftigkeit miteinander zusammenhängen. Der spearman-Korrelationskoeffizient beträgt -0.02 und ist statistisch signifikant (_p_ = 0.757). Folglich wird die Nullhypothese hier verworfen: Neurotizismus und Gewissenhaftigkeit weisen einen signifikanten Zusammenhang auf.

**Modifikation**
Wir haben in der Funktion `cor.test()` als Argument `method = "spearman"` eingegeben, da die Voraussetzungen für die Pearson-Korrelation nicht erfüllt waren. Wenn dies der Fall gewesen wäre, müsste man stattdessen `method = "pearson"` angeben:


```r
cor.test(fb23$neuro, fb23$gewis, 
         alternative = "two.sided", 
         method = "pearson",       
         use = "complete")
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  fb23$neuro and fb23$gewis
## t = -0.39357, df = 177, p-value = 0.6944
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.1754809  0.1176127
## sample estimates:
##        cor 
## -0.0295697
```



***

## Vertiefung: Wie können Zusammenhangsmaße für ordinalskalierte Daten berechnet werden?
	
_In diesem Abschnitt wird vertiefend die Bestimmung von Zusammenhangsmaßen für ordinalskalierte Variablen besprochen. Den dazugehörigen Auszug aus den Vorlesungsfolien, der in diesem Jahr herausgekürzt wurde, finden Sie [hier](/post/Bonus_Korrelation.pdf)._

Ordinalskalierte Daten können aufgrund der Verletzung der Äquidistanz zwischen bspw. Antwortstufen eines Items eines Messinstrumentes nicht schlicht mittels Pearson-Korrelation in Zusammenhang gesetzt werden. Zudem sind oft Verteilungsannahmen bei ordinalskalierten Variablen verletzt. Der Koeffizient $\hat{\gamma}$ ist zur Betrachtung solcher Zusammenhänge am besten geeignet (sogar besser als Spearman's und Kendalls's Rangkorrelation). Er nimmt - ähnlich wie Spearman's und Kendall's Koeffizenten - weder eine gewisse Verteilung der Daten an, noch deren Äquidistanz.

Zur Berechnung dieses Koeffizienten müssen wir das Paket `rococo` installieren, welches verschiedene Konkordanz-basierte Zusammenhangsmaße enthält. Die Installation muss dem Laden des Paketes logischerweise vorausgestellt sein. Wenn R einmal geschlossen wird, müssen alle Zusatzpakete neu geladen, jedoch nicht neu installiert werden.


```r
install.packages('rococo')          #installieren
```


```r
library(rococo)                     #laden
```

Übersichten über Pakete kann man mit `??` erhalten.


```r
??rococo
```

Die Funktion heißt hier zufälligerweise genau gleich wie das Paket. Wenn man nur Informationen über die Funktion statt dem Paket sucht, geht das anhand von `?`.


```r
?rococo
```

Dank des neuen Pakets können wir nun den Koeffizienten $\hat{\gamma}$ berechnen und damit den Zusammenhang zwischen Items betrachten. Schauen wir uns nun mal den Zusammenhang der beiden Prokrastinationsitems `prok1` und `prok9` an, um zu überprüfen, ob die beiden Items auch (wie beabsichtigt) etwas Ähnliches messen (nähmlich Prokrastionationstendenz). Die beiden Variablen wurden ursprünglich auf einer Skala von 1 (*stimmt nicht*) bis 4 (*stimmt genau*) (also auf Ordinalskalenniveau) erfasst. 


```r
rococo(fb23$mdbf2_pre, fb23$mdbf3_pre)
```

```
## [1] -0.4482018
```

Um zu überprüfen, ob zwei ordinalskalierte Variablen signifikant miteinander zusammenhängen, können wir die `rococo.test()`-Funktion anwenden.


```r
rococo.test(fb23$mdbf2_pre, fb23$mdbf3_pre)
```

```
## 
## 	Robust Gamma Rank Correlation:
## 
## data: fb23$mdbf2_pre and fb23$mdbf3_pre (length = 179)
## similarity: linear 
## rx = 0.1 / ry = 0.2 
## t-norm: min 
## alternative hypothesis: true gamma is not equal to 0 
## sample gamma = -0.4482018 
## estimated p-value = < 2.2e-16 (0 of 1000 values)
```

Betrachten wir nun den Koeffizienten $\hat{\gamma}$ für zwei andere Items (`prok1` mit `prok2`) 


```
## 
## 	Robust Gamma Rank Correlation:
## 
## data: fb23$mdbf2_pre and fb23$mdbf3_pre (length = 179)
## similarity: linear 
## rx = 0.1 / ry = 0.2 
## t-norm: min 
## alternative hypothesis: true gamma is not equal to 0 
## sample gamma = -0.4482018 
## estimated p-value = < 2.2e-16 (0 of 1000 values)
```
Der Koeffizient von -0.45 zeigt uns, dass die Items zwar miteinander korrelieren, allerdings negativ. Ist hier etwas schief gelaufen? Nein, `prok2` ist lediglich ein invertiertes Item. Mit der rekodierten Variante der `prok2` Variable würde das `-` nicht da stehen, aber die Höhe der Korrelation gleich bleiben. Wir sehen daher, dass `prok1` mit `prok2` signifikant zusammenhängt. Die beiden Items messen demnach ein ähnliches zugrundeliegendes Konstrukt (Prokrastination).

****

