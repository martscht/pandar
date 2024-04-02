---
title: "Einfache Lineare Regression - Lösungen" 
type: post
date: '2021-01-04' 
slug: einfache-reg-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [winkler, neubauer, walter] 
weight: 
lastmod: '2024-04-02'
featured: no
banner:
  image: "/header/modern_buildings.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/411588)"
projects: []
expiryDate: 
publishDate: 
_build:
  list: never
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/einfache-reg
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/einfache-reg-aufgaben


output:
  html_document:
    keep_md: true
---



## Vorbereitung

Laden Sie zunächst den Datensatz `fb23` von der pandar-Website und führen Sie die Ergänzungen vor, die in zurückliegenden Tutorials vorgenommen wurden. 


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
fb23$fach_klin <- factor(as.numeric(fb23$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))
fb23$ort <- factor(fb23$ort, levels=c(1,2), labels=c("FFM", "anderer"))
fb23$job <- factor(fb23$job, levels=c(1,2), labels=c("nein", "ja"))
fb23$unipartys <- factor(fb23$uni3,
                             levels = 0:1,
                             labels = c("nein", "ja"))

# Rekodierung invertierter Items
fb23$mdbf4_pre_r <- -1 * (fb23$mdbf4_pre - 4 - 1)
fb23$mdbf11_pre_r <- -1 * (fb23$mdbf11_pre - 4 - 1)
fb23$mdbf3_pre_r <-  -1 * (fb23$mdbf3_pre - 4 - 1)
fb23$mdbf9_pre_r <-  -1 * (fb23$mdbf9_pre - 4 - 1)
fb23$mdbf5_pre_r <- -1 * (fb23$mdbf5_pre - 4 - 1)
fb23$mdbf7_pre_r <- -1 * (fb23$mdbf7_pre - 4 - 1)

# Berechnung von Skalenwerten
fb23$wm_pre  <- fb23[, c('mdbf1_pre', 'mdbf5_pre_r', 
                        'mdbf7_pre_r', 'mdbf10_pre')] |> rowMeans()
fb23$gs_pre  <- fb23[, c('mdbf1_pre', 'mdbf4_pre_r', 
                        'mdbf8_pre', 'mdbf11_pre_r')] |> rowMeans()
fb23$ru_pre <-  fb23[, c("mdbf3_pre_r", "mdbf6_pre", 
                         "mdbf9_pre_r", "mdbf12_pre")] |> rowMeans()

# z-Standardisierung
fb23$ru_pre_zstd <- scale(fb23$ru_pre, center = TRUE, scale = TRUE)
```

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb23)
```

```
## [1] 179  53
```

```r
str(fb23)
```

```
## 'data.frame':	179 obs. of  53 variables:
##  $ mdbf1_pre   : int  4 2 4 NA 3 3 2 3 3 2 ...
##  $ mdbf2_pre   : int  2 2 3 3 3 2 3 2 2 1 ...
##  $ mdbf3_pre   : int  3 4 2 2 2 3 3 1 2 2 ...
##  $ mdbf4_pre   : int  2 2 1 2 1 1 3 2 3 3 ...
##  $ mdbf5_pre   : int  3 2 3 2 2 1 3 3 2 4 ...
##  $ mdbf6_pre   : int  2 1 2 2 2 2 2 3 2 2 ...
##  $ mdbf7_pre   : int  4 3 3 1 1 2 2 3 3 3 ...
##  $ mdbf8_pre   : int  3 2 3 2 3 3 2 3 3 2 ...
##  $ mdbf9_pre   : int  2 4 1 2 3 3 4 2 2 3 ...
##  $ mdbf10_pre  : int  3 2 3 3 2 4 2 2 2 2 ...
##  $ mdbf11_pre  : int  3 2 1 2 2 1 3 1 2 4 ...
##  $ mdbf12_pre  : int  1 1 2 3 2 2 2 3 3 2 ...
##  $ lz          : num  5.4 3.4 4.4 4.4 6.4 5.6 5.4 5 4.8 6 ...
##  $ extra       : num  3.5 3 4 3 4 4.5 3.5 3.5 2.5 3 ...
##  $ vertr       : num  1.5 3 3.5 4 4 4.5 4 4 3 3.5 ...
##  $ gewis       : num  4.5 4 5 3.5 3.5 4 4.5 2.5 3.5 4 ...
##  $ neuro       : num  5 5 2 4 3.5 4.5 3 2.5 4.5 4 ...
##  $ offen       : num  5 5 4.5 3.5 4 4 5 4.5 4 3 ...
##  $ prok        : num  1.8 3.1 1.5 1.6 2.7 3.3 2.2 3.4 2.4 3.1 ...
##  $ nerd        : num  4.17 3 2.33 2.83 3.83 ...
##  $ grund       : chr  "Berufsziel" "Interesse am Menschen" "Interesse und Berufsaussichten" "Wissenschaftliche Ergänzung zu meinen bisherigen Tätigkeiten (Arbeit in der psychiatrischen Akutpflege, Gestalt"| __truncated__ ...
##  $ fach        : Factor w/ 5 levels "Allgemeine","Biologische",..: 4 4 4 4 4 4 NA 4 4 NA ...
##  $ ziel        : Factor w/ 4 levels "Wirtschaft","Therapie",..: 2 2 2 2 2 2 NA 4 2 2 ...
##  $ wissen      : int  5 4 5 4 2 3 NA 4 3 3 ...
##  $ therap      : int  5 5 5 5 4 5 NA 3 5 5 ...
##  $ lerntyp     : num  3 3 1 3 3 1 NA 1 3 3 ...
##  $ hand        : int  2 2 2 2 2 2 NA 2 1 2 ...
##  $ job         : Factor w/ 2 levels "nein","ja": 1 1 1 1 2 2 NA 2 1 2 ...
##  $ ort         : Factor w/ 2 levels "FFM","anderer": 2 1 1 1 1 2 NA 1 1 2 ...
##  $ ort12       : int  2 1 2 2 2 1 NA 2 2 1 ...
##  $ wohnen      : Factor w/ 4 levels "WG","bei Eltern",..: 4 1 1 1 1 2 NA 3 3 2 ...
##  $ uni1        : num  0 1 0 1 0 0 0 0 0 0 ...
##  $ uni2        : num  1 1 1 1 1 1 0 1 1 1 ...
##  $ uni3        : num  0 1 0 0 1 0 0 1 1 0 ...
##  $ uni4        : num  0 1 0 1 0 0 0 0 0 0 ...
##  $ attent_pre  : int  6 6 6 6 6 6 NA 4 5 5 ...
##  $ gs_post     : num  3 2.75 4 2.5 3.75 NA 4 2.75 3.75 2.5 ...
##  $ wm_post     : num  2 1 3.75 2.75 3 NA 3.25 2 3.25 2 ...
##  $ ru_post     : num  2.25 1.5 3.75 3.5 3 NA 3.5 2.75 2.75 2.75 ...
##  $ attent_post : int  6 5 6 6 6 NA 6 4 5 3 ...
##  $ hand_factor : Factor w/ 2 levels "links","rechts": 2 2 2 2 2 2 NA 2 1 2 ...
##  $ fach_klin   : Factor w/ 2 levels "nicht klinisch",..: 2 2 2 2 2 2 NA 2 2 NA ...
##  $ unipartys   : Factor w/ 2 levels "nein","ja": 1 2 1 1 2 1 1 2 2 1 ...
##  $ mdbf4_pre_r : num  3 3 4 3 4 4 2 3 2 2 ...
##  $ mdbf11_pre_r: num  2 3 4 3 3 4 2 4 3 1 ...
##  $ mdbf3_pre_r : num  2 1 3 3 3 2 2 4 3 3 ...
##  $ mdbf9_pre_r : num  3 1 4 3 2 2 1 3 3 2 ...
##  $ mdbf5_pre_r : num  2 3 2 3 3 4 2 2 3 1 ...
##  $ mdbf7_pre_r : num  1 2 2 4 4 3 3 2 2 2 ...
##  $ wm_pre      : num  2.5 2.25 2.75 NA 3 3.5 2.25 2.25 2.5 1.75 ...
##  $ gs_pre      : num  3 2.5 3.75 NA 3.25 3.5 2 3.25 2.75 1.75 ...
##  $ ru_pre      : num  2 1 2.75 2.75 2.25 2 1.75 3.25 2.75 2.25 ...
##  $ ru_pre_zstd : num [1:179, 1] -0.9749 -2.3095 0.0261 0.0261 -0.6412 ...
##   ..- attr(*, "scaled:center")= num 2.73
##   ..- attr(*, "scaled:scale")= num 0.749
```

Der Datensatz besteht aus 179 Zeilen (Beobachtungen) und 53 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.

***
    
   
## Aufgabe 1
Welche der fünf Persönlichkeitsdimensionen Extraversion (`extra`), Verträglichkeit (`vertr`), Gewissenhaftigkeit (`gewis`), Neurotizsimus (`neuro`) und Offenheit für neue Erfahrungen (`offen`) zeigt den höchsten linearen Zusammenhang mit der Lebenszufriedenheit (`lz`)?

  * Erstellen Sie für jeden Zusammenhang je ein Streudiagramm.

<details><summary>Lösung</summary>

**`extra`:**

```r
plot(fb23$extra, fb23$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/einfache-reg-loesungen_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

**`vertr`:**

```r
plot(fb23$vertr, fb23$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/einfache-reg-loesungen_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

**`gewis`:**

```r
plot(fb23$gewis, fb23$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/einfache-reg-loesungen_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

**`neuro`:**

```r
plot(fb23$neuro, fb23$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/einfache-reg-loesungen_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

**`intel`:**

```r
plot(fb23$offen, fb23$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/einfache-reg-loesungen_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

</details>

  * Schätzen Sie für jeden Zusammenhang je ein Modell.

<details><summary>Lösung</summary>

**`extra`:**

```r
fme <- lm(lz ~ extra, fb23)
summary(fme)
```

```
## 
## Call:
## lm(formula = lz ~ extra, data = fb23)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.1828 -0.6196  0.1252  0.7620  2.2356 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.69084    0.27607  13.369  < 2e-16 ***
## extra        0.43679    0.08126   5.375 2.42e-07 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.9801 on 175 degrees of freedom
##   (2 observations deleted due to missingness)
## Multiple R-squared:  0.1417,	Adjusted R-squared:  0.1368 
## F-statistic: 28.89 on 1 and 175 DF,  p-value: 2.42e-07
```

**`vertr`:**

```r
fmv <- lm(lz ~ vertr, fb23)
summary(fmv)
```

```
## 
## Call:
## lm(formula = lz ~ vertr, data = fb23)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.5247 -0.6459  0.1612  0.7612  1.9895 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  4.32567    0.34356   12.59   <2e-16 ***
## vertr        0.22828    0.09633    2.37   0.0189 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.044 on 174 degrees of freedom
##   (3 observations deleted due to missingness)
## Multiple R-squared:  0.03126,	Adjusted R-squared:  0.0257 
## F-statistic: 5.616 on 1 and 174 DF,  p-value: 0.0189
```

**`gewis`:**

```r
fmg <- lm(lz ~ gewis, fb23)
summary(fmg)
```

```
## 
## Call:
## lm(formula = lz ~ gewis, data = fb23)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.6219 -0.5908  0.1937  0.7781  2.1625 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   4.4686     0.3755  11.900   <2e-16 ***
## gewis         0.1844     0.1038   1.777   0.0774 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.048 on 175 degrees of freedom
##   (2 observations deleted due to missingness)
## Multiple R-squared:  0.01772,	Adjusted R-squared:  0.0121 
## F-statistic: 3.156 on 1 and 175 DF,  p-value: 0.07737
```

**`neuro`:**

```r
fmn <- lm(lz ~ neuro, fb23)
summary(fmn)
```

```
## 
## Call:
## lm(formula = lz ~ neuro, data = fb23)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.2488 -0.6202  0.1227  0.7512  1.9512 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  6.07728    0.27289  22.270  < 2e-16 ***
## neuro       -0.28570    0.07824  -3.652 0.000344 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.02 on 175 degrees of freedom
##   (2 observations deleted due to missingness)
## Multiple R-squared:  0.0708,	Adjusted R-squared:  0.06549 
## F-statistic: 13.33 on 1 and 175 DF,  p-value: 0.000344
```

**`intel`:**

```r
fmo <- lm(lz ~ offen, fb23)
summary(fmo)
```

```
## 
## Call:
## lm(formula = lz ~ offen, data = fb23)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.7082 -0.5793  0.2207  0.7155  1.9392 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  5.29777    0.33066  16.022   <2e-16 ***
## offen       -0.04740    0.08602  -0.551    0.582    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.057 on 175 degrees of freedom
##   (2 observations deleted due to missingness)
## Multiple R-squared:  0.001732,	Adjusted R-squared:  -0.003972 
## F-statistic: 0.3036 on 1 and 175 DF,  p-value: 0.5823
```
Wenn wir die Koeffizienten der Modelle vergleichen, sehen wir, dass `extra` den stärksten linearen Zusammenhang mit `lz` aufweist (Hinweis: für den Vergleich der Modelle vergleichen wir den Determinationskoeffizienten der fünf Modelle = Multiple R-squared im R-Output! Dieser ist für das Modell mit dem Prädiktor Extraversion am höchsten)

</details>

  * Interpretieren Sie den standardisierten Koeffizienten des linearen Zusammenhangs zwischen Extraversion und Lebenszufriedenheit. Wie verändert sich `lz`, wenn sich `extra` um eine Standardabweichung erhöht?
 
<details><summary>Lösung</summary>

Für diese Aufgabe gibt es zwei Lösungsansätze.

1. Das Einbauen der scale()-Funktion in unser Regressionsmodell.

2. Das Verwenden der lm.beta()-Funktion aus dem gleichnamigen Paket.

Es gilt zu Beachten:
Wenn wir die Lösung zwischen den zwei Ansätzen vergleichen, ist der Wert des standardisierten Koeffizienten nicht exakt gleich.
Dies ist der Fall, weil bei der standardisierten Regression mithilfe der lm()- und scale()-Befehle, das Intercept noch mitgeschätzt wird und sich dadurch auch auf die Schätzung des Koeffizienten auswirkt. Dies sollte sich aber in der Regel erst in den hinteren Nachkommastellen auswirken, sodass es für die Interpretation der Größe des Koeffizienten für gewöhnlich keine relevante Rolle spielt.


Zu 1:

```r
sfme <- lm(scale(lz) ~ scale(extra), fb23)
sfme
```

```
## 
## Call:
## lm(formula = scale(lz) ~ scale(extra), data = fb23)
## 
## Coefficients:
##  (Intercept)  scale(extra)  
##    -0.002424      0.375167
```


Zu 2:

Für die Lösung der Aufgabe verwenden wir die lm.beta() Funktion. Diese stammt aus dem lm.beta-Paket, welches installiert und dann geladen werden muss.

```r
library(lm.beta)

sfme2 <- lm.beta(fme)
summary(sfme2)         # reg |> lm.beta() |> summary()
```

```
## 
## Call:
## lm(formula = lz ~ extra, data = fb23)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.1828 -0.6196  0.1252  0.7620  2.2356 
## 
## Coefficients:
##             Estimate Standardized Std. Error t value Pr(>|t|)    
## (Intercept)  3.69084           NA    0.27607  13.369  < 2e-16 ***
## extra        0.43679      0.37643    0.08126   5.375 2.42e-07 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.9801 on 175 degrees of freedom
##   (2 observations deleted due to missingness)
## Multiple R-squared:  0.1417,	Adjusted R-squared:  0.1368 
## F-statistic: 28.89 on 1 and 175 DF,  p-value: 2.42e-07
```

lm.beta()  ergänzt den Output der lm()-Funktion an der Stelle der Koeffizienten um die Spalte "Standardized". Dieser können wir den standardisierten Koeffizienten des linearen Zusammenhangs zwischen Extraversion und Lebenszufriedenheit entnehmen.

Wenn sich die Variable `extra` um eine Standardabweichung verändert, verändert sich das Kriterium `lz` um 0.38 Standardabweichungen.

</details>

## Aufgabe 2

Betrachten Sie nun den Zusammenhang von Neurotizismus (`neuro`) und Lebenszufriedenheit (`lz`) etwas genauer:

  * Erstellen Sie ein Streu-Punkt-Diagramm  mit Regressionsgerade für den linearen Zusammenhang zwischen Neurotizismus und Lebenszufriedenheit.

<details><summary>Lösung</summary>


```r
plot(fb23$neuro, fb23$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
abline(fmn, col = "red")
```

![](/lehre/statistik-i/einfache-reg-loesungen_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

</details>

  * Wie viel Prozent der Varianz werden durch das Modell erklärt?

<details><summary>Lösung</summary>


```r
summary(fmn)
```

```
## 
## Call:
## lm(formula = lz ~ neuro, data = fb23)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.2488 -0.6202  0.1227  0.7512  1.9512 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  6.07728    0.27289  22.270  < 2e-16 ***
## neuro       -0.28570    0.07824  -3.652 0.000344 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.02 on 175 degrees of freedom
##   (2 observations deleted due to missingness)
## Multiple R-squared:  0.0708,	Adjusted R-squared:  0.06549 
## F-statistic: 13.33 on 1 and 175 DF,  p-value: 0.000344
```

$\rightarrow$ Das Modell erklärt 7.08% der Varianz in Lebenszufriedenheit durch Neurotizismus.

</details>

  * Ein paar Studierende wurden nachträglich zum Studiengang Psychologie zugelassen und befinden sich daher nicht im Datensatz. Die neuen Studierenden wurden nachträglich befragt und weisen auf der Skala Neurotizismus folgende Werte auf: 1.25; 2.75; 3.5; 4.25; 3.75; 2.15. Machen Sie eine Vorhersage für die Lebenszufriedenheit für die neuen Studierenden.

<details><summary>Lösung</summary>


```r
new <- data.frame(neuro = c(1.25, 2.75, 3.5, 4.25, 3.75, 2.15))
predict(fmn, newdata = new)
```

```
##        1        2        3        4        5        6 
## 5.720154 5.291599 5.077322 4.863045 5.005896 5.463021
```

</details> 
