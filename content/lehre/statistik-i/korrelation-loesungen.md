---
title: "Korrelation - Lösungen" 
type: post
date: '2021-01-04' 
slug: korrelation-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [nehler, winkler, schroeder] 
weight: 
lastmod: '2023-10-28'
featured: no
banner:
  image: "/header/storch_with_baby.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/855019)"
projects: []
expiryDate: 
publishDate: '2024-01-28'
_build:
  list: never
reading_time: false
share: false
output:
  html_document:
    keep_md: true
---

## Vorbereitung



Laden Sie zunächst den Datensatz `fb22` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb22.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/gruppenvergleiche-abhaengig/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

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


***
# Korrelation

## Aufgabe 1

In der Befragung am Anfang des Semesters wurde gefragt, ob Sie neben der Uni einen Nebenjob (`job`) ausüben und in welcher Wohnsituation Sie sich befinden (`wohnen`). Erstellen Sie für diese beiden Variablen eine Kreuztabelle mit Randsummen.

-   Stellen Sie zunächst sicher, dass die Variablen als Faktoren vorliegen und die Kategorien beider Variablen korrekt bezeichnet sind.

<details>

<summary>Lösung</summary>

Zunächst können wir überprüfen, ob die Variablen als Fakto vorliegen.


```r
#Labels
is.factor(fb22$job)
```

```
## [1] FALSE
```

```r
is.factor(fb22$wohnen)
```

```
## [1] TRUE
```

Wenn Sie die Datensatzvorbereitung aus dem Skript kopiert haben, sollte `wohnen` bereits ein Faktor sein. Also müssen nur `job` in einen Faktor verwandeln.


```r
#Labels
fb22$job <- factor(fb22$job, levels = c(1, 2),
  labels = c('nein', 'ja'))

str(fb22$job)
```

```
##  Factor w/ 2 levels "nein","ja": 1 2 1 1 1 NA 2 1 1 1 ...
```

Für den Fall, dass `wohnen` noch kein Faktor im Datensatz war, kann folgender Code durchgeführt werden. Achten Sie aber drauf, dass dieser Befehl auf eine Variable nicht angewendet werden sollte, wenn diese bereits ein Faktor ist. Ansonsten kommt es zu dem Fehler, dass die Variable keine Informationen mehr enthält.


```r
#Labels
fb22$wohnen <- factor(fb22$wohnen, levels = 1:4,
     label = c('WG', 'bei Eltern', 'alleine', 'sonstiges'))
```

Die Variable sieht dann folgendermaßen aus.


```r
str(fb22$wohnen)
```

```
##  Factor w/ 4 levels "WG","bei Eltern",..: 2 2 3 4 2 NA 2 1 1 3 ...
```

</details>

-   Wie viele Personen wohnen in einer WG und haben keinen Nebenjob?

<details>

<summary>Lösung</summary>


```r
# Kreuztabelle absolut
tab <- table(fb22$job, fb22$wohnen)
addmargins(tab)
```

```
##       
##         WG bei Eltern alleine sonstiges Sum
##   nein  25         35      23        14  97
##   ja    13         21      12         5  51
##   Sum   38         56      35        19 148
```

25 Personen wohnen in einer WG und haben keinen Nebenjob.

</details>

-   Was ist der relative Anteil aller Teilnehmer:innen, die bei ihren Eltern wohnen?

<details>

<summary>Lösung</summary>


```r
# Relative Häufigkeiten, mit Randsummen
addmargins(prop.table(tab))
```

```
##       
##                WG bei Eltern    alleine  sonstiges        Sum
##   nein 0.16891892 0.23648649 0.15540541 0.09459459 0.65540541
##   ja   0.08783784 0.14189189 0.08108108 0.03378378 0.34459459
##   Sum  0.25675676 0.37837838 0.23648649 0.12837838 1.00000000
```

37.84% aller Teilnehmer:innen wohnen bei ihren Eltern.

</details>

-   Welcher Anteil der Personen, die alleine wohnen, gehen einer Nebentätigkeit nach?

<details>

<summary>Lösung</summary>


```r
# Relative Häufigkeiten, an wohnen normiert
prop.table(tab, 2)
```

```
##       
##               WG bei Eltern   alleine sonstiges
##   nein 0.6578947  0.6250000 0.6571429 0.7368421
##   ja   0.3421053  0.3750000 0.3428571 0.2631579
```

34.29% aller Teilnehmer:innen, die alleine wohnen, gehen einer Nebentätigkeit nach.

</details>

## Aufgabe 2

Erstellen Sie für diese Kombination an Variablen ein gruppiertes Balkendiagramm.

-   Achten Sie darauf, dass die Balken nebeneinander stehen.
-   Nutzen Sie für die Personen mit und ohne Nebenjob unterschiedliche Farben und fügen Sie eine Legende hinzu, die das verdeutlicht.

<details>

<summary>Lösung</summary>


```r
# Gruppiertes Balkendiagramm
barplot(tab,
  beside = TRUE,             # nebeneinander
  col = c('blue', 'orange'), # Farben definieren: Blau und Orange
  legend = rownames(tab))    # Legende einfuegen
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

</details>

## Aufgabe 3

Welche der fünf Persönlichkeitsdimensionen Extraversion (`extra`), Verträglichkeit (`vertr`), Gewissenhaftigkeit (`gewis`), Neurotizismus (`neuro`) und Intellekt (`intel`) ist am stärksten mit der Lebenszufriedenheit korreliert (`lz`)?

-   Überprüfen Sie die Voraussetzungen für die Pearson-Korrelation.

<details>

<summary>Lösung</summary>

**Voraussetzungen Pearson-Korrelation:**

1.  Skalenniveau: intervallskalierte Daten $\rightarrow$ ok\
2.  Linearität: Zusammenhang muss linear sein $\rightarrow$ Grafische überprüfung (Scatterplot)


```r
# Scatterplot
plot(fb22$extra, fb22$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

```r
plot(fb22$vertr, fb22$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-11-2.png)<!-- -->

```r
plot(fb22$gewis, fb22$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-11-3.png)<!-- -->

```r
plot(fb22$neuro, fb22$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-11-4.png)<!-- -->

```r
plot(fb22$intel, fb22$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-11-5.png)<!-- -->

</details>

<details>

<summary>Lösung</summary>

3.  Normalverteilung $\rightarrow$ QQ-Plot, Histogramm oder Shapiro-Wilk-Test


```r
#QQ
qqnorm(fb22$extra)
qqline(fb22$extra)
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

```r
qqnorm(fb22$vertr)
qqline(fb22$vertr)
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-12-2.png)<!-- -->

```r
qqnorm(fb22$gewis)
qqline(fb22$gewis)
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-12-3.png)<!-- -->

```r
qqnorm(fb22$neuro)
qqline(fb22$neuro)
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-12-4.png)<!-- -->

```r
qqnorm(fb22$intel)
qqline(fb22$intel)
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-12-5.png)<!-- -->

```r
qqnorm(fb22$lz)
qqline(fb22$lz)
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-12-6.png)<!-- -->

```r
#Histogramm
hist(fb22$extra, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb22$extra, na.rm = T), sd = sd(fb22$extra, na.rm = T)), col = "blue", add = T)  
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-12-7.png)<!-- -->

```r
hist(fb22$vertr, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb22$vertr, na.rm = T), sd = sd(fb22$vertr, na.rm = T)), col = "blue", add = T)  
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-12-8.png)<!-- -->

```r
hist(fb22$gewis, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb22$gewis, na.rm = T), sd = sd(fb22$gewis, na.rm = T)), col = "blue", add = T)  
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-12-9.png)<!-- -->

```r
hist(fb22$neuro, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb22$neuro, na.rm = T), sd = sd(fb22$neuro, na.rm = T)), col = "blue", add = T)  
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-12-10.png)<!-- -->

```r
hist(fb22$intel, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb22$intel, na.rm = T), sd = sd(fb22$intel, na.rm = T)), col = "blue", add = T)  
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-12-11.png)<!-- -->

```r
hist(fb22$lz, prob = T, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb22$lz, na.rm = T), sd = sd(fb22$lz, na.rm = T)), col = "blue", add = T)  
```

![](pandar.git//lehre/statistik-i/stat-i-korrelation-loesungen_files/figure-html/unnamed-chunk-12-12.png)<!-- -->

```r
#Shapiro
shapiro.test(fb22$extra)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb22$extra
## W = 0.98526, p-value = 0.09014
```

```r
shapiro.test(fb22$vertr)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb22$vertr
## W = 0.95611, p-value = 6.624e-05
```

```r
shapiro.test(fb22$gewis)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb22$gewis
## W = 0.95665, p-value = 7.423e-05
```

```r
shapiro.test(fb22$neuro)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb22$neuro
## W = 0.97456, p-value = 0.004916
```

```r
shapiro.test(fb22$intel)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb22$intel
## W = 0.96559, p-value = 0.0005415
```

```r
shapiro.test(fb22$lz)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb22$lz
## W = 0.96405, p-value = 0.0004178
```

$p < \alpha$ $\rightarrow$ H1: Normalverteilung kann für alle Variablen außer `extra` nicht angenommen werden. Somit ist diese Voraussetzung für die meisten Variablen verletzt. Daher sollten wir fortlaufend die Rangkorrelation nach Spearman nutzen.

</details>

-   Erstellen Sie für diese Frage eine Korrelationsmatrix, die alle Korrelationen enthält. Verwenden Sie die Funktion `round()` (unter Betrachtung der Hilfe), um die Werte auf zwei Nachkommastellen zu runden und die Tabelle dadurch übersichtlicher darzustellen.

<details>
<summary>Lösung</summary>


```r
# Korrelationstabelle erstellen und runden
cor_mat <- round(cor(fb22[,c('lz', 'extra', 'vertr', 'gewis', 'neuro', 'intel')], use = 'pairwise', method = 'spearman'),2)
cor_mat
```

```
##          lz extra vertr gewis neuro intel
## lz     1.00  0.16  0.12  0.27 -0.18  0.24
## extra  0.16  1.00  0.32  0.04  0.09  0.20
## vertr  0.12  0.32  1.00  0.25  0.08  0.19
## gewis  0.27  0.04  0.25  1.00  0.00  0.24
## neuro -0.18  0.09  0.08  0.00  1.00  0.05
## intel  0.24  0.20  0.19  0.24  0.05  1.00
```


</details>

-   Wie würden Sie das Ausmaß dieser Korrelation nach den Richtlinien von Cohen (1988) einschätzen?

<details>

<summary>Lösung</summary>

Die größte Korrelation mit der Lebenszufriedenheit hat die Gewissenhaftigkeit. Nach den Richtlinien ist diese mit 0.27 einem positiven mittleren Effekt, der ungefähr 0.3 beträgt, zuzuordnen.

</details>

-   Ist der Korrelationskoeffizient von Lebenszufriedenheit und Gewissenhaftigkeit statistisch signifikant?

<details>

<summary>Lösung</summary>


```r
cor.test(fb22$lz, fb22$gewis, 
         alternative = "two.sided", 
         method = "spearman",       
         use = "complete.obs")
```

```
## Warning in cor.test.default(fb22$lz, fb22$gewis, alternative = "two.sided", : Cannot compute exact p-value with ties
```

```
## 
## 	Spearman's rank correlation rho
## 
## data:  fb22$lz and fb22$gewis
## S = 473208, p-value = 0.0007487
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##       rho 
## 0.2662948
```

$p < \alpha$ $\rightarrow$ H1. Die Korrelation ist mit einer Irrtumswahrscheinlichkeit von 5% signifikant von 0 verschieden.

</details>

## Aufgabe 4

Berechnen sie die Pearson-Korrelation, die Spearman-Korrelation, Kendall's Tau sowie $\hat{\gamma}$ für den Zusammenhang von `prok1` und `prok6`.

<details>

<summary>Lösung</summary>


```r
library(rococo)
cor(fb22$prok1, fb22$prok6, method = "pearson")
```

```
## [1] 0.2569755
```

```r
cor(fb22$prok1, fb22$prok6, method = "spearman")
```

```
## [1] 0.2553553
```

```r
cor(fb22$prok1, fb22$prok6, method = "kendall")
```

```
## [1] 0.2278183
```

```r
rococo(fb22$prok1, fb22$prok6)
```

```
## [1] 0.3299527
```

</details>

## Aufgabe 5

Das Paket `psych` enthält vielerlei Funktionen, die für die Analyse von Datensätzen aus psychologischer Forschung praktisch sind. Eine von ihnen (`describe()`) erlaubt es, gleichzeitig verschiedene Deskriptivstatistiken für Variablen zu erstellen.

-   Installieren und laden Sie das Paket `psych`.

<details>

<summary>Lösung</summary>


```r
# Paket installieren
install.packages('psych')
```


```r
# Paket laden
library(psych)
```

</details>

-   Nutzen Sie den neugewonnen Befehl `describe()`, um sich gleichzeitig die verschiedenen Deskriptivstatistiken für Lebenszufriedenheit (`lz`) ausgeben zu lassen.

<details>

<summary>Lösung</summary>


```r
describe(fb22$lz)
```

```
##    vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 157 4.71 1.07    4.8    4.79 0.89 1.4 6.6   5.2 -0.64     0.04 0.09
```

</details>

-   `describe()` kann auch genutzt werden, um gleichzeitig Deskriptivstatistiken für verschiedene Variablen zu berechnen. Nutzen Sie diese Funktionalität, um sich gleichzeitg die univariaten Deskriptivstatistiken für die fünf Persönlichkeitsdimensionen ausgeben zu lassen.

<details>

<summary>Lösung</summary>


```r
describe(fb22[,c("extra","vertr","gewis","neuro","intel")])
```

```
##       vars   n mean   sd median trimmed  mad  min max range  skew kurtosis   se
## extra    1 159 3.38 0.71   3.25    3.39 0.74 1.50   5  3.50 -0.06    -0.31 0.06
## vertr    2 159 4.10 0.58   4.00    4.12 0.74 2.50   5  2.50 -0.34    -0.40 0.05
## gewis    3 159 3.88 0.66   4.00    3.91 0.74 2.00   5  3.00 -0.53    -0.11 0.05
## neuro    4 159 3.63 0.72   3.75    3.65 0.74 1.25   5  3.75 -0.43     0.09 0.06
## intel    5 159 3.59 0.62   3.75    3.61 0.37 1.25   5  3.75 -0.49     1.08 0.05
```

</details>


***
