---
title: "Tests für abhängige Stichproben - Lösungen" 
type: post
date: '2022-12-13' 
slug: gruppenvergleiche-abhaengig-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [koehler, buchholz] 
lastmod: '2023-10-18'
featured: no
banner:
  image: "/header/BSc2_test_abh_stpr.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/449195)"
projects: []
expiryDate: 
publishDate: '2023-12-24'
_build:
  list: never
reading_time: false
share: false
output:
  html_document:
    keep_md: true
---

## Vorbereitung

<details><summary>Lösung</summary>



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




Für die Beantwortung der Fragen werden einige Pakete benötigt, die wir bereits durchgeführt haben.


```r
library(psych)
library(car)
library(effsize)
```

</details>


## Aufgabe 1
Unterscheidet sich im Durchschnitt die Angabe von Psychologiestudierenden zu ihrer Prokrastinationstendenz, wenn sie positiv formulierte Items (prok1, prok4, prok6, prok9, prok10) beantworten im Vergleich zu negativ formulierten Items (prok2, prok3, prok5, prok7 und prok8)? 

<details><summary>Lösung</summary>


Die Skala "Prokrastination" soll bei hohen Werten eine höhere Prokrastinationstendenz darstellen. Um zu vergleichen, ob die Zustimmung je nach Itemformulierung (pos. vs. neg.) anders ausfällt, müssen wir die rekodierten Versionen der Variablen nehmen (wurde im Seminar bereits durchgeführt).

Anschließend bilden wir für jede Person ihren Mittelwert auf den positiv formulierten Items sowie ihren Mittelwert auf den negativ formulierten Items.


```r
# Skalenbildung
prokrast_pos <- fb22[, c('prok1', 'prok4',  'prok6',
                         'prok9', 'prok10')]
prokrast_pos$mean <- rowMeans(prokrast_pos,na.rm = T)

prokrast_neg <- fb22[, c('prok2_r', 'prok3_r',
                         'prok5_r', 'prok7_r',
                         'prok8_r')]
prokrast_neg$mean <- rowMeans(prokrast_neg,na.rm = T)
```

**Deskriptivstatistische Beantwortung der Fragestellung: grafisch**

Je ein Histogramm pro Skala, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert

```r
par(mfrow=c(2,1), mar=c(3,2,2,0))
hist(prokrast_pos$mean, xlim=c(0,4), ylim=c(1,60), main="Prokrastinationstendenz positiv formulierte Items", xlab="", ylab="", las=1)
abline(v=mean(prokrast_pos$mean), lty=2, lwd=2)
hist(prokrast_neg$mean, xlim=c(0,4), ylim=c(1,60), main="Prokrastinationstendenz negativ formulierte Items", xlab="", ylab="", las=1)
abline(v=mean(prokrast_neg$mean), lty=2, lwd=2)
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig-loesungen_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```r
par(mfrow=c(1,1))
```

**Deskriptivstatistische Beantwortung der Fragestellung: statistisch**

```r
summary(prokrast_pos$mean)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   1.200   2.200   2.800   2.684   3.200   4.000
```

```r
summary(prokrast_neg$mean)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   1.200   2.000   2.400   2.323   2.600   4.000
```

```r
#alternativ
library(psych)
describe(prokrast_pos$mean)
```

```
##    vars   n mean   sd median trimmed  mad min max range skew kurtosis   se
## X1    1 159 2.68 0.64    2.8    2.68 0.59 1.2   4   2.8 0.09    -0.55 0.05
```

```r
describe(prokrast_neg$mean)
```

```
##    vars   n mean   sd median trimmed  mad min max range skew kurtosis   se
## X1    1 159 2.32 0.52    2.4    2.31 0.59 1.2   4   2.8 0.31     0.14 0.04
```

Mittelwert positiv (_M_ = 2.68, _SD_ = 0.64) ist deskriptiv höher als Mittelwert negativ (_M_ = 2.32, _SD_ = 0.52).

**Voraussetzungen für t-Test für abhängige Stichproben**

1. Die abhängige Variable ist intervallskaliert $\rightarrow$ ok
2. Die Messwerte innerhalb der Paare dürfen sich gegenseitig beeinflussen/voneinander abhängig sein; keine Abhängigkeiten zwischen den Messwertpaaren $\rightarrow$ ok
3. Die Differenzvariable _d_ muss in der Population normalverteilt sein $\rightarrow$ ab $n \ge 30$ gegeben, ansonsten grafische Prüfung oder Hintergrundwissen 

**Voraussetzungsprüfung: Normalverteilung von _d_**

```r
par(mar=c(3,3,3,0)) #ändern der Ränder (margins) des Plot-Fensters
difference <- prokrast_pos$mean-prokrast_neg$mean
hist(difference, 
     breaks = 15,
     xlim=c(-2,2), 
     ylim = c(0,1), 
     main="Verteilung der Differenzen", 
     xlab="Differenzen", ylab="", las=1,freq=F)
curve(dnorm(x, mean=mean(difference), sd=sd(difference)), col="blue", lwd=2, add=T)
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig-loesungen_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

```r
par(mfrow=c(1,1)) #Zurücksetzen auf default
qqnorm(difference,las=1)
qqline(difference, col="blue")
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig-loesungen_files/figure-html/unnamed-chunk-8-2.png)<!-- -->

$\Rightarrow$ Differenzen sehen einigermaßen normalverteilt aus

**Hypothesen**

* Art des Effekts: Unterschiedshypothese  
* Richtung des Effekts: Ungerichtet $\rightarrow$ ungerichtete Hypothese
* Größe des Effekts: Unspezifisch  


Hypothesenpaar (inhaltlich):  
H0: Studierende geben in gleichem Ausmaß ihre Prokrastinationstendenz an, d.h. die Richtung der Itemformulierung ist irrelevant.

H1: Studierende geben nicht im gleichen Ausmaß ihre Prokrastinationstendenz an, d.h. die Richtung der Itemformulierung hat einen Einfluss.

Hypothesenpaar (statistisch):  

* $H_0$: $\mu_\text{positiv} = \mu_\text{negativ}$  bzw. $\mu_{d} = 0$
* $H_1$: $\mu_\text{positiv} \ne   \mu_\text{negativ}$  bzw. $\mu_{d} \ne 0$

**Spezifikation des Signifikanzniveaus**

$\alpha = .05$

**Durchführung des _t_-Tests für abhängige Stichproben in R**


```r
t.test(x = prokrast_pos$mean, y  = prokrast_neg$mean, 
       paired = T,                       # Stichproben sind abhängig
       alternative = "two.sided",        # ungerichtete Hypothese 
       conf.level = .95)                 # alpha = .05
```

```
## 
## 	Paired t-test
## 
## data:  prokrast_pos$mean and prokrast_neg$mean
## t = 8.7105, df = 158, p-value = 3.85e-15
## alternative hypothesis: true mean difference is not equal to 0
## 95 percent confidence interval:
##  0.2789052 0.4424784
## sample estimates:
## mean difference 
##       0.3606918
```



* Zur Erinnerung: _df_ bei _t_-test mit abhängigen Stichproben: _n_ - 1 
* _t_(0.05;158) = 8.71, _p_ < .001 $\rightarrow$ signifikant, H0 wird verworfen.

**Schätzung des standardisierten Populationseffekts**


```r
mean_d <- mean(difference)
sd.d.est <- sd(difference) #die geschätzte SD der Differenzen
d_prok <- mean_d/sd.d.est
d_prok
```

```
## [1] 0.6907852
```

$\Rightarrow$ Der standardisierte Populationseffekt beträgt _d2''_ = 0.69 und ist laut Konventionen nach Cohen (1988) groß. 

**Formales Berichten des Ergebnisses**

Es wurde untersucht, ob Psychologiestudierende in Anbhängigkeit der Itemformulierung in unterschiedlichem Maße angeben, dass sie prokrastinieren. Es findet sich deskriptiv ein Unterschied: Bei den positiv formulierten Items liegt der durchschnittliche Prokrastinationswert bei 2.68 (_SD_ = 0.64), während er bei negativ formulierten Items bei 2.32 (_SD_ = 0.52) liegt. 

Zur Beantwortung der Fragestellung wurde ein ungerichteter _t_-Test für abhängige Stichproben durchgeführt. Der Unterschied ist signifikant (_t_(158) = 8.71, _p_ < .001), somit wird die Nullhypothese verworfen. Die Itemformulierung scheint einen Einfluss auf die angegebene Prokrastinationstendenz zu haben. 

Dieser Einfluss ist nach dem standardisierten Populationseffekt von _d''_ = 0.69 groß.

Anmerkung: Hierbei ist zu bedenken, dass es neben der Richtung der Itemformulierung  natürlich noch andere (bei unserer Erhebung nicht kontrollierte) Eigenheiten der Items geben kann, die zu Unterschieden führen (z. B. wie extrem bzw. schwierig die Items formuliert sind). 

</details>


## Aufgabe 2
Ein Therapeut behauptet, dass eine von ihm entwickelte Meditation die Zufriedenheit von Menschen positiv beeinflusst. Er möchte dies mit wissenschaftlichen Methoden zeigen und misst die Zufriedenheit vor und nach der Meditation. Es ergeben sich folgende Werte für 18 Personen:   


| Vpn| Vorher| Nachher|
|---:|------:|-------:|
|   1|    4.1|     4.0|
|   2|    5.9|     7.2|
|   3|    4.4|     8.1|
|   4|    7.8|     6.2|
|   5|    2.4|     4.1|
|   6|    8.8|     7.7|
|   7|    3.1|     5.5|
|   8|    5.0|     6.9|
|   9|    6.0|     8.2|
|  10|    4.5|     5.4|
|  11|    5.8|     9.1|
|  12|    4.4|     5.6|
|  13|    3.2|     6.8|
|  14|    7.3|     7.5|
|  15|    7.4|     6.4|
|  16|    6.3|     4.9|
|  17|    4.3|     6.1|
|  18|    7.1|     7.9|

Wirkt die Meditation positiv auf die Zufriedenheit?

<details><summary>Lösung</summary>
**Datensatz generieren**

```r
dataMeditation <- data.frame(Vpn = 1:18, 
                             Vorher = c(4.1,5.9,4.4,7.8,2.4,8.8,3.1,5.0,6.0,4.5,5.8,4.4,3.2,7.3,7.4,6.3,4.3,7.1), 
                             Nachher = c(4.0,7.2,8.1,6.2,4.1,7.7,5.5,6.9,8.2,5.4,9.1,5.6,6.8,7.5,6.4,4.9,6.1,7.9))
```

**Deskriptivstatistische Beantwortung der Fragestellung: grafisch**

Histogramme (weil Intervallskalenqualität):
Je ein Histogramm pro Gruppe, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert

```r
par(mfrow=c(2,1), mar=c(3,2,2,0))
hist(dataMeditation[, "Vorher"], xlim=c(0,10), ylim=c(1,6), main="Zufriedenheit vor der Meditation", xlab="", ylab="", las=1)
abline(v=mean(dataMeditation[, "Vorher"]), lty=2, lwd=2)
hist(dataMeditation[, "Nachher"], xlim=c(0,10), ylim=c(1,6), main="Zufriedenheit nach der Meditation", xlab="", ylab="", las=1)
abline(v=mean(dataMeditation[, "Nachher"]), lty=2, lwd=2)
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig-loesungen_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

```r
par(mfrow=c(1,1))
```

**Deskriptivstatistische Beantwortung der Fragestellung: statistisch**

```r
summary(dataMeditation[, "Vorher"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   2.400   4.325   5.400   5.433   6.900   8.800
```

```r
summary(dataMeditation[, "Nachher"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   4.000   5.525   6.600   6.533   7.650   9.100
```

```r
#alternativ
library(psych)
describe(dataMeditation[, "Vorher"])
```

```
##    vars  n mean   sd median trimmed  mad min max range skew kurtosis   se
## X1    1 18 5.43 1.79    5.4    5.41 1.78 2.4 8.8   6.4 0.12    -1.14 0.42
```

```r
describe(dataMeditation[, "Nachher"])
```

```
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 18 6.53 1.44    6.6    6.53 1.63   4 9.1   5.1 -0.14    -1.05 0.34
```

Mittelwert vorher (_M_ = 5.43, _SD_ = 1.79) ist deskriptiv niedriger als Mittelwert nachher (_M_ = 6.53, _SD_ = 1.44).

**Voraussetzungen für t-Test für abhängige Stichproben**

1. Die abhängige Variable ist intervallskaliert $\rightarrow$ ok
2. Die Messwerte innerhalb der Paare dürfen sich gegenseitig beeinflussen/voneinander abhängig sein; keine Abhängigkeiten zwischen den Messwertpaaren $\rightarrow$ ok
3. Die Differenzvariable _d_ muss in der Population normalverteilt sein $\rightarrow$ ab $n \ge 30$ gegeben, ansonsten grafische Prüfung oder Hintergrundwissen 

**Voraussetzungsprüfung: Normalverteilung von _d_**

```r
par(mar=c(3,3,3,0)) #ändern der Ränder (margins) des Plot-Fensters
difference2 <- dataMeditation[, "Vorher"]-dataMeditation[, "Nachher"]
hist(difference2, xlim=c(-6,4), main="Verteilung der Differenzen", xlab="Differenzen", ylab="", las=1,freq=F)
curve(dnorm(x, mean=mean(difference2), sd=sd(difference2)), col="blue", lwd=2, add=T)
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig-loesungen_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

```r
par(mfrow=c(1,1)) #Zurücksetzen auf default
qqnorm(difference2,las=1)
qqline(difference2, col="blue")
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig-loesungen_files/figure-html/unnamed-chunk-17-2.png)<!-- -->

$\Rightarrow$ Differenzen sehen nicht normalverteilt aus

$\Rightarrow$ Durchführung des Wilcoxon-Tests für abhängige Stichproben, da die Voraussetzungen hierfür erfüllt sind.

**Hypothesen**

* Art des Effekts: Unterschiedshypothese  
* Richtung des Effekts: Gerichtet $\rightarrow$ gerichtete Hypothesen (Der Wissenschaftler erwartet eine positive Wirkung der Meditation auf die Zufriedenheit.) 
* Größe des Effekts: Unspezifisch  


Hypothesenpaar (inhaltlich):  
H0: Die Meditation wirkt sich nicht oder negativ auf die Zufriedenheit aus.

H1: Die Meditation wirkt sich positiv auf die Zufriedenheit aus.

Hypothesenpaar (statistisch):  

* $H_0$: $\eta_\text{vorher} \ge \eta_\text{nachher}$  bzw. $\mu_{d} \ge 0$
* $H_1$: $\eta_\text{vorher} <   \eta_\text{nachher}$  bzw. $\mu_{d} < 0$

**Spezifikation des Signifikanzniveaus**

$\alpha = .05$

**Inferenzstatistik: Wilcoxon-Test für abhängige Stichproben**

```r
wilcox.test(x = dataMeditation[, "Vorher"], y  = dataMeditation[, "Nachher"], # die beiden abhängigen Gruppen
       paired = T,                       # Stichproben sind abhängig
       alternative = "less",             # gerichtete Hypothese -> einseitige Testung
       conf.level = .95)                 # alpha = .05
```

```
## 
## 	Wilcoxon signed rank exact test
## 
## data:  dataMeditation[, "Vorher"] and dataMeditation[, "Nachher"]
## V = 31, p-value = 0.007965
## alternative hypothesis: true location shift is less than 0
```



$\Rightarrow$ _V_ = 31, _p_ < .01 $\rightarrow$ H0 wird verworfen.


**Formales Berichten des Ergebnisses**

Es wurde in einer Wiederholungsmessung untersucht, ob sich Meditation auf Zufriedenheit auswirkt. Zunächst findet sich deskriptiv ein Unterschied: Vor der Meditation liegt der durchschnittliche Zufriedenheitswert bei 5.43 (_SD_ = 1.79), während er nach der Meditation bei 6.53 (_SD_ = 1.44) liegt. 

Da die Differenzen nicht normalverteilt waren, wurde ein gerichteter Wilcoxon-Test für abhängige Stichproben durchgeführt. Der Unterschied wurde bei einem Signifikanzniveau von alpha = .05 signifikant (_V_ = 31, _p_ < .01). Somit wird die Nullhypothese verworfen. Die Meditation hat einen positiven Einfluss auf die Zufriedenheit.


</details>
