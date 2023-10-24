---
title: "Deskriptivstatistik für Intervallskalen - Lösungen" 
type: post
date: '2020-11-26' 
slug: deskriptiv-intervall-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [nehler, buchholz] 
lastmod: '2023-10-24'
featured: no
banner:
  image: "/header/descriptive_post.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1227907)"
projects: []
expiryDate: '2024-10-10'
publishDate: '2023-10-16'
reading_time: false
share: false
_build:
  list: never
output:
  html_document:
    keep_md: true
---


### Vorbereitung

<details><summary>Lösung</summary>

Laden Sie zunächst den Datensatz `fb22` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb22.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/deskriptiv-intervall/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.


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
```

</details>


## Aufgabe 1

Erstellen Sie im Datensatz `fb22` die Skalenwerte für die Naturverbundenheit, die mit den Items nr1 bis nr6 gemessen wurde. Keines der Items ist invertiert.


Erstellen Sie den Skalenwert als Mittelwert der sechs Items.

<details><summary>Lösung</summary>


```r
# Skalenwert

naturverbundenheit <- fb22[, c('nr1', 'nr2', 'nr3', 'nr4', 'nr5',  'nr6')]
fb22$nr_ges <- rowMeans(naturverbundenheit)
```

Oder in einem Schritt mit der Pipe:


```r
# Skalenwert

fb22$nr_ges <-  fb22[, c('nr1', 'nr2', 'nr3', 'nr4', 'nr5',  'nr6')] |> rowMeans()
```

</details>


## Aufgabe 2

Bestimmen Sie für die Skala den gesamten Mittelwert und Median.

* Was vermuten Sie, aufgrund des Verhältnisses der beiden Maße der zentralen Tendenz, bezüglich der Schiefe der Verteilung?
* Prüfen Sie Ihre Vermutung anhand eines Histogramms!


<details><summary>Lösung</summary>


```r
# Median und Mittelwert
median(fb22$nr_ges, na.rm = TRUE)
```

```
## [1] 3.333333
```

```r
mean(fb22$nr_ges, na.rm = TRUE)
```

```
## [1] 3.254777
```

Der Median ist (geringfügig) größer als der Mittelwert, was auf eine (leicht) linksschiefe bzw. rechtssteile Verteilung schließen lässt.

**Prüfen der Vermutung anhand eines Histogramms!**


```r
hist(fb22$nr_ges) # Histogramm
```

![](/lehre/statistik-i/deskriptiv-intervall-loesungen_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

Die Verteilung ist tatsächlich (leicht) linksschief bzw. rechtssteil.

</details>


## Aufgabe 3

Bestimmen Sie für den Skalenwert `nr_ges` die empirische Varianz und Standardabweichung. Achten Sie dabei darauf, ob es auf der Skala fehlende Werte gibt.

* Sind empirische Varianz und Standardbweichung größer oder kleiner als diejenige Schätzung, die mithilfe von `var()` oder `sd()` bestimmt wird? 

<details><summary>Lösung</summary>

**Erinnerung:**

* Empirische Varianz: $s^2_{X} = \frac{\sum_{m=1}^n (x_m - \bar{x})^2}{n}$  
* Schätzer der Populationsvarianz: $\hat{\sigma}^2_{X} = \frac{\sum_{m=1}^n (x_m - \bar{x})^2}{n - 1}$  

Zur Berechnung der Varianz gemäß Formel benötigen wir $n$. Wir könnten mit `nrow(fb22)` die Länge des Datensatzes für `n` heranziehen. Dies ist jedoch nur dann sinnvoll, wenn auf der Variable `nr_ges` keine fehlenden Werte vorhanden sind!


```r
is.na(fb22$nr_ges) |> sum()
```

```
## [1] 2
```

Hier gibt es tatäschlich wieder zwei fehlenden Werte. Im Tutorial haben wir aber bereits gelernt, dass man mit `length(na.omit(fb22$nr_ges))` die Anzahl an Personen bestimmen kann, die auf der Skala einen Wert haben.


```r
# empirische Varianz
# per Hand
sum((fb22$nr_ges - mean(fb22$nr_ges, na.rm = T))^2, na.rm = T) / (length(na.omit(fb22$nr_ges)))
```

```
## [1] 0.6597879
```

```r
# durch Umrechnung 
var(fb22$nr_ges, na.rm = T) * (length(na.omit(fb22$nr_ges))-1) / length(na.omit(fb22$nr_ges))
```

```
## [1] 0.6597879
```

```r
# Populationsschätzer
var(fb22$nr_ges, na.rm = T)
```

```
## [1] 0.6640173
```

Die empirische Varianz ist kleiner als der Populationsschätzer.

Nun fehlt noch die Betrachtung der Standardabweichung. Als einfachste Möglichkeit für die Berechnung der empirischen Standardabweichung haben wir gelernt, dass man die Wurzel aus der empirischen Varianz ziehen kann.


```r
# empirische Standardabweichung
(sum((fb22$nr_ges - mean(fb22$nr_ges, na.rm = T))^2, na.rm = T) / length(na.omit(fb22$nr_ges))) |> sqrt()
```

```
## [1] 0.8122733
```

```r
# Populationsschätzer
sd(fb22$nr_ges, na.rm = T)
```

```
## [1] 0.8148726
```

Auch hier ist der empirische Wert kleiner als der Schätzer.

</details>


## Aufgabe 4

Erstellen Sie eine z-standardisierte Variante der Skala zur Naturverbundenheit als `nr_ges_z`.

* Erstellen Sie für `nr_ges_z` ein Histogramm.
* Was fällt Ihnen auf, wenn Sie dieses mit dem Histogramm der unstandardisierten Werte `nr_ges` vergleichen?
* Erstellen Sie beide Histogramme noch einmal mit 20 ageforderten Breaks


<details><summary>Lösung</summary>

Um die Vergleichbarkeit zu erhöhen, wird im folgenden Code ein kleiner Trick angewendet. Die beiden Histogramme sollten am besten gleichzeitig unter **Plots** angezeigt werden. Durch die verwendete Funktion `par()` kann man verschiedene Plots gemeinsam in einem Fenster zeichnen. Das Argument bestimmt dabei, dass es eine Zeile und zwei Spalten für die Plots gibt.


```r
par(mfrow=c(1,2))

# z-Standardisierung
fb22$nr_ges_z <- scale(fb22$nr_ges)

# Histogramme
hist(fb22$nr_ges_z)
hist(fb22$nr_ges)
```

![](/lehre/statistik-i/deskriptiv-intervall-loesungen_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

Beim Vergleich der beiden Histogrammen fällt auf, dass sich - aufgrund der R-Voreinstellungen - das Erscheinungsbild fälschlicherweise unterscheidet - eigentlich sollte sich durch die z-Transformation nur Skalierung der x-Achsen-Variable verändern. Tatsächlich aber bestimmt R hier eine unterschiedliche Anzahl von Kategorien. Wir erhalten eine konstantere Darstellung durch das `breaks`-Argument:


```r
# Histogramme mit jeweils 20 Breaks
par(mfrow=c(1,2))
hist(fb22$nr_ges_z, breaks = 20)
hist(fb22$nr_ges, breaks = 20)
```

![](/lehre/statistik-i/deskriptiv-intervall-loesungen_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

Die Verteilungen sehen nun tatächlich (fast) gleich aus. Da die Breaks ein weicher Befehl sind, ist die komplette Gleichheit aber dennoch nicht gegeben.

</details>
