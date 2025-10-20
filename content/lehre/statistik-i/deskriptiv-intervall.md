---
title: "Deskriptivstatistik für Intervallskalen" 
type: post
date: '2020-09-24' 
slug: deskriptiv-intervall 
categories: ["Statistik I"] 
tags: ["Deskriptivstatistik", "Intervallskalen", "Mittelwerte", "Varianz"] 
subtitle: ''
summary: 'In diesem Beitrag wird die Deskriptivstatistik für intervallskalierte Variablen vorgestellt. Dabei wird zunächst die Berechnung des Mittelwerts, der Varianz sowie Standardabweichung behandelt. Dann wird gezeigt, wie Variablen zentriert bzw. standardisiert werden können. Abschließend geht es außerdem um das Rekodieren von Items und das Bilden von Skalenwerten.' 
authors: [nehler, beitner, buchholz] 
weight: 3
lastmod: '2025-10-20'
featured: no
banner:
  image: "/header/frogs_on_phones.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1227907)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/deskriptiv-intervall
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-i/deskriptiv-intervall.R
  - icon_pack: fas
    icon: pen-to-square
    name: Übungen
    url: /lehre/statistik-i/deskriptiv-intervall-uebungen
output:
  html_document:
    keep_md: true
---






<details><summary><b>Kernfragen dieser Lehreinheit</b></summary>
 
* Was ist der Befehl um den [**Mittelwert**](#Mittelwert) zu bestimmen?
* Wie kann die [**empirische Varianz**](#Varianz) bestimmt werden? Wie unterscheidet sich diese von der mit `var()` bestimmten Varianz?
* Wie können Variablen [**zentriert und standardisiert**](#Zentrieren) werden?
* Welche Möglichkeiten gibt es, negativ formulierte Items zu [**rekodieren**](#Rekodieren)?
* Mit welchen Befehlen können in R einzelne Items zu [**Skalenwerte**](#Skalenwerte) zusammengefasst werden?

</details>

***

## Wiederholung aus der Vorlesung: Skalenniveaus

Skala | Aussage | Transformation | Zentrale Lage | Dispersion |
--- | ------------ | -------- | ---------- | ----------------- |
Nominal | Äquivalenz | eineindeutig | Modus | Relativer Informationsgehalt |
Ordinal | Ordnung | monoton | Median | Interquartilsbereich |
Intervall | Verhältnis von Differenzen | positiv linear | Mittelwert | Standardabweichung, Varianz |
Verhältnis | Verhältnisse | Ähnlichkeit | ... | ... |
Absolut | absoluter Wert | Identität | ... | ... |


***

## Vorbereitende Schritte {#prep}

Den Datensatz `fb24` haben wir bereits über diesen [{{< icon name="download" pack="fas" >}} Link heruntergeladen](/daten/fb24.rda) und können ihn über den lokalen Speicherort einladen oder Sie können Ihn direkt mittels des folgenden Befehls aus dem Internet in das Environment bekommen. Im letzten Tutorial und den dazugehörigen Aufgaben haben wir bereits Änderungen am Datensatz durchgeführt, die hier nochmal aufgeführt sind, um den Datensatz auf dem aktuellen Stand zu haben: 


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
```

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb24)
```

```
## [1] 192  43
```

Der Datensatz besteht aus 192 Zeilen (Beobachtungen) und 43 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.


***

## Mindestens intervallskalierte Variablen

Nachdem wir deskriptive Maße für nominal- und ordinalskalierte Variablen kennengelernt haben, wollen wir uns in diesem Tutorial mit Kennwerten beschäftigen, die für Variablen mit mindestens Intervallskalierung verwendet werden. Dabei ist das Verhältnis von Differenzen für die Funktionalität der Kennwerte die wichtige Voraussetzung, sodass sie bei Intervall-, Verhältnis- oder Absolutskalierung genutzt werden können. In der Psychologie begegnen wir Variablen mit diesem Skalenniveau in zwei verschiedenen Bereichen:

#### Klassische mindestens intervallskalierte Variablen

* Behaviorale Maße: Reaktionszeiten, Bearbeitungsdauer, Anzahl von Fehlern, ...
* Biologische Maße: Hautleitfähigkeit, Stimmhöhe, Anzahl der Sakkaden, ...
* Neurophysiologische Maße: EEG-Daten, Durchblutung von Hirnregionen, ...


#### Konstruierte mindestens intervallskalierte Variablen

* Fragebogendaten werden meist ordinalskaliert erhoben (einzelne Items)
* Um Intervallskalenniveau zu erreichen, werden Items zu Skalenwerten verrechnet (Summe oder Mittelwert)
* Erzeugt viele mögliche Ausprägungen und wird als intervallskaliert behandelt

Für das Tutorial benutzen wir einen Skalenwert aus dem ausgefüllten Fragebogen, da wir keine behavioralen oder biologischen Maße in der Befragung haben. Wir wollen uns auf die von Ihnen berichtete **Lebenszufriedenheit** konzentrieren. Zur Erinnerung: Diese wurde mit den 5 Items auf der Abbildung erfragt.

{{<inline_image"/lehre/statistik-i/fb_swls.png">}}

Wir haben den Skalenwert bereits in der Vorbereitung des Datesnatzes für Sie erstellt. Dabei haben wir den Mittelwert aus Ihren Antworten auf die 5 Items berechnet. Wir werden uns später noch anschauen wie die Erstellung eines Skalenwertes abläuft. Für Lebeszufriedenheit ist der Skalenwert für jede einzelne Person nun in der Spalte `lz` in unserem Datensatz zu finden. Indem wir die Variable ansprechen, können wir uns die Ausprägungen anzeigen lassen.


```r
fb24$lz
```

```
##   [1] 6.6 4.0 5.2 4.0 5.0 4.4
##   [7] 6.4 4.0 4.6 6.0 3.8 3.4
##  [13] 6.6 6.4 5.8 4.6 4.6 2.0
##  [19] 4.6 5.2 4.0 6.4 4.8 5.0
##  [25] 6.8 2.6 4.6 4.4 5.6 5.6
##  [31] 3.0 4.8 3.8 5.5 5.4 5.8
##  [37] 5.8 4.6 4.6 4.2 4.8 4.2
##  [43] 5.0 4.8 6.0 3.2 6.0 6.0
##  [49] 5.6 5.2 2.8 5.4 5.0 5.6
##  [55] 3.8 4.8 4.2 4.0 3.0 4.6
##  [61] 5.8 5.8 5.0 5.8 5.2 5.4
##  [67] 5.8 4.0 2.6 6.0 5.8 6.6
##  [73] 4.4 4.4 7.0 6.0 4.4 5.4
##  [79] 5.8 5.2 4.8 4.4 2.6 4.4
##  [85]  NA 6.6 5.0 5.2 7.0 4.6
##  [91] 4.0 3.8 6.6 3.8 6.4 4.4
##  [97] 5.6 5.6 6.8 3.2 3.2 5.4
## [103] 5.0 6.0 5.8 2.8 3.6 5.4
## [109] 6.6 3.6 3.8 6.4 5.0 2.4
## [115] 5.4 4.8 4.4 3.6 5.2 4.4
## [121] 4.8 4.8 5.8 5.4 5.6 3.6
## [127] 5.0 3.2 6.0 4.8 4.4 5.4
## [133] 4.4 3.8 6.2 2.2 5.8 6.2
## [139] 4.0 5.6 5.4 6.2 2.4 6.4
## [145] 3.0 6.2 5.4 6.4 5.2 4.8
## [151] 6.8 5.6 4.0 4.8 3.4 5.8
## [157] 5.2 4.2 4.6 6.0 6.2 3.8
## [163] 6.8 3.6 3.4 4.2 6.2 4.8
## [169] 5.0 4.6 6.2 5.6 3.6 4.4
## [175] 3.8 4.8 5.8 7.0 6.4 2.4
## [181] 2.0 2.4 5.8 4.4 6.0 5.4
## [187] 6.0 5.0 5.0 6.2 6.0 5.6
```

Auf den ersten Blick ist es schwer, aus so einer großen Menge an unterschiedlichen Werten ein Fazit zu ziehen. Um eine Stichprobe zusammenzufassen, lernen wir heute deskriptive Maße kennen. Zunächst lässt sich aber feststellen, dass wir es auch auf dem Skalenwert mit fehlenden Werten (`NA`) zu tun haben. 

## Deskriptivstatistik für mindestens intervallskalierte Variablen

Bevor wir uns mit neuen Kennwerten beschäftigen, werfen wir nochmal einen Blick zurück. 
Statistische Verfahren sind "rückwärtskompatibel", d.h. alle Berechnungen, die auf nominalskalierte und ordinalskalierte Variablen anwendbar sind, lassen sich auch auf mindestens intervallskalierte Variablen anwenden. Das bedeutet, dass bspw. Range, Quantile und Median weiterhin valide bestimmt werden können.


```r
# Minimum & Maximum
range(fb24$lz, na.rm=T)
```

```
## [1] 2 7
```

```r
# Quartile & Median
quantile(fb24$lz, c(.25, .5, .75), na.rm=T)
```

```
## 25% 50% 75% 
## 4.2 5.0 5.8
```

```r
#Box-Whisker Plot
boxplot(fb24$lz)
```

![](/deskriptiv-intervall_files/unnamed-chunk-4-1.png)<!-- -->

Die Betrachtung zeigt uns, dass die meisten Werte Ihrer selbstberichteten Lebenszufriedenheit im oberen Bereich der Skala liegen. Personen mit sehr niedrigen Skalenwerten werden als mögliche Ausreißer getestet.

## Histogramme

Um die Verteilung der Werte für eine mindestens intervallskalierte noch besser betrachten zu können, wird sehr häufig das Histogramm als grafische Darstellungsform genutzt. Dieses fasst die kontinuierlichen Werte in Klassen (Kategorien, Intervalle) zusammen. Anschließend wird eine Häufigkeitsverteilung (ähnlich dem Barplot) für die kategorisierten Daten (sekundäre Häufigkeitsverteilung) erstellt. Grundlegend kann solch eine Grafik über den Befehl `hist()` angefordert werden.


```r
# Histogramm
hist(fb24$lz)
```

![](/deskriptiv-intervall_files/unnamed-chunk-5-1.png)<!-- -->

Natürlich kann man auch hier zusätzliche Argumente nutzen, die die Optik des Histogramms verändern. Dabei können beispielsweise Farbe, Achsenbeschriftungen oder auch der Titel verändert werden. Damit haben wir uns aber bereits auseinandergesetzt und wiederholen es deswegen an dieser Stelle nicht nochmal. Eine neue Bearbeitungsoption für den Plot ist aber das Argument `breaks`. Hierin wird beschrieben, an welchem Ort eine Kategorie anfängt und wieder aufhört. bspw. startet die erste Kategorie bei 1 und geht bis 3, die zweite dann bei 3 bis 5 und die vierte von 5 bis 7. Die Anzahl der Breakpoints wäre in diesem Beispiel 4 (`c(1, 3, 5, 7)`). Ohne eigenen Input bestimmt `R` dieses komplett selbst. Wir können aber auch einen Wert zuordnen - bspw. eine ganze Zahl. 


```r
# Histogramm (20 Breakpoints anfordern)
hist(fb24$lz,
     breaks = 20)
```

![](/deskriptiv-intervall_files/unnamed-chunk-6-1.png)<!-- -->

Das Argument ist eine weiche Einstellung. `R` weiß jetzt, dass wir 20 Kategorien bevorzugen. Im Hintergrund laufen aber Funktionen ab, die einen optisch ansprechenden Code produzieren. Deshalb erhalten wir mehr als 20 Breakpoints. Eine weiche Einstellung bedeutet also, dass `R` das Argument nicht als Pflicht übernimmt. Dieses Phänomen werden wir relativ selten im Verlauf des Semesters sehen. Es wird aber in der Hilfe `?hist` im Unterpunkt `breaks` beschrieben. 

Werte, die genau auf einem Break liegen, werden standardmäßig der Kategorie zugeordnet, von der sie den Abschluss bilden. Wenn die Breaks `c(1, 1.5, 2)` sind, wird ein Wert von 1.5 der ersten Kategorie zugeordnet. Dies gilt mit Ausnahme der untersten Kategorie - hier würde ein Wert von 1 natürlich auch der ersten Kategorie und nicht der nullten Kategorie, die es nicht gibt, zugeordnet werden. 

Achtung! Die Anzahl der Kategorien kann den Eindruck der Daten beeinflussen. Hier erstellen wir ein Beispiel dafür, wie wir jeden Breakpoint selbst bestimmen können und auch den Eindruck der Daten manipulieren.


```r
# Histogramm (ungleiche Kategorien)
hist(fb24$lz,
     breaks = c(1, 3, 3.3, 3.6, 3.9, 4.5, 5, 7))
```

![](/deskriptiv-intervall_files/unnamed-chunk-7-1.png)<!-- -->

Für die eigene Bestimmung der Grenzen muss also anstatt einer ganzen Zahl dem Befehl ein Vektor `c()` mit allen Breakpoints übergeben werden.

## Mittelwert {#Mittelwert}

Betrachten wir nun, wie in `R` das Maß der zentralen Tendenz für mindestens intervallskalierte Daten per Funktion bestimmt werden kann. In der Vorlesung haben Sie die Formel zur Bestimmung kennen gelernt.

**Formel:** ${x} = \frac{\sum_{m = 1}^n x_m}{n} = \frac{1}{n} \sum_{m = 1}^n x_m$

In `R` ist die Funktion zum Glück sehr intuitiv benannt. Dabei muss auch hier beachtet werden, dass fehlende Werte über `na.rm = T` ausgeschlossen werden, damit nicht auch als Ergebnis `NA` angezeigt.


```r
# Arithmetisches Mittel
mean(fb24$lz, na.rm = TRUE)
```

```
## [1] 4.919895
```

## Varianz

Für die Varianz haben Sie in der Vorlesung folgende Formel kennen gelernt:

**Formel:** $s^2_{X} = \frac{\sum_{m=1}^n (x_m - \bar{x})^2}{n}$

Wollen wir diese nun per Hand bestimmen, könnte folgender Code das für uns erledigen:


```r
# Händische Varianzberechnung
sum((fb24$lz - mean(fb24$lz, na.rm = TRUE))^2, na.rm = TRUE) / (nrow(fb24)-2)
```

```
## [1] 1.321813
```

Achtung! Wir benötigen für die Varianzberechnung `n` (s. Formel)! Wir nutzen hier `nrow(fb24)`-1, weil `nrow(fb24)` nicht das richtige n anzeigt (1 Personen haben einen fehlenden Wert, daher die Anzahl an Zeilen minus der 1 fehlenden Werte = n).


**Kleiner Diskurs zu fehlenden Werten:**

<img src="/deskriptiv-intervall_files/unnamed-chunk-10-1.png" style="display: block; margin: auto;" />

Um zu prüfen, ob und wie viele fehlende Werte eine Variable hat, lässt sich z. B. folgende Syntax verwenden:


```r
is.na(fb24$lz) |> sum()
```

```
## [1] 1
```

Um die Länge einer Variablen ohne fehlende Werte (also die Anzahl an Beobachtungen auf einer Variablen) zu bestimmen, lässt sich z. B. folgende Syntax verwenden:


```r
na.omit(fb24$lz) |> length() # mit Pipe
```

```
## [1] 191
```

```r
length(na.omit(fb24$lz))     # ohne Pipe
```

```
## [1] 191
```

Zur händischen Varianzberechnung können wir daher auch folgende Syntax verwenden:


```r
# Händische Varianzberechnung
sum((fb24$lz - mean(fb24$lz, na.rm = TRUE))^2, na.rm = TRUE) / (length(na.omit(fb24$lz)))
```

```
## [1] 1.314892
```


## Verschiedene Varianzschätzer

Sie haben sich eventuell schon gewundert, warum wir eine so bekannten Wert wie die Varianz per Hand bestimmen müssen. Mit der ersten Intuition findet man bereits eine Funktion für die Berechnung, `var()`. Folgendes Ergebnis liefert R, wenn wir die R-Funktion `var()` zur Berechnung der Varianz verwenden:

```r
# R-interne Varianzberechnung
var(fb24$lz, na.rm = TRUE)
```

```
## [1] 1.321813
```

Warum erhalten wir hier einen abweichenden Wert im Vergleich zu unserer händischen Varianzberechnung?

Die meisten Programme berechnen nicht die empirische Varianz, sondern einen Schätzer der Populationsvarianz:

{{<intext_anchor Varianz>}}
**Empirische Varianz**

$s^2_{X} = \frac{\sum_{m=1}^n (x_m - \bar{x})^2}{n}$

**Schätzer der Populationsvarianz**

$\hat{\sigma}^2_{X} = \frac{\sum_{m=1}^n (x_m - \bar{x})^2}{n - 1}$

Ein enger Zusammenhang zwischen Populationsvarianz und empirischer Varianz ist bereits nur durch Ansicht der Formeln erkenntlich. Eine Erklärung über diesen wird es erst im weiteren Verlauf der Vorlesung geben. Wir wollen uns nun darauf konzentrieren, wie wir technisch den Wert, den wir durch `var()` erhalten, für unsere Zwecke nutzen können.

Um in R die empirische Varianz mithilfe der `var()`-Funktion zu berechnen, kann man die Populationsvarianz nutzen. Multipliziert man sie mit $\frac{n - 1}{n}$, erhält man die empirische Varianz.


```r
# Umrechnung der Varianzen
var(fb24$lz, na.rm = TRUE) * (nrow(fb24) - 1) / nrow(fb24)
```

```
## [1] 1.314928
```

Achtung! Dies funktioniert in unserem Fall wieder nicht, da die Verwendung von `nrow(fb24)` - wie oben bereits angemerkt - nicht sinnvoll ist: `nrow(fb24)` ist nicht gleich n (es kommt `NA` 1 Mal vor), daher besser:


```r
# Umrechnung der Varianzen
var(fb24$lz, na.rm = TRUE) * (length(na.omit(fb24$lz)) - 1) / (length(na.omit(fb24$lz)))
```

```
## [1] 1.314892
```

Alternativ, wenn man die fehlenden Werte händisch abzieht:

```r
# Umrechnung der Varianzen
var(fb24$lz, na.rm = TRUE) * (191 - 1) / 191
```

```
## [1] 1.314892
```


## Standardabweichung

Auch bei der Standardabweichung bestimmt R den Populationsschätzer $\hat{\sigma}_{X}$.

{{< math >}}
\begin{equation}
\small
\hat{\sigma}_{X} = \sqrt{\hat{\sigma}^2_{X}} = \sqrt{\frac{\sum_{m=1}^n (x_m - \bar{x})^2}{n - 1}}
\end{equation}
{{< /math >}}



```r
# Standardabweichung in R
sd(fb24$lz, na.rm = TRUE) # Populationsschaetzer
```

```
## [1] 1.149701
```


In der Vorlesung hingegen haben Sie die empirische Standardabweichung kennen gelernt.

$s_{X} = \sqrt{s^2_{X}} = \sqrt{\frac{\sum_{m=1}^n (x_m - \bar{x})^2}{n}}$

Wir müssten das Ergebnis also wieder mit einem Faktor ($\sqrt{\frac{n - 1}{n}}$) multiplizieren, um die emprische Standardabweichung zu erhalten. 


```r
# Umrechnung der Standardabweichung
sd(fb24$lz, na.rm = TRUE) * sqrt((191 - 1) / 191)
```

```
## [1] 1.146687
```

Alternativ kann diese natürlich auch komplett händisch berechnet werden. Dafür können wir einfach den bereits geschriebenen Code für die empirische Varianz nehmen und aus dem Ergebnis die Wurzel ziehen.


```r
# Händische Berechnung der empirischen Standardabweichung
(sum((fb24$lz - mean(fb24$lz, na.rm = TRUE))^2,
    na.rm = TRUE) / (length(na.omit(fb24$lz)))) |> sqrt()
```

```
## [1] 1.146687
```

***

## Zentrierung und Standardisierung {#Zentrieren}

In der Vorlesung haben Sie gelernt, dass eine Variable zentriert oder standardisiert werden kann. Die Zentrierung sorgt für einen Mittelwert von 0, während die z-Standardisierung zusätzlich die Varianz auf 1 setzt. Die Variablenzentrierung und -standardisierung lässt sich in R per Hand berechnen.


```r
# Zentrierung
lz_c <- fb24$lz - mean(fb24$lz, na.rm = TRUE)
head(lz_c)    # erste 6 zentrierte Werte
```

```
## [1]  1.68010471 -0.91989529
## [3]  0.28010471 -0.91989529
## [5]  0.08010471 -0.51989529
```

```r
# z-Standardisierung
lz_z <- lz_c / sd(fb24$lz, na.rm = TRUE)
head(lz_z)    # erste 6 z-standardisierte Werte
```

```
## [1]  1.46134044 -0.80011691
## [3]  0.24363264 -0.80011691
## [5]  0.06967438 -0.45220039
```

...oder mit Hilfe bereits existierender Funktionen:


```r
## Befehl zum z-Standardisieren
lz_z <- scale(fb24$lz, center = TRUE, scale = TRUE) # Mittelwert auf 0 und Varianz auf 1
## Befehl zum Zentrieren (ohne Varianzrelativierung)
lz_c <- scale(fb24$lz, center = TRUE, scale = FALSE) # setzt Varianz nicht auf 1
```

Beachten Sie, dass wir hier die z-standardisierten und zentrierten Werte jeweils in einem eigenen Objekt (`lz_z` und `lz_c`) und nicht als neue Variable im Datensatz (`fb24`) abgelegt haben. 
***


## Skalenwerte

Wie bereits besprochen, werden Fragebogendaten (also einzelne Items, die Versuchsteilnehmenden vorgelegt werden) meist ordinalskaliert erhoben. Um Intervallskalenniveau zu erreichen werden Items zu Skalenwerten verrechnet. Beispielsweise kann die Summe oder auch der Mittelwert verwendet werden. Darüber können viele mögliche Ausprägungen erzeugt werden und der Skalenwert wird als intervallskaliert behandelt. Doch nicht immer steigt man direkt in die Aggregation der Items ein. viele Fragebögen bestehen nämlich aus positiven und negativen Items, was eine Rekodierung nötig macht.

### Items Rekodieren {#Rekodieren}

Viele Fragebögen enthalten sowohl positiv als auch negativ formulierte Items,

* ...um die Befragung abwechslungsreich zu gestalten
* ...um das psychologische Konstrukt umfassender zu erheben
* ...um Antworttendenzen leichter identifizieren zu können

Vor der Skalenbildung müssen alle Items in eine Richtung gebracht werden: Das wird als **Rekodierung** bezeichnet.

Betrachten wir als Beispiel den Fragebogen zur Befindlichkeit von dem wir hier einen Ausschnitt dargestellt haben. 

{{<inline_image"/lehre/statistik-i/mdbf.png">}}

Im speziellen wollen wir uns auf die Skala gut/schlecht beziehen. Den Fragebogen zur Befindlichkeit haben Sie zu Beginn und am Ende des Praktikums ausgefüllt. Skalenwerte für die spätere Befragung (post) haben wir bereits für Sie in der Datenaufbereitung gebildet. Skalenwerte für die erste Befragung (pre) stehen noch aus. Wie bereits erwähnt, wollen wir uns im Tutorial auf die Skala gut/schlecht beziehen. Diese soll bei hohem Wert darstellen, dass man sich gut fühlt. Aus dem abgebildeten Teil des Fragebogens zur Befindlichkeit gehören Items 1 und 4 zu dieser Skala. Hier wird bereits deutlich, dass es sich um ein negatives und ein positives Item handelt. Damit der Skalenwert gut/schlecht also ein gutes Befinden anzeigt, muss Item 4 vor der Bildung des Skalenwertes rekodiert werden. Weitere Items des Fragebogens, die zu dieser Skala gehören, sind Items 8 und 11, wobei 11 auch negativ formuliert ist (nennt man auch *invertiert*). Auch hier ist also eine Rekodierung nötig.

Auf der Abbildung konnten wir sehen, dass die möglichen Werte für die Beantwortung der Frage von 1 bis 4 gingen. Mit den Befehlen und R-Kenntnissen aus den bisherigen Sitzungen können wir zwei verschiedene Wege zur Transformation erstellen, die wir auf Items 4 und 11 des Fragebogens zur Befindlichkeit (`mdbf`) anwenden. Bei beiden Transformationen ist es sinnvoll, oder auch notwendig, die transformierten Werte in einer neuen Variable in R abzulegen, um ein korrektes Vorgehen zu gewährleisten.


**Variante 1: Lineare Transformation**

```r
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 5)
head(fb24$mdbf4)     # erste 6 Werte ohne Transformation
```

```
## [1] 1 1 1 2 1 3
```

```r
head(fb24$mdbf4_r)   # erste 6 Werte mit Transformation
```

```
## [1] 4 4 4 3 4 2
```

* Allgemeine Form: $-1 \cdot (x_m - x_{\max} - 1)$   
* Vorteil: schnell und einfach umsetzbar   
* Nachteil: nur für Invertierung sinnvoll, nicht allgemeiner anwendbar   

<details><summary><b>Quizfrage</b>: Ist dies eine zulässige Transformation für ordinalskalierte Variablen (wie Items)</summary>

***Antwort***: Ja, denn die Ordnungsrelation bleibt hierbei erhalten! 

</details>



**Variante 2: Logische Filter**

Mit Hilfe von logischen Filtern, die wir auch schon im [R-Intro](/lehre/statistik-i/crash-kurs/) kennen gelernt haben, können wir uns auch alle Antworten einer Ausprägung (z.B. 1) anzeigen lassen und diesen dann den transformierten Wert zuweisen. Durch die Invertierung wissen wir, dass dem Wert 1 der Wert 4 zugeordnet werden muss. Also können wir eine Abfrage nach allen Teilnehmenden machen, die die Antwort 1 gegeben haben.


```r
head(fb24$mdbf11 == 1, 15) #Zeige die ersten 15 Antworten
```

```
##  [1]  TRUE  TRUE  TRUE FALSE
##  [5] FALSE FALSE FALSE  TRUE
##  [9] FALSE  TRUE FALSE  TRUE
## [13]  TRUE  TRUE  TRUE
```

Wir erhalten einen booleschen Vektor, der uns sagt, wo der Wert 1 auftaucht (`TRUE`) und wo nicht (`FALSE`).
Mit Hilfe dieses booleschen Vektors können wir die Stellen ansteuern bzw. indizieren, in denen im transformierten Vektor dann eine 4 statt einer 1 stehen soll. Dies passiert für all die Stellen, an denen `TRUE` steht.


```r
fb24$mdbf11_r[fb24$mdbf11 == 1] <- 4
fb24$mdbf11_r[fb24$mdbf11 == 2] <- 3
fb24$mdbf11_r[fb24$mdbf11 == 3] <- 2
fb24$mdbf11_r[fb24$mdbf11 == 4] <- 1

head(fb24$mdbf11)
```

```
## [1] 1 1 1 2 3 2
```

```r
head(fb24$mdbf11_r)
```

```
## [1] 4 4 4 3 2 3
```

* Durch logische Filter Personen auswählen, die auf Originalvariable den relevanten Wert haben  
* Auf rekodierter Variable neuen Wert zuweisen  
* Vorteil: extrem flexibel, jede Transformation möglich  
* Nachteil: umständlich zu schreiben  


### Skalenwerte erstellen {#Skalenwerte}

Skalenwerte werden zumeist als Summen oder Mittelwerte der Items erstellt. Dafür kann man sich beispielsweise alle Daten, die der Skala zugrunde liegen, in einem eigenen kleinen Datensatz ablegen. Dieser Datensatz kann genutzt werden, um den Skalenwert wieder im Original abzulegen. Jede Person repräsentiert eine Zeile - `rowMeans()` berechnet den Mittelwert der Zeilen. Somit erhält jede Person einen eigenen Mittelwert über die Einträge. Führen wir das ganze beispielsweise für den Skalenwert zur gut/schlecht durch, die mit den 4 Items erhoben wurde. Wichtig ist hier auch, dass wir die rekodierten Items nehmen, da diese ja die "korrekte Richtung" aufweisen.


```r
# neuen Datensatz der relevanten Variablen erstellen 
gs_pre_data <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')]
# Skalenwert in Originaldatensatz erstellen
fb24$gs_pre <- rowMeans(gs_pre_data)
head(fb24$gs_pre)
```

```
## [1] 4.00 3.75 3.50 3.00 3.00
## [6] 2.25
```

Natürlich kann die Erstellung auch in einem Befehl passieren - beispielsweise durch Verwendung der Pipe. Es gibt aber auch noch viele andere Optionen zur Skalenbildung - es wird (wie eigentlich fast immer) nur ein Ausschnitt der Möglichkeiten gezeigt.


```r
# Direkter Befehle
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
head(fb24$gs_pre )
```

```
## [1] 4.00 3.75 3.50 3.00 3.00
## [6] 2.25
```

<details><summary><b>Quizfrage</b>: Was bedeutet <code>NA</code> in <code>fb24$gs_pre</code>?</summary>

***Antwort***: `NA` bedeutet in diesem Fall, dass eine teilnehmende Person mindestens ein Item nicht beantwortet hat. Da `rowMeans()` im Hintergrund auch nur `mean()` auf jeder Zeile aufruft, gibt es bei fehlenden Werten die Ausgabe `NA`. Wenn man das vermeiden möchte, kann man wieder das Argument `na.rm = TRUE` hinzufügen. Dabei muss man sich aber im Klaren sein, dass der Mittelwert dann auch für Personen berechnet wird, die nicht alle Items ausgefüllt haben. Im schlimmsten Fall sogar nur ein einziges von 10. Daher sollte solche Entscheidungen immer mit Bedacht getroffen werden.

</details>


### Ergänzungen

Wenn Sie als Skalenwert lieber die Summe aller Items statt des Mittelwertes nutzen wollen, kann dasselbe Vorgehen genutzt werden. Dabei muss dann `rowMeans()` (Mittelwert für jede Zeile über Variablen) durch `rowSums()` (Summe für jede Zeile über Variablen) ersetzt werden. 

Wenn statt Personen in den Zeilen Informationen über Variablen gewonnen werden sollen, kann dies mit `colMeans()` (Mittelwert für jede Spalte über Personen)  und `colSums()` (Summe für jede Spalte über Personen) erreicht werden. Da diese Befehle im typischen psychologischen Setting aber über Personen und nicht Variablen hinweg gehen, werden diese eher nicht im Bereich der Skalenbildung verwendet und hier nur zur Vollständigkeit aufgeführt.  

***
