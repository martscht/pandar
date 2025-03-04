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
lastmod: '2025-02-07'
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

Laden Sie zunächst den Datensatz `fb24` von der pandar-Website und führen Sie die Ergänzungen vor, die in zurückliegenden Tutorials vorgenommen wurden. 


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
fb24$fach_klin <- factor(as.numeric(fb24$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))
fb24$ort <- factor(fb24$ort, levels=c(1,2), labels=c("FFM", "anderer"))
fb24$job <- factor(fb24$job, levels=c(1,2), labels=c("nein", "ja"))
fb24$unipartys <- factor(fb24$uni3,
                             levels = 0:1,
                             labels = c("nein", "ja"))

# Rekodierung invertierter Items
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 4 - 1)
fb24$mdbf11_r <- -1 * (fb24$mdbf11 - 4 - 1)
fb24$mdbf3_r <-  -1 * (fb24$mdbf3 - 4 - 1)
fb24$mdbf9_r <-  -1 * (fb24$mdbf9 - 4 - 1)
fb24$mdbf5_r <- -1 * (fb24$mdbf5 - 4 - 1)
fb24$mdbf7_r <- -1 * (fb24$mdbf7 - 4 - 1)

# Berechnung von Skalenwerten
fb24$wm_pre  <- fb24[, c('mdbf1', 'mdbf5_r', 
                        'mdbf7_r', 'mdbf10')] |> rowMeans()
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb24$ru_pre <-  fb24[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb24$ru_pre_zstd <- scale(fb24$ru_pre, center = TRUE, scale = TRUE)
```

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb24)
```

```
## [1] 192  55
```

```r
str(fb24)
```

```
## 'data.frame':	192 obs. of  55 variables:
##  $ mdbf1      : num  4 3 3 3 3 2 4 2 3 4 ...
##  $ mdbf2      : num  3 2 3 1 2 2 4 3 3 4 ...
##  $ mdbf3      : num  1 1 1 2 3 1 1 2 2 1 ...
##  $ mdbf4      : num  1 1 1 2 1 3 1 1 1 1 ...
##  $ mdbf5      : num  3 1 3 3 2 4 1 2 1 1 ...
##  $ mdbf6      : num  3 3 3 2 2 3 3 3 3 4 ...
##  $ mdbf7      : num  3 3 2 3 2 4 1 4 1 1 ...
##  $ mdbf8      : num  4 4 3 3 3 2 4 3 4 4 ...
##  $ mdbf9      : num  1 2 1 2 3 2 3 3 2 1 ...
##  $ mdbf10     : num  3 3 3 3 3 2 3 2 4 4 ...
##  $ mdbf11     : num  1 1 1 2 3 2 2 1 2 1 ...
##  $ mdbf12     : num  3 4 3 3 2 2 3 2 3 4 ...
##  $ time_pre   : num  49 68 107 38 45 100 61 40 36 40 ...
##  $ lz         : num  6.6 4 5.2 4 5 4.4 6.4 4 4.6 6 ...
##  $ extra      : num  5 4 3 1.5 2.5 4.5 4 2.5 4 3 ...
##  $ vertr      : num  4 3 3 3 3.5 2.5 4 2.5 4.5 3 ...
##  $ gewis      : num  4 4.5 4 3.5 2.5 4 3.5 3.5 4 5 ...
##  $ neuro      : num  1.5 3 3.5 3.5 4.5 3.5 2.5 3.5 5 2.5 ...
##  $ offen      : num  4 4 4 3.5 4.5 4 4 4 4.5 3 ...
##  $ prok       : num  2.7 2.5 2.9 2.8 2.9 2.7 2.4 2.5 2.7 2.6 ...
##  $ nerd       : num  2.5 2.33 2.83 4 3.67 ...
##  $ uni1       : num  0 0 0 0 0 0 0 0 1 0 ...
##  $ uni2       : num  1 1 1 1 1 1 1 1 1 1 ...
##  $ uni3       : num  0 0 1 0 0 1 0 1 1 1 ...
##  $ uni4       : num  0 0 1 0 0 0 0 0 1 0 ...
##  $ grund      : chr  "Interesse an Menschen, Verhalten und Sozialdynamiken" "Ich will die Menschliche Psyche und menschliches Handeln, Denken verstehen." NA "Um Therapeutin zu werden und Menschen aus meiner früheren Situatuon zu helfen " ...
##  $ fach       : Factor w/ 5 levels "Allgemeine","Biologische",..: 1 3 1 4 4 3 1 3 1 4 ...
##  $ ziel       : Factor w/ 4 levels "Wirtschaft","Therapie",..: 3 2 3 2 2 3 1 4 4 2 ...
##  $ wissen     : int  4 3 5 5 4 3 3 4 5 3 ...
##  $ therap     : int  5 4 5 5 5 5 4 5 4 5 ...
##  $ lerntyp    : num  3 1 1 1 1 1 3 3 3 1 ...
##  $ hand       : num  1 2 2 2 2 2 2 2 1 2 ...
##  $ job        : Factor w/ 2 levels "nein","ja": 2 1 2 1 1 1 1 1 2 2 ...
##  $ ort        : Factor w/ 2 levels "FFM","anderer": 2 2 1 1 1 1 1 2 1 1 ...
##  $ ort12      : num  1 2 1 1 2 2 2 1 2 2 ...
##  $ wohnen     : Factor w/ 4 levels "WG","bei Eltern",..: 2 3 3 3 3 3 1 2 1 1 ...
##  $ attent     : num  5 4 5 5 5 5 5 4 4 5 ...
##  $ gs_post    : num  NA 3 3.5 2.75 2.5 3 NA 3.25 3 3.25 ...
##  $ wm_post    : num  NA 2.25 3 2.25 2.5 2.25 NA 2.5 3 3.25 ...
##  $ ru_post    : num  NA 2.25 2.25 2.25 2 2.25 NA 2.25 2.75 1.75 ...
##  $ time_post  : num  NA 34 37 37 51 40 NA 40 30 27 ...
##  $ attent_post: num  NA 5 5 5 5 5 NA 5 5 5 ...
##  $ hand_factor: Factor w/ 2 levels "links","rechts": 1 2 2 2 2 2 2 2 1 2 ...
##  $ fach_klin  : Factor w/ 2 levels "nicht klinisch",..: 1 1 1 2 2 1 1 1 1 2 ...
##  $ unipartys  : Factor w/ 2 levels "nein","ja": 1 1 2 1 1 2 1 2 2 2 ...
##  $ mdbf4_r    : num  4 4 4 3 4 2 4 4 4 4 ...
##  $ mdbf11_r   : num  4 4 4 3 2 3 3 4 3 4 ...
##  $ mdbf3_r    : num  4 4 4 3 2 4 4 3 3 4 ...
##  $ mdbf9_r    : num  4 3 4 3 2 3 2 2 3 4 ...
##  $ mdbf5_r    : num  2 4 2 2 3 1 4 3 4 4 ...
##  $ mdbf7_r    : num  2 2 3 2 3 1 4 1 4 4 ...
##  $ wm_pre     : num  2.75 3 2.75 2.5 3 1.5 3.75 2 3.75 4 ...
##  $ gs_pre     : num  4 3.75 3.5 3 3 2.25 3.75 3.25 3.5 4 ...
##  $ ru_pre     : num  3.5 3.5 3.5 2.75 2 3 3 2.5 3 4 ...
##  $ ru_pre_zstd: num [1:192, 1] 1.0554 1.0554 1.0554 -0.0402 -1.1357 ...
##   ..- attr(*, "scaled:center")= num 2.78
##   ..- attr(*, "scaled:scale")= num 0.685
```

Der Datensatz besteht aus 192 Zeilen (Beobachtungen) und 55 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.

***
    
   
## Aufgabe 1
Welche der fünf Persönlichkeitsdimensionen Extraversion (`extra`), Verträglichkeit (`vertr`), Gewissenhaftigkeit (`gewis`), Neurotizsimus (`neuro`) und Offenheit für neue Erfahrungen (`offen`) zeigt den höchsten linearen Zusammenhang mit der Lebenszufriedenheit (`lz`)?

  * Erstellen Sie für jeden Zusammenhang je ein Streudiagramm.

<details><summary>Lösung</summary>

**`extra`:**

```r
plot(fb24$extra, fb24$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/einfache-reg-loesungen_files/unnamed-chunk-3-1.png)<!-- -->

**`vertr`:**

```r
plot(fb24$vertr, fb24$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/einfache-reg-loesungen_files/unnamed-chunk-4-1.png)<!-- -->

**`gewis`:**

```r
plot(fb24$gewis, fb24$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/einfache-reg-loesungen_files/unnamed-chunk-5-1.png)<!-- -->

**`neuro`:**

```r
plot(fb24$neuro, fb24$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/einfache-reg-loesungen_files/unnamed-chunk-6-1.png)<!-- -->

**`intel`:**

```r
plot(fb24$offen, fb24$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/einfache-reg-loesungen_files/unnamed-chunk-7-1.png)<!-- -->

</details>

  * Schätzen Sie für jeden Zusammenhang je ein Modell.

<details><summary>Lösung</summary>

**`extra`:**

```r
fme <- lm(lz ~ extra, fb24)
summary(fme)
```

```
## 
## Call:
## lm(formula = lz ~ extra, data = fb24)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.0204 -0.6463  0.1537  0.7408  2.0572 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.43939    0.25842  13.309  < 2e-16 ***
## extra        0.45172    0.07532   5.998 9.99e-09 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.057 on 189 degrees of freedom
##   (1 Beobachtung als fehlend gelöscht)
## Multiple R-squared:  0.1599,	Adjusted R-squared:  0.1554 
## F-statistic: 35.97 on 1 and 189 DF,  p-value: 9.992e-09
```

**`vertr`:**

```r
fmv <- lm(lz ~ vertr, fb24)
summary(fmv)
```

```
## 
## Call:
## lm(formula = lz ~ vertr, data = fb24)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -3.04951 -0.67250  0.07616  0.85049  2.12750 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   4.0442     0.3588  11.271   <2e-16 ***
## vertr         0.2513     0.1003   2.507    0.013 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.134 on 189 degrees of freedom
##   (1 Beobachtung als fehlend gelöscht)
## Multiple R-squared:  0.03218,	Adjusted R-squared:  0.02706 
## F-statistic: 6.285 on 1 and 189 DF,  p-value: 0.01302
```

**`gewis`:**

```r
fmg <- lm(lz ~ gewis, fb24)
summary(fmg)
```

```
## 
## Call:
## lm(formula = lz ~ gewis, data = fb24)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.0219 -0.6895  0.1105  0.8766  2.2090 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.76025    0.32588  11.539  < 2e-16 ***
## gewis        0.33232    0.09049   3.673 0.000312 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.114 on 189 degrees of freedom
##   (1 Beobachtung als fehlend gelöscht)
## Multiple R-squared:  0.06661,	Adjusted R-squared:  0.06167 
## F-statistic: 13.49 on 1 and 189 DF,  p-value: 0.0003125
```

**`neuro`:**

```r
fmn <- lm(lz ~ neuro, fb24)
summary(fmn)
```

```
## 
## Call:
## lm(formula = lz ~ neuro, data = fb24)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.7780 -0.7258  0.1699  0.7481  2.2827 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   6.6387     0.2843  23.347  < 2e-16 ***
## neuro        -0.5043     0.0804  -6.272 2.37e-09 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.049 on 189 degrees of freedom
##   (1 Beobachtung als fehlend gelöscht)
## Multiple R-squared:  0.1723,	Adjusted R-squared:  0.1679 
## F-statistic: 39.34 on 1 and 189 DF,  p-value: 2.368e-09
```

**`intel`:**

```r
fmo <- lm(lz ~ offen, fb24)
summary(fmo)
```

```
## 
## Call:
## lm(formula = lz ~ offen, data = fb24)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -3.02651 -0.71322  0.01824  0.81824  2.01824 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  4.57896    0.33563  13.643   <2e-16 ***
## offen        0.08951    0.08537   1.049    0.296    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.149 on 189 degrees of freedom
##   (1 Beobachtung als fehlend gelöscht)
## Multiple R-squared:  0.005783,	Adjusted R-squared:  0.0005228 
## F-statistic: 1.099 on 1 and 189 DF,  p-value: 0.2957
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
sfme <- lm(scale(lz) ~ scale(extra), fb24)
sfme
```

```
## 
## Call:
## lm(formula = scale(lz) ~ scale(extra), data = fb24)
## 
## Coefficients:
##  (Intercept)  scale(extra)  
##   -5.044e-16     3.999e-01
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
## lm(formula = lz ~ extra, data = fb24)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.0204 -0.6463  0.1537  0.7408  2.0572 
## 
## Coefficients:
##             Estimate Standardized Std. Error t value Pr(>|t|)    
## (Intercept)  3.43939           NA    0.25842  13.309  < 2e-16 ***
## extra        0.45172      0.39986    0.07532   5.998 9.99e-09 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.057 on 189 degrees of freedom
##   (1 Beobachtung als fehlend gelöscht)
## Multiple R-squared:  0.1599,	Adjusted R-squared:  0.1554 
## F-statistic: 35.97 on 1 and 189 DF,  p-value: 9.992e-09
```

lm.beta()  ergänzt den Output der lm()-Funktion an der Stelle der Koeffizienten um die Spalte "Standardized". Dieser können wir den standardisierten Koeffizienten des linearen Zusammenhangs zwischen Extraversion und Lebenszufriedenheit entnehmen.

Wenn sich die Variable `extra` um eine Standardabweichung verändert, verändert sich das Kriterium `lz` um 0.4 Standardabweichungen.

</details>

## Aufgabe 2

Betrachten Sie nun den Zusammenhang von Neurotizismus (`neuro`) und Lebenszufriedenheit (`lz`) etwas genauer:

  * Erstellen Sie ein Streu-Punkt-Diagramm  mit Regressionsgerade für den linearen Zusammenhang zwischen Neurotizismus und Lebenszufriedenheit.

<details><summary>Lösung</summary>


```r
plot(fb24$neuro, fb24$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
abline(fmn, col = "red")
```

![](/einfache-reg-loesungen_files/unnamed-chunk-15-1.png)<!-- -->

</details>

  * Wie viel Prozent der Varianz werden durch das Modell erklärt?

<details><summary>Lösung</summary>


```r
summary(fmn)
```

```
## 
## Call:
## lm(formula = lz ~ neuro, data = fb24)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.7780 -0.7258  0.1699  0.7481  2.2827 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   6.6387     0.2843  23.347  < 2e-16 ***
## neuro        -0.5043     0.0804  -6.272 2.37e-09 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.049 on 189 degrees of freedom
##   (1 Beobachtung als fehlend gelöscht)
## Multiple R-squared:  0.1723,	Adjusted R-squared:  0.1679 
## F-statistic: 39.34 on 1 and 189 DF,  p-value: 2.368e-09
```

$\rightarrow$ Das Modell erklärt 17.23% der Varianz in Lebenszufriedenheit durch Neurotizismus.

</details>

  * Ein paar Studierende wurden nachträglich zum Studiengang Psychologie zugelassen und befinden sich daher nicht im Datensatz. Die neuen Studierenden wurden nachträglich befragt und weisen auf der Skala Neurotizismus folgende Werte auf: 1.25; 2.75; 3.5; 4.25; 3.75; 2.15. Machen Sie eine Vorhersage für die Lebenszufriedenheit für die neuen Studierenden.

<details><summary>Lösung</summary>


```r
new <- data.frame(neuro = c(1.25, 2.75, 3.5, 4.25, 3.75, 2.15))
predict(fmn, newdata = new)
```

```
##        1        2        3        4        5        6 
## 6.008326 5.251903 4.873691 4.495480 4.747621 5.554472
```

</details> 
