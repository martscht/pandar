---
title: Tests und Konfidenzintervalle - Lösungen
type: post
date: '2020-12-11'
slug: tests-konfidenzintervalle-loesungen
categories: Statistik I Übungen
tags: []
subtitle: ''
summary: ''
authors:
- nehler
- scheppa-lahyani
- vogler
- pommeranz
lastmod: '2025-05-13'
featured: no
banner:
  image: /header/angel_of_the_north.jpg
  caption: '[Courtesy of pxhere](https://pxhere.com/de/photo/1240882)'
projects: []
expiryDate: ''
links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-i/tests-konfidenzintervalle
- icon_pack: fas
  icon: pen-to-square
  name: Übungen
  url: /lehre/statistik-i/tests-konfidenzintervalle-uebungen
_build:
  list: never
reading_time: no
share: no
output:
  html_document:
    keep_md: yes
private: 'true'
---



### Vorbereitung

> Laden Sie zunächst den Datensatz `fb24` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb24.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/tests-konfidenzintervalle/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

<details><summary>Lösung</summary>


```r
#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb24.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb24$hand_factor <- factor(fb24$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb24$fach <- factor(fb24$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb24$ziel <- factor(fb24$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb24$wohnen <- factor(fb24$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

# Rekodierung invertierter Items
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf11_r <- -1 * (fb24$mdbf11 - 5)
fb24$mdbf3_r <-  -1 * (fb24$mdbf3 - 5)
fb24$mdbf9_r <-  -1 * (fb24$mdbf9 - 5)

# Berechnung von Skalenwerten
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb24$ru_pre <-  fb24[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb24$ru_pre_zstd <- scale(fb24$ru_pre, center = TRUE, scale = TRUE)
```

Prüfen Sie zur Sicherheit, ob alles funktioniert hat:


```r
dim(fb24)
```

```
## [1] 192  50
```

Der Datensatz besteht aus 192 Zeilen (Beobachtungen) und mindestens (unter Einbeziehung der Ergänzungen) 50 Spalten (Variablen). Falls Sie bereits weitere eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.

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
mean_lz <- mean(fb24$lz, na.rm = TRUE) #Mittlere Lebenszufriedenheit
mean_lz
```

```
## [1] 4.919895
```

```r
sd_lz <- sd(fb24$lz, na.rm = TRUE) #Standardabweichung (Populationsschätzer)
sd_lz
```

```
## [1] 1.149701
```

```r
n_lz <- length(na.omit(fb24$lz)) #Stichprobengröße

se_lz <- sd_lz / sqrt(n_lz) #Standardfehler
se_lz
```

```
## [1] 0.08318945
```

* Der Mittelwert der Lebenszufriedenheit in der Stichprobe liegt bei 4.92.
* Die Standardabweichung der Lebenszufriedenheit beträgt 1.15.
* Der Standardfehler des Mittelwerts der Lebenszufriedenheit wird als 0.083 geschätzt.

**Variante 2**:


```r
describe(fb24$lz) #Funktion aus Paket "psych"
```

```
##    vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 191 4.92 1.15      5    4.98 1.19   2   7     5 -0.43    -0.41 0.08
```

</details>



**2.2** Sind die Lebenszufriedenheitswerte normalverteilt? Veranschaulichen Sie dies mit einer geeigneten optischen Prüfung. Benutzen Sie außerdem die `qqPlot`-Funktion aus dem `car`-Paket. Wann kann man in diesem Fall von einer Normalverteilung ausgehen?

<details><summary>Lösung</summary>


```r
#Histogramm zur Veranschaulichung der Normalverteilung
hist(fb24$lz, xlim = c(1,7), main = "Histogramm", xlab = "Score", ylab = "Dichte", freq = FALSE)
curve(dnorm(x, mean = mean(fb24$lz, na.rm = TRUE), sd = sd(fb24$lz, na.rm = TRUE)), add = TRUE)
```

![](/tests-konfidenzintervalle-loesungen_files/unnamed-chunk-7-1.png)<!-- -->

```r
#geeigneter Plot: QQ-Plot. Alle Punkte sollten auf einer Linie liegen.
qqnorm(fb24$lz)
qqline(fb24$lz)
```

![](/tests-konfidenzintervalle-loesungen_files/unnamed-chunk-7-2.png)<!-- -->

```r
#Die qqPlot-Funktion zeichnet ein Konfidenzintervall in den QQ-Plot. Dies macht es für Betrachter:innen einfacher zu entscheiden, ob alle Punkte in etwa auf einer Linie liegen. Die Punkte sollten nicht außerhalb der blauen Linien liegen.
qqPlot(fb24$lz)
```

![](/tests-konfidenzintervalle-loesungen_files/unnamed-chunk-7-3.png)<!-- -->

```
## [1]  18 181
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
t.test(fb24$lz, mu=4.4)
```

```
## 
## 	One Sample t-test
## 
## data:  fb24$lz
## t = 6.2495, df = 190, p-value = 2.647e-09
## alternative hypothesis: true mean is not equal to 4.4
## 95 percent confidence interval:
##  4.755802 5.083989
## sample estimates:
## mean of x 
##  4.919895
```

```r
t.test(fb24$lz, mu=4.4, conf.level = 0.99) #Default ist 95%, deshalb erhöhen wir auf 99%
```

```
## 
## 	One Sample t-test
## 
## data:  fb24$lz
## t = 6.2495, df = 190, p-value = 2.647e-09
## alternative hypothesis: true mean is not equal to 4.4
## 99 percent confidence interval:
##  4.70344 5.13635
## sample estimates:
## mean of x 
##  4.919895
```

Zuvor ist uns aufgefallen, dass die Lebenszufriedenheit nicht normalverteilt ist.
Außerdem haben wir gelernt das ab $n$ > 30 der zentrale Grenzwertsatz greift.
Es gibt aber auch noch die Möglichkeit auf einen Test mit weniger strengen Voraussetzungen zurückzugreifen. Dafür büßen wir etwas Power ($1 - \beta$) ein. Das heißt, wenn ein Effekt vorliegt ist es schwerer (unwahrscheinlicher) diesen nachzuweisen.
Der Ein-Stichproben Wilcoxon Tests der folgt wird **nicht** in der Vorlesung behandelt und ist auch **nicht** klausurrelevant.


```r
wilcox.test(fb24$lz, mu = 4.4, conf.level = 0.99) #gleiche Argumente wie beim t-Test
```

```
## 
## 	Wilcoxon signed rank test with continuity correction
## 
## data:  fb24$lz
## V = 11503, p-value = 1.074e-07
## alternative hypothesis: true location is not equal to 4.4
```

Auch dieser Test fällt signifikant aus. Daraus können wir schließen:

Mit einer Irrtumswahrscheinlichkeit von 1% kann die $H_0$ verworfen werden. Die Psychologie-Studierenden unterscheiden sich in ihrer Lebenszufriedenheit von der Gesamtbevölkerung. 

</details>

## Aufgabe 3

**3.1** Unterscheidet sich der Mittelwert der Extraversionswerte (`extra`) der Studierenden der Psychologie (1. Semester) von dem der Gesamtbevölkerung ($\mu$ = 3.5, $\sigma$ = 1.2)? Bestimmen Sie den p-Wert und treffen Sie basierend auf Ihrem Ergebnis eine Signifikanzentscheidung.

<details><summary>Lösung</summary>

**Hypothesengenerierung:**

$\alpha$ = .05 

$H_0$: Der Mittelwert der Extraversionswerte der Psychologie-Studierenden $\mu_1$ unterscheidet sich nicht von der Gesamtbevölkerung $\mu_0$.

$H_0$: $\mu_0$ $=$ $\mu_1$

$H_1$: Die Mittelwert der Extraversionswerte der Psychologie-Studierenden $\mu_1$ unterscheidet sich von der Gesamtbevölkerung $\mu_0$.

$H_1$: $\mu_0$ $\neq$ $\mu_1$


```r
## Erste Schritte

anyNA(fb24$extra) #NA's vorhanden

mean_extra_pop <- 3.5 #Mittelwert der Population

sd_extra_pop <- 1.2 #empirische Standardabweichung der Population

se_extra <- sd_extra_pop / sqrt(length(na.omit(fb24$extra))) #Standardfehler

mean_extra_smpl <- mean(fb24$extra, na.rm = TRUE) #Mittelwert der Stichprobe
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
t.test(fb24$offen, mu = 3.6, alternative = "greater")
```

```
## 
## 	One Sample t-test
## 
## data:  fb24$offen
## t = 2.9557, df = 190, p-value = 0.001757
## alternative hypothesis: true mean is greater than 3.6
## 95 percent confidence interval:
##  3.692078      Inf
## sample estimates:
## mean of x 
##  3.808901
```



Der p-Wert beträgt 0.0018 < .05, somit kann mit einer Irrtumswahrscheinlichkeit von 5% die $H_0$ verworfen werden. Die Psychologie-Studierenden haben höhere Offenheits-Werte im Vergleich zur Gesamtbevölkerung.


</details>

**3.3** Überprüfen Sie Ihre Entscheidung aus **3.2** erneut, indem sie händisch ihren empirischen t-Wert ermitteln und mit dem entsprechenden kritischen t-Wert vergleichen.

<details><summary>Lösung</summary>


```r
t_emp <- (mean(fb24$offen, na.rm = TRUE)-3.6) / (sd(fb24$offen, na.rm = TRUE)/sqrt(length(na.omit(fb24$offen)))) # (Mittelwert Stichprobe - Mittelwert Population) / Standardfehler des Mittelwerts
t_krit <- qt(0.05, df = (length(na.omit(fb24$offen))-1), lower.tail = FALSE) # Bei "Default" des vorigen Tests gehen wir von 5% beim Alphafehler aus - Alternativhypothese Größer, daher lower.tail = F
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
anyNA(fb24$vertr) # NAs vorhanden !

mean_vertr <- mean(fb24$vertr, na.rm = TRUE) #Mittlere Verträglichkeit der Stichprobe

sd_vertr <- sd(fb24$vertr, na.rm = TRUE) #Stichproben SD (Populationsschätzer)

mean_pop_vertr <- 3.3 #Mittlere Verträglichkeit der Grundgesamtheit
```
**Konfidenzintervall**

```r
t_quantil_einseitig_vertr <- qt(0.01, df = length(na.omit(fb24$vertr))-1, lower.tail = FALSE)

t_lower_vertr <- mean_vertr - t_quantil_einseitig_vertr * (sd_vertr / sqrt(length(na.omit(fb24$vertr)))) # Formel für N muss angepasst werden an NAs -> Wir nehmen die Länge des Vektors der Variable ohne NA statt nrow! Siehe Deskriptivstatistik für Intervallskalen
```
**Effektgröße**

```r
d3 <- abs((mean_vertr - mean_pop_vertr) / sd_vertr) #abs(), da Betrag
d3
```

```
## [1] 0.2245748
```

Da der Mittelwert der Population von 3.3 kleiner ist als das untere Konfidenzintervall mit 3.345 kann die $H_0$ verworfen werden.
Die Effektgröße ist mit 0.22 nach Cohen (1988) als klein einzuordnen.


</details>





## Aufgabe 4

Folgende Aufgaben haben ein erhöhtes Schwierigkeitsniveau.
Nehmen Sie für die weiteren Aufgaben den Datensatz `fb24` als Grundgesamtheit (Population) an.

**4.1** Sie haben eine Stichprobe mit $n$ = 42 aus dem Datensatz gezogen. Die mittlere Gewissenhaftigkeit dieser Stichprobe beträgt $\bar{x}$ = 3.6. Unterscheiden sich die Psychologie-Studierenden (1. Semester) der Stichprobe in ihrer Gewissenhaftigkeit (`gewis`) von der Grundgesamtheit?
Berechnen Sie den angemessenen Test und bestimmen Sie das 95%ige Konfidenzintervall.

<details><summary>Lösung</summary>

**Hypothesengenerierung:**

$\alpha$ = .05 

$H_0$: Die durchschnittliche Gewissenhaftigkeit der Psychologie-Studierenden aus der Stichprobe $\mu_1$ unterscheidet sich nicht von der Gewissenhaftigkeit der Gesamtbevölkerung (Datensatz) $\mu_0$.

$H_0$: $\mu_0$ $=$ $\mu_1$

$H_1$: Die durchschnittliche Gewissenhaftigkeit der Psychologie-Studierenden aus der Stichprobe $\mu_1$ unterscheidet sich von der Gewissenhaftigkeit der Gesamtbevölkerung (Datensatz) $\mu_0$.

$H_1$: $\mu_0$ $\neq$ $\mu_1$

**z-Test:**

Wir arbeiten für diesen Aufgabenblock unter der Annahme, dass uns die Daten der gesamten Population, in unserem Fall aller Psychologie 1. Semester, in Form des Datensatzes `fb24` vorliegen. Daher ist der angemessene Test ist in diesem Fall der z-Test.

Zuvor überprüfen wir noch ob es fehlende Werte auf der Variable `gewis` gibt. Sollte dies nicht der Fall sein können wir uns das Argument `na.rm = TRUE` sowie die Funktion `na.omit()` später an mehreren Stellen in der Rechnung sparen.


```r
anyNA(fb24$gewis) #NA's vorhanden
```

```
## [1] TRUE
```

Nun zur eigentlichen Rechnung:


```r
mean_gewis_pop <- mean(fb24$gewis, na.rm = TRUE) #Mittelwert der Population

mean_gewis_smpl1 <- 3.6 #Mittelwert der Stichprobe
```

Weiterhin brauchen wir den Standardfehler. Dieser erechnet sich bei einem z-Test über die Standardabweichung der Population.

Da unser Datensatz nun die Population ist, können wir einfach die Standardabweichung der Werte im Datensatz bestimmen. Wir müssen hier aber nicht schätzen, da wir davon ausgehen, dass die ganze Population im Datensatz vorliegt. Deshalb muss die `sd()`-Funktion, die von Natur aus die geschätzte Standardabweichung berechnet, noch korrigiert werden mit dem Faktor $\sqrt\frac{n-1}{n}$. Anschließend kann der Standardfehler des Mittelwerts berechnet werden.


```r
sd_gewis_pop <- sd(fb24$gewis, na.rm = TRUE) * sqrt((length(na.omit(fb24$gewis)) - 1) / length(na.omit(fb24$gewis))) #empirische Standardabweichung der Population

se_gewis <- sd_gewis_pop / sqrt(42) #Standardfehler des Mittelwerts 
```


Die Teststatistik bestimmt sich mit:


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

Alternativ lässt sich auch noch der p-Wert über folgende Formel berechnen:


```r
2 * pnorm(z_gewis1, lower.tail = FALSE) #p Wert
```

```
## [1] 0.4214418
```

Da dieser größer ist als unser $alpha = 0.05$ können wir die Nullhypothese nicht verwerfen.

**Konfidenzintervall:**


```r
upper_conf_gewis <- mean_gewis_smpl1 + z_krit * se_gewis
lower_conf_gewis <- mean_gewis_smpl1 - z_krit * se_gewis

conf_int <- c(lower_conf_gewis, upper_conf_gewis)
conf_int
```

```
## [1] 3.330671 3.869329
```

Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ nicht verworfen werden. Die Psychologie-Studierenden der Stichprobe unterscheiden sich nicht in ihrer Gewissenhaftigkeit von der Grundgesamtheit (Datensatz). 
Das 95%-ige Konfidenzintervall liegt zwischen 3.33 und 3.87.


</details>


**4.2** Ziehen Sie nun selbst eine Stichprobe mit $n$ = 31 aus dem Datensatz (aber nur aus den Personen, die auch Beobachtungen für die Variable `gewis` haben. Nutzen Sie hierfür die `set.seed(1234)`-Funktion. Versuchen Sie zunächst selbst mit Hilfe der `sample()`-Funktion eine Stichprobe ($n$ = 31) zu ziehen. Falls Sie hier von alleine nicht weiterkommen, ist das kein Problem. Nutzen Sie dann für die weitere Aufgabenstellung folgenden Code:

<details><summary>Code</summary>


```r
fb24_red <- fb24[!is.na(fb24$gewis),] #NA's entfernen
set.seed(1234) #erlaubt Reproduzierbarkeit
fb24_sample <- fb24_red[sample(nrow(fb24_red), size = 31), ] #zieht eine Stichprobe mit n = 31
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
fb24_red <- fb24[!is.na(fb24$gewis),] #NA's entfernen

set.seed(1234) #erlaubt Reproduzierbarkeit
fb24_sample <- fb24_red[sample(nrow(fb24_red), size = 31), ] #zieht eine Stichprobe mit n = 31
```

Mit der `set.seed()`-Funktion haben wir uns bereits im vorherigen Kapitel zu [Verteilungen](/lehre/statistik-i/verteilungen/) beschäftigt. Sie erlaubt uns die Ergebnisse eines Zufallsvorgangs konstant zu halten.
Die `sample()`-Funktion nimmt als erstes Argument **keinen** Datensatz entgegen sondern ausschließlich einen Vektor. Daher nutzen wir die Funktion um uns wahllos 31 Zahlen zwischen 1 und `nrow(fb24_red)` auszugeben. Der äußere Teil gibt uns dann die Zeilen (Personen) die mit den besagten 31 Zahlen übereinstimmen wieder. 

**z-Test:**

Nachdem wir unsere Stichprobe gezogen haben ist die Berechnung analog zu Aufgabe 4.1. Für eine detailierte Beschreibung der Rechenschritte verweisen wir Sie auf die Lösung der vorherigen Aufgabe. Es ist allerdings wichtig zu erwähnen, das wir hier nicht mit fehlenden Werten arbeiten müssen, weshalb wir die Anzahl der genutzten Funktionen und Argumente reduzieren können, indem wir die Behandlung fehlender Werte weglassen.


```r
anyNA(fb24$gewis) # NA's vorhanden
```

```
## [1] TRUE
```

```r
anyNA(fb24_red$gewis) # keine NA's vorhanden durch Reduzierung
```

```
## [1] FALSE
```

```r
anyNA(fb24_sample$gewis) # keine NA's vorhanden da Stichprobe aus fb24_red
```

```
## [1] FALSE
```

```r
mean_gewis_pop <- mean(fb24_red$gewis) # Mittelwert der Population

sd_gewis_pop <- sd(fb24_red$gewis) * sqrt((length(fb24_red$gewis) - 1) / length(fb24_red$gewis)) # empirische Standardabweichung der Population - ist also die Populationsvarianz

se_gewis <- sd_gewis_pop / sqrt(length(fb24_sample$gewis)) # Standardfehler des Mittelwerts

mean_gewis_smpl2 <- mean(fb24_sample$gewis) # Mittelwert der Stichprobe

z_gewis2 <- (mean_gewis_smpl2 - mean_gewis_pop) / se_gewis #empirischer z-Wert

z_krit <- qnorm(1 - 0.05/2) # kritischer z-Wert, zweiseitig

abs(z_gewis2) > z_krit # nicht signifikant
```

```
## [1] FALSE
```

```r
2 * pnorm(z_gewis2, lower.tail = FALSE) #p > .05, nicht signifikant
```

```
## [1] 0.2021192
```

Mit einer Irrtumswahrscheinlichkeit von 5% kann die $H_0$ **nicht** verworfen werden. Die Psychologie-Studierenden der Stichprobe unterscheiden sich in ihrer Gewissenhaftigkeit nicht von der Grundgesamtheit (Datensatz). 

</details>
