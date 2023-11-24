---
title: "Tests und Konfidenzintervalle - Lösungen" 
type: post
date: '2020-12-11' 
slug: tests-konfidenzintervalle-loesungen
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [nehler, scheppa-lahyani, vogler] 
lastmod: '2023-11-24'
featured: no
banner:
  image: "/header/angel_of_the_north.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/1240882)"
projects: []
expiryDate: '2024-10-10'

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
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb23$ziel <- factor(fb23$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb23$wohnen <- factor(fb23$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

# Rekodierung invertierter Items
fb23$mdbf4_pre_r <- -1 * (fb23$mdbf4_pre - 4 - 1)
fb23$mdbf11_pre_r <- -1 * (fb23$mdbf11_pre - 4 - 1)
fb23$mdbf3_pre_r <-  -1 * (fb23$mdbf3_pre - 4 - 1)
fb23$mdbf9_pre_r <-  -1 * (fb23$mdbf9_pre - 4 - 1)

# Berechnung von Skalenwerten
fb23$gs_pre  <- fb23[, c('mdbf1_pre', 'mdbf4_pre_r', 
                        'mdbf8_pre', 'mdbf11_pre_r')] |> rowMeans()
fb23$wm_pre <-  fb23[, c("mdbf3_pre_r", "mdbf6_pre", 
                         "mdbf9_pre_r", "mdbf12_pre")] |> rowMeans()

# z-Standardisierung
fb23$wm_pre_zstd <- scale(fb23$wm_pre, center = TRUE, scale = TRUE)
```

Prüfen Sie zur Sicherheit, ob alles funktioniert hat:


```r
dim(fb23)
```

```
## [1] 179  48
```

```r
str(fb23)
```

```
## 'data.frame':	179 obs. of  48 variables:
##  $ mdbf1_pre   : int  4 2 4 NA 3 3 2 3 3 2 ...
##  $ mdbf2_pre   : int  2 2 3 3 3 2 3 2 2 1 ...
##  $ mdbf3_pre   : int  3 4 2 2 2 3 3 1 2 2 ...
##  $ mdbf4_pre   : int  2 2 1 2 1 1 3 2 3 3 ...
##  $ mdbf5_pre   : int  3 2 3 2 2 1 3 3 2 4 ...
##  $ mdbf6_pre   : int  2 1 2 2 2 2 2 3 2 2 ...
##  $ mdbf7_pre   : int  4 3 3 1 1 2 2 3 3 3 ...
##  $ mdbf8_pre   : int  3 2 3 2 3 3 2 3 3 2 ...
##  $ mdbf9_pre   : int  2 4 1 2 3 3 4 2 2 3 ...
##  $ mdbf10_pre  : int  3 2 3 3 2 4 2 2 2 2 ...
##  $ mdbf11_pre  : int  3 2 1 2 2 1 3 1 2 4 ...
##  $ mdbf12_pre  : int  1 1 2 3 2 2 2 3 3 2 ...
##  $ lz          : num  5.4 3.4 4.4 4.4 6.4 5.6 5.4 5 4.8 6 ...
##  $ extra       : num  3.5 3 4 3 4 4.5 3.5 3.5 2.5 3 ...
##  $ vertr       : num  1.5 3 3.5 4 4 4.5 4 4 3 3.5 ...
##  $ gewis       : num  4.5 4 5 3.5 3.5 4 4.5 2.5 3.5 4 ...
##  $ neuro       : num  5 5 2 4 3.5 4.5 3 2.5 4.5 4 ...
##  $ offen       : num  5 5 4.5 3.5 4 4 5 4.5 4 3 ...
##  $ prok        : num  1.8 3.1 1.5 1.6 2.7 3.3 2.2 3.4 2.4 3.1 ...
##  $ nerd        : num  4.17 3 2.33 2.83 3.83 ...
##  $ grund       : chr  "Berufsziel" "Interesse am Menschen" "Interesse und Berufsaussichten" "Wissenschaftliche Ergänzung zu meinen bisherigen Tätigkeiten (Arbeit in der psychiatrischen Akutpflege, Gestalt"| __truncated__ ...
##  $ fach        : Factor w/ 5 levels "Allgemeine","Biologische",..: 4 4 4 4 4 4 NA 4 4 NA ...
##  $ ziel        : Factor w/ 4 levels "Wirtschaft","Therapie",..: 2 2 2 2 2 2 NA 4 2 2 ...
##  $ wissen      : int  5 4 5 4 2 3 NA 4 3 3 ...
##  $ therap      : int  5 5 5 5 4 5 NA 3 5 5 ...
##  $ lerntyp     : num  3 3 1 3 3 1 NA 1 3 3 ...
##  $ hand        : int  2 2 2 2 2 2 NA 2 1 2 ...
##  $ job         : int  1 1 1 1 2 2 NA 2 1 2 ...
##  $ ort         : int  2 1 1 1 1 2 NA 1 1 2 ...
##  $ ort12       : int  2 1 2 2 2 1 NA 2 2 1 ...
##  $ wohnen      : Factor w/ 4 levels "WG","bei Eltern",..: 4 1 1 1 1 2 NA 3 3 2 ...
##  $ uni1        : num  0 1 0 1 0 0 0 0 0 0 ...
##  $ uni2        : num  1 1 1 1 1 1 0 1 1 1 ...
##  $ uni3        : num  0 1 0 0 1 0 0 1 1 0 ...
##  $ uni4        : num  0 1 0 1 0 0 0 0 0 0 ...
##  $ attent_pre  : int  6 6 6 6 6 6 NA 4 5 5 ...
##  $ gs_post     : num  3 2.75 4 2.5 3.75 NA 4 2.75 3.75 2.5 ...
##  $ wm_post     : num  2 1 3.75 2.75 3 NA 3.25 2 3.25 2 ...
##  $ ru_post     : num  2.25 1.5 3.75 3.5 3 NA 3.5 2.75 2.75 2.75 ...
##  $ attent_post : int  6 5 6 6 6 NA 6 4 5 3 ...
##  $ hand_factor : Factor w/ 2 levels "links","rechts": 2 2 2 2 2 2 NA 2 1 2 ...
##  $ mdbf4_pre_r : num  3 3 4 3 4 4 2 3 2 2 ...
##  $ mdbf11_pre_r: num  2 3 4 3 3 4 2 4 3 1 ...
##  $ mdbf3_pre_r : num  2 1 3 3 3 2 2 4 3 3 ...
##  $ mdbf9_pre_r : num  3 1 4 3 2 2 1 3 3 2 ...
##  $ gs_pre      : num  3 2.5 3.75 NA 3.25 3.5 2 3.25 2.75 1.75 ...
##  $ wm_pre      : num  2 1 2.75 2.75 2.25 2 1.75 3.25 2.75 2.25 ...
##  $ wm_pre_zstd : num [1:179, 1] -0.9749 -2.3095 0.0261 0.0261 -0.6412 ...
##   ..- attr(*, "scaled:center")= num 2.73
##   ..- attr(*, "scaled:scale")= num 0.749
```

Der Datensatz besteht aus 179 Zeilen (Beobachtungen) und 48 Spalten (Variablen). Falls Sie weitere eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.

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

```
## Lade nötiges Paket: carData
```

```
## 
## Attache Paket: 'car'
```

```
## Das folgende Objekt ist maskiert 'package:psych':
## 
##     logit
```

</details>


## Aufgabe 2

Die mittlere Lebenszufriedenheit (`lz`) in Deutschland liegt bei $\mu$ = 4.4.

**2.1** Was ist der Mittelwert der Stichprobe ($\bar{x}$) und die geschätzte Populations-Standardabweichung ($\hat\sigma$) der Lebenszufriedenheit in der Gruppe der Psychologie-Studierenden? Schätzen Sie außerdem ausgehend von unseren erhobenen Daten den Standardfehler des Mittelwerts ($\hat{\sigma_{\bar{x}}}$) der Lebenszufriedenheit.

<details><summary>Lösung</summary>

**Variante 1**:


```r
mean_lz <- mean(fb23$lz, na.rm = TRUE) #Mittlere Lebenszufriedenheit
mean_lz
```

```
## [1] 5.120904
```

```r
sd_lz <- sd(fb23$lz, na.rm = TRUE) #Standardabweichung (Populationsschätzer)
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
* Der Standardfehler des Mittelwerts der Lebenszufriedenheit wird als 0.079 geschätzt.

**Variante 2**:


```r
describe(fb23$lz) #Funktion aus Paket "psych"
```

```
##    vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 177 5.12 1.05    5.4    5.19 0.89 1.4   7   5.6 -0.75     0.58 0.08
```

</details>



**2.2** Sind die Lebenszufriedenheitswerte normalverteilt? Veranschaulichen Sie dies mit einer geeigneten optischen Prüfung. Benutzen Sie außerdem die `qqPlot`-Funktion aus dem `car`-Paket. Wann kann man in diesem Fall von einer Normalverteilung ausgehen?

<details><summary>Lösung</summary>


```r
#Histogramm zur Veranschaulichung der Normalverteilung
hist(fb23$lz, xlim = c(1,7), main = "Histogramm", xlab = "Score", ylab = "Dichte", freq = FALSE)
curve(dnorm(x, mean = mean(fb23$lz, na.rm = TRUE), sd = sd(fb23$lz, na.rm = TRUE)), add = TRUE)
```

![](/lehre/statistik-i/tests-konfidenzintervalle-loesungen_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

```r
#geeigneter Plot: QQ-Plot. Alle Punkte sollten auf einer Linie liegen.
qqnorm(fb23$lz)
qqline(fb23$lz)
```

![](/lehre/statistik-i/tests-konfidenzintervalle-loesungen_files/figure-html/unnamed-chunk-7-2.png)<!-- -->

```r
#Die qqPlot-Funktion zeichnet ein Konfidenzintervall in den QQ-Plot. Dies macht es für Betrachter:innen einfacher zu entscheiden, ob alle Punkte in etwa auf einer Linie liegen. Die Punkte sollten nicht außerhalb der blauen Linien liegen.
qqPlot(fb23$lz)
```

![](/lehre/statistik-i/tests-konfidenzintervalle-loesungen_files/figure-html/unnamed-chunk-7-3.png)<!-- -->

```
## [1] 19 98
```
Das Histogramm, sowie beide Darstellungsweisen des QQ-Plot weisen darauf hin, dass die Daten **nicht** normalverteilt sind.

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

Zuvor ist uns aufgefallen, dass die Lebenszufriedenheit nicht normalverteilt ist.
Außerdem haben wir gelernt das ab $n$ > 30 der zentrale Grenzwertsatz greift.
Es gibt aber auch noch die Möglichkeit auf einen Test mit weniger strengen Voraussetzungen zurückzugreifen. Dafür büßen wir etwas Power ($1 - \beta$) ein. Das heißt, wenn ein Effekt vorliegt ist es schwerer (unwahrscheinlicher) diesen nachzuweisen.
Der Ein-Stichproben Wilcoxon Tests der folgt wird **nicht** in der Vorlesung behandelt und ist auch **nicht** klausurrelevant.


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

**3.1** Unterscheidet sich der Mittelwert der Extraversionswerte (`extra`) der Studierenden der Psychologie (1. Semester) von dem der Gesamtbevölkerung ($\mu$ = 3.5, $\sigma$ = 1.2)? Bestimmen Sie das 99%ige Konfidenzintervall und treffen Sie basiered auf Ihrem Ergebnis eine Signifikanzentscheidung.

<details><summary>Lösung</summary>

**Hypothesengenerierung:**

$\alpha$ = .05 

$H_0$: Der Mittelwert der Extraversionswerte der Psychologie-Studierenden $\mu_1$ unterscheidet sich nicht von der Gesamtbevölkerung $\mu_0$.

$H_0$: $\mu_0$ $=$ $\mu_1$

$H_1$: Die Mittelwert der Extraversionswerte der Psychologie-Studierenden $\mu_1$ unterscheidet sich von der Gesamtbevölkerung $\mu_0$.

$H_1$: $\mu_0$ $\neq$ $\mu_1$


```r
## Erste Schritte

anyNA(fb23$extra) #keine NA's vorhanden
```

```
## [1] FALSE
```

```r
mean_extra_pop <- 3.5 #Mittelwert der Population

sd_extra_pop <- 1.2 #empirische Standardabweichung der Population

se_extra <- sd_extra_pop / sqrt(nrow(fb23)) #Standardfehler

mean_extra_smpl <- mean(fb23$extra) #Mittelwert der Stichprobe

## Konfidenzintervall

z_quantil_zweiseitig <- qnorm(p = 1-(.01/2), mean = 0, sd = 1)

upper <- mean_extra_smpl+((z_quantil_zweiseitig*sd_extra_pop)/sqrt(nrow(fb23)))

lower <- mean_extra_smpl-((z_quantil_zweiseitig*sd_extra_pop)/sqrt(nrow(fb23)))

# 3.5 lieg nicht in dem Bereich zwischen Upper und lower -> Signifikanzentscheidung kann schon getroffen werden (Mittelwert unterscheidet sich!)
  
## zusätzlich mögliche Signifikanzentscheidung

z_extra <- (mean_extra_smpl - mean_extra_pop) / se_extra #empirischer z-Wert

z_krit <- qnorm(1 - 0.05/2) #kritischer z-Wert, zweiseitig

abs(z_extra) > z_krit #signifikant
```

```
## [1] TRUE
```

```r
2 * pnorm(z_extra) #p < .05, signifikant
```

```
## [1] 0.009741298
```


</details>

**3.2** Sind die Offenheits-Werte (`offen`) der Psychologie-Studierenden (1. Semester) größer als die Offenheits-Werte der Gesamtbevölkerung ($\mu$ = 3.6)? Bestimmen Sie den p-Wert und treffen Sie basierend auf Ihrem Ergebnis eine Signifikanzentscheidung.

<details><summary>Lösung</summary>

**Hypothesengenerierung:**

$\alpha$ = .05 

$H_0$: Die durchschnittlichen Offenheits-Werte der Psychologie-Studierenden $\mu_1$ sind geringer oder gleich gross wie die Werte der Gesamtbevölkerung $\mu_0$.

$H_0$: $\mu_0$ $\geq$ $\mu_1$

$H_1$: Die durchschnittlichen Offenheits-Werte der Psychologie-Studierenden $\mu_1$ sind groesser als die Werte der Gesamtbevölkerung $\mu_0$.

$H_1$: $\mu_0$ $<$ $\mu_1$


```r
t.test(fb23$offen, mu = 3.6, alternative = "greater")
```

```
## 
## 	One Sample t-test
## 
## data:  fb23$offen
## t = 2.0257, df = 178, p-value = 0.02214
## alternative hypothesis: true mean is greater than 3.6
## 95 percent confidence interval:
##  3.625769      Inf
## sample estimates:
## mean of x 
##  3.740223
```



Der p-Wert beträgt 0.0221 < .05, somit kann mit einer Irrtumswahrscheinlichkeit von 5% die $H_0$ verworfen werden. Die Psychologie-Studierenden haben höhere Offenheits-Werte im Vergleich zur Gesamtbevölkerung.


</details>

**3.3** Überprüfen Sie Ihre Entscheidung aus **3.2** erneut, indem sie händisch ihren empirischen t-Wert ermitteln und mit dem entsprechenden kritischen t-Wert vergleichen.

<details><summary>Lösung</summary>


```r
t_emp <- (mean(fb23$offen)-3.6) / (sd(fb23$offen)/sqrt(nrow(fb23))) # (Mittelwert Stichprobe - Mittelwert Population) / Standardfehler des Mittelwerts
t_krit <- qt(0.05, df = (nrow(fb23)-1), lower.tail = FALSE) # Bei "Default" des vorigen Tests gehen wir von 5% beim Alphafehler aus - Alternativhypothese Größer, daher lower.tail = F
t_emp > t_krit #Vergleich
```

```
## [1] TRUE
```

Da der empirische Wert größer als der kritische Wert ist, können wir erneut bestätigen, dass die H0 verworfen und die H1 angenommen werden kann!

</details>

**3.4** Zeigen die Psychologie-Studierenden (1. Semester) höhere Werte auf der Verträglichkeits-Skala (`vertr`) als die Grundgesamtheit ($\mu$ = 3.9)? Bestimmen Sie die Effektgröße und ordnen sie diese ein.



<details><summary>Lösung</summary>

**Effektgröße:**


```r
mean_vertr <- mean(fb23$vertr, na.rm = TRUE) #Mittlere Verträglichkeit der Stichprobe

sd_vertr <- sd(fb23$vertr, na.rm = TRUE) #Stichproben SD (Populationsschätzer)

mean_pop_vertr <- 3.9 #Mittlere Verträglichkeit der Grundgesamtheit

d3 <- abs((mean_vertr - mean_pop_vertr) / sd_vertr) #abs(), da Betrag
d3
```

```
## [1] 0.5312277
```

Die Effektgröße ist mit 0.53 nach Cohen (1988) als mittelstark einzuordnen.


</details>



## Aufgabe 4

Folgende Aufgaben haben ein erhöhtes Schwierigkeitsniveau.
Nehmen Sie für die weiteren Aufgaben den Datensatz `fb23` als Grundgesamtheit (Population) an.

**4.1** Sie haben eine Stichprobe mit $n$ = 42 aus dem Datensatz gezogen. Der mittlere Gewissenhaftigkeits-Wert dieser Stichprobe beträgt $\mu$ = 3.6. Unterscheiden sich die Psychologie-Studierenden (1. Semester) der Stichprobe in ihrem Wert (`gewis`) von der Grundgesamtheit?
Berechnen Sie den angemessenen Test und bestimmen Sie das 95%ige Konfidenzintervall.

<details><summary>Lösung</summary>

**Hypothesengenerierung:**

$\alpha$ = .05 

$H_0$: Die durchschnittliche Gewissenhaftigkeit der Psychologie-Studierenden aus der Stichprobe $\mu_1$ unterscheidet sich nicht von der Gewissenhaftigkeit der Gesamtbevölkerung (Datensatz) $\mu_0$.

$H_0$: $\mu_0$ $=$ $\mu_1$

$H_1$: Die durchschnittliche Gewissenhaftigkeit der Psychologie-Studierenden aus der Stichprobe $\mu_1$ unterscheidet sich von der Gewissenhaftigkeit der Gesamtbevölkerung (Datensatz) $\mu_0$.

$H_1$: $\mu_0$ $\neq$ $\mu_1$

**z-Test:**

Wir arbeiten für diesen Aufgabenblock unter der Annahme, dass uns die Daten der gesamten Population, in unserem Fall aller Psychologie 1. Semester, in Form des Datensatzes `fb23` vorliegen. Daher ist der angemessene Test ist in diesem Fall der z-Test.

Zuvor überprüfen wir noch ob es fehlende Werte auf der Variable `gewis` gibt. Sollte dies nicht der Fall sein können wir uns das Argument `na.rm = TRUE` sowie die Funktion `na.omit()` später an mehreren Stellen in der Rechnung sparen.


```r
anyNA(fb23$gewis) #keine NA's vorhanden
```

```
## [1] FALSE
```

Nun zur eigentlichen Rechnung:


```r
mean_gewis_pop <- mean(fb23$gewis) #Mittelwert der Population

mean_gewis_smpl1 <- 3.6 #Mittelwert der Stichprobe
```

Weiterhin brauchen wir den Standardfehler. Dieser erechnet sich bei einem z-Test über die Standardabweichung der Population.


```r
sd_gewis_pop <- sd(fb23$gewis) * sqrt((nrow(fb23) - 1) / nrow(fb23)) #empirische Standardabweichung der Population

se_gewis <- sd_gewis_pop / sqrt(nrow(fb23)) #Standardfehler
```

Da die `sd()`-Funktion von Natur aus die geschätzte Standardabweichung berechnet, wir aber die empirische Standardabweichung benötigen müssen wir diese noch mit $\sqrt\frac{n-1}{n}$ verrechnen.

Weiter geht es mit:


```r
z_gewis1 <- (mean_gewis_smpl1 - mean_gewis_pop) / se_gewis #empirischer z-Wert

z_krit <- qnorm(1 - 0.05/2) #kritischer z-Wert, zweiseitig
```

Der Abgleich des empirischen z-Werts mit dem kritischen Wert ergibt:


```r
abs(z_gewis1) > z_krit #nicht signifikant
```

```
## [1] FALSE
```

Zusätzlich lässt sich auch noch der p-Wert über folgende Formel berechnen:


```r
2 * pnorm(z_gewis1, lower.tail = FALSE) #p > .05, nicht signifikant
```

```
## [1] 0.2253066
```

**Konfidenzintervall:**


```r
upper_conf_gewis <- mean_gewis_smpl1 + z_krit * se_gewis
lower_conf_gewis <- mean_gewis_smpl1 - z_krit * se_gewis

conf_int <- c(lower_conf_gewis, upper_conf_gewis)
conf_int # Mittelwert der Population innerhalb des Intervalls, H0 kann nicht verworfen werden
```

```
## [1] 3.488025 3.711975
```

Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ nicht verworfen werden. Die Psychologie-Studierenden der Stichprobe unterscheiden sich nicht in ihrer Gewissenhaftigkeit von der Grundgesamtheit (Datensatz). 
Das 95%-ige Konfidenzintervall liegt zwischen 3.49 und 3.71.


</details>


**4.2** Ziehen Sie nun selbst eine Stichprobe mit $n$ = 31 aus dem Datensatz. Nutzen Sie hierfür die `set.seed(1234)`-Funktion. Versuchen Sie zunächst selbst mit Hilfe der `sample()`-Funktion eine Stichprobe ($n$ = 31) zu ziehen. Falls Sie hier von alleine nicht weiterkommen, ist das kein Problem. Nutzen Sie dann für die weitere Aufgabenstellung folgenden Code:

<details><summary>Code</summary>


```r
set.seed(1234) #erlaubt Reproduzierbarkeit
fb23_sample <- fb23[sample(nrow(fb23), size = 31), ] #zieht eine Stichprobe mit n = 31
```

</details>

Untersuchen Sie erneut, ob sich die Stichprobe von der Grundgesamtheit (Population) in ihrer Gewissenhaftigkeit unterscheidet. Berechnen Sie den angemessenen Test.

<details><summary>Lösung</summary>

**Hypothesengenerierung:**

$\alpha$ = .05 

$H_0$: Die durchschnittliche Gewissenhaftigkeit der Psychologie-Studierenden aus der Stichprobe $\mu_1$ unterscheidet sich nicht von der Gewissenhaftigkeit der Gesamtbevölkerung (Datensatz) $\mu_0$.

$H_0$: $\mu_0$ $=$ $\mu_1$

$H_1$: Die durchschnittliche Gewissenhaftigkeit der Psychologie-Studierenden aus der Stichprobe $\mu_1$ unterscheidet sich von der Gewissenhaftigkeit der Gesamtbevölkerung (Datensatz) $\mu_0$.

$H_1$: $\mu_0$ $\neq$ $\mu_1$

**Stichprobenziehung:**


```r
set.seed(1234) #erlaubt Reproduzierbarkeit
fb23_sample <- fb23[sample(nrow(fb23), size = 31), ] #zieht eine Stichprobe mit n = 31
```

Mit der `set.seed()`-Funktion haben wir uns bereits im vorherigen Kapitel zu [Verteilungen](/lehre/statistik-i/verteilungen/) beschäftigt. Sie erlaubt uns die Ergebnisse eines Zufallsvorgangs konstant zu halten.
Die `sample()`-Funktion nimmt als erstes Argument **keinen** Datensatz entgegen sondern ausschließlich einen Vektor. Daher nutzen wir die Funktion um uns wahllos 31 Zahlen zwischen 1 und `nrow(fb23)` auszugeben. Der äußere Teil gibt uns dann die Zeilen (Personen) die mit den besagten 31 Zahlen übereinstimmen wieder. 

**z-Test:**

Nachdem wir unsere Stichprobe gezogen haben ist die Berechnung analog zu Aufgabe 4.1. Für eine detailierte Beschreibung der Rechenschritte verweisen wir Sie auf die Lösung der vorherigen Aufgabe.


```r
anyNA(fb23$gewis) #keine NA's vorhanden
```

```
## [1] FALSE
```

```r
mean_gewis_pop <- mean(fb23$gewis) #Mittelwert der Population

sd_gewis_pop <- sd(fb23$gewis) * sqrt((nrow(fb23) - 1) / nrow(fb23)) #empirische Standardabweichung der Population

se_gewis <- sd_gewis_pop / sqrt(nrow(fb23)) #Standardfehler

mean_gewis_smpl2 <- mean(fb23_sample$gewis) #Mittelwert der Stichprobe

z_gewis2 <- (mean_gewis_smpl2 - mean_gewis_pop) / se_gewis #empirischer z-Wert

z_krit <- qnorm(1 - 0.05/2) #kritischer z-Wert, zweiseitig

abs(z_gewis2) > z_krit #signifikant
```

```
## [1] TRUE
```

```r
2 * pnorm(z_gewis2) #p < .05, signifikant
```

```
## [1] 0.02563394
```

Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ verworfen werden. Die Psychologie-Studierenden der Stichprobe unterscheiden sich in ihrer Gewissenhaftigkeit von der Grundgesamtheit (Datensatz). 




</details>
