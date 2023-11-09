---
title: "Verteilungen - Lösungen" 
type: post
date: '2020-11-16' 
slug: verteilungen-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [nehler] 
lastmod: '2023-11-07'
featured: no
banner:
  image: "/header/six_sided_dice.png"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1087694)"
projects: []
expiryDate: 
publishDate: ''
_build:
  list: never
reading_time: false
share: false
output:
  html_document:
    keep_md: true
---

## Aufgabe 1

Bei einem Gewinnspiel auf dem Jahrmarkt wird aus zwei Töpfen eine Kugel gezogen. In beiden Töpfen gibt es jeweils eine Kugel der Farben rot, grün, blau und gelb.

* Wie viele Kombinationsmöglichkeiten an Ziehungen gibt es, wenn jeweils eine Kugel gezogen wird. Lassen Sie sich diese ausgeben.

<details><summary>Lösung</summary>

An dieser Stelle zunächst eine generelle Anmerkung: Für einige der nachfolgenden Aufgaben wird es - wie eigentlich fast immer in `R` - mehrere Lösungswege geben. Die hier gezeigten Wege sind also exemplarische Vorlagen.


```r
topf <- c('rot','gruen','blau','gelb')
kombis <- expand.grid(topf, topf)
nrow(kombis)
```

```
## [1] 16
```

Es gibt demnach 16 Möglichkeiten.

</details>

* Wenn mindestens eine der beiden gezogenen Kugeln grün ist, gewinnen Sie das Spiel. Lassen Sie sich von R ausgeben, wie viele mögliche Ziehungskombinationen einen Gewinn beinhalten.

<details><summary>Lösung</summary>


```r
kombis$gewinn <- kombis$Var1 == 'gruen'|kombis$Var2 == 'gruen'
sum(kombis$gewinn == TRUE)
```

```
## [1] 7
```

Die Spalte `gewinn` enthält hier in logischer Form Informationen darüber, ob eine der beiden Kugeln grün war. Der vertikale Strich `|` steht dabei für einen oder-Zusammenhang. `gewinn` wird `TRUE`, wenn entweder `Var1` oder `Var2` mit `gruen` an dieser Stelle gefüllt ist. Dabei entsteht auch `TRUE`, wenn beide logischen Überprüfungen `TRUE` anzeigen. Danach muss also nur noch die Summe der `TRUE` Einträge geprüft werden. Diese ist 7.

</details>

## Aufgabe 2

Eine typischer Münzwurf bietet die Optionen Kopf oder Zahl.

* Simulieren Sie mithilfe von R einen Münzwurf.

<details><summary>Lösung</summary>


```r
muenze <- c('Kopf', 'Zahl')
sample(x = muenze, size = 1)
```

```
## [1] "Zahl"
```

</details>

* Replizieren Sie diesen Wurf nun fünf Mal. Lassen Sie sich dabei in einem abgespeicherten Objekt logisch (`TRUE` oder `FALSE`) ausgeben, ob die Münze Kopf angezeigt hat. Verwenden Sie zur Konstanthaltung einen Seed von 1901.

<details><summary>Lösung</summary>


```r
set.seed(1901)
kopfwurf <- replicate(n = 5, expr = sample(x = muenze, size = 1)=="Kopf")
```

Natürlich wäre es auch möglich, erst die 5 Replikationen in einem Objekt abzulegen und dieses dann auf Kopf-Würfe zu untersuchen. Allerdings kann diese Operation auch gleich in die `replicate` Funktion mit eingebaut werden.

</details>


* Welchem Wert würde sich der Mittelwert des eben abgespeicherten Objektes im unendlichen Fall annähern?

<details><summary>Lösung</summary>

`TRUE` und `FALSE` werden wie bereits besprochen als `1` und `0` in `R` behandelt. Bei unendlichen Würfen sollte man erwarten, dass Kopf und Zahl gleich häufig vorkommen. Demnach stehen in unserem Objekt gleich viele `TRUE` und `FALSE` Angaben. Der Mittelwert würde gegen 0.5 gehen.

</details>

## Aufgabe 3

Sie wollen an einem Gewinnspiel mit Losen teilnehmen. Dafür hat der Veranstalter ein computerbasiertes Vorgehen, in dem in 70% der Fällen Nieten angezeigt werden.

* Wie wahrscheinlich ist es, dass Sie in 10 Versuchen genau 4 Mal einen Gewinn erhalten?

<details><summary>Lösung</summary>


```r
dbinom(x = 4, size = 10, prob = 0.3)
```

```
## [1] 0.2001209
```

</details>

* Plotten Sie die Wahrscheinlichkeitsverteilung für die 10 Versuche!

<details><summary>Lösung</summary>


```r
x <- c(0:10)
probs <- dbinom(x, size = 10, prob = 0.3)
plot(x = x, y = probs, type = "h", xlab = "Häufigkeiten eines Gewinns", ylab = "Wahrscheinlichkeit bei 10 Versuchen")
```

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-37-1.png)<!-- -->

</details>

* Wie wahrscheinlich ist es, dass Sie in 10 Versuchen minimal 5 Gewinne erhalten?

<details><summary>Lösung</summary>


```r
pbinom (q = 4, size = 10, prob = 0.3, lower.tail = FALSE)
```

```
## [1] 0.1502683
```

Durch `q = 4` und `lower.tail = FALSE` werden hier die Werte der Wahrscheinlichkeiten von 5 bis 10 Gewinnen aufaddiert.

</details>

* Wie wahrscheinlich ist es, dass Sie minimal 6 und höchstens 8 Gewinne erhalten?

<details><summary>Lösung</summary>


```r
pbinom(q = 8, size = 10, prob = 0.3) - pbinom(q = 5, size = 10, prob = 0.3)
```

```
## [1] 0.0472053
```

Hier berechnen wir zunächst die Wahrscheinlichkeit, maximal 8 (d.h. 8 oder weniger) Gewinne zu erzielen und ziehen dann die Wahrscheinlichkeit ab, maximal 5 Gewinne zu erzielen. Somit erhalten wir die Wahrscheinlichkeit dafür, mindestens 6 und maximal 8 Gewinne zu erhalten.

</details>

* Der Preis pro Gewinn beträgt 2€. Sollten Sie bei einem Einsatz von 5€ pro 10 Versuche mitspielen?

<details><summary>Lösung</summary>

Hier sollte herausgefunden werden, welchen Erwartungswert man für die Teilnahme hat. 30% der Versuche sollten Gewinne sein.


```r
anzahlGewinne <- 10*.3       #Erwartungswert bei 10 Versuchen
GeldErw <- anzahlGewinne * 2 #Erwartungswert in Euro
GeldErw > 5  
```

```
## [1] TRUE
```

Die letzte Zeile vergleicht unseren erwarteten Gewinn in Euro mit dem Einsatz. Da der durchschnittliche Gewinn höher ist als der Einsatz - anders als in Gewinnspielen in der realen Welt - sollte man hier wohl mitspielen.

</details>

## Aufgabe 4

Ein Fragebogen zum Thema Stressempfinden wird so konzipiert, dass die Verteilung der Testwerte einer Normalverteilung mit einem Mittelwert von 50 und einer Standardabweichung von 10 folgt.

* Zeichnen Sie die Dichtefunktion für Testwerte zwischen 30 und 70!

<details><summary>Lösung</summary>


```r
curve (expr = dnorm (x, mean = 50, sd = 10),
       from = 30,
       to = 70,
       main = "Dichtefunktion",
       xlab = "Stress-Werte",
       ylab = "Dichte")
```

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-41-1.png)<!-- -->

</details>

* Standardisieren Sie die Verteilung gedanklich. Welche Ihnen bekannte Verteilung wäre das? Zeichnen Sie zur Hilfe die Dichtefunktion für Werte zwischen -2 und 2 mit einem Mittelwert von 0 und einer Standardabweichung von 1.

<details><summary>Lösung</summary>

Die standardisierte Verteilung entspricht der Standardnormalverteilung. Das wird auch durch die Zeichnung verdeutlicht.


```r
curve (expr = dnorm (x, mean = 0, sd = 1),
       from = -2,
       to = 2,
       main = "Standardnormalverteilung",
       xlab = "standardisierte Stress-Werte",
       ylab = "Dichte")
```

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-42-1.png)<!-- -->

</details>

* Nach dem Ausfüllen des Fragebogens erhalten zwei Personen Ihre Ergebnisse. Person 1 hat einen z-Wert von 0.5, während Person 2 einen Wert von 66 auf der beschriebenen Skala erreicht. Wer empfindet höheren Stress?

<details><summary>Lösung</summary>

Ein einfacher Weg ist die Standardisierung des Skalenwertes nach der Formel.


```r
(66-50)/10
```

```
## [1] 1.6
```

Wir sehen, dass die Person einen höheren z-Wert hat, also mehr Stress empfindet.

</details>

* Für welchen z-Wert gilt stets die Aussage, dass die Verteilungsfunktion den y-Wert von 0.5 erreicht?

<details><summary>Lösung</summary>

Dies gilt stets für einen z-Wert von 0, denn die Dichtefunktion ist symmetrisch mit der möglichen Spiegelung bei 0.

</details>

* Zeichnen Sie die Verteilungsfunktion für die Standardnormalverteilung in den bereits verwendeten Grenzen.

<details><summary>Lösung</summary>


```r
curve (expr = pnorm (x, mean = 0, sd = 1),
       from = -2,
       to = 2,
       main = "Verteilungsfunktion",
       xlab = "standardisierte Testwerte",
       ylab = "F(x)")
```

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-44-1.png)<!-- -->

</details>

## Aufgabe 5

Zum Abschluss werden wir auch hier eine Variable aus unserem Datensatz betrachten. Dabei wird es um Neurotizismus gehen. Den Datensatz haben wir bereits heruntergeladen, können ihn aber auch online abrufen. Beachten müssen wir, dass bereits Veränderungen vorgenommen wurden, die [hier](/lehre/statistik-i/verteilungen/#prep) zusammengefasst werden.

* Laden Sie den Datensatz zunächst in ihr Environment ein und überprüfen Sie, ob die Variable `neuro` den passenden Typ für unsere Betrachtung hat!

<details><summary>Lösung</summary>


```r
load(url('https://pandar.netlify.app/daten/fb23.rda'))
is.numeric(fb23$neuro)
```

```
## [1] TRUE
```

Einladen können wir den Datensatz über den gewohnten Befehl. Wir geben hier die Vorbereitung der anderen Befehle nicht nochmal an, da `neuro` als Variable bereits existiert und der Text hier nicht zu lang werden soll.

Da wir Werte wie den Mittelwert für die Überprüfung der Normalverteilung verwenden werden, ist es nötig, eine numerische Variable vorliegen zu haben (`is.numeric`). Das Resultat `TRUE` zeigt uns an, dass dies gegeben ist.

</details>

* Überprüfen Sie, ob die Variable fehlende Werte enthält. Bestimmen Sie anschließend den Mittelwert der Variable.

<details><summary>Lösung</summary>

```r
fb23$neuro |> is.na() |> sum()
```

```
## [1] 0
```

```r
mean(fb23$neuro) 
```

```
## [1] 3.354749
```
Ein Lösungsansatz ist es, die Variable `neuro` als Vektor zu nehmen und erstmal für jeden Eintrag zu überprüfen, ob dieser fehlt. Dann würde ein `TRUE` entstehen. Da dieses als 1 gewertet wird, können wir anschließend mit `sum` die Anzahl der fehlenden Werte ermitteln. In diesem Fall ergibt sich 0 - also kein Wert fehlt. Der Mittelwert kann demnach ohne Ergänzungen zu den `NA` mit der Funktion `mean` direkt bestimmt werden.

</details>

* Erstellen Sie für die Variable ein Histogramm mit sinnvollen Begrenzungen auf der x-Achse und der theoretisch erwarteten Normalverteilung. Bewerten Sie diese auch hinsichtlich der Passung!

<details><summary>Lösung</summary>

```r
hist(fb23$neuro, xlim=c(0,6), main="Score", xlab="", ylab="", prob=T)
curve(dnorm(x, mean=mean(fb23$neuro), sd=sd(fb23$neuro)), add=T)
```

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-47-1.png)<!-- -->
Der Befehl unterscheidet sich zunächst nicht von der Betrachtung im Tutorial. Logischerweise muss nur alles auf die Variable `neuro` angewendet werden. Jedoch sehen wir, dass der Plot leider oben leicht abgeschnitten wird, wenn wir die Linie der Normalverteilung hinzufügen. Dies kann durch eine Modifikation der y-Achse `y-lim` umgangen werden:


```r
hist(fb23$neuro, xlim=c(0,6), ylim=c(0,0.5), main="Score", xlab="", ylab="", prob=T)
curve(dnorm(x, mean=mean(fb23$neuro), sd=sd(fb23$neuro)), add=T)
```

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-48-1.png)<!-- -->

Wir sehen leichte Abweichungen des Histogramms von der theoretischen Kurve. Vor allem im unteren Bereich bei einem Wert von 1 bis 2.5 sind Personen, die die Verteilung nicht erwarten würde, während im oberen Teil (über 5) Leute fehlen (was ja auch logisch ist, da es keinen höheren Wert geben konnte aufgrund der Konstruktion der Fragen). Auch wenn diesmal Abweichungen deutlicher zu sehen sind als im Tutorial, würde man noch keine starke Verletzung attestieren, da die Form der Glocke auch gut dargestellt wird.

</details>

* Führt die Betrachtung des Histogramms und eine Betrachtung eines QQ-Plots zum selben Ergebnis? Zusatz: Versuchen Sie, die Linie im Plot rot zu färben!

<details><summary>Lösung</summary>

Wir haben im Tutorial gelernt, dass die Erstellung einer standardisierten Variable die Interpretierbarkeit eines solchen Plots fördern kann. 



```r
fb23$neuro_std <- scale(fb23$neuro, center = T, scale = T)
hist(fb23$neuro_std, xlim=c(-3,3), ylim=c(0,0.5), main="Score", xlab="", ylab="", prob=T)
curve(dnorm(x, mean=mean(fb23$neuro_std), sd=sd(fb23$neuro_std)), add=T)
```

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-49-1.png)<!-- -->



```r
qqnorm(fb23$neuro_std)
qqline(fb23$neuro_std, col = "red")
```

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-50-1.png)<!-- -->

Der QQ-Plot zeigt ein ähnliches Muster wie das Histogramm. In der empirischen Verteilung gibt es auf der linken Seite vereinzelt zu hohe Werte, die durch die theoretische Verteilung nicht so zu erwarten wären (liegen oberhalb der Linie - Personen haben z-Werte leicht unter -2 obwohl bis zu -3 erwartet wird). Die Werte liegen über den Erwartungen - streuen zu weit nach rechts. Auf auf der rechten Seite wiederum bleiben einige empirischen Werte unter den theoretisch erwarteten zurück (liegen unterhalb der Linie - Personen haben z-Werte unter 2, obwohl über 2 erwartet wird). Hier bedeutet dies, dass unsere empirischen Werte nicht weit genug nach rechts streuen.

Trotzdem ist auch hier die Verletzung auf wenige Punkte fokussiert, weshalb wir keine starke Verletzung annehmen. Die Färbung erhalten wir in diesem Fall dadurch, dass wir in `qqline` noch eine Farbe im Argument `col` ergänzen.

</details>
