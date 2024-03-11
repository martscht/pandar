---
title: "Regressionsanalyse II" 
type: post
date: '2021-04-28' 
slug: regression-ii 
categories: ["Statistik II"] 
tags: ["Regression", "Zusammenhangsanalyse", "Erklärte Varianz", "Modelloptimierung"] 
subtitle: 'Modelloptimierung'
summary: ''
authors: [irmer, hartig, schueller, nehler]
weight: 5
lastmod: '2024-03-08'
featured: no
banner:
  image: "/header/gardening_tools.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/598938)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-ii/regression-ii
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-ii/regression-ii.R
output:
  html_document:
    keep_md: true
---



## Modelloptimierung

Bei der Regressionsanalyse hat die Modelloptimierung zum Ziel, ein Regresionsmodell zu verbessern - das heißt, möglichst viel Varianz der abhängigen Variable zu erklären. Dadurch wird die "Vorhersage" der abhängigen Variable genauer (die Streuung der Werte um die Regressionsgerade/-hyperebene ist kleiner).

**Modelloptimierung** bedeutet, ein Modell zu verbessern, durch: 

* Aufnehmen zusätzlicher, bedeutsamer Prädiktoren
* Ausschließen von Prädiktoren, die nicht zur Varianzaufklärung beitragen

**Ziel** ist ein *sparsames Modell*, in dem 

* jeder enthaltene Prädiktor einen Beitrag zur Varianzaufklärung des Kriteriums leistet und
* kein wichtiger (= vorhersagestarker) Prädiktor vergessen wurde.

In diesem Kontext sind zwei unterschiedliche Fragestellungen von Interesse:

1. Die theoriegeleitete Arbeit: Aus der Literatur werden Modelle abgeleitet, die von Interesse sind. Diese unterscheiden sich in der Anzahl der Prädiktoren und können mittels Modellvergleich gegeneinander getestet werden. Hier geht es also um die Testung von spezfisichen Hypothesen.
2. Die schrittweise, “explorative” Auswahl von Prädiktoren aus einer größeren Menge möglicher Prädiktoren: Explorativ bedeutet hier, dass wir keiner zuvor hergeleiteter Theorie folgen, sondern die Daten möglichst genau untersuchen wollen. Hier kann es dann zum sogenannten Overfitting kommen, also zu einer zu starken Anpassung unseres Modells an die Daten. In weiteren (unabhängigen / mit neuen Daten) Studien könnte dann das neu herausgearbeitete Modell konfirmatorisch (also von einer vor Analyse bestehenden Theorie abgeleitet/ theoriebestätigend) untersucht werden. 

### Übungs-Datensatz

Die Modelloptimierung wird am gleichen Datensatz demonstriert, der auch in der Sitzung zu [Regression I](/lehre/statistik-ii/regression-i) verwendet wurde. Eine Stichprobe von 100 Schüler:innen hat einen Lese- und einen Mathematiktest bearbeitet, und zusätzlich dazu einen allgemeinen Intelligenztest absolviert. Im Datensatz enthalten ist zudem das Geschlecht (Variable: `female`, 0 = m, 1 = w). Die abhängige Variable ist die Matheleistung, die durch die anderen Variablen im Datensatz vorhergesagt werden soll.

Den Datensatz laden Sie  wie folgt:

```r
# Datensatz laden
load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))
```

## Hypothesentestung / Theoriegeleitete Testung

Wie bereits beschrieben werden in der theoriegeleiteten Testung Modelle aus den Hypothesen abgeleitet und dann gegeneinander getestet. Dabei soll das Modell identifziert werden, dass die Varianz der abhängigen Variable besser erklären kann. Der Unterschied in der erklärten Varianz zwischen zwei Modellen wird je nach Fragestellung als Inkrement / Dekrement bezeichnet. Mit Inkrement und Dekrement meinen wir hier das Varianzinkrement/-dekrement, also das Hinzukommen oder die Abnahme der erklärten Varianz in unserem Modell. 

### Bestimmung eines Inkrements

Das Inkrement beschreibt den Zugewinn an erklärter Varianz, wenn wir einen zusätzlichen Prädiktor in das Modell mit aufnehmen. Für seine Bestimmung stellen wir dabei ein eingeschränktes Modell $M_c$ ($_c$ steht hier für "constrained", also eingeschränkt) mit weniger Prädiktoren und ein uneingeschränktes Modell $M_u$ ($_u$ steht hier für "unconstrained", also uneingeschränkt) mit zusätzlichen Prädiktoren auf. 

Orientieren wir uns an einem Beispiel: Nehmen wir an, dass in der Literatur ein Modell existiert, in dem `math` durch `reading` und das Geschlecht vorhergesagt wird. Wir haben uns jetzt aber mit dem Thema beschäftigt und aus der Literatur auch herleiten können, dass die Hinzunahme von Intelligenz (`IQ`) zu einem signifikanten Zuwachs an erklärter Varianz führen sollte. Nähern wir uns dem ganzen erstmal deskriptiv, indem wir das Inkrement der Intelligenz bestimmen. Dafür stellen wir im folgenden Code erstmal das eingeschränkte und uneingeschränkte Modell auf.


```r
m.c <- lm(math ~ reading + female, data = Schulleistungen)      # constrained
m.u <- lm(math ~ reading + female + IQ, data = Schulleistungen) # unconstrained
summary(m.c)
```

```
## 
## Call:
## lm(formula = math ~ reading + female, data = Schulleistungen)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -204.12  -64.84   -7.69   45.14  490.01 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 369.9663    51.1049   7.239 1.07e-10 ***
## reading       0.4431     0.1011   4.381 2.99e-05 ***
## female      -52.3994    21.4960  -2.438   0.0166 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 106.2 on 97 degrees of freedom
## Multiple R-squared:  0.1897,	Adjusted R-squared:  0.173 
## F-statistic: 11.36 on 2 and 97 DF,  p-value: 3.701e-05
```

```r
summary(m.u)
```

```
## 
## Call:
## lm(formula = math ~ reading + female + IQ, data = Schulleistungen)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -96.46 -50.69 -20.66  18.53 455.03 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  75.416510  55.602607   1.356    0.178    
## reading      -0.002986   0.098679  -0.030    0.976    
## female      -26.310648  17.318600  -1.519    0.132    
## IQ            5.112758   0.663512   7.706 1.19e-11 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 83.91 on 96 degrees of freedom
## Multiple R-squared:  0.4994,	Adjusted R-squared:  0.4837 
## F-statistic: 31.92 on 3 and 96 DF,  p-value: 2.121e-14
```

Wir interessieren uns insbesonders für die erklärte Varianz, schauen uns also den Determinationskoeffizienten genauer an.

**Ergebniszusammenfassung: $R^2$**

* Determinationskoeffizient ohne IQ ("constrained"): $R_c^2=0.19$
* Determinationskoeffizient mit IQ ("unconstrained"): $R_u^2=0.50$

Das Inkrement ist nun die Differenz der beiden Determinationskoeffizienten. Wir können diese natürlich per Hand bestimmen, aber besser ist die Nutzung dieses Codes:


```r
# Inkrement = Differenz in R2 aus restringiertem Modell 2 minus R2 aus unrestringiertem Modell 1
summary(m.u)$r.squared - summary(m.c)$r.squared
```

```
## [1] 0.3096366
```



Wir sehen also, dass das Modell mit IQ als weiteren Prädiktor mehr Varianz erklärt als das ohne IQ. Die Hinzunahme des IQ führt zu einem Zuwachs von 31% erklärter Varianz ($\Delta R^2 = R_u^2 - R_c^2 = 0.31$). Eine Signifikanzentscheidung können wir an dieser Stelle jedoch noch nicht treffen, denn der Zuwachs an erklärter Varianz ist immer $\ge0$. Die Hinzunahme von Prädiktoren erhöht den Anteil an erklärter Varianz also immer, aber wir haben in der Einführung bereits das Sparsamkeitsprinzip angesprochen. Ein Prädiktor sollte also nur aufgenommen werden, wenn sein Inkrement auch verschieden von 0 ist.

### Inferenzstatistische Testung eines Inkrements

Wir müssen das *Inkrement* also auf Signifikanz testen. Die inferenzstatistische Testung starten wir am besten, indem wir Hypothesen aufstellen. 

Für die statistische Hypothese nehmen wir erstmal an, dass $\Delta R^2$ den unterschied in der erklärten Varianz zwischen dem eingeschränkten und dem uneingeschränkten Modell beschreibt.

$$\Delta R^2 = R_u^2 - R_c^2$$
Daher können wir das Hypothesenpaar so formulieren, dass unter der $H_0$ die Differenz der nicht erklärten Varianz bei 0 liegt, während sie in der $H_1$ verschieden von 0 ist.
$$H0: \Delta R^2 = 0; H1: \Delta R^2 \neq 0$$

Der Modellvergleich kann mit der `anova`-Funktion vorgenommen werden. ANOVA steht hierbei für "**An**alysis **o**f **Va**riance", wir vergleichen ja nichts weiteres als Varianzen! Im Bezug auf Gruppenunterschiede hat die ANOVA eine besondere Bedeutung, weswegen wir ihr auch noch drei Blöcke widmen werden -- also in späteren Sitzungen mehr zu diesem Thema. Wir vergleichen die beiden Determinationskoeffizienten, indem wir der `anova`-Funktion einfach die beiden Modelle übergeben. Hierbei soll das eingeschränkte Modell stets links stehen, damit die Freiheitsgrade des Modellvergleichs positiv sind! Die Freiheitsgrade geben dann an, wie viele weiteren Parameter in unserem Modell zusätzlich geschätzt werden müssen.



```r
# Modellvergleich mit der anova-Funktion
anova(m.c, m.u)
```

```
## Analysis of Variance Table
## 
## Model 1: math ~ reading + female
## Model 2: math ~ reading + female + IQ
##   Res.Df     RSS Df Sum of Sq      F    Pr(>F)    
## 1     97 1094086                                  
## 2     96  675987  1    418099 59.376 1.186e-11 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Im Output sehen wir zunächst eine Übersicht über die beiden Modelle (auch mehr als 2 Modelle sind möglich, die Modelle müssen nur geschachtelt sein, also auseinander hervorgehen, damit sie sinnvoll miteinander verglichen werden können). Model 1 ist das Modell ohne IQ, während Model 2 das Modell mit IQ beschreibt. Die Zahlen 1 und 2 beschreiben dann die Zeilen der Modelle. `Res.Df` sind die Residualfreiheitsgrade (diese lassen sich bestimmen, indem von der Stichprobengröße $N$ die Anzahl der zu schätzenden Koeffizienten inklusive Interzept abgezogen werden). `RSS` ist die Residual Sum of Squares, also die Residualquadratsumme. `Df` sind die Freiheitsgrade (Degrees of Freedom). `Sum of Sq` ist die durch die hinzukommenden Prädiktoren erklärte Quadratsumme, welche sich einfach durch die Differenz der beiden `RSS` bestimmen lässt. `F` beschreibt den $F$-Wert, der die Änderung in den `Sum of Sq` an der zufälligen Streuung relativiert. `Pr(>F)` ist die Spalte mit den zu dem $F$-Werten gehörigen $p$-Werte, also die Spalte, die uns besonders interessiert!

Das Inkrement des IQs ist auf einem Alpha-Fehlerniveau von 0.05 signifikant von null verschieden ($p<.001$). Somit wird der Anteil erklärter Varianz statistisch bedeutsam vergrößert.

Zum Vergleich finden Sie hier die Berechnung des F-Tests zu Fuß zur Regression:

$$F = \frac{\frac{R^2_u-R_c^2}{df_{u}-df_c}}{\frac{1-R_u^2}{df_{e}}}.$$

Dabei bezeichnen: $R^2_u$ den Determinationskoeffizient des uneingeschränkten (unconstrained) Modells, $R^2_c$ den Determinationskoeffizient des eingeschränkten (constrained) Modells, $df_u$ die Anzahl an Freiheitsgraden des uneingeschränkten (unconstrained) Modells [entspricht Anzahl der $b/\beta$-Gewichte inklusive Interzept], $df_u$ die Anzahl an Freiheitsgraden des eingeschränkten (constrained) Modells [entspricht Anzahl der $b/\beta$-Gewichte inklusive Interzept] und $df_e$ die Residualfreiheitsgrade des uneingeschränkten Modells.

In `R`:


```r
R2.u <- summary(m.u)$r.squared
R2.c <- summary(m.c)$r.squared
df.diff <- summary(m.u)$df[1] - summary(m.c)$df[1] # Änderung in den df
df.e <- summary(m.u)$df[2] # Fehlerfreiheitsgrade des uneingeschränkten Modells
F.diff <- ((R2.u - R2.c) / df.diff) /
  ((1 - R2.u) / df.e)
p.diff <- 1-pf(F.diff, df.diff, df.e)
F.diff # F-Wert der Differenz in R^2
```

```
## [1] 59.37622
```

```r
p.diff # zugehöriger p-Wert  
```

```
## [1] 1.186384e-11
```

### Zusammenhang des Inkrements und der Semipartialkorrelation

Außerdem sei an dieser Stelle erwähnt, dass das Inkrement auch über die Semipartialkorrelation bestimmt werden kann. Das Varianzinkrement `R2.u - R2.c` des IQs über Leseleistung und Geschlecht hinaus ist ja nichts anderes als die quadrierte Semipartialkorrelation zwischen Matheleistung und IQ wobei Leseleistung und Geschlecht herauspartialisiert wurden. 


```r
R2.u - R2.c # Inkrement
```

```
## [1] 0.3096366
```

```r
library(ppcor)
sp <- spcor.test(x = Schulleistungen$math, y = Schulleistungen$IQ, z = Schulleistungen[, c("reading", "female")])
sp$estimate^2 # ebenfalls Inkrement!
```

```
## [1] 0.3096366
```

Wir stellen keinen Unterschied im Wert selbst fest. Beachtet aber, dass die inferenzstatistische Testung mit dem Modellvergleich nicht die Semipartialkorrelation nutzt. Für Interessierte: Vertiefende Infos zu dieser Situation werden wir im [Anhang](#Appendix) bereitstellen. Falls die Testung des Inkrements / Dekrements in einer Übung verlangt wird, nutzen Sie die $p$-Werte aus dem $F$-Test (`anova`).

### Testen eines Dekrements

Das Dekrement ist ebenfalls ein Unterschied im $R^2$ zwischen dem restringierten Modell $M_c$ und dem unrestringierten Modell $M_u$. Wir gehen hier nur nicht von einer Hinzunahme von einem oder mehreren Prädiktoren aus, sondern von einem Herausnehmen von einem oder mehreren Prädiktoren. Es ändert sich also lediglich die Logik, in welcher wir das Modell verändern. Die Testung eines Dekrements erfolgt analog zum Inkrement: das eingeschränkte Modell $M_c$ mit weniger Prädiktoren wird mit dem uneingeschränkten Modell $M_u$ mit mehr Prädiktoren verglichen. Es soll nun geprüft werden, ob das *Weglassen* des Geschlechts aus dem Modell zu einem signifikanten Rückgang der erklärten Varianz führt. Dazu müssen wir im Grunde eigentlich wieder das Inkrement testen... Wir wissen also bereits wie das geht:


```r
m.u <- lm(math ~ reading + female + IQ, data = Schulleistungen) # unconstrained
m.c <- lm(math ~ reading + IQ, data = Schulleistungen) # constrained

summary(m.u)$r.squared - summary(m.c)$r.squared
```

```
## [1] 0.01203586
```

```r
# Modellvergleich mit der anova-Funktion
anova(m.c, m.u)
```

```
## Analysis of Variance Table
## 
## Model 1: math ~ reading + IQ
## Model 2: math ~ reading + female + IQ
##   Res.Df    RSS Df Sum of Sq     F Pr(>F)
## 1     97 692239                          
## 2     96 675987  1     16252 2.308  0.132
```

Der Ausschluss des Geschlechts führt zu einer Verringerung von 1% erklärter Varianz ($\Delta R^2=0.012$). Dieser Unterschied ist *nicht* signifikant von 0 verschieden ($p=0.132$). Somit wird der Anteil erklärter Varianz nicht signifikant verringert!

## Explorative Modellauswahl

Inkremente und Dekremente können theoriegeleitet auf Signifikanz getestet werden. In manchen Untersuchungen gibt es für die Modelle aber noch keine Hypothesen und mögliche Prädiktoren sollen erstmal exploriert werden. Es gibt verschiedene Vorgehensweisen bei der explorativen Suche nach einem Modell. Es kann variierte werden, ob vorwärts, rückwärts oder in beide Richtungen gesucht wird. Weiterhin kann das Kriterium für den Einschluss und Ausschluss von Prädiktoren variiert werden. Wir betrachten im folgenden zwei Beispiele aus diesem weiten Raum an Möglichkeiten.

### Nutzung der Testung von Inkrementen und Dekrementen

Wie immer gibt es in `R` viele weitere Wege, zum selben Ziel zu kommen. Das Paket `olsrr` beinhaltet verschiedene Funktionen, die für die Regressionsanalyse nützlich sind, u.a. auch Funktionen, die die schrittweise Auswahl von Prädiktoren auf Basis verschiedener Kriterien und nach verschiedenen Methoden (vorwärts, rückwärts, etc.) ermöglichen. Finden Sie [hier](https://olsrr.rsquaredacademy.com/articles/variable_selection.html#best-subset-regression) mehr Informationen dazu. 


```r
# install.packages("olsrr")
library(olsrr)
```

Die Funktion `ols_step_both_p()` beinhaltet die Auswahl auf Basis der Signifikanz des Inkrements oder Dekrements und führt in jedem Schritt Tests für Einschluss und Ausschluss durch. Sie nutzt also die Technik, die wir gerade für den theorigeleiteten Modellvergleich auch genommen haben. Dieses Vorgehen sollte nicht als Default angesehen werden, da einige Probleme bestehen, auf die wir nach der Demonstration eingehen. Aufgrund der Prävalenz des Vorgehens haben wir uns dazu entschieden, es auch zu präsentieren.

Nun zu der Anwendung der `ols_step_both_p()`-Funktion: Der Input  ist ein Regressionsmodell, das mit der bekannten Funktion `lm` erstellt wurde. Über die zusätzlichen Argumente kann gesteuert werden, wie streng bei Aufnahme und Ausschluss getestet wird. Über das Argument `details` können Sie den gesamten Verlauf der schrittweisen Selektion (nicht nur das finale Ergebnis) anzeigen lassen. `pent` ist der p-Wert, der für das "entering" in das Modell zuständig ist. Also muss das Inkrement einen p-Wert von $p<.05$ haben, wenn wir `pent = .05` wählen.`prem` ist der p-Wert, der für das "removing" aus dem Modell zuständig ist. Also muss das Dekremnt einen p-Wert von $p>.10$ haben, wenn wir `pent = .10` wählen. `details = TRUE` fordert weitere Informationen an.


```r
# Modell mit allen Prädiktoren
m <- lm(math ~ reading + female + IQ, data = Schulleistungen)

# Anwendung der iterativen Modellbildung
ols_step_both_p(m, pent = .05, prem = .10, details = TRUE)
```

```
## Stepwise Selection Method   
## ---------------------------
## 
## Candidate Terms: 
## 
## 1. reading 
## 2. female 
## 3. IQ 
## 
## We are selecting variables based on p value...
## 
## 
## Stepwise Selection: Step 1 
## 
## + IQ 
## 
##                          Model Summary                           
## ----------------------------------------------------------------
## R                       0.698       RMSE                 84.105 
## R-Squared               0.487       Coef. Var            14.980 
## Adj. R-Squared          0.481       MSE                7073.620 
## Pred R-Squared          0.468       MAE                  52.958 
## ----------------------------------------------------------------
##  RMSE: Root Mean Square Error 
##  MSE: Mean Square Error 
##  MAE: Mean Absolute Error 
## 
##                                  ANOVA                                  
## -----------------------------------------------------------------------
##                    Sum of                                              
##                   Squares        DF    Mean Square      F         Sig. 
## -----------------------------------------------------------------------
## Regression     657075.570         1     657075.570    92.891    0.0000 
## Residual       693214.751        98       7073.620                     
## Total         1350290.321        99                                    
## -----------------------------------------------------------------------
## 
##                                    Parameter Estimates                                    
## -----------------------------------------------------------------------------------------
##       model      Beta    Std. Error    Std. Beta      t       Sig       lower      upper 
## -----------------------------------------------------------------------------------------
## (Intercept)    53.901        53.330                 1.011    0.315    -51.931    159.733 
##          IQ     5.172         0.537        0.698    9.638    0.000      4.107      6.237 
## -----------------------------------------------------------------------------------------
## 
## 
## 
## No more variables to be added/removed.
## 
## 
## Final Model Output 
## ------------------
## 
##                          Model Summary                           
## ----------------------------------------------------------------
## R                       0.698       RMSE                 84.105 
## R-Squared               0.487       Coef. Var            14.980 
## Adj. R-Squared          0.481       MSE                7073.620 
## Pred R-Squared          0.468       MAE                  52.958 
## ----------------------------------------------------------------
##  RMSE: Root Mean Square Error 
##  MSE: Mean Square Error 
##  MAE: Mean Absolute Error 
## 
##                                  ANOVA                                  
## -----------------------------------------------------------------------
##                    Sum of                                              
##                   Squares        DF    Mean Square      F         Sig. 
## -----------------------------------------------------------------------
## Regression     657075.570         1     657075.570    92.891    0.0000 
## Residual       693214.751        98       7073.620                     
## Total         1350290.321        99                                    
## -----------------------------------------------------------------------
## 
##                                    Parameter Estimates                                    
## -----------------------------------------------------------------------------------------
##       model      Beta    Std. Error    Std. Beta      t       Sig       lower      upper 
## -----------------------------------------------------------------------------------------
## (Intercept)    53.901        53.330                 1.011    0.315    -51.931    159.733 
##          IQ     5.172         0.537        0.698    9.638    0.000      4.107      6.237 
## -----------------------------------------------------------------------------------------
```

```
## 
##                               Stepwise Selection Summary                               
## --------------------------------------------------------------------------------------
##                      Added/                   Adj.                                        
## Step    Variable    Removed     R-Square    R-Square     C(p)        AIC        RMSE      
## --------------------------------------------------------------------------------------
##    1       IQ       addition       0.487       0.481    2.4470    1174.1802    84.1048    
## --------------------------------------------------------------------------------------
```

Der Output ist extrem detailliert, wobei allerdings nicht aufgeführt wird, wie die jeweiligen Inkremente oder Dekremente der anderen Variablen ausgefallen waren, die nicht selektiert wurden. Mit der `ols_step_both_p` wählen wir nur den IQ als Prädiktor aus! Uns wird nach jedem Step zunächst gesagt, welcher Prädiktor gewählt wurde und wie sich verschiedene Fit-Maße verhalten (bspw. AIC oder $R^2$). Für uns ist an dieser Stelle besonders das $R^2$ (`R-Squared`) von Relevanz. Die ANOVA im Output beschreibt einfach eine ANOVA der zu vergleichenden Modelle, wobei zunächst mit dem Null-Modell, welches nur das Interzept enthält, begonnen wird. 

Unter `Parameter Estimates` finden wir das finale geschätzte Modell. `Stepwise Selection Summary` zeigt uns das Vorgehen dieses Auswahlalgorithmus.

Wie bereits angekündigt, kann man die Nutzung der Testung von Inkrementen und Dekrementen im explorative Fall in Frage stellen. Durch das sehr häufige Testen, besonders bei einer großen Menge an möglichen Prädiktoren, kann das $\alpha$-Fehlerniveau nicht eingehalten werden kann. Eigentlich müsste dann nämlich bspw. Bonferroni korrigiert werden, was wiederum schwierig ist, wenn wir die Anzahl der Tests im Vorhinein kennen. Sie erkennen, das ganze Thema ist eine Wissenschaft für sich! Weiterhin ist es auch aus forschungstheoretischer Sicht fraglich, Inferenzstatistik an dieser Stelle zu benutzen, da diese mit Hypothesen einhergeht. Im explorativen Fall haben wir aber gerade keine Hypothesen. Wir empfehlen daher ein anderes Vorgehen bei der explorativen Suche, das wir im folgenden Abschnitt beschreiben.

### Nutzung von Informationskriterien

Eine weitere "theoriefreie" schrittweise Auswahl von Prädiktoren kann in `R` mit der `step()`-Funktion erfolgen. Diese macht, anders als unser zuvor demonstriertes Vorgehen, nicht von Inkrementen und deren inferenzstatistischer Absicherung Gebrauch, sondern standardmäßig vom sogenannten Informationskriterium AIC (*Akaike Information Criterion*). Dieses basiert auf der **Likelihood** eines geschätzten Modells $L(\hat{\theta})$ und der Anzahl der Modellparameter $p$:

$AIC=-2L(\hat{\theta}) + 2p$

Die Likelihood bezeichnet ein Maß für die Plausibilität/Wahrscheinlichkeit eines Modells, unter Berücksichtigung der gegebenen (empirisch erhobenen) Daten. Anders ausgedrückt: sie beantwortet die Frage, wie wahrscheinlich das Modell ist, wenn wir unsere gegeben Daten beobachtet haben. Um das beste Modell zu finden, kann man die Likelihood verschiedener Modelle vergleichen. Höhere Likelihoodwerte zeigen bessere Modelle an. Allerdings verbessert sich die Likelihood immer, wenn wir weitere Prädiktoren aufnehmen. Deshalb werden eben Informationskriterien wie der AIC verwendet, da er zusätzlich zur Likelihood auch noch die Komplexität des Modells berücksichtigt. Komplexere Modelle mit vielen Prädiktoren werden bestraft durch den Bestrafungsterm $2p$.

Für lineare Regressionsmodelle lässt sich der AIC wie folgt darstellen:

$AIC_{\sigma}=n \cdot log(\sigma_e^2) + 2p$

Der AIC ist hier eine Funktion der Stichprobengröße $n$, der Residualvarianz $\sigma_e^2$ und der Anzahl der Parameter (= Regressionskoeffizienten) $p=m+1$. Es wird ersichtlich, dass der AIC von der Varianz der abhängigen Variablen abhängt, da diese wiederum die Residualvarianz beeinflusst.

Der AIC ist ein sogenanntes inverses Maß, das bedeutet, dass Modelle mit einem kleineren AIC besser sind als Modelle mit einem größeren AIC. Man kann sich den AIC also als eine Art Distanzmaß vorstellen (Achtung, das ist nur eine Anschauung) zwischen Daten und Modell. Der AIC wird durch den Term $n \cdot log(\sigma_e^2)$ kleiner, wenn die Residualvarianz kleiner wird, also mehr Varianz erklärt wird. Durch den "Strafterm" $2p$ wird der AIC größer, wenn das Modell mehr Prädiktoren enthält. 
Es soll also ein Modell gefunden werden, das mit möglichst wenigen Prädiktoren möglichst viel Varianz erklärt (*Sparsamkeitsprinzip*).

Auch hier kann die Selektion "vorwärts", "rückwärts", oder in beide Richtungen erfolgen. Wir wollen eine Foward-Backward (also vor und rückwärts) Selektion durchführen und wählen daher `direction = "both"`. Eine reine Forward oder reine Backward Selektion können wir auch über `direction` einstellen. Lesen Sie dazu `?step`. Die Standardeinstellung der `step`-Funktion ist die, dass ein Modell mit allen möglichen Prädiktoren als Ausgangspunkt genommen wird. Es wird dann der Prädiktor ausgeschlossen, der die größte Reduktion des AIC erlaubt, dann der nächste, usw. In jedem Schritt wird auch wieder geprüft, ob Prädiktoren, die *nicht* im Modell sind, bei Aufnahme wieder zu einer Reduktion des AIC führen würden. Das Verfahren stoppt, wenn: 

1. nur noch Prädiktoren im Modell sind, deren Ausschluss zu einer Erhöhung des AIC führen würden und
2. nur Prädiktoren "übrig" sind, deren Einschluss den AIC nicht verbessern würde.

Einfaches Beispiel: Optimierung des Modells für Mathematikleistung, Start mit allen drei möglichen Prädiktoren:


```r
# Optimierung des Modells nach AIC
summary(step(m, direction = "both"))
```

```
## Start:  AIC=889.88
## math ~ reading + female + IQ
## 
##           Df Sum of Sq     RSS    AIC
## - reading  1         6  675993 887.88
## <none>                  675987 889.88
## - female   1     16252  692239 890.25
## - IQ       1    418099 1094086 936.03
## 
## Step:  AIC=887.88
## math ~ female + IQ
## 
##           Df Sum of Sq     RSS    AIC
## <none>                  675993 887.88
## - female   1     17222  693215 888.39
## + reading  1         6  675987 889.88
## - IQ       1    634538 1310531 952.08
```

```
## 
## Call:
## lm(formula = math ~ female + IQ, data = Schulleistungen)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -96.60 -50.72 -20.91  18.41 455.09 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  75.1532    54.6335   1.376    0.172    
## female      -26.4255    16.8102  -1.572    0.119    
## IQ            5.1010     0.5346   9.542 1.31e-15 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 83.48 on 97 degrees of freedom
## Multiple R-squared:  0.4994,	Adjusted R-squared:  0.489 
## F-statistic: 48.38 on 2 and 97 DF,  p-value: 2.67e-15
```

Der Output enthält folgende Inhalte:


```
## Start:  AIC=889.88
## math ~ reading + female + IQ
```

zeigt uns das Anfangsmodell und den zugehörigen AIC.


```
##           Df Sum of Sq     RSS    AIC
## - reading  1         6  675993 887.88
## <none>                  675987 889.88
## - female   1     16252  692239 890.25
## - IQ       1    418099 1094086 936.03
```

ist der Output des ersten Schrittes. `<none>` beschreibt unser Modell (ohne Veränderung). Jede Zeile steht für ein Modell, in welchem jeweils maximal ein Prädiktor aus dem Modell ausgeschlossen wird oder maximal ein Prädiktor in das Modell aufgenommen wird. Das "Minus" (`-`) am Anfang der Zeile zeigt an, dass hier ein Prädiktor ausgeschlossen wird. Eine "Plus" (`+`) zeigt an, dass der jeweilige Prädiktor hinzukam. Die `Df` zeigen wieder an, wie sich die Freiheitsgrade verändern. Würden wir eine Variable verwenden, die aus mehr als 2 Faktorstufen besteht, würden hier auch `Df` größer 1 stehen. `Sum of Sq` zeigt an, wie sich die Sum of Squares verändern. `RSS` ist wieder die Residual Sum of Squares, wie oben.


```
## Step:  AIC=887.88
## math ~ female + IQ
## 
##          Df Sum of Sq     RSS    AIC
## <none>                 675993 887.88
## - female  1     17222  693215 888.39
## - IQ      1    634538 1310531 952.08
```

Der nächste Step beginnt nun mit dem verbesserten AIC, der erlangt wurde, indem die Leseleistung aus dem Modell gestrichen wurde. Da nun alle weiteren Modifikationen zu einer Verschlechterung des Modells führen, sind wir nach einer Modifikation bereits am Ende angelangt. 

**Zusammenfassung:**

Es ist zu sehen dass es im Ausgangsmodell nur eine Möglichkeit gibt, das Modell zu verbessern, nämlich den Ausschluss von Lesekompetenz (`reading`) (AIC von 889.88 auf 887.88). Danach gibt es keine Möglichkeit zur Verbesserung mehr, beide verbleibenden Prädiktoren würden bei einem Ausschluss zu einer Verschlechterung des AIC führen (`female` auf 888.39 und `IQ` auf 952.08) und eine Wiederaufnahme von `reading` ist auch nicht sinnvoll, da wir dann das Modell wieder verschlechtern würden (zurück auf 889.88). Damit sind Geschlecht und IQ die Prädiktoren für das optimierte Modell. An der Ausgabe für das "finale"  Modell am Schluss ist zu sehen, dass der Effekt von Geschlecht im finalen Modell hier *nicht* signifikant ist. Auch oben haben wir gesehen, dass unter Betrachtung des Dekrements dieser Prädiktor wegfallen würde. Wir sehen also, dass eine Auswahl mittels des AICs nicht notwendigerweise nur signifikante Prädiktoren auswählt!

Sparsamkeit wird beim AIC im "Strafterm" $2p$ nicht so hoch gewichtet wie bei anderen Informationskriterien. In der Funktion `step` kann man über die Veränderung des Parameters `k` steuern, wie streng die Prädiktorauswahl vorgenommen wird. Wenn man hier $k = log(n)$ angibt, wird statt des AIC das sogenannte Bayes'sche Informationskriterium BIC (*Bayesian Information Criterion*) verwendet.

$BIC=-2L(\hat{\theta}) + log(n)\cdot p$

Vorsicht, in der Ausgabe der `step`-Funktion steht immer AIC, auch wenn dies nur mit der Standardeinstellung von $k=2$ tatsächlich dem AIC entspricht!


```r
# Optimierung mit BIC
summary(step(m, direction = "both", k=log(nrow(Schulleistungen))))
```

```
## Start:  AIC=900.3
## math ~ reading + female + IQ
## 
##           Df Sum of Sq     RSS    AIC
## - reading  1         6  675993 895.69
## - female   1     16252  692239 898.07
## <none>                  675987 900.30
## - IQ       1    418099 1094086 943.84
## 
## Step:  AIC=895.69
## math ~ female + IQ
## 
##           Df Sum of Sq     RSS    AIC
## - female   1     17222  693215 893.60
## <none>                  675993 895.69
## + reading  1         6  675987 900.30
## - IQ       1    634538 1310531 957.29
## 
## Step:  AIC=893.6
## math ~ IQ
## 
##           Df Sum of Sq     RSS    AIC
## <none>                  693215 893.60
## + female   1     17222  675993 895.69
## + reading  1       976  692239 898.07
## - IQ       1    657076 1350290 955.67
```

```
## 
## Call:
## lm(formula = math ~ IQ, data = Schulleistungen)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -84.14 -51.06 -18.69  24.02 468.71 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  53.9006    53.3302   1.011    0.315    
## IQ            5.1721     0.5366   9.638 7.39e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 84.1 on 98 degrees of freedom
## Multiple R-squared:  0.4866,	Adjusted R-squared:  0.4814 
## F-statistic: 92.89 on 1 and 98 DF,  p-value: 7.392e-16
```

Bei der Verwendung des stengeren Kriteriums wird auch Geschlecht aus dem Modell entfernt, es verbleibt nur der IQ im finalen Modell. Dies entspricht nun eher der Modellmodifikation inklusive finalem Modelltest, den wir beim ersten Modell durchgeführt haben.

An dieser Stelle sei nochmal erwähnt, dass nach der explorativen Suche von Prädiktoren eine konformative, also theoriegeleitete Studie folgen sollte, in der wir Hypothesen aufstellen und diese inferenzstatistisch prüfen. Durch das explorative Vorgehen haben wir das Modell gewonnen, das auf unseren vorliegenden Datensatz am besten passt - ein Übertrag auf die Population sollte dadurch aber noch nicht gemacht werden.

#### Ergänzung: Unterschiede im AIC

Wer den Output der beiden neu gelernten Funktionen etwas genauer betrachtet, bemerkt, dass der AIC, der in der `step()`-Funktion berichtet wird, nicht identisch mit demjenigen AIC ist, der in `ols_step_both_p()` angezeigt wird. Zu Recht kann man sich nun fragen, ob hier ein Fehler passiert. Die Antwort ist nein (und ja). Es werden tatsächlich unterschiedliche Berechnungen für den AIC herangezogen. In `step()` wird intern die `extractAIC()`-Funktion verwendet, während in `ols_step_both_p()` die `AIC`-Funktion verwendet wird:


```r
model <- lm(math ~ reading + female, data = Schulleistungen)
AIC(model)
```

```
## [1] 1221.814
```

```r
extractAIC(model) # erstes Argument ist die Anzahl der Parameter (p)
```

```
## [1]   3.000 936.026
```

Die `AIC()`-Funktion gibt den "vollständigen" AIC an, während `extractAIC()` eine korrigierte Version heranzieht, aus der sämtlichen irrelevanten Konstanten entfernt wurden. Da der AIC immer nur für Vergleiche auf dem selben Datensatz herangezogen werden sollte, können Konstanten in der Berechnung getrost ignoriert werden, da sie nicht vom betrachteten Modell abhängen. Dazu ein Gedankenexperiment: Für zwei Zahlen $a$ und $b$ (welche bspw. zwei AICs repräsentieren können) gilt: $a>b \Longrightarrow a + c > b + c$ für eine dritte Zahl $c$. Sie sehen also, dass Konstanten, die überall "draufaddiert" werden, den Modellvergleich nicht beeinflussen. 

Um jetzt den Unterschied genau zu erkennen, müssen wir zunächst die **Loglikelihood** (den Logarithmus der Likelihood) unseres Modells bestimmen. Dies geht über den Kurs an dieser Stelle hinaus. Wer sich allerdings für die Überführung des `extractAIC()` zum AIC sowie die Berechnung beider interessiert, kann gerne im [Appendix B](#AppendixB) vorbeischauen.



***

## Appendix A {#AppendixA}

<details><summary><b>Inferenzstatistik der Semipartialkorrelation und der Modellvergleich</b></summary>

Wir arbeiten weiterhin mit dem Datensatz `Schulleistungen` und gehen davon aus, dass wir bereits `reading` und `female` zur Vorhersage von `math` nutzen. nun soll zusätzlich noch `IQ` aufgenommen werden. Den Modelltest erlangen wir über das eingeschränkte und uneingeschränkte Modell mit der Funktion `anova()`.


```r
m.c <- lm(math ~ reading + female, data = Schulleistungen)      # constrained
m.u <- lm(math ~ reading + female + IQ, data = Schulleistungen) # unconstrained
anova(m.c, m.u)
```

```
## Analysis of Variance Table
## 
## Model 1: math ~ reading + female
## Model 2: math ~ reading + female + IQ
##   Res.Df     RSS Df Sum of Sq      F    Pr(>F)    
## 1     97 1094086                                  
## 2     96  675987  1    418099 59.376 1.186e-11 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Die Semipartialkorrelation wird auch wie im Tutorial mit `spcor.test()` berechnet. 


```r
sp <- spcor.test(x = Schulleistungen$math, y = Schulleistungen$IQ, z = Schulleistungen[, c("reading", "female")])
sp$estimate^2    # Quadrat der Semipartialkorrelation
```

```
## [1] 0.3096366
```

```r
sp$p             # p-Wert der Semipartialkorrelation
```

```
## [1] 2.695227e-09
```
Weiterhin sehen wir, dass das Inkrement und die quadrierte Semipartialkorrelation derselbe Wert sind. Die $p$-Werte hingegen unterscheiden sich. Dies kommt daher, dass der Modelltest eigentlich die Partialkorrelation testet. Einschlägige Literatur begründet das damit, dass für diese der Standardfehler weniger komplex zu bestimmt wäre. Weiterhin sind sich die Nullhypothesen auch ähnlich, wodurch in den allermeisten Fällen der Modelltest und die Prüfung der Semipartialkorrelation zur selben Signifikanzentscheidung führen.

</details>

## Appendix B {#AppendixB}

<details><summary><b>Bestimmen von AIC und Vergleich zwischen `AIC` und `extractAIC`</b></summary>

Wie bereits oben besprochen, benötigen wir für die Berechnung des AIC die Loglikelihood (Logarithmus der Likelihood) der Daten. Diese erhalten wir ganz einfach mit der `logLik` Funktion. 


```r
logLik(model)
```

```
## 'log Lik.' -606.9068 (df=4)
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


```r
LL <- logLik(model) # Loglikelihood des Modells
p <- length(coef(model))+1 # betas + sigma
n <- nrow(Schulleistungen) # Stichprobengröße (nur so möglich, wenn keine Missings!)
sigma <-summary(model)$sigma * sqrt((n-3)/n) # Korrektur um die Freiheitsgrade df_e = n - (Anzahl beta-Gewichte)
LL
```

```
## 'log Lik.' -606.9068 (df=4)
```

```r
-n/2*log(2*pi) - n*log(sigma) - n/2
```

```
## [1] -606.9068
```

So, jetzt haben wir die Loglikelihood bestimmt, jetzt fehlt nur noch der AIC:


```r
myAIC <- -2*LL[1] + 2*p
myAIC
```

```
## [1] 1221.814
```

```r
AIC(model)
```

```
## [1] 1221.814
```

Super! Die beiden sind schon mal identisch.

Wie erhalten wir nun den Unterschied zu `extractAIC`? Wir hatten gesagt, dass in `extractAIC` alle "Konstanten" herausgelassen werden, also jene Informationen, die nicht vom Modell beeinflusst werden, solange es auf die gleichen Daten angewandt wird. Die Formel für die Loglikelihood sah so aus: $-\frac{n}{2}\log(2\pi) -\frac{n}{2}\log(\sigma^2) - \frac{n}{2}$. Hier hängt nur der Term $-\frac{n}{2}\log(\sigma^2)$ vom Modell ab, da nur die Residualvarianz $\sigma^2$ von der Inklusion der Prädiktoren abhängt. Somit haben wir also unsere fehlenden Terme gefunden! Da die Loglikelihood in der Bestimmung des AICs mit -2 multipliziert wird, müssen wir also die "Konstanten" nur noch damit multiplizieren und auf `extractAIC` draufaddieren. Außerdem müssen wir die Anzahl der Parameter um die Residualvarianz vergrößern, also müssen wir zusätlich 2*1 addieren:


```r
extractAIC(model)[2] + n + n*log(2*pi) + 2
```

```
## [1] 1221.814
```

```r
myAIC
```

```
## [1] 1221.814
```

```r
AIC(model)
```

```
## [1] 1221.814
```

Nun sind alle AICs gleich! Warum ist das aber kein Problem? Vergleichen wir doch mal 2 Modelle:


```r
model1 <- lm(math ~ reading + female, data = Schulleistungen)
model2 <- lm(math ~ reading , data = Schulleistungen)

AIC(model1) - AIC(model2)
```

```
## [1] -3.94554
```

```r
extractAIC(model1) - extractAIC(model2)
```

```
## [1]  1.00000 -3.94554
```

Der Unterschied in den bestimmten AICs ist identisch. Somit sehen wir, dass die Unterschiede in den absoluten Werten keinen Einfluss auf die Auswahl der Modelle nimmt. Was für ein Aufwand. Wir hoffen, dass die Herleitung beim Verstehen des Sachverhalts hilft.

</details>

***

