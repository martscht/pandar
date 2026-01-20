---
title: "Korrelation" 
type: post
date: '2026-01-20'
slug: korrelation 
categories: ["Statistik I"] 
tags: ["Korrelation", "Grundlagen", "Hilfe"] 
subtitle: ''
summary: 'Zuerst werden in dieser Sitzung verschiedene Darstelungsmöglichkeiten zusammenhängender Variablen besprochen. Im Anschluss werden Varianz- und Kovarianzberechnung, aufbauend Korrelation, und abschließend Korrelation dichotomer Variablen und Korrelation mit fehlenden Werten in R anhand des FB24 erklärt.' 
authors: [nehler, winkler, schroeder, neubauer, goldhammer]
weight: 9
lastmod: '2026-01-20'
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

Den Datensatz `fb25` haben wir bereits über diesen [<i class="fas fa-download"></i> Link heruntergeladen](/daten/fb25.rda) und können ihn über den lokalen Speicherort einladen oder Sie können Ihn direkt mittels des folgenden Befehls aus dem Internet in das Environment bekommen. In den vorherigen Tutorials und den dazugehörigen Aufgaben haben wir bereits Änderungen am Datensatz durchgeführt, die hier nochmal aufgeführt sind, um den Datensatz auf dem aktuellen Stand zu haben:


``` r
#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb25.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb25$hand_factor <- factor(fb25$hand,
                           levels = 1:2,
                           labels = c("links", "rechts"))
fb25$fach <- factor(fb25$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb25$ziel <- factor(fb25$ziel,
                    levels = 1:4,
                    labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb25$wohnen <- factor(fb25$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))
fb25$ort <- factor(fb25$ort, 
                   levels=c(1,2), 
                   labels=c("FFM", "anderer"))
fb25$job <- factor(fb25$job, 
                   levels=c(1,2), 
                   labels=c("nein", "ja"))

# Rekodierung invertierter Items
fb25$mdbf4_r <- -1 * (fb25$mdbf4 - 5)
fb25$mdbf11_r <- -1 * (fb25$mdbf11 - 5)
fb25$mdbf3_r <- -1 * (fb25$mdbf3 - 5)
fb25$mdbf9_r <- -1 * (fb25$mdbf9 - 5)

# Berechnung von Skalenwerten
fb25$gs_pre  <- fb25[, c('mdbf1', 'mdbf4_r', 
                         'mdbf8', 'mdbf11_r')] |> rowMeans()
fb25$ru_pre <-  fb25[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb25$ru_pre_zstd <- scale(fb25$ru_pre, center = TRUE, scale = TRUE)
```

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
var(fb25$neuro, na.rm = TRUE)            #Varianz Neurotizismus
```

```
## [1] 0.985026
```

``` r
var(fb25$gewis, na.rm = TRUE)            #Varianz Gewissenhaftigkeit
```

```
## [1] 0.6312345
```


Die Funktion `cov()` wird für die Kovarianz verwendet und benötigt als Argumente die Variablen. 

{{<intext_anchor NA>}}


``` r
cov(fb25$neuro, fb25$gewis)              #Kovarianz Neurotizismus und Gewissenhaftigkeit
```

```
## [1] 0.09750056
```

Natürlich können auch bei der Kovarianzberechnung fehlende Werte zu einem Problem werden. Zur Bewältigung des Problems gibt es das Argument `use`, das mehr Flexibilität bietet, als `na.rm` bei der univariaten Betrachtung. Diese Flexibilität setzt aber nur deutlich ein, wenn mehr als zwei Variablen gleichzeitig betrachtet werden. Wir werden gleich also alle fünf der Big 5 Persönlichkeitsdimensionen betrachten. Zunächst aber eine kurze Zusammenfassung von den drei häufigsten Optionen:

* *Nutzung aller Beobachtungen*: Alle Zeilen (also Personen) gehen in die Berechnung aller Werte mit ein.
* *Listenweiser Fallausschluss*: Personen, die auf (mindestens) einer von **allen** Variablen `NA` haben, werden von der Berechnung ausgeschlossen.
* *Paarweiser Fallausschluss*: Personen, die auf (mindestens) einer von **zwei** Variablen `NA` haben, werden von der Berechnung ausgeschlossen.

Am besten lässt sich der Unterschied in einer *Kovarianzmatrix* veranschaulichen. Hier werden alle Varianzen und Kovarianzen von einer Menge an Variablen berechnet und in einer Tabelle darstellt. Dafür kann ein Datensatz erstellt werden, der nur die interessierenden Variablen enthält. Wir nehmen alle vier Variablen aus unseren Beispielen zur Kovarianzen auf. Außerdem müssen wir zu Veranschaulichungszwecken noch das Vorkommen fehlender Werte (willkürlich) anpassen.


``` r
big5 <- fb25[,c('extra', 'vertr', 'gewis', 'neuro', 'offen')] #Datensatzreduktion
cov(big5)                                       #Kovarianzmatrix   
```

```
##       extra       vertr      gewis       neuro       offen
## extra    NA          NA         NA          NA          NA
## vertr    NA  0.67371925 0.09664861 -0.01130670  0.07576732
## gewis    NA  0.09664861 0.63123448  0.09750056  0.01420108
## neuro    NA -0.01130670 0.09750056  0.98502595 -0.01341684
## offen    NA  0.07576732 0.01420108 -0.01341684  0.79347777
```

Auch hier bekommen wir zunächst die wenig zufriedenstellende Aussage, dass mehrere der Kovarianzen nicht bestimmt werden können, weil fehlende Werte vorliegen. Anhand der `summary` können wir auch schnell ermitteln, wie viele fehlende Werte das pro Variable sind:


``` r
summary(big5)
```

```
##      extra           vertr           gewis           neuro           offen      
##  Min.   :1.000   Min.   :1.500   Min.   :2.000   Min.   :1.000   Min.   :1.000  
##  1st Qu.:2.500   1st Qu.:3.000   1st Qu.:3.000   1st Qu.:2.500   1st Qu.:3.500  
##  Median :3.500   Median :3.500   Median :3.500   Median :3.000   Median :4.000  
##  Mean   :3.379   Mean   :3.509   Mean   :3.602   Mean   :3.187   Mean   :3.919  
##  3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:4.500  
##  Max.   :5.000   Max.   :5.000   Max.   :5.000   Max.   :5.000   Max.   :5.000  
##  NA's   :1
```


Um trotz dieses fehlenden Werts Kovarianzen berechnen zu können, können wir mit dem Argument `use` arbeiten. Per Voreinstellung wird die erste der drei Optionen genutzt, welche ausgeschrieben `"everything"` heißt. Da dabei alle Zeilen einfach in die Berechnung eingehen, werden `NA`-Werte nicht ausgeschlossen und für die Zusammenhänge daher keine Kennwerte erzeugt. Wir können diese Schlussfolgerug auch nochmal überprüfen.


``` r
cov(big5, use = "everything")         # Kovarianzmatrix mit Argument   
```

```
##       extra       vertr      gewis       neuro       offen
## extra    NA          NA         NA          NA          NA
## vertr    NA  0.67371925 0.09664861 -0.01130670  0.07576732
## gewis    NA  0.09664861 0.63123448  0.09750056  0.01420108
## neuro    NA -0.01130670 0.09750056  0.98502595 -0.01341684
## offen    NA  0.07576732 0.01420108 -0.01341684  0.79347777
```

Die Ergebnisse sind exakt gleich mit den vorherigen - `"everything"` ist also der Default für diese Funktion. Nach dieser ersten Erkenntnis können wir die verschiedenen Argumente für die Behandlung von `NA` in der `cov()` Funktion ausprobieren. 

Beginnen wir mit dem *paarweisem Fallausschluss*, der mit `"pairwise"` angesprochen werden kann. 


``` r
cov(big5, use = 'pairwise')             #Paarweiser Fallausschluss
```

```
##             extra       vertr      gewis       neuro       offen
## extra  0.94810321  0.04483937 0.01549897 -0.39451470  0.11271360
## vertr  0.04483937  0.67371925 0.09664861 -0.01130670  0.07576732
## gewis  0.01549897  0.09664861 0.63123448  0.09750056  0.01420108
## neuro -0.39451470 -0.01130670 0.09750056  0.98502595 -0.01341684
## offen  0.11271360  0.07576732 0.01420108 -0.01341684  0.79347777
```

Wie wir sehen, werden nun die Personen mit fehlenden Werten auf einer Variable ignoriert, wenn für die Variable mit fehlendem Wert ein Zusammenhangsmaß berechnet wird. Ansonsten werden Personen aber nicht aus der Berechnung ausgeschlossen, was man vor allem daran sieht, dass sich die Kovarianzen (und Varianzen) von Variablen ohne fehlende Werte (`vertr`, `gewis`, `neuro` und `offen`) nicht verändert haben.

Vergleichen wir nun dieses Ergebnis noch mit dem Ergebnis des *listenweisem Fallausschluss*.

``` r
cov(big5, use = 'complete')             #Listenweiser Fallausschluss
```

```
##             extra       vertr      gewis       neuro       offen
## extra  0.94810321  0.04483937 0.01549897 -0.39451470  0.11271360
## vertr  0.04483937  0.67222602 0.09283436 -0.01046936  0.08050809
## gewis  0.01549897  0.09283436 0.63037708  0.09877535  0.01823878
## neuro -0.39451470 -0.01046936 0.09877535  0.98957052 -0.01430850
## offen  0.11271360  0.08050809 0.01823878 -0.01430850  0.79321030
```

Wie wir sehen, unterscheiden sich die Werte zwischen `pairwise` und `complete` für die Kovarianzen aller Kombinationen außer der mit der ersten Variable. Das liegt daran, dass `complete` Personen mit fehlenden Werten aus der kompletten Berechnung ausgeschlossen werden. Selbst wenn sie nur auf der Extraversion (`extra`) einen fehlenden Wert haben, gehen sie nicht in die Berechnung des Zusammenhangs zwischen bspw. Verträglichkeit und Neurotizismus (`vertr` und `neuro`) ein. 

### Grafische Darstellung

Der Zusammenhang zwischen zwei Variablen kann in einem *Scatterplot* bzw. *Streupunktdiagramm* dargestellt werden. Dafür kann man die `plot()` Funktion nutzen. Als Argumente können dabei `x` für die Variable auf der x-Achse, `y` für die Variable auf der y-Achse, `xlim`, `ylim` für eventuelle Begrenzungen der Achsen und `pch` für die Punktart angegeben werden.


``` r
plot(x = fb25$neuro, y = fb25$gewis, xlim = c(1,5) , ylim = c(1,5))
```

![](/korrelation_files/unnamed-chunk-9-1.png)<!-- -->

### Produkt-Moment-Korrelation (Pearson Korrelation)

{{<intext_anchor PMK>}}

Wie in der Vorlesung besprochen, sind für verschiedene Skalenniveaus verschiedene Zusammenhangsmaße verfügbar, die im Gegensatz zur Kovarianz auch eine Vergleichbarkeit zwischen zwei Zusammenhangswerten sicherstellen. Für zwei metrisch skalierte Variablen gibt es dabei die *Produkt-Moment-Korrelation*. In der Funktion `cor()` werden dabei die Argumente `x` und `y` für die beiden betrachteten Variablen benötigt. `use` beschreibt weiterhin den Umgang mit fehlenden Werten.


``` r
cor(x = fb25$neuro, y = fb25$gewis, use = 'pairwise')
```

```
## [1] 0.1236482
```

Bei einer positiven Korrelation gilt „je mehr Variable x... desto mehr Variable y" bzw. umgekehrt, bei einer negativen Korrelation „je mehr Variable x... desto weniger Variable y" bzw. umgekehrt. Korrelationen sind immer ungerichtet, das heißt, sie enthalten keine Information darüber, welche Variable eine andere vorhersagt - beide Variablen sind gleichberechtigt. Korrelationen (und Regressionen, die wir später [in einem Tutorial](/lehre/statistik-i/einfache-reg) kennen lernen werden) liefern *keine* Hinweise auf Kausalitäten. Sie sagen beide etwas über den (linearen) Zusammenhang zweier Variablen aus.

In R können wir uns auch eine *Korrelationsmatrix* ausgeben lassen. Dies geschieht äquivalent zu der Kovarianzmatrix mit dem Datensatz als Argument in der `cor()` Funktion. In der Diagonale stehen die Korrelationen der Variable mit sich selbst - also 1 - und in den restlichen Feldern die Korrelationen der Variablen untereinander.


``` r
cor(big5, use = 'pairwise')
```

```
##             extra       vertr      gewis       neuro       offen
## extra  1.00000000  0.05616607 0.02004818 -0.40729774  0.12997336
## vertr  0.05616607  1.00000000 0.14820429 -0.01387946  0.10362751
## gewis  0.02004818  0.14820429 1.00000000  0.12364824  0.02006590
## neuro -0.40729774 -0.01387946 0.12364824  1.00000000 -0.01517605
## offen  0.12997336  0.10362751 0.02006590 -0.01517605  1.00000000
```


Die Stärke des korrelativen Zusammenhangs wird mit dem Korrelationskoeffizienten ausgedrückt, der zwischen -1 und +1 liegt. 
Die default-Einstellung bei `cor()`ist die *Produkt-Moment-Korrelation*, also die Pearson-Korrelation.


``` r
cor(fb25$neuro, fb25$gewis, use = "pairwise", method = "pearson")
```

```
## [1] 0.1236482
```


Achtung! Die inferenzstatistische Testung der Pearson-Korrelation hat gewisse Voraussetzungen, die vor der Durchführung überprüft werden sollten!

### Voraussetzungen Pearson-Korrelation

1. *Skalenniveau*: intervallskalierte Daten $\rightarrow$ ok (Ratingskalen werden meist als intervallskaliert aufgefasst, auch wenn das nicht 100% korrekt ist)  
2. *Linearität*: Zusammenhang muss linear sein $\rightarrow$ grafische Überprüfung (siehe  Scatterplot)  
3. *Normalverteilung*: Variablen müssen normalverteilt sein $\rightarrow$ QQ-Plot, Histogramm oder Shapiro-Wilk-Test  

#### zu 3. Normalverteilung

$\rightarrow$ QQ-Plot, Histogramm & Shapiro-Wilk-Test

Der *Shapiro-Wilk-Test* prüft, ob eine Variable normalverteilt ist. Die Nullhypothese des Tests besagt, dass die Daten aus einer normalverteilten Grundgesamtheit stammen. Ein p-Wert kleiner als das gewählte Signifikanzniveau (z. B. $\alpha$ = 0.05) spricht gegen die Annahme einer Normalverteilung, ein größerer p-Wert dagegen nicht. Der Test liefert eine Entscheidungsgrundlage dafür, ob die Annahme einer Normalverteilung für die vorliegenden Daten plausibel ist und welche statistischen Verfahren angewendet werden sollten.


``` r
# car-Paket laden
library(car)
```

```
## Loading required package: carData
```

``` r
#QQ
qqPlot(fb25$neuro)
```

![](/korrelation_files/unnamed-chunk-13-1.png)<!-- -->

```
## [1]  8 78
```

``` r
qqPlot(fb25$gewis)
```

![](/korrelation_files/unnamed-chunk-13-2.png)<!-- -->

```
## [1]  8 29
```

``` r
#Histogramm

hist(fb25$neuro, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb25$neuro, na.rm = T), sd = sd(fb25$neuro, na.rm = T)), col = "blue", add = T)  
```

![](/korrelation_files/unnamed-chunk-13-3.png)<!-- -->

``` r
hist(fb25$gewis, prob = T, ylim = c(0,1))
curve(dnorm(x, mean = mean(fb25$gewis, na.rm = T), sd = sd(fb25$gewis, na.rm = T)), col = "blue", add = T)
```

![](/korrelation_files/unnamed-chunk-13-4.png)<!-- -->

``` r
#Shapiro
shapiro.test(fb25$neuro)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb25$neuro
## W = 0.96305, p-value = 2.605e-05
```

``` r
shapiro.test(fb25$gewis)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb25$gewis
## W = 0.94854, p-value = 7.546e-07
```

$p < \alpha$ $\rightarrow$ $H_1$: Normalverteilung kann nicht angenommen werden. Somit ist diese Voraussetzung verletzt. Eine Möglichkeit damit umzugehen, ist die Rangkorrelation nach Spearman. Diese ist nicht an die Voraussetzung der Normalverteilung gebunden. Das Verfahren kann über `method = "spearman"` angewendet werden.

{{<intext_anchor Rs>}}

#### Rangkorrelation in R


``` r
r1 <- cor(fb25$neuro,fb25$gewis,
          method = "spearman",     #Pearson ist default
          use = "complete") 

r1
```

```
## [1] 0.106223
```


#### Interpretation des deskriptiven Zusammenhangs

Es handelt sich um eine schwache positive Korrelation von _r_ = 0.11. Der Effekt ist nach Cohens (1988) Konvention als vernachlässigbar bis schwach zu bewerten. D.h. es gibt keinen nennenswerten Zusammenhang zwischen der Ausprägung in Neurotizismus und der Ausprägung in der Gewissenhaftigkeit. 

#### Cohens (1988) Konvention zur Interpretation von $|r|$

* ~ .10: schwacher Effekt  
* ~ .30: mittlerer Effekt  
* ~ .50: starker Effekt 

### Kendalls $\tau$ {{<intext_anchor tau>}}

Als weitere Variante der Rangkorrelation gibt es noch Kendalls $\tau$. Diese kann man mit `method = "kendall"` angesprochen werden.


``` r
cor(fb25$neuro, fb25$gewis, use = 'complete', method = 'kendall')
```

```
## [1] 0.07920505
```
Die Interpretation erfolgt wie bei Spearman's Rangkorrelation. 

**Signifikanztestung des Korrelationskoeffizienten:**
Nachdem der Korrelationskoeffizient berechnet wurde, kann dieser noch auf Signifikanz geprüft werden. Dazu verwenden wir die `cor.test()`-Funktion.

* $H_0$: $\rho = 0$ $\rightarrow$ es gibt keinen Zusammenhang zwischen Neurotizismus und Gewissenhaftigkeit
* $H_1$: $\rho \neq 0$ $\rightarrow$  es gibt einen Zusammenhang zwischen Neurotizismus und Gewissenhaftigkeit


``` r
cor <- cor.test(fb25$neuro, fb25$gewis, 
         alternative = "two.sided", 
         method = "spearman",      #Da Voraussetzungen für Pearson verletzt
         use = "complete")
```

```
## Warning in cor.test.default(fb25$neuro, fb25$gewis, alternative = "two.sided", :
## Cannot compute exact p-value with ties
```

``` r
cor$p.value      #Gibt den p-Wert aus
```

```
## [1] 0.1240077
```

Anmerkung: Bei der Rangkorrelation kann der exakte p-Wert nicht berechnet werden, da gebundene Ränge vorliegen. Das Ergebnis ist allerdings sehr eindeutig: $p > \alpha$ $\rightarrow$ $H_0$. Die Korrelation fällt nicht signifikant von 0 verschieden aus, d.h. die $H_0$ wird beibehalten. Daraus würde sich die folgende Interpretation ergeben:

**Ergebnisinterpretation:**
Es wurde untersucht, ob Neurotizismus und Gewissenhaftigkeit miteinander zusammenhängen. Der Spearman-Korrelationskoeffizient beträgt 0.11 und ist statistisch nicht signifikant (_p_ = 0.124). Folglich wird die Nullhypothese hier beibehalten: Neurotizismus und Gewissenhaftigkeit weisen keinen Zusammenhang auf.

**Modifikation**
Wir haben in der Funktion `cor.test()` als Argument `method = "spearman"` eingegeben, da die Voraussetzungen für die Pearson-Korrelation nicht erfüllt waren. Wenn dies der Fall gewesen wäre, müsste man stattdessen `method = "pearson"` angeben:


``` r
cor.test(fb25$neuro, fb25$gewis, 
         alternative = "two.sided", 
         method = "pearson",       
         use = "complete")
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  fb25$neuro and fb25$gewis
## t = 1.8014, df = 209, p-value = 0.07308
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.0116143  0.2544670
## sample estimates:
##       cor 
## 0.1236482
```

### Zusammenhang dichotomer (nominaler) Variablen {#Dichotome_var .anchorheader}

Abschließend lernen wir Zusammenhangsmaße für dichotome nominalskalierte Variablen kennen. Dazu bearbeiten wir folgende Forschungsfragestellung: Haben Studierende mit Wohnort in Uninähe (Frankfurt) eher einen Nebenjob als Studierende, deren Wohnort außerhalb von Frankfurt liegt?

Wir analysieren aus unserem Datensatz die beiden dichotomen Variablen `job` (ja [`ja`] vs. nein [`nein`]) und `ort` (Frankfurt [`FFM`] vs. außerhalb [`andere`]). Die Variablen `ort` und `job` liegen nach den vorbereitenden Schritten bereits als Faktor-Variablen mit entsprechende Labels vor. Dies wird durch die folgende Prüfung bestätigt:


``` r
is.factor(fb25$ort)
```

```
## [1] TRUE
```

``` r
is.factor(fb25$job)
```

```
## [1] TRUE
```

Bevor wir uns mit der Berechnung statistisch komplexerer Zusammenhangsmaße beschäftigen, möchten wir zunächst die Beziehung zwischen den beiden Variablen mithilfe von Häufigkeitstabellen sowie grafisch verdeutlichen.

#### Häufigkeitstabellen 

{{<intext_anchor Kreuztabellen>}}

Die Gruppengehörigkeit verschiedener Kombinationen der dichotomen Variablen `job` und `ort` können Sie mithilfe einer sogenannten *Kreuztabelle* darstellen. *Kreuztabellen* sind *Häufigkeitstabellen* zur Darstellung bivariater Häufigkeiten. Sie stellen somit eine Erweiterung der Ihnen bereits bekannten Häufigkeitstabellen des univariaten Falls dar, die Sie mit dem Befehl `table()` erstellt haben.

Kreuztabellen liefern die Häufigkeit von Kombinationen von Ausprägungen in mehreren Variablen. In den Zeilen wird die erste Variable abgetragen und in den Spalten die zweite. Im Unterschied zum univariaten Fall muss im `table()`-Befehl nur die zweite interessierende Variable zusätzlich genannt werden. Tabellen können beliebig viele Dimensionen haben, werden dann aber sehr unübersichtlich.

Erstellen der Kreuztabelle als Datenbasis:

``` r
tab <- table(fb25$ort, fb25$job)
tab
```

```
##          
##           nein ja
##   FFM       78 46
##   anderer   55 24
```

In eine Kreuztabelle können Randsummen mit dem `addmargins()` Befehl hinzugefügt werden. Randsummen erzeugen in der letzten Spalte bzw. Zeile die univariaten Häufigkeitstabellen der Variablen.


``` r
addmargins(tab)                       #Randsummen hinzufügen
```

```
##          
##           nein  ja Sum
##   FFM       78  46 124
##   anderer   55  24  79
##   Sum      133  70 203
```

{{<intext_anchor Relativtabelle>}}

Auch für die Kreuztabelle ist die Möglichkeit der Darstellung der Häufigkeiten in Relation zur Gesamtzahl der Beobachtungen gegeben. 


``` r
prop.table(tab)                       #Relative Häufigkeiten
```

```
##          
##                nein        ja
##   FFM     0.3842365 0.2266010
##   anderer 0.2709360 0.1182266
```

78 von insgesamt 203 (38.42%) Studierenden wohnen in Frankfurt *und* haben keinen Nebenjob.


`prob.table()` kann allerdings nicht nur an der Gesamtzahl relativiert werden, sondern auch an der jeweiligen Zeilen- oder Spaltensumme. Dafür gibt man im Argument `margin` für Zeilen `1` oder für Spalten `2` an.


``` r
prop.table(tab, margin = 1)           #relativiert an Zeilen
```

```
##          
##                nein        ja
##   FFM     0.6290323 0.3709677
##   anderer 0.6962025 0.3037975
```

Von 124 Personen, die in Frankfurt Wohnen, haben 62.9% (nämlich 78 Personen) keinen Nebenjob.


``` r
prop.table(tab, margin = 2)           #relativiert an Spalten
```

```
##          
##                nein        ja
##   FFM     0.5864662 0.6571429
##   anderer 0.4135338 0.3428571
```

Von 133 Personen, die keinen Nebenjob haben, wohnen 58.65% (nämlich 78 Personen) in Frankfurt.


`addmargins()`und `prop.table()` können beliebig kombiniert werden.
`prop.table(addmargins(tab))` behandelt die Randsummen als eigene Kategorie (inhaltlich meist unsinnig!).
`addmargins(prop.table(tab))` liefert die Randsummen der relativen Häufigkeiten.


``` r
addmargins(prop.table(tab))      # als geschachtelte Funktion
```

```
##          
##                nein        ja       Sum
##   FFM     0.3842365 0.2266010 0.6108374
##   anderer 0.2709360 0.1182266 0.3891626
##   Sum     0.6551724 0.3448276 1.0000000
```

``` r
prop.table(tab) |> addmargins()  # als Pipe
```

```
##          
##                nein        ja       Sum
##   FFM     0.3842365 0.2266010 0.6108374
##   anderer 0.2709360 0.1182266 0.3891626
##   Sum     0.6551724 0.3448276 1.0000000
```

#### Balkendiagramme {#Balkendiagramm .anchorheader}

Grafisch kann eine solche Kreuztabelle durch gruppierte Balkendiagramme dargestellt werden. Das Argument `beside` sorgt für die Anordnung der Balken (bei `TRUE` nebeneinander, bei `FALSE` übereinander). Das Argument `legend` nimmt einen Vektor für die Beschriftung entgegen. Die Zeilen des Datensatzes bilden dabei stets eigene Balken, während die Spalten die Gruppierungsvariable bilden. Deshalb müssen als Legende die Namen der Reihen `rownames()` unserer Tabelle `tab` ausgewählt werden.


``` r
barplot (tab,
         beside = TRUE,
         col = c('mintcream','olivedrab'),
         legend = rownames(tab))
```

![](/korrelation_files/unnamed-chunk-25-1.png)<!-- -->

Somit haben Sie sich einen klaren Überblick über die bivariate Beziehung verschafft und können nun einen geeigneten Korrelationskoeffizienten berechnen und interpretieren.

**Korrelationskoeffizient Phi** ($\phi$)

Wie in der Vorlesung behandelt, berechnet sich $\phi$ folgendermaßen:

$$\phi = \frac{n_{11}n_{22}-n_{12}n_{21}}{\sqrt{(n_{11}+n_{12})(n_{11}+n_{21})(n_{12}+n_{22})(n_{21}+n_{22})}}$$ welches einen Wertebereich von [-1,1] aufweist und analog zur Korrelation interpretiert werden kann. 1 steht in diesem Fall für einen perfekten positiven Zusammenhang .

Durch ein mathematisches Wunder (dass Sie gerne anhand der Formeln für Kovarianz und Korrelation nachvollziehen können) entspricht diese Korrelation exakt dem Wert, den wir auch anhand der Pearson-Korrelation zwischen den beiden Variablen bestimmen würden:


``` r
# Numerische Variablen erstellen
ort_num <- as.numeric(fb25$ort)
job_num <- as.numeric(fb25$job)

cor(ort_num, job_num, use = 'pairwise')
```

```
## [1] -0.06890118
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
## t = -0.97917, df = 201, p-value = 0.3287
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.20466904  0.06946779
## sample estimates:
##         cor 
## -0.06890118
```


Cohen (1988) hat folgende Konventionen zur Beurteilung der Effektstärke $\phi$ vorgeschlagen, die man heranziehen kann, um den Effekt "bei kompletter Ahnungslosigkeit" einschätzen zu können (wissen wir mehr über den Sachverhalt, so sollten Effektstärken lieber im Bezug zu anderen Studienergebnissen interpretiert werden):

| *phi* |  Interpretation  |
|:-----:|:----------------:|
| \~ .1 |  kleiner Effekt  |
| \~ .3 | mittlerer Effekt |
| \~ .5 |  großer Effekt   |

Der Wert für den Zusammenhang der beiden Variablen ist also bei völliger Ahnungslosigkeit als klein einzuschätzen.

In `R` sieht eine händische Berechnung von Phi so aus:


``` r
korr_phi <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
  sqrt((tab[1,1]+tab[1,2])*(tab[1,1]+tab[2,1])*(tab[1,2]+tab[2,2])*(tab[2,1]+tab[2,2]))
korr_phi
```

```
## [1] -0.06890118
```

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
## [1] -0.1494775
```


Das Ganze lässt sich auch mit dem `psych` Paket und der darin enthaltenen Funktionen `phi()` und `Yule()` umsetzen:


``` r
# alternativ mit psych Paket
library(psych)
```

```
## 
## Attaching package: 'psych'
```

```
## The following object is masked from 'package:car':
## 
##     logit
```

``` r
phi(tab, digits = 8)
```

```
## [1] -0.06890118
```

``` r
Yule(tab)
```

```
## [1] -0.1494775
```

**Odds (Wettquotient) und Odds-Ratio** {#odds-wettquotient-und-odds-ratio .anchorheader}

Der Odds (Wettquotient, Chance) gibt das Verhältnis der Wahrscheinlichkeiten an, dass ein Ereignis eintritt bzw. dass es nicht eintritt. 
Das Wettquotienten-Verhältnis (Odds-Ratio) zeigt an, um wieviel sich dieses Verhältnis zwischen Ausprägungen einer zweiten dichotomen Variablen unterscheidet (Maß für den Zusammenhang).

Zur Erinnerung die Kreuztabelle:

``` r
tab
```

```
##          
##           nein ja
##   FFM       78 46
##   anderer   55 24
```

Berechnung des Odds für `FFM`:

``` r
Odds_FFM = tab[1,1]/tab[1,2]
Odds_FFM
```

```
## [1] 1.695652
```
Für in Frankfurt Wohnende ist die Chance keinen Job zu haben demnach 1.7-mal so hoch wie einen Job zu haben. 

Berechnung des Odds für `anderer`:

``` r
Odds_anderer = tab[2,1]/tab[2,2]
Odds_anderer
```

```
## [1] 2.291667
```

Für nicht in Frankfurt Wohnende ist die Chance keinen Job zu haben 2.29-mal so hoch wie einen Job zu haben. 

Berechnung des Odds-Ratio:

``` r
OR = Odds_anderer/Odds_FFM
OR
```

```
## [1] 1.351496
```

Die Chance, keinen Job zu haben, ist für nicht in Frankfurt Wohnende 1.35-mal so hoch wie für in Frankfurt Wohnende. Man könnte auch den Kehrwert bilden, wodurch sich der Wert ändert, die Interpretation jedoch nicht. 

#### Ergebnisinterpretation

Es wurde untersucht, ob Studierende mit Wohnort in Uninähe (also in Frankfurt) eher einen Nebenjob haben als Studierende, deren Wohnort außerhalb von Frankfurt liegt. Zur Beantwortung der Fragestellung wurden die Korrelationmaße $\phi$ und Yules Q bestimmt. Der Zusammenhang ist jeweils leicht negativ, d.h. dass Studierende, die nicht in Frankfurt wohnen, eher keinen Job haben. Der Effekt ist aber von vernachlässigbarer Größe ($\phi$ = -0.069). 
Diese Befundlage ergibt sich auch aus dem Odds-Ratio, das geringfügig größer als 1 aufällt (OR = 1.35).


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

```
## Installing package into '/home/martin/R/x86_64-pc-linux-gnu-library/4.5'
## (as 'lib' is unspecified)
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

Dank des neuen Pakets können wir nun den Koeffizienten $\hat{\gamma}$ berechnen und damit den Zusammenhang zwischen Items betrachten. Schauen wir uns nun mal den Zusammenhang der beiden Prokrastinationsitems `fb25$mdbf2` und `fb25$mdbf3` an, um zu überprüfen, ob die beiden Items auch (wie beabsichtigt) etwas Ähnliches messen (nähmlich die aktuelle Stimmung). Die beiden Variablen wurden ursprünglich auf einer Skala von 1 (*stimmt gar nicht*) bis 4 (*stimmt vollkommen*) (also auf Ordinalskalenniveau) erfasst. 


``` r
rococo(fb25$mdbf2, fb25$mdbf3)
```

```
## [1] -0.5505108
```

Um zu überprüfen, ob zwei ordinalskalierte Variablen signifikant miteinander zusammenhängen, können wir die `rococo.test()`-Funktion anwenden.


``` r
rococo.test(fb25$mdbf2, fb25$mdbf3)
```

```
## 
## 	Robust Gamma Rank Correlation:
## 
## data: fb25$mdbf2 and fb25$mdbf3 (length = 211)
## similarity: linear 
## rx = 0.1 / ry = 0.2 
## t-norm: min 
## alternative hypothesis: true gamma is not equal to 0 
## sample gamma = -0.5505108 
## estimated p-value = < 2.2e-16 (0 of 1000 values)
```


Der Koeffizient von -0.55 zeigt uns, dass die Items zwar miteinander korrelieren, allerdings negativ. Ist hier etwas schief gelaufen? Nein, `mdbf2_pre` und `mdbf3_pre` repräsentieren gegenläufige Stimmungsaspekte. Mit der rekodierten Variante einer der beiden Variablen würde das `-` nicht da stehen, aber die Höhe der Korrelation bliebe gleich. Wir sehen daher, dass `mdbf2` mit `mdbf3` signifikant zusammenhängt. Die beiden Items messen demnach ein ähnliches zugrundeliegendes Konstrukt (aktuelle Stimmung).


</details>



