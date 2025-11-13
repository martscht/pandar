---
title: "Korrelation" 
type: post
date: '2025-01-09'
slug: korrelation 
categories: ["Statistik I"] 
tags: ["Korrelation", "Grundlagen", "Hilfe"] 
subtitle: ''
summary: 'Zuerst werden in dieser Sitzung verschiedene Darstelungsmöglichkeiten zusammenhängender Variablen besprochen. Im Anschluss werden Varianz- und Kovarianzberechnung, aufbauend Korrelation, und abschließend Korrelation dichotomer Variablen und Korrelation mit fehlenden Werten in R anhand des FB24 erklärt.' 
authors: [nehler, winkler, schroeder, neubauer, goldhammer]
weight: 9
lastmod: '2025-11-13'
featured: no
banner:
  image: "/header/storch_with_baby.jpg"
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
    name: Übungen
    url: /lehre/statistik-i/korrelation-uebungen
output:
  html_document:
    keep_md: true
---





<details><summary><b>Kernfragen dieser Lehreinheit</b></summary>

* Wie können [Kreuztabellen](#Kreuztabellen) in R erstellt werden? Welche Varianten gibt es, [relative Häufigkeitstabellen](#Relativtabelle) zu erstellen?
* Wie kann ein gemeinsames [Balkendiagramm](#Balkendiagramm) für zwei Variablen erstellt werden?
* Welche zwei Varianten gibt es, [Varianzen und Kovarianzen](#Ko_Varianz) zu bestimmen?
* Wie kann die [Produkt-Moment-Korrelation](#PMK), die [Rang-Korrelation nach Spearman](#Rs) und [Kendalls $\tau$](#tau) bestimmt werden?
* Wie wird bei der Berechnung von [Korrelationen mit fehlenden Werten](#NA) umgegangen?
* Wie lässt sich der Zusammenhang zweier [dichotomer (nominaler) Variablen](#Dichotome_var) berechnen?

</details>

***


## Vorbereitende Schritte {#prep}

Den Datensatz `fb24` haben wir bereits über diesen [<i class="fas fa-download"></i> Link heruntergeladen](/daten/fb24.rda) und können ihn über den lokalen Speicherort einladen oder Sie können Ihn direkt mittels des folgenden Befehls aus dem Internet in das Environment bekommen. In den vorherigen Tutorials und den dazugehörigen Aufgaben haben wir bereits Änderungen am Datensatz durchgeführt, die hier nochmal aufgeführt sind, um den Datensatz auf dem aktuellen Stand zu haben:


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

fb24$ort <- factor(fb24$ort, levels=c(1,2), labels=c("FFM", "anderer"))
fb24$job <- factor(fb24$job, levels=c(1,2), labels=c("nein", "ja"))

# Rekodierung invertierter Items
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf11_r <- -1 * (fb24$mdbf11 - 5)
fb24$mdbf3_r <- -1 * (fb24$mdbf3 - 5)
fb24$mdbf9_r <- -1 * (fb24$mdbf9 - 5)

# Berechnung von Skalenwerten
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb24$ru_pre <-  fb24[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb24$ru_pre_zstd <- scale(fb24$ru_pre, center = TRUE, scale = TRUE)
```

****

## Häufigkeitstabellen 

Die Erstellung von *Häufigkeitstabellen* zur Darstellung univariater Häufigkeiten haben Sie schon kennengelernt. Dies funktioniert mit einfachen Befehlen für die Häufigkeiten und die zugehörigen relativen Prozentzahlen.



``` r
tab <- table(fb24$fach)               #Absolut
tab
```

```
## 
##  Allgemeine Biologische Entwicklung   Klinische Diag./Meth. 
##          41          15          40          88           3
```

``` r
prop.table(tab)                       #Relativ
```

```
## 
##  Allgemeine Biologische Entwicklung   Klinische Diag./Meth. 
##  0.21925134  0.08021390  0.21390374  0.47058824  0.01604278
```

{{<intext_anchor Kreuztabellen>}}

Die Erweiterung für den bivariaten Fall ist dabei nicht schwierig und wird als *Kreuztabelle* bezeichnet. Sie liefert die Häufigkeit von Kombinationen von Ausprägungen in mehreren Variablen. In den Zeilen wird die erste Variable abgetragen und in den Spalten die zweite. Im Unterschied zum univariaten Fall muss im `table()`-Befehl nur die zweite interessierende Variable zusätzlich genannt werden. Tabellen können beliebig viele Dimensionen haben, werden dann aber sehr unübersichtlich.


``` r
tab<-table(fb24$fach,fb24$ziel)       #Kreuztabelle
tab
```

```
##              
##               Wirtschaft Therapie Forschung Andere
##   Allgemeine          13       11         8      9
##   Biologische          2        6         6      1
##   Entwicklung          8       16         5     10
##   Klinische            1       74         4      9
##   Diag./Meth.          0        1         2      0
```

In eine Kreuztabelle können Randsummen mit dem `addmargins()` Befehl hinzugefügt werden. Randsummen erzeugen in der letzten Spalte bzw. Zeile die univariaten Häufigkeitstabellen der Variablen.


``` r
addmargins(tab)                       #Randsummen hinzufügen
```

```
##              
##               Wirtschaft Therapie Forschung Andere Sum
##   Allgemeine          13       11         8      9  41
##   Biologische          2        6         6      1  15
##   Entwicklung          8       16         5     10  39
##   Klinische            1       74         4      9  88
##   Diag./Meth.          0        1         2      0   3
##   Sum                 24      108        25     29 186
```

{{<intext_anchor Relativtabelle>}}

Auch für die Kreuztabelle ist die Möglichkeit der Darstellung der Häufigkeiten in Relation zur Gesamtzahl der Beobachtungen gegeben. 


``` r
prop.table(tab)                       #Relative Häufigkeiten
```

```
##              
##                Wirtschaft    Therapie   Forschung      Andere
##   Allgemeine  0.069892473 0.059139785 0.043010753 0.048387097
##   Biologische 0.010752688 0.032258065 0.032258065 0.005376344
##   Entwicklung 0.043010753 0.086021505 0.026881720 0.053763441
##   Klinische   0.005376344 0.397849462 0.021505376 0.048387097
##   Diag./Meth. 0.000000000 0.005376344 0.010752688 0.000000000
```

74 von insgesamt 186 (39.78%)  wollen therapeutisch arbeiten *und* interessieren sich bisher am meisten für die klinische Psychologie.


`prob.table()` kann allerdings nicht nur an der Gesamtzahl relativiert werden, sondern auch an der jeweiligen Zeilen- oder Spaltensumme. Dafür gibt man im Argument `margin` für Zeilen `1` oder für Spalten `2` an.


``` r
prop.table(tab, margin = 1)           #relativiert an Zeilen
```

```
##              
##               Wirtschaft   Therapie  Forschung     Andere
##   Allgemeine  0.31707317 0.26829268 0.19512195 0.21951220
##   Biologische 0.13333333 0.40000000 0.40000000 0.06666667
##   Entwicklung 0.20512821 0.41025641 0.12820513 0.25641026
##   Klinische   0.01136364 0.84090909 0.04545455 0.10227273
##   Diag./Meth. 0.00000000 0.33333333 0.66666667 0.00000000
```

Von 88 Personen, die sich am meisten für klinische Psychologie interessieren, wollen 84.09% (nämlich 74 Personen) später therapeutisch arbeiten.


``` r
prop.table(tab, margin = 2)           #relativiert an Spalten
```

```
##              
##                Wirtschaft    Therapie   Forschung      Andere
##   Allgemeine  0.541666667 0.101851852 0.320000000 0.310344828
##   Biologische 0.083333333 0.055555556 0.240000000 0.034482759
##   Entwicklung 0.333333333 0.148148148 0.200000000 0.344827586
##   Klinische   0.041666667 0.685185185 0.160000000 0.310344828
##   Diag./Meth. 0.000000000 0.009259259 0.080000000 0.000000000
```

Von 108 Personen, die später therapeutisch arbeiten wollen, interessieren sich 68.52% (nämlich 74 Personen) für die klinische Psychologie.


`addmargins()`und `prop.table()` können beliebig kombiniert werden.
`prop.table(addmargins(tab))` behandelt die Randsummen als eigene Kategorie (inhaltlich meist unsinnig!).
`addmargins(prop.table(tab))` liefert die Randsummen der relativen Häufigkeiten.


``` r
addmargins(prop.table(tab))      # als geschachtelte Funktion
```

```
##              
##                Wirtschaft    Therapie   Forschung      Andere         Sum
##   Allgemeine  0.069892473 0.059139785 0.043010753 0.048387097 0.220430108
##   Biologische 0.010752688 0.032258065 0.032258065 0.005376344 0.080645161
##   Entwicklung 0.043010753 0.086021505 0.026881720 0.053763441 0.209677419
##   Klinische   0.005376344 0.397849462 0.021505376 0.048387097 0.473118280
##   Diag./Meth. 0.000000000 0.005376344 0.010752688 0.000000000 0.016129032
##   Sum         0.129032258 0.580645161 0.134408602 0.155913978 1.000000000
```

``` r
prop.table(tab) |> addmargins()  # als Pipe
```

```
##              
##                Wirtschaft    Therapie   Forschung      Andere         Sum
##   Allgemeine  0.069892473 0.059139785 0.043010753 0.048387097 0.220430108
##   Biologische 0.010752688 0.032258065 0.032258065 0.005376344 0.080645161
##   Entwicklung 0.043010753 0.086021505 0.026881720 0.053763441 0.209677419
##   Klinische   0.005376344 0.397849462 0.021505376 0.048387097 0.473118280
##   Diag./Meth. 0.000000000 0.005376344 0.010752688 0.000000000 0.016129032
##   Sum         0.129032258 0.580645161 0.134408602 0.155913978 1.000000000
```

****

## Balkendiagramme {#Balkendiagramm .anchorheader}

Grafisch kann eine solche Kreuztabelle durch gruppierte Balkendiagramme dargestellt werden. Das Argument `beside` sorgt für die Anordnung der Balken (bei `TRUE` nebeneinander, bei `FALSE` übereinander). Das Argument `legend` nimmt einen Vektor für die Beschriftung entgegen. Die Zeilen des Datensatzes bilden dabei stets eigene Balken, während die Spalten die Gruppierungsvariable bilden. Deshalb müssen als Legende die Namen der Reihen `rownames()` unserer Tabelle `tab` ausgewählt werden.


``` r
barplot (tab,
         beside = TRUE,
         col = c('mintcream','olivedrab','peachpuff','steelblue','maroon'),
         legend = rownames(tab))
```

![](/korrelation_files/unnamed-chunk-9-1.png)<!-- -->

****

## Varianz, Kovarianz und Korrelation {#Ko_Varianz .anchorheader}

In der Vorlesung haben Sie gelernt, dass es für *Kovarianzen* und *Varianzen* empirische und geschätzte Werte gibt. R berechnet standardmäßig für die Varianz und Kovarianz die *Populationsschätzer*, verwendet also folgende Formeln für Varianz 

{{< math >}}
\begin{equation}
\small
\hat{\sigma}^2_{X} = \frac{\sum_{m=1}^n (y_m - \bar{y})^2}{n-1}
\end{equation}
{{< /math >}}


und Kovarianz.

{{< math >}}
\begin{equation}
\small
\hat{\sigma}_{XY} = \frac{\sum_{m=1}^n (x_m - \bar{x}) \cdot (y_m - \bar{y})}{n-1}
\end{equation}
{{< /math >}}

### Funktionen und Behandlung fehlender Werte {#fehlende-werte}

Die Funktionen für die Varianz ist dabei `var()`. Im Folgenden wird diese für die Variablen `neuro` (Neurotizismus) und `gewis` (Gewissenhaftigkeit) aus dem Datensatz bestimmt. Als Argumente müssen jeweils die Variablennamen verwendet werden.
Wie bereits in vergangenen Sitzungen gesehen, führen fehlende Werte zu der Ausgabe `NA`. Um dies vorzubeugen, wird im univariaten Fall `na.rm = TRUE` zum Ausschluss verwendet. 


``` r
var(fb24$neuro, na.rm = TRUE)            #Varianz Neurotizismus
```

```
## [1] 0.8955084
```

``` r
var(fb24$gewis, na.rm = TRUE)            #Varianz Gewissenhaftigkeit
```

```
## [1] 0.7972582
```


Die Funktion `cov()` wird für die Kovarianz verwendet und benötigt als Argumente die Variablen. 

{{<intext_anchor NA>}}


``` r
cov(fb24$neuro, fb24$gewis)              #Kovarianz Neurotizismus und Gewissenhaftigkeit
```

```
## [1] NA
```

Natürlich können auch bei der Kovarianzberechnung fehlende Werte zu einem Problem werden. Zur Bewältigung des Problems gibt es das Argument `use`, das mehr Flexibilität bietet, als `na.rm` bei der univariaten Betrachtung. Diese Flexibilität setzt aber nur deutlich ein, wenn mehr als zwei Variablen gleichzeitig betrachtet werden. Wir werden gleich also alle fünf der Big 5 Persönlichkeitsdimensionen betrachten. Zunächst aber eine kurze Zusammenfassung von den drei häufigsten Optionen:

* *Nutzung aller Beobachtungen*: Alle Zeilen (also Personen) gehen in die Berechnung aller Werte mit ein.
* *Listenweiser Fallausschluss*: Personen, die auf (mindestens) einer von **allen** Variablen `NA` haben, werden von der Berechnung ausgeschlossen.
* *Paarweiser Fallausschluss*: Personen, die auf (mindestens) einer von **zwei** Variablen `NA` haben, werden von der Berechnung ausgeschlossen.

Am besten lässt sich der Unterschied in einer *Kovarianzmatrix* veranschaulichen. Hier werden alle Varianzen und Kovarianzen von einer Menge an Variablen berechnet und in einer Tabelle darstellt. Dafür kann ein Datensatz erstellt werden, der nur die interessierenden Variablen enthält. Wir nehmen alle vier Variablen aus unseren Beispielen zur Kovarianzen auf. Außerdem müssen wir zu Veranschaulichungszwecken noch das Vorkommen fehlender Werte (willkürlich) anpassen.


``` r
big5 <- fb24[,c('extra', 'vertr', 'gewis', 'neuro', 'offen')] #Datensatzreduktion
cov(big5)                                       #Kovarianzmatrix   
```

```
##       extra vertr gewis neuro offen
## extra    NA    NA    NA    NA    NA
## vertr    NA    NA    NA    NA    NA
## gewis    NA    NA    NA    NA    NA
## neuro    NA    NA    NA    NA    NA
## offen    NA    NA    NA    NA    NA
```

Auch hier bekommen wir zunächst die wenig zufriedenstellende Aussage, dass keine der Kovarianzen bestimmt werden kann, weil fehlende Werte vorliegen. Anhand der `summary` können wir auch schnell ermitteln, wie viele fehlende Werte das pro Variable sind:


``` r
summary(big5)
```

```
##      extra           vertr           gewis          neuro           offen      
##  Min.   :1.000   Min.   :1.000   Min.   :1.50   Min.   :1.000   Min.   :1.000  
##  1st Qu.:2.500   1st Qu.:3.000   1st Qu.:3.00   1st Qu.:3.000   1st Qu.:3.000  
##  Median :3.500   Median :3.500   Median :3.50   Median :3.500   Median :4.000  
##  Mean   :3.277   Mean   :3.484   Mean   :3.49   Mean   :3.408   Mean   :3.809  
##  3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:4.00   3rd Qu.:4.000   3rd Qu.:4.500  
##  Max.   :5.000   Max.   :5.000   Max.   :5.00   Max.   :5.000   Max.   :5.000  
##  NA's   :1       NA's   :1       NA's   :1      NA's   :1       NA's   :1
```


Um trotz dieser fehlenden Werte Kovarianzen berechnen zu können, können wir mit dem Argument `use` arbeiten. Per Voreinstellung wird die erste der drei Optionen genutzt, welche ausgeschrieben `"everything"` heißt. Da dabei alle Zeilen einfach in die Berechnung eingehen, werden `NA`-Werte nicht ausgeschlossen und für die Zusammenhänge daher keine Kennwerte erzeugt. Wir können diese Schlussfolgerug auch nochmal überprüfen.


``` r
cov(big5, use = "everything")         # Kovarianzmatrix mit Argument   
```

```
##       extra vertr gewis neuro offen
## extra    NA    NA    NA    NA    NA
## vertr    NA    NA    NA    NA    NA
## gewis    NA    NA    NA    NA    NA
## neuro    NA    NA    NA    NA    NA
## offen    NA    NA    NA    NA    NA
```

Die Ergebnisse sind exakt gleich mit den vorherigen - `"everything"` ist also der Default für diese Funktion. Nach dieser ersten Erkenntnis können wir die verschiedenen Argumente für die Behandlung von `NA` in der `cov()` Funktion ausprobieren. 

Beginnen wir mit dem *paarweisem Fallausschluss*, der mit `"pairwise"` angesprochen werden kann. 


``` r
cov(big5, use = 'pairwise')             #Paarweiser Fallausschluss
```

```
##             extra        vertr        gewis       neuro       offen
## extra  1.03575365  0.143855056  0.037131441 -0.34812621 -0.02300909
## vertr  0.14385506  0.673436208 -0.008060072 -0.07644668  0.05619317
## gewis  0.03713144 -0.008060072  0.797258198 -0.08254340 -0.08095894
## neuro -0.34812621 -0.076446680 -0.082543400  0.89550840  0.02187242
## offen -0.02300909  0.056193166 -0.080958942  0.02187242  0.95407826
```

Wie wir sehen, werden nun die Personen mit fehlenden Werten auf einer Variable ignoriert, wenn für die Variable mit fehlendem Wert ein Zusammenhangsmaß berechnet wird. Ansonsten werden Personen aber nicht aus der Berechnung ausgeschlossen, was man vor allem daran sieht, dass sich die Kovarianzen (und Varianzen) von Variablen ohne fehlende Werte (`gewis` und `neuro`) nicht verändert haben. 

Vergleichen wir nun dieses Ergebnis noch mit dem Ergebnis des *listenweisem Fallausschluss*.

``` r
cov(big5, use = 'complete')             #Listenweiser Fallausschluss
```

```
##             extra        vertr        gewis       neuro       offen
## extra  1.03575365  0.143855056  0.037131441 -0.34812621 -0.02300909
## vertr  0.14385506  0.673436208 -0.008060072 -0.07644668  0.05619317
## gewis  0.03713144 -0.008060072  0.797258198 -0.08254340 -0.08095894
## neuro -0.34812621 -0.076446680 -0.082543400  0.89550840  0.02187242
## offen -0.02300909  0.056193166 -0.080958942  0.02187242  0.95407826
```

Wie wir sehen, sind die Werte in diesem Fall gleich. Das liegt allerdings nur daran, dass es anscheinend _die selbe_ Person war, die auf allen fünf Variablen fehlende Werte hatte. Wenn wir händisch einen fehlenden Wert hinzufügen:


``` r
big5[1, 1] <- NA
```

unterscheiden sich die Werte zwischen `pairwise` und `complete` für die Kovarianzen aller Kombinationen außer der mit der ersten Variable:


``` r
cov(big5, use = 'complete')             #Listenweiser Fallausschluss
```

```
##             extra        vertr        gewis       neuro       offen
## extra  1.02545252  0.139891395  0.032651072 -0.33248399 -0.02488165
## vertr  0.13989140  0.675584795 -0.009502924 -0.07161654  0.05596630
## gewis  0.03265107 -0.009502924  0.800090504 -0.07779866 -0.08190615
## neuro -0.33248399 -0.071616541 -0.077798663  0.88087580  0.02392788
## offen -0.02488165  0.055966305 -0.081906154  0.02392788  0.95893205
```

``` r
cov(big5, use = 'pairwise')             #Paarweiser Fallausschluss
```

```
##             extra        vertr        gewis       neuro       offen
## extra  1.02545252  0.139891395  0.032651072 -0.33248399 -0.02488165
## vertr  0.13989140  0.673436208 -0.008060072 -0.07644668  0.05619317
## gewis  0.03265107 -0.008060072  0.797258198 -0.08254340 -0.08095894
## neuro -0.33248399 -0.076446680 -0.082543400  0.89550840  0.02187242
## offen -0.02488165  0.056193166 -0.080958942  0.02187242  0.95407826
```

Das liegt daran, dass `complete` Personen mit fehlenden Werten aus der kompletten Berechnung ausgeschlossen werden. Selbst wenn sie nur auf der Extraversion (`extra`) einen fehlenden Wert haben, gehen sie nicht in die Berechnung des Zusammenhangs zwischen bspw. Verträglichkeit und Neurotizismus (`vertr` und `neuro`) ein. 

### Grafische Darstellung

Der Zusammenhang zwischen zwei Variablen kann in einem *Scatterplot* bzw. *Streupunktdiagramm* dargestellt werden. Dafür kann man die `plot()` Funktion nutzen. Als Argumente können dabei `x` für die Variable auf der x-Achse, `y` für die Variable auf der y-Achse, `xlim`, `ylim` für eventuelle Begrenzungen der Achsen und `pch` für die Punktart angegeben werden.


``` r
plot(x = fb24$neuro, y = fb24$gewis, xlim = c(1,5) , ylim = c(1,5))
```

![](/korrelation_files/unnamed-chunk-19-1.png)<!-- -->

### Produkt-Moment-Korrelation (Pearson Korrelation)

{{<intext_anchor PMK>}}

Wie in der Vorlesung besprochen, sind für verschiedene Skalenniveaus verschiedene Zusammenhangsmaße verfügbar, die im Gegensatz zur Kovarianz auch eine Vergleichbarkeit zwischen zwei Zusammenhangswerten sicherstellen. Für zwei metrisch skalierte Variablen gibt es dabei die *Produkt-Moment-Korrelation*. In der Funktion `cor()` werden dabei die Argumente `x` und `y` für die beiden betrachteten Variablen benötigt. `use` beschreibt weiterhin den Umgang mit fehlenden Werten.


``` r
cor(x = fb24$neuro, y = fb24$gewis, use = 'pairwise')
```

```
## [1] -0.09768953
```

Bei einer positiven Korrelation gilt „je mehr Variable x... desto mehr Variable y" bzw. umgekehrt, bei einer negativen Korrelation „je mehr Variable x... desto weniger Variable y" bzw. umgekehrt. Korrelationen sind immer ungerichtet, das heißt, sie enthalten keine Information darüber, welche Variable eine andere vorhersagt - beide Variablen sind gleichberechtigt. Korrelationen (und Regressionen, die wir später [in einem Tutorial](/lehre/statistik-i/einfache-reg) kennen lernen werden) liefern *keine* Hinweise auf Kausalitäten. Sie sagen beide etwas über den (linearen) Zusammenhang zweier Variablen aus.

In R können wir uns auch eine *Korrelationsmatrix* ausgeben lassen. Dies geschieht äquivalent zu der Kovarianzmatrix mit dem Datensatz als Argument in der `cor()` Funktion. In der Diagonale stehen die Korrelationen der Variable mit sich selbst - also 1 - und in den restlichen Feldern die Korrelationen der Variablen untereinander.


``` r
cor(big5, use = 'pairwise')
```

```
##             extra       vertr       gewis       neuro       offen
## extra  1.00000000  0.16807120  0.03604708 -0.34982885 -0.02509155
## vertr  0.16807120  1.00000000 -0.01099996 -0.09844090  0.07010408
## gewis  0.03604708 -0.01099996  1.00000000 -0.09768953 -0.09282679
## neuro -0.34982885 -0.09844090 -0.09768953  1.00000000  0.02366301
## offen -0.02509155  0.07010408 -0.09282679  0.02366301  1.00000000
```


Die Stärke des korrelativen Zusammenhangs wird mit dem Korrelationskoeffizienten ausgedrückt, der zwischen -1 und +1 liegt. 
Die default-Einstellung bei `cor()`ist die *Produkt-Moment-Korrelation*, also die Pearson-Korrelation.


``` r
cor(fb24$neuro, fb24$gewis, use = "pairwise", method = "pearson")
```

```
## [1] -0.09768953
```


Achtung! Die inferenzstatistische Testung der Pearson-Korrelation hat gewisse Voraussetzungen, die vor der Durchführung überprüft werden sollten!

### Voraussetzungen Pearson-Korrelation

1. *Skalenniveau*: intervallskalierte Daten $\rightarrow$ ok (Ratingskalen werden meist als intervallskaliert aufgefasst, auch wenn das nicht 100% korrekt ist)  
2. *Linearität*: Zusammenhang muss linear sein $\rightarrow$ grafische Überprüfung (siehe  Scatterplot)  
3. *Normalverteilung*: Variablen müssen normalverteilt sein $\rightarrow$ QQ-Plot, Histogramm oder Shapiro-Wilk-Test  

#### zu 3. Normalverteilung

$\rightarrow$ QQ-Plot, Histogramm & Shapiro-Wilk-Test


``` r
# car-Paket laden
library(car)

#QQ
qqPlot(fb24$neuro)
```

![](/korrelation_files/unnamed-chunk-23-1.png)<!-- -->

```
## [1]  13 146
```

``` r
qqPlot(fb24$gewis)
```

![](/korrelation_files/unnamed-chunk-23-2.png)<!-- -->

```
## [1] 34 44
```

``` r
#Histogramm

hist(fb24$neuro, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb24$neuro, na.rm = T), sd = sd(fb24$neuro, na.rm = T)), col = "blue", add = T)  
```

![](/korrelation_files/unnamed-chunk-23-3.png)<!-- -->

``` r
hist(fb24$gewis, prob = T, ylim = c(0,1))
curve(dnorm(x, mean = mean(fb24$gewis, na.rm = T), sd = sd(fb24$gewis, na.rm = T)), col = "blue", add = T)
```

![](/korrelation_files/unnamed-chunk-23-4.png)<!-- -->

``` r
#Shapiro
shapiro.test(fb24$neuro)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb24$neuro
## W = 0.95921, p-value = 2.523e-05
```

``` r
shapiro.test(fb24$gewis)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb24$gewis
## W = 0.95223, p-value = 5.029e-06
```

$p < \alpha$ $\rightarrow$ $H_1$: Normalverteilung kann nicht angenommen werden. Somit ist diese Voraussetzung verletzt. Eine Möglichkeit damit umzugehen, ist die Rangkorrelation nach Spearman. Diese ist nicht an die Voraussetzung der Normalverteilung gebunden. Das Verfahren kann über `method = "spearman"` angewendet werden.

{{<intext_anchor Rs>}}

#### Rangkorrelation in R


``` r
r1 <- cor(fb24$neuro,fb24$gewis,
          method = "spearman",     #Pearson ist default
          use = "complete") 

r1
```

```
## [1] -0.1146832
```


#### Interpretation des deskriptiven Zusammenhangs

Es handelt sich um eine schwache negative Korrelation von _r_ = -0.11. Der Effekt ist nach Cohens (1988) Konvention als vernachlässigbar bis schwach zu bewerten. D.h. es gibt keinen nennenswerten Zusammenhang zwischen der Ausprägung in Neurotizismus und der Ausprägung in der Gewissenhaftigkeit. 

#### Cohens (1988) Konvention zur Interpretation von $|r|$

* ~ .10: schwacher Effekt  
* ~ .30: mittlerer Effekt  
* ~ .50: starker Effekt 

### Kendalls $\tau$ {{<intext_anchor tau>}}

Als weitere Variante der Rangkorrelation gibt es noch Kendalls $\tau$. Diese kann man mit `method = "kendall"` angesprochen werden.


``` r
cor(fb24$neuro, fb24$gewis, use = 'complete', method = 'kendall')
```

```
## [1] -0.08730305
```
Die Interpretation erfolgt wie bei Spearman's Rangkorrelation. 

**Signifikanztestung des Korrelationskoeffizienten:**
Nachdem der Korrelationskoeffizient berechnet wurde, kann dieser noch auf Signifikanz geprüft werden. Dazu verwenden wir die `cor.test()`-Funktion.

* $H_0$: $\rho = 0$ $\rightarrow$ es gibt keinen Zusammenhang zwischen Neurotizismus und Gewissenhaftigkeit
* $H_1$: $\rho \neq 0$ $\rightarrow$  es gibt einen Zusammenhang zwischen Neurotizismus und Gewissenhaftigkeit


``` r
cor <- cor.test(fb24$neuro, fb24$gewis, 
         alternative = "two.sided", 
         method = "spearman",      #Da Voraussetzungen für Pearson verletzt
         use = "complete")
```

```
## Warning in cor.test.default(fb24$neuro, fb24$gewis, alternative = "two.sided", : Kann
## exakten p-Wert bei Bindungen nicht berechnen
```

``` r
cor$p.value      #Gibt den p-Wert aus
```

```
## [1] 0.1141605
```

Anmerkung: Bei der Rangkorrelation kann der exakte p-Wert nicht berechnet werden, da gebundene Ränge vorliegen. Das Ergebnis ist allerdings sehr eindeutig: $p > \alpha$ $\rightarrow$ $H_0$. Die Korrelation fällt nicht signifikant von 0 verschieden aus, d.h. die $H_0$ wird beibehalten. Daraus würde sich die folgende Interpretation ergeben:

**Ergebnisinterpretation:**
Es wurde untersucht, ob Neurotizismus und Gewissenhaftigkeit miteinander zusammenhängen. Der Spearman-Korrelationskoeffizient beträgt -0.11 und ist statistisch nicht signifikant (_p_ = 0.114). Folglich wird die Nullhypothese hier beibehalten: Neurotizismus und Gewissenhaftigkeit weisen keinen Zusammenhang auf.

**Modifikation**
Wir haben in der Funktion `cor.test()` als Argument `method = "spearman"` eingegeben, da die Voraussetzungen für die Pearson-Korrelation nicht erfüllt waren. Wenn dies der Fall gewesen wäre, müsste man stattdessen `method = "pearson"` angeben:


``` r
cor.test(fb24$neuro, fb24$gewis, 
         alternative = "two.sided", 
         method = "pearson",       
         use = "complete")
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  fb24$neuro and fb24$gewis
## t = -1.3495, df = 189, p-value = 0.1788
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.23639017  0.04491275
## sample estimates:
##         cor 
## -0.09768953
```

### Zusammenhang dichotomer (nominaler) Variablen {#Dichotome_var .anchorheader}

Abschließend lernen wir Zusammenhangsmaße für dichotome nominalskalierte Variablen kennen. Dazu bearbeiten wir folgende Forschungsfragestellung: Haben Studierende mit Wohnort in Uninähe (Frankfurt) eher einen Nebenjob als Studierende, deren Wohnort außerhalb von Frankfurt liegt?

Wir analysieren aus unserem Datensatz die beiden dichotomen Variablen `job` (ja [`ja`] vs. nein [`nein`]) und `ort` (Frankfurt [`FFM`] vs. außerhalb [`andere`]). Die Variablen `ort` und `job` liegen nach den vorbereitenden Schritten bereits als Faktor-Variablen mit entsprechende Labels vor. Dies wird durch die folgende Prüfung bestätigt:


``` r
is.factor(fb24$ort)
```

```
## [1] TRUE
```

``` r
is.factor(fb24$job)
```

```
## [1] TRUE
```
Erstellen der Kreuztabelle als Datenbasis:

``` r
tab <- table(fb24$ort, fb24$job)
tab
```

```
##          
##           nein ja
##   FFM       68 43
##   anderer   53 24
```


**Korrelationskoeffizient Phi** ($\phi$)

Wie in der Vorlesung behandelt, berechnet sich $\phi$ folgendermaßen:

$$\phi = \frac{n_{11}n_{22}-n_{12}n_{21}}{\sqrt{(n_{11}+n_{12})(n_{11}+n_{21})(n_{12}+n_{22})(n_{21}+n_{22})}}$$ welches einen Wertebereich von [-1,1] aufweist und analog zur Korrelation interpretiert werden kann. 1 steht in diesem Fall für einen perfekten positiven Zusammenhang .

In `R` sieht das so aus:


``` r
korr_phi <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
  sqrt((tab[1,1]+tab[1,2])*(tab[1,1]+tab[2,1])*(tab[1,2]+tab[2,2])*(tab[2,1]+tab[2,2]))
korr_phi
```

```
## [1] -0.07772618
```

Durch ein mathematisches Wunder (dass Sie gerne anhand der Formeln für Kovarianz und Korrelation nachvollziehen können) entspricht diese Korrelation exakt dem Wert, den wir auch anhand der Pearson-Korrelation zwischen den beiden Variablen bestimmen würden:


``` r
# Numerische Variablen erstellen
ort_num <- as.numeric(fb24$ort)
job_num <- as.numeric(fb24$job)

cor(ort_num, job_num, use = 'pairwise')
```

```
## [1] -0.07772618
```
Das hat gegenüber der händischen Bestimmung natürlich den Vorteil, dass wir direkt $p$-Wert und Konfidenzintervall bestimmen können:


``` r
cor.test(ort_num, job_num)
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ort_num and job_num
## t = -1.0633, df = 186, p-value = 0.289
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.21840699  0.06611953
## sample estimates:
##         cor 
## -0.07772618
```


Cohen (1988) hat folgende Konventionen zur Beurteilung der Effektstärke $\phi$ vorgeschlagen, die man heranziehen kann, um den Effekt "bei kompletter Ahnungslosigkeit" einschätzen zu können (wissen wir mehr über den Sachverhalt, so sollten Effektstärken lieber im Bezug zu anderen Studienergebnissen interpretiert werden):

| *phi* |  Interpretation  |
|:-----:|:----------------:|
| \~ .1 |  kleiner Effekt  |
| \~ .3 | mittlerer Effekt |
| \~ .5 |  großer Effekt   |

Der Wert für den Zusammenhang der beiden Variablen ist also bei völliger Ahnungslosigkeit als klein einzuschätzen.


**Yules Q**

Dieses Zusammenhangsmaße berechnet sich als

$$Q=\frac{n_{11}n_{22}-n_{12}n_{21}}{n_{11}n_{22}+n_{12}n_{21}},$$

welches einen Wertebereich von [-1,1] aufweist und analog zur Korrelation interpretiert werden kann. 1 steht in diesem Fall für einen perfekten positiven Zusammenhang.

In `R` sieht das so aus:


``` r
YulesQ <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
                 (tab[1,1]*tab[2,2]+tab[1,2]*tab[2,1])
YulesQ
```

```
## [1] -0.1654308
```


Das Ganze lässt sich auch mit dem `psych` Paket und der darin enthaltenen Funktionen `phi()` und `Yule()` umsetzen:


``` r
# alternativ mit psych Paket
library(psych)
phi(tab, digits = 8)
```

```
## [1] -0.07772618
```

``` r
Yule(tab)
```

```
## [1] -0.1654308
```

### Odds (Wettquotient) und Odds-Ratio {#odds-wettquotient-und-odds-ratio .anchorheader}

Der Odds (Wettquotient, Chance) gibt das Verhältnis der Wahrscheinlichkeiten an, dass ein Ereignis eintritt bzw. dass es nicht eintritt. 
Das Wettquotienten-Verhältnis (Odds-Ratio) zeigt an, um wieviel sich dieses Verhältnis zwischen Ausprägungen einer zweiten dichotomen Variablen unterscheidet (Maß für den Zusammenhang).

Zur Erinnerung die Kreuztabelle:

``` r
tab
```

```
##          
##           nein ja
##   FFM       68 43
##   anderer   53 24
```

Berechnung des Odds für `FFM`:

``` r
Odds_FFM = tab[1,1]/tab[1,2]
Odds_FFM
```

```
## [1] 1.581395
```
Für in Frankfurt Wohnende ist die Chance keinen Job zu haben demnach 1.58-mal so hoch wie einen Job zu haben. 

Berechnung des Odds für `anderer`:

``` r
Odds_anderer = tab[2,1]/tab[2,2]
Odds_anderer
```

```
## [1] 2.208333
```

Für nicht in Frankfurt Wohnende ist die Chance keinen Job zu haben 2.21-mal so hoch wie einen Job zu haben. 

Berechnung des Odds-Ratio:

``` r
OR = Odds_anderer/Odds_FFM
OR
```

```
## [1] 1.396446
```

Die Chance, keinen Job zu haben, ist für nicht in Frankfurt Wohnende 1.4-mal so hoch wie für in Frankfurt Wohnende. Man könnte auch den Kehrwert bilden, wodurch sich der Wert ändert, die Interpretation jedoch nicht. 

#### Ergebnisinterpretation

Es wurde untersucht, ob Studierende mit Wohnort in Uninähe (also in Frankfurt) eher einen Nebenjob haben als Studierende, deren Wohnort außerhalb von Frankfurt liegt. Zur Beantwortung der Fragestellung wurden die Korrelationmaße $\phi$ und Yules Q bestimmt. Der Zusammenhang ist jeweils leicht negativ, d.h. dass Studierende, die nicht in Frankfurt wohnen, eher keinen Job haben. Der Effekt ist aber von vernachlässigbarer Größe ($\phi$ = -0.078). 
Diese Befundlage ergibt sich auch aus dem Odds-Ratio, das geringfügig größer als 1 aufällt (OR = 1.4).


***

## Appendix 

<details><summary>Zusammenhangsmaße für ordinalskalierte Daten</summary>

### Vertiefung: Wie können Zusammenhangsmaße für ordinalskalierte Daten berechnet werden?
	
_In diesem Abschnitt wird vertiefend die Bestimmung von Zusammenhangsmaßen für ordinalskalierte Variablen besprochen. Den dazugehörigen Auszug aus den Vorlesungsfolien, der in diesem Jahr herausgekürzt wurde, finden Sie im Moodle-Ordner._

Ordinalskalierte Daten können aufgrund der Verletzung der Äquidistanz zwischen bspw. Antwortstufen eines Items eines Messinstrumentes nicht schlicht mittels Pearson-Korrelation in Zusammenhang gesetzt werden. Zudem sind oft Verteilungsannahmen bei ordinalskalierten Variablen verletzt. Der Koeffizient $\hat{\gamma}$ ist zur Betrachtung solcher Zusammenhänge am besten geeignet (sogar besser als Spearman's und Kendalls's Rangkorrelation). Er nimmt - ähnlich wie Spearman's und Kendall's Koeffizenten - weder eine gewisse Verteilung der Daten an, noch deren Äquidistanz.

Zur Berechnung dieses Koeffizienten müssen wir das Paket `rococo` installieren, welches verschiedene Konkordanz-basierte Zusammenhangsmaße enthält. Die Installation muss dem Laden des Paketes logischerweise vorausgestellt sein. Wenn R einmal geschlossen wird, müssen alle Zusatzpakete neu geladen, jedoch nicht neu installiert werden.


``` r
if (!requireNamespace("rococo", quietly = TRUE)) {
  install.packages("rococo")
}
```


``` r
library(rococo)                     #laden
```

Übersichten über Pakete kann man mit `??` erhalten.


``` r
??rococo
```

Die Funktion heißt hier zufälligerweise genau gleich wie das Paket. Wenn man nur Informationen über die Funktion statt dem Paket sucht, geht das anhand von `?`.


``` r
?rococo
```

Dank des neuen Pakets können wir nun den Koeffizienten $\hat{\gamma}$ berechnen und damit den Zusammenhang zwischen Items betrachten. Schauen wir uns nun mal den Zusammenhang der beiden Prokrastinationsitems `fb24$mdbf2` und `fb24$mdbf3` an, um zu überprüfen, ob die beiden Items auch (wie beabsichtigt) etwas Ähnliches messen (nähmlich die aktuelle Stimmung). Die beiden Variablen wurden ursprünglich auf einer Skala von 1 (*stimmt gar nicht*) bis 4 (*stimmt vollkommen*) (also auf Ordinalskalenniveau) erfasst. 


``` r
rococo(fb24$mdbf2, fb24$mdbf3)
```

```
## [1] -0.3841988
```

Um zu überprüfen, ob zwei ordinalskalierte Variablen signifikant miteinander zusammenhängen, können wir die `rococo.test()`-Funktion anwenden.


``` r
rococo.test(fb24$mdbf2, fb24$mdbf3)
```

```
## 
## 	Robust Gamma Rank Correlation:
## 
## data: fb24$mdbf2 and fb24$mdbf3 (length = 192)
## similarity: linear 
## rx = 0.1 / ry = 0.2 
## t-norm: min 
## alternative hypothesis: true gamma is not equal to 0 
## sample gamma = -0.3841988 
## estimated p-value = < 2.2e-16 (0 of 1000 values)
```


Der Koeffizient von -0.38 zeigt uns, dass die Items zwar miteinander korrelieren, allerdings negativ. Ist hier etwas schief gelaufen? Nein, `mdbf2_pre` und `mdbf3_pre` repräsentieren gegenläufige Stimmungsaspekte. Mit der rekodierten Variante einer der beiden Variablen würde das `-` nicht da stehen, aber die Höhe der Korrelation bliebe gleich. Wir sehen daher, dass `mdbf2` mit `mdbf3` signifikant zusammenhängt. Die beiden Items messen demnach ein ähnliches zugrundeliegendes Konstrukt (aktuelle Stimmung).


</details>



