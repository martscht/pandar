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
lastmod: '2025-04-07'
featured: no
banner:
  image: "/header/storch_with_baby.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/855019)"
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
    url: /lehre/statistik-i/korrelation
  - icon_pack: fas
    icon: pen-to-square
    name: Übungen
    url: /lehre/statistik-i/korrelation-uebungen

output:
  html_document:
    keep_md: true
---



## Vorbereitung



> Laden Sie zunächst den Datensatz `fb24` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb24.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/korrelation/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


``` r
dim(fb24)
```

```
## [1] 192  55
```

``` r
names(fb24)
```

```
##  [1] "mdbf1"       "mdbf2"       "mdbf3"       "mdbf4"       "mdbf5"       "mdbf6"       "mdbf7"      
##  [8] "mdbf8"       "mdbf9"       "mdbf10"      "mdbf11"      "mdbf12"      "time_pre"    "lz"         
## [15] "extra"       "vertr"       "gewis"       "neuro"       "offen"       "prok"        "nerd"       
## [22] "uni1"        "uni2"        "uni3"        "uni4"        "grund"       "fach"        "ziel"       
## [29] "wissen"      "therap"      "lerntyp"     "hand"        "job"         "ort"         "ort12"      
## [36] "wohnen"      "attent"      "gs_post"     "wm_post"     "ru_post"     "time_post"   "attent_post"
## [43] "hand_factor" "fach_klin"   "unipartys"   "mdbf4_r"     "mdbf11_r"    "mdbf3_r"     "mdbf9_r"    
## [50] "mdbf5_r"     "mdbf7_r"     "wm_pre"      "gs_pre"      "ru_pre"      "ru_pre_zstd"
```

Der Datensatz besteht aus 192 Zeilen (Beobachtungen) und 55 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.


***

## Aufgabe 1

Das Paket `psych` enthält vielerlei Funktionen, die für die Analyse von Datensätzen aus psychologischer Forschung praktisch sind. Eine von ihnen (`describe()`) erlaubt es, gleichzeitig verschiedene Deskriptivstatistiken für Variablen zu erstellen.

  * Installieren (falls noch nicht geschehen) und laden Sie das Paket `psych`.
  * Nutzen Sie den neugewonnen Befehl `describe()`, um sich gleichzeitig die verschiedenen Deskriptivstatistiken für Lebenszufriedenheit (`lz`) ausgeben zu lassen.

<details>

<summary>Lösung</summary>


``` r
# Paket installieren
install.packages('psych')
```


``` r
# Paket laden
library(psych)
```

</details>

-   Nutzen Sie den neugewonnen Befehl `describe()`, um sich gleichzeitig die verschiedenen Deskriptivstatistiken für Lebenszufriedenheit (`lz`) ausgeben zu lassen.

<details>

<summary>Lösung</summary>


``` r
describe(fb24$lz)
```

```
##    vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 191 4.92 1.15      5    4.98 1.19   2   7     5 -0.43    -0.41 0.08
```

</details>

  * Die Funktion `describeBy()` ermöglicht außerdem Deskriptivstatistiken in Abhängigkeit einer gruppierenden Variable auszugeben. Machen Sie sich diesen Befehl zunutze, um sich die Lebenszufriedenheit (`lz`) abhängig von der derzeitigen Wohnsituation (`wohnen`) anzeigen zu lassen.

<details>

<summary>Lösung</summary>


``` r
describeBy(fb24$lz, group = fb24$wohnen)
```

```
## 
##  Descriptive statistics by group 
## group: WG
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 62 5.03 1.09      5    5.06 1.19 2.4   7   4.6 -0.21    -0.55 0.14
## ------------------------------------------------------------------------------------- 
## group: bei Eltern
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 60 5.06 1.14    5.3    5.15 1.19   2   7     5 -0.67    -0.28 0.15
## ------------------------------------------------------------------------------------- 
## group: alleine
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 45 4.48 1.27    4.6    4.51 1.48   2 6.8   4.8 -0.17    -0.95 0.19
## ------------------------------------------------------------------------------------- 
## group: sonstiges
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis  se
## X1    1 22 5.14 0.95      5    5.16 0.89 2.8 6.8     4 -0.23    -0.27 0.2
```

</details>

-   `describe()` kann auch genutzt werden, um gleichzeitig Deskriptivstatistiken für verschiedene Variablen zu berechnen. Nutzen Sie diese Funktionalität, um sich gleichzeitg die univariaten Deskriptivstatistiken für die fünf Persönlichkeitsdimensionen ausgeben zu lassen.

<details>

<summary>Lösung</summary>


``` r
describe(fb24[,c("extra","vertr","gewis","neuro","offen")])
```

```
##       vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## extra    1 191 3.28 1.02    3.5    3.31 1.48 1.0   5   4.0 -0.28    -0.79 0.07
## vertr    2 191 3.48 0.82    3.5    3.51 0.74 1.0   5   4.0 -0.38     0.11 0.06
## gewis    3 191 3.49 0.89    3.5    3.50 0.74 1.5   5   3.5 -0.13    -0.80 0.06
## neuro    4 191 3.41 0.95    3.5    3.43 0.74 1.0   5   4.0 -0.25    -0.53 0.07
## offen    5 191 3.81 0.98    4.0    3.91 0.74 1.0   5   4.0 -0.80    -0.07 0.07
```

</details>



## Aufgabe 2

In der Befragung am Anfang des Semesters wurde gefragt, ob Sie neben der Uni einen Nebenjob (`job`) ausüben und mit welcher Hand sie primär schreiben (`hand`). Erstellen Sie für diese beiden Variablen eine Kreuztabelle mit Randsummen.

  * Stellen Sie zunächst sicher, dass die Variablen als Faktoren vorliegen und die Kategorien beider Variablen korrekt bezeichnet sind. 
  
<details>

<summary>Lösung</summary>

Zunächst können wir überprüfen, ob die Variablen als Faktor vorliegen.


``` r
#Labels
is.factor(fb24$job)
```

```
## [1] TRUE
```

``` r
is.factor(fb24$hand)
```

```
## [1] FALSE
```

Wenn Sie die Datensatzvorbereitung aus dem Skript kopiert haben, sollte die Variable `job` bereits ein Faktor sein.
Die Variable `hand` jedoch nicht. Dies müssen wir ändern.


``` r
fb24$hand <- factor(fb24$hand,
                    levels = c(1, 2),
                    labels = c("links", "rechts"))
```

Für den Fall, dass die Variable `job` noch nicht als Faktor im Datensatz vorliegt, kann folgender Code durchgeführt werden. Achten Sie aber drauf, dass dieser Befehl auf eine Variable nicht angewendet werden sollte, wenn diese bereits ein Faktor ist. Ansonsten kommt es zu dem Fehler, dass die Variable keine Informationen mehr enthält.


``` r
fb24$job <- factor(fb24$job, levels = c(1, 2),
  labels = c('nein', 'ja'))
```

Die Variablen sehen dann folgendermaßen aus.


``` r
str(fb24$job)
```

```
##  Factor w/ 2 levels "nein","ja": 2 1 2 1 1 1 1 1 2 2 ...
```

``` r
str(fb24$hand)
```

```
##  Factor w/ 2 levels "links","rechts": 1 2 2 2 2 2 2 2 1 2 ...
```

</details>

-   Wie viele Personen sind Linkshänder und haben keinen Nebenjob?

<details>

<summary>Lösung</summary>


``` r
# Kreuztabelle absolut
tab <- table(fb24$hand, fb24$job)
addmargins(tab)
```

```
##         
##          nein  ja Sum
##   links    13  10  23
##   rechts  108  56 164
##   Sum     121  66 187
```

13 Personen schreiben primär mit der linken Hand und haben keinen Nebenjob.

</details>

-   Was ist der relative Anteil aller Teilnehmenden, die einem Nebenjob nachgehen?

<details>

<summary>Lösung</summary>


``` r
# Relative Häufigkeiten, mit Randsummen
addmargins(prop.table(tab))
```

```
##         
##                nein         ja        Sum
##   links  0.06951872 0.05347594 0.12299465
##   rechts 0.57754011 0.29946524 0.87700535
##   Sum    0.64705882 0.35294118 1.00000000
```

35.29% aller Teilnehmenden gehen einer Nebentätigkeit nach.

</details>

-   Berechnen Sie nun mit Hilfe des `psych`-Pakets die Korrelationskoeffizienten Phi ($\phi$) und Yules Q für das oben genannte Beispiel.

<details>

<summary>Lösung</summary>


``` r
phi(tab, digits = 3)
```

```
## [1] -0.064
```

``` r
Yule(tab) |> round(digits = 3) #da die Yule()-Funktion nicht direkt runden kann geben wir das Ergebnis an die round()-Funktion weiter
```

```
## [1] -0.195
```

Beide Koeffizienten sprechen für eine wenn überhaupt schwache Korrelation.

</details>


## Aufgabe 3

Welche der fünf Persönlichkeitsdimensionen Extraversion (`extra`), Verträglichkeit (`vertr`), Gewissenhaftigkeit (`gewis`), Neurotizismus (`neuro`) und Offenheit für neue Erfahrungen (`offen`) ist am stärksten mit der Lebenszufriedenheit korreliert (`lz`)?

  * Überprüfen Sie die Voraussetzungen für die Pearson-Korrelation.


<details>

<summary>Lösung</summary>

**Voraussetzungen Pearson-Korrelation:**

1.  Skalenniveau: intervallskalierte Daten $\rightarrow$ ok\
2.  Linearität: Zusammenhang muss linear sein $\rightarrow$ Grafische überprüfung (Scatterplot)


``` r
# Scatterplot
plot(fb24$extra, fb24$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/korrelation-loesungen_files/unnamed-chunk-15-1.png)<!-- -->

``` r
plot(fb24$vertr, fb24$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/korrelation-loesungen_files/unnamed-chunk-15-2.png)<!-- -->

``` r
plot(fb24$gewis, fb24$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/korrelation-loesungen_files/unnamed-chunk-15-3.png)<!-- -->

``` r
plot(fb24$neuro, fb24$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/korrelation-loesungen_files/unnamed-chunk-15-4.png)<!-- -->

``` r
plot(fb24$offen, fb24$lz, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/korrelation-loesungen_files/unnamed-chunk-15-5.png)<!-- -->

Die fünf Scatterplots lassen allesamt auf einen linearen Zusammenhang zwischen den Variablen schließen.

3.  Normalverteilung $\rightarrow$ QQ-Plot, Histogramm oder Shapiro-Wilk-Test


``` r
#QQ
qqnorm(fb24$extra)
qqline(fb24$extra)
```

![](/korrelation-loesungen_files/unnamed-chunk-16-1.png)<!-- -->

``` r
qqnorm(fb24$vertr)
qqline(fb24$vertr)
```

![](/korrelation-loesungen_files/unnamed-chunk-16-2.png)<!-- -->

``` r
qqnorm(fb24$gewis)
qqline(fb24$gewis)
```

![](/korrelation-loesungen_files/unnamed-chunk-16-3.png)<!-- -->

``` r
qqnorm(fb24$neuro)
qqline(fb24$neuro)
```

![](/korrelation-loesungen_files/unnamed-chunk-16-4.png)<!-- -->

``` r
qqnorm(fb24$offen)
qqline(fb24$offen)
```

![](/korrelation-loesungen_files/unnamed-chunk-16-5.png)<!-- -->

``` r
qqnorm(fb24$lz)
qqline(fb24$lz)
```

![](/korrelation-loesungen_files/unnamed-chunk-16-6.png)<!-- -->

``` r
#Histogramm
hist(fb24$extra, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb24$extra, na.rm = TRUE), sd = sd(fb24$extra, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/korrelation-loesungen_files/unnamed-chunk-16-7.png)<!-- -->

``` r
hist(fb24$vertr, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb24$vertr, na.rm = TRUE), sd = sd(fb24$vertr, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/korrelation-loesungen_files/unnamed-chunk-16-8.png)<!-- -->

``` r
hist(fb24$gewis, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb24$gewis, na.rm = TRUE), sd = sd(fb24$gewis, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/korrelation-loesungen_files/unnamed-chunk-16-9.png)<!-- -->

``` r
hist(fb24$neuro, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb24$neuro, na.rm = TRUE), sd = sd(fb24$neuro, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/korrelation-loesungen_files/unnamed-chunk-16-10.png)<!-- -->

``` r
hist(fb24$offen, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb24$offen, na.rm = TRUE), sd = sd(fb24$offen, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/korrelation-loesungen_files/unnamed-chunk-16-11.png)<!-- -->

``` r
hist(fb24$lz, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb24$lz, na.rm = TRUE), sd = sd(fb24$lz, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/korrelation-loesungen_files/unnamed-chunk-16-12.png)<!-- -->

``` r
#Shapiro
shapiro.test(fb24$extra)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb24$extra
## W = 0.9514, p-value = 4.187e-06
```

``` r
shapiro.test(fb24$vertr)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb24$vertr
## W = 0.95457, p-value = 8.51e-06
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

``` r
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
shapiro.test(fb24$offen)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb24$offen
## W = 0.90621, p-value = 1.225e-09
```

``` r
shapiro.test(fb24$lz)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb24$lz
## W = 0.97398, p-value = 0.001257
```

$p < \alpha$ $\rightarrow$ H1: Normalverteilung kann für alle Variablen nicht angenommen werden. Somit ist diese Voraussetzung für alle Variablen verletzt. Daher sollten wir fortlaufend die Rangkorrelation nach Spearman nutzen.

</details>

-   Erstellen Sie für diese Frage eine Korrelationsmatrix, die alle Korrelationen enthält. Verwenden Sie die Funktion `round()` (unter Betrachtung der Hilfe), um die Werte auf zwei Nachkommastellen zu runden und die Tabelle dadurch übersichtlicher darzustellen.

<details>
<summary>Lösung</summary>


``` r
# Korrelationstabelle erstellen und runden
cor_mat <- round(cor(fb24[,c('lz', 'extra', 'vertr', 'gewis', 'neuro', 'offen')],
                     use = 'pairwise',
                     method = 'spearman'),3)
cor_mat
```

```
##           lz  extra  vertr  gewis  neuro  offen
## lz     1.000  0.408  0.168  0.270 -0.412  0.080
## extra  0.408  1.000  0.147  0.067 -0.337  0.047
## vertr  0.168  0.147  1.000 -0.012 -0.099  0.086
## gewis  0.270  0.067 -0.012  1.000 -0.115 -0.083
## neuro -0.412 -0.337 -0.099 -0.115  1.000  0.028
## offen  0.080  0.047  0.086 -0.083  0.028  1.000
```


</details>

-   Wie würden Sie das Ausmaß der betragsmäßig größten Korrelation mit der Lebenszufriedenheit nach den Richtlinien von Cohen (1988) einschätzen?

<details>

<summary>Lösung</summary>

Die betragsmäßig größte Korrelation mit der Lebenszufriedenheit hat der Neurotizismus. Nach den Richtlinien ist dieser mit 0.27 einem negativen mittleren Effekt, der ungefähr 0.3 beträgt, zuzuordnen.

</details>

-   Ist der Korrelationskoeffizient von Lebenszufriedenheit und Neurotizismus statistisch signifikant?

<details>

<summary>Lösung</summary>


``` r
cor.test(fb24$lz, fb24$neuro, 
         alternative = "two.sided", 
         method = "spearman",       
         use = "pairwise") 
```

```
## Warning in cor.test.default(fb24$lz, fb24$neuro, alternative = "two.sided", : Kann exakten p-Wert bei Bindungen
## nicht berechnen
```

```
## 
## 	Spearman's rank correlation rho
## 
## data:  fb24$lz and fb24$neuro
## S = 1640303, p-value = 3.038e-09
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##        rho 
## -0.4124959
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


``` r
# Scatterplot
plot(fb24$nerd, fb24$prok, 
  xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/korrelation-loesungen_files/unnamed-chunk-19-1.png)<!-- -->

Es ist kein klarer linearer Zusammenhang zwischen `nerd` und `prok` zu erkennen.
Gleichzeitig ist keine andere Art des Zusammenhangs (polynomial, exponentiell etc.) offensichtlich. Daher gehen wir für diese Aufgabe, um im Rahmen des Erstsemester Statistik Praktikums zu bleiben, davon aus dass die Vorraussetzung der Linearität erfüllt ist.  

3.  Normalverteilung $\rightarrow$ QQ-Plot, Histogramm oder Shapiro-Wilk Test


``` r
#Car-Paket laden
library(car)
```


``` r
#QQ-Plot
qqPlot(fb24$nerd)
```

![](/korrelation-loesungen_files/unnamed-chunk-21-1.png)<!-- -->

```
## [1] 148 192
```

``` r
qqPlot(fb24$prok)
```

![](/korrelation-loesungen_files/unnamed-chunk-21-2.png)<!-- -->

```
## [1] 109 169
```

``` r
#Histogramm
hist(fb24$nerd, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb24$nerd, na.rm = TRUE), sd = sd(fb24$nerd, na.rm = TRUE)), col = "#00618F", add = TRUE)  
```

![](/korrelation-loesungen_files/unnamed-chunk-21-3.png)<!-- -->

``` r
hist(fb24$prok, prob = TRUE, ylim = c(0, 1))
curve(dnorm(x, mean = mean(fb24$prok, na.rm = TRUE), sd = sd(fb24$prok, na.rm = TRUE)), col = "#00618F", add = TRUE)
```

![](/korrelation-loesungen_files/unnamed-chunk-21-4.png)<!-- -->

``` r
#Shapiro-Wilk Test
shapiro.test(fb24$nerd) #signifikant
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb24$nerd
## W = 0.98363, p-value = 0.02579
```

``` r
shapiro.test(fb24$prok) #signifikant
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb24$prok
## W = 0.97531, p-value = 0.001926
```

Auf Basis der zwei graphischen und dem inferenzstatistischen Verfahren kommen wir zum Schluss das beide Variablen nicht normalverteilt vorliegen.

Somit kommen wir zum Schluss das die Spearman-Rangkorrelation hier das richtige Korrelationsmaß ist.



``` r
cor.test(fb24$nerd, fb24$prok,
                        alternative = "two.sided",
                        method = "spearman",
                        use = "pairwise")
```

```
## Warning in cor.test.default(fb24$nerd, fb24$prok, alternative = "two.sided", : Kann exakten p-Wert bei Bindungen
## nicht berechnen
```

```
## 
## 	Spearman's rank correlation rho
## 
## data:  fb24$nerd and fb24$prok
## S = 1118997, p-value = 0.7724
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##        rho 
## 0.02111588
```


```
## Warning in cor.test.default(fb24$nerd, fb24$prok, alternative = "two.sided", : Kann exakten p-Wert bei Bindungen
## nicht berechnen
```

Die Spearman-Rangkorrelation (p = 0.7724483) ist nicht signifikant von 0 verschieden. 

</details>

## Aufgabe 5 Bonus

Im vorherigen Kapitel haben wir die Poweranalyse behandelt. Solche Analysen kann man auch für Korrelationen vornehmen. Frischen Sie gerne Ihren Wissensstand [hier](/lehre/statistik-i/simulation-poweranalyse/) noch einmal auf.
Daher, führen sie mit Hilfe des Pakets `WebPower` eine Sensitivitätsanalyse für den Datensatz `fb24` unter folgenden Parametern durch:

  * Fehler 1. Art ($\alpha = 5\%$)
  * Fehler 2. Art ($\beta = 20\%$)
  * Alternativhypothese ($H_1$: $\rho_1 \neq 0$)
  
<details>

<summary>Lösung</summary>

Bei einer Sensitivitätsanalyse interessiert uns wie stark ein Effekt sein muss damit wir ihn gegeben der Stichprobengröße (n) und $\alpha$-Fehlerniveau mit einer Wahrscheinlichkeit (Power = 1 - $\beta$) finden.
Einfach gesagt, gesucht ist die aufdeckbare Effektstärke.
Außerdem sind Korrelationen ihre eigenen Effektgrößen, daher müssen wir nicht noch etwa Cohens d berechnen.


``` r
library(WebPower)
```


``` r
wp.correlation(n = nrow(fb24),            
               r = NULL,                  #gesucht
               power = 0.8,               #Power = 1 - Beta
               alternative = "two.sided") #leitet sich aus der H1 ab
```

```
## Power for correlation
## 
##       n         r alpha power
##     192 0.2005028  0.05   0.8
## 
## URL: http://psychstat.org/correlation
```



Gegeben es gibt eine von null verschiedene (signifikante) Pearson-Korrelation muss diese mindestens 0.201 groß sein, damit wir diese mit einer Power von 80%, auf einem $\alpha$-Fehlerniveau von 5% in unserem Datensatz, mit n = 192 finden könnten.

</details>


***
