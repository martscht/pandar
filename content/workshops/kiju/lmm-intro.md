---
title: Einführung in gemischte Modelle mit lme4
type: post
date: '2023-02-23'
slug: lmm-intro
categories: ["KiJu"]
tags: ["Regression", "Hierarchische Daten", "Zufallseffekte"]
subtitle: ''
summary: ''
authors: [schultze]
weight: 3
lastmod: '2024-01-12'
featured: no
banner:
  image: "/header/grapevines_dark.jpg"
  caption: "[Courtesy of pexels](https://www.pexels.com/photo/bunches-of-grapes-hanging-from-vines-3840335/)"
projects: []

reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /workshops/kiju/lmm-intro
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /workshops/kiju/lmm-intro.R

output:
  html_document:
    keep_md: true
---







## Vorbereitung

### Datenbeispiel

- International College Survey (Diener, Kim-Pietro, Scollon, et al., 2001)
- Wohlbefinden in unterschiedlichen Ländern


```r
load(url('https://pandar.netlify.app/post/kultur.rda'))
head(kultur)[, 1:8] # alle Zeilen und Spalten 1-8 für die ersten 6 Personen
```


```
##   nation female auf_e kla_e lezu       pa    na         bal
## 1 Turkey   male   3.0   3.0  4.0 4.333333 4.250  0.08333333
## 2 Turkey female   2.5   2.5  5.6 5.333333 7.375 -2.04166667
## 3 Turkey female   3.0   3.0  4.0 5.666667 2.000  3.66666667
## 4 Turkey female   3.5   3.0  2.4 3.833333 5.000 -1.16666667
## 5 Turkey female   3.5   2.5  2.0 5.666667 6.125 -0.45833333
## 6 Turkey   male   3.0   3.0  4.4 6.666667 4.500  2.16666667
```

- Lebenszufriedenheit (lezu)
  * 5 Items auf einer Skala von 1 (“strongly disagree”) bis 7 (“strongly agree”)
  * z.B. “I am satisfied with my life”
- Positiver Affekt (pa) & negativer Affekt (na)
  * "For the following list of emotions, please rate how often you felt each of the emotions in the last week"
  * Skala von 1 (“not at all”) bis 7 (“all the time”)
  * Für positiven Affekt: Pleasant, Happy, Cheerful, etc.
  * Für negativen Affekt: Unpleasant, Sad, Anger, etc.
- Klarheit eigener Gefühle (kla_e)
- Aufmerksamkeit auf eigene Gefühle (auf_e)
- Schachtelung in Nationen (nation)


```r
levels(kultur$nation) # Übersicht über alle vorkommenden Nationen
```

```
##  [1] "Turkey"      "Korea"       "Slovenia"    "Nigeria"    
##  [5] "Japan"       "Chile"       "China"       "Thailand"   
##  [9] "Australia"   "Hong Kong"   "Iran"        "Greece"     
## [13] "Philippines" "Nepal"       "Cyprus"      "Indonesia"  
## [17] "Mexico"      "Belgium"     "Portugal"    "Uganda"     
## [21] "Singapore"   "Netherlands" "Malaysia"    "Georgia"    
## [25] "Croatia"     "Ghana"       "Bulgaria"    "Bangladesh" 
## [29] "Russia"      "Slovakia"    "Zimbabwe"    "Germany"    
## [33] "Kuwait"      "Columbia"    "Brazil"      "Cameroon"   
## [37] "Canada"      "India"       "S. Africa"   "Austria"
```


```r
dim(kultur) # Anzahl Zeilen und Spalten des ganzen Datensatzes
```

```
## [1] 7194   16
```


### Regressionsergebnisse im Beispiel


```r
mod <- lm(lezu ~ 1 + pa, kultur) # Interzept wird hier explizit angefordert
summary(mod)
```

```
## 
## Call:
## lm(formula = lezu ~ 1 + pa, data = kultur)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -4.4262 -0.7588  0.1076  0.7743  3.0413 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 2.225025   0.049592   44.87   <2e-16 ***
## pa          0.400132   0.008679   46.10   <2e-16 ***
## ---
## Signif. codes:  
## 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.086 on 7139 degrees of freedom
##   (53 Beobachtungen als fehlend gelöscht)
## Multiple R-squared:  0.2294,	Adjusted R-squared:  0.2293 
## F-statistic:  2126 on 1 and 7139 DF,  p-value: < 2.2e-16
```
- Darstellung der Ergebnisse (siehe [ggplotting unter Extras](https://pandar.netlify.app/extras/#ggplotting))


```r
library(ggplot2)
ggplot(kultur, aes(x = pa, y = lezu)) + 
  geom_point() +
  geom_abline(intercept = coef(mod)[1], slope = coef(mod)[2], color = 'blue') +
  theme_minimal()
```

```
## Warning: Removed 53 rows containing missing values
## (`geom_point()`).
```

![](/workshops/kiju/lmm-intro_files/figure-html/scatter-reg-1.png)<!-- -->


- R-Funktionen für Regression

Befehl | Funktionalität
--- | ------
`summary()` | Zusammenfassung der Ergebnisse
`coef()` | Koeffizienten ausgeben lassen
`confint()` | Konfidenzintervalle für Koeffizienten
`resid()` | Ausgabe der $e_{i}$
`predict()` | Ausgabe der $\hat{y}_i$
`anova()` | Modellvergleiche
`plot()` | Residuenplots zur Diagnostik

### Pakete


```r
# Für Plots der Modelle - dauert einen Moment
install.packages('sjPlot', dependencies = TRUE)

# Für eine erweiterte Modellzusammenfassung
installpackages('jtools')
```

Für alternative Ansätze der Darstellung bzw. Berechnung von Komponenten (nur in vereinzelten Beispielen genutzt)


```r
# Für Inferenz der fixed effects
install.packages('lmerTest')

# Für Bestimmung von Pseudo R^2
install.packages('MuMIn')
```


## Hintergrund zu LMMs

- Verletzung der Annahme unabhängiger Beobachtungen
  * Varianz kleiner als bei Zufallsstichprobe (wegen Abhängigkeiten)
  * Effektives $n$ überschätzt
  * Präzision der Effekte überschätzt (SE unterschätzt)
- Koeffizienten nicht verzerrt, aber gemischt
  * Risiko falscher Schlüsse

  
- Für Umgang mit Voraussetzungsverletzung ist Korrektur der SE ausreichend
- Für korrekte Zerlegung von Effekten und deren Wirkebene: LMMs


- Feste Effekte (Kodiervariablen)
  * Aussagen über einzelne Ausprägungen relevant
  * Durch Studiendesign festgelegt oder natürliche Gruppen
  * Geschlecht, Therapieansätze, Schulformen
- Zufällige Effekte (LMMs)
  * Zusammenfassende Aussagen über viele Ausprägungen relevant
  * Per Zufall aus Population gezogen
  * Schulklasse, Therapeut:innen, Teams

  
- Übliche Begriffe
  * Mehrebenenmodelle
  * Gemischte Modelle (LMMs)
  * Hierarchische Modelle

Level 2 | Level 1
--- | ---
macro-units | micro-units
primary units | secondary units
clusters | elementary units
between level | within level

## Nullmodell

### Notation

Notation | Bedeutung
-- | -----
$y_{ij}$ | AV-Wert von Person $i$ in Cluster $j$
$r_{ij}$ | Residuum auf L1, Abweichung der Person von Vorhersage
$u_{0j}$ | Residuum auf L2, Abweichung des Clusters von Vorhersage
$\beta_{0j}$ | (bedingter) Erwartungswert für Cluster $j$
$\gamma_{00}$ | Erwartungswert der Erwartungswerte über alle Cluster

**Level 1** 
$$ y_{ij} = \beta_{0j} + r_{ij} $$

**Level 2**
$$ \beta_{0j} = \gamma_{00} + u_{0j} $$

**Gesamtgleichung**
$$ y_{ij} = \gamma_{00} + u_{0j} + r_{ij} $$

### Nullmodell in lme4


```r
library(lme4)
mod0 <- lmer(lezu ~ 1 + (1 | nation), kultur)
```

Generelle Schreibweise:

- `lmer`: *linear mixed effects regression*
- `AV ~ UV`: wie in `lm`
- `(RE | Cluster)`: Welcher Parameter (`RE`) soll über die Cluster variieren dürfen



```r
summary(mod0)
```

```
## Linear mixed model fit by REML. t-tests use
##   Satterthwaite's method [lmerModLmerTest]
## Formula: lezu ~ 1 + (1 | nation)
##    Data: kultur
## 
## REML criterion at convergence: 21954.9
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -3.8470 -0.6650  0.0939  0.7345  3.3902 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  nation   (Intercept) 0.2854   0.5342  
##  Residual             1.2296   1.1089  
## Number of obs: 7163, groups:  nation, 40
## 
## Fixed effects:
##             Estimate Std. Error       df t value Pr(>|t|)
## (Intercept)  4.39599    0.08581 39.05402   51.23   <2e-16
##                
## (Intercept) ***
## ---
## Signif. codes:  
## 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### Inferenzstatistik in lme4


```r
confint(mod0)
```

```
## Computing profile confidence intervals ...
```

```
##                 2.5 %    97.5 %
## .sig01      0.4264675 0.6719161
## .sigma      1.0908914 1.1273144
## (Intercept) 4.2259305 4.5662197
```


```r
library(lmerTest)
mod0 <- lmer(lezu ~ 1 + (1 | nation), kultur)
summary(mod0)
```

```
## Linear mixed model fit by REML. t-tests use
##   Satterthwaite's method [lmerModLmerTest]
## Formula: lezu ~ 1 + (1 | nation)
##    Data: kultur
## 
## REML criterion at convergence: 21954.9
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -3.8470 -0.6650  0.0939  0.7345  3.3902 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  nation   (Intercept) 0.2854   0.5342  
##  Residual             1.2296   1.1089  
## Number of obs: 7163, groups:  nation, 40
## 
## Fixed effects:
##             Estimate Std. Error       df t value Pr(>|t|)
## (Intercept)  4.39599    0.08581 39.05402   51.23   <2e-16
##                
## (Intercept) ***
## ---
## Signif. codes:  
## 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

## Zufällige Effekte


```r
summary(mod0)$var
```

```
##  Groups   Name        Std.Dev.
##  nation   (Intercept) 0.53423 
##  Residual             1.10885
```

- Darstellung der Ergebnisse in `sjPlot`
  * gibt `ggplot` Objekt aus, sodass damit alle üblichen Anpassungen vorgenommen werden können



```r
library(sjPlot)
plot_model(mod0, type = 're', sort.est = '(Intercept)') +  # Plot für Random Effects (re), sortiert nach Schätzung (est) der Interzept ('(Intercept)')
  ggplot2::theme_minimal() # Layout
```

![](/workshops/kiju/lmm-intro_files/figure-html/caterpillar-mod0-1.png)<!-- -->

```r
# Breite der Fehlerbalken hängt mit Stichprobengröße zusammen
```

- Einzelne Werte abrufen (für weitere Verarbeitung)


```r
ranef(mod0)
```

```
## $nation
##             (Intercept)
## Turkey      -0.44818086
## Korea       -0.40503647
## Slovenia     0.56208695
## Nigeria     -0.17616391
## Japan       -0.56699431
## Chile        0.86978321
## China       -1.18650851
## Thailand    -0.45861364
## Australia    0.48105911
## Hong Kong   -0.21362638
## Iran        -0.48112865
## Greece       0.14584524
## Philippines  0.15297260
## Nepal       -0.58509359
## Cyprus       0.10940207
## Indonesia    0.10703558
## Mexico       0.58950252
## Belgium      0.48558728
## Portugal     0.35390197
## Uganda      -1.15522933
## Singapore   -0.34397158
## Netherlands  0.52671074
## Malaysia     0.29471140
## Georgia     -0.67191598
## Croatia      0.17087872
## Ghana       -0.20139742
## Bulgaria    -0.29096543
## Bangladesh   0.05749552
## Russia       0.05460689
## Slovakia    -0.12780524
## Zimbabwe    -0.09329670
## Germany      0.46822898
## Kuwait       0.10655340
## Columbia     0.49243158
## Brazil       0.46243395
## Cameroon    -0.91203076
## Canada       1.09983334
## India       -0.26631345
## S. Africa    0.52621827
## Austria      0.46699289
## 
## with conditional variances for "nation"
```

### ICC

$$
  ICC = \rho(y_{ij}, y_{i'j}) = \frac{var(u_{0j})}{var(y_{ij})} = \frac{\sigma^2_{u_{0j}}}{\sigma^2_{u_{0j}} + \sigma^2_{r_{ij}}}
$$

- händisch berechnen:


```r
tmp <- VarCorr(mod0) |> as.data.frame()
tmp$vcov[1] / sum(tmp$vcov)
```

```
## [1] 0.1883886
```

- in `jtools`


```r
library(jtools)
print(summ(mod0))
```

```
## MODEL INFO:
## Observations: 7163
## Dependent Variable: lezu
## Type: Mixed effects linear regression 
## 
## MODEL FIT:
## AIC = 21960.88, BIC = 21981.51
## Pseudo-R² (fixed effects) = 0.00
## Pseudo-R² (total) = 0.19 
## 
## FIXED EFFECTS:
## -------------------------------------------------------
##                     Est.   S.E.   t val.    d.f.      p
## ----------------- ------ ------ -------- ------- ------
## (Intercept)         4.40   0.09    51.23   39.05   0.00
## -------------------------------------------------------
## 
## p values calculated using Satterthwaite d.f.
## 
## RANDOM EFFECTS:
## ------------------------------------
##   Group      Parameter    Std. Dev. 
## ---------- ------------- -----------
##   nation    (Intercept)     0.53    
##  Residual                   1.11    
## ------------------------------------
## 
## Grouping variables:
## --------------------------
##  Group    # groups   ICC  
## -------- ---------- ------
##  nation      40      0.19 
## --------------------------
```
- Wenn $ICC > 0$, ist die Annahme der Unabhängigkeit verletzt und es wird ein Multilevel-Modell benötigt
- Wenn $ICC > 0$ können dennoch Gruppenunterschiede bzgl. der _Regressionsgewichte_ bestehen
- Häufig wird $ICC >.10$ als Cut-Off Kriterium gewertet
  * Schon bei kleinen Werten, kann Clusterung zur starken Überschätzung der Power führen
- Forschungsbereich Bildung und Organisationen:
  * klein:  .05, mittel: .10, groß: .15
- Forschungsbereich kleine Gruppen und Familien:
  * klein: .10, mittel: .20, groß: .30
- Generell: je größer die Gruppen desto kleiner ICC per Zufall
- Effektive Stichprobengröße:
$$ 
  n_{\text{eff}} = \frac{n}{1 + (n_{\text{clus}} - 1)ICC}
$$

## Level-1 Prädiktoren

### Random Intercept Model

**Level 1** 
$$ y_{ij} = \beta_{0j} + \beta_{1j}x_{ij} + r_{ij} $$

**Level 2**
$$ \beta_{0j} = \gamma_{00} + u_{0j} $$
$$ \beta_{1j} = \gamma_{10} $$


**Gesamtgleichung**
$$ y_{ij} = \gamma_{00} + \gamma_{10}x_{ij} + u_{0j} + r_{ij} $$

Vergleich der Parameterinterpretation:

- Nullmodell
  * $\gamma_{00}$ Erwartungswert der Gruppenerwartungswerte
  * $r_{ij}$ Abweichung eines individuellen Wertes vom jeweiligen Gruppenerwartungswert
  * $u_{0j}$ u0j Abweichung eines Gruppenerwartungswert vom Erwartungswert der Gruppenerwartungswerte
- Random Intercept Modell
  * $\gamma_{00}$ Mittleres Intercept
  * $r_{ij}$ Abweichung eines individuellen Wertes von der gruppenspezifische Regressionsgeraden bzw. vom vorhergesagten Wert
  * $u_{0j}$ Abweichung eines gruppenspezifischen Intercepts vom mittleren Intercept


- Modell in `lme4` Aufstellen


```r
mod1 <- lmer(lezu ~ 1 + pa + (1 | nation), kultur) # pa als Prädiktor zusätzlich aufnehmen
print(summ(mod1))
```

```
## MODEL INFO:
## Observations: 7141
## Dependent Variable: lezu
## Type: Mixed effects linear regression 
## 
## MODEL FIT:
## AIC = 20481.85, BIC = 20509.35
## Pseudo-R² (fixed effects) = 0.18
## Pseudo-R² (total) = 0.31 
## 
## FIXED EFFECTS:
## ---------------------------------------------------------
##                     Est.   S.E.   t val.      d.f.      p
## ----------------- ------ ------ -------- --------- ------
## (Intercept)         2.50   0.09    29.35     82.79   0.00
## pa                  0.35   0.01    39.64   7137.96   0.00
## ---------------------------------------------------------
## 
## p values calculated using Satterthwaite d.f.
## 
## RANDOM EFFECTS:
## ------------------------------------
##   Group      Parameter    Std. Dev. 
## ---------- ------------- -----------
##   nation    (Intercept)     0.44    
##  Residual                   1.00    
## ------------------------------------
## 
## Grouping variables:
## --------------------------
##  Group    # groups   ICC  
## -------- ---------- ------
##  nation      40      0.16 
## --------------------------
```


```r
coef(mod1)$nation['Canada',] # spezifische Koeffizienten für Kanada auswählen
```

```
##        (Intercept)        pa
## Canada    3.391403 0.3490583
```


```r
mod1b <- lmer(lezu ~ 1 + pa + (1 + pa | nation), kultur) # Random Intercept Random Slope Modell
```

```
## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl =
## control$checkConv, : Model failed to converge with
## max|grad| = 0.0036817 (tol = 0.002, component 1)
```

```r
summ(mod1b)
```

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
<tbody>
  <tr>
   <td style="text-align:left;font-weight: bold;"> Observations </td>
   <td style="text-align:right;"> 7141 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;"> Dependent variable </td>
   <td style="text-align:right;"> lezu </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;"> Type </td>
   <td style="text-align:right;"> Mixed effects linear regression </td>
  </tr>
</tbody>
</table> <table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
<tbody>
  <tr>
   <td style="text-align:left;font-weight: bold;"> AIC </td>
   <td style="text-align:right;"> 20440.39 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;"> BIC </td>
   <td style="text-align:right;"> 20481.63 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;"> Pseudo-R² (fixed effects) </td>
   <td style="text-align:right;"> 0.18 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;"> Pseudo-R² (total) </td>
   <td style="text-align:right;"> 0.32 </td>
  </tr>
</tbody>
</table> <table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0;">
 <thead>
<tr><th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="6"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Fixed Effects</div></th></tr>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> Est. </th>
   <th style="text-align:right;"> S.E. </th>
   <th style="text-align:right;"> t val. </th>
   <th style="text-align:right;"> d.f. </th>
   <th style="text-align:right;"> p </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;font-weight: bold;"> (Intercept) </td>
   <td style="text-align:right;"> 2.51 </td>
   <td style="text-align:right;"> 0.09 </td>
   <td style="text-align:right;"> 27.23 </td>
   <td style="text-align:right;"> 38.60 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;"> pa </td>
   <td style="text-align:right;"> 0.35 </td>
   <td style="text-align:right;"> 0.02 </td>
   <td style="text-align:right;"> 21.83 </td>
   <td style="text-align:right;"> 38.57 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
</tbody>
<tfoot><tr><td style="padding: 0; " colspan="100%">
<sup></sup>  p values calculated using Satterthwaite d.f. </td></tr></tfoot>
</table> <table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
<tr><th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="3"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Random Effects</div></th></tr>
  <tr>
   <th> Group </th>
   <th> Parameter </th>
   <th> Std. Dev. </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td> nation </td>
   <td> (Intercept) </td>
   <td> 0.47 </td>
  </tr>
  <tr>
   <td> nation </td>
   <td> pa </td>
   <td> 0.08 </td>
  </tr>
  <tr>
   <td> Residual </td>
   <td>  </td>
   <td> 1.00 </td>
  </tr>
</tbody>
</table> <table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
<tr><th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="3"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Grouping Variables</div></th></tr>
  <tr>
   <th> Group </th>
   <th> # groups </th>
   <th> ICC </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td> nation </td>
   <td> 40 </td>
   <td> 0.18 </td>
  </tr>
</tbody>
</table>


### Grafische Darstellung


```r
plot_model(mod1, type = 're', sort.est = '(Intercept)')
```

![](/workshops/kiju/lmm-intro_files/figure-html/caterpillar-mod1-1.png)<!-- -->

### Mehrere Prädiktoren

- *Übungsaufgabe*: positiven und negativen Affekt aufnehmen
  * Was ist bedeutsam in der Vorhersage der Lebenszufriedenheit?
  

```r
mod2 <- lmer(lezu ~ 1 + pa + na + (1 | nation), kultur)
print(summ(mod2))
```

```
## MODEL INFO:
## Observations: 7134
## Dependent Variable: lezu
## Type: Mixed effects linear regression 
## 
## MODEL FIT:
## AIC = 20140.59, BIC = 20174.96
## Pseudo-R² (fixed effects) = 0.21
## Pseudo-R² (total) = 0.34 
## 
## FIXED EFFECTS:
## ----------------------------------------------------------
##                      Est.   S.E.   t val.      d.f.      p
## ----------------- ------- ------ -------- --------- ------
## (Intercept)          3.34   0.10    35.04    137.11   0.00
## pa                   0.31   0.01    35.49   7130.58   0.00
## na                  -0.18   0.01   -18.45   7126.81   0.00
## ----------------------------------------------------------
## 
## p values calculated using Satterthwaite d.f.
## 
## RANDOM EFFECTS:
## ------------------------------------
##   Group      Parameter    Std. Dev. 
## ---------- ------------- -----------
##   nation    (Intercept)     0.43    
##  Residual                   0.98    
## ------------------------------------
## 
## Grouping variables:
## --------------------------
##  Group    # groups   ICC  
## -------- ---------- ------
##  nation      40      0.16 
## --------------------------
```


### Prüfung via Modellvergleich


```r
anova(mod0, mod1, mod2)
```

```
## Error in anova.merMod(mod0, mod1, mod2): models were not all fitted to the same size of dataset
```
- Fehlende Werte auf den UVs verändern Größe des Datensatzes


```r
kultur_comp <- mod2@frame
mod0_u <- update(mod0, data = kultur_comp)
mod1_u <- update(mod1, data = kultur_comp)
mod2_u <- update(mod2, data = kultur_comp)
```


```r
anova(mod0_u, mod1_u, mod2_u)
```

```
## refitting model(s) with ML (instead of REML)
```

```
## Data: kultur_comp
## Models:
## mod0_u: lezu ~ 1 + (1 | nation)
## mod1_u: lezu ~ 1 + pa + (1 | nation)
## mod2_u: lezu ~ 1 + pa + na + (1 | nation)
##        npar   AIC   BIC logLik deviance   Chisq Df
## mod0_u    3 21868 21889 -10931    21862           
## mod1_u    4 20453 20480 -10222    20445 1417.51  1
## mod2_u    5 20122 20156 -10056    20112  332.65  1
##        Pr(>Chisq)    
## mod0_u               
## mod1_u  < 2.2e-16 ***
## mod2_u  < 2.2e-16 ***
## ---
## Signif. codes:  
## 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### Random Slopes Modelle


**Level 1** 
$$ y_{ij} = \beta_{0j} + \beta_{1j}x_{1ij} + \beta_{2j}x_{2ij} + r_{ij} $$

**Level 2**
$$ \beta_{0j} = \gamma_{00} + u_{0j} $$
$$ \beta_{1j} = \gamma_{10} + u_{1j} $$
$$ \beta_{2j} = \gamma_{20} + u_{2j} $$

**Gesamtgleichung**
$$ y_{ij} = \gamma_{00} + \gamma_{10}x_{1ij} + \gamma_{20}x_{2ij} + u_{0j} + u_{1j}x_{1ij} + u_{2j}x_{2ij} + r_{ij} $$

```r
mod3 <- lmer(lezu ~ 1 + pa + na + (1 + pa + na | nation), kultur)
```

```
## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl =
## control$checkConv, : Model failed to converge with
## max|grad| = 0.00356468 (tol = 0.002, component 1)
```

- Fehlende Konvergenz des Modells
  * sehr kleine Zufallseffekte
  * sehr hohe Korrelationen zwischen Zufallseffekten
  * hohe Modellkomplexität
  * in jedem Fall: inhaltliche Diagnostik betreiben!


```r
# Optimizer wechseln, langsamer aber Versuch Konvergenz zu erreichen
opts <- lmerControl(optimizer = 'bobyqa')
mod3 <- lmer(lezu ~ 1 + pa + na + (1 + pa + na | nation), kultur, control = opts)
```


```r
print(summ(mod3))
```

```
## MODEL INFO:
## Observations: 7134
## Dependent Variable: lezu
## Type: Mixed effects linear regression 
## 
## MODEL FIT:
## AIC = 20092.97, BIC = 20161.69
## Pseudo-R² (fixed effects) = 0.21
## Pseudo-R² (total) = 0.35 
## 
## FIXED EFFECTS:
## --------------------------------------------------------
##                      Est.   S.E.   t val.    d.f.      p
## ----------------- ------- ------ -------- ------- ------
## (Intercept)          3.38   0.10    33.31   39.77   0.00
## pa                   0.31   0.01    21.44   37.36   0.00
## na                  -0.18   0.02   -11.26   35.54   0.00
## --------------------------------------------------------
## 
## p values calculated using Satterthwaite d.f.
## 
## RANDOM EFFECTS:
## ------------------------------------
##   Group      Parameter    Std. Dev. 
## ---------- ------------- -----------
##   nation    (Intercept)     0.46    
##   nation        pa          0.07    
##   nation        na          0.08    
##  Residual                   0.97    
## ------------------------------------
## 
## Grouping variables:
## --------------------------
##  Group    # groups   ICC  
## -------- ---------- ------
##  nation      40      0.18 
## --------------------------
```
- Gibt leider Korrelationen zwischen REs nicht aus


```r
summary(mod3)$varcor
```

```
##  Groups   Name        Std.Dev. Corr         
##  nation   (Intercept) 0.461843              
##           pa          0.068146 -0.201       
##           na          0.078971 -0.545 -0.170
##  Residual             0.972926
```

### Tests der Zufallseffekte


```r
anova(mod0, mod1) # Fehlermeldung, da Modelle auf den gleichen Datensatz angewandt werden müssen
```


```r
# Respezifizierung
mod0b <- update(mod0, data = mod1@frame)
mod1b <- update(mod1, data = mod1@frame)

anova(mod0b, mod1b)
```

```
## refitting model(s) with ML (instead of REML)
```

```
## Data: mod1@frame
## Models:
## mod0b: lezu ~ 1 + (1 | nation)
## mod1b: lezu ~ 1 + pa + (1 | nation)
##       npar   AIC   BIC logLik deviance  Chisq Df Pr(>Chisq)
## mod0b    3 21889 21909 -10941    21883                     
## mod1b    4 20471 20498 -10231    20463 1419.8  1  < 2.2e-16
##          
## mod0b    
## mod1b ***
## ---
## Signif. codes:  
## 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```



```r
anova(mod2, mod3, refit = FALSE)
```

```
## Data: kultur
## Models:
## mod2: lezu ~ 1 + pa + na + (1 | nation)
## mod3: lezu ~ 1 + pa + na + (1 + pa + na | nation)
##      npar   AIC   BIC logLik deviance  Chisq Df Pr(>Chisq)
## mod2    5 20141 20175 -10065    20131                     
## mod3   10 20093 20162 -10036    20073 57.625  5  3.758e-11
##         
## mod2    
## mod3 ***
## ---
## Signif. codes:  
## 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```


```r
confint(mod3)
```

```
##                   2.5 %      97.5 %
## .sig01       0.28803189  0.65838445
## .sig02      -0.59999696  0.41636426
## .sig03      -0.81112066 -0.04285697
## .sig04       0.04324943  0.09596252
## .sig05      -0.68676513  0.35625998
## .sig06       0.05101183  0.11042401
## .sigma       0.95705358  0.98925414
## (Intercept)  3.18096518  3.58486611
## pa           0.27964164  0.33677395
## na          -0.21457578 -0.15018436
```

### Cluster-spezifische Effekte 


```r
coef(mod3)
```

```
## $nation
##             (Intercept)        pa          na
## Turkey         3.079608 0.3240336 -0.15334413
## Korea          3.035651 0.3134756 -0.18870916
## Slovenia       4.175208 0.2567304 -0.21844995
## Nigeria        2.884774 0.2613938 -0.06944023
## Japan          3.348556 0.3633211 -0.30076712
## Chile          3.532361 0.3643897 -0.15439388
## China          2.598439 0.2457451 -0.12783823
## Thailand       3.244452 0.2347657 -0.15131070
## Australia      3.786808 0.3451122 -0.25063502
## Hong Kong      3.088845 0.3728188 -0.18464793
## Iran           3.025574 0.3631969 -0.20183313
## Greece         3.643419 0.2642848 -0.10956000
## Philippines    3.292682 0.3213366 -0.18554128
## Nepal          2.964934 0.3076757 -0.19683107
## Cyprus         3.678415 0.3042300 -0.18522187
## Indonesia      3.194256 0.3054313 -0.14505944
## Mexico         2.998794 0.3464554 -0.08919076
## Belgium        3.642759 0.3557331 -0.22231392
## Portugal       3.719619 0.3758924 -0.28584230
## Uganda         3.299329 0.2149195 -0.33049575
## Singapore      3.148669 0.3434949 -0.19295688
## Netherlands    3.598535 0.3259989 -0.12747586
## Malaysia       3.580539 0.2726055 -0.12509845
## Georgia        3.061731 0.2409628 -0.17861740
## Croatia        3.657428 0.3363807 -0.24157277
## Ghana          3.676626 0.2090378 -0.19710033
## Bulgaria       3.329737 0.2706613 -0.16330331
## Bangladesh     3.190195 0.3365806 -0.10865137
## Russia         3.444138 0.2978681 -0.14481125
## Slovakia       3.859749 0.2801991 -0.27383148
## Zimbabwe       3.340911 0.2964229 -0.18914435
## Germany        3.826814 0.3333657 -0.21541130
## Kuwait         3.378347 0.3747502 -0.24066897
## Columbia       2.904566 0.4045387 -0.12502961
## Brazil         3.720056 0.3164293 -0.20185956
## Cameroon       2.786753 0.1910107 -0.08125603
## Canada         3.953574 0.3682447 -0.22887872
## India          3.263557 0.2099855 -0.07876222
## S. Africa      3.590771 0.3093362 -0.18161229
## Austria        3.685437 0.3694096 -0.23295959
## 
## attr(,"class")
## [1] "coef.mer"
```


```r
plot_model(mod3, type = 're', grid = FALSE, sort.est = TRUE)[c(1,3)]
```

```
## [[1]]
```

![](/workshops/kiju/lmm-intro_files/figure-html/caterpillar-mod3-1.png)<!-- -->

```
## 
## [[2]]
```

![](/workshops/kiju/lmm-intro_files/figure-html/caterpillar-mod3-2.png)<!-- -->

## Level 2 Prädiktoren

### Im Random Intercept Modell

**Level 1** 
$$ y_{ij} = \beta_{0j} + \beta_{1j}x_{1ij} + \beta_{2j}x_{2ij} + r_{ij} $$

**Level 2**
$$ \beta_{0j} = \gamma_{00} + \gamma_{01} w_{j} + u_{0j} $$
$$ \beta_{1j} = \gamma_{10} $$
$$ \beta_{2j} = \gamma_{20} $$

**Gesamtgleichung**
$$ y_{ij} = \gamma_{00} + \gamma_{10}x_{1ij} + \gamma_{20}x_{2ij} + \gamma_{01} w_{j} + u_{0j} + r_{ij} $$
- Interpretation der Parameter
  * `(Intercept)` Erwarteter Lebenszufriedenheitswert für Menschen mit 0 positiven Affekt in einem Land mit 0 GDP
  * `pa`/`na` Unterschied zwischen Personen, die sich um eine Einheit im positiven/negativen Affekt unterscheiden, aber aus Ländern mit gleichem GDP kommen.
  * `gdp` Unterschied zwischen Personen mit gleichem positivem und negativen Affekt die aus Ländern mit 1 GDP Unterschied kommen


```r
mod4 <- lmer(lezu ~ 1 + pa + na + gdp + (1 | nation), kultur)
print(summ(mod4))
```

```
## MODEL INFO:
## Observations: 7134
## Dependent Variable: lezu
## Type: Mixed effects linear regression 
## 
## MODEL FIT:
## AIC = 20120.50, BIC = 20161.74
## Pseudo-R² (fixed effects) = 0.26
## Pseudo-R² (total) = 0.33 
## 
## FIXED EFFECTS:
## ----------------------------------------------------------
##                      Est.   S.E.   t val.      d.f.      p
## ----------------- ------- ------ -------- --------- ------
## (Intercept)          2.08   0.24     8.55     44.68   0.00
## pa                   0.31   0.01    35.70   7116.43   0.00
## na                  -0.18   0.01   -18.45   7128.77   0.00
## gdp                  1.72   0.32     5.45     38.61   0.00
## ----------------------------------------------------------
## 
## p values calculated using Satterthwaite d.f.
## 
## RANDOM EFFECTS:
## ------------------------------------
##   Group      Parameter    Std. Dev. 
## ---------- ------------- -----------
##   nation    (Intercept)     0.32    
##  Residual                   0.98    
## ------------------------------------
## 
## Grouping variables:
## --------------------------
##  Group    # groups   ICC  
## -------- ---------- ------
##  nation      40      0.10 
## --------------------------
```


### Zentrierung

- Effekte der L1 Prädiktoren sind Mischungen aus Individual- und Ländereffekten
- Allgemein CWC für die meisten L1 Prädiktoren empfohlen (mehr bei Enders & Tofighi, 2007, und Yaremych et al., 2021)


```r
cwc <- with(kultur, aggregate(cbind(pa, na) ~ nation, FUN = mean))
names(cwc) <- c('nation', 'pa_mean', 'na_mean')
kultur_cen <- merge(kultur, cwc, by = 'nation', all.x = TRUE)
```


```r
kultur$pa_cwc <- kultur$pa - kultur$pa_mean
kultur$na_cwc <- kultur$na - kultur$na_mean
```

- Modellterme verändern sich


```r
mod5 <- lmer(lezu ~ 1 + pa_mean + pa_cwc + na_mean + na_cwc + (1 | nation), kultur)
print(summ(mod5))
```

```
## MODEL INFO:
## Observations: 7134
## Dependent Variable: lezu
## Type: Mixed effects linear regression 
## 
## MODEL FIT:
## AIC = 20141.83, BIC = 20189.94
## Pseudo-R² (fixed effects) = 0.27
## Pseudo-R² (total) = 0.38 
## 
## FIXED EFFECTS:
## ----------------------------------------------------------
##                      Est.   S.E.   t val.      d.f.      p
## ----------------- ------- ------ -------- --------- ------
## (Intercept)          1.96   0.86     2.27     36.67   0.03
## pa_mean              0.63   0.12     5.25     36.45   0.00
## pa_cwc               0.31   0.01    35.24   7091.92   0.00
## na_mean             -0.27   0.15    -1.79     37.60   0.08
## na_cwc              -0.18   0.01   -18.42   7091.92   0.00
## ----------------------------------------------------------
## 
## p values calculated using Satterthwaite d.f.
## 
## RANDOM EFFECTS:
## ------------------------------------
##   Group      Parameter    Std. Dev. 
## ---------- ------------- -----------
##   nation    (Intercept)     0.40    
##  Residual                   0.98    
## ------------------------------------
## 
## Grouping variables:
## --------------------------
##  Group    # groups   ICC  
## -------- ---------- ------
##  nation      40      0.14 
## --------------------------
```
### Cross-Level Interaktion

**Level 1** 
$$ y_{ij} = \beta_{0j} + \beta_{1j}x_{1ij} + \beta_{2j}x_{2ij} + r_{ij} $$

**Level 2**
$$ \beta_{0j} = \gamma_{00} + \gamma_{01} w_{j} + u_{0j} $$
$$ \beta_{1j} = \gamma_{10} + \gamma_{11} w_{j}  + u_{1j} $$
$$ \beta_{2j} = \gamma_{20} + \gamma_{21} w_{j}  + u_{2j} $$

**Gesamtgleichung**
$$ y_{ij} = \gamma_{00} + \gamma_{10}x_{1ij} + \gamma_{20}x_{2ij} + \gamma_{01} w_{j} + \gamma_{11} w_{j}x_{1ij} + \gamma_{21} w_{j}x_{2ij} + u_{0j} + u_{1j}x_{1ij} + u_{2j}x_{2ij} + r_{ij} $$

Parameter | Bedeutung 
-- | ---------
$\gamma_{00}$ | Mittleres Intercept
$\gamma_{01}$ | Regressionsgewicht des L2-Prädiktors $w_j$ für den Random Intercept
$\gamma_{10}$ | Slope des L1-Prädiktors $x_{ij}$ für L2-Einheiten mit $w_j = 0$, $E(B_1 | W = 0)$
$\gamma_{11}$ | Veränderung von $\hat\beta_{ij}$ pro Einheit des L2-Prädiktors $w_j$
$u_{0j}$ | L2-Residuum bzgl. der Intercepts $(\beta_{0j} − \hat\beta_{0j})$
$u_{1j}$ | L2-Residuum bzgl. des Slopes  $(\beta_{1j} − \hat\beta_{1j})$
$r_{ij}$ | L1-Residuum $(y_{ij} − \hat y_{ij})$


```r
mod6 <- lmer(lezu ~ pa_cwc*gdp + na_cwc*gdp + pa_mean*gdp + na_mean*gdp + (pa_cwc + na_cwc | nation), kultur)
print(summ(mod6))
```

```
## MODEL INFO:
## Observations: 7134
## Dependent Variable: lezu
## Type: Mixed effects linear regression 
## 
## MODEL FIT:
## AIC = 20057.76, BIC = 20174.59
## Pseudo-R² (fixed effects) = 0.33
## Pseudo-R² (total) = 0.37 
## 
## FIXED EFFECTS:
## --------------------------------------------------------
##                      Est.   S.E.   t val.    d.f.      p
## ----------------- ------- ------ -------- ------- ------
## (Intercept)         -7.30   2.85    -2.56   35.31   0.01
## pa_cwc               0.15   0.06     2.50   41.71   0.02
## gdp                 12.81   3.96     3.24   36.46   0.00
## na_cwc              -0.03   0.07    -0.48   34.65   0.63
## pa_mean              0.90   0.39     2.33   33.18   0.03
## na_mean              1.53   0.43     3.52   37.09   0.00
## pa_cwc:gdp           0.21   0.08     2.56   42.39   0.01
## gdp:na_cwc          -0.21   0.09    -2.21   35.70   0.03
## gdp:pa_mean         -0.44   0.54    -0.81   34.12   0.42
## gdp:na_mean         -2.39   0.56    -4.27   38.05   0.00
## --------------------------------------------------------
## 
## p values calculated using Satterthwaite d.f.
## 
## RANDOM EFFECTS:
## ------------------------------------
##   Group      Parameter    Std. Dev. 
## ---------- ------------- -----------
##   nation    (Intercept)     0.22    
##   nation      pa_cwc        0.06    
##   nation      na_cwc        0.07    
##  Residual                   0.97    
## ------------------------------------
## 
## Grouping variables:
## --------------------------
##  Group    # groups   ICC  
## -------- ---------- ------
##  nation      40      0.05 
## --------------------------
```

```r
plot_model(mod6, 'pred', 
  terms = c('na_cwc', 'gdp'))
```

![](/workshops/kiju/lmm-intro_files/figure-html/unnamed-chunk-39-1.png)<!-- -->


```r
plot_model(mod6, 'est')
```

![](/workshops/kiju/lmm-intro_files/figure-html/unnamed-chunk-40-1.png)<!-- -->

