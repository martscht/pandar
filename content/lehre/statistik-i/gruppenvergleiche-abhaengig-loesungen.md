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
lastmod: '2024-03-27'
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

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/gruppenvergleiche-abhaengig
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/gruppenvergleiche-abhaengig-aufgaben
    
output:
  html_document:
    keep_md: true
---



## Vorbereitung

> Laden Sie zunächst den Datensatz `fb23` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb23.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/gruppenvergleiche-abhaengig/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.





## Aufgabe 1
Zu Beginn und nach der ersten Pratikumssitzung wurden Sie als Studierende nach Ihrem Befinden zum Zeitpunkt der Umfrage befragt. Hierbei wurde unteranderem erhoben, wie wach (hohe Werte) oder müde (niedrige Werte) Sie sich zu beiden Zeitpunkten gefühlt haben (Variable `wm_pre` und `wm_post`). Nun wollen Sie untersuchen, ob die Teilnahme am Statistikpraktikum einen Einfluss auf das Befinden der Studierenden hat. Sie gehen davon aus, dass sich die Angaben zu Wach vor und nach dem Praktikum unterscheidet ohne eine Richtung anzunehmen.



* Stellen Sie zunächst das Hypothesenpaar der Testung inhaltich und auch mathematisch auf. Spezifizieren Sie das Signifikanzniveau. Dieses soll so gewählt werden, dass wir die Nullhypothese in 1 von 20 Fällen fälschlicherweise verwerfen würden.

<details><summary>Lösung</summary>

**Hypothesen**

* Art des Effekts: Unterschiedshypothese  
* Richtung des Effekts: ungerichtete Hypothese
* Größe des Effekts: Unspezifisch  


Hypothesenpaar (inhaltlich):  
H0: Die Teilnahme am Statistikpraktikum wirkt sich nicht auf das Wachempfinden der Studierenden aus.
H1: Die Teilnahme am Statistikpraktikum wirkt sich auf das Wachempfinden der Studierenden aus.

Hypothesenpaar (statistisch):  

* $H_0$: $\eta_\text{nachher} = \eta_\text{vorher}$  bzw. $\mu_{d} = 0$
* $H_1$: $\eta_\text{nachher} \neq  \eta_\text{vorher}$  bzw. $\mu_{d} \neq 0$

**Spezifikation des Signifikanzniveaus**

$\alpha = .05$

</details>

* Bestimmen Sie die deskriptivstatistischen Maße und bewerten Sie diese im Hinblick auf die Hypothesen. Beachten Sie, dass bei der späteren inferenzstatistischen Testung nur Personen eingehen, die zu beiden Messzeitpunkten Angaben gemacht haben. Schließen Sie also Personen mit fehlenden Werten auf einer (oder beiden) Variablen vor der Berechnung der deskriptivstatistischen Maße aus.

<details><summary>Lösung</summary>

**Bevor es weiter geht:**

Ein Blick in den `fb23`-Datensatz verrät, dass auf dem Skalenwert `wm_post`, der Messung des Wachempfindens zum zweiten Zeitpunkt, Werte fehlen. Diese fehlenden Werte werden als *NA* abgebildet.

Um verfälschte deskriptiv- und inferenzstatistische Ergebnisse zu vermeiden, werden alle Personen aus der weiteren Berechung ausgeschlossen, die einen fehlenden Wert auf `wm_post` (oder `wm_pre`) aufweisen. Damit wir den Datensatz `fb23` aber nicht generell verändern, legen wir estmal einen neuen Datesatz an, der nur die beiden interessierenden Variablen enthält.


```r
wach <- fb23[, c("wm_pre", "wm_post")] #Erstellung eines neuen Datensatzes, welcher nur die für uns wichtigen Variablen enthält

wach <- na.omit(wach) #Entfernt alle Beobachtungen, die auf einer der beiden Variable einen fehlenden Wert haben

str(wach) #Ablesen der finalen Stichprobengröße
```

```
## 'data.frame':	146 obs. of  2 variables:
##  $ wm_pre : num  2.5 2.25 2.75 3 2.25 2.25 2.5 1.75 3.25 2.5 ...
##  $ wm_post: num  2 1 3.75 3 3.25 2 3.25 2 1.5 3 ...
##  - attr(*, "na.action")= 'omit' Named int [1:33] 4 6 14 15 17 24 25 28 44 47 ...
##   ..- attr(*, "names")= chr [1:33] "4" "7" "15" "16" ...
```

Nach dem Entfernen der fehlenden Werte haben wir eine Stichprobengröße von $n = 147$.

**Deskriptivstatistische Überprüfung der Hypothesen: grafisch**

Histogramme (weil die Skalenwerte Intervallskalenqualität haben):
Je ein Histogramm pro Gruppe, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert.


```r
par(mfrow=c(2,1), mar=c(3,2,2,0)) # Zusammenfügen der zwei Histogramme in eine Plot-Datei und ändern der Ränder (margins) des Plot-Fensters

hist(wach[, "wm_pre"], xlim=c(0,5), ylim=c(1,50), main="Wachempfinden vor der Sitzung", xlab="", ylab="", las=1)
abline(v=mean(wach[, "wm_pre"]), lty=2, lwd=2)

hist(wach[, "wm_post"], xlim=c(0,5), ylim=c(1,50), main="Wachempfinden nach der Sitzung", xlab="", ylab="", las=1)
abline(v=mean(wach[, "wm_post"]), lty=2, lwd=2)
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig-loesungen_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
par(mfrow=c(1,1)) #Zurücksetzen auf default
```


**Deskriptivstatistische Beantwortung der Fragestellung: statistisch**


```r
summary(wach[, "wm_pre"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.00    2.25    2.75    2.63    3.00    4.00
```

```r
summary(wach[, "wm_post"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.00    2.00    2.50    2.58    3.00    4.00
```

```r
# aus dem Paket psych, das wir bereits installiert haben
library(psych)
describe(wach[, "wm_pre"])
```

```
##    vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 146 2.63 0.59   2.75    2.64 0.74   1   4     3 -0.19    -0.29 0.05
```

```r
describe(wach[, "wm_post"])
```

```
##    vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 146 2.58 0.69    2.5    2.59 0.74   1   4     3 -0.15    -0.41 0.06
```

Der Mittelwert vorher ($M$ = 2.63, $SD$ = 0.59) ist deskriptiv niedriger als Mittelwert nachher ($M$ = 2.58, $SD$ = 0.69).

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
difference <- wach[, "wm_pre"]-wach[, "wm_post"]
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

$\Rightarrow$ Differenzen weisen leichte bis mittlere Abweichungen zur Normalverteilung auf. Symmetrie trotzdem gegeben und auf Grund des zentralen Grenzwertsatzes und der Stichprobengröße $\Rightarrow$ Durchführung des t-Tests für abhängige Stichproben
</details>

* Führen Sie die inferenzstatistische Testung durch.

<details><summary>Lösung</summary>

**Durchführung des _t_-Tests für abhängige Stichproben in R**


```r
t.test(x = wach[, "wm_pre"], y  = wach[, "wm_post"], # die Werte vorher und nachher
       paired = T,                                   # Stichproben sind abhängig
       alternative = "two.sided",                    # unggerichtete Hypothese -> zweiseitig Testung
       conf.level = .95)                             # alpha = .05
```

```
## 
## 	Paired t-test
## 
## data:  wach[, "wm_pre"] and wach[, "wm_post"]
## t = 1.0791, df = 145, p-value = 0.2823
## alternative hypothesis: true mean difference is not equal to 0
## 95 percent confidence interval:
##  -0.04129183  0.14060690
## sample estimates:
## mean difference 
##      0.04965753
```


```r
# Alternative Schreibweise
t.test(x = wach$wm_pre, y = wach$wm_post, 
       paired = T,
       alternative = "two.sided",
       conf.level = .95)
```



* Zur Erinnerung: $df$ bei $t$-test mit abhängigen Stichproben: $n - 1$ (wobei $n$ die Anzahl der Paare darstellt)
* _t_(145) = 1.079, $p =$ 0.282 $\rightarrow$ nicht signifikant, H0 wird beibehalten.

</details>

* Bestimmen Sie unabhängig von der Signifikanzentscheidung die zugehörige Effektstärke.

<details><summary>Lösung</summary>

**Schätzung des standardisierten Populationseffekts**


```r
mean_d <- mean(difference) # Mittelwert der Differenzen
sd.d.est <- sd(difference) # geschätzte Populationsstandardabweichung der Differenzen
d <- mean_d/sd.d.est
d
```

```
## [1] 0.08930936
```

$\Rightarrow$ Der standardisierte Populationseffekt beträgt _d2''_ = 0.09 und ist laut Konventionen nach Cohen (1988) klein. 

Zu beachten ist, dass der standardisierte Populationseffekt auf der vorher berechneten Differenzvariable basiert. Aus diesem Grund hat der Effekt ein negatives Vorzeichen.

Zur Berechnung der Differenzvariable wurden von den Prä-Messungen die Post-Messungen abgezogen. Ein negatives Vorzeichen des standardisierten Populationseffektes deutet also, wie auch unsere deskriptivstatistischen Ergebnisse, darauf hin, dass die Teilnahme am Statistikpraktikum einen positiven Effekt auf das Wachempfinden haben könnte. Dies könnte man in einer weiteren Studie inferenzstatistisch überprüfen.

</details>

* Berichten Sie die Ergebnisse formal (in schriftlicher Form).

<details><summary>Lösung</summary>

**Formales Berichten des Ergebnisses**

Es wurde in einer Wiederholungsmessung untersucht, ob sich die Teilnahme am Statistikpraktikum  auf das Wachempfinden auswirkt. Zunächst findet sich deskriptiv folgender Unterschied: Vor der Praktikumssitzung liegt der durchschnittliche Zufriedenheitswert bei 2.63 (_SD_ = 0.59), während er nach der Praktikumssitzung bei 2.58 (_SD_ = 0.69) liegt. 

Zur Beantwortung der Fragestellung wurde ein ungerichteter $t$-Test für abhängige Stichproben durchgeführt. Der Gruppenunterschied ist nicht signifikant ($t$(145) = 1.079, $p =$ 0.282), somit wird die Nullhypothese beibehalten. Wir gehen davon aus, dass sich die Teilnahme am Statistikpraktikum nicht auf das Wachempfinden auswirkt.

Der standardisierte Populationseffekt von _d''_ = 0.09 ist laut Konventionen nach Cohen (1988) klein.

</details>
