---
title: Multiple Regression
date: '2024-09-26'
slug: multiple-regression-klinische
categories: ["KliPPs"]
tags: ["Regression", "Voraussetzungen", "Grundlagen"]
subtitle: 'Grundlagen, Annahmen und ein paar Erweiterungen'
summary: ''
authors: [schultze, nehler, irmer]
weight: 1
lastmod: '2024-10-10'
featured: no
banner:
  image: "/header/whip.jpg"
  caption: "[Courtesy of pexels](https://www.pexels.com/photo/whip-on-red-background-5187496/)"
projects: []

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/klipps/multiple-regression-klinische
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/klipps/multiple-regression-klinische.R
  - icon_pack: fas
    icon: newspaper
    name: Artikel
    url: https://doi.org/10.1177/10790632231205799
    
output:
  html_document:
    keep_md: true
---



## Einleitung

Im ersten Beitrag zur Methodenlehre im Master "Klinische Psychologie und Psychotherapie" (ab sofort einfach immer auf KliPPs abgekürzt) geht es darum, an einem konkreten Beispiel aus der aktuellen klinischen Forschung noch einmal die Grundideen der multiplen Regression zu wiederholen und für den Fall einer moderierten Regression zu nutzen. Beides in einem Beitrag kann etwas kurz geraten, deswegen möchte ich an dieser Stelle noch auf die etwas umfangreicheren Einzelbeiträge aus dem Bachelorstudiengang zur [multiplen Regression](/lehre/statistik-i/multiple-reg), der [Prüfung der Voraussetzungen in der multiplen Regression](/lehre/statistik-ii/regressionsdiagnostik), zur [Inferenz und Modellauswahl](/lehre/statistik-ii/multreg-inf-mod) und zur [moderierten Regression](/lehre/statistik-ii/moderierte-reg) verweisen. Wie Sie sehen: das sind einige Beiträge, also können wir hier wirklich nur einen Versuch der Auffrischung unternehmen und uns angucken, wie eine Anwendung dieser Methoden in der Praxis aussieht.

### Neigung zur sexuellen Nötigung

Eine solche Praxis finden wir im Artikel von [Thatcher, Wallace & Fido (2023)](https://doi.org/10.1177/10790632231205799). In dieser Studie geht es darum, die Neigung zur sexuellen Nötigung (sexual coercion proclivity, SCP) mit psychopathischen Persönlichkeitseigenschaften in Verbindung zu bringen und dabei insbesondere zu untersuchen, inwiefern diese den Einfluss atypischer Sexualpräferenzen (z.B. Sadismus und Masochismus) moderiert. Alle Daten stammen dabei aus einer Online-Erhebung aus der Britischen Allgemeinbevölkerung. Betrachten wir diese Daten ein wenig genauer.

Die Autor*innen der Studie haben sowohl die Rohdaten, als auch einige SPSS-Outputs und die genutzten Fragebögen in einem Repository im [OSF zur Verfügung](https://osf.io/xkcah/) gestellt. Darüber hinaus: falls Sie keinen Zugriff auf den veröffentlichten Artikel haben sollten, finden Sie auf [PsyArXiv den Preprint der Studie](https://psyarxiv.com/a83pg/). Weil der Originaldatensatz nur SPSS-Format vorliegt und insgesamt 212 Variablen umfasst, habe ich die Datenaufbereitung schon einmal erledigt und Sie können die reduzierte Fassung in R einlesen, indem Sie folgendes Skript ausführen:


``` r
source('https://pandar.netlify.app/daten/Data_Processing_coercion.R')
```



Die abhängige Variable, die in der Studie im Zentrum steht ist `coerce`, ein Skalenwert aus der "Tactics to Obtain Sex Scale" (Camilleri et al., 2009), welcher abfragt, wie wahrscheinlich es ist, dass man bestimmte Verhaltensweisen an den Tag legen würde, wenn die Person von Interesse deutlich gemacht hat, dass sie heute keinen Sex möchte. Dazu gehören Aussagen wie z.B. "Try to make them feel bad about not having sex" oder "Provide them with alcohol". Mehr Details zu den restlichen Variablen finden Sie in der...

<details><summary><b>Variablenübersicht</b></summary>
Variable | Beschreibung | Ausprägungen
--- | ------ | ----- 
`age` | Alter | in Jahren
`sex` | Geschlecht | `Male`, `Female`
`f1` | Faktor 1 der Psychopathie | _Skalenwert_, 14-70
`f2` | Faktor 2 der Psychopathie | _Skalenwert_, 15-75
`maso` | Masochismus | _Skalenwert_, 0-64
`sadi` | Sadismus | _Skalenwert_, 0-64
`drive` | Sexueller Antrieb | _Skalenwert_, 4-24
`coerce` | Neigung zur sexuellen Nötigung | _Skalenwert_, 19-95
`coax` | Neigung zur sexuellen Überredung | _Skalenwert_, 12-60
</details>

### Deskriptivstatistik

Bevor wir uns mit der moderierten Regression befassen, sollten wir zunächst sicherstellen, dass die Daten, die uns vorliegen, die gleichen sind, die auch tatsächlich im Artikel von [Thatcher et al. (2023)](https://doi.org/10.1177/10790632231205799) genutzt wurden. Zum Glück, werden im Artikel auf S. 10, Tabelle 1, einige Deskriptivstatistiken berichtet, die wir mit unseren Daten vergleichen können. Auch wenn uns in diesem Fall eigentlich nur Mittelwerte und Standardabweichungen interessieren, empfehle ich eine etwas vollständigere Deskriptivstatistik aus dem `psych`-Paket anzufordern. Zunächst können wir die Daten aber auf die relevanten Variablen einschränken, damit der Abgleich etwas leichter fällt:


``` r
# Paket für Deskriptivstatistik laden
library(psych)

# Deskriptives aus der Gesamtstichprobe
subset(coercion, select = c('drive', 'sadi', 'maso', 'f1', 'coerce')) |>
  describe()
```

```
##        vars   n  mean   sd median trimmed  mad min max range  skew kurtosis
## drive     1 405 15.51 4.04     16   15.64 2.97   4  26    22 -0.33    -0.10
## sadi      2 405  5.35 7.86      3    3.62 4.45   0  56    56  2.73     9.28
## maso      3 405  7.41 9.31      4    5.54 4.45   0  61    61  2.12     5.35
## f1        4 405 26.49 8.26     26   25.97 8.90  14  53    39  0.48    -0.35
## coerce    5 405 23.87 6.53     22   22.58 4.45  19  68    49  2.84    11.55
##          se
## drive  0.20
## sadi   0.39
## maso   0.46
## f1     0.41
## coerce 0.32
```
Mittelwerte und Standardabweichungen stimmen beruhigenderweise schon einmal mit dem überein, was in Tabelle 1 für die Gesamtstichprobe berichtet wird. Das Vorgehen mit `psych` hat den Vorteil, dass wir auch extrem leicht Deskriptivstatistik für einzelne Gruppen erstellen können:


``` r
# Deskriptives getrennt nach Geschlecht
subset(coercion, select = c('drive', 'sadi', 'maso', 'f1', 'coerce')) |>
  describeBy(coercion$sex)
```

```
## 
##  Descriptive statistics by group 
## group: Male
##        vars   n  mean   sd median trimmed  mad min max range  skew kurtosis
## drive     1 173 17.45 3.34     18   17.53 2.97   5  26    21 -0.32     0.44
## sadi      2 173  7.16 9.60      4    5.06 5.93   0  56    56  2.31     6.03
## maso      3 173  5.62 8.32      3    3.75 4.45   0  51    51  2.71     8.59
## f1        4 173 29.72 8.25     29   29.49 8.90  14  53    39  0.25    -0.47
## coerce    5 173 24.41 6.92     23   23.08 4.45  19  63    44  2.79    10.22
##          se
## drive  0.25
## sadi   0.73
## maso   0.63
## f1     0.63
## coerce 0.53
## --------------------------------------------------------- 
## group: Female
##        vars   n  mean   sd median trimmed  mad min max range  skew kurtosis
## drive     1 232 14.06 3.92     14   14.16 4.45   4  24    20 -0.22    -0.32
## sadi      2 232  4.00 5.93      2    2.68 2.97   0  41    41  2.67     9.01
## maso      3 232  8.75 9.80      5    7.04 5.93   0  61    61  1.83     4.10
## f1        4 232 24.08 7.42     23   23.47 8.90  14  48    34  0.64    -0.12
## coerce    5 232 23.46 6.21     21   22.22 2.97  19  68    49  2.84    12.54
##          se
## drive  0.26
## sadi   0.39
## maso   0.64
## f1     0.49
## coerce 0.41
```
Um mit der statistischen Auswertung wieder etwas in die Gänge zu kommen, können wir auch den $t$-Test für die einzelnen Skalenwerte nachbauen. Hier mal exemplarisch für das Outcome `coerce`:


``` r
# t-Test für coerce
t.test(coercion$coerce ~ coercion$sex, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  coercion$coerce by coercion$sex
## t = 1.4483, df = 403, p-value = 0.1483
## alternative hypothesis: true difference in means between group Male and group Female is not equal to 0
## 95 percent confidence interval:
##  -0.3392421  2.2376375
## sample estimates:
##   mean in group Male mean in group Female 
##             24.41040             23.46121
```

``` r
# Cohen's d
cohen.d(coercion$coerce, coercion$sex)$cohen.d
```

```
##          lower     effect      upper
## [1,] -0.342892 -0.1458419 0.05138898
```

Auch hier soweit alles das, was im Artikel steht. Die weiteren Analysen aus dem Artikel sind nach Geschlechtern getrennt durchgeführt und berichtet, weswegen wir zur Vorbereitung noch zwei Teildatensätze erstellen sollten:


``` r
# Teildatensätze
males <- subset(coercion, sex == 'Male')
females <- subset(coercion, sex == 'Female') 
```


## Wiederholung: Regression

Das Ziel einer Regression besteht darin, die Unterschiede zwischen Personen in einer Variable durch ihre Unterschiede in einer oder mehreren andere Variablen vorherzusagen (Prognose und Erklärung). Die vorhergesagte Variable wird als Kriterium, Regressand oder auch abhängige Variable (AV) bezeichnet und üblicherweise mit $y$ symbolisiert. Die Variablen zur Vorhersage der abhängigen Variablen werden als Prädiktoren, Regressoren oder unabhängige Variablen (UV) bezeichnet und üblicherweise mit $x$ symbolisiert.
Die häufigste Form der Regressionsanalyse ist die lineare Regression, bei der der Zusammenhang über eine Gerade bzw. eine (Hyper-)Ebene beschrieben wird. Demzufolge kann die lineare Beziehung zwischen den vorhergesagten Werten und den Werten der unabhängigen Variablen mathematisch folgendermaßen beschrieben werden:

$$y_i = b_0 +b_{1}x_{i1} + ... +b_{m}x_{im} + e_i$$

* Ordinatenabschnitt/ $y$-Achsenabschnitt/ Konstante/ Interzept $b_0$:
    + Schnittpunkt der Regressionsgeraden mit der $y$-Achse
    + Erwartung von y, wenn alle UVs den Wert 0 annehmen
* Regressionsgewichte $b_{1},\dots, b_m$:
    + beziffern die Steigung der Regressionsgeraden
    + Interpretation: die Steigung der Geraden lässt erkennen, um wie viele Einheiten $y$ zunimmt, wenn (das jeweilige) x um eine Einheit zunimmt  (unter Kontrolle aller weiteren Variablen im Modell)
* Regressionsresiduum (kurz: Residuum), Residualwert oder Fehlerwert $e_i$:
    + die Differenz zwischen einem beobachteten und einem vorhergesagten y-Wert ($e_i=y_i-\hat{y}_i$)
    + je größer die Fehlerwerte (betraglich), umso größer ist die Abweichung (betraglich) eines beobachteten vom vorhergesagten Wert

Gucken wir uns das Ganze mal an den Daten aus der Studie an. Dort werden als erstes die Ergebnisse des Modells berichtet, in dem sexueller Antrieb (`drive`) und Faktor 1 der Psychopathie (`f1`) - welcher vor allem Defizite in der Empathie und manipulatives Verhalten abbildet - als Prädiktoren für die Neigung zur sexuellen Nötigung betrachtet werden. In der R können wir diese multiple Regression mit der Funktion `lm()` durchführen:


``` r
# Multiple Regression
mod0m <- lm(coerce ~ drive + f1, data = males)
mod0f <- lm(coerce ~ drive + f1, data = females)

# Ergebnisse für männliche Probanden
summary(mod0m)
```

```
## 
## Call:
## lm(formula = coerce ~ drive + f1, data = males)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -9.945 -3.629 -1.633  1.663 35.857 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 12.39577    3.05709   4.055 7.63e-05 ***
## drive        0.25818    0.15054   1.715   0.0882 .  
## f1           0.25264    0.06095   4.145 5.35e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.551 on 170 degrees of freedom
## Multiple R-squared:  0.1147,	Adjusted R-squared:  0.1043 
## F-statistic: 11.02 on 2 and 170 DF,  p-value: 3.175e-05
```


***

## Literatur

Camilleri, J. A., Quinsey, V. L., & Tapscott, J. L. (2009). Assessing the propensity for sexual coaxing and coercion in relationships: Factor structure, reliability, and validity of the Tactics to Obtain Sex Scale. Archives of Sexual Behavior, 38(6), 959–973. https://doi.org/10.1007/s10508-008-9377-2

[Thatcher, A. S., Wallace, L., & Fido, D. (2023)](https://doi.org/10.1177/10790632231205799). Psychopathic Personality as a Moderator of the Relationship Between Atypical Sexuality and Sexual Coercion Proclivity in the General Population. _Sexual Abuse, 0_(0). https://doi.org/10.1177/10790632231205799

