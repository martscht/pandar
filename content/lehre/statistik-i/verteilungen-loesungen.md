---
title: "Verteilungen - Lösungen" 
type: post
date: '2020-11-16' 
slug: verteilungen-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [nehler, zacharias] 
lastmod: '2023-11-21'
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

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

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

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

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

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

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

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

</details>

## Aufgabe 5 (Transferaufgabe)

Eine Schlafforscherin plant die Messung der Zeit (in Minuten), die Menschen benötigen, um nach einem stressigen Tag einzuschlafen. Sie geht davon aus, dass die gemessenen Werte einer Exponentialverteilung mit einer Rate (Kehrwert der mittleren Zeit bis zum Einschlafen) von λ = 0.05 folgen.

* Nutzen Sie die Hilfe in R, um die Funktion für die Exponentialverteilung zu finden.

<details><summary>Lösung</summary>


```r
?distributions
```

Wir erhalten eine Übersicht über die Verteilungen, die in im `stats`-Paket verfügbar sind. Die Exponentialfunktion ist über das Kürzel `exp()` und den entsprechenden Präfix (`d`, `p`, `q`, `r`) aufrufbar.  

</details>

* Zeichnen Sie die Dichtefunktion der Exponentialverteilung für die Einschlafzeit von 0 bis 60 Minuten.

<details><summary>Lösung</summary>


```r
curve(expr = dexp(x, rate = 0.05), 
      from = 0, 
      to = 60,
      main = "Exponentialverteilung",
      xlab = "Einschlafzeit (Minuten)",
      ylab = "Dichte f(x)")
```

![](/lehre/statistik-i/verteilungen-loesungen_files/figure-html/unnamed-chunk-15-1.png)<!-- -->
</details>

* Berechnen Sie die Wahrscheinlichkeit, dass eine Person 
a) bis zu 10 Minuten und
b) zwischen 15 und 20 Minuten 
benötigt, um nach einem stressigen Tag einzuschlafen. Nutzen Sie hierzu beide Male die Funktion `integrate()` und vergleichen Sie das Ergebnis im Anschluss jeweils mit dem Resultat, das Sie erhalten, wenn Sie die vordefinierte Verteilungsfunktion mit dem entsprechenden Präfix verwenden. 

<details><summary>Lösung</summary>
Die Wahrscheinlichkeit, dass eine Person bis zu 10 Minuten benötigt, um einzuschlafen, berechnet sich wie folgt:

```r
# manuell mit integrate()
integrate(f = dexp, lower = 0, upper = 10, rate = 0.05)
```

```
## 0.3934693 with absolute error < 4.4e-15
```

```r
# über Verteilungsfunktion pexp()
pexp(10, rate = 0.05, lower.tail = TRUE)
```

```
## [1] 0.3934693
```
Wir erhalten das gleiche Ergebnis und mit der `integrate`-Funktion noch zusätzlich die Angabe über die Genauigkeit unserer Berechnung. 
Die Wahrscheinlichkeit, dass eine Person zwischen 15 und 20 Minuten benötigt, um einzuschlafen, berechnet sich wie folgt:


```r
# manuell mit integrate()
integrate(f = dexp, lower = 15, upper = 20, rate = 0.05)
```

```
## 0.1044871 with absolute error < 1.2e-15
```

```r
# über Verteilungsfunktionp exp()
pexp(20, rate = 0.05, lower.tail = TRUE) - pexp(15, rate = 0.05, lower.tail = TRUE)
```

```
## [1] 0.1044871
```
Wir stellen fest, die Ergebnisse stimmen wieder überein. 

</details>
