---
title: "Tests und Konfidenzintervalle - Lösungen" 
type: post
date: '2020-12-11' 
slug: tests-konfidenzintervalle-loesungen
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [nehler, scheppa-lahyani, vogler, pommeranz] 
lastmod: '2024-03-18'
featured: no
banner:
  image: "/header/angel_of_the_north.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/1240882)"
projects: []
expiryDate: ''

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/tests-konfidenzintervalle
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/tests-konfidenzintervalle-aufgaben

_build:
  list: never
reading_time: false
share: false
output:
  html_document:
    keep_md: true
---



### Vorbereitung

> Laden Sie zunächst den Datensatz `fb23` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb23.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/tests-konfidenzintervalle/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

<details><summary>Lösung</summary>


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
fb23$ru_pre <-  fb23[, c("mdbf3_pre_r", "mdbf6_pre", 
                         "mdbf9_pre_r", "mdbf12_pre")] |> rowMeans()

# z-Standardisierung
fb23$ru_pre_zstd <- scale(fb23$ru_pre, center = TRUE, scale = TRUE)
```

Prüfen Sie zur Sicherheit, ob alles funktioniert hat:


```r
dim(fb23)
```

```
## [1] 179  48
```

Der Datensatz besteht aus 179 Zeilen (Beobachtungen) und mindestens (unter Einbeziehung der Ergänzungen) 48 Spalten (Variablen). Falls Sie bereits weitere eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.

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



**2.3** Unterscheidet sich die Lebenszufriedenheit der Psychologie-Studierenden von der Lebenszufriedenheit der Gesamtbevölkerung (wie bereits geschrieben $\mu$ = 4.4)? Bestimmen Sie das 99%ige Konfidenzintervall.

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

**3.1** Unterscheidet sich der Mittelwert der Extraversionswerte (`extra`) der Studierenden der Psychologie (1. Semester) von dem der Gesamtbevölkerung ($\mu$ = 3.5, $\sigma$ = 1.2)? Bestimmen Sie den p-Wert und treffen Sie basiered auf Ihrem Ergebnis eine Signifikanzentscheidung.

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

mean_extra_pop <- 3.5 #Mittelwert der Population

sd_extra_pop <- 1.2 #empirische Standardabweichung der Population

se_extra <- sd_extra_pop / sqrt(nrow(fb23)) #Standardfehler

mean_extra_smpl <- mean(fb23$extra) #Mittelwert der Stichprobe
```
**z-Wert bestimmen**

```r
z_extra <- (mean_extra_smpl - mean_extra_pop) / se_extra #empirischer z-Wert
```
**p-Wert bestimmen**

```r
2 * pnorm(z_extra) #p < .05, signifikant
```
**optionale z-Wert-Prüfung**

```r
z_krit <- qnorm(1 - 0.05/2) #kritischer z-Wert, zweiseitig

abs(z_extra) > z_krit #signifikant, kann als zusätzliche Überprüfung genutzt werden
```

</details>

**3.2** Sind die Offenheits-Werte (`offen`) der Psychologie-Studierenden (1. Semester) größer als die Offenheits-Werte der Gesamtbevölkerung ($\mu$ = 3.6)? Bestimmen Sie den p-Wert und treffen Sie basierend auf Ihrem Ergebnis eine Signifikanzentscheidung.

<details><summary>Lösung</summary>

**Hypothesengenerierung:**

$\alpha$ = .05 

$H_0$: Die durchschnittlichen Offenheits-Werte der Psychologie-Studierenden $\mu_1$ sind geringer oder gleich groß wie die Werte der Gesamtbevölkerung $\mu_0$.

$H_0$: $\mu_0$ $\geq$ $\mu_1$

$H_1$: Die durchschnittlichen Offenheits-Werte der Psychologie-Studierenden $\mu_1$ sind größer als die Werte der Gesamtbevölkerung $\mu_0$.

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

**3.4** Zeigen die Psychologie-Studierenden (1. Semester) höhere Werte auf der Verträglichkeits-Skala (`vertr`) als die Grundgesamtheit ($\mu$ = 3.3)? Bestimmen Sie das 99%-Konfidenzintervall sowie die Effektgröße und ordnen sie diese ein.



<details><summary>Lösung</summary>

**Hypothesengenerierung:**

$\alpha$ = .01 

$H_0$: Die durchschnittlichen Verträglichkeits-Werte der Psychologie-Studierenden $\mu_1$ sind geringer oder gleich groß wie die Werte der Gesamtbevölkerung $\mu_0$.

$H_0$: $\mu_0$ $\geq$ $\mu_1$

$H_1$: Die durchschnittlichen Verträglichkeits-Werte der Psychologie-Studierenden $\mu_1$ sind größer als die Werte der Gesamtbevölkerung $\mu_0$.

$H_1$: $\mu_0$ $<$ $\mu_1$


```r
anyNA(fb23$vertr) # NAs vorhanden !

mean_vertr <- mean(fb23$vertr, na.rm = TRUE) #Mittlere Verträglichkeit der Stichprobe

sd_vertr <- sd(fb23$vertr, na.rm = TRUE) #Stichproben SD (Populationsschätzer)

mean_pop_vertr <- 3.3 #Mittlere Verträglichkeit der Grundgesamtheit
```
**Konfidenzintervall**

```r
t_quantil_einseitig_vertr <- qt(0.01, df = length(na.omit(fb23$vertr))-1, lower.tail = FALSE)

t_lower_vertr <- mean_vertr - t_quantil_einseitig_vertr * (sd_vertr / sqrt(length(na.omit(fb23$vertr)))) # Formel für N muss angepasst werden an NAs -> Wir nehmen die Länge des Vektors der Variable ohne NA statt nrow! Siehe Deskriptivstatistik für Intervallskalen
```
**Effektgröße**

```r
d3 <- abs((mean_vertr - mean_pop_vertr) / sd_vertr) #abs(), da Betrag
d3
```

```
## [1] 0.198954
```

Da der Mittelwert der Population von 3.3 kleiner ist als das untere Konfidenzintervall mit 3.319 kann die $H_0$ verworfen werden.
Die Effektgröße ist mit 0.2 nach Cohen (1988) als klein einzuordnen.


</details>





## Aufgabe 4

Folgende Aufgaben haben ein erhöhtes Schwierigkeitsniveau.
Nehmen Sie für die weiteren Aufgaben den Datensatz `fb23` als Grundgesamtheit (Population) an.

**4.1** Sie haben eine Stichprobe mit $n$ = 42 aus dem Datensatz gezogen. Die mittlere Gewissenhaftigkeit dieser Stichprobe beträgt $\mu$ = 3.6. Unterscheiden sich die Psychologie-Studierenden (1. Semester) der Stichprobe in ihrer Gewissenhaftigkeit (`gewis`) von der Grundgesamtheit?
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

se_gewis <- sd_gewis_pop / sqrt(42) #Standardfehler
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
## [1] 0.5569719
```

**Konfidenzintervall:**


```r
upper_conf_gewis <- mean_gewis_smpl1 + z_krit * se_gewis
lower_conf_gewis <- mean_gewis_smpl1 - z_krit * se_gewis

conf_int <- c(lower_conf_gewis, upper_conf_gewis)
conf_int
```

```
## [1] 3.368834 3.831166
```

Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ nicht verworfen werden. Die Psychologie-Studierenden der Stichprobe unterscheiden sich nicht in ihrer Gewissenhaftigkeit von der Grundgesamtheit (Datensatz). 
Das 95%-ige Konfidenzintervall liegt zwischen 3.37 und 3.83.


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

se_gewis <- sd_gewis_pop / sqrt(nrow(fb23_sample)) #Standardfehler

mean_gewis_smpl2 <- mean(fb23_sample$gewis) #Mittelwert der Stichprobe

z_gewis2 <- (mean_gewis_smpl2 - mean_gewis_pop) / se_gewis #empirischer z-Wert

z_krit <- qnorm(1 - 0.05/2) #kritischer z-Wert, zweiseitig

abs(z_gewis2) > z_krit #nicht signifikant
```

```
## [1] FALSE
```

```r
2 * pnorm(z_gewis2) #p > .05, nicht signifikant
```

```
## [1] 0.3530255
```

Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ **nicht** verworfen werden. Die Psychologie-Studierenden der Stichprobe unterscheiden sich in ihrer Gewissenhaftigkeit von der Grundgesamtheit (Datensatz). 

</details>
