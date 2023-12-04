---
title: "Tests für abhängige Stichproben - Lösungen" 
type: post
date: '2022-12-13' 
slug: gruppenvergleiche-abhaengig-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [walter, nehler] 
lastmod: '2023-12-02'
featured: no
banner:
  image: "/header/consent_checkbox.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/449195)"
projects: []
expiryDate: 
publishDate: 
_build:
  list: never
reading_time: false
share: false
output:
  html_document:
    keep_md: true
---



## Vorbereitung

> Laden Sie zunächst den Datensatz `fb23` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb23.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/gruppenvergleiche-abhaengig/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.





## Aufgabe 1
Zu Beginn und nach der ersten Pratikumssitzung wurden Sie als Studierende nach Ihrem Befinden zum Zeitpunkt der Umfrage befragt. Hierbei wurde unteranderem erhoben, wie ruhig (hohe Werte) oder unruhig (niedrige Werte) Sie sich zu beiden Zeitpunkten gefühlt haben (Variable `ru_pre` und `ru_post`). Nun wollen Sie untersuchen, ob die Teilnahme am Statistikpraktikum einen Einfluss auf das Befinden der Studierenden hat. Sie gehen davon aus, dass sich der Ruhestudium vor und nach dem Praktikum unterscheidet ohne eine Richtung anzunehmen.



* Stellen Sie zunächst das Hypothesenpaar der Testung inhaltich und auch mathematisch auf. Spezifizieren Sie das Signifikanzniveau. Dieses soll so gewählt werden, dass wir die Nullhypothese in 1 von 20 Fällen fälschlicherweise verwerfen würden.

<details><summary>Lösung</summary>

**Hypothesen**

* Art des Effekts: Unterschiedshypothese  
* Richtung des Effekts: ungerichtete Hypothese
* Größe des Effekts: Unspezifisch  


Hypothesenpaar (inhaltlich):  
H0: Die Teilnahme am Statistikpraktikum wirkt sich nicht auf das Ruheempfinden der Studierenden aus.
H1: Die Teilnahme am Statistikpraktikum wirkt sich auf das Ruheempfinden der Studierenden aus.

Hypothesenpaar (statistisch):  

* $H_0$: $\eta_\text{nachher} = \eta_\text{vorher}$  bzw. $\mu_{d} = 0$
* $H_1$: $\eta_\text{nachher} \neq  \eta_\text{vorher}$  bzw. $\mu_{d} \neq 0$

**Spezifikation des Signifikanzniveaus**

$\alpha = .05$

</details>

* Bestimmen Sie die deskriptivstatistischen Maße und bewerten Sie diese im Hinblick auf die Hypothesen. Beachten Sie, dass bei der späteren inferenzstatistischen Testung nur Personen eingehen, die zu beiden Messzeitpunkten Angaben gemacht haben. Schließen Sie also Personen mit fehlenden Werten auf einer (oder beiden) Variablen vor der Berechnung der deskriptivstatistischen Maße aus.

<details><summary>Lösung</summary>

**Bevor es weiter geht:**

Ein Blick in den fb23-Datensatz verrät, dass auf dem Skalenwert ru_post, der Messung des Ruheempfindes zum zweiten Zeitpunkt, Werte fehlen. Diese fehlenden Werte werden als *NA* abgebildet.

Um verfälschte deskriptiv- und inferenzstatistische Ergebnisse zu vermeiden, werden alle Personen aus der weiteren Berechung ausgeschlossen, die einen fehlenden Wert auf `ru_post` (oder `ru_pre`) aufweisen. Damit wir den Datensatz `fb23` aber nicht generell verändern, legen wir estmal einen neuen Datesatz an, der nur die beiden interessierenden Variablen enthält.


```r
ruhe <- fb23[, c("ru_pre", "ru_post")] #Erstellung eines neuen Datensatzes, welcher nur die für uns wichtigen Variablen enthält

ruhe <- na.omit(ruhe) #Entfernt alle Beobachtungen, die auf einer der beiden Variable einen fehlenden Wert haben

str(ruhe) #Ablesen der finalen Stichprobengröße
```

```
## 'data.frame':	147 obs. of  2 variables:
##  $ ru_pre : num  2 1 2.75 2.75 2.25 1.75 3.25 2.75 2.25 3.25 ...
##  $ ru_post: num  2.25 1.5 3.75 3.5 3 3.5 2.75 2.75 2.75 3.25 ...
##  - attr(*, "na.action")= 'omit' Named int [1:32] 6 14 15 17 24 25 28 44 47 53 ...
##   ..- attr(*, "names")= chr [1:32] "7" "15" "16" "18" ...
```

Nach dem Entfernen der fehlenden Werte haben wir eine Stichprobengröße von $n = 147$.

**Deskriptivstatistische Überprüfung der Hypothesen: grafisch**

Histogramme (weil die Skalenwerte Intervallskalenqualität haben):
Je ein Histogramm pro Gruppe, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert.


```r
par(mfrow=c(2,1), mar=c(3,2,2,0)) # Zusammenfügen der zwei Histogramme in eine Plot-Datei und ändern der Ränder (margins) des Plot-Fensters

hist(ruhe[, "ru_pre"], xlim=c(0,5), ylim=c(1,50), main="Ruheempfinden vor der Sitzung", xlab="", ylab="", las=1)
abline(v=mean(ruhe[, "ru_pre"]), lty=2, lwd=2)

hist(ruhe[, "ru_post"], xlim=c(0,5), ylim=c(1,50), main="Ruheempfinden nach der Sitzung", xlab="", ylab="", las=1)
abline(v=mean(ruhe[, "ru_post"]), lty=2, lwd=2)
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig-loesungen_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
par(mfrow=c(1,1)) #Zurücksetzen auf default
```


**Deskriptivstatistische Beantwortung der Fragestellung: statistisch**


```r
summary(ruhe[, "ru_pre"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   1.000   2.250   3.000   2.745   3.250   4.000
```

```r
summary(ruhe[, "ru_post"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   1.000   2.500   3.000   2.951   3.500   4.000
```

```r
# aus dem Paket psych, das wir bereits installiert haben
library(psych)
describe(ruhe[, "ru_pre"])
```

```
##    vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 147 2.74 0.76      3    2.79 0.74   1   4     3 -0.48    -0.55 0.06
```

```r
describe(ruhe[, "ru_post"])
```

```
##    vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 147 2.95 0.65      3    2.98 0.74   1   4     3 -0.43    -0.36 0.05
```

Der Mittelwert vorher ($M$ = 2.74, $SD$ = 0.76) ist deskriptiv niedriger als Mittelwert nachher ($M$ = 2.95, $SD$ = 0.65).

Die deskriptivstatistischen Maße unterscheiden sich. 

</details>

* Welcher inferenzstatistische Test ist zur Überprüfung der Hypothesen am geeignetsten? Prüfen Sie die Voraussetzungen dieses Tests.

<details><summary>Lösung</summary>

**Voraussetzungen für t-Test für abhängige Stichproben**

1. Die abhängige Variable ist intervallskaliert $\rightarrow$ ok

2. Die Messwerte innerhalb der Paare dürfen sich gegenseitig beeinflussen/voneinander abhängig sein; keine Abhängigkeiten zwischen den Messwertpaaren $\rightarrow$ ok

3. Die Stichprobenkennwerteverteilung der mittleren Mittelwertsdifferenz muss in der Population normalverteilt sein (ist gegeben, wenn die Verteilung der Mittelwertsdifferenzen in der Stichprobe normalverteilt ist) $\rightarrow$ ab $n > 30$ ist Normalverteilung der Stichprobenkennwerteverteilung durch zetralen Grenzwertsatz gegeben, ansonsten grafische Prüfung oder Hintergrundwissen $\rightarrow$ mit $n = 147$ erfüllt; Überprüfung der Normalverteilung von _d_ wird hier aus Übungszwecken trotzdem mit aufgeführt.

**Grafische Voraussetzungsprüfung: Normalverteilung von _d_**

```r
par(mar=c(3,3,3,0)) #ändern der Ränder (margins) des Plot-Fensters
difference <- ruhe[, "ru_pre"]-ruhe[, "ru_post"]
hist(difference, xlim=c(-4,4), main="Verteilung der Differenzen", xlab="Differenzen", ylab="", las=1,freq=F)
curve(dnorm(x, mean=mean(difference), sd=sd(difference)), col="blue", lwd=2, add=T)
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig-loesungen_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

```r
par(mfrow=c(1,1)) #Zurücksetzen auf default
qqnorm(difference,las=1)
qqline(difference, col="blue")
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig-loesungen_files/figure-html/unnamed-chunk-6-2.png)<!-- -->

$\Rightarrow$ Differenzen sehen einigermaßen normalverteilt aus. 

$\Rightarrow$ Durchführung des t-Tests für abhängige Stichproben, da alle Voraussetzungen hierfür erfüllt sind.
</details>

* Führen Sie die inferenzstatistische Testung durch.

<details><summary>Lösung</summary>

**Durchführung des _t_-Tests für abhängige Stichproben in R**


```r
t.test(x = ruhe[, "ru_pre"], y  = ruhe[, "ru_post"], # die Werte vorher und nachher
       paired = T,                                   # Stichproben sind abhängig
       alternative = "two.sided",                    # unggerichtete Hypothese -> zweiseitig Testung
       conf.level = .95)                             # alpha = .05
```

```
## 
## 	Paired t-test
## 
## data:  ruhe[, "ru_pre"] and ruhe[, "ru_post"]
## t = -4.353, df = 146, p-value = 2.511e-05
## alternative hypothesis: true mean difference is not equal to 0
## 95 percent confidence interval:
##  -0.2992108 -0.1123539
## sample estimates:
## mean difference 
##      -0.2057823
```


```r
# Alternative Schreibweise
t.test(x = ruhe$ru_pre, y = ruhe$ru_post, 
       paired = T,
       alternative = "two.sided",
       conf.level = .95)
```



* Zur Erinnerung: $df$ bei $t$-test mit abhängigen Stichproben: $n - 1$ (wobei $n$ die Anzahl der Paare darstellt)
* _t_(146) = -4.353, $p > .05$ $\rightarrow$ nicht signifikant, H0 wird beibehalten.

</details>

* Berechnen Sie die zugehörige Effektstärke.

<details><summary>Lösung</summary>

**Schätzung des standardisierten Populationseffekts**


```r
mean_d <- mean(difference) # Mittelwert der Differenzen
sd.d.est <- sd(difference) # geschätzte Populationsstandardabweichung der Differenzen
d <- mean_d/sd.d.est
d
```

```
## [1] -0.359032
```

$\Rightarrow$ Der standardisierte Populationseffekt beträgt _d2''_ = -0.36 und ist laut Konventionen nach Cohen (1988) klein. 

Zu beachten ist, dass der standardisierte Populationseffekt auf der vorher berechneten Differenzvariable basiert. Aus diesem Grund hat der Effekt ein negatives Vorzeichen.

Zur Berechnung der Differenzvariable wurden von den Prä-Messungen die Post-Messungen abgezogen. Ein negatives Vorzeichen des standardisierten Populationseffektes deutet also, wie auch unsere deskriptivstatistischen Ergebnisse, darauf hin, dass die Teilnahme am Statistikpraktikum einen positiven Effekt auf das Ruheempfinden haben könnte. Dies könnte man in einer weiteren Studie inferenzstatistisch überprüfen.

</details>

* Berichten Sie die Ergebnisse formal (in schriftlicher Form).

<details><summary>Lösung</summary>

**Formales Berichten des Ergebnisses**

Es wurde in einer Wiederholungsmessung untersucht, ob sich die Teilnahme am Statistikpraktikum  auf das Ruheempfinden auswirkt. Zunächst findet sich deskriptiv folgender Unterschied: Vor der Praktikumssitzung liegt der durchschnittliche Zufriedenheitswert bei 2.74 (_SD_ = 0.76), während er nach der Praktikumssitzung bei 2.95 (_SD_ = 0.65) liegt. 

Zur Beantwortung der Fragestellung wurde ein ungerichteter _t_-Test für abhängige Stichproben durchgeführt. Der Gruppenunterschied ist signifikant (_t_(146) = -4.353, $p < .05$), somit wird die Nullhypothese verworfen. Wir gehen davon aus, dass sich die Teilnahme am Statistikpraktikum auf das Ruheempfinden auswirkt.

Der standardisierte Populationseffekt von _d''_ = -0.36 ist laut Konventionen nach Cohen (1988) klein.

</details>
