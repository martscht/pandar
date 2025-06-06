---
title: Simulation und Poweranalyse - Übungen
type: post
date: '2019-10-18'
slug: simulation-poweranalyse-uebungen
categories: Statistik I Übungen
tags: []
subtitle: ''
summary: ''
authors:
- irmer
- sinn
weight: ~
lastmod: '2025-05-13'
featured: no
banner:
  image: /header/windmills_but_fancy.jpg
  caption: '[Courtesy of pxhere](https://pxhere.com/en/photo/1178076)'
projects: []
reading_time: no
share: no
links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-i/simulation-poweranalyse
- icon_pack: fas
  icon: star
  name: Lösungen
  url: /lehre/statistik-i/simulation-poweranalyse-loesungen
output:
  html_document:
    keep_md: yes
private: 'true'
---




## Aufgabe 1
### Lineare Beziehungen zwischen Variablen: Korrelationstest unter $H_1$
Wir wollen uns ebenfalls die Power für den Korrelationstest ansehen. Dazu müssen wir allerdings korrelierte Variablen generieren. Um das hinzubekommen, müssen wir einige Eigenschaften der Normalverteilung ausnutzen: bspw. dass die Summe zweier normalverteilter Zufallsvariablen wieder normalverteilt ist. Für zwei unabhängige (unkorrelierte) standardnormalverteilte Zufallsvariablen $X$ und $Z$, ist die Zufallsvariable $Y$, die folgendermaßen gebildet wird:

$$Y:= \rho X + \sqrt{1-\rho^2}Z,$$

wieder standardnormalverteilt und um den Korrelationskoeffizienten $\rho$ korreliert mit $X$. Wir können also relativ einfach zwei korrelierte Variablen generieren. Wie in der Sitzung verwenden wir $N=20$:


```r
N <- 20

set.seed(12345)
X <- rnorm(N)
Z <- rnorm(N)
Y <- 0.5*X + sqrt(1 - 0.5^2)*Z
cor(X, Y) # empirische Korrelation
```

```
## [1] 0.579799
```

```r
sd(X) 
```

```
## [1] 0.8339354
```

```r
sd(Y)
```

```
## [1] 1.232089
```

Falls Sie die oben genutzte Formel zur Generierung korrelierter Zufallsvariablen überprüfen wollen, dann setzen Sie doch einmal `N = 10^6` (also eine Stichprobe von 1 Mio). Dann sollte die empirische Korrelation sehr nah an der theoretischen liegen. Auch sollten dann die empirischen Standardabweichungen sehr nah an der 1 liegen.

Verwenden Sie für diese Aufgabe stets den Seed 12345 (`set.seed(12345)`).

* Betrachten Sie das Modell für eine Stichprobe von `N = 10^6`. Berichten Sie die empirische Korrelation sowie die empirischen Standardabweichungen.
* Untersuchen Sie die Power des Korrelationstests für eine Korrelation von $\rho=0.5$ und $N = 20$. Führen Sie eine Simulationsstudie durch. Wie groß ist die Power?
* Stellen Sie die Verteilung  der empirischen Korrelationen (für $\rho=0.5$ und $N=20$) unter der $H_1$ dar.

## Aufgabe 2
### Lineare Beziehungen zwischen Variablen: Korrelationstest unter $H_1$ für ungleiche Varianzen

Wiederholen Sie die Analyse. Verändern Sie diesmal die Varianz der beiden Variablen `X` und `Y`. `X` soll eine Varianz von 9 haben (multiplizieren Sie dazu `X` mit 3, nachdem Sie `Y` mithilfe von `X` und `Z` generiert haben), und `Y` soll eine Varianz von 0.25 haben (multiplizieren Sie dazu `Y` mit 0.5, nachdem Sie `Y` mit Hilfe von `X` und `Z` generiert haben). 

* Betrachten Sie das Modell für eine Stichprobe von `N = 10^6`. Berichten Sie die empirische Korrelation sowie die empirischen Standardabweichungen.
* Führen Sie eine Simulationsstudie durch (für $\rho=0.5$ und $N=20$). Wie verändert sich die Power des Tests durch die veränderten Varianzen?

## Aufgabe 3
### Sensitivitätsanalyse für die Korrelation

In den [Inhalten](/lehre/statistik-i/simulation-poweranalyse/) zu dieser Sitzung haben Sie neben der Poweranalyse auch die Sensitivitätsanalyse für den $t$-Test kennengelernt. Diese lässt sich mithilfe des Pakets `WebPower` auch für die Korrelation durchführen.

* Laden Sie zunächst das Paket `WebPower` und schauen Sie sich die Funktion für die Poweranalyse bei einer Korrelation an.
* Nehmen Sie an, dass Sie eine Gruppe von $N=50$ Personen untersucht haben. Sie möchten nun wissen, wie groß der Korrelationskoeffizient theoretisch sein müsste, damit eine Power von $95\\%$ erreicht werden kann. Das $\alpha$-Fehleriveau soll dabei bei $0.05$ liegen.

## Aufgabe 4
### Type I-Error und Power zu einem $\alpha$-Niveau von $0.1$ des $t$-Test

Wir wollen nun die Power des $t$-Tests für ein anderes $\alpha$-Fehlerniveau bestimmen. Wiederholen Sie also die Poweranalysen aus der Sitzung für den $\alpha$-Fehler und die Power für ein $\alpha$-Fehlerniveau von $0.1$.

Nutzen Sie den Seed 12345 (`set.seed(12345)`).

* Führen Sie eine Simulation durch, um das empirische $\alpha$-Niveau des $t$-Tests zu bestimmen für $N=20$. Vergleichen Sie das Ergebnis mit dem Ergebnis aus der Sitzung.
* Führen Sie eine Simulation durch, um die empirische Power des $t$-Tests zu bestimmen für $N=20$, $d = 0.5$ und $\alpha = 0.1$. Vergleichen Sie das Ergebnis mit dem Ergebnis aus der Sitzung. Was bedeutet dies für die Wahl der Irrtumswahrscheinlichkeit?

## Aufgabe 5
### Power-Plots für den $t$-Test

Wir wollen nun die Power des $t$-Tests für unterschiedliche Effektgrößen untersuchen. In den beiden Gruppen soll jeweils eine Varianz von 1 herrschen. Verändern Sie also den Code der Sitzung nur hinsichtlich der Effektgröße. Das $\alpha$-Fehlerniveau soll wieder bei $0.05$ liegen.

Nutzen Sie den Seed 12345 (`set.seed(12345)`).

* Erstellen Sie einen Power-Plot für die folgenden Effekte $d = 0, 0.25, 0.5, 0.75, 1,$ und $1.25$ bei einer Stichprobengröße von $N = 20$. Stellen Sie die Effektgröße auf der x-Achse dar.

* Welcher Effekt muss mindestens bestehen, damit die Power bei $80\%$ liegt?

## Aufgabe 6
### Powervergleich: $t$-Test vs. Wilcoxon-Test

Wir wollen nun die Power des $t$-Tests mit der Power des Wilcoxon-Tests vergleichen. Der Wilcoxon-Test ist flexibler anzuwenden, da er weniger Annahmen aufweist. Untersuchen Sie, wie sich dies auf die Power auswirkt. Das $\alpha$-Fehlerniveau soll wieder bei $0.05$ liegen.

Nutzen Sie den Seed 12345 (`set.seed(12345)`).

* Verwenden Sie das gleiche Setting wie aus der Sitzung und bestimmen Sie die Power des Wilcoxon-Tests für $N=20$, $d = 0.5$ und $\alpha = 0.05$. Vergleichen Sie das Ergebnis mit dem Ergebnis aus der Sitzung. 
