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
lastmod: '2023-11-03'
featured: no
banner:
  image: "/header/frogs_on_phones.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1227907)"
projects: []
expiryDate: '2024-10-10'
publishDate: ''
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


Laden Sie zunächst den Datensatz `fb23` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb23.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/deskriptiv-intervall/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.



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
```

</details>


## Aufgabe 1

Erstellen Sie im Datensatz `fb23` die Skalenwerte für die aktuelle Stimmung, die mit den Items mdbf1 bis mdbf12 gemessen wurde. Keines der Items ist invertiert.


* Erstellen Sie den Skalenwert als Mittelwert der zwölf Items.

<details><summary>Lösung</summary>


```r
# Skalenwert

mood <- fb23[, c("mdbf1_pre", "mdbf2_pre", "mdbf3_pre", "mdbf4_pre", "mdbf5_pre", "mdbf6_pre", "mdbf7_pre", "mdbf8_pre", "mdbf9_pre", "mdbf10_pre", "mdbf11_pre", "mdbf12_pre")]

fb23$mood_ges <- rowMeans(mood)
```

Oder in einem Schritt mit der Pipe:


```r
# Skalenwert

fb23$mood_ges <-  fb23[, c("mdbf1_pre", "mdbf2_pre", "mdbf3_pre", "mdbf4_pre", "mdbf5_pre", "mdbf6_pre", "mdbf7_pre", "mdbf8_pre", "mdbf9_pre", "mdbf10_pre", "mdbf11_pre", "mdbf12_pre")] |> rowMeans()
```

</details>


## Aufgabe 2

Bestimmen Sie für die Skala den gesamten Mittelwert und Median.

* Was vermuten Sie, aufgrund des Verhältnisses der beiden Maße der zentralen Tendenz, bezüglich der Schiefe der Verteilung?
* Prüfen Sie Ihre Vermutung anhand eines Histogramms!


<details><summary>Lösung</summary>


```r
# Median und Mittelwert
median(fb23$mood_ges, na.rm = TRUE)
```

```
## [1] 2.333333
```

```r
mean(fb23$mood_ges, na.rm = TRUE)
```

```
## [1] 2.328652
```

Der Median und der Mittelwert sind nahezu identisch, was eine symmetrische Verteilung vermuten lässt.


**Prüfen der Vermutung anhand eines Histogramms!**


```r
hist(fb23$mood_ges, breaks = 30) # Histogramm
```

![](/lehre/statistik-i/deskriptiv-intervall-loesungen_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

Unser Histogramm zeigt uns, dass die Verteilung tatsächlich einigermaßen symmetrisch verläuft. Um dies sehen zu können, ist es wichtig, dass wir der `hist`-Funktion das Argument `breaks` übergeben und hier einen entsprechenden Wert einsetzen, der die Anzahl an Kategorien vorgibt, die wir gerne geplottet bekommen wollen. Übergeben wir das Argument nicht, bestimmt R die Anzahl selbst und in unserem Fall wird die Darstellung dann zu ungenau, um die Symmetrie der Verteilung zu sehen. 

</details>


## Aufgabe 3

Bestimmen Sie für den Skalenwert `mood_ges` die empirische Varianz und Standardabweichung. Achten Sie dabei darauf, ob es auf der Skala fehlende Werte gibt.

* Sind empirische Varianz und Standardabweichung größer oder kleiner als diejenige Schätzung, die mithilfe von `var()` oder `sd()` bestimmt wird?

<details><summary>Lösung</summary>

**Erinnerung:**

* Empirische Varianz: $s^2_{X} = \frac{\sum_{m=1}^n (x_m - \bar{x})^2}{n}$  
* Schätzer der Populationsvarianz: $\hat{\sigma}^2_{X} = \frac{\sum_{m=1}^n (x_m - \bar{x})^2}{n - 1}$  

Zur Berechnung der Varianz gemäß Formel benötigen wir $n$. Wir könnten mit `nrow(fb23)` die Länge des Datensatzes für `n` heranziehen. Dies ist jedoch nur dann sinnvoll, wenn auf der Variable `mood_ges` keine fehlenden Werte vorhanden sind!


```r
is.na(fb23$mood_ges) |> sum()
```

```
## [1] 1
```

Hier gibt es tatsächlich einen fehlenden Wert. Im Tutorial haben wir aber bereits gelernt, dass man mit `length(na.omit(fb23$mood_ges))` die Anzahl an Personen bestimmen kann, die auf der Skala einen Wert haben.


```r
# empirische Varianz
# per Hand
sum((fb23$mood_ges - mean(fb23$mood_ges, na.rm = T))^2, na.rm = T) / (length(na.omit(fb23$mood_ges)))
```

```
## [1] 0.04570218
```

```r
# durch Umrechnung 
var(fb23$mood_ges, na.rm = T) * (length(na.omit(fb23$mood_ges))-1) / length(na.omit(fb23$mood_ges))
```

```
## [1] 0.04570218
```

```r
# Populationsschätzer
var(fb23$mood_ges, na.rm = T)
```

```
## [1] 0.04596038
```

Die empirische Varianz ist kleiner als der Populationsschätzer.

Nun fehlt noch die Betrachtung der Standardabweichung. Als einfachste Möglichkeit für die Berechnung der empirischen Standardabweichung haben wir gelernt, dass man die Wurzel aus der empirischen Varianz ziehen kann.


```r
# empirische Standardabweichung
(sum((fb23$mood_ges - mean(fb23$mood_ges, na.rm = T))^2, na.rm = T) / length(na.omit(fb23$mood_ges))) |> sqrt()
```

```
## [1] 0.2137807
```

```r
# Populationsschätzer
sd(fb23$mood_ges, na.rm = T)
```

```
## [1] 0.2143837
```

Auch hier ist der empirische Wert kleiner als der Schätzer.

</details>


## Aufgabe 4

Erstellen Sie eine z-standardisierte Variante der Stimmungs-Skala als `mood_ges_z`.

* Erstellen Sie für `mood_ges_z` ein Histogramm.
* Was fällt Ihnen auf, wenn Sie dieses mit dem Histogramm der unstandardisierten Werte `mood_ges` vergleichen?
* Erstellen Sie beide Histogramme noch einmal mit 40 angeforderten Breaks.


<details><summary>Lösung</summary>

Um die Vergleichbarkeit zu erhöhen, wird im folgenden Code ein kleiner Trick angewendet. Die beiden Histogramme sollten am besten gleichzeitig unter **Plots** angezeigt werden. Durch die verwendete Funktion `par()` kann man verschiedene Plots gemeinsam in einem Fenster zeichnen. Das Argument bestimmt dabei, dass es eine Zeile und zwei Spalten für die Plots gibt.


```r
par(mfrow=c(1,2))

# z-Standardisierung
fb23$mood_ges_z <- scale(fb23$mood_ges)

# Histogramme
hist(fb23$mood_ges_z)
hist(fb23$mood_ges)
```

![](/lehre/statistik-i/deskriptiv-intervall-loesungen_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

Beim Vergleich der beiden Histogrammen fällt auf, dass sich - aufgrund der R-Voreinstellungen - das Erscheinungsbild fälschlicherweise unterscheidet (vor allem, wenn wir die y-Achse betrachten!) - eigentlich sollte sich durch die z-Transformation nur Skalierung der x-Achsen-Variable verändern. Tatsächlich aber bestimmt R hier eine unterschiedliche Anzahl von Kategorien. Wir erhalten eine konstantere Darstellung durch das `breaks`-Argument:


```r
# Histogramme mit jeweils 40 Breaks
par(mfrow=c(1,2))
hist(fb23$mood_ges_z, breaks = 40)
hist(fb23$mood_ges, breaks = 40)
```

![](/lehre/statistik-i/deskriptiv-intervall-loesungen_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

Die Verteilungen sehen nun tatächlich gleich aus. Da die Breaks ein weicher Befehl sind, kann es hier jedoch trotzdem vorkommen, dass keine komplette Gleichheit gegeben werden kann.

</details>
