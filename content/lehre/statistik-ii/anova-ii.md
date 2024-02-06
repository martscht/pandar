---
title: "ANOVA II: zweifaktorielle ANOVA"
type: post
date: '2021-03-30' 
slug: anova-ii
categories: ["Statistik II"] 
tags: ["ANOVA","Zweifaktoriell", "Kontraste"] 
subtitle: '2-fakt. ANOVA'
summary: ''
authors: [irmer,scheppa-lahyani,schultze]
weight: 8
lastmod: '2024-02-06'
featured: no
banner:
  image: "/header/heart_alien.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1293359)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-ii/anova-ii
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-ii/anova-ii.R
  - icon_pack: fas
    icon: pen-to-square
    name: Quizdaten
    url: /lehre/statistik-ii/quizdaten-bsc7#Quiz4
output:
  html_document:
    keep_md: true
---



In der letzten Sitzung haben wir die [einfaktorielle Varianzanalyse](/post/anova1) behandelt. Die spezifische Benennung als *einfaktoriell* verdeutlicht schon, dass wir hier ansetzen und Erweiterungen vornehmen können. In dieser Sitzung geht es vor allem um die *zweifaktorielle* Varianzanalyse. Ziel dieser Analyse ist es gleichzeitig Gruppenunterschiede auf mehreren (um genau zu sein 2 im zweifaktoriellen Fall) Variablen zu untersuchen und dabei zu überprüfen, ob Kombinationen von Gruppen besondere Auswirkungen haben. Für weitere Inhalte siehe bspw. auch [Eid, Gollwitzer und Schmitt (2017, Kapitel 13 und insb. 13.2 und folgend)](https://hds.hebis.de/ubffm/Record/HEB366849158).

Wir arbeiten wieder mit dem `conspiracy` Datensatz. Sie können den im Folgenden verwendeten [<i class="fas fa-download"></i> Datensatz "conspiracy.rda" hier herunterladen](../../daten/conspiracy.rda).

### Daten laden
Wir laden zunächst die Daten: entweder lokal von Ihrem Rechner:


```r
load("C:/Users/Musterfrau/Desktop/conspiracy.rda")
```

oder wir laden sie direkt über die Website:


```r
load(url("https://pandar.netlify.app/post/conspiracy.rda"))
```

Eine kurze Übersicht über den Datensatz zeigt:


```r
dim(conspiracy)
```

```
## [1] 2451    9
```

Der Datensatz enthält die Werte von 2451 Personen auf 9 Variablen. 


```r
head(conspiracy)
```

```
##              edu    urban gender age       GM       MG       ET       PW       CI
## 2     highschool suburban female  14 4.000000 5.000000 4.666667 3.333333 4.666667
## 3        college suburban female  26 2.000000 4.000000 1.500000 2.000000 3.333333
## 4        college    rural   male  25 5.000000 4.333333 1.000000 3.333333 4.666667
## 5 not highschool suburban   male  37 5.000000 4.333333 2.333333 3.333333 4.666667
## 6        college    rural   male  34 1.000000 1.000000 1.000000 1.000000 1.000000
## 7 not highschool suburban   male  17 3.333333 2.666667 3.000000 2.666667 3.666667
```

Er stammt aus einer Untersuchung zum Thema *verschwörungstheoretische Überzegungen*. Die **ersten vier Variablen** enthalten Informationen über den demographischen Hintergrund der Personen: höchster Bildungsabschluss (`edu`), Typ des Wohnortes (`urban`), Geschlecht (`gender`) und Alter (`age`). Die **fünf restlichen Variablen** sind Skalenwerte bezüglich verschiedener subdimensionen verschwörungstheoretischer Überzeugungen: `GM` (goverment malfeasance), `MG` (malevolent global conspiracies), `ET` (extraterrestrial cover-up), `PW` (personal well-being) und `CI` (control of information).


## Einfaktorielle ANOVA

In der letzten Sitzung zeigte sich, dass die Überzeugung, dass die Existenz von Außerirdischen durch eine globale Verschwörung verdeckt wird (`ET`), von der Art des Wohngebiets (`urban`) abhängig ist. Zur Berechnung der einfaktoriellen ANOVA wurde das `ez`-Paket verwendet. Dieses Paket brauchen wir weiterhin:


```r
library(ez)
```

```
## Warning: Paket 'ez' wurde unter R Version 4.2.3 erstellt
```

Wie schon in der letzten Sitzung, ist es zunächst erforderlich eine Personen-ID zu erzeugen. In diesem Fall kann einfach die Zeilennummer einer Person genutzt werden:


```r
conspiracy$id <- as.factor(1:nrow(conspiracy))
```

Wir führen zur kurzen Wiederholung noch einmal die einfaktorielle ANOVA bezüglich des Wohnortes durch, um uns zu vergegenwärtigen, wie der `ezANOVA`-Befehl funktioniert! Der `ezANOVA` Befehl, um eine einfaktorielle ANOVA durchzuführen, braucht vier Argumente: `data` übergeben wir unseren Datensatz (`data = conspiracy`), `wid` kennzeichnet den Within-Identifier, eine Personen ID Variable, weswegen wir diesem Argument unsere ID-Variable übergeben (`wid = id`),  `dv` steht für "Dependent Variable", also abhängige Variable, weswegen wir hier die Überzeugung, dass die Existenz von Außerirdischen durch eine globale Verschwörung verdeckt wird, übergeben (`dv = ET`), `between` ist die unabhängige Variable, die zwischen Personen unterscheidet, also die Gruppierungsvariable für deren Effekt wir uns interessieren, hier die Art des Wohngebiets (`between = urban`).


```r
ezANOVA(data = conspiracy, wid = id, dv = ET, between = urban)
```

```
## Warning: Data is unbalanced (unequal N per group). Make sure you specified a
## well-considered value for the type argument to ezANOVA().
```

```
## Coefficient covariances computed by hccm()
```

```
## $ANOVA
##   Effect DFn  DFd        F          p p<.05         ges
## 1  urban   2 2448 3.434118 0.03240931     * 0.002797802
## 
## $`Levene's Test for Homogeneity of Variance`
##   DFn  DFd     SSn      SSd        F         p p<.05
## 1   2 2448 3.62836 1752.977 2.533469 0.0795913
```

Die Ergebnisse zeigen, dass die Annahme der Homoskedastizität nicht verworfen werden muss ($p$ > .05) und dass es bedeutsame Unterschiede zwischen verschiedenen Wohnorten hinsichtlich der verschwörungstheoretischen Überzeugung gibt, dass die Existenz Außerirdischer absichtlich verschleiert wird.

Die Ergebnisse aus den Übungsaufgaben ergaben bezüglich des Bildungabschlusses:


```
## Warning: Data is unbalanced (unequal N per group). Make sure you specified a
## well-considered value for the type argument to ezANOVA().
```

```
## Coefficient covariances computed by hccm()
```

```
## $ANOVA
##   Effect DFn  DFd        F            p p<.05
## 1    edu   2 2448 37.10788 1.329579e-16     *
## 
## $`Levene's Test for Homogeneity of Variance`
##   DFn  DFd     SSn     SSd        F            p p<.05
## 1   2 2448 33.5895 1808.96 22.72773 1.659556e-10     *
```

Hier musste die Annahme der Homoskedastizität verworfen werden ($p$ < .05), sodass eine Adjustierung der Inferenzstatistik durchgeführt werden sollte (`white.adjust = TRUE`). Im ersten Fall erhalten wir auch das generalisierte partielle $\eta^2$, also einen Schätzer der Effektstärke, die im Grunde angibt, wie viel systematische Variation in den Daten ist, relativ zur zufälligen Schwankung. Um dies in der Skala der ursprünglichen Variablen zu interpretieren, können wir uns rein deskriptiv die gruppenspezifischen Mittelwerte angucken. Dazu kann mit einer Vielzahl von Funktionen gearbeitet werden. Eine gängige Variante ist der `tapply`-Befehl:


```r
tapply(X = conspiracy$ET, INDEX = conspiracy$urban, FUN = mean)
```

```
##    rural suburban    urban 
## 2.194386 2.150963 2.307286
```

```r
tapply(X = conspiracy$ET, INDEX = conspiracy$edu, FUN = mean)
```

```
## not highschool     highschool        college 
##       2.369340       2.443033       1.937717
```

Dieser Funktion müssen jeweils die Daten (`X`), ein Index für Gruppierung (`INDEX`) sowie eine Funktion, die auf die Subgruppen angewendet werden soll (`FUN`, hier der Mittelwert, deshalb `FUN = mean`), übergeben werden. Es gibt jedoch noch unzählbar viele andere Wege zum selben Ergebnis zu kommen. Hier einige Beispiele:


```r
# Mithilfe des aggregate-Befehls
aggregate(ET ~ urban, data = conspiracy, mean)
```

```
##      urban       ET
## 1    rural 2.194386
## 2 suburban 2.150963
## 3    urban 2.307286
```

```r
aggregate(ET ~ edu, data = conspiracy, mean)
```

```
##              edu       ET
## 1 not highschool 2.369340
## 2     highschool 2.443033
## 3        college 1.937717
```

```r
# Mithilfe des aggregate-Befehls mit anderer Schreibweise (wie bei tapply)
aggregate(conspiracy$ET, list(conspiracy$urban), mean)
```

```
##    Group.1        x
## 1    rural 2.194386
## 2 suburban 2.150963
## 3    urban 2.307286
```

```r
aggregate(conspiracy$ET, list(conspiracy$edu), mean)
```

```
##          Group.1        x
## 1 not highschool 2.369340
## 2     highschool 2.443033
## 3        college 1.937717
```

```r
# Mithilfe des describeBy-Befehls aus dem psych-Paket
library(psych)
describeBy(conspiracy$ET, conspiracy$urban)
```

```
## 
##  Descriptive statistics by group 
## group: rural
##    vars   n mean   sd median trimmed  mad min max range skew kurtosis   se
## X1    1 475 2.19 1.32   1.67    2.02 0.99   1   5     4 0.74    -0.81 0.06
## ------------------------------------------------------------------ 
## group: suburban
##    vars    n mean  sd median trimmed  mad min max range skew kurtosis   se
## X1    1 1125 2.15 1.3   1.67    1.97 0.99   1   5     4 0.81    -0.65 0.04
## ------------------------------------------------------------------ 
## group: urban
##    vars   n mean   sd median trimmed  mad min max range skew kurtosis   se
## X1    1 851 2.31 1.36      2    2.15 1.48   1   5     4 0.62    -0.98 0.05
```

```r
describeBy(conspiracy$ET, conspiracy$edu)
```

```
## 
##  Descriptive statistics by group 
## group: not highschool
##    vars    n mean   sd median trimmed  mad min max range skew kurtosis   se
## X1    1 1060 2.37 1.36      2    2.23 1.48   1   5     4 0.54    -1.07 0.04
## ------------------------------------------------------------------ 
## group: highschool
##    vars   n mean   sd median trimmed  mad min max range skew kurtosis   se
## X1    1 433 2.44 1.36   2.33    2.32 1.98   1   5     4 0.48    -1.11 0.07
## ------------------------------------------------------------------ 
## group: college
##    vars   n mean   sd median trimmed  mad min max range skew kurtosis   se
## X1    1 958 1.94 1.22   1.33    1.72 0.49   1   5     4 1.11    -0.01 0.04
```

## Deskriptive Darstellung der Kombinationen

In der mehrfaktoriellen ANOVA steht nicht nur der Vergleich von Gruppen anhand *einer* unabhängigen Variable im Mittelpunkt, sondern der Fokus liegt auf der *Kombination von Gruppierungen* anhand mehrerer unabhängiger Variablen. Deksriptiv können die Mittelwerte aus Gruppenkombinationen ebenfalls mit der `tapply`-Funktion bestimmt werden:


```r
# Gruppierungskombinationen erstellen
kombi <- conspiracy[, c('urban', 'edu')]

# Kombinationsspezifische Mittelwertetabelle
tapply(X = conspiracy$ET, INDEX = kombi, FUN = mean)
```

```
##           edu
## urban      not highschool highschool  college
##   rural          2.402778   2.333333 1.911458
##   suburban       2.244748   2.382902 1.914868
##   urban          2.510870   2.601990 1.979465
```

Im `ez`-Paket sind neben den Funktionen zur direkten Berechnung von Varianzanalysen auch einige zusätzliche Hilfefunktionen integriert. Dazu gehört die `ezStats`-Funktion, die die Darstellung von Gruppengrößen, Mittelwerten und Standardabweichungen innerhalb der einzelnen Gruppenkombinationen erlaubt. Die Argumente, die diese Funktion erwartet, sind analog zu denen in der `ezANOVA`-Funktion:

  - `data = `: der genutzte Datensatz
  - `wid = `: eine Personen ID-Variable
  - `dv = `: die abhängige Variable (dependent variable)
  - `between = `: eine Gruppierungsvariable (die *zwischen* Personen unterscheidet)

Um mehrere Variablen als unabhängige Variablen zu deklarieren, kann mit `c()` ein Vektor eröffnet werden, der an das Argument `between` weitergegeben wird.


```r
ezStats(conspiracy, dv = ET, wid = id, between = c(urban, edu))
```

```
## Warning: Data is unbalanced (unequal N per group). Make sure you specified a
## well-considered value for the type argument to ezANOVA().
```

```
## Coefficient covariances computed by hccm()
```

```
## Warning in ezStats(conspiracy, dv = ET, wid = id, between = c(urban, edu)): Unbalanced
## groups. Mean N will be used in computation of FLSD
```

```
##      urban            edu   N     Mean       SD      FLSD
## 1    rural not highschool 216 2.402778 1.376271 0.2195306
## 2    rural     highschool  67 2.333333 1.363300 0.2195306
## 3    rural        college 192 1.911458 1.181458 0.2195306
## 4 suburban not highschool 476 2.244748 1.324632 0.2195306
## 5 suburban     highschool 232 2.382902 1.341716 0.2195306
## 6 suburban        college 417 1.914868 1.217532 0.2195306
## 7    urban not highschool 368 2.510870 1.391729 0.2195306
## 8    urban     highschool 134 2.601990 1.373747 0.2195306
## 9    urban        college 349 1.979465 1.249384 0.2195306
```

Neben $N$, $\bar{X}$ und $\hat{\sigma}$ wird in der Ausgabe auch *Fisher's Least Significant Difference* (FLSD) ausgegeben. Diese kennzeichnet den minimalen Mittelwertsunterschied, der im direkten Vergleich zweier Gruppen signifikant wäre. Schon an dieser Stelle werden wir von `ez` darauf hingewiesen, dass die Gruppen ungleich groß sind und dies in der ANOVA zu Problemen führen könnte.

Für eine grafische Darstellung der Mittelwerte, kann `ezPlot` benutzt werden. Der Befehl nimmt die gleichen Argumente entgegen wie `ezStats`, benötigt aber zusätzlich eine Aussage darüber, welche Variable auf der x-Achse abgetragen werden soll (`x = `) und welche Variable farblich unterschieden werden soll (`split = `). Mit dieser Funktion wird dann ein `ggplot` erstellt. Diesen könnten Sie mit dem, was wir in der [Sitzung zu `ggplot2`](grafiken-ggplot2) besprochen haben, auch händisch erstellen! `ezPlot` nimmt Ihnen hier aber ein wenig Arbeit ab:


```r
ezPlot(conspiracy, dv = ET, wid = id, between = c(urban, edu),
  x = urban, split = edu)
```

```
## Warning: Data is unbalanced (unequal N per group). Make sure you specified a
## well-considered value for the type argument to ezANOVA().
```

```
## Coefficient covariances computed by hccm()
```

```
## Warning in ezStats(data = data, dv = dv, wid = wid, within = within, within_full =
## within_full, : Unbalanced groups. Mean N will be used in computation of FLSD
```

<img src="/lehre/statistik-ii/anova-ii_files/figure-html/unnamed-chunk-14-1.png" style="display: block; margin: auto;" />

Die **FLSD** wird hier in Form von *Error-Bars* dargestellt - durch diese kann also abgeschätzt werden, welche Mittelwerte sich statistisch bedeutsam unterscheiden.

Auf den ersten Blick fällt schon einmal auf, dass Menschen, die als höchsten Bildungsabschluss das College besucht hatten, deutlich niedrigere Mittelwerte hinsichtlich der Verschwörung aufweisen, als jene, die keinen High-School oder maximal einen High-School Abschluss haben. Wir schauen uns dies im Folgenden genauer an, indem wir eine **zweifaktorielle ANOVA** durchführen.

## Zweifaktorielle Varianzanalyse

Mithilfe der zweifaktoriellen Varianzanalyse können drei zentralen Fragen beantwortet werden ([Eid et al., 2017](https://hds.hebis.de/ubffm/Record/HEB366849158), S. 432):

  1. Lassen sich **Unterschiede in der AV** auf **Unterschiede in der 1. UV** zurückführen? (**Haupteffekt 1**, manchmal auch Haupteffekt Faktor A)
  2. Lassen sich **Unterschiede in der AV** auf **Unterschiede in der 2. UV** zurückführen? (**Haupteffekt 2**, manchmal auch Haupteffekt Faktor B)
  3. Hängt der **Einfluss der 1. UV** auf die AV von der **2. UV ab**, bzw. hängt der **Einfluss der 2. UV** von der **1. UV ab**? (**Interaktionseffekt**, manchmal auch Interaktionseffekt A*B)

Im Beispiel wären die Fragen also:

  1. Lassen sich Unterschiede in der ET-Überzeugung (`ET`) auf die Art des Wohnorts (`urban`) zurückführen?
  2. Lassen sich Unterschiede in der ET-Überzeugung (`ET`) auf das Bildungsniveau (`edu`) zurückführen?
  3. Unterschieden sich die Unterschiede aufgrund der Art des Wohnorts (`urban`) zwischen den Bildungsniveaus (`edu`)?

Deskriptiv lässt sich ein Hinweis auf eine Antwort zur 3. Frage in der Abbildung der Mittelwerte darin erkennen, dass innerhalb der Gruppe mit ländlichem Wohnort (`rural`) Personen ohne Highschool Abschluss eine höhere verschwörungstheoretische Überzeugung aufweisen als Personen mit höheren Bildungsabschlüssen, wohingegen sie in den beiden anderen Wohnort-Gruppen einen niedrigeren ET-Wert aufweisen als Personen mit Highschool Abschluss.

Etwas technischer ausgedrückt lassen sich die drei Fragen in Hypothesenpaaren formulieren ([Eid et al., 2017](https://hds.hebis.de/ubffm/Record/HEB366849158), S. 442):

  1. $H_0: \mu_{j \bullet} - \mu = 0$, $\quad H_1: \mu_{j \bullet} - \mu \neq 0$
  2. $H_0: \mu_{\bullet k} - \mu = 0$, $\quad H_1: \mu_{\bullet k} - \mu \neq 0$
  3. $H_0: \mu_{jk} - \mu_{j \bullet} - \mu_{\bullet k} + \mu = 0$, $\quad H_1: \mu_{jk} - \mu_{j \bullet} - \mu_{\bullet k} + \mu \neq 0$

Diese können von den Gleichungen für die zweifaktorielle ANOVA abgeleitet werden. Der beobachtete Wert der i-ten Person aus Stufe j des 1. Faktors (Faktor A) und Stufe k des 2. Faktors (Faktor B) setzt sich wie folgt zusammen:

$$Y_{ijk} := \mu + \alpha_j+\beta_k + \gamma_{jk} + \varepsilon_{ijk} = \mu_{jk} + \varepsilon_{ijk},$$

wobei $\mu$ der Mittelwert über alle Messungen ist (Grand Mean). $\alpha_j$ stellt die Abweichung vom Mittelwert bedingt durch den Faktor A auf der j-ten Stufe, $\beta_k$ die Abweichung von Mittelwert bedingt durch den Faktor B auf der k-ten Stufe dar. $\gamma_{jk}$ ist die Abweichung vom Mittelwert aufgrund der spezifischen Kombination des Faktors A auf der j-ten Stufe und des Faktors B auf der k-ten, was auch die Interaktionen dieser Gruppenkombination genannt wird. Entsprechend stellt $\mu_{jk}$ auch den Mittelwert in Gruppe Faktor A Stufe j und Faktor B Stufe k dar. $\varepsilon_{ijk}$ beschreibt das Residuum, das zufällige Abweichungen in den Gruppen darstellt (dieses wird als normalverteilt und unabhängig mit gleicher Varianz über alle Gruppen hinweg angenommen!). Nun können wir die Gleichung von oben hierzu übersetzten:

1. $\mu_{j \bullet}$ ist der Mittelwert der j-ten Stufe auf Faktor A unabhängig von Faktor B - hier wird also über alle $\beta_k$ und $\gamma_{jk}$ gemittelt ($\beta_k$ und $\gamma_{jk}$ fallen somit weg). Somit ist $\alpha_j$ nichts anderes als die Differenz zwischen $\mu_{j \bullet}$ und $\mu$, also: $\alpha_j:=\mu_{j \bullet} - \mu$.

2. $\mu_{\bullet k}$ ist dementsprechend der Mittelwert der k-ten Stufe auf Faktor B unabhängig von Faktor A - $\alpha_j$ und $\gamma_{jk}$ fallen somit weg. Es ergibt sich $\beta_k:=\mu_{\bullet k}-\mu$.

3. $\mu_{jk}$ ist der Mittelwert der entsteht, wenn man Faktor A und Faktor B kombiniert. Da aber der alleinige Interaktionseffekt gesucht ist, muss dieser noch um die alleinigen Effekte $\mu_{j \bullet}$ und $\mu_{\bullet k}$ bereinigt werden. Daher ergibt sich $\gamma_{jk}:=\mu_{jk}-\alpha_j-\beta_k-\mu$ und daraus dann $\gamma_{jk}:=\mu_{jk}-(\mu_{j \bullet}-\mu)-(\mu_{\bullet k}-\mu)-\mu$. Wenn man dies nun vereinfacht, entsteht: $\gamma_{jk}:=\mu_{jk}-\mu_{j \bullet}-\mu_{\bullet k}+\mu$.

Da wir wissen wollen, ob sich die Effekte $\alpha_j$, $\beta_k$ und $\gamma_{jk}$ signifikant von Null unterscheiden, werden die Gleichungen in die oben genannten Hypothesen überführt. Bspw. wäre die Hypothese für Faktor A: $H_0: \alpha_1 = \dots \alpha_J = 0$ oder $H_0: \alpha_j=0$, wobei $\alpha_j:=\mu_{j \bullet} - \mu$.


Die drei Nullhypothesen werden in der **zweifaktoriellen ANOVA** geprüft. Die für `ezStats` genutzten Argumente können auch für `ezANOVA` benutzt werden. Um eine etwas detailliertere Ausgabe zu erhalten, kann zudem `detailed = TRUE` gesetzt werden.


```r
ezANOVA(conspiracy, dv = ET, wid = id, between = c(urban, edu), detailed = TRUE)
```

```
## Warning: Data is unbalanced (unequal N per group). Make sure you specified a
## well-considered value for the type argument to ezANOVA().
```

```
## Coefficient covariances computed by hccm()
```

```
## $ANOVA
##      Effect DFn  DFd        SSn      SSd         F            p p<.05         ges
## 1     urban   2 2442  15.286269 4167.541  4.478549 1.144325e-02     * 0.003654530
## 2       edu   2 2442 124.645422 4167.541 36.518431 2.359355e-16     * 0.029040076
## 3 urban:edu   4 2442   5.704855 4167.541  0.835700 5.023239e-01       0.001367007
## 
## $`Levene's Test for Homogeneity of Variance`
##   DFn  DFd      SSn      SSd        F            p p<.05
## 1   8 2442 35.01704 2002.067 5.338958 1.141927e-06     *
```

In der ANOVA erhalten wir folgende Informationen: `Effect` ist die unabhängige Variable, `DFn` sind die Hypothesenfreiheitsgrade (das n steht für numerator, also den Zähler des F-Bruchs), `DFd` sind die Residualfreiheitsgrade (d steht für denominator, also den Nenner des F-Bruchs), `SSn` ist die Hypothesen-Sum-of-Squares/-quadratsumme, `SSd` die Residualquadratsumme, `F` der F-Wert, `p` der p-Wert zum F-Wert, `p<.05` gibt uns eine Signifikanzentscheidung und `ges` ist das generalisierte partielle $\eta^2$.

Der *Levene Test* fällt in diesem Fall statistisch bedeutsam aus, sodass die Homoskedastizitätsannahme (in diesem Fall: die Varianz ist in allen 9 Gruppen identisch) verworfen werden muss. `ezANOVA` liefert eine eingebaute Korrekturmöglichkeit (HC3 von MacKinnon & White, 1985), die mithilfe `white.adjust = TRUE` angefordert werden kann. Probieren Sie das doch einmal selbst aus, indem Sie den Code kopieren und die Korrektur anfordern! Wie verändert das die Ergebnisse, die Ihnen ausgegeben werden?


```r
ezANOVA(conspiracy, dv = ET, wid = id, between = c(urban, edu), detailed = TRUE, white.adjust = TRUE)
```

```
## Warning: Data is unbalanced (unequal N per group). Make sure you specified a
## well-considered value for the type argument to ezANOVA().
```

```
## Coefficient covariances computed by hccm()
```

```
## $ANOVA
##      Effect DFn  DFd         F            p p<.05
## 1     urban   2 2442  4.030804 1.787834e-02     *
## 2       edu   2 2442 37.575166 8.460068e-17     *
## 3 urban:edu   4 2442  0.836493 5.018262e-01      
## 
## $`Levene's Test for Homogeneity of Variance`
##   DFn  DFd      SSn      SSd        F            p p<.05
## 1   8 2442 35.01704 2002.067 5.338958 1.141927e-06     *
```

In diesem Fall werden beide Haupteffekte statistisch bedeutsam, die Interaktion allerdings nicht. Inhaltlich heißt das, dass sowohl die Art des Wohnorts als auch das Bildungsniveau einen Einfluss auf die verschwörungstheoretische Überzeugung haben. Über die jeweiligen Effekte hinaus, ist die spezifische Kombination aus Wohnort und Bildungsniveau für diese Überzeugung irrelevant.

Wenn Interaktionen von 0 verschieden sind, wird davon abgeraten die Haupteffekte zu interpretieren. Ähnliches hatten wir bemerkt, als wir die [quadratische und moderierte Regression](regression-iv) kennengelernt hatten. Hier war es auch wenig sinnvoll den linearen Effekt ohne den quadratischen zu interpretieren, bzw. den Effekt des Prädiktors unabhängig vom Moderator zu interpretieren --- genauso ist es hier auch!

Welche unterschiedlichen Kombinationen an Signifikanzen es gibt und was diese schematisch bedeuten, kann bspw. in [Eid et al. (2017](https://hds.hebis.de/ubffm/Record/HEB366849158), p. 436, Abbildung 13.6) nachgelesen werden.


## Post-Hoc Analyse und Kontraste

### Alle Gruppenvergleiche

Mit *Tukeys Honest Significant Difference* können, wie auch in der [letzten Sitzung](anova-i), alle möglichen Gruppenkombinationen verglichen werden. Wir müssen die `TuckeyHSD` Funktion auf ein `aov`-Objekt anwenden.


```r
TukeyHSD(aov(ET ~ urban*edu, conspiracy))
```

```
##   Tukey multiple comparisons of means
##     95% family-wise confidence level
## 
## Fit: aov(formula = ET ~ urban * edu, data = conspiracy)
## 
## $urban
##                      diff         lwr       upr     p adj
## suburban-rural -0.0434230 -0.21106066 0.1242147 0.8160596
## urban-rural     0.1128996 -0.06256717 0.2883663 0.2868556
## urban-suburban  0.1563226  0.01713930 0.2955059 0.0230965
## 
## $edu
##                                  diff         lwr        upr    p adj
## highschool-not highschool  0.08171642 -0.09301366  0.2564465 0.516161
## college-not highschool    -0.43415436 -0.57072569 -0.2975830 0.000000
## college-highschool        -0.51587078 -0.69327810 -0.3384635 0.000000
## 
## $`urban:edu`
##                                                      diff         lwr         upr
## suburban:not highschool-rural:not highschool -0.158029879 -0.49075525  0.17469549
## urban:not highschool-rural:not highschool     0.108091787 -0.23953951  0.45572308
## rural:highschool-rural:not highschool        -0.069444444 -0.63658691  0.49769802
## suburban:highschool-rural:not highschool     -0.019875479 -0.40334545  0.36359449
## urban:highschool-rural:not highschool         0.199212272 -0.24677039  0.64519493
## rural:college-rural:not highschool           -0.491319444 -0.89358775 -0.08905114
## suburban:college-rural:not highschool        -0.487909672 -0.82790283 -0.14791651
## urban:college-rural:not highschool           -0.423312639 -0.77442641 -0.07219887
## urban:not highschool-suburban:not highschool  0.266121666 -0.01539691  0.54764025
## rural:highschool-suburban:not highschool      0.088585434 -0.44061752  0.61778839
## suburban:highschool-suburban:not highschool   0.138154400 -0.18658306  0.46289186
## urban:highschool-suburban:not highschool      0.357242151 -0.03937571  0.75386001
## rural:college-suburban:not highschool        -0.333289566 -0.68002431  0.01344518
## suburban:college-suburban:not highschool     -0.329879794 -0.60191020 -0.05784939
## urban:college-suburban:not highschool        -0.265282761 -0.55109052  0.02052499
## rural:highschool-urban:not highschool        -0.177536232 -0.71623569  0.36116323
## suburban:highschool-urban:not highschool     -0.127967266 -0.46796103  0.21202650
## urban:highschool-urban:not highschool         0.091120485 -0.31808248  0.50032345
## rural:college-urban:not highschool           -0.599411232 -0.96047401 -0.23834846
## suburban:college-urban:not highschool        -0.596001460 -0.88607366 -0.30592925
## urban:college-urban:not highschool           -0.531404427 -0.83443481 -0.22837404
## suburban:highschool-rural:highschool          0.049568966 -0.51292443  0.61206236
## urban:highschool-rural:highschool             0.268656716 -0.33817945  0.87549288
## rural:college-rural:highschool               -0.421875000 -0.99734818  0.15359818
## suburban:college-rural:highschool            -0.418465228 -0.95226757  0.11533712
## urban:college-rural:highschool               -0.353868195 -0.89482150  0.18708511
## urban:highschool-suburban:highschool          0.219087751 -0.22096767  0.65914317
## rural:college-suburban:highschool            -0.471443966 -0.86713075 -0.07575718
## suburban:college-suburban:highschool         -0.468034193 -0.80021425 -0.13585414
## urban:college-suburban:highschool            -0.403437160 -0.74699082 -0.05988350
## rural:college-urban:highschool               -0.690531716 -1.14706139 -0.23400204
## suburban:college-urban:highschool            -0.687121944 -1.08985622 -0.28438766
## urban:college-urban:highschool               -0.622524911 -1.03469045 -0.21035937
## suburban:college-rural:college                0.003409772 -0.35030503  0.35712457
## urban:college-rural:college                   0.068006805 -0.29641011  0.43242372
## urban:college-suburban:college                0.064597033 -0.22963969  0.35883375
##                                                  p adj
## suburban:not highschool-rural:not highschool 0.8674832
## urban:not highschool-rural:not highschool    0.9888501
## rural:highschool-rural:not highschool        0.9999880
## suburban:highschool-rural:not highschool     1.0000000
## urban:highschool-rural:not highschool        0.9030684
## rural:college-rural:not highschool           0.0048260
## suburban:college-rural:not highschool        0.0003000
## urban:college-rural:not highschool           0.0058080
## urban:not highschool-suburban:not highschool 0.0811231
## rural:highschool-suburban:not highschool     0.9998677
## suburban:highschool-suburban:not highschool  0.9253454
## urban:highschool-suburban:not highschool     0.1168434
## rural:college-suburban:not highschool        0.0707540
## suburban:college-suburban:not highschool     0.0053488
## urban:college-suburban:not highschool        0.0936241
## rural:highschool-urban:not highschool        0.9837367
## suburban:highschool-urban:not highschool     0.9629765
## urban:highschool-urban:not highschool        0.9989009
## rural:college-urban:not highschool           0.0000098
## suburban:college-urban:not highschool        0.0000000
## urban:college-urban:not highschool           0.0000020
## suburban:highschool-rural:highschool         0.9999991
## urban:highschool-rural:highschool            0.9075139
## rural:college-rural:highschool               0.3572013
## suburban:college-rural:highschool            0.2659691
## urban:college-rural:highschool               0.5217326
## urban:highschool-suburban:highschool         0.8337309
## rural:college-suburban:highschool            0.0068453
## suburban:college-suburban:highschool         0.0004320
## urban:college-suburban:highschool            0.0083262
## rural:college-urban:highschool               0.0000975
## suburban:college-urban:highschool            0.0000046
## urban:college-urban:highschool               0.0001008
## suburban:college-rural:college               1.0000000
## urban:college-rural:college                  0.9997005
## urban:college-suburban:college               0.9990084
```

Leider ist das Ergebnis etwas unübersichtlich, weil sich in diesem Fall 36 Vergleiche ergeben. Mit ein paar Funktionen aus dem `emmeans`-Paket können wir versuchen, das optisch etwas aufzubereiten. Dafür müssen wir zunächst das Paket laden:


```r
library(emmeans)
```

In diesem Paket gibt es die wenig überraschend benannte `emmeans`-Funktion, mit der wir alle weiteren Analysen vorbereiten müssen:


```r
emm <- emmeans(aov(ET ~ urban*edu, conspiracy), ~ urban * edu)
```

Diese Funktion nimmt als erstes Argument das gleiche `aov`-Objekt entgegen wie `TukeyHSD`. Als zweites müssen wir definieren, welche unabhängigen Variablen uns in der Post-Hoc Analyse interessieren. Weil wir hier alle Gruppen betrachten möchten, können wir einfach die gleiche Struktur der unabhängigen Variablen wiederholen: `~ urban * edu`.

Wenn wir uns das entstandene Objekt angucken, sehen wir eine Tabelle mit 7 Spalten:


```r
emm
```

```
##  urban    edu            emmean     SE   df lower.CL upper.CL
##  rural    not highschool   2.40 0.0889 2442     2.23     2.58
##  suburban not highschool   2.24 0.0599 2442     2.13     2.36
##  urban    not highschool   2.51 0.0681 2442     2.38     2.64
##  rural    highschool       2.33 0.1596 2442     2.02     2.65
##  suburban highschool       2.38 0.0858 2442     2.21     2.55
##  urban    highschool       2.60 0.1129 2442     2.38     2.82
##  rural    college          1.91 0.0943 2442     1.73     2.10
##  suburban college          1.91 0.0640 2442     1.79     2.04
##  urban    college          1.98 0.0699 2442     1.84     2.12
## 
## Confidence level used: 0.95
```

Die ersten beiden Spalten  (`urban`, `edu`) geben an, welche Ausprägungen unsere beiden unabhängigen Variablen haben. Die erste Zeile bezieht sich also auf Personen aus einem ländlichen Gebiet, die keinen Highschool-Abschluss haben. Die dritte Spalte (`emmean`) ist der Gruppenmittelwert, die vierte der dazugehörige Standardfehler (`SE`), dann die fünfte die Freiheitsgrade (`df`) und die letzten beiden Spalten geben das Konfidenzintervall des Mittelwerts an (`lower.CL` ist die untere und `upper.CL` die obere Grenze des Konfidenzintervalls).

Mittelwerte und Konfidenzintervalle können wir uns sehr einfach direkt plotten lassen:


```r
plot(emm)
```

<img src="/lehre/statistik-ii/anova-ii_files/figure-html/unnamed-chunk-21-1.png" style="display: block; margin: auto;" />

Diese Abbildung können wir um eine Aussage über die direkten Vergleiche erweitern:


```r
plot(emm, comparisons = TRUE)
```

<img src="/lehre/statistik-ii/anova-ii_files/figure-html/unnamed-chunk-22-1.png" style="display: block; margin: auto;" />

Die neu hinzugekommenen roten Pfeile geben uns einen Hinweis dazu, welche Gruppen sich unterscheiden. Wenn zwei rote Pfeile überlappen, gibt es keinen statistisch bedeutsamen Unterschied. Wenn Sie das nicht tun, unterscheiden sich die beiden Gruppenmittelwerte auf dem festgeleten $\alpha$-Fehlerniveau (per Voreinstellung 5%) statistisch bedeutsam.

Eine zweite Möglichkeit, die Ergebnisse ein wenig übersichtlicher zu gestalten sind *pairwise $p$-value plots*. Im `emmeans`-Paket werden diese über `pwpp` angefordert:


```r
pwpp(emm)
```

<img src="/lehre/statistik-ii/anova-ii_files/figure-html/unnamed-chunk-23-1.png" style="display: block; margin: auto;" />

In dieser Abbildung ist auf der x-Achse der $p$-Wert des Mittelwertvergleichs dargestellt. Auf der y-Achse werden die Gruppen anhand ihrer deskriptiven Mittelwerte sortiert und abgetragen (dabei sind alle Abstände zwischen zwei Gruppen gleich groß, egal wie groß der Mittelwertsunterschied auf der abhängigen Variable tatsächlich ist). Eine Verbindung besteht immer zwischen jenen Gruppen, die auf dem jeweiligen Niveau signifikant sind (`Tuckey-adjusted P value`). Die `x`-Achse ist gestaucht dargestellt, um möglichst gut darstellen zu können, welche Gruppen sich jeweils auf welchem Niveau unterscheiden. Bspw. hat der Gruppenvergleich `urban highschool` vs. `suburban not highschool` einen `Tuckey-adjusted P value` von etwas mehr als 0.1.

Wir hätten auch mit Hilfe des `ezANOVA`-Befehls ein `aov`-Objekt erhalten können, mit welchem wir die oben aufgeführten Späße hätten durchführen können. Dazu müssen wir das Objekt lediglich abspeichern und das Argument `return_aov` auf `T`, bzw. `TRUE` setzen:


```r
ez1 <- ezANOVA(conspiracy, dv = ET, wid = id, between = c(urban, edu), detailed = TRUE, return_aov = T)
aov1 <- ez1$aov
emm1 <- emmeans(aov1, ~ urban * edu)
plot(emm1, comparisons = TRUE) # identisch zu oben
```

<img src="/lehre/statistik-ii/anova-ii_files/figure-html/unnamed-chunk-24-1.png" style="display: block; margin: auto;" />

So ein `aov`-Objekt hat auch weitere Vorteile, da wir bspw. dem `ez1` Objekt nicht direkt alle Informationen, wie etwa die Residuen, entlocken können. Um einem `aov`-Objekt ähnliche Infos wie dem `ezANOVA`-Objekt zu entlocken, wird in der Regel die `summary` Funktion verwendet. Genauso können auch weitere Werte, wie bspw. die Residuen, diesem Objekt entnommen werden, was bspw. mit der `resid` Funktion geht, welche bereits auch in der letzten Sitzung zur [einfaktoriellen Varianzanalyse](anova-i) angesprochen wurden, um die Normalverteilung der Residuen zu untersuchen.

### Kontraste

In Situationen mit vielen Gruppen ist es außerordentlich ineffizient, *alle* Vergleiche durchzuführen. Durch die Grundgedanken des Nullhypothesentestens muss das $\alpha$-Fehlerniveau auf alle *durchgeführten* Tests korrigiert werden. Nach klassischer *Bonferroni*-Korrektur wäre das korrigierte $\alpha$-Fehlerniveau in diesem Fall also $\frac{.05}{36} = 0.0014$ um eine echte Irrtumswahrscheinlichkeit von 5% aufrecht zu erhalten. An dieser Stelle können daher *geplante Kontraste* genutzt werden, um a-priori definierte, theoretisch relevante Vergleiche durchzuführen. So kann die Anzahl der Tests auf die theoretisch notwendigen reduziert werden und mit einer weniger restriktiven Korrektur gerechnet werden.

Um Kontraste definieren zu können, müssen wir zunächst in Erfahrung bringen, in welcher Reihenfolge die Gruppenkombinationen intern repräsentiert werden. Diese Reihenfolge haben wir bereits im `emm`-Objekt gesehen:


```r
emm
```

```
##  urban    edu            emmean     SE   df lower.CL upper.CL
##  rural    not highschool   2.40 0.0889 2442     2.23     2.58
##  suburban not highschool   2.24 0.0599 2442     2.13     2.36
##  urban    not highschool   2.51 0.0681 2442     2.38     2.64
##  rural    highschool       2.33 0.1596 2442     2.02     2.65
##  suburban highschool       2.38 0.0858 2442     2.21     2.55
##  urban    highschool       2.60 0.1129 2442     2.38     2.82
##  rural    college          1.91 0.0943 2442     1.73     2.10
##  suburban college          1.91 0.0640 2442     1.79     2.04
##  urban    college          1.98 0.0699 2442     1.84     2.12
## 
## Confidence level used: 0.95
```

Mithilfe eines 9 Elemente langen Vektors können Kontraste festgelegt werden. Um z.B. die Gruppe "rural, not highschool" (Zeile 1) mit der Gruppe "suburban, not highschool" (Zeile 2) zu vergleichen, kann folgender Vektor angelegt werden:


```r
cont1 <- c(1, -1, 0, 0, 0, 0, 0, 0, 0)
```

Die Nullhypothese, die durch diesen Vektor geprüft wird, lässt sich mithilfe der Reihenfolge der Gruppen leicht zusammenstellen. Wenn $j$ die drei Stufen von `urban` indiziert (1 = rural, 2 = suburban, 3 = urban) und $k$ die drei Stufen von `edu` (1 = not highschool, 2 = highschool, 3 = college), ist die durch `cont1` festgelegte Nullhypothese:

$H_0: 1 \cdot \mu_{11} - 1 \cdot \mu_{21} + 0 \cdot \mu_{31} + 0 \cdot \mu_{12} + 0 \cdot \mu_{22} + 0 \cdot \mu_{32} + 0 \cdot \mu_{13} + 0 \cdot \mu_{23} + 0 \cdot \mu_{33} = 0$

Oder gekürzt:

$H_0: \mu_{11} - \mu_{21} = 0$

Mit dem `contrast`-Befehl kann der festgelegte Kontrast geprüft werden, indem wir das Mittelwertsobjekt `emm` übergeben und anschließend die Gruppenzugehörigkeit via Kontrast als Liste `list(cont1)` übergeben:


```r
contrast(emm, list(cont1))
```

```
##  contrast                      estimate    SE   df t.ratio p.value
##  c(1, -1, 0, 0, 0, 0, 0, 0, 0)    0.158 0.107 2442   1.475  0.1405
```

Dieser Kontrast entspricht dem ersten Vergleich des oben durchgeführten `TukeyHSD`, unterscheidet sich jedoch im $p$-Wert. Der hier bestimmte $p$-Wert ist nicht korrigiert (weil nur ein Kontrast geprüft wurde), der oben aufgeführte ist hingegen auf 36 Tests Tukey-korrigiert. Genauso können andere Gruppen miteinander verglichen werden, indem die jeweiligen Stellen von `cont1` verändert werden. Eine generelle Daumenregel besagt, dass die Summe des Kontrastvektors 0 sein sollte:


```r
sum(cont1)
```

```
## [1] 0
```

```r
sum(cont1) == 0
```

```
## [1] TRUE
```

Falls dies nicht der Fall ist, dann ist der Kontrast nicht richtig gewählt!

Mithilfe der Kontrast-Vektoren können auch komplexe Hypothesen geprüft werden. Beispielsweise könnten wir vergleichen, inwiefern sich Personen aus städtischer Umgebung ($j = 3$) mit mindestens High School Abschluss ($k = 2$ und $k = 3$) von Personen ohne High School Abschluss ($k = 1$) unterscheiden. Da nun die Gruppen 32 und 33 gleichwertig sind, teilen sie sich einen Platz. Daher bekommen beide Gruppen einen halben Platz, also 0.5:


```r
cont2 <- c(0, 0, 1, 0, 0, -.5, 0, 0, -.5)
```

oder in Hypothesenform: $H_0: \mu_{31} - .5 \cdot \mu_{32} - .5 \cdot \mu_{33} = 0$ bzw. $H_0: \mu_{31} - \frac{\mu_{32} + \mu_{33}}{2} = 0$. 

Weil sowohl `cont1` als auch `cont2` durchgeführt werden, muss für das multiple Testen der beiden korrigiert werden. Das kann dadurch erreicht werden, dass im `contrast`-Befehl alle Kontraste gleichzeitig eingeschlossen werden und mit `adjust = 'bonferroni'` z.B. die Bonferroni-Korrektur ausgewählt wird:


```r
contrast(emm, list(cont1, cont2), adjust = 'bonferroni')
```

```
##  contrast                           estimate     SE   df t.ratio p.value
##  c(1, -1, 0, 0, 0, 0, 0, 0, 0)         0.158 0.1072 2442   1.475  0.2809
##  c(0, 0, 1, 0, 0, -0.5, 0, 0, -0.5)    0.220 0.0951 2442   2.315  0.0414
## 
## P value adjustment: bonferroni method for 2 tests
```

Der erste Kontrast ist nicht signifikant (p = 0.2809 > 0.05), der zweite jedoch schon (p = 0.0414 < 0.05). Damit unterscheiden sich die Mittelwerte in den Gruppen mit mindestens und ohne High-School Abschluss mit einer Irrtumswahrscheinlichkeit von $5\%$.  Hierbei ist nun zu beachten, dass dieser Kontrast eigentlich verworfen werden müsste, da die städtischen Menschen mit Collegeabschluss eine sehr geringe Überzeugung haben (1.98), dass die Regierung die Existenz von Außerirdischen vertuschen, während die High-Schoolabsolvent\*innen (2.60) tatsächlich einen höheren Mittelwert als die Menschen ohne High-Schoolabschluss (2.51) hatten. (Ungewichtetes) Mitteln bringt uns dann einen Vergleich von mindestens High-Schoolabschluss vs. keinen High-Schoolabschluss von 2.29 vs. 2.51, sodass diese Differenz signifikant wird, obwohl die High-Schoolabsolvent\*innen eigentlich einen höheren Mittelwert als diejenigen ohne Abschluss haben!  


***

## Appendix A

<details><summary><b>Quadratsummen-Typ</b></summary>

Bei mehrfaktoriellen ANOVAs können die Quadratsummen auf unterschiedliche Arten berechnet werden. Verbreitet sind dabei 3 Typen, zwischen denen man sich anhand der inhaltlichen Hypothesen entscheiden sollte.

### Typ I

Typ I berücksichtigt in der Berechnung der Quadratsummen nur die vorherigen unabhängigen Variablen. Dies entspricht konzeptuell der sequentiellen Aufnahme von Prädiktoren in der Regression.


```r
# QS-Typ 1, Reihenfolge 1
ezANOVA(conspiracy, dv = ET, wid = id, between = c(urban, edu), type = 1)
```

```
## Warning: Data is unbalanced (unequal N per group). Make sure you specified a
## well-considered value for the type argument to ezANOVA().
```

```
## Warning: Using "type==1" is highly questionable when data are unbalanced and there is
## more than one variable. Hopefully you are doing this for demonstration purposes only!
```

```
## $ANOVA
##      Effect DFn  DFd         F            p p<.05         ges
## 1     urban   2 2442  3.532848 2.937100e-02     * 0.002885058
## 2       edu   2 2442 36.518431 2.359355e-16     * 0.029040076
## 3 urban:edu   4 2442  0.835700 5.023239e-01       0.001367007
```

```r
# QS-Typ 1, Reihenfolge 2
ezANOVA(conspiracy, dv = ET, wid = id, between = c(edu, urban), type = 1)
```

```
## Warning: Data is unbalanced (unequal N per group). Make sure you specified a
## well-considered value for the type argument to ezANOVA().

## Warning: Using "type==1" is highly questionable when data are unbalanced and there is
## more than one variable. Hopefully you are doing this for demonstration purposes only!
```

```
## $ANOVA
##      Effect DFn  DFd         F            p p<.05         ges
## 1       edu   2 2442 35.572731 5.911919e-16     * 0.028309329
## 2     urban   2 2442  4.478549 1.144325e-02     * 0.003654530
## 3 edu:urban   4 2442  0.835700 5.023239e-01       0.001367007
```

Dies ist im Übrigen auch der Default im `lm`-Befehl, an den auch einfach eine `factor`-Variable übergeben werden kann. Auf das `lm`-Objekt wird dann die `anova`-Funktion angewandt, um den gängigen ANOVA-Output zu erhalten. Jedoch sollte hier aufgepasst werden, falls Interaktionen bestimmt werden. Der Default ist immer Typ I!


```r
# QS-Typ 1, Reihenfolge 1 mit lm
anova(lm(ET ~ urban*edu, data = conspiracy))
```

```
## Analysis of Variance Table
## 
## Response: ET
##             Df Sum Sq Mean Sq F value    Pr(>F)    
## urban        2   12.1   6.029  3.5328   0.02937 *  
## edu          2  124.6  62.323 36.5184 2.359e-16 ***
## urban:edu    4    5.7   1.426  0.8357   0.50232    
## Residuals 2442 4167.5   1.707                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
# QS-Typ 1, Reihenfolge 2 mit lm
anova(lm(ET ~ edu*urban, data = conspiracy))
```

```
## Analysis of Variance Table
## 
## Response: ET
##             Df Sum Sq Mean Sq F value    Pr(>F)    
## edu          2  121.4  60.709 35.5727 5.912e-16 ***
## urban        2   15.3   7.643  4.4785   0.01144 *  
## edu:urban    4    5.7   1.426  0.8357   0.50232    
## Residuals 2442 4167.5   1.707                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

`*` fügt immer neben der Interaktion automatisch noch die Haupteffekte hinzu. Das gleiche funktioniert selbstverständlich auch mit dem `aov` Befehl (ein `aov`-Objekt können wir auch in der `ezANOVA` anfordern und damit weiterrechnen, wir wollen hier aber die Äquvialenz der Vorgehensweisen aufzeigen):



```r
# QS-Typ 1, Reihenfolge 1 mit aov
summary(aov(ET ~ urban*edu, data = conspiracy))
```

```
##               Df Sum Sq Mean Sq F value   Pr(>F)    
## urban          2     12    6.03   3.533   0.0294 *  
## edu            2    125   62.32  36.518 2.36e-16 ***
## urban:edu      4      6    1.43   0.836   0.5023    
## Residuals   2442   4168    1.71                     
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
# QS-Typ 1, Reihenfolge 2 mit aov
summary(aov(ET ~ edu*urban, data = conspiracy))
```

```
##               Df Sum Sq Mean Sq F value   Pr(>F)    
## edu            2    121   60.71  35.573 5.91e-16 ***
## urban          2     15    7.64   4.479   0.0114 *  
## edu:urban      4      6    1.43   0.836   0.5023    
## Residuals   2442   4168    1.71                     
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Wir sehen deutlich, dass sich der $F$-Wert ändert, je nach dem in welcher Reihenfolge die Prädiktoren in die Gleichung genommen werden. Demnach kann es sein, dass die Reihenfolge die Signifikanzentscheidung beeinflusst.

### Typ II

Typ II berücksichtigt in der Berechnung alle anderen unabhängigen Variablen. In der Berechnung der einzelnen Quadratsummen wird allerdings angenommen, dass alle Interaktionen, an denen dieser Term beteiligt ist, 0 sind. Typ II ist in `ezANOVA` voreingestellt.


```r
# QS-Typ 2
ezANOVA(conspiracy, dv = ET, wid = id, between = c(urban, edu), type = 2)
```

```
## Warning: Data is unbalanced (unequal N per group). Make sure you specified a
## well-considered value for the type argument to ezANOVA().
```

```
## Coefficient covariances computed by hccm()
```

```
## $ANOVA
##      Effect DFn  DFd         F            p p<.05         ges
## 1     urban   2 2442  4.478549 1.144325e-02     * 0.003654530
## 2       edu   2 2442 36.518431 2.359355e-16     * 0.029040076
## 3 urban:edu   4 2442  0.835700 5.023239e-01       0.001367007
## 
## $`Levene's Test for Homogeneity of Variance`
##   DFn  DFd      SSn      SSd        F            p p<.05
## 1   8 2442 35.01704 2002.067 5.338958 1.141927e-06     *
```

Die Quadratsummen mit `lm` zu replizieren, ist extrem aufwendig. Es geht aber auch noch bspw. mit dem `Anova` Befehl aus dem `car`-Paket, welcher auf ein `lm` oder ein `aov`-Objekt angewandt wird. 

Zunächst laden wir das Paket:


```r
library(car)
```

Anschließend verwenden wir `Anova` aus dem `car`-Paket wie zuvor `anova` auf das `lm`-Objekt oder wie die `summary` auf das `aov`-Objekt an. Mit dem Zusatzargument `type = "II"`, stellen wir, analog zu `ezANOVA`, den Quadratsummentyp ein. Die Reihenfolge der Prädiktoren spielt nun keine Rolle mehr!


```r
Anova(lm(ET ~ urban*edu, data = conspiracy), type = "II")
```

```
## Anova Table (Type II tests)
## 
## Response: ET
##           Sum Sq   Df F value    Pr(>F)    
## urban       15.3    2  4.4785   0.01144 *  
## edu        124.6    2 36.5184 2.359e-16 ***
## urban:edu    5.7    4  0.8357   0.50232    
## Residuals 4167.5 2442                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
Anova(aov(ET ~ urban*edu, data = conspiracy), type = "II")
```

```
## Anova Table (Type II tests)
## 
## Response: ET
##           Sum Sq   Df F value    Pr(>F)    
## urban       15.3    2  4.4785   0.01144 *  
## edu        124.6    2 36.5184 2.359e-16 ***
## urban:edu    5.7    4  0.8357   0.50232    
## Residuals 4167.5 2442                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```


### Typ III

Typ III unterscheidet sich von Typ II nur darin, dass bei der Berechnung nicht angenommen wird, dass die Interaktionen 0 sind. Typ III ist z.B. in SPSS voreingestellt.


```r
# QS-Typ 3
ezANOVA(conspiracy, dv = ET, wid = id, between = c(urban, edu), type = 3)
```

```
## Warning: Data is unbalanced (unequal N per group). Make sure you specified a
## well-considered value for the type argument to ezANOVA().
```

```
## Coefficient covariances computed by hccm()
```

```
## $ANOVA
##      Effect DFn  DFd         F            p p<.05         ges
## 2     urban   2 2442  4.184991 1.533166e-02     * 0.003415803
## 3       edu   2 2442 32.850744 8.349353e-15     * 0.026199884
## 4 urban:edu   4 2442  0.835700 5.023239e-01       0.001367007
## 
## $`Levene's Test for Homogeneity of Variance`
##   DFn  DFd      SSn      SSd        F            p p<.05
## 1   8 2442 35.01704 2002.067 5.338958 1.141927e-06     *
```


Wir wollen dies nun noch für den `lm` und den `aov`-Befehl replizieren. Hier müssen wir allerdings einige Einstellungen abändern, damit die Quadratsummen auch den richtigen Typ haben. Da dies eine leichte Fehlerquelle darstellt, wird es hier der Vollständigkeit halber präsentiert.



```r
# verstelle die Art, wie Kontraste bestimmt werden --- Achtung! Immer wieder zurückstellen
options(contrasts=c(unordered="contr.sum", ordered="contr.poly")) 
Anova(lm(ET ~ urban*edu, data = conspiracy), type = "III")
```

```
## Anova Table (Type III tests)
## 
## Response: ET
##             Sum Sq   Df   F value    Pr(>F)    
## (Intercept) 8824.4    1 5170.7229 < 2.2e-16 ***
## urban         14.3    2    4.1850   0.01533 *  
## edu          112.1    2   32.8507 8.349e-15 ***
## urban:edu      5.7    4    0.8357   0.50232    
## Residuals   4167.5 2442                        
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
Anova(aov(ET ~ urban*edu, data = conspiracy), type = "III")
```

```
## Anova Table (Type III tests)
## 
## Response: ET
##             Sum Sq   Df   F value    Pr(>F)    
## (Intercept) 8824.4    1 5170.7229 < 2.2e-16 ***
## urban         14.3    2    4.1850   0.01533 *  
## edu          112.1    2   32.8507 8.349e-15 ***
## urban:edu      5.7    4    0.8357   0.50232    
## Residuals   4167.5 2442                        
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
# Einstellungen zurücksetzen zum Default:
options(contrasts=c(unordered="contr.treatment", ordered="contr.poly"))

# Der Default kann getestet werden via
options("contrasts")
```

```
## $contrasts
##         unordered           ordered 
## "contr.treatment"      "contr.poly"
```

An den globalen Einstellungen in `R` herum zu spielen erscheint etwas riskant. Daher freuen wir uns, dass die `ezANOVA`-Funktion uns das alles erspart!

### Welcher Typ ist der Richtige?

Generell ist Typ II besser geeignet um die Quadratsummen von Haupteffekten zu bestimmen, wenn Interaktionen empirisch nicht von 0 verschieden sind. Wenn Interaktionen von 0 verschieden sind, wird (unabhängig vom QS-Typ) davon abgeraten die Haupteffekte zu interpretieren, sodass deren Bestimmung in diesem Fall wenig Relevanz hat. Ähnliches hatten wir bemerkt, als wir die [quadratische und moderierte Regression](quadratische-und-moderierte-regression) kennengelernt hatten. Hier war es auch wenig sinnvoll den linearen Effekt ohne den quadratischen zu interpretieren, bzw. den Effekt des Prädiktors unabhängig vom Moderator zu interpretieren --- genauso ist es hier auch! Die Terme höchster Ordnung (hier die Interaktion) sind zwischen Typ II und Typ III identisch, sodass die Interpretation der Interaktion durch die Wahl nicht beeinflusst wird. Von Typ I wird generell abgeraten (wie Ihnen `ezANOVA` auch direkt mitteilt). In einigen Online-Foren steht sogar, dass Typ I nur zu Demonstrationszwecken genutzt werden sollte, dass viel schief gehen kann.

</details>

***

## R-Skript
Den gesamten `R`-Code, der in dieser Sitzung genutzt wird, können Sie [<i class="fas fa-download"></i> hier herunterladen](../anova-ii.R).

***

## Literatur
[Eid, M., Gollwitzer, M., & Schmitt, M. (2017).](https://hds.hebis.de/ubffm/Record/HEB366849158) *Statistik und Forschungsmethoden* (5. Auflage, 1. Auflage: 2010). Weinheim: Beltz. 


* <small> *Blau hinterlegte Autorenangaben führen Sie direkt zur universitätsinternen Ressource.*
