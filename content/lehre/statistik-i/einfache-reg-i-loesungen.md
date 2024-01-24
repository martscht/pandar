---
title: "Regression I - Lösungen" 
type: post
date: '2021-01-04' 
slug: einfache-reg-i-loesungen 
categories: [] 
tags: ["Statistik I Übungen"] 
subtitle: ''
summary: '' 
authors: [winkler, neubauer] 
weight: 
lastmod: '2024-01-24'
featured: no
banner:
  image: "/header/modern_buildings.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/411588)"
projects: []
expiryDate: 
publishDate: '2024-02-04'
_build:
  list: never
reading_time: false
share: false
output:
  html_document:
    keep_md: true
---




## Vorbereitung



Laden Sie zunächst den Datensatz `fb22` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb22.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/regression/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb22)
```

```
## [1] 159  47
```

```r
str(fb22)
```

```
## 'data.frame':	159 obs. of  47 variables:
##  $ prok1        : int  1 4 3 1 2 2 2 3 2 4 ...
##  $ prok2        : int  3 3 3 3 1 4 2 1 3 3 ...
##  $ prok3        : int  4 2 2 4 4 2 3 2 2 2 ...
##  $ prok4        : int  2 4 4 NA 3 2 2 3 3 4 ...
##  $ prok5        : int  3 1 2 4 2 3 3 3 4 2 ...
##  $ prok6        : int  4 4 4 3 1 2 2 3 2 4 ...
##  $ prok7        : int  3 2 2 4 2 3 3 3 3 3 ...
##  $ prok8        : int  3 4 3 4 4 2 3 3 4 2 ...
##  $ prok9        : int  1 4 4 2 1 1 2 2 3 4 ...
##  $ prok10       : int  3 4 3 2 1 3 1 4 1 4 ...
##  $ nr1          : int  1 1 4 2 1 1 1 5 2 1 ...
##  $ nr2          : int  3 2 5 4 5 4 3 5 4 4 ...
##  $ nr3          : int  5 1 5 4 1 3 3 5 5 4 ...
##  $ nr4          : int  4 2 5 4 2 4 4 5 3 5 ...
##  $ nr5          : int  4 2 5 4 2 3 4 5 4 4 ...
##  $ nr6          : int  3 1 5 3 2 1 1 5 2 4 ...
##  $ lz           : num  5.4 6 3 6 3.2 5.8 4.2 NA 5.4 4.6 ...
##  $ extra        : num  2.75 3.75 4.25 4 2.5 3 2.75 3.5 4.75 5 ...
##  $ vertr        : num  3.75 4.75 4.5 4.75 4.75 3 3.25 5 4.5 4.5 ...
##  $ gewis        : num  4.25 2.75 3.75 4.25 5 4.25 4 4.75 4.5 3 ...
##  $ neuro        : num  4.25 5 4 2.25 3.75 3.25 3 3.5 4 4.5 ...
##  $ intel        : num  4.75 4 5 4.75 3.5 3 4 4 5 4.25 ...
##  $ nerd         : num  2.67 4 4.33 3.17 4.17 ...
##  $ grund        : chr  "Interesse" "Allgemeines Interesse schon seit der Kindheit" "menschliche Kognition wichtig und rätselhaft; Interesse für Psychoanalyse; Schnittstelle zur Linguistik" "Psychoanalyse, Hilfsbereitschaft, Lebenserfahrung" ...
##  $ fach         : Factor w/ 5 levels "Allgemeine","Biologische",..: 5 4 1 4 2 NA 1 4 3 4 ...
##  $ ziel         : Factor w/ 4 levels "Wirtschaft","Therapie",..: 2 2 3 2 2 NA 1 2 2 2 ...
##  $ lerntyp      : num  1 1 1 1 1 NA 3 2 3 1 ...
##  $ geschl       : int  1 2 2 2 1 NA 2 1 1 1 ...
##  $ job          : int  1 2 1 1 1 NA 2 1 1 1 ...
##  $ ort          : int  1 1 1 2 2 NA 2 1 1 1 ...
##  $ ort12        : int  1 1 1 1 1 NA 1 1 1 1 ...
##  $ wohnen       : Factor w/ 4 levels "WG","bei Eltern",..: 2 2 3 4 2 NA 2 1 1 3 ...
##  $ uni1         : num  0 0 0 0 0 0 0 1 1 1 ...
##  $ uni2         : num  1 1 0 1 1 0 0 1 1 1 ...
##  $ uni3         : num  0 0 0 0 0 0 0 1 1 1 ...
##  $ uni4         : num  0 0 1 0 0 0 0 0 0 0 ...
##  $ geschl_faktor: Factor w/ 3 levels "weiblich","männlich",..: 1 2 2 2 1 NA 2 1 1 1 ...
##  $ prok2_r      : num  2 2 2 2 4 1 3 4 2 2 ...
##  $ prok3_r      : num  1 3 3 1 1 3 2 3 3 3 ...
##  $ prok5_r      : num  2 4 3 1 3 2 2 2 1 3 ...
##  $ prok7_r      : num  2 3 3 1 3 2 2 2 2 2 ...
##  $ prok8_r      : num  2 1 2 1 1 3 2 2 1 3 ...
##  $ prok_ges     : num  2 3.3 3.1 NA 2 2.1 2 2.8 2 3.3 ...
##  $ nr_ges       : num  3.33 1.5 4.83 3.5 2.17 ...
##  $ nr_ges_z     : num [1:159, 1] 0.0964 -2.1534 1.9372 0.3009 -1.3353 ...
##   ..- attr(*, "scaled:center")= num 3.25
##   ..- attr(*, "scaled:scale")= num 0.815
##  $ nerd_std     : num [1:159, 1] -0.7059 1.3395 1.8509 0.0611 1.5952 ...
##   ..- attr(*, "scaled:center")= num 3.13
##   ..- attr(*, "scaled:scale")= num 0.652
##  $ neuro_std    : num [1:159, 1] 0.869 1.912 0.521 -1.914 0.173 ...
##   ..- attr(*, "scaled:center")= num 3.63
##   ..- attr(*, "scaled:scale")= num 0.719
```

Der Datensatz besteht aus 159 Zeilen (Beobachtungen) und 47 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.

***
    
   
## Aufgabe 1
Welche der fünf Persönlichkeitsdimensionen Extraversion (`extra`), Verträglichkeit (`vertr`), Gewissenhaftigkeit (`gewis`), Neurotizsimus (`neuro`) und Intellekt (`intel`) zeigt den höchsten linearen Zusammenhang mit der Lebenszufriedenheit (`lz`)?

  * Erstellen Sie für jeden Zusammenhang je ein Streudiagramm.

<details><summary>Lösung</summary>
**`extra`:**

```r
plot(fb22$extra, fb22$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/einfache-reg-i-loesungen_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

**`vertr`:**

```r
plot(fb22$vertr, fb22$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/einfache-reg-i-loesungen_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

**`gewis`:**

```r
plot(fb22$gewis, fb22$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/einfache-reg-i-loesungen_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

**`neuro`:**

```r
plot(fb22$neuro, fb22$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/einfache-reg-i-loesungen_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

**`intel`:**

```r
plot(fb22$intel, fb22$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
```

![](/lehre/statistik-i/einfache-reg-i-loesungen_files/figure-html/unnamed-chunk-7-1.png)<!-- -->
</details>

<p>
  * Schätzen Sie für jeden Zusammenhang je ein Modell.

<details><summary>Lösung</summary>
**`extra`:**

```r
fme <- lm(lz ~ extra, fb22)
summary(fme)
```

```
## 
## Call:
## lm(formula = lz ~ extra, data = fb22)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.2680 -0.7009  0.1320  0.8425  2.0096 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   3.6590     0.4128   8.863 1.73e-15 ***
## extra         0.3105     0.1194   2.599   0.0102 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.055 on 155 degrees of freedom
##   (2 Beobachtungen als fehlend gelöscht)
## Multiple R-squared:  0.04177,	Adjusted R-squared:  0.03559 
## F-statistic: 6.757 on 1 and 155 DF,  p-value: 0.01024
```

**`vertr`:**

```r
fmv <- lm(lz ~ vertr, fb22)
summary(fmv)
```

```
## 
## Call:
## lm(formula = lz ~ vertr, data = fb22)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.2873 -0.6167  0.1127  0.7774  1.8480 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   3.6519     0.6136   5.952 1.71e-08 ***
## vertr         0.2588     0.1487   1.740   0.0838 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.067 on 155 degrees of freedom
##   (2 Beobachtungen als fehlend gelöscht)
## Multiple R-squared:  0.01917,	Adjusted R-squared:  0.01284 
## F-statistic: 3.029 on 1 and 155 DF,  p-value: 0.08376
```

**`gewis`:**

```r
fmg <- lm(lz ~ gewis, fb22)
summary(fmg)
```

```
## 
## Call:
## lm(formula = lz ~ gewis, data = fb22)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -2.90189 -0.57501  0.07874  0.69811  2.25937 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   2.7450     0.4900   5.602 9.42e-08 ***
## gewis         0.5075     0.1248   4.067 7.57e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.024 on 155 degrees of freedom
##   (2 Beobachtungen als fehlend gelöscht)
## Multiple R-squared:  0.0964,	Adjusted R-squared:  0.09058 
## F-statistic: 16.54 on 1 and 155 DF,  p-value: 7.57e-05
```

**`neuro`:**

```r
fmn <- lm(lz ~ neuro, fb22)
summary(fmn)
```

```
## 
## Call:
## lm(formula = lz ~ neuro, data = fb22)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.2277 -0.6419  0.1188  0.7581  1.8795 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   5.4848     0.4404  12.454   <2e-16 ***
## neuro        -0.2143     0.1194  -1.794   0.0748 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.066 on 155 degrees of freedom
##   (2 Beobachtungen als fehlend gelöscht)
## Multiple R-squared:  0.02034,	Adjusted R-squared:  0.01402 
## F-statistic: 3.219 on 1 and 155 DF,  p-value: 0.07476
```

**`intel`:**

```r
fmi <- lm(lz ~ intel, fb22)
summary(fmi)
```

```
## 
## Call:
## lm(formula = lz ~ intel, data = fb22)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.5318 -0.6023  0.0739  0.7387  2.0797 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   2.7678     0.4779   5.791 3.77e-08 ***
## intel         0.5410     0.1312   4.123 6.07e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.023 on 155 degrees of freedom
##   (2 Beobachtungen als fehlend gelöscht)
## Multiple R-squared:  0.09885,	Adjusted R-squared:  0.09303 
## F-statistic:    17 on 1 and 155 DF,  p-value: 6.068e-05
```
Wenn wir die Koeffizienten der Modelle vergleichen, sehen wir, dass `intel` den stärksten linearen Zusammenhang mit `lz` aufweist (Hinweis: für den Vergleich der Modelle vergleichen wir den Determinationskoeffizienten der fünf Modelle! Dieser ist für das Modell mit dem Prädiktor Intellekt am höchsten)
</details>

<p>
  * Prüfen Sie die Voraussetzungen und interpretieren Sie den standardisierten Koeffizienten des linearen Zusammenhangs zwischen Intellekt und Lebenszufriedenheit. Wie verändert sich `lz`, wenn sich `intel` um eine Standardabweichung erhöht?
 
<details><summary>Lösung</summary>
### Voraussetzungen:

1. Linearität: Zusammenhang muss linear sein $\rightarrow$ Grafische Überprüfung (Scatterplot)  
2. Varianzhomogenität (Homoskedastizität) der Fehler: der Fehler jedes Wertes der UV hat annähernd die gleiche Varianz  
3. Normalverteilung der Fehlervariablen  
4. Unabhängigkeit der Fehler  

Die Voraussetzungen 2-4 können erst geprüft werden, nachdem das Modell schon gerechnet wurde, weil sie sich auf die Fehler (Residuen: Differenz aus beobachtetem und vorhergesagtem Wert für y) beziehen!

**zu 1. Linearität: Zusammenhang muss linear sein $\rightarrow$ Grafische Überprüfung (Scatterplot)**


```r
plot(fb22$intel, fb22$lz, xlab = "Intellekt", ylab = "Lebenszufriedenheit", 
     main = "Zusammenhang zwischen Intellekt und Lebenszufriedenheit", xlim = c(0, 6), ylim = c(0, 7), pch = 19)
lines(loess.smooth(fb22$intel, fb22$lz), col = 'blue')    #beobachteter, lokaler Zusammenhang
fmi <- lm(lz ~ intel, fb22)                              #Modell erstellen und ablegen
abline(fmi, col = "red")                                  #Modellierter linearer Zusammenhang in zuvor erstellten Plot einzeichnen
```

![](/lehre/statistik-i/einfache-reg-i-loesungen_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

**zu Voraussetzungen 2-4:**


```r
par(mfrow = c(2, 2)) #Vier Abbildungen gleichzeitig
plot(fmi)
```

![](/lehre/statistik-i/einfache-reg-i-loesungen_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

```r
par(mfrow = c(1, 1)) #wieder auf eine Abbildung zurücksetzen
```


In diesem Fall ist alles weitestgehend erfüllt.


```r
sfmi <- lm(scale(lz) ~ scale(intel), fb22)
sfmi
```

```
## 
## Call:
## lm(formula = scale(lz) ~ scale(intel), data = fb22)
## 
## Coefficients:
##  (Intercept)  scale(intel)  
##    0.0002271     0.3131344
```

Wenn sich die Variable `intel` um eine Standardabweichung verändert, verändert sich das Kriterium `lz` um 0.31 Standardabweichungen.
</details>

## Aufgabe 2

Betrachten Sie nun den Zusammenhang von Neurotizismus und Lebenszufriedenheit etwas genauer:

  * Erstellen Sie ein Streu-Punkt-Diagramm  mit Regressionsgerade für den linearen Zusammenhang zwischen Neurotizismus und Lebenszufriedenheit.

<details><summary>Lösung</summary>

```r
plot(fb22$neuro, fb22$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
abline(fmn, col = "red")
```

![](/lehre/statistik-i/einfache-reg-i-loesungen_files/figure-html/unnamed-chunk-16-1.png)<!-- -->
</details>

<p>
  * Wie viel Prozent der Varianz werden durch das Modell erklärt?

<details><summary>Lösung</summary>

```r
summary(fmn)
```

```
## 
## Call:
## lm(formula = lz ~ neuro, data = fb22)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.2277 -0.6419  0.1188  0.7581  1.8795 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   5.4848     0.4404  12.454   <2e-16 ***
## neuro        -0.2143     0.1194  -1.794   0.0748 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.066 on 155 degrees of freedom
##   (2 Beobachtungen als fehlend gelöscht)
## Multiple R-squared:  0.02034,	Adjusted R-squared:  0.01402 
## F-statistic: 3.219 on 1 and 155 DF,  p-value: 0.07476
```

  * Das Modell erklärt 2.03% der Varianz in Lebenszufriedenheit durch Neurotizismus.
</details>

<p>
  * Ein paar Studierende wurden nachträglich zum Studiengang Psychologie zugelassen und befinden sich daher nicht im Datensatz. Die neuen Studierenden wurden nachträglich befragt und weisen auf der Skala Neurotizismus folgende Werte auf: 1.25; 2.75; 3.5; 4.25; 3.75; 2.15. Machen Sie eine Vorhersage für die Lebenszufriedenheit für die neuen Studierenden.

<details><summary>Lösung</summary>

```r
new <- data.frame(neuro = c(1.25, 2.75, 3.5, 4.25, 3.75, 2.15))
predict(fmn, newdata = new)
```

```
##        1        2        3        4        5        6 
## 5.216925 4.895510 4.734803 4.574096 4.681234 5.024076
```
</details> 
