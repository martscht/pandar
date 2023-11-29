---
title: "Schätzung von Kausaleffekten 2"
date: '2022-02-07'
slug: kausaleffekte2_?
categories: ["KliPPs"]
tags: ["Kausalität", "Propensity Scores", "ANCOVA", "Gewichtung", "Matching"]
subtitle: 'Propensity Scores'
summary: ''
authors: [hartig]
weight: 10
lastmod: '2023-11-29'
featured: no
banner:
     image: "/header/dusk_or_dawn.jpg"
     caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/795494)"
projects: []

reading_time: false 
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/klipps/kausaleffekte2
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/klipps/kausaleffekte2.R
  - icon_pack: fas
    icon: pen-to-square
    name: Quizdaten
    url: /lehre/klipps/quizdaten#Block5
 
output:
  html_document:
    keep_md: true
---

#### Pakete laden

```r
# Benötigte Pakete --> Installieren, falls nicht schon vorhanden
library(psych)        # Für logistische Transformationen
library(ggplot2)      # Grafiken
library(gridExtra)
library(MatchIt)      # Für das Propensity Score Matching
```

### Inhalte 

* [Konstruktion des PS mittels logistischer Regression](#Konstruktion)
* [Propensity Score als Kontrollvariable](#ANCOVA)
* [Propensity Score Matching](#Matching)
* [Stratifizierung nach dem Propensity Score](#Stratifizierung)
* [Gewichtung mit dem Propensity Score](#Gewichtung)

## Datenbeispiel{#Einleitung}

Wir verwenden wieder unserer fiktives Datenbeispiel, in dem Patient\*innen, die an einer Depression oder einer Angststörung leiden, entweder mit einer kognitiven Verhaltenstherapie (CBT) behandelt oder in einer Wartekontrollgruppe belassen wurden. Die Zuordnung konnte nicht randomisiert erfolgen, weshalb der Effekt der Behandlung nicht ohne weiteres berechenbar ist.


```r
load(url("https://courageous-donut-84b9e9.netlify.app/post/CBTdata.rda"))
head(CBTdata)
```

<div class = "big-maths">
<table>
 <thead>
  <tr>
   <th style="text-align:right;"> Age </th>
   <th style="text-align:left;"> Gender </th>
   <th style="text-align:left;"> Treatment </th>
   <th style="text-align:left;"> Disorder </th>
   <th style="text-align:right;"> BDI_pre </th>
   <th style="text-align:right;"> SWL_pre </th>
   <th style="text-align:right;"> BDI_post </th>
   <th style="text-align:right;"> SWL_post </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> CBT </td>
   <td style="text-align:left;"> ANX </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 15 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> CBT </td>
   <td style="text-align:left;"> ANX </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 17 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> CBT </td>
   <td style="text-align:left;"> ANX </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 14 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> CBT </td>
   <td style="text-align:left;"> ANX </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> CBT </td>
   <td style="text-align:left;"> DEP </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 20 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> CBT </td>
   <td style="text-align:left;"> ANX </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
</tbody>
</table>
</div>



Wir wissen auch bereits, dass der Prima-Facie-Effekt (PFE) von 0.39 Punkten nicht signifikant ist. Im Folgenden werden wir auf Basis von Kovariaten einen Propensity Score schätzen und auf verschiedene Weisen verwenden, um eine adjustierte Schätzung des Treatment-Effekts vorzunehmen.

## Konstruktion des Propensity Scores{#Konstruktion}

Zur Bildung des Propensity Scores verwenden wir eine logistische Regression mit den Variablen, von denen wir bereits wissen, dass sich die Gruppen darin unterscheiden: Art der Störung, Prätest im BDI und Prätest im SWL:


```r
# Vorhersage des Treatments durch Kovariaten
mod_ps1 <- glm(Treatment ~ Disorder + BDI_pre + SWL_pre,
              family = "binomial", data = CBTdata)
summary(mod_ps1)
```

```
## 
## Call:
## glm(formula = Treatment ~ Disorder + BDI_pre + SWL_pre, family = "binomial", 
##     data = CBTdata)
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -0.89704    1.12602  -0.797  0.42565    
## DisorderDEP -0.77678    0.27580  -2.816  0.00486 ** 
## BDI_pre      0.16953    0.03750   4.520 6.18e-06 ***
## SWL_pre     -0.13763    0.03443  -3.998 6.39e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 449.86  on 325  degrees of freedom
## Residual deviance: 349.89  on 322  degrees of freedom
## AIC: 357.89
## 
## Number of Fisher Scoring iterations: 4
```

Wir sehen, dass alle Kovariaten auch bei gemeinsamer Berücksichtigung einen signifikanten Effekt auf die Treatment-Zugehörigkeit haben. Sicherheitshalber untersuchen wir auch die Wechselwirkungen:


```r
# Einschluss von Wechselwirkungen, hierzu zunächst Zentrierung der Prädiktoren
CBTdata$BDI_pre_c <- scale(CBTdata$BDI_pre, scale = F)
CBTdata$SWL_pre_c <- scale(CBTdata$SWL_pre, scale = F)

mod_ps2 <- glm(Treatment ~ Disorder + BDI_pre_c + SWL_pre_c +
                Disorder:BDI_pre_c + Disorder:SWL_pre_c + BDI_pre_c:SWL_pre_c +
                Disorder:BDI_pre_c:SWL_pre_c,
              family = "binomial", data = CBTdata)
summary(mod_ps2)
```

```
## 
## Call:
## glm(formula = Treatment ~ Disorder + BDI_pre_c + SWL_pre_c + 
##     Disorder:BDI_pre_c + Disorder:SWL_pre_c + BDI_pre_c:SWL_pre_c + 
##     Disorder:BDI_pre_c:SWL_pre_c, family = "binomial", data = CBTdata)
## 
## Coefficients:
##                                 Estimate Std. Error z value Pr(>|z|)    
## (Intercept)                      0.69555    0.20390   3.411 0.000647 ***
## DisorderDEP                     -0.82670    0.28607  -2.890 0.003854 ** 
## BDI_pre_c                        0.14802    0.05433   2.724 0.006446 ** 
## SWL_pre_c                       -0.13322    0.05650  -2.358 0.018378 *  
## DisorderDEP:BDI_pre_c            0.05187    0.07791   0.666 0.505586    
## DisorderDEP:SWL_pre_c           -0.03984    0.07692  -0.518 0.604514    
## BDI_pre_c:SWL_pre_c              0.01808    0.01161   1.557 0.119472    
## DisorderDEP:BDI_pre_c:SWL_pre_c -0.02353    0.01893  -1.243 0.213798    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 449.86  on 325  degrees of freedom
## Residual deviance: 345.66  on 318  degrees of freedom
## AIC: 361.66
## 
## Number of Fisher Scoring iterations: 4
```

Da keiner der Wechselwirkungs-Terme signifikant ist, verwenden wir im nächsten Schritt das einfachere Modell `mod_ps1`. Mit der `predict`-Funktion erhalten wir vorhergesagte Werte in Logit-Einheiten, mit der `logistic`-Funktion des `psych`-Pakets können wir diese in Wahrscheinlichkeiten transformieren:


```r
CBTdata$PS_logit <- predict(mod_ps1)
CBTdata$PS_P <- logistic(CBTdata$PS_logit)
plot(CBTdata$PS_logit, CBTdata$PS_P)
```

![](/lehre/klipps/kausaleffekte2_question_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

### Prüfung des Overlap

Die Unterschiede im resultierenden Propensity Score in Logit-Einheiten können wir uns durch eine grafische Darstellung der Verteilungen in den Gruppen veranschaulichen. Die Treatment-Wahrscheinlichkeit ist in der Treatment-Gruppe deutlich höher, was z.B. durch eine Selektion nach Dringlichkeit der Fälle zustande gekommen sein kann. Durch ein Abtragen der Treatment-Wahrscheinlichkeiten können wir zusätzlich veranschaulichen, wie groß die Überschneidungen der Gruppen (*common support*) sind. In dieser Grafik sind auch das Minimum der Wahrscheinlichkeit in der Treatment-Gruppe und das Maximum in der Kontrollgruppe eingetragen - diese definieren die Grenzen der Überschneidung zwischen den Gruppen.


```{.r .fold-hide}
## Overlap & Common Support ----
p1 <- ggplot(CBTdata, aes(x=PS_logit, fill = Treatment)) + 
  theme_bw() + theme(legend.position="top") +
  scale_fill_manual(values=c("#E69F00", "#56B4E9")) +
  geom_density(alpha=0.5)

p2 <- ggplot(CBTdata, aes(x=PS_P, fill = Treatment)) + 
  theme_bw() +
  labs(x="P(X=1)", y="") + xlim(c(0,1)) +
  scale_y_continuous(breaks=c(-1.5,1.5),     # "manuelle" Achsenbeschriftungen, um die Gruppen einzutragen
                     labels=c("CBT", "WL")) +
  geom_histogram(data = CBTdata[CBTdata$Treatment=="WL",], aes(y=..density..),   # Histogramm WL
                 alpha=0.5, fill="#E69F00") +
  geom_histogram(data = CBTdata[CBTdata$Treatment=="CBT",], aes(y=-..density..), # Histogramm CBT
                 alpha=0.5, fill="#56B4E9") +
  # Minimum in CBT und maximum in WL einzeichnen
  geom_vline(xintercept = c(min(CBTdata$PS_P[CBTdata$Treatment=="CBT"]),
                            max(CBTdata$PS_P[CBTdata$Treatment=="WL"])),
             linetype=2) +
  coord_flip()
grid.arrange(p1, p2, nrow=1) # Beide Plots nebeneinander
```

![](/lehre/klipps/kausaleffekte2_question_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

Für Fälle außerhalb der *common support region* können keine kausalen Effekte geschätzt werden. Wir schließen daher 16 Fälle aus, die außerhalb des Überschneidungsbereichs liegen:


```r
### Fälle außerhalb der Überschneidung ausschließen ----
# Fälle der Kontrollgruppe entfernen, deren Wahrscheinlichkeit kleiner ist als
# die kleinste Wahrscheinlichkeit in der Treatment-Gruppe
CBTdata <- CBTdata[!(CBTdata$Treatment=="WL" & 
                               CBTdata$PS_P < min(subset(CBTdata, Treatment=="CBT")$PS_P)),]
# Fälle der Treatment-Gruppe entfernen, deren Wahrscheinlichkeit größer ist als
# die größte Wahrscheinlichkeit in der Kontrollgruppe
CBTdata <- CBTdata[!(CBTdata$Treatment=="CBT" & 
                               CBTdata$PS_P > max(subset(CBTdata, Treatment=="WL")$PS_P)),]
```

Nach dieser Korrektur überlappen sich die Propensity Scores beider Gruppen vollständig:


```{.r .fold-hide}
## Overlap & Common Support nach Fallausschluss ----
p1 <- ggplot(CBTdata, aes(x=PS_logit, fill = Treatment)) + 
  theme_bw() + theme(legend.position="top") +
  scale_fill_manual(values=c("#E69F00", "#56B4E9")) +
  geom_density(alpha=0.5)

p2 <- ggplot(CBTdata, aes(x=PS_P, fill = Treatment)) + 
  theme_bw() +
  labs(x="P(X=1)", y="") + xlim(c(0,1)) +
  scale_y_continuous(breaks=c(-1.5,1.5),     # "manuelle" Achsenbeschriftungen, um die Gruppen einzutragen
                     labels=c("CBT", "WL")) +
  geom_histogram(data = CBTdata[CBTdata$Treatment=="WL",], aes(y=..density..),   # Histogramm WL
                 alpha=0.5, fill="#E69F00") +
  geom_histogram(data = CBTdata[CBTdata$Treatment=="CBT",], aes(y=-..density..), # Histogramm CBT
                 alpha=0.5, fill="#56B4E9") +
  coord_flip()
grid.arrange(p1, p2, nrow=1) # Beide Plots nebeneinander
```

![](/lehre/klipps/kausaleffekte2_question_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

## Verwendung des Propensity Score in der ANCOVA{#ANCOVA}

Wir können den Treatment-Effekt schätzen, indem wir den Propensity Score anstelle der ursprünglichen Kovariaten als Kontrollvariable verwenden. Wir vergleichen hier die klassische ANCOVA mit allen Kovariaten mit einem Modell, in dem nur der Propensity Score kontrolliert wird (Achtung: Aufgrund der Reduktion des Datensatzes entsprechen die Ergebnisse des 1. Modells nicht exakt [denen im ersten Teil dieses Blocks](/lehre/klipps/kausaleffekte1/#ANCOVA)!) Wir sehen, dass die auf beiden Wegen geschätzen Effekte praktisch identisch sind.


```r
BDI.adj <- lm(BDI_post ~ Treatment + Disorder + BDI_pre + SWL_pre, data = CBTdata)
round(coef(BDI.adj)[2],2)
```

```
## TreatmentCBT 
##        -4.08
```

```r
BDI.PS <- lm(BDI_post ~ Treatment + PS_logit, data = CBTdata)
round(coef(BDI.PS)[2],2)
```

```
## TreatmentCBT 
##        -4.15
```

## Propensity Score Matching{#Matching}

### Auswirkung der zulässigen Distanz

Matching können wir komfortabel mit der Funktion `matchit` aus dem Paket `MatchIt` durchführen. Mit Standard-Einstellungen wird als Methode zur Paarbildung ein "greedy nearest neighbor matching" verwendet, bei dem jedem Fall aus der Treatment-Gruppe nacheinander der ähnlichste Fall der Kontrollgruppe zugeordnet wird. Hier ist es wichtig, die Option `caliper` zu nutzen, um den zulässigen Höchstabstand zwischen den "Zwillingen" zu definieren (ausgedrückt in SD-Einheiten). Die folgende Grafik demonstriert den Effekt des caliper auf die Balance des Propensity Scores und auf die Anzahl der Fälle, die in der Analyse verbleiben. 

[*Abbildung: PS-Score-Dichte mit unterschiedlichen Werten für den caliper*]

### Kontrolle der Balance

Mit einem caliper von 0.1 wird in der obigen Grafik augenscheinlich schon eine recht gute Balance erreicht, so dass wir diesen Wert für die weiteren Analysen verwenden.


```r
PS.match <- matchit(Treatment ~ Disorder + BDI_pre + SWL_pre, method = "nearest",
                    data = CBTdata, link = "logit", caliper = 0.1)
```

```
## Warning: Fewer control units than treated units; not all treated units will get a match.
```

Die Balance hinsichtlich des Propensity Scores $\pi$ und die Lage der nicht-gepaarten Fälle lässt sich auch gut mit einem Plot der `matchit`-Funktion veranschaulichen. Wir sehen, dass vor allem Fälle der Kontrollgruppe mit niedriger und Fälle der Treatment-Gruppe mit hoher Treatment-Wahrscheinlichkeit vom Matching ausgeschlossen werden:


```r
plot(PS.match, type = "jitter", interactive = F)
```

![](/lehre/klipps/kausaleffekte2_question_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

Die `summary` des `matchit`-Objekts liefert detailierte Informationen zur Balance der einbezogenen Kovariaten. Wir sehen, dass die Differenzen in den Kovariaten sehr gut reduziert werden konnten. In der gematchten Stichprobe sind allerdings auch nur noch 168 (2 * 84) Fälle verblieben. 142 wurden ausgeschlossen, da sie nicht mit einem hinreichend ähnlichen Fall "gepaart" werden konnten.


```r
summary(PS.match)
```

```
## 
## Call:
## matchit(formula = Treatment ~ Disorder + BDI_pre + SWL_pre, data = CBTdata, 
##     method = "nearest", link = "logit", caliper = 0.1)
## 
## Summary of Balance for All Data:
##             Means Treated Means Control Std. Mean Diff. Var. Ratio eCDF Mean eCDF Max
## distance           0.6546        0.4140          1.2129     0.7774    0.2806   0.4689
## DisorderANX        0.6450        0.3191          0.6809          .    0.3258   0.3258
## DisorderDEP        0.3550        0.6809         -0.6809          .    0.3258   0.3258
## BDI_pre           23.6509       20.3546          0.8805     0.9477    0.1433   0.3627
## SWL_pre           15.0414       17.7872         -0.7177     0.9862    0.1262   0.3057
## 
## Summary of Balance for Matched Data:
##             Means Treated Means Control Std. Mean Diff. Var. Ratio eCDF Mean eCDF Max Std. Pair Dist.
## distance           0.5471        0.5370          0.0505     1.0724    0.0157   0.0595          0.0582
## DisorderANX        0.4881        0.4643          0.0498          .    0.0238   0.0238          0.6966
## DisorderDEP        0.5119        0.5357         -0.0498          .    0.0238   0.0238          0.6966
## BDI_pre           22.2262       22.0000          0.0604     1.2695    0.0233   0.0714          0.6710
## SWL_pre           16.2262       16.2262          0.0000     1.3760    0.0303   0.0952          3.1667
## 
## Sample Sizes:
##           Control Treated
## All           141     169
## Matched        84      84
## Unmatched      57      85
## Discarded       0       0
```

Eine grafische Zusammenfassung der Kovariaten-Balance lässt sich durch einen `plot` der `summary` des `matchit`-Objekts erzeugen. Auch hier sehen wir, dass die Balance zufriedenstellend ist:


```r
plot(summary(PS.match),
     var.order = "unmatched", abs = FALSE)
```

![](/lehre/klipps/kausaleffekte2_question_files/figure-html/unnamed-chunk-15-1.png)<!-- -->


### Effektschätzung

Um den ATT zu schätzen, wird mit der Funktion `match.data` der gematchte Datensatz aus dem `matchit`-Objekt gebildet. Mit diesem können wir ein einfaches lineares Modell zur Schätzung des Treatment-Effekts nutzen. Die Effektschätzung von -3.85 entspricht wieder recht gut den Ergebnissen, die wir mit anderen Methoden erhalten hatten.


```r
CBTdata.PSM <- match.data(PS.match)
BDI.match <- lm(BDI_post ~ Treatment, data = CBTdata.PSM)
summary(BDI.match)
```

```
## 
## Call:
## lm(formula = BDI_post ~ Treatment, data = CBTdata.PSM)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -13.667  -3.821   0.256   3.333  15.333 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   20.6667     0.5585  37.006  < 2e-16 ***
## TreatmentCBT  -3.8452     0.7898  -4.869  2.6e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 5.118 on 166 degrees of freedom
## Multiple R-squared:  0.125,	Adjusted R-squared:  0.1197 
## F-statistic:  23.7 on 1 and 166 DF,  p-value: 2.6e-06
```

## Stratifizierung{#Stratifizierung}

Stratifizierung ist als Methode `subclass` in der `matchit`-Funktion enthalten. Wir bilden fünf Strata und extrahieren den Datensatz, der die Zugehörigkeit zu den Strata enthält (Variable `subclass`). Die Kreuztabelle zeigt, dass die Strata so gebildet wurden, dass die Treatment-Gruppe gleichmäßig aufgeteilt wurde. Die Anzahl der jeweils "passenden" Kontrollgruppen-Fälle in den Strata unterscheidet sich stark.


```r
PS.strat <- matchit(Treatment ~ Disorder + BDI_pre + SWL_pre, data = CBTdata,
                 distance = 'logit', method = 'subclass', subclass = 5)
CBTdata.strat <- match.data(PS.strat)
# Zugehörigkeit der Fälle zu Treatment und Stratum
table(CBTdata.strat$Treatment, CBTdata.strat$subclass)
```

```
##      
##        1  2  3  4  5
##   WL  91 21 15  7  7
##   CBT 34 34 33 33 35
```

Die folgende Grafik veranschaulicht die gebildeten Strata, als Grenzen sind jeweils die Untergrenzen (Minima in den Gruppen) eingezeichnet:


```{.r .fold-hide}
ggplot(CBTdata.strat, aes(x=distance, fill = Treatment)) + 
  theme_bw() + theme(text = element_text(size = 20)) +
  labs(x="P(X=1)", y="") +
  scale_y_continuous(breaks=c(-1.5,1.5),     # "manuelle" Achsenbeschriftungen, um die Gruppen einzutragen
                     labels=c("CBT", "WL")) +
  geom_histogram(data = CBTdata.strat[CBTdata.strat$Treatment=="WL",], aes(y=..density..),   # Histogramm WL
                 alpha=0.5, fill="#E69F00") +
  geom_histogram(data = CBTdata.strat[CBTdata.strat$Treatment=="CBT",], aes(y=-..density..), # Histogramm CBT
                 alpha=0.5, fill="#56B4E9") +
  coord_flip() +
  geom_vline(xintercept = aggregate(CBTdata.strat$distance, by=list(CBTdata.strat$subclass), FUN=min)$x[2:5],
             linetype=2) +
  coord_flip()
```

![](/lehre/klipps/kausaleffekte2_question_files/figure-html/unnamed-chunk-18-1.png)<!-- -->





Den Treatment-Effekt berechnen wir hier jetzt "per Hand". Die Funktion `tapply` wird hierbei benutzt, um die Mittelwerte von Treatment- und Kontrollgruppe in den Strata zu berechnen, diese werden dann als Schätzer für $Y^0$ und $Y^1$ verwendet, aus ihrer Differenz ergibt sich der ATT innerhalb jedes Stratum. 
Für jedes Stratum wird anhand des Anteils der Fälle an der Gesamtstichprobe ein Gewichtungsfaktor berechtet. Der ATT ergibt sich dann als gewichtete Summe der Effekte innerhalb der Strata. Wir erhalten hier mit -3.51 einen geringfügig geringeren Effekt als bei anderen Methoden.


```r
##ATEs in den Strata berechnen und als neuen Datensatz
MWs <- tapply(CBTdata.strat$BDI_post, list(CBTdata.strat$subclass, CBTdata.strat$Treatment), mean)
MWW <- data.frame(Y0 = MWs[, 1], Y1 = MWs[, 2], ATEq = MWs[, 2]-MWs[, 1])
MWW
```

```
##         Y0       Y1      ATEq
## 1 16.18681 14.52941 -1.657401
## 2 21.57143 15.61765 -5.953782
## 3 21.46667 18.57576 -2.890909
## 4 23.28571 19.66667 -3.619048
## 5 29.00000 22.54286 -6.457143
```

```r
##Gesamt-ATE als gewichtetes Mittel über die Strata berechnen 
MWW$Wq <- tabulate(CBTdata.strat$subclass)/nrow(CBTdata.strat) # Anteil des Stratum an der Stichprobe
# Gesamteffekt als gewichtete Summe:
sum(MWW$Wq*MWW$ATEq)
```

```
## [1] -3.51406
```


## Gewichtung mit dem Propensity Score{#Gewichtung}

Gewichte konstruieren wir auf Basis der Propensity Scores $\pi$ und der Treatmentgruppen-Zugehörigkeit $X \in \{0,1\}$ nach der Formel

$$\frac{X_i}{\pi_i}+\frac{1-X_i}{1-\pi_i}$$


```r
# mit (CBTdata$Treatment=="CBT")*1 wird Treatment numerisch mit 1, Kontrollgruppe mit 0 kodiert
CBTdata$ps_w <- (CBTdata$Treatment=="CBT")*1/CBTdata$PS_P + (1 - (CBTdata$Treatment=="CBT")*1)/(1 - CBTdata$PS_P)
```

Diese Gewichte können in der `lm`-Funktion verwendet werden, um eine Schätzung mittels *weighted least squares* (WLS) vorzunehmen. Hierbei erhalten wir mit einem geschätzten Treatment-Effekt von -5.08 eine etwas "optimistischere" Schätzung als mit den anderen Methoden.


```r
BDI.weighted <- lm(BDI_post ~ Treatment, data = CBTdata, weights = ps_w)
summary(BDI.weighted)
```

```
## 
## Call:
## lm(formula = BDI_post ~ Treatment, data = CBTdata, weights = ps_w)
## 
## Weighted Residuals:
##     Min      1Q  Median      3Q     Max 
## -24.514  -6.297  -0.823   3.910  54.230 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   21.7474     0.4601  47.263  < 2e-16 ***
## TreatmentCBT  -5.0833     0.6617  -7.682  2.1e-13 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 8.391 on 308 degrees of freedom
## Multiple R-squared:  0.1608,	Adjusted R-squared:  0.1581 
## F-statistic: 59.01 on 1 and 308 DF,  p-value: 2.104e-13
```

***


