---
title: "Inferenz und Modellauswahl in der multiplen Regression" 
type: post
date: '2021-04-22' 
slug: multreg-inf-mod
categories: ['Statistik II'] 
tags: ["Regression", "Modelltest", "Modelloptimierung"] 
subtitle: ''
summary: ''
authors: [nehler, irmer, schueller, hartig]
weight: 4
lastmod: '2025-04-08'
featured: no
banner:
  image: "/header/man_with_binoculars.jpg"
  caption: "[Courtesy of pxhere](https://www.pexels.com/photo/man-looking-in-binoculars-during-sunset-802412/)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-ii/multreg-inf-mod
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-ii/multreg-inf-mod.R
  - icon_pack: fas
    icon: pen-to-square
    name: Übungen
    url: /lehre/statistik-ii/multreg-inf-mod-uebungen
output:
  html_document:
    keep_md: true
---



## Einleitung

Im letzten Semester haben wir uns bereits mit der Analyse von Zusammenhängen beschäftigt. Dabei haben wir zunächst lineare Modelle mit einem Prädiktor, genannt einfache lineare Regression, und anschließend lineare Modelle mit mehreren Prädiktoren (multiple Regression) kennengelernt. In diesem Semester wollen wir uns weiter mit der multiplen Regression beschäftigen, indem wir Interaktionen aufnehmen und die Linearitätsannahme aufweichen. In diesem ersten Tutorial werden wir jedoch einige Grundlagen wiederholen und nur ausgewählte Aspekte vertiefen.

Dabei ist dieser Beitrag in zwei Teile aufgeteilt. Im ersten Teil geht es um die Analyse eines spezifischen Regressionsmodells inklusive der inferenzstatistischen Testung und der Vorhersage der abhängigen Variable. Im zweiten Teil geht es um die hypothesengeleitete und explorative Modelloptimierung. Zunächst brauchen wir aber einen Datensatz, damit wir den praktischen Bezug der statistischen Vorgehensweisen aufzeigen können.

## Einladen des Datensatzes

Für das vorliegende Tutorial laden wir einen Datensatz aus dem [Open Scniece Framework (OSF)](https://osf.io/) ein, der aus einer [Studie](https://doi.org/10.1016/j.chiabu.2020.104826) stammt, die sich mit Parental Burnout (Elterlichem Burnout) befasst. Die Studie können wir mit folgendem Befehl direkt einladen. Die erste Spalte benötigen wir nicht, da diese sich mit der Zeilennummer doppelt.


``` r
burnout <- read.csv(file = url("https://osf.io/qev5n/download"))
burnout <- burnout[,2:8]
dim(burnout)
```

```
## [1] 1551    7
```

Insgesamt besteht der restliche Datensatz also aus 1551 Zeilen und 7 Spalten. Betrachten wir nun die Variablen noch genauer. 


``` r
str(burnout)
```

```
## 'data.frame':	1551 obs. of  7 variables:
##  $ Exhaust    : int  44 23 0 13 21 40 0 8 34 15 ...
##  $ Distan     : int  31 10 1 18 11 37 2 1 26 6 ...
##  $ Ineffic    : int  29 7 1 19 9 31 1 0 11 9 ...
##  $ Neglect    : int  38 27 18 28 25 29 19 39 31 25 ...
##  $ Violence   : int  76 26 15 20 22 34 16 19 28 24 ...
##  $ PartEstrang: int  17 8 5 5 8 6 5 5 5 7 ...
##  $ PartConfl  : int  12 4 4 4 4 3 2 3 5 7 ...
```

Zu diesen Variablen hier zunächst noch eine inhaltliche Zuordnung: 

| Variable | Bedeutung | Kodierung | Beispielitem |
| --- | ---- | --- | ----- |
| `Exhaust` | *Emotional exhaustion* | 0 - 48 | "I feel emotionally drained by my parental role" |
| `Distan` | *Emotional distancing* | 0 - 48 | "I sometimes feel as though I am taking care of my children on autopilot" | 
| `Ineffic` | *Parental accomplishment and efficacy* | 0 - 36 | "I accomplish many worthwhile things as a parent" (invertiert) |
| `Neglect` | *Neglectful behaviors toward children* | 17 - 136 | "I sometimes don’t take my child to the doctor when I think it would be a good idea." |
| `Violence` | *Violent behaviors toward children* | 15 - 120 | "I sometimes tell my child that I will abandon him/her if s/he is not good." |
| `PartEstrang` | *Partner Estrangement* | 5 - 40 | "I sometimes think of leaving my partner" |
| `PartConfl` | *Conflicts with partner* | 2 - 14 | "How often do you quarrel with your partner?" |

Wie dem, zu den Daten gehörenden Artikel zu entnehmen ist, sind die Variablen alle Summenwerte von mehreren Items aus entsprechenden Fragebögen, weswegen sie sehr unterschiedliche Werte annehmen können. Im weiteren Verlauf werden wir (wie auch im ursprünglichen Artikel) annehmen, dass diese Skalenwerte intervallskaliert sind.


## Multiple Regression - Betrachtung eines spezifische Modells.

Das Ziel einer Regression besteht darin, eine Variable durch eine oder mehrere andere Variablen vorherzusagen (Prognose). Die vorhergesagte Variable wird als Kriterium, Regressand oder auch abhängige Variable (AV) bezeichnet. Die Variablen zur Vorhersage der abhängigen Variablen werden als Prädiktoren, Regressoren oder unabhängige Variablen (UV) bezeichnet. Als Anwendungsbeispiel wollen wir die Gewalttätigkeit gegenüber Kindern (`Violent`) durch die Emotionale Erschöpfung (`Exhaust`), die Emotionale Distanz (`Distan`) und die Konflikte mit dem Partner / der Partnerin (`PartConfl`) vorhersagen.

### Bestimmung der Koeffizienten der Multiplen Regression

Die AV wird üblicherweise mit $y_i$ ($i$ steht als Index für eine Person) symbolisiert, während die UVs durch $x_{im}$ ($i$ steht weiterhin für eine Person, $m$ für die Nummer des Prädiktors) symbolisiert. Wenn wir die Linearitätsannahme beibehalten, folgt die Modellgleichung:

$$y_i = b_0 +b_{1}x_{i1} + ... +b_{m}x_{im} + e_i$$
In unserem Modell wäre die höchste Ausprägung $m = 3$, da wir 3 Variablen haben, die als Prädiktoren gelten sollen. Die theoretische Bedeutung der einzelnen Bestandteile der Modellgleichung sind die folgenden:

* $b_0$ = y-Achsenabschnitt/ Ordinatenabschnitt/ Konstante/ Interzept
* $b_{1}/ b_m$ = Regressionsgewichte der Prädiktoren
* $e_i$ = Regressionsresiduum (kurz: Residuum), Residualwert oder Fehlerwert


Um die Bedeutung nochmal klarer zu machen, setzen wir unser Modell zum Parental Burnout um. Wie wir bereits [hier](/lehre/statistik-i/multiple-reg/#multiple-regression) gelernt haben, wird die multiple Regression in `R` mit der Funktion `lm` durchgeführt. Wir legen das Resultat in einem Objekt mit dem Namen `mod` ab. 


``` r
mod <- lm(Violence ~ Exhaust + Distan + PartConfl, data = burnout)
```
    
Um die berechneten Parameter des Modells anzuzeigen, nutzen wir die Funktion `summary`. 


``` r
summary(mod)
```

```
## 
## Call:
## lm(formula = Violence ~ Exhaust + Distan + PartConfl, data = burnout)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -14.252  -3.688  -1.057   2.454  50.151 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 15.24726    0.40437  37.706  < 2e-16 ***
## Exhaust      0.10683    0.01851   5.770 9.56e-09 ***
## Distan       0.30161    0.02421  12.460  < 2e-16 ***
## PartConfl    0.57351    0.06821   8.408  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.402 on 1547 degrees of freedom
## Multiple R-squared:  0.2889,	Adjusted R-squared:  0.2875 
## F-statistic: 209.5 on 3 and 1547 DF,  p-value: < 2.2e-16
```
Wir haben bereits gelernt, dass die Punktschätzer für die Regressionsgewichte in der Spalte `Estimate` im Abschnitt `Coefficients` zu finden sind. Der Achsenabschnitt unseres Modells beträgt also $b_0$ = 15.25. Dies bedeutet, dass wir einer Person mit einem Wert von 0 in allen Prädiktoren eine Gewalttätigkeit von 15.25 vorhersagen. Die Regressionsgewichte für die Prädiktoren sind $b_{1}$ = 0.107 für Emotionale Erschöpfung, $b_{2}$ = 0.302 für Emotionale Distanz und $b_{3}$ = 0.574 für Konflikte mit dem Partner. Die Interpretaion nochmal am Beispiel der Emotionalen Erschöpfung: Wenn sich die Emotionale Erschöpfung um eine Einheit erhöht und alle anderen Prädiktoren konstant gehalten werden, so erhöht sich die Gewalttätigkeit um 0.107 Einheiten. 

Der letzte Teil des Regressionsmodells beinhaltet die Fehler $e_i$, die (wie durch den Index $i$ gekennzeichnet) für jede Person individuell sind. Die Fehler können wir beispielsweise anzeigen, indem wir die Funktion `resid()` auf unser Objekt anwenden. Wir zeigen hier nur die ersten zehn Fehlerwerte, da der Output sonst sehr lange wäre.


``` r
resid(mod)[1:10]
```

```
##          1          2          3          4          5          6          7          8          9         10 
## 39.8203389  2.9855780 -2.8429139 -4.3589986 -1.1023730  1.5996231 -0.9974955  0.8759748 -1.5887563  1.3260923
```

### Omnibustest der Multiplen Regression

Einschätzungen zur Güte unseres Modells finden wir wie in [Statistik 1 besprochen](/lehre/statistik-i/multiple-reg/#determinationskoeffizient) im letzten Teil des Outputs der `summary()` Funktion. Wir blenden die spezifischen Ergebnisse an dieser Stelle nochmal ein:


```
## Residual standard error: 6.402 on 1547 degrees of freedom
## Multiple R-squared:  0.2889,	Adjusted R-squared:  0.2875 
## F-statistic: 209.5 on 3 and 1547 DF,  p-value: < 2.2e-16
```

Hier finden wir die Werte des Bestimmtheitsmaßes $R^2$ und des F-Tests. Der Wert von $R^2$ beträgt 0.289. Dies bedeutet, dass 28.9% der Varianz in der Gewalttätigkeit durch unsere Prädiktoren erklärt wird. Der Wert ist zunächst einmal ein deskriptivstatistisches Maß und beschreibt unsere Stichprobe. Er sollte also noch inferenzstatistisch überprüft werden, um sicherzugehen, dass er in der Population von 0 verschieden ist. Dies geschieht durch den F-Test. Dabei wird in der Nullhypothese festgehalten, dass die erklärte Varianz an der abhängigen Variable in unserem Modell 0 ist. Dies ist gleichbedeutend damit, dass alle Regressionsgewichte gleich 0 sind. Der Test erhält daher auch den Namen Omnibustest, da alle Prädiktoren gemeinsaem getestet werden. In der Alternativhypothese wird festgehalten, dass die erklärte Varianz unseres Modells nicht 0 ist, was gleichbedeutend damit ist, dass mindestens ein Regressionsgewicht ungleich 0 ist.

$H_0$: $b_1 = b_2 = b_3 = 0$

$H_1$: mind. ein  $b_m \neq 0$

In unserem Fall hat der Omnibustest einen empirischen Wert von 209.524 bei Freiheitsgraden von 3 und 1547. Der Test prüft, ob die Prädiktoren in der Modellgleichung gemeinsam signifikant zur Vorhersage der abhängigen Variable beitragen, was in diesem Fall gegeben ist, da der p-Wert kleiner als 0.05 ist, was üblicherweise als $\alpha$-Niveau verwendet wird.

### Testung einzelner Prädiktoren

Neben der gemeinsamen Testung aller Prädiktoren ist es bei der multiplen Regression auch möglich, die einzelnen Prädiktoren auf ihre Signifikanz zu testen. Dies geschieht durch die Anwendung des t-Tests auf die einzelnen Regressionsgewichte. Führen wir eine solche Testung anhand des Prädiktors Emotionale Erschöpfung durch Die Nullhypothese des t-Tests lautet, dass das Regressionsgewicht des Prädiktors Emotionale Erschöpfung 0 ist. Die Alternativhypothese ist, dass das Regressionsgewicht ungleich 0 ist.

$H_0$: $b_1 = 0$ und $H_1$: $b_1 \neq 0$

Auch für die Testung der einzelnen Prädiktoren liefert uns die `summary()` Funktion die nötigen Informationen. Wir blenden den spezifischen Teil des Outputs an dieser Stelle nochmal ein.


```
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 15.24726    0.40437  37.706  < 2e-16 ***
## Exhaust      0.10683    0.01851   5.770 9.56e-09 ***
## Distan       0.30161    0.02421  12.460  < 2e-16 ***
## PartConfl    0.57351    0.06821   8.408  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Für Emotionale Erschöpfung ergibt sich ein empirischer Wert von 5.77 und ein p-Wert von kleiner 0.001. Dieser ist kleiner als das übliche $\alpha$-Niveau von 0.05, was ein signifikantes Ergebnis anzeigt. Was bedeutet dies jetzt? Wie in den Hypothesen festgehalten wird damit angezeigt, dass das Regressionsgewicht der Emotionalen Erschöpfung verschieden von 0 ist. Nun könnte man argumentieren, dass man dies ja bereits an dem Wert für den Regressionsparameter sehen konnte, da dieser eindeutig verschieden von 0 ist, jedoch handelt es sich auch hier nur um einen deskriptivstatistischen Wert. Der t-Test zeigt uns, dass dieser in der Population von 0 verschieden. Wenn wir nun in unserem Ergebnisbericht nicht nur die Punktschätzung für den Regressionsparameter angeben wollen, können wir ein Konfidenzintervall um den Wert legen (Konfidenzintervalle haben wir [hier](/lehre/statistik-i/tests-konfidenzintervalle/#KonfInt) beim Testen eines Mittelwerts sehr detailliert besprochen). Die Formel nutzt dabei den Standardfehler des Regressionsgewichts, der in der Übersicht enthalten ist. Zusätzlich wird der kritische Wert aus der t-Verteilung benötigt (wobei mit $\alpha$ das Fehlerniveau festgelegt wird und $k$ hier für die Anzahl an Prädiktoren - also 3 - steht).

$$CI = b_m \pm t_{(1-\alpha/2, n-k-1)} \cdot \hat{\sigma}_{b_m}$$

Wir könnten also per Hand das Intervall bestimmen. Jedoch ist in `R` die Erstellung des Konfidenzintervalls sehr simpel mit der Funktion `confint()` möglich. Diese muss nur auf das Objekt angwendet werden, das unser Regressionsmodell enthält. Mit dem Argument `level` kann das Konfidenzniveau festgelegt werden, das sich aus $1 - \alpha$ bestimmt. In unserem Fall wäre dieses also 0.95.


``` r
confint(mod, level = 0.95)
```

```
##                   2.5 %     97.5 %
## (Intercept) 14.45408609 16.0404255
## Exhaust      0.07051175  0.1431443
## Distan       0.25412861  0.3490856
## PartConfl    0.43971116  0.7073143
```

Betrachten wir erneut den Prädiktore Emotionale Erschöpfung. Als Konfidenzintervall erhalten wir die untere Grenze von 0.0705117 und die obere Grenze von 0.1431443. Dies bedeutet, dass wir zu 95% sicher sind, dass dieses Intervall den wahren Wert für das Gewicht $b_1$ enthält. Es wird auch nochmal deutlich, dass die 0 nicht in diesem Intervall enthalten ist. Wenn wir dies in Bezug zu den formulierten Hypothesen für die inferenzstatistische Testung eines einzelnen Prädiktors betrachtet, widerspricht dies also der $H_0$. Wir würden uns also mit einem $\alpha$ von 0.05 auch bei Betrachtung des Konfidenzintervalls gegen die Beibehaltung der $H_0$ entscheiden. Die beiden Wege (Durchführung des t-Tests und Betrachtung des Konfidenzintervalls) müssen immer zum selben Ergebnis führen.

Abschließend noch ein essentieller Punkt zur Testung einzelner Prädiktoren: Von enormer Wichtigkeit ist sich dabei bewusst zu machen, dass die eben besprochenen Ergebnisse für den Prädiktor Emotionale Erschöpfung nur für dieses Set an Prädiktoren gelten. Sobald wir weitere Prädiktoren hinzufügen, Prädiktoren entfernen oder diese auswechseln, können sich die Ergebnisse ändern.

### Vorhersage der abhängigen Variable

Durch die Erstellung unseres Regressionsmodells haben wir nun die Möglichkeit, einer Person einen Wert für die abhängige Variable vorherzusagen. Dies geschieht durch die Anwendung der Regressionsgewichte auf die Werte der Prädiktoren. In unserem Fall wollen wir die Gewalttätigkeit gegenüber Kindern vorhersagen. Stellen wir uns vor, dass die neue Person einen Wert von 3 für Emotionale Erschöpfung, 4 für Emotionale Distanz und 2 für Konflikte mit dem Partner hat. Hier gibt es wieder viele Wege zum Ziel. Wir legen zuerst einen neuen Datensatz an, der die Werte der Prädiktoren enthält. 


``` r
predict_data <- data.frame(Exhaust = 3, Distan = 4, PartConfl = 2)
```

Anschließend können wir die Funktion `predict()` auf unser Modell anwenden. 


``` r
predict(mod, newdata = predict_data)
```

```
##        1 
## 17.92119
```

Wir haben für die Person nun eine Punktschätzung von 17.92 für die Gewalttätigkeit. Gleichzeitig wissen wir aber auch, dass dies keine perfekte Vorhersage ist. Schließlich sagen die Prädiktoren nicht 100% der Varianz der abhängigen Variable vorher. Wir sollten also ein Intervall um unsere Punktschätzung legen. Dieses wird in der Regression als Prognoseintervall bezeichnet.

Für die Bestimmung müssen wir nur optionale Argumente in der Funktion `predict()` nutzen. Diese umfassen erstmal die Art des Intervalls, das wir bestimmen wollen `interval = "prediction"` und das Konfidenzniveau `level = 0.95`.


``` r
predict(mod, newdata = predict_data, interval = "prediction", level = 0.95)
```

```
##        fit      lwr      upr
## 1 17.92119 5.349854 30.49253
```

Das berechnete Intervall enthält nun zu 95\% den wahren Wert der Person. Die breite des Intervalls hängt in erster Linie von der Varianz der Fehler ab, da diese die Sicherheit unserer Regression repräsentiert. Ein Vergleich mit der Berechnung "per Hand" und warum sich dort Unterschiede ergeben können, findet sich in [Appendix A](#appendix-a). 

## Modellvergleiche bzw. Modelloptimierung

Bei der Regressionsanalyse hat die Modelloptimierung zum Ziel, ein Regresionsmodell zu verbessern - das heißt, möglichst viel Varianz der abhängigen Variable zu erklären. Dadurch wird die "Vorhersage" der abhängigen Variable genauer (die Streuung der Werte um die Regressionsgerade/-hyperebene ist kleiner).

**Modelloptimierung** bedeutet, ein Modell zu verbessern, durch: 

* Aufnehmen zusätzlicher, bedeutsamer Prädiktoren
* Ausschließen von Prädiktoren, die nicht zur Varianzaufklärung beitragen

**Ziel** ist ein *sparsames Modell*, in dem 

* jeder enthaltene Prädiktor einen Beitrag zur Varianzaufklärung des Kriteriums leistet und
* kein wichtiger (= vorhersagestarker) Prädiktor vergessen wurde.

In diesem Kontext sind zwei der drei unterschiedlichen _Erkenntnisinteressen_ relevant, die Sie im ersten Semester in BSc1 kennengelernt haben:

1. In explanativen Studien: Aus bisheriger Forschungs werden relevante Prädiktoren identifiziert und es soll geprüft werden, ob diese theoretisch relevanten Prädiktoren auch empirisch relevant (also statistisch bedeutsam) sind. Hier geht es also um die Testung von spezfisichen Hypothesen.
2. In explorativen Studien: In der Studie gibt es eine größere Menge möglicher Prädiktoren und es soll herausgefunden werden, welche davon statistisch bedeutsam sind und welche sich als irrelevant erweisen. Hier werden die Erkenntnisse allerdings an _einem_ Datensatz gewonnen, sodass es zum sogenannten Overfitting kommen kann - einer zu starken Anpassung des Modells an die Daten. Grund dafür können z.B. einfache $\alpha$- und $\beta$-Fehler sein, die dazu führen dass wir irrelevant Prädiktoren aufgenommen ($\alpha$) oder bedeutende Prädiktoren ($\beta$) übersehen haben. Außerdem ist es natürlich möglich, dass die Stichprobe nicht zu 100% repräsentativ ist - die Inferenzpopulation also nicht deckungsgleihc mit der Zielpopulaiton ist. Daher müssen so gewonnene Erkenntnisse immer in weiteren explanativen Studien überprüft werden.

### Hypothesengeleitete Modellvergleiche

Wie bereits beschrieben werden in der theoriegeleiteten Testung Modelle aus den Hypothesen abgeleitet und dann gegeneinander getestet. Dabei soll das Modell identifziert werden, dass die Varianz der abhängigen Variable besser erklären kann. Der Unterschied in der erklärten Varianz zwischen zwei Modellen wird je nach Fragestellung als Inkrement / Dekrement bezeichnet. Mit Inkrement und Dekrement meinen wir hier das Varianzinkrement/-dekrement, also das Hinzukommen oder die Abnahme der erklärten Varianz in unserem Modell. Modelltests wurden auch bereits [im ersten Semester](/lehre/statistik-i/multiple-reg/#modellvergleiche) besprochen.  

Erstellen wir uns ein praktisches Beispiel. Wir haben bereits unser Modell, in dem wir die Gewalttätigkeit durch die Emotionale Erschöpfung, die Emotionale Distanz und die Konflikte mit dem Partner / der Partnerin vorhergesagt haben. Nun gibt es eine andere Gruppe von Forscher*innen, die theoretisch herleiten und anschließend aufzeigen wollen, dass die zusätzliche Aufnahme der Vernachlässigung der Kinder (`Neglect`) und Entfremdung des Partners / der Partnerin (`PartEstrang`) die Varianz der Gewalttätigkeit besser erklären kann. Dies ist ein typisches Beispiel für einen hypothesengeleiteten Modellvergleich in dem ein Inkrement getestet wird. 

Die Modelle, die im Vergleich getestet werden, müssen geschachtelt sein. Das bedeutet, dass das Modell mit weniger Prädiktoren in dem Modell mit mehr Prädiktoren enthalten ist. Dies ist in unserem Fall gegeben, da das Modell mit 5 Prädiktoren (Emotionale Erschöpfung, Emotionale Distanz, Konflikte mit dem Partner / der Partnerin, Vernachlässigung der Kinder und Entfremdung des Partners / der Partnerin) das Modell mit 3 Prädiktoren (Emotionale Erschöpfung, Emotionale Distanz und Konflikte mit dem Partner / der Partnerin) enthält. Um die Modelle auch sprachlich zu unterscheiden, haben sich die Bezeichungen unrestricted bzw. unconstrained (auf deutsch uneingeschränkt) und restricted bzw. constrained (auf deutsch eingeschränkt) etabliert. Das unrestricted Modell enthält also alle Prädiktoren, während das restricted Modell nur eine Teilmenge der Prädiktoren enthält.

In `R` können wir das Modell mit allen Prädiktoren wie folgt erstellen:


``` r
mod_unrestricted <- lm(Violence ~ Exhaust + Distan + 
                         PartConfl + Neglect + PartEstrang, data = burnout)
```

Um die Benennung nochmal klarer zu machen, nennen wir das Modell `mod`, das wir bereits im ersten Teil des Tutorials erstellt haben, `mod_restricted`. Dies ist aber optional und dient nur der besseren Unterscheidung. 


``` r
mod_restricted <- mod
```

In einem Modelltest wird im Endeffekt der Zugewinn an erklärter Varianze durch die Aufnahme weiterer Prädiktoren getestet. Dies geschieht durch den Vergleich der erklärten Varianz des Modells mit den zusätzlichen Prädiktoren (unrestricted) mit der erklärten Varianz des Modells ohne diese Prädiktoren (restricted). 

Die beiden Werte können wir uns direkt anzeigen lassen, indem wir aus dem jeweiligen `summary()` nur den Abschnitt mit dem $R^2$-Wert (`r.squared`) mittels `$` extrahieren. 


``` r
summary(mod_unrestricted)$r.squared
```

```
## [1] 0.4170518
```

``` r
summary(mod_restricted)$r.squared
```

```
## [1] 0.288923
```

Der Unterschied in der Varianzerklärung ist nun die Differenz der beiden eben betrachteten Werte ($\Delta R^2 = R_u^2 - R_r^2$):


``` r
summary(mod_unrestricted)$r.squared - summary(mod_restricted)$r.squared
```

```
## [1] 0.1281288
```

Der Anteil der hinzugenommenen Varianz beträgt also 12.8%. Dies ist also das Inkrement der beiden aufgenommenen Variablen bezeichnet. Wie es bereits mehrfach in diesem Tutorial der Fall war, handelt es sich aber erstmal um einen deskriptivstatistischen Wert. Um sicherzugehen, dass dieser Wert in der Population von 0 verschieden ist, führen wir einen F-Test durch. 

Die Umsetzung in `R` geschieht mit der Funktion `anova()` (was im weiteren Verlauf des Semesters zu Verwirrungen führen könnte).


``` r
anova(mod_restricted, mod_unrestricted)
```

```
## Analysis of Variance Table
## 
## Model 1: Violence ~ Exhaust + Distan + PartConfl
## Model 2: Violence ~ Exhaust + Distan + PartConfl + Neglect + PartEstrang
##   Res.Df   RSS Df Sum of Sq      F    Pr(>F)    
## 1   1547 63410                                  
## 2   1545 51984  2     11426 169.79 < 2.2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```


Im Output sehen wir zunächst eine Übersicht über die beiden Modelle (auch mehr als 2 Modelle sind möglich, die Modelle müssen nur geschachtelt sein, also auseinander hervorgehen, damit sie sinnvoll miteinander verglichen werden können). `Model 1` ist das Modell mit weniger Prädiktoren, während `Model 2` das Modell mit allen Prädiktoren beschreibt. Die Zahlen 1 und 2 beschreiben dann die Zeilen der Modelle. `Res.Df` sind die Residualfreiheitsgrade (diese lassen sich bestimmen, indem von der Stichprobengröße $N$ die Anzahl der zu schätzenden Koeffizienten inklusive Interzept abgezogen werden). `RSS` ist die Residual Sum of Squares, also die Residualquadratsumme. `Df` sind die Freiheitsgrade (Degrees of Freedom). `Sum of Sq` ist die durch die hinzukommenden Prädiktoren erklärte Quadratsumme, welche sich einfach durch die Differenz der beiden `RSS` bestimmen lässt. `F` beschreibt den $F$-Wert, der die Änderung in den `Sum of Sq` an der zufälligen Streuung relativiert. `Pr(>F)` ist die Spalte mit den zu dem $F$-Werten gehörigen $p$-Werte, also die Spalte, die uns besonders interessiert!

Das Inkrement der beiden Prädiktoren ist auf einem Alpha-Fehlerniveau von 0.05 signifikant von null verschieden ($p<.001$). Somit wird der Anteil erklärter Varianz statistisch bedeutsam vergrößert. Die neue Gruppe von Forscher*innen hat also gezeigt, dass die zusätzliche Aufnahme der Vernachlässigung der Kinder und Entfremdung des Partners / der Partnerin die Varianz der Gewalttätigkeit besser erklären kann. Dieses Modell mit 5 Prädiktoren sollte als aktueller Stand der Wissenschaft gewertet werden.

### Automatisierte Modellsuche

Inkremente und Dekremente können theoriegeleitet getestet werden. In manchen Untersuchungen gibt es für die Modelle aber noch keine Hypothesen und mögliche Prädiktoren sollen erstmal exploriert werden. Wir versetzen uns also in ein neues Anwendungsszenario, in dem wir keine Hypothesen dazu haben, wie die Gewalttätigkeit vorhergesagt werden kann. Wir haben also eine größere Menge an möglichen Prädiktoren und wollen nun diejenigen finden, die die Varianz der Gewalttätigkeit in unserem Datensatz am besten erklären.

Es gibt verschiedene Vorgehensweisen bei der explorativen Suche nach einem Modell. Es kann variiert werden, ob vorwärts, rückwärts oder in beide Richtungen gesucht wird. Weiterhin kann das Kriterium für den Einschluss und Ausschluss von Prädiktoren variiert werden. Wir betrachten im folgenden zwei Beispiele aus diesem weiten Raum an Möglichkeiten - einmal machen wir uns die inferenzstatistische Testung von Inkrementen und Dekrementen zu Nutze und einmal sogenannte Informationskriterien.

Wie immer gibt es in `R` viele weitere Wege, zum selben Ziel zu kommen. Das Paket `olsrr` beinhaltet verschiedene Funktionen, die für die Regressionsanalyse nützlich sind, u.a. auch Funktionen, die die schrittweise Auswahl von Prädiktoren auf Basis verschiedener Kriterien und nach verschiedenen Methoden (vorwärts, rückwärts, etc.) ermöglichen. Finden Sie [hier](https://olsrr.rsquaredacademy.com/articles/variable_selection.html#best-subset-regression) mehr Informationen dazu. Bei der ersten Nutzung muss das Paket natürlich installiert werden. 


``` r
install.packages("olsrr")
```

Für die Nutzung ist die Aktivierung mit `library()` notwendig.


``` r
library(olsrr)
```

```
## Warning: Paket 'olsrr' wurde unter R Version 4.4.3 erstellt
```

```
## Need help getting started with regression models? Visit: https://www.rsquaredacademy.com
```

```
## 
## Attache Paket: 'olsrr'
```

```
## Das folgende Objekt ist maskiert 'package:datasets':
## 
##     rivers
```

#### Nutzung der Testung von Inkrementen und Dekrementen

Die Funktion `ols_step_both_p()` beinhaltet die Auswahl auf Basis der Signifikanz des Inkrements oder Dekrements und führt in jedem Schritt Tests für Einschluss und Ausschluss durch. Sie nutzt also die Technik, die wir gerade für den theorigeleiteten Modellvergleich auch genommen haben. Dieses Vorgehen sollte nicht als Default angesehen werden, da einige Probleme bestehen, auf die wir nach der Demonstration eingehen. Aufgrund der Prävalenz des Vorgehens haben wir uns dazu entschieden, es auch zu präsentieren.

Für die Anwendung der Funktion `ols_step_both_p()` benötigen wir zunächst ein Modell, das wir auf Basis der explorativen Suche optimieren wollen. Wir erstellen also ein Modell, das alle Prädiktoren enthält. Wenn wir uns dabei ersparen wollen, alle Prädiktoren einzeln aufzuschreiben, können wir die `.` nutzen. Dies führt dazu, dass alle anderen Variablen im Datensatz genutzt werden. Hier ist es besonders wichtig, dass Sie also auch den Datensatz mit 7 Spalten vorliegen haben!


``` r
# Modell mit allen Prädiktoren
mod_all <- lm(Violence ~ ., data = burnout)
```

Nun zu der Anwendung der `ols_step_both_p()`-Funktion: Der erste Input ist das eben aufgestellte Regressionsmodell. Über die zusätzlichen Argumente kann gesteuert werden, wie streng bei Aufnahme und Ausschluss getestet wird. Über das Argument `details` können Sie den gesamten Verlauf der schrittweisen Selektion (nicht nur das finale Ergebnis) anzeigen lassen. `p_enter` ist der p-Wert, der für das "entering" in das Modell zuständig ist. Also muss das Inkrement einen p-Wert von $p<.05$ haben, wenn wir `p_enter = .05` wählen.`p_remove` ist der p-Wert, der für das "removing" aus dem Modell zuständig ist. Also muss das Dekremnt einen p-Wert von $p>.10$ haben, wenn wir `p_remove = .10` wählen. `details = TRUE` fordert weitere Informationen an.


``` r
# Anwendung der iterativen Modellbildung
ols_step_both_p(mod_all, p_enter = .05, p_remove = .10, details = TRUE)
```

```
## Stepwise Selection Method 
## -------------------------
## 
## Candidate Terms: 
## 
## 1. Exhaust 
## 2. Distan 
## 3. Ineffic 
## 4. Neglect 
## 5. PartEstrang 
## 6. PartConfl 
## 
## 
## Step   => 0 
## Model  => Violence ~ 1 
## R2     => 0 
## 
## Initiating stepwise selection... 
## 
## Step      => 1 
## Selected  => Neglect 
## Model     => Violence ~ Neglect 
## R2        => 0.351 
## 
## Step      => 2 
## Selected  => Exhaust 
## Model     => Violence ~ Neglect + Exhaust 
## R2        => 0.399 
## 
## Step      => 3 
## Selected  => Ineffic 
## Model     => Violence ~ Neglect + Exhaust + Ineffic 
## R2        => 0.417 
## 
## Step      => 4 
## Selected  => PartConfl 
## Model     => Violence ~ Neglect + Exhaust + Ineffic + PartConfl 
## R2        => 0.432 
## 
## 
## No more variables to be added or removed.
```

```
## 
## 
##                                  Stepwise Summary                                  
## ---------------------------------------------------------------------------------
## Step    Variable            AIC          SBC         SBIC        R2       Adj. R2 
## ---------------------------------------------------------------------------------
##  0      Base Model       10689.734    10700.428    6286.957    0.00000    0.00000 
##  1      Neglect (+)      10021.467    10037.507    5619.403    0.35089    0.35047 
##  2      Exhaust (+)       9904.797     9926.184    5502.932    0.39870    0.39792 
##  3      Ineffic (+)       9859.783     9886.516    5458.052    0.41665    0.41552 
##  4      PartConfl (+)     9821.429     9853.509    5419.911    0.43164    0.43017 
## ---------------------------------------------------------------------------------
## 
## Final Model Output 
## ------------------
## 
##                          Model Summary                           
## ----------------------------------------------------------------
## R                       0.657       RMSE                  5.716 
## R-Squared               0.432       MSE                  32.678 
## Adj. R-Squared          0.430       Coef. Var            25.168 
## Pred R-Squared          0.425       AIC                9821.429 
## MAE                     4.031       SBC                9853.509 
## ----------------------------------------------------------------
##  RMSE: Root Mean Square Error 
##  MSE: Mean Square Error 
##  MAE: Mean Absolute Error 
##  AIC: Akaike Information Criteria 
##  SBC: Schwarz Bayesian Criteria 
## 
##                                  ANOVA                                   
## ------------------------------------------------------------------------
##                  Sum of                                                 
##                 Squares          DF    Mean Square       F         Sig. 
## ------------------------------------------------------------------------
## Regression    38491.144           4       9622.786    293.522    0.0000 
## Residual      50683.794        1546         32.784                      
## Total         89174.937        1550                                     
## ------------------------------------------------------------------------
## 
##                                  Parameter Estimates                                  
## -------------------------------------------------------------------------------------
##       model     Beta    Std. Error    Std. Beta      t        Sig     lower    upper 
## -------------------------------------------------------------------------------------
## (Intercept)    7.584         0.500                 15.162    0.000    6.602    8.565 
##     Neglect    0.368         0.018        0.445    20.585    0.000    0.333    0.403 
##     Exhaust    0.124         0.014        0.186     8.666    0.000    0.096    0.152 
##     Ineffic    0.156         0.022        0.142     6.988    0.000    0.113    0.200 
##   PartConfl    0.394         0.062        0.130     6.384    0.000    0.273    0.515 
## -------------------------------------------------------------------------------------
```

Der Output ist extrem detailliert. Uns wird nach jedem Step zunächst gesagt, welcher Prädiktor gewählt wurde und wie sich das $R^2$ (`R-Squared`) verändert. Allerdings wird nicht aufgeführt wird, wie die jeweiligen Inkremente oder Dekremente der anderen Variablen ausgefallen waren, die nicht selektiert wurden. 

Anschließend werden nochmal spezifische Fit-Kriterien für jeden Schritt aufgezeigt (siehe `Stepwise Summary`), deren Werte wir im nächsten Abschnitt zum Teil nochmal besprechen werden. Insgesamt wurden 4 Schritte benötigt, bei denen Prädiktoren hinzugefügt wurden (`addition`). Zur Entfernung von Prädiktoren kam es nicht, weshalb unser Modell vier Prädiktoren enthält. In `Final Model Output` erhalten wir, wie der Name sagt, Informationen über das finale Modell. Bspw. testet der Abschnitt `ANOVA` das Gesamtmodell auf Signifikanz. Der Abschnitt `Parameter Estimates` die Koeffizienten des final geschätzten Modells. 

Wie bereits angekündigt, kann man die Nutzung der Testung von Inkrementen und Dekrementen im explorative Fall in Frage stellen. Durch das sehr häufige Testen, besonders bei einer großen Menge an möglichen Prädiktoren, kann das $\alpha$-Fehlerniveau nicht eingehalten werden kann. Eigentlich müsste dann nämlich bspw. Bonferroni korrigiert werden, was wiederum schwierig ist, wenn wir die Anzahl der Tests im Vorhinein kennen. Sie erkennen, das ganze Thema ist eine Wissenschaft für sich! Weiterhin ist es auch aus forschungstheoretischer Sicht fraglich, Inferenzstatistik an dieser Stelle zu benutzen, da diese mit Hypothesen einhergeht. Im explorativen Fall haben wir aber gerade keine Hypothesen. Wir empfehlen daher ein anderes Vorgehen bei der explorativen Suche, das wir im folgenden Abschnitt beschreiben.

#### Nutzung von Informationskriterien

Eine weitere "theoriefreie" schrittweise Auswahl von Prädiktoren kann in `R` mit der `step()`-Funktion erfolgen. Diese macht, anders als unser zuvor demonstriertes Vorgehen, nicht von Inkrementen und deren inferenzstatistischer Absicherung Gebrauch, sondern standardmäßig vom sogenannten Informationskriterium AIC (*Akaike Information Criterion*). Dieses basiert auf der **Likelihood** $L(\hat{\theta})$ eines geschätzten Modells und der Anzahl der Modellparameter $p$. Zur besseren Berechnung im Hintergrund wird dabei die logarithmierte Likelihood genutzt ($LL$):

$AIC=-2LL(\hat{\theta}) + 2p$

Die Likelihood bezeichnet ein Maß für die Plausibilität des Modells. 
Diese wird über die  Wahrscheinlichkeit der (empirisch erhobenen) Daten gegeben der berechneten Modellparameter dargestellt. Die Frage lautet einfach formuliert also: Wie wahrscheinlich würde ich die epmirischen Daten erhalten, wenn in der Population die berechneten Modellparameter gelten würden? Um das beste Modell zu finden, kann man die Likelihood verschiedener Modelle vergleichen. Höhere Likelihoodwerte zeigen bessere Modelle an, da sie eine höhere Plausibilität haben. Allerdings verbessert sich die Likelihood immer, wenn wir weitere Prädiktoren aufnehmen. Eine reine Verbesserung des Likelihood ist damit nicht repräsentativ für ein besseres Modell. 

Deshalb werden Informationskriterien wie der AIC verwendet, da er zusätzlich zur (log)Likelihood auch noch die Komplexität des Modells berücksichtigt. Komplexere Modelle mit vielen Prädiktoren werden "bestraft" durch den Bestrafungsterm $2p$.

Für lineare Regressionsmodelle lässt sich der AIC wie folgt darstellen:

$AIC_{\sigma}=n \cdot log(\sigma_e^2) + 2p$

Der AIC ist hier eine Funktion der Stichprobengröße $n$, der Residualvarianz $\sigma_e^2$ und der Anzahl der Parameter (= Regressionskoeffizienten) $p=m+1$. Es wird ersichtlich, dass der AIC von der Varianz der abhängigen Variablen abhängt, da diese wiederum die Residualvarianz beeinflusst.

Der AIC ist ein sogenanntes inverses Maß, das bedeutet, dass Modelle mit einem kleineren AIC besser sind als Modelle mit einem größeren AIC. Man kann sich den AIC also als eine Art Distanzmaß vorstellen (Achtung, das ist nur eine Anschauung) zwischen Daten und Modell. Der AIC wird durch den Term $n \cdot log(\sigma_e^2)$ kleiner, wenn die Residualvarianz kleiner wird, also mehr Varianz erklärt wird. Durch den "Strafterm" $2p$ wird der AIC größer, wenn das Modell mehr Prädiktoren enthält. Es soll also ein Modell gefunden werden, das mit möglichst wenigen Prädiktoren möglichst viel Varianz erklärt (*Sparsamkeitsprinzip*).

Auch hier kann die Selektion "vorwärts", "rückwärts", oder in beide Richtungen erfolgen. Wir wollen eine Foward-Backward (also vor und rückwärts) Selektion durchführen und wählen daher `direction = "both"`. Eine reine Forward oder reine Backward Selektion können wir auch über `direction` einstellen. Lesen Sie dazu `?step`. Die Standardeinstellung der `step`-Funktion ist die, dass ein Modell mit allen möglichen Prädiktoren als Ausgangspunkt genommen wird. Es wird dann der Prädiktor ausgeschlossen, der die größte Reduktion des AIC erlaubt, dann der nächste, usw. In jedem Schritt wird auch wieder geprüft, ob Prädiktoren, die *nicht* im Modell sind, bei Aufnahme wieder zu einer Reduktion des AIC führen würden. Das Verfahren stoppt, wenn: 

1. nur noch Prädiktoren im Modell sind, deren Ausschluss zu einer Erhöhung des AIC führen würden und
2. nur Prädiktoren "übrig" sind, deren Einschluss den AIC nicht verbessern würde.

Wenden wir die Logik der `step()`-Funktion auf unser Modell an. 


``` r
# Optimierung des Modells nach AIC
step(mod_all, direction = "both")
```

```
## Start:  AIC=5419.39
## Violence ~ Exhaust + Distan + Ineffic + Neglect + PartEstrang + 
##     PartConfl
## 
##               Df Sum of Sq   RSS    AIC
## - Distan       1      20.8 50623 5418.0
## - PartEstrang  1      58.2 50661 5419.2
## <none>                     50602 5419.4
## - PartConfl    1     946.3 51549 5446.1
## - Ineffic      1    1382.1 51984 5459.2
## - Exhaust      1    1603.2 52206 5465.8
## - Neglect      1    9856.4 60459 5693.4
## 
## Step:  AIC=5418.02
## Violence ~ Exhaust + Ineffic + Neglect + PartEstrang + PartConfl
## 
##               Df Sum of Sq   RSS    AIC
## - PartEstrang  1      60.7 50684 5417.9
## <none>                     50623 5418.0
## + Distan       1      20.8 50602 5419.4
## - PartConfl    1     934.6 51558 5444.4
## - Ineffic      1    1552.0 52175 5462.9
## - Exhaust      1    2407.5 53031 5488.1
## - Neglect      1   12956.1 63579 5769.5
## 
## Step:  AIC=5417.88
## Violence ~ Exhaust + Ineffic + Neglect + PartConfl
## 
##               Df Sum of Sq   RSS    AIC
## <none>                     50684 5417.9
## + PartEstrang  1      60.7 50623 5418.0
## + Distan       1      23.2 50661 5419.2
## - PartConfl    1    1336.0 52020 5456.2
## - Ineffic      1    1600.8 52285 5464.1
## - Exhaust      1    2462.3 53146 5489.5
## - Neglect      1   13891.8 64576 5791.6
```

```
## 
## Call:
## lm(formula = Violence ~ Exhaust + Ineffic + Neglect + PartConfl, 
##     data = burnout)
## 
## Coefficients:
## (Intercept)      Exhaust      Ineffic      Neglect    PartConfl  
##      7.5836       0.1238       0.1564       0.3682       0.3937
```

Der Output enthält folgende Inhalte:


```
## Start:  AIC=5419.39
## Violence ~ Exhaust + Distan + Ineffic + Neglect + PartEstrang + 
##     PartConfl
```

zeigt uns das Anfangsmodell und den zugehörigen AIC.


```
##               Df Sum of Sq   RSS    AIC
## - Distan       1      20.8 50623 5418.0
## - PartEstrang  1      58.2 50661 5419.2
## <none>                     50602 5419.4
## - PartConfl    1     946.3 51549 5446.1
## - Ineffic      1    1382.1 51984 5459.2
## - Exhaust      1    1603.2 52206 5465.8
## - Neglect      1    9856.4 60459 5693.4
```

ist der Output des ersten Schrittes. `<none>` beschreibt unser Modell (ohne Veränderung). Jede Zeile steht für ein Modell, in welchem jeweils maximal ein Prädiktor aus dem Modell ausgeschlossen wird oder maximal ein Prädiktor in das Modell aufgenommen wird. Das "Minus" (`-`) am Anfang der Zeile zeigt an, dass hier ein Prädiktor ausgeschlossen wird. Eine "Plus" (`+`) zeigt an, dass der jeweilige Prädiktor hinzukam. Die `Df` zeigen wieder an, wie sich die Freiheitsgrade verändern. Würden wir eine Variable verwenden, die aus mehr als 2 Faktorstufen besteht, würden hier auch `Df` größer 1 stehen. `Sum of Sq` zeigt an, wie sich die Sum of Squares verändern. `RSS` ist wieder die Residual Sum of Squares, wie oben. Der Algorithmus entscheidet sich an dieser Stelle für den Ausschluss der Variable `Distan`


```
## Step:  AIC=5418.02
## Violence ~ Exhaust + Ineffic + Neglect + PartEstrang + PartConfl
## 
##               Df Sum of Sq   RSS    AIC
## - PartEstrang  1      60.7 50684 5417.9
## <none>                     50623 5418.0
## - PartConfl    1     934.6 51558 5444.4
## - Ineffic      1    1552.0 52175 5462.9
## - Exhaust      1    2407.5 53031 5488.1
## - Neglect      1   12956.1 63579 5769.5
## 
## Step:  AIC=5417.88
## Violence ~ Exhaust + Ineffic + Neglect + PartConfl
## 
##             Df Sum of Sq   RSS    AIC
## <none>                   50684 5417.9
## - PartConfl  1    1336.0 52020 5456.2
## - Ineffic    1    1600.8 52285 5464.1
## - Exhaust    1    2462.3 53146 5489.5
## - Neglect    1   13891.8 64576 5791.6
```

Der nächste Step beginnt nun mit dem verbesserten AIC, der erlangt wurde, indem `Distan` aus dem Modell gestrichen wurde. Es wird ein weiterer Ausschluss (der Variable `PartEstrang`) veranlasst. Nach diesem ist jedoch keine weitere Verbesserung mehr möglich, weshalb der Algorithmus dann stoppt. 

Am Ende des Outputs sehen wir das "finale" Modell, das durch die `step()`-Funktion ausgewählt wurde. Hier sehen wir zunächst nur die Regressionsgewichte. Um auch weitere Informationen, wie bspw. das $R^2$ zu erhalten, können wir die `summary()`-Funktion mit der `step()`-Funktion schachteln.


``` r
# Ergänzung des Outputs
summary(step(mod_all, direction = "both"))
```

```
## Start:  AIC=5419.39
## Violence ~ Exhaust + Distan + Ineffic + Neglect + PartEstrang + 
##     PartConfl
## 
##               Df Sum of Sq   RSS    AIC
## - Distan       1      20.8 50623 5418.0
## - PartEstrang  1      58.2 50661 5419.2
## <none>                     50602 5419.4
## - PartConfl    1     946.3 51549 5446.1
## - Ineffic      1    1382.1 51984 5459.2
## - Exhaust      1    1603.2 52206 5465.8
## - Neglect      1    9856.4 60459 5693.4
## 
## Step:  AIC=5418.02
## Violence ~ Exhaust + Ineffic + Neglect + PartEstrang + PartConfl
## 
##               Df Sum of Sq   RSS    AIC
## - PartEstrang  1      60.7 50684 5417.9
## <none>                     50623 5418.0
## + Distan       1      20.8 50602 5419.4
## - PartConfl    1     934.6 51558 5444.4
## - Ineffic      1    1552.0 52175 5462.9
## - Exhaust      1    2407.5 53031 5488.1
## - Neglect      1   12956.1 63579 5769.5
## 
## Step:  AIC=5417.88
## Violence ~ Exhaust + Ineffic + Neglect + PartConfl
## 
##               Df Sum of Sq   RSS    AIC
## <none>                     50684 5417.9
## + PartEstrang  1      60.7 50623 5418.0
## + Distan       1      23.2 50661 5419.2
## - PartConfl    1    1336.0 52020 5456.2
## - Ineffic      1    1600.8 52285 5464.1
## - Exhaust      1    2462.3 53146 5489.5
## - Neglect      1   13891.8 64576 5791.6
```

```
## 
## Call:
## lm(formula = Violence ~ Exhaust + Ineffic + Neglect + PartConfl, 
##     data = burnout)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -15.416  -3.255  -0.763   2.382  39.718 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  7.58356    0.50016  15.162  < 2e-16 ***
## Exhaust      0.12375    0.01428   8.666  < 2e-16 ***
## Ineffic      0.15644    0.02239   6.988 4.14e-12 ***
## Neglect      0.36823    0.01789  20.585  < 2e-16 ***
## PartConfl    0.39368    0.06167   6.384 2.28e-10 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 5.726 on 1546 degrees of freedom
## Multiple R-squared:  0.4316,	Adjusted R-squared:  0.4302 
## F-statistic: 293.5 on 4 and 1546 DF,  p-value: < 2.2e-16
```


Sparsamkeit wird beim AIC im "Strafterm" $2p$ nicht so hoch gewichtet wie bei anderen Informationskriterien. In der Funktion `step` kann man über die Veränderung des Parameters `k` steuern, wie streng die Prädiktorauswahl vorgenommen wird. Wenn man hier $k = log(n)$ angibt, wird statt des AIC das sogenannte Bayes'sche Informationskriterium BIC (*Bayesian Information Criterion*) verwendet.

$BIC=-2L(\hat{\theta}) + log(n)\cdot p$

Vorsicht, in der Ausgabe der `step`-Funktion steht immer AIC, auch wenn dies nur mit der Standardeinstellung von $k=2$ tatsächlich dem AIC entspricht!


``` r
# Optimierung mit BIC
summary(step(mod_all, direction = "both", k=log(nrow(burnout))))
```

```
## Start:  AIC=5456.81
## Violence ~ Exhaust + Distan + Ineffic + Neglect + PartEstrang + 
##     PartConfl
## 
##               Df Sum of Sq   RSS    AIC
## - Distan       1      20.8 50623 5450.1
## - PartEstrang  1      58.2 50661 5451.2
## <none>                     50602 5456.8
## - PartConfl    1     946.3 51549 5478.2
## - Ineffic      1    1382.1 51984 5491.3
## - Exhaust      1    1603.2 52206 5497.8
## - Neglect      1    9856.4 60459 5725.5
## 
## Step:  AIC=5450.1
## Violence ~ Exhaust + Ineffic + Neglect + PartEstrang + PartConfl
## 
##               Df Sum of Sq   RSS    AIC
## - PartEstrang  1      60.7 50684 5444.6
## <none>                     50623 5450.1
## + Distan       1      20.8 50602 5456.8
## - PartConfl    1     934.6 51558 5471.1
## - Ineffic      1    1552.0 52175 5489.6
## - Exhaust      1    2407.5 53031 5514.8
## - Neglect      1   12956.1 63579 5796.2
## 
## Step:  AIC=5444.61
## Violence ~ Exhaust + Ineffic + Neglect + PartConfl
## 
##               Df Sum of Sq   RSS    AIC
## <none>                     50684 5444.6
## + PartEstrang  1      60.7 50623 5450.1
## + Distan       1      23.2 50661 5451.2
## - PartConfl    1    1336.0 52020 5477.6
## - Ineffic      1    1600.8 52285 5485.5
## - Exhaust      1    2462.3 53146 5510.8
## - Neglect      1   13891.8 64576 5813.0
```

```
## 
## Call:
## lm(formula = Violence ~ Exhaust + Ineffic + Neglect + PartConfl, 
##     data = burnout)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -15.416  -3.255  -0.763   2.382  39.718 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  7.58356    0.50016  15.162  < 2e-16 ***
## Exhaust      0.12375    0.01428   8.666  < 2e-16 ***
## Ineffic      0.15644    0.02239   6.988 4.14e-12 ***
## Neglect      0.36823    0.01789  20.585  < 2e-16 ***
## PartConfl    0.39368    0.06167   6.384 2.28e-10 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 5.726 on 1546 degrees of freedom
## Multiple R-squared:  0.4316,	Adjusted R-squared:  0.4302 
## F-statistic: 293.5 on 4 and 1546 DF,  p-value: < 2.2e-16
```

Die Anwendung eines Informationskriteriums mit strengerem Fokus auf Sparsamkeit macht in unserem Anwendungsbeispiel keinen Unterschied. Dies ist jedoch nicht die Regel!

An dieser Stelle sei nochmal erwähnt, dass nach der explorativen Suche von Prädiktoren eine konformative, also theoriegeleitete Studie folgen sollte, in der wir Hypothesen aufstellen und diese inferenzstatistisch prüfen. Durch das explorative Vorgehen haben wir das Modell gewonnen, das auf unseren vorliegenden Datensatz am besten passt - ein Übertrag auf die Population sollte dadurch aber noch nicht gemacht werden.

##### Ergänzung: Unterschiede im AIC

Wer den Output der beiden neu gelernten Funktionen etwas genauer betrachtet, bemerkt, dass der AIC, der in der `step()`-Funktion berichtet wird, nicht identisch mit demjenigen AIC ist, der in `ols_step_both_p()` angezeigt wird. Zu Recht kann man sich nun fragen, ob hier ein Fehler passiert. Die Antwort ist nein (und ja). Es werden tatsächlich unterschiedliche Berechnungen für den AIC herangezogen. In `step()` wird intern die `extractAIC()`-Funktion verwendet, während in `ols_step_both_p()` die `AIC`-Funktion verwendet wird:


``` r
AIC(mod_all)
```

```
## [1] 9822.933
```

``` r
extractAIC(mod_all) # erstes Argument ist die Anzahl der Parameter (p)
```

```
## [1]    7.000 5419.386
```

Die `AIC()`-Funktion gibt den "vollständigen" AIC an, während `extractAIC()` eine korrigierte Version heranzieht, aus der sämtlichen irrelevanten Konstanten entfernt wurden. Da der AIC immer nur für Vergleiche auf dem selben Datensatz herangezogen werden sollte, können Konstanten in der Berechnung getrost ignoriert werden, da sie nicht vom betrachteten Modell abhängen. Dazu ein Gedankenexperiment: Für zwei Zahlen $a$ und $b$ (welche bspw. zwei AICs repräsentieren können) gilt: $a>b \Longrightarrow a + c > b + c$ für eine dritte Zahl $c$. Sie sehen also, dass Konstanten, die überall "draufaddiert" werden, den Modellvergleich nicht beeinflussen. 

Um jetzt den Unterschied genau zu erkennen, müssen wir zunächst die **Loglikelihood** (den Logarithmus der Likelihood) unseres Modells bestimmen. Dies geht über den Kurs an dieser Stelle hinaus. Wer sich allerdings für die Überführung des `extractAIC()` zum AIC sowie die Berechnung beider interessiert, kann gerne im [Appendix B](#Appendix-B) vorbeischauen.



***



## Appendix A 

<details><summary><b>Händische Berechnung des Prognoseintervalls</b></summary>

In der Vorlesung haben Sie zur Berechnung des Prognoseintervalls gelernt, dass dies über den Standardfehler geschehen kann. Dafür wurde folgende Gleichung als approximativ gültig beschrieben:

<math>
$$PI = \hat{y} \pm t_{(1-\alpha/2, n-k-1)} \cdot \hat{\sigma}_{e}$$
</math>

Viele Bestandteile dieser Formel haben wir bereits kennengelernt. $\hat{y}$ ist unsere Punktschätzung, $\hat{\sigma_{e}}$ ist der geschätzte Populationsstandardfehler der Residuen. Dieser wurde uns schon im `summary()` Output angezeigt und ist mit `$sigma` ansprechbar. $t_{(1-\alpha/2, n-k-1)}$ ist ein Wert aus der t-Verteilung ($n$ Anzahl an Personen, $k$ Anzahl an Prädiktoren). 


``` r
y_hat <- predict(mod, newdata = predict_data)
sigma_e <- summary(mod)$sigma
n <- nrow(burnout)                             # da keine fehlenden Werte
k <- ncol(predict_data)                        # da in diesem Datensatz nur Werte der Prädiktoren
t <- qt(1 - 0.05/2, n - k - 1)                 # alpha von 0.05 üblich 
```

Wenn wir die Werte in die Formel einsetzen, erhalten wir das Prognoseintervall. 


``` r
# Prognoseintervall händische, approximative Bestimmung
y_hat + t * sigma_e
```

```
##        1 
## 30.47925
```

``` r
y_hat - t * sigma_e
```

```
##        1 
## 5.363133
```

``` r
# Prognoseintervall - Bestimmung durch Funktion
predict(mod, newdata = predict_data, interval = "prediction", level = 0.95)
```

```
##        fit      lwr      upr
## 1 17.92119 5.349854 30.49253
```
 
Wir sehen, dass ähnliche Ergebnisse - jedoch nicht exakt gleiche ausgegeben werden. Das liegt daran, dass die angegebene Formel eben nur approximativ gültig ist. Sie lässt einen Teil der eigentlichen Berechnung weg, da sich dieseer bei einer großen Anzahl an Beobachtungen der 0 annähert. Die komplette Formel wäre die folgende:

<math>
$$PI = \hat{y} \pm t_{(1-\alpha/2, n-k-1)} \cdot \hat{\sigma}_{e} \cdot \sqrt{1 + x_i'(X'X)x_i}$$
</math>

In dieser Formel sind die Werte $x_i$ die Werte, für die wir das Prognoseintervall bestimmen wollen. $X$ ist die Matrix der ursprünglichen Werte von den Personen auf den Prädiktoren in dem. Damit wir auf dasselbe Ergebnis kommen, dürfen wir nicht vergessen, den Einsenvektor für den Achsenabschnitt hinzuzufügen. Damit wir Multiplikation mit `R` durchführen können, müssen wir Objekte in Matrizen umwandeln.


``` r
# Eine 1 für den Achsenabschnitt und die Werte auf den Prädiktoren für die neue Person
x_i <- cbind(1, predict_data) |> as.matrix()
# Ein 1en Vektor und die Werte auf den Prädiktoren für die Personen im ursprünglichen Datensatz
X <- cbind(1, as.matrix(burnout[, c("Exhaust", "Distan", "PartConfl")])) |> as.matrix()
```

Die Formel geht davon aus, dass `x_i` als Spaltenvektor vorliegt. Hier ist es jedoch ein Zeilenvektor. Daher müssen wir die Transponierung anhand der Funktion `t()` genau andersrum als in der Formel machen. Die Inverse von `X` können wir wie gewohnt mit `solve()` aufrufen.


``` r
y_hat + t * sigma_e * sqrt(1 + x_i %*% solve(t(X) %*% X) %*% t(x_i))
```

```
##          [,1]
## [1,] 30.49253
```

``` r
y_hat - t * sigma_e * sqrt(1 + x_i %*% solve(t(X) %*% X) %*% t(x_i))
```

```
##          [,1]
## [1,] 5.349854
```

Nun finden wir auch per Hand (glücklicherweise) dieselben Ergebnisse wie in der Durchführung anhand der Funktion `predict()`.

</details>

## Appendix B 

<details><summary><b>Bestimmen von AIC und Vergleich zwischen <code>AIC()</code> und <code>extractAIC()</code></b></summary>

Wie bereits oben besprochen, benötigen wir für die Berechnung des AIC die Loglikelihood (Logarithmus der Likelihood) der Daten. Diese erhalten wir ganz einfach mit der `logLik` Funktion. 


``` r
logLik(mod_all)
```

```
## 'log Lik.' -4903.467 (df=8)
```

`df` ist die Anzahl der Freiheitsgrade in der Likelihood: hier wird zu den $\beta$-Koeffizienten noch die Residualvarianz $\sigma$ hinzugezählt.

Sie ergibt sich aus der Verteilungsannahme an unserem Modell. Diese werden wir in der nächsten Sitzung auch noch genauer prüfen. Jedoch wissen wir aus den inhaltlichen Sitzungen, dass das Residuum der Regression oft als normalverteilt angenommen wird. Das Residuum ist ja aber gerade $\varepsilon_i = Y_i - (\beta_0 + \beta_1X_1 + \dots + \beta_mX_m)$. Außerdem nehmen wir an, dass für alle (Personen) $i$ die Varianz der Residuen gleich groß ist (Varianzhomogenität), nämlich $\sigma^2$ und deren Erwartung 0 ist, also $\mathbb{E}[\varepsilon_i]=0$.  Die Wahrscheinlichkeitsverteilung des normalverteilten Residuums $\varepsilon_i$ ist also über die Normalverteilung definiert. Einsetzen in die Verteilung ergibt

$$\frac{1}{\sqrt{2\pi\sigma^2}}e^{-\frac{(Y_i - (\beta_0 + \beta_1X_1 + \dots + \beta_mX_m))^2}{2\sigma^2}} = \frac{1}{\sqrt{2\pi\sigma^2}}e^{-\frac{\varepsilon_i^2}{2\sigma^2}}.$$

Sie sehen als Unbekannte in dieser Darstellung gibt es nur die Parameter $\beta_0, \beta_1, \dots,\beta_m,\sigma^2$. Diese gilt es zu finden. Dies geschieht meist über die Loglikelihood. Logarithmieren wir also:

$$-\frac{1}{2}\log(2\pi) -\frac{1}{2}\log(\sigma^2) - \frac{\varepsilon_i^2}{2\sigma^2}$$

Haben wir nun ganz viele Beobachtungen, müssen diese bzgl. der Likelihood multipliziert werden (unabhängige Ereignisse werden multipliziert - das folgt dem gleichen Konzept, wie als wenn wir zweimal einen Würfel würfeln, dann müssen  die Wahrscheinlichkeiten bspw. die 6 zu würfeln, multipliziert werden). Wenn wir dann logarithmieren, entsteht eine Summe, mit der relativ leicht umgegangen werden kann (deswegen wird auch zumeist die Loglikelihood genutzt, da diese genau dann wenn die Likelihood maximal ist, auch maximal ist, allerdings leichter zu "handlen" ist):

$$\tiny \sum_{i=1}^n-\frac{1}{2}\log(2\pi) -\frac{1}{2}\log(\sigma^2) - \frac{\varepsilon_i^2}{2\sigma^2} = \frac{n}{2}\log(2\pi) -\frac{n}{2}\log(\sigma^2) - \frac{1}{2\sigma^2} \sum_{i=1}^n \varepsilon_i^2$$

den letzten Ausdruck kennen wir aber! Das ist die Fehlerquadratsumme! Es gilt $\sum_{i=1}^n \varepsilon_i^2 = n\sigma^2$. Wir können also $\frac{1}{2\sigma^2}\sum_{i=1}^n \varepsilon_i^2$ kürzen: $\frac{1}{2\sigma^2}\sum_{i=1}^n \varepsilon_i^2 = \frac{1}{2\sigma^2}n\sigma^2 = \frac{n}{2}$ ($\sigma^2$ fliegt raus). Also ist die Loglikelihood unserer Daten:

$$-\frac{n}{2}\log(2\pi) -\frac{n}{2}\log(\sigma^2) - \frac{n}{2}$$

An dieser Stelle muss noch einmal erwähnt werden, dass in der Likelihoodschreibweise die Schätzer der Fehlervarianz etwas anders ausfallen, da die Parameter alle simultan geschätzt werden können und nicht von den $\beta$-Gewichten abhängen. Deshalb müssen wir die Fehlervarianz anders bestimmen (die Logik ist ein wenig so, wie wenn man die Populationsschätzer und die Stichprobenschätzer der Varianz vergleicht).


``` r
LL <- logLik(mod_all) # Loglikelihood des Modells
p <- length(coef(mod_all))+1 # betas + sigma
n <- nrow(burnout) # Stichprobengröße (nur so möglich, wenn keine Missings!)
sigma <-summary(mod_all)$sigma * sqrt((n-3)/n) # Korrektur um die Freiheitsgrade df_e = n - (Anzahl beta-Gewichte)
LL
```

```
## 'log Lik.' -4903.467 (df=8)
```

``` r
-n/2*log(2*pi) - n*log(sigma) - n/2
```

```
## [1] -4905.473
```

So, jetzt haben wir die Loglikelihood bestimmt, jetzt fehlt nur noch der AIC:


``` r
myAIC <- -2*LL[1] + 2*p
myAIC
```

```
## [1] 9822.933
```

``` r
AIC(mod_all)
```

```
## [1] 9822.933
```

Super! Die beiden sind schon mal identisch.

Wie erhalten wir nun den Unterschied zu `extractAIC`? Wir hatten gesagt, dass in `extractAIC` alle "Konstanten" herausgelassen werden, also jene Informationen, die nicht vom Modell beeinflusst werden, solange es auf die gleichen Daten angewandt wird. Die Formel für die Loglikelihood sah so aus: $-\frac{n}{2}\log(2\pi) -\frac{n}{2}\log(\sigma^2) - \frac{n}{2}$. Hier hängt nur der Term $-\frac{n}{2}\log(\sigma^2)$ vom Modell ab, da nur die Residualvarianz $\sigma^2$ von der Inklusion der Prädiktoren abhängt. Somit haben wir also unsere fehlenden Terme gefunden! Da die Loglikelihood in der Bestimmung des AICs mit -2 multipliziert wird, müssen wir also die "Konstanten" nur noch damit multiplizieren und auf `extractAIC` draufaddieren. Außerdem müssen wir die Anzahl der Parameter um die Residualvarianz vergrößern, also müssen wir zusätlich 2*1 addieren:


``` r
extractAIC(mod_all)[2] + n + n*log(2*pi) + 2
```

```
## [1] 9822.933
```

``` r
myAIC
```

```
## [1] 9822.933
```

``` r
AIC(mod_all)
```

```
## [1] 9822.933
```

Nun sind alle AICs gleich! Warum ist das aber kein Problem? Vergleichen wir doch mal 2 Modelle:


``` r
model1 <- lm(Violence ~ Neglect + Ineffic, data = burnout)
model2 <- lm(Violence ~ Neglect , data = burnout)

AIC(model1) - AIC(model2)
```

```
## [1] -60.8287
```

``` r
extractAIC(model1) - extractAIC(model2)
```

```
## [1]   1.0000 -60.8287
```

Der Unterschied in den bestimmten AICs ist identisch. Somit sehen wir, dass die Unterschiede in den absoluten Werten keinen Einfluss auf die Auswahl der Modelle nimmt. Was für ein Aufwand. Wir hoffen, dass die Herleitung beim Verstehen des Sachverhalts hilft.

</details>

***

