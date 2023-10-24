---
title: "Tests und Konfidenzintervalle - Lösungen" 
type: post
date: '2020-12-11' 
slug: tests-konfidenzintervalle-loesungen
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [scheppa-lahyani, nehler, vogler] 
lastmod: '2023-10-24'
featured: no
banner:
  image: "/header/BSc2_Tests.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/1240882)"
projects: []
expiryDate: '2024-10-10'
publishDate: '2023-11-30'
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

Laden Sie zunächst den Datensatz `fb23` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb23.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/tests-konfidenzintervalle/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.


```r
#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb23.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb23$hand_factor <- factor(fb23$hand,
                           levels = 1:2,
                           labels = c("links", "rechts"))

fb23$fach <- factor(fb23$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung',
                               'Klinische', 'Diag./Meth.'))

fb23$ziel <- factor(fb23$ziel,
                    levels = 1:4,
                    labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))

fb23$wohnen <- factor(fb23$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

# Weitere Standardisierugen
fb23$nerd_std <- scale(fb23$nerd)
fb23$neuro_std <- scale(fb23$neuro)
```

Prüfen Sie zur Sicherheit, ob alles funktioniert hat:


```r
dim(fb23)
```

```
## [1] 179  43
```

```r
str(fb23)
```

```
## 'data.frame':	179 obs. of  43 variables:
##  $ mdbf1_pre  : int  4 2 4 NA 3 3 2 3 3 2 ...
##  $ mdbf2_pre  : int  2 2 3 3 3 2 3 2 2 1 ...
##  $ mdbf3_pre  : int  3 4 2 2 2 3 3 1 2 2 ...
##  $ mdbf4_pre  : int  2 2 1 2 1 1 3 2 3 3 ...
##  $ mdbf5_pre  : int  3 2 3 2 2 1 3 3 2 4 ...
##  $ mdbf6_pre  : int  2 1 2 2 2 2 2 3 2 2 ...
##  $ mdbf7_pre  : int  4 3 3 1 1 2 2 3 3 3 ...
##  $ mdbf8_pre  : int  3 2 3 2 3 3 2 3 3 2 ...
##  $ mdbf9_pre  : int  2 4 1 2 3 3 4 2 2 3 ...
##  $ mdbf10_pre : int  3 2 3 3 2 4 2 2 2 2 ...
##  $ mdbf11_pre : int  3 2 1 2 2 1 3 1 2 4 ...
##  $ mdbf12_pre : int  1 1 2 3 2 2 2 3 3 2 ...
##  $ lz         : num  5.4 3.4 4.4 4.4 6.4 5.6 5.4 5 4.8 6 ...
##  $ extra      : num  3.5 3 4 3 4 4.5 3.5 3.5 2.5 3 ...
##  $ vertr      : num  1.5 3 3.5 4 4 4.5 4 4 3 3.5 ...
##  $ gewis      : num  4.5 4 5 3.5 3.5 4 4.5 2.5 3.5 4 ...
##  $ neuro      : num  5 5 2 4 3.5 4.5 3 2.5 4.5 4 ...
##  $ offen      : num  5 5 4.5 3.5 4 4 5 4.5 4 3 ...
##  $ prok       : num  1.8 3.1 1.5 1.6 2.7 3.3 2.2 3.4 2.4 3.1 ...
##  $ nerd       : num  4.17 3 2.33 2.83 3.83 ...
##  $ grund      : chr  "Berufsziel" "Interesse am Menschen" "Interesse und Berufsaussichten" "Wissenschaftliche Ergänzung zu meinen bisherigen Tätigkeiten (Arbeit in der psychiatrischen Akutpflege, Gestalt"| __truncated__ ...
##  $ fach       : Factor w/ 5 levels "Allgemeine","Biologische",..: 4 4 4 4 4 4 NA 4 4 NA ...
##  $ ziel       : Factor w/ 4 levels "Wirtschaft","Therapie",..: 2 2 2 2 2 2 NA 4 2 2 ...
##  $ wissen     : int  5 4 5 4 2 3 NA 4 3 3 ...
##  $ therap     : int  5 5 5 5 4 5 NA 3 5 5 ...
##  $ lerntyp    : num  3 3 1 3 3 1 NA 1 3 3 ...
##  $ hand       : int  2 2 2 2 2 2 NA 2 1 2 ...
##  $ job        : int  1 1 1 1 2 2 NA 2 1 2 ...
##  $ ort        : int  2 1 1 1 1 2 NA 1 1 2 ...
##  $ ort12      : int  2 1 2 2 2 1 NA 2 2 1 ...
##  $ wohnen     : Factor w/ 4 levels "WG","bei Eltern",..: 4 1 1 1 1 2 NA 3 3 2 ...
##  $ uni1       : num  0 1 0 1 0 0 0 0 0 0 ...
##  $ uni2       : num  1 1 1 1 1 1 0 1 1 1 ...
##  $ uni3       : num  0 1 0 0 1 0 0 1 1 0 ...
##  $ uni4       : num  0 1 0 1 0 0 0 0 0 0 ...
##  $ attent_pre : int  6 6 6 6 6 6 NA 4 5 5 ...
##  $ gs_post    : num  3 2.75 4 2.5 3.75 NA 4 2.75 3.75 2.5 ...
##  $ wm_post    : num  2 1 3.75 2.75 3 NA 3.25 2 3.25 2 ...
##  $ ru_post    : num  2.25 1.5 3.75 3.5 3 NA 3.5 2.75 2.75 2.75 ...
##  $ attent_post: int  6 5 6 6 6 NA 6 4 5 3 ...
##  $ hand_factor: Factor w/ 2 levels "links","rechts": 2 2 2 2 2 2 NA 2 1 2 ...
##  $ nerd_std   : num [1:179, 1] 1.797 -0.0516 -1.108 -0.3157 1.2688 ...
##   ..- attr(*, "scaled:center")= num 3.03
##   ..- attr(*, "scaled:scale")= num 0.631
##  $ neuro_std  : num [1:179, 1] 1.68 1.68 -1.383 0.659 0.148 ...
##   ..- attr(*, "scaled:center")= num 3.35
##   ..- attr(*, "scaled:scale")= num 0.979
```

Der Datensatz besteht aus 179 Zeilen (Beobachtungen) und 43 Spalten (Variablen). Falls Sie weitere eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.

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
mean_lz <- mean(fb23$lz, na.rm = T) #Mittelwert
mean_lz
```

```
## [1] 5.120904
```

```r
sd_lz <- sd(fb23$lz, na.rm = T) #Standardabweichung
sd_lz
```

```
## [1] 1.054893
```

```r
n_lz <- length(na.omit(fb23$lz)) #Stichprobengröße
se_lz <- sd_lz / sqrt(n_lz) #Standardfehler
se_lz
```

```
## [1] 0.07929061
```

* Der Mittelwert der Lebenszufriedenheit in der Stichprobe liegt bei 5.121.
* Die Standardabweichung der Lebenszufriedenheit beträgt 1.055.
* Der Standardfehler der Lebenszufriedenheit beträgt 0.079.

**Variante 2**:


```r
describe(fb23$lz) #Funktion aus Paket "psych"
```

```
##    vars   n mean   sd median trimmed  mad min max range  skew
## X1    1 177 5.12 1.05    5.4    5.19 0.89 1.4   7   5.6 -0.75
##    kurtosis   se
## X1     0.58 0.08
```

</details>



**2.2** Sind die Lebenszufriedenheitswerte normalverteilt? Veranschaulichen Sie dies mit einem geeigneten Plot. Benutzen Sie außerdem die `qqPlot`-Funktion aus dem `car`-Paket. Wann kann man in diesem Fall von einer Normalverteilung ausgehen?

<details><summary>Lösung</summary>


```r
#geeigneter Plot: QQ-Plot. Alle Punkte sollten auf einer Linie liegen.
qqnorm(fb23$lz)
qqline(fb23$lz)
```

![](/lehre/statistik-i/tests-konfidenzintervalle-loesungen_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

```r
#Die qqPlot-Funktion zeichnet ein Konfidenzintervall in den QQ-Plot. Dies macht es für Betrachter:innen einfacher zu entscheiden, ob alle Punkte in etwa auf einer Linie liegen. Die Punkte sollten nicht außerhalb der blauen Linien liegen.
qqPlot(fb23$lz)
```

![](/lehre/statistik-i/tests-konfidenzintervalle-loesungen_files/figure-html/unnamed-chunk-7-2.png)<!-- -->

```
## [1] 19 98
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
t.test(fb23$lz, mu=4.4)
```

```
## 
## 	One Sample t-test
## 
## data:  fb23$lz
## t = 9.0919, df = 176, p-value < 2.2e-16
## alternative hypothesis: true mean is not equal to 4.4
## 95 percent confidence interval:
##  4.964421 5.277387
## sample estimates:
## mean of x 
##  5.120904
```

```r
t.test(fb23$lz, mu=4.4, conf.level = 0.99) #Default ist 95%, deshalb erhöhen wir auf 99%
```

```
## 
## 	One Sample t-test
## 
## data:  fb23$lz
## t = 9.0919, df = 176, p-value < 2.2e-16
## alternative hypothesis: true mean is not equal to 4.4
## 99 percent confidence interval:
##  4.914427 5.327381
## sample estimates:
## mean of x 
##  5.120904
```

Zuvor ist uns aufgefallen, dass die Lebenszufriedenheit nicht normalskaliert ist.
Außerdem haben wir gelernt das ab *n* > 30 der zentrale Grenzwertsatz greift. Es
gibt aber auch noch die Möglichkeit auf einen Test mit weniger strengen Voraussetzungen zurückzugreifen. Dafür büßen wir etwas Power ($1 - \beta$) ein. Das heißt, wenn ein Effekt vorliegt ist es schwerer (unwahrscheinlicher) diesen nachzuweisen.
Einen solchen Test lernt ihr im nächsten Kapitel kennen und der
Vollständigkeit halber werden wir in hier vorrechnen. Dabei handelt es sich um den Wilcoxon-Test.


```r
wilcox.test(fb23$lz, mu = 4.4, conf.level = 0.99) #gleiche Argumente wie beim t-Test
```

```
## 
## 	Wilcoxon signed rank test with continuity correction
## 
## data:  fb23$lz
## V = 12005, p-value = 1.644e-13
## alternative hypothesis: true location is not equal to 4.4
```

Auch dieser Test fällt signifikant aus. Daraus können wir schließen:

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
mean_note <- 2.01 #Mittelwert alt
mean_sd <- 0.57 #Standardabweichung alt
n_new_note <- 140 #Stichprobengröße
new_mean_note <- 1.81 #Mittelwert neu
se_mean_note <- 0.57/sqrt(n_new_note) #Standardfehler
z_note <- abs((new_mean_note - mean_note)/se_mean_note) #empirischer z-Wert
z_note
```

```
## [1] 4.151635
```

```r
z_krit <- qnorm(1 - .05) #kritischer z-Wert
z_krit
```

```
## [1] 1.644854
```

```r
z_note > z_krit #Signifikanzentscheidung
```

```
## [1] TRUE
```

Mit einer Irrtumswahrscheinlichkeit von 5% wird die $H_0$ (keine Veränderung) verworfen. Die Abschlussnote hat sich über die Jahre verbessert.

</details>



**3.2** Wieviel Prozent der damaligen Fälle hatten eine bessere Abschlussnote als die neue ermittelte Abschlussnote von 1.81?

<details><summary>Lösung</summary>




```r
pnorm(q = 1.81, mean = 2.01, sd = .57, lower.tail = T)*100
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
t.test(fb23$extra, mu = 3.5)
```

```
## 
## 	One Sample t-test
## 
## data:  fb23$extra
## t = -3.4235, df = 178, p-value = 0.0007673
## alternative hypothesis: true mean is not equal to 3.5
## 95 percent confidence interval:
##  3.134515 3.401798
## sample estimates:
## mean of x 
##  3.268156
```



Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ verworfen werden. Die Psychologie-Studierenden unterscheiden sich in ihrer Extraversion von der Gesamtbevölkerung. 
Das 95%-ige Konfidenzintervall liegt zwischen 3.13 und 3.4. Das bedeutet, dass in 95% der Fälle in einer wiederholten Ziehung aus der Grundgesamtheit die mittleren Extraversionswerte zwischen 3.13 und 3.4 liegen.

**Effektgröße:**


```r
mean_extra <- mean(fb23$extra, na.rm = T) #Mittlere Extraversion der Stichprobe
sd_extra <- sd(fb23$extra, na.rm = T) #Stichproben SD (Populationsschätzer)
mean_Popu_extra <- 3.5 #Mittlere Extraversion der Grundgesamtheit
d1 <- abs((mean_extra - mean_Popu_extra) / sd_extra) #abs(), da Betrag
d1
```

```
## [1] 0.2558808
```

Die Effektgröße ist mit 0.26 nach Cohen (1988) als klein einzuordnen.

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
t.test(fb23$nerd, mu = 2.9, alternative = "greater", conf.level = 0.99)
```

```
## 
## 	One Sample t-test
## 
## data:  fb23$nerd
## t = 2.8109, df = 178, p-value = 0.002747
## alternative hypothesis: true mean is greater than 2.9
## 99 percent confidence interval:
##  2.921858      Inf
## sample estimates:
## mean of x 
##  3.032588
```



Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ verworfen werden. Die Psychologie-Studierenden haben höhere Nerdiness-Werte im Vergleich zur Gesamtbevölkerung.


**Effektgröße:**


```r
mean_nerd <- mean(fb23$nerd, na.rm = T) #Mittlere Nerdiness der Stichprobe
sd_nerd <- sd(fb23$nerd, na.rm = T) #Stichproben SD (Populationsschätzer)
mean_Popu_nerd <- 2.9 #Mittlere Nerdiness der Grundgesamtheit
d2 <- abs((mean_nerd - mean_Popu_nerd) / sd_nerd) #abs(), da Betrag
d2
```

```
## [1] 0.2100938
```

Die Effektgröße ist mit 0.21 nach Cohen als klein einzuordnen.

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
t.test(fb23$vertr, mu = 3.9, alternative = "greater")
```

```
## 
## 	One Sample t-test
## 
## data:  fb23$vertr
## t = -7.0875, df = 177, p-value = 1
## alternative hypothesis: true mean is greater than 3.9
## 95 percent confidence interval:
##  3.361644      Inf
## sample estimates:
## mean of x 
##  3.463483
```



Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ verworfen werden. Die Psychologie-Studierenden haben höhere Verträglichkeitswerte im Vergleich zur Gesamtbevölkerung.
Das 95%-ige Konfidenzintervall liegt zwischen 3.36 und $\infty$ (außerhalb des definierten Wertebereichs). Das bedeutet, dass in 95% der Fälle in einer wiederholten Ziehung aus der Grundgesamtheit die mittleren Verträglichkeitswerte zwischen 3.36 und $\infty$ (außerhalb des definierten Wertebereichs) liegen.

**Effektgröße:**


```r
mean_vertr <- mean(fb23$vertr, na.rm = T) #Mittlere Verträglichkeit der Stichprobe
sd_vertr <- sd(fb23$vertr, na.rm = T) #Stichproben SD (Populationsschätzer)
mean_Popu_vertr <- 3.9 #Mittlere Verträglichkeit der Grundgesamtheit
d3 <- abs((mean_vertr - mean_Popu_vertr) / sd_vertr) #abs(), da Betrag
d3
```

```
## [1] 0.5312277
```

Die Effektgröße ist mit 0.53 nach Cohen (1988) als mittel einzuordnen.
