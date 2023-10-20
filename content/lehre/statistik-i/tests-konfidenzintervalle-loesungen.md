---
title: "Tests und Konfidenzintervalle - Lösungen" 
type: post
date: '2020-12-11' 
slug: tests-konfidenzintervalle-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [scheppa-lahyani, nehler] 
lastmod: '2023-10-18'
featured: no
banner:
  image: "/header/BSc2_Tests.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/1240882)"
projects: []
expiryDate:
publishDate: '2023-12-10'
_build:
  list: never
reading_time: false
share: false
output:
  html_document:
    keep_md: true
---

### Vorbereitung

<details><summary>Lösung</summary>

Laden Sie zunächst den Datensatz `fb22` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb22.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/tests-konfidenzintervalle/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.


```r
#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb22.rda'))  

# Nominalskalierte Variablen in Faktoren verwandeln
fb22$geschl_faktor <- factor(fb22$geschl,
                             levels = 1:3,
                             labels = c("weiblich", "männlich", "anderes"))
fb22$fach <- factor(fb22$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb22$ziel <- factor(fb22$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb22$wohnen <- factor(fb22$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

# Skalenbildung

fb22$prok2_r <- -1 * (fb22$prok2 - 5)
fb22$prok3_r <- -1 * (fb22$prok3 - 5)
fb22$prok5_r <- -1 * (fb22$prok5 - 5)
fb22$prok7_r <- -1 * (fb22$prok7 - 5)
fb22$prok8_r <- -1 * (fb22$prok8 - 5)

# Prokrastination
fb22$prok_ges <- fb22[, c('prok1', 'prok2_r', 'prok3_r',
                          'prok4', 'prok5_r', 'prok6',
                          'prok7_r', 'prok8_r', 'prok9', 
                          'prok10')] |> rowMeans()
# Naturverbundenheit
fb22$nr_ges <-  fb22[, c('nr1', 'nr2', 'nr3', 'nr4', 'nr5',  'nr6')] |> rowMeans()
fb22$nr_ges_z <- scale(fb22$nr_ges) # Standardisiert

# Weitere Standardisierugen
fb22$nerd_std <- scale(fb22$nerd)
fb22$neuro_std <- scale(fb22$neuro)
```

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

Der Datensatz besteht aus 159 Zeilen (Beobachtungen) und 47 Spalten (Variablen). Falls Sie weitere eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.

</details>


## Aufgabe 1

Im Laufe der Aufgaben sollen Sie auch Funktionen aus Paketen nutzen, die nicht standardmäßig aktiviert und auch eventuell noch nicht installiert sind. Sorgen Sie in dieser Aufgabe zunächst dafür, dass Sie Funktionen aus den Paketen `psych` und `car` nutzbar sind. Denken Sie an die beiden dargestellten Schritte aus dem Tutorial und auch daran, dass eine Installation nur einmalig notwendig ist. 

<details><summary>Lösung</summary>

Installieren aller wichtigen Packages. Beachten Sie, dass das `psych` Paket eventuell schon im Tutorial installiert wurde, weshalb Sie dies nicht nochmal machen müssen.


```r
install.packages("psych")
install.packages("car")
```

Damit die Funktionen ansprechbar sind, müssen die Pakete auch noch mittels `library` aktiviert werden.


```r
library(psych)
library(car)
```

</details>


## Aufgabe 2

Die mittlere Lebenszufriedenheit (`lz`) in Deutschland liegt bei $\mu$ = 4.4.

**2.1** Was ist der Mittelwert ($\bar{x}$), die Standardabweichung (*SD*, $\hat\sigma$) und der Standardfehler ($\hat{\sigma_{\bar{x}}}$) der Lebenszufriedenheit in der Gruppe der Psychologie-Studierenden?

<details><summary>Lösung</summary>

**Variante 1**:


```r
mean.lz <- mean(fb22$lz, na.rm = T) #Mittelwert
mean.lz
```

```
## [1] 4.709554
```

```r
sd.lz <- sd(fb22$lz, na.rm = T) #Standardabweichung
sd.lz
```

```
## [1] 1.073801
```

```r
n.lz <- length(na.omit(fb22$lz)) #Stichprobengröße
se.lz <- sd.lz/sqrt(n.lz) #Standardfehler
se.lz
```

```
## [1] 0.08569867
```

* Der Mittelwert der Lebenszufriedenheit in der Stichprobe liegt bei 4.71.
* Die Standardabweichung der Lebenszufriedenheit beträgt 1.074.
* Der Standardfehler der Lebenszufriedenheit beträgt 0.086.

**Variante 2**:


```r
describe(fb22$lz) #Funktion aus Paket "psych"
```

```
##    vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 157 4.71 1.07    4.8    4.79 0.89 1.4 6.6   5.2 -0.64     0.04 0.09
```

</details>



**2.2** Sind die Lebenszufriedenheitswerte normalverteilt? Veranschaulichen Sie dies mit einem geeigneten Plot. Benutzen Sie außerdem die `qqPlot`-Funktion aus dem `car`-Paket. Wann kann man in diesem Fall von einer Normalverteilung ausgehen?

<details><summary>Lösung</summary>


```r
#geeigneter Plot: QQ-Plot. Alle Punkte sollten auf einer Linie liegen.
qqnorm(fb22$lz)
qqline(fb22$lz)
```

![](/lehre/statistik-i/tests-konfidenzintervalle-loesungen_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

```r
#Die qqPlot-Funktion zeichnet ein Konfidenzintervall in den QQ-Plot. Dies macht es für Betrachter:innen einfacher zu entscheiden, ob alle Punkte in etwa auf einer Linie liegen. Die Punkte sollten nicht außerhalb der blauen Linien liegen.
qqPlot(fb22$lz)
```

![](/lehre/statistik-i/tests-konfidenzintervalle-loesungen_files/figure-html/unnamed-chunk-7-2.png)<!-- -->

```
## [1]  76 120
```
Beide Darstellungsweisen des QQ-Plot weisen darauf hin, dass die Daten **nicht** normalverteilt sind.

</details>



**2.3** Unterscheidet sich die Lebenszufriedenheit der Psychologie-Studierenden von der Lebenszufriedenheit der Gesamtbevölkerung ($\mu$ = 4.4)? Bestimmen Sie das 99%ige Konfidenzintervall.

<details><summary>Lösung</summary>

Da die Varianz der Grundgesamtheit nicht bekannt ist, wird ein t-Test herangezogen.
Obwohl keine Normalverteilung vorliegt, können wir aufgrund des *zentralen Grenzwertsatzes* trotzdem einen t-Test rechnen.

**Hypothesengenerierung:**

$\alpha$ = .01 

$H_0$: Die durchschnittliche Lebenzufriedenheit der Psychologie-Studierenden $\mu_1$ unterscheidet sich nicht von der Lebenszufriedenheit der Gesamtbevölkerung $\mu_0$.

$H_0$: $\mu_0$ $=$ $\mu_1$

$H_1$: Die durchschnittliche Lebenzufriedenheit der Psychologie-Studierenden $\mu_1$ unterscheidet sich von der Lebenszufriedenheit der Gesamtbevölkerung $\mu_0$.

$H_1$: $\mu_0$ $\neq$ $\mu_1$


```r
t.test(fb22$lz, mu=4.4)
```

```
## 
## 	One Sample t-test
## 
## data:  fb22$lz
## t = 3.6121, df = 156, p-value = 0.000409
## alternative hypothesis: true mean is not equal to 4.4
## 95 percent confidence interval:
##  4.540275 4.878834
## sample estimates:
## mean of x 
##  4.709554
```

```r
t.test(fb22$lz, mu=4.4, conf.level = 0.99) #Default ist 95%, deshalb erhöhen wir auf 99%
```

```
## 
## 	One Sample t-test
## 
## data:  fb22$lz
## t = 3.6121, df = 156, p-value = 0.000409
## alternative hypothesis: true mean is not equal to 4.4
## 99 percent confidence interval:
##  4.486077 4.933032
## sample estimates:
## mean of x 
##  4.709554
```

Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ verworfen werden. Die Psychologie-Studierenden unterscheiden sich in ihrer Lebenszufriedenheit von der Gesamtbevölkerung. 

</details>



## Aufgabe 3

Die durchschnittliche Abschlussnote im Fach Psychologie (Bachelor) ist 2.01 ($\sigma$ = 0.57). Eine Forschungsgruppe vermutet, dass sich die durchschnittliche Abschlussnote über die Jahre verändert hat und nun besser ist. Um dies zu überpruefen, untersucht die Forschungsgruppe eine zufällige Stichprobe aus 140 Psychologie-Studierenden (*N* = 140). Sie ermitteln eine durchschnittliche Abschlussnote von 1.81.

**3.1** Reicht diese Information aus, um nachzuweisen, dass sich die durchschnittliche Abschlussnote verändert hat? Berechnen Sie wenn möglich, ob es eine Veränderung gab ($\alpha$ = .05).

<details><summary>Lösung</summary>

Ja, diese Informationen reichen aus. Die Standardabweichung der Stichprobe wird nicht benötigt.

**Hypothesengenerierung:**

$\alpha$ = .05 

$H_0$: Die durchschnittliche Abschlussnote der Psychologie-Studierenden $\mu_1$ ist schlechter oder gleich groß wie zuvor ($\mu_0$).

$H_0$: $\mu_0$ $\leq$ $\mu_1$

$H_1$: Die durchschnittliche Abschlussnote der Psychologie-Studierenden $\mu_1$ ist besser als zuvor ($\mu_0$).

$H_1$: $\mu_0$ $>$ $\mu_1$


```r
mean.note <- 2.01 #Mittelwert alt
mean.sd <- 0.57 #Standardabweichung alt
n.new.note <- 140 #Stichprobengröße
new.mean.note <- 1.81 #Mittelwert neu
se.mean.note <- 0.57/sqrt(n.new.note) #Standardfehler
z.note <- abs((new.mean.note-mean.note)/se.mean.note) #empirischer z-Wert
z.note
```

```
## [1] 4.151635
```

```r
z_krit <- qnorm(1-.05) #kritischer z-Wert
z_krit
```

```
## [1] 1.644854
```

```r
z.note > z_krit #Signifikanzentscheidung
```

```
## [1] TRUE
```

Mit einer Irrtumswahrscheinlichkeit von 5% wird die $H_0$ (keine Veränderung) verworfen. Die Abschlussnote hat sich über die Jahre verbessert.

</details>



**3.2** Wieviel Prozent der damaligen Fälle hatten eine bessere Abschlussnote als die neue ermittelte Abschlussnote von 1.81?

<details><summary>Lösung</summary>




```r
pnorm(q = 1.81, mean = 2.01,sd = .57, lower.tail = T)*100
```

```
## [1] 36.28402
```

Nur 36.28% der Fälle hatten eine bessere Abschlussnote als 1.81. Dies unterstützt das Ergebnis, dass sich der neue Wert von dem bisherigen Mittelwert unterscheidet.  

</details>



## Aufgabe 4

**4.1** Unterscheiden sich die Extraversionswerte (`extra`) der Studierenden der Psychologie (1. Semester) von den Extraversionswerten der Gesamtbevölkerung ($\mu$ = 3.5)? Bestimmen Sie das 95%ige Konfidenzintervall und die Effektgröße.

<details><summary>Lösung</summary>

**Hypothesengenerierung:**

$\alpha$ = .05 

$H_0$: Die durchschnittlichen Extraversionswerte der Psychologie-Studierenden $\mu_1$ unterscheiden sich nicht von den Werten der Gesamtbevölkerung $\mu_0$.

$H_0$: $\mu_0$ $=$ $\mu_1$

$H_1$: Die durchschnittlichen Extraversionswerte der Psychologie-Studierenden $\mu_1$ unterscheiden sich von den Werten der Gesamtbevölkerung $\mu_0$.

$H_1$: $\mu_0$ $\neq$ $\mu_1$


```r
t.test(fb22$extra, mu=3.5)
```

```
## 
## 	One Sample t-test
## 
## data:  fb22$extra
## t = -2.1626, df = 158, p-value = 0.03207
## alternative hypothesis: true mean is not equal to 3.5
## 95 percent confidence interval:
##  3.268361 3.489500
## sample estimates:
## mean of x 
##  3.378931
```



Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ verworfen werden. Die Psychologie-Studierenden unterscheiden sich in ihrer Extraversion von der Gesamtbevölkerung. 
Das 95%-ige Konfidenzintervall liegt zwischen 3.27 und 3.49. Das bedeutet, dass in 95% der Fälle in einer wiederholten Ziehung aus der Grundgesamtheit die mittleren Extraversionswerte zwischen 3.27 und 3.49 liegen.

**Effektgröße:**


```r
mean_extra <- mean(fb22$extra, na.rm = T) #MW der Stichprobe
sd_extra <- sd(fb22$extra, na.rm = T) #Stichproben SD (Populationsschätzer)
mean_Popu_extra <- 3.5 #MW der Grundgesamtheit
d1 <- abs((mean_extra - mean_Popu_extra)/sd_extra) #abs(), da Betrag
d1
```

```
## [1] 0.1715089
```

Die Effektgröße ist mit 0.17 als klein einzuordnen.

</details>



**4.2** Sind die Nerdiness-Werte (`nerd`) der Psychologie-Studierenden (1. Semester) größer als die Nerdiness-Werte der Gesamtbevölkerung ($\mu$ = 2.9)? Bestimmen Sie das 99%ige Konfidenzintervall und die Effektgröße.

<details><summary>Lösung</summary>

**Hypothesengenerierung:**

$\alpha$ = .01 

$H_0$: Die durchschnittlichen Nerdiness-Werte der Psychologie-Studierenden $\mu_1$ sind geringer oder gleich gross wie die Werte der Gesamtbevölkerung $\mu_0$.

$H_0$: $\mu_0$ $\geq$ $\mu_1$

$H_1$: Die durchschnittlichen Nerdiness-Werte der Psychologie-Studierenden $\mu_1$ sind groesser als die Werte der Gesamtbevölkerung $\mu_0$.

$H_1$: $\mu_0$ $<$ $\mu_1$


```r
t.test(fb22$nerd, mu=2.9, alternative="greater", conf.level = 0.99)
```

```
## 
## 	One Sample t-test
## 
## data:  fb22$nerd
## t = 4.3879, df = 158, p-value = 1.042e-05
## alternative hypothesis: true mean is greater than 2.9
## 99 percent confidence interval:
##  3.005341      Inf
## sample estimates:
## mean of x 
##  3.126834
```



Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ verworfen und die $H_1$ angenommen werden. Die Psychologie-Studierenden haben höhere Nerdiness-Werte im Vergleich zur Gesamtbevölkerung.


**Effektgröße:**


```r
mean_nerd <- mean(fb22$nerd, na.rm = T) #MW der Stichprobe
sd_nerd <- sd(fb22$nerd, na.rm = T) #Stichproben SD (Populationsschätzer)
mean_Popu_nerd <- 2.9 #MW der Grundgesamtheit
d2 <- abs((mean_nerd - mean_Popu_nerd)/sd_nerd) #abs(), da Betrag
d2
```

```
## [1] 0.3479827
```

Die Effektgröße ist mit 0.35 als klein bis mittel einzuordnen.

</details>



**4.3** Sind die Psychologie-Studierenden (1. Semester) verträglicher (`vertr`) als die Grundgesamtheit ($\mu$ = 3.9)? Bestimmen Sie das 95%ige Konfidenzintervall und die Effektgröße.

<details><summary>Lösung</summary>

**Hypothesengenerierung:**

$\alpha$ = .05 

$H_0$: Die durchschnittlichen Verträglichkeitswerte der Psychologie-Studierenden $\mu_1$ sind geringer oder gleich gross wie die Werte der Gesamtbevölkerung $\mu_0$.

$H_0$: $\mu_0$ $\geq$ $\mu_1$

$H_1$: Die durchschnittlichen Verträglichkeitswerte der Psychologie-Studierenden $\mu_1$ sind größer als die Werte der Gesamtbevölkerung $\mu_0$.

$H_1$: $\mu_0$ $<$ $\mu_1$


```r
t.test(fb22$vertr, mu=3.9, alternative = "greater")
```

```
## 
## 	One Sample t-test
## 
## data:  fb22$vertr
## t = 4.2764, df = 158, p-value = 1.638e-05
## alternative hypothesis: true mean is greater than 3.9
## 95 percent confidence interval:
##  4.020113      Inf
## sample estimates:
## mean of x 
##  4.095912
```



Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ verworfen und die $H_1$ angenommen werden. Die Psychologie-Studierenden haben höhere Verträglichkeitswerte im Vergleich zur Gesamtbevölkerung.
Das 95%-ige Konfidenzintervall liegt zwischen 4.02 und $\infty$ (außerhalb des definierten Wertebereichs). Das bedeutet, dass in 95% der Fälle in einer wiederholten Ziehung aus der Grundgesamtheit die mittleren Verträglichkeitswerte zwischen 4.02 und $\infty$ (außerhalb des definierten Wertebereichs) liegen.

**Effektgröße:**


```r
mean_vertr <- mean(fb22$vertr, na.rm = T) #MW der Stichprobe
sd_vertr <- sd(fb22$vertr, na.rm = T) #Stichproben SD (Populationsschätzer)
mean_Popu_vertr <- 3.9 #MW der Grundgesamtheit
d3 <- abs((mean_vertr - mean_Popu_vertr)/sd_vertr) #abs(), da Betrag
d3
```

```
## [1] 0.3391422
```

Die Effektgröße ist mit 0.34 als klein bis mittel einzuordnen.
