---
title: "Korrelation - Lösungen" 
type: post
date: '2021-01-04' 
slug: korrelation-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [nehler, winkler, vogler, schroeder] 
weight: 
lastmod: '2024-01-16'
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



> Laden Sie zunächst den Datensatz `fb23` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb23.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/korrelation/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb23)
```

```
## [1] 179  53
```

```r
names(fb23)
```

```
##  [1] "mdbf1_pre"    "mdbf2_pre"    "mdbf3_pre"   
##  [4] "mdbf4_pre"    "mdbf5_pre"    "mdbf6_pre"   
##  [7] "mdbf7_pre"    "mdbf8_pre"    "mdbf9_pre"   
## [10] "mdbf10_pre"   "mdbf11_pre"   "mdbf12_pre"  
## [13] "lz"           "extra"        "vertr"       
## [16] "gewis"        "neuro"        "offen"       
## [19] "prok"         "nerd"         "grund"       
## [22] "fach"         "ziel"         "wissen"      
## [25] "therap"       "lerntyp"      "hand"        
## [28] "job"          "ort"          "ort12"       
## [31] "wohnen"       "uni1"         "uni2"        
## [34] "uni3"         "uni4"         "attent_pre"  
## [37] "gs_post"      "wm_post"      "ru_post"     
## [40] "attent_post"  "hand_factor"  "fach_klin"   
## [43] "unipartys"    "mdbf4_pre_r"  "mdbf11_pre_r"
## [46] "mdbf3_pre_r"  "mdbf9_pre_r"  "mdbf5_pre_r" 
## [49] "mdbf7_pre_r"  "wm_pre"       "gs_pre"      
## [52] "ru_pre"       "ru_pre_zstd"
```

Der Datensatz besteht aus 179 Zeilen (Beobachtungen) und 53 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.


***

## Aufgabe 1

Das Paket `psych` enthält vielerlei Funktionen, die für die Analyse von Datensätzen aus psychologischer Forschung praktisch sind. Eine von ihnen (`describe()`) erlaubt es, gleichzeitig verschiedene Deskriptivstatistiken für Variablen zu erstellen.

  * Installieren (falls noch nicht geschehen) und laden Sie das Paket `psych`.
  * Nutzen Sie den neugewonnen Befehl `describe()`, um sich gleichzeitig die verschiedenen Deskriptivstatistiken für Lebenszufriedenheit (`lz`) ausgeben zu lassen.
  * Die Funktion `describeBy()` ermöglicht außerdem Deskriptivstatistiken in Abhängigkeit einer gruppierenden Variable auszugeben. Machen Sie sich diesen Befehl zunutze, um sich die Lebenszufriedenheit (`lz`) abhängig von der derzeitigen Wohnsituation (`wohnen`) anzeigen zu lassen.
  * `describe()` kann auch genutzt werden, um gleichzeitig Deskriptivstatistiken für verschiedene Variablen zu berechnen. Nutzen Sie diese Funktionalität, um sich gleichzeitg die univariaten Deskriptivstatistiken für die fünf Persönlichkeitsdimensionen ausgeben zu lassen.

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
describe(fb23$lz)
```

```
##    vars   n mean   sd median trimmed  mad min max range
## X1    1 177 5.12 1.05    5.4    5.19 0.89 1.4   7   5.6
##     skew kurtosis   se
## X1 -0.75     0.58 0.08
```

</details>

-   `describeBy()` ermöglicht die Ausgabe von Deskriptivstatistiken in Abhängigkeit einer gruppierenden Variable.

<details>

<summary>Lösung</summary>


```r
describeBy(fb23$lz, group = fb23$wohnen)
```

```
## 
##  Descriptive statistics by group 
## group: WG
##    vars  n mean   sd median trimmed  mad min max range
## X1    1 55 5.11 1.09    5.2    5.19 0.89 1.4   7   5.6
##     skew kurtosis   se
## X1 -0.83     0.94 0.15
## --------------------------------------------- 
## group: bei Eltern
##    vars  n mean   sd median trimmed  mad min max range
## X1    1 40 5.04 1.03    5.2    5.14 0.89 1.6   7   5.4
##     skew kurtosis   se
## X1 -1.01     1.52 0.16
## --------------------------------------------- 
## group: alleine
##    vars  n mean   sd median trimmed  mad min max range
## X1    1 44  5.2 0.99    5.2    5.22 1.19 2.6 6.8   4.2
##     skew kurtosis   se
## X1 -0.24    -0.41 0.15
## --------------------------------------------- 
## group: sonstiges
##    vars  n mean   sd median trimmed  mad min max range
## X1    1 25 5.07 1.08    5.4    5.16 0.89 2.6 6.4   3.8
##     skew kurtosis   se
## X1 -0.81    -0.65 0.22
```

</details>

-   `describe()` kann auch genutzt werden, um gleichzeitig Deskriptivstatistiken für verschiedene Variablen zu berechnen. Nutzen Sie diese Funktionalität, um sich gleichzeitg die univariaten Deskriptivstatistiken für die fünf Persönlichkeitsdimensionen ausgeben zu lassen.

<details>

<summary>Lösung</summary>


```r
describe(fb23[,c("extra","vertr","gewis","neuro","offen")])
```

```
##       vars   n mean   sd median trimmed  mad min max range
## extra    1 179 3.27 0.91    3.0    3.28 0.74 1.0   5   4.0
## vertr    2 178 3.46 0.82    3.5    3.49 0.74 1.0   5   4.0
## gewis    3 179 3.53 0.77    3.5    3.54 0.74 1.5   5   3.5
## neuro    4 179 3.35 0.98    3.5    3.37 0.74 1.0   5   4.0
## offen    5 179 3.74 0.93    4.0    3.79 1.48 1.5   5   3.5
##        skew kurtosis   se
## extra -0.08    -0.64 0.07
## vertr -0.26    -0.18 0.06
## gewis -0.13    -0.51 0.06
## neuro -0.19    -0.68 0.07
## offen -0.34    -0.79 0.07
```

</details>



## Aufgabe 2

In der Befragung am Anfang des Semesters wurde gefragt, ob Sie neben der Uni einen Nebenjob (`job`) ausüben und mit welcher Hand sie primär schreiben (`hand`). Erstellen Sie für diese beiden Variablen eine Kreuztabelle mit Randsummen.

  * Stellen Sie zunächst sicher, dass die Variablen als Faktoren vorliegen und die Kategorien beider Variablen korrekt bezeichnet sind. 
  * Wie viele Personen sind Linkshänder und haben keinen Nebenjob? 
  * Was ist der relative Anteil aller Teilnehmenden, die einem Nebenjob nachgehen?

  * Berechnen Sie nun mit Hilfe des `psych`-Pakets die Korrelationskoeffizienten Phi ($\phi$) und Yules Q für das oben genannte Beispiel.
  
<details>

<summary>Lösung</summary>

Zunächst können wir überprüfen, ob die Variablen als Faktor vorliegen.


```r
#Labels
is.factor(fb23$job)
```

```
## [1] TRUE
```

```r
is.factor(fb23$hand)
```

```
## [1] FALSE
```

Wenn Sie die Datensatzvorbereitung aus dem Skript kopiert haben, sollte die Variable `job` bereits ein Faktor sein.
Die Variable `hand` jedoch nicht. Dies müssen wir ändern.


```r
fb23$hand <- factor(fb23$hand,
                    levels = c(1, 2),
                    labels = c("links", "rechts"))
```

Für den Fall, dass die Variable `job` noch nicht als Faktor im Datensatz vorliegt, kann folgender Code durchgeführt werden. Achten Sie aber drauf, dass dieser Befehl auf eine Variable nicht angewendet werden sollte, wenn diese bereits ein Faktor ist. Ansonsten kommt es zu dem Fehler, dass die Variable keine Informationen mehr enthält.


```r
fb23$job <- factor(fb23$job, levels = c(1, 2),
  labels = c('nein', 'ja'))
```

Die Variablen sehen dann folgendermaßen aus.


```r
str(fb23$job)
```

```
##  Factor w/ 2 levels "nein","ja": 1 1 1 1 2 2 NA 2 1 2 ...
```

```r
str(fb23$hand)
```

```
##  Factor w/ 2 levels "links","rechts": 2 2 2 2 2 2 NA 2 1 2 ...
```

</details>

-   Wie viele Personen sind Linkshänder und haben keinen Nebenjob?

<details>

<summary>Lösung</summary>


```r
# Kreuztabelle absolut
tab <- table(fb23$hand, fb23$job)
addmargins(tab)
```

```
##         
##          nein  ja Sum
##   links    12   7  19
##   rechts   84  73 157
##   Sum      96  80 176
```

12 Personen schreiben primär mit der linken Hand und haben keinen Nebenjob.

</details>

-   Was ist der relative Anteil aller Teilnehmenden, die einem Nebenjob nachgehen?

<details>

<summary>Lösung</summary>


```r
# Relative Häufigkeiten, mit Randsummen
addmargins(prop.table(tab))
```

```
##         
##                nein         ja        Sum
##   links  0.06818182 0.03977273 0.10795455
##   rechts 0.47727273 0.41477273 0.89204545
##   Sum    0.54545455 0.45454545 1.00000000
```

45.45% aller Teilnehmenden gehen keiner Nebentätigkeit nach.

</details>

-   Berechnung der Korrelationskoeffizienten Phi ($\phi$) und Yules Q mit Hilfe des `psych`-Pakets.

<details>

<summary>Lösung</summary>


```r
phi(tab, digits = 3)
```

```
## [1] 0.06
```

```r
Yule(tab) |> round(digits = 3) #da die Yule()-Funktion nicht direkt runden kann geben wir das Ergebnis an die round()-Funktion weiter
```

```
## [1] 0.197
```

Beide Koeffizienten sprechen für eine wenn überhaupt schwache Korrelation.

</details>


## Aufgabe 3

Welche der fünf Persönlichkeitsdimensionen Extraversion (`extra`), Verträglichkeit (`vertr`), Gewissenhaftigkeit (`gewis`), Neurotizismus (`neuro`) und Offenheit für neue Erfahrungen (`offen`) ist am stärksten mit der Lebenszufriedenheit korreliert (`lz`)?

  * Überprüfen Sie die Voraussetzungen für die Pearson-Korrelation.
  * Erstellen Sie für diese Frage eine Korrelationsmatrix, die alle Korrelationen enthält. Verwenden Sie die Funktion `round()` (unter Betrachtung der Hilfe), um die Werte auf zwei Nachkommastellen zu runden und die Tabelle dadurch übersichtlicher darzustellen.
  * Wie würden Sie das Ausmaß der betragsmäßig größten Korrelation mit der Lebenszufiredenheit nach den Richtlinien von Cohen (1988) einschätzen?
  * Ist der Korrelationskoeffizient von Neurotizismus und Lebenszufriedenheit statistisch bedeutsam?


Voraussetzungsprüfung:

<details>

<summary>Lösung</summary>

**Voraussetzungen Pearson-Korrelation:**

1.  Skalenniveau: intervallskalierte Daten $\rightarrow$ ok\
2.  Linearität: Zusammenhang muss linear sein $\rightarrow$ Grafische überprüfung (Scatterplot)


```r
# Scatterplot
plot(fb23$extra, fb23$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

```r
plot(fb23$vertr, fb23$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-15-2.png)<!-- -->

```r
plot(fb23$gewis, fb23$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-15-3.png)<!-- -->

```r
plot(fb23$neuro, fb23$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-15-4.png)<!-- -->

```r
plot(fb23$offen, fb23$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-15-5.png)<!-- -->

Die fünf Scatterplots lassen allesamt auf einen linearen Zusammenhang zwischen den Variablen schließen.

</details>

<details>

<summary>Lösung</summary>

3.  Normalverteilung $\rightarrow$ QQ-Plot, Histogramm oder Shapiro-Wilk-Test


```r
#QQ
qqnorm(fb23$extra)
qqline(fb23$extra)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

```r
qqnorm(fb23$vertr)
qqline(fb23$vertr)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-16-2.png)<!-- -->

```r
qqnorm(fb23$gewis)
qqline(fb23$gewis)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-16-3.png)<!-- -->

```r
qqnorm(fb23$neuro)
qqline(fb23$neuro)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-16-4.png)<!-- -->

```r
qqnorm(fb23$offen)
qqline(fb23$offen)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-16-5.png)<!-- -->

```r
qqnorm(fb23$lz)
qqline(fb23$lz)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-16-6.png)<!-- -->

```r
#Histogramm
hist(fb23$extra, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb23$extra, na.rm = TRUE), sd = sd(fb23$extra, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-16-7.png)<!-- -->

```r
hist(fb23$vertr, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb23$vertr, na.rm = TRUE), sd = sd(fb23$vertr, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-16-8.png)<!-- -->

```r
hist(fb23$gewis, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb23$gewis, na.rm = TRUE), sd = sd(fb23$gewis, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-16-9.png)<!-- -->

```r
hist(fb23$neuro, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb23$neuro, na.rm = TRUE), sd = sd(fb23$neuro, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-16-10.png)<!-- -->

```r
hist(fb23$offen, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb23$offen, na.rm = TRUE), sd = sd(fb23$offen, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-16-11.png)<!-- -->

```r
hist(fb23$lz, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb23$lz, na.rm = TRUE), sd = sd(fb23$lz, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-16-12.png)<!-- -->

```r
#Shapiro
shapiro.test(fb23$extra)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb23$extra
## W = 0.96277, p-value = 0.0001067
```

```r
shapiro.test(fb23$vertr)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb23$vertr
## W = 0.95626, p-value = 2.466e-05
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

```r
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
shapiro.test(fb23$offen)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb23$offen
## W = 0.93418, p-value = 2.776e-07
```

```r
shapiro.test(fb23$lz)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb23$lz
## W = 0.96084, p-value = 7.429e-05
```

$p < \alpha$ $\rightarrow$ H1: Normalverteilung kann für alle Variablen nicht angenommen werden. Somit ist diese Voraussetzung für alle Variablen verletzt. Daher sollten wir fortlaufend die Rangkorrelation nach Spearman nutzen.

</details>

-   Erstellen Sie für diese Frage eine Korrelationsmatrix, die alle Korrelationen enthält. Verwenden Sie die Funktion `round()` (unter Betrachtung der Hilfe), um die Werte auf zwei Nachkommastellen zu runden und die Tabelle dadurch übersichtlicher darzustellen.

<details>
<summary>Lösung</summary>


```r
# Korrelationstabelle erstellen und runden
cor_mat <- round(cor(fb23[,c('lz', 'extra', 'vertr', 'gewis', 'neuro', 'offen')],
                     use = 'pairwise',
                     method = 'spearman'),2)
cor_mat
```

```
##          lz extra vertr gewis neuro offen
## lz     1.00  0.33  0.15  0.16 -0.23 -0.04
## extra  0.33  1.00 -0.02  0.08 -0.36  0.12
## vertr  0.15 -0.02  1.00 -0.01  0.15 -0.13
## gewis  0.16  0.08 -0.01  1.00 -0.02  0.11
## neuro -0.23 -0.36  0.15 -0.02  1.00 -0.02
## offen -0.04  0.12 -0.13  0.11 -0.02  1.00
```


</details>

-   Wie würden Sie das Ausmaß der betragsmäßig größten Korrelation mit der Lebenszufriedenheit nach den Richtlinien von Cohen (1988) einschätzen?

<details>

<summary>Lösung</summary>

Die betragsmäßig größte Korrelation mit der Lebenszufriedenheit hat die Extraversion. Nach den Richtlinien ist diese mit 0.33 einem positiven mittleren Effekt, der ungefähr 0.3 beträgt, zuzuordnen.

</details>

-   Ist der Korrelationskoeffizient von Lebenszufriedenheit und Neurotizismus statistisch signifikant?

<details>

<summary>Lösung</summary>


```r
cor.test(fb23$lz, fb23$neuro, 
         alternative = "two.sided", 
         method = "spearman",       
         use = "pairwise") 
```

```
## Warning in cor.test.default(fb23$lz, fb23$neuro,
## alternative = "two.sided", : Cannot compute exact p-value
## with ties
```

```
## 
## 	Spearman's rank correlation rho
## 
## data:  fb23$lz and fb23$neuro
## S = 1136540, p-value = 0.002093
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##        rho 
## -0.2297879
```

$p < \alpha$ $\rightarrow$ H1. Die Korrelation ist mit einer Irrtumswahrscheinlichkeit von 5% signifikant von 0 verschieden.

</details>

## Aufgabe 4

Untersuchen Sie die Korrelation zwischen Nerdiness (`nerd`) und Prokrastinationstendenz (`prok`). Berechnen Sie dafür ein geeignetes Korrelationsmaß und testen Sie dieses auf Signifikanz.

<details>

<summary>Lösung</summary>

Um das geeignete Korrelationsmaß zu bestimmen überprüfen wir zunächst die Vorrausetzungen der Pearson-Korrelation:

1.  Skalenniveau: intervallskalierte Daten $\rightarrow$ ok\
2.  Linearität: Zusammenhang muss linear sein $\rightarrow$ Grafische überprüfung (Scatterplot)


```r
# Scatterplot
plot(fb23$nerd, fb23$prok, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-19-1.png)<!-- -->

Es ist kein klarer linearer Zusammenhang zwischen `nerd` und `prok` zu erkennen.
Gleichzeitig ist keine andere Art des Zusammenhangs (polynomial, exponentiell etc.) offensichtlich. Daher gehen wir für diese Aufgabe, um im Rahmen des Erstsemester Statistik Praktikums zu bleiben, davon aus dass die Vorraussetzung der Linearität erfüllt ist.  

3.  Normalverteilung $\rightarrow$ QQ-Plot, Histogramm oder Shapiro-Wilk Test


```r
#Car-Paket laden
library(car)
```


```r
#QQ-Plot
qqPlot(fb23$nerd)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-21-1.png)<!-- -->

```
## [1] 25 74
```

```r
qqPlot(fb23$prok)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-21-2.png)<!-- -->

```
## [1] 91 19
```

```r
#Histogramm
hist(fb23$nerd, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb23$nerd, na.rm = TRUE), sd = sd(fb23$nerd, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-21-3.png)<!-- -->

```r
hist(fb23$prok, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb23$prok, na.rm = TRUE), sd = sd(fb23$prok, na.rm = TRUE)), col = "#00618F", add = TRUE)
```

![](/lehre/statistik-i/korrelation-loesungen_files/figure-html/unnamed-chunk-21-4.png)<!-- -->

```r
#Shapiro-Wilk Test
shapiro.test(fb23$nerd) #nicht signifikant
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb23$nerd
## W = 0.99184, p-value = 0.4097
```

```r
shapiro.test(fb23$prok) #knapp signifikant
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb23$prok
## W = 0.98435, p-value = 0.04279
```

Auf Basis der zwei graphischen und dem inferenzstatistischen Verfahren kommen wir zum Schluss das beide Variablen normalverteilt vorliegen, auch wenn der Shapiro-Wilk Test für `prok` signifikant ausfällt. 
Hier lässt sich auch mit dem *zentralen Grenzwertsatz* argumentieren. Als Faustregel gilt hiernach $n > 30 \rightarrow$ normalverteilt.

Somit kommen wir zum Schluss das die Pearson-Korrelation hier das richtige Korrelationsmaß ist.
Falls Sie für ihre Berechnung jedoch die Normalverteilungsannahme verworfen haben und mit Spearman gerechnet haben ist dies auch ok.


```r
cor.test(fb23$nerd, fb23$prok,
         alternative = "two.sided",
         method = "pearson",
         use = "pairwise")
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  fb23$nerd and fb23$prok
## t = 0.19556, df = 177, p-value = 0.8452
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.1322599  0.1610227
## sample estimates:
##        cor 
## 0.01469751
```

```r
cor.test(fb23$nerd, fb23$prok,
                        alternative = "two.sided",
                        method = "spearman",
                        use = "pairwise")
```

```
## Warning in cor.test.default(fb23$nerd, fb23$prok,
## alternative = "two.sided", : Cannot compute exact p-value
## with ties
```

```
## 
## 	Spearman's rank correlation rho
## 
## data:  fb23$nerd and fb23$prok
## S = 907096, p-value = 0.4976
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##        rho 
## 0.05101605
```


```
## Warning in cor.test.default(fb23$nerd, fb23$prok,
## alternative = "two.sided", : Cannot compute exact p-value
## with ties
```

Sowohl die Pearson-Korrelation (p = 0.8451798) als auch Spearman-Rangkorrelation (p = 0.4976397) sind nicht signifikant von 0 verschieden. 

</details>

## Aufgabe 5 Bonus

Im vorherigen Kapitel haben wir die Poweranalyse behandelt. Solche Analysen kann man auch für Korrelationen vornehmen. Frischen Sie gerne Ihren Wissensstand [hier](/lehre/statistik-i/simulation-poweranalyse/) noch einmal auf.
Daher, führen sie mit Hilfe des Pakets `WebPower` eine Sensitivitätsanalyse für den Datensatz `fb23` unter folgenden Parametern durch:

  * Fehler 1. Art ($\alpha = 5\%$)
  * Fehler 2. Art ($\beta = 20\%$)
  * Alternativhypothese ($H_1$: $\rho_1 \neq 0$)
  
<details>

<summary>Lösung</summary>

Bei einer Sensitivitätsanalyse interessiert uns wie stark ein Effekt sein muss damit wir ihn gegeben der Stichprobengröße (n) und $\alpha$-Fehlerniveau mit einer Wahrscheinlichkeit (Power = 1 - $\beta$) finden.
Einfach gesagt, gesucht ist die aufdeckbare Effektstärke.
Außerdem sind Korrelationen ihre eigenen Effektgrößen, daher müssen wir nicht noch etwa Cohens d berechnen.


```r
library(WebPower)
```


```r
wp.correlation(n = nrow(fb23),            
               r = NULL,                  #gesucht
               power = 0.8,               #Power = 1 - Beta
               alternative = "two.sided") #leitet sich aus der H1 ab
```

```
## Power for correlation
## 
##       n         r alpha power
##     179 0.2075271  0.05   0.8
## 
## URL: http://psychstat.org/correlation
```



Gegeben es gibt eine von null verschiedene (signifikante) Pearson-Korrelation muss diese mindestens 0.208 groß sein, damit wir diese mit einer Power von 80%, auf einem $alpha$-Fehlerniveau von 5% in unserem Datensatz, mit n = 179 finden könnten.

</details>


***
