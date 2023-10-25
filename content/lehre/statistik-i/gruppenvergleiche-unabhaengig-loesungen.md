---
title: "Tests für unabhängige Stichproben - Lösungen" 
type: post
date: '2022-12-09' 
slug: gruppenvergleiche-unabhaengig-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [koehler, buchholz, goldhammer] 
lastmod: '2023-10-25'
featured: no
banner:
  image: "/header/BSc2_test_unabh_stpr.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/662606)"
projects: []
expiryDate: '2024-10-10'
publishDate: '2023-12-17'
_build:
  list: never
reading_time: false
share: false
output:
  html_document:
    keep_md: true
---




**Daten einlesen**


```r
load(url('https://pandar.netlify.app/daten/fb22.rda')) 
```

**Daten aufbereiten**

Prüfe zunächst, ob die Variablen Faktoren sind.


```r
is.factor(fb22$fach)
```

```
## [1] FALSE
```

```r
is.factor(fb22$ort)
```

```
## [1] FALSE
```

```r
is.factor(fb22$geschl)
```

```
## [1] FALSE
```

Falls nicht:


```r
# Lieblingsfach als Faktor - falls es noch keiner war
fb22$fach <- factor(fb22$fach, 
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung',
                               'Klinische', 'Diag./Meth.'))

# Wohnort als Faktor - falls es noch keiner war
fb22$ort <- factor(fb22$ort, 
                   levels = c(1, 2),
                   labels = c('Frankfurt', 'anderer'))


# Geschlecht als Faktor - falls es noch keiner war
fb22$geschl <- factor(fb22$geschl, 
                      levels=c(1,2,3), 
                      labels=c('weiblich', 'maennlich', 'anderes'))
```

***

## Aufgabe 1
Unterscheiden sich Studierende, die sich für Allgemeine Psychologie (Variable "fach") interessieren, im Persönlichkeitsmerkmal Intellekt (auch: Offenheit für neue Erfahrungen, "intel") von Studierenden, die sich für Klinische Psychologie interessieren? Normalverteilung des Merkmals in der Population darf angenommen werden. 

<details><summary>Lösung</summary>
**Deskriptivstatistische Beantwortung der Fragestellung: grafisch**

```r
data1 <- fb22[ (which(fb22$fach=="Allgemeine"|fb22$fach=="Klinische")), ]
data1$fach <- droplevels(data1$fach)
boxplot(data1$intel ~ data1$fach,
        xlab="Interessenfach", ylab="Intellekt", 
        las=1, cex.lab=1.5, 
        main="Interessenfach und Intellekt")
```

![](/lehre/statistik-i/gruppenvergleiche-unabhaengig-loesungen_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

**Deskriptivstatistische Beantwortung der Fragestellung: statistisch**


```r
# Überblick

library(psych)
describeBy(data1$intel, data1$fach)
```

```
## 
##  Descriptive statistics by group 
## group: Allgemeine
##    vars  n mean   sd median trimmed  mad min max range skew kurtosis   se
## X1    1 19 3.79 0.48   3.75    3.76 0.37   3   5     2 0.59     0.08 0.11
## ------------------------------------------------------------- 
## group: Klinische
##    vars  n mean   sd median trimmed  mad  min  max range  skew kurtosis   se
## X1    1 57 3.54 0.63   3.75    3.56 0.37 1.75 4.75     3 -0.63     0.34 0.08
```

```r
# Berechnung der empirischen Standardabweichung

intel.A <- data1$intel[(data1$fach=="Allgemeine")]
sigma.A <- sd(intel.A)
n.A <- length(intel.A[!is.na(intel.A)])
sd.A <- sigma.A * sqrt((n.A-1) / n.A)
sd.A 
```

```
## [1] 0.4677997
```

```r
intel.B <- data1$intel[(data1$fach=="Klinische")]
sigma.B <- sd(intel.B)
n.B <- length(intel.B[!is.na(intel.B)])
sd.B <- sigma.B * sqrt((n.B-1) / n.B)
sd.B
```

```
## [1] 0.6255499
```

Mittelwert der Allgemeinen Psychologen (_M_ = 3.79, _SD_ = 0.47) unterscheidet sich deskriptivstatistisch vom Mittelwert der Klinischen (_M_ = 3.54, _SD_ = 0.63).


**Voraussetzungsprüfung: Normalverteilung**

Nicht nötig, da Normalverteilung in Population angenommen werden darf (s. Aufgabenstellung).

**Hypothesen**

* Art des Effekts: Unterschiedshypothese  
* Richtung des Effekts: Ungerichtet $\rightarrow$ ungerichtete Hypothesen  
* Größe des Effekts: Unspezifisch  

Hypthesenpaar (statistisch):  

* $H_0$: $\mu_\text{Allgemeine} =   \mu_\text{Klinische}$
* $H_1$: $\mu_\text{Allgemeine} \ne \mu_\text{Klinische}$

**Spezifikation des Signifikanzniveaus** 

$\alpha = .05$

**Voraussetzungsprüfung: Varianzhomogenität**


```r
library(car)
leveneTest(data1$intel ~ data1$fach)
```

```
## Levene's Test for Homogeneity of Variance (center = median)
##       Df F value Pr(>F)
## group  1  1.3813 0.2437
##       74
```


_F_(1, 74) = 1.38, _p_ = 0.244 $\rightarrow$ Das Ergebnis ist nicht signifikant, die $H_0$ wird beibehalten und Varianzhomogenität angenommen.

**Durchführung des _t_-Tests**


```r
t.test(data1$intel ~ data1$fach,           # abhängige Variable ~ unabhängige Variable
       paired = F,                   # Stichproben sind unabhängig 
       alternative = "two.sided",         # zweiseitige Testung
       var.equal = T,                # Varianzhomogenität ist gegeben (-> Levene-Test)
       conf.level = .95)             # alpha = .05 
```

```
## 
## 	Two Sample t-test
## 
## data:  data1$intel by data1$fach
## t = 1.6058, df = 74, p-value = 0.1126
## alternative hypothesis: true difference in means between group Allgemeine and group Klinische is not equal to 0
## 95 percent confidence interval:
##  -0.0612611  0.5700330
## sample estimates:
## mean in group Allgemeine  mean in group Klinische 
##                 3.789474                 3.535088
```



**Formales Berichten des Ergebnisses**

Es wurde untersucht, ob sich Studierende, die sich für Allgemeine Psychologie interessieren, im Persönlichkeitsmerkmal 'Intellekt' (auch: Offenheit für neue Erfahrungen) von Studierenden, die sich für Klinische Psychologie interessieren, unterscheiden. Deskriptiv liegt ein solcher Unterschied vor: Die Mittelwerte betragen 3.79 (Allgemeine, _SD_ = 0.47) und 3.54 (Klinische, _SD_ = 0.63). Der entsprechende _t_-Test zeigt jedoch ein nicht signifikantes Ergebnis (_t_(_df_ = 74, zweis.) = 1.61, _p_ = 0.113). Die Nullhypothese konnte nicht verworfen werden und wird beibehalten. Die Studierenden sind im Persönlichkeitsmerkmal 'Intellekt' unabhängig davon, ob sie sich für Allgemeine Psychologie oder für Klinische Psychologie interessieren.

</details>

## Aufgabe 2
Sind Studierende, die außerhalb von Frankfurt wohnen ("ort"), unzufriedener im Leben ("lz") als diejenigen, die innerhalb von Frankfurt wohnen?  

<details><summary>Lösung</summary>
**Deskriptivstatistische Beantwortung der Fragestellung: grafisch**


```r
boxplot(fb22$lz ~ fb22$ort,
        xlab="Wohnort", ylab="Lebenszufriedenheit", 
        las=1, cex.lab=1.5, 
        main="Wohnort und Lebenszufriedenheit")
```

![](/lehre/statistik-i/gruppenvergleiche-unabhaengig-loesungen_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

**Deskriptivstatistische Beantwortung der Fragestellung: statistisch**


```r
library(psych)
describeBy(fb22$lz, fb22$ort)
```

```
## 
##  Descriptive statistics by group 
## group: Frankfurt
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 95  4.8 1.15      5     4.9 1.19 1.4 6.6   5.2 -0.77     0.14 0.12
## ------------------------------------------------------------- 
## group: anderer
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 53 4.68 0.91    4.8    4.75 0.89   2 6.2   4.2 -0.73     0.19 0.13
```

```r
summary(fb22[which(fb22$ort=="Frankfurt"), "lz"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##     1.4     4.2     5.0     4.8     5.7     6.6       1
```

```r
summary(fb22[which(fb22$ort=="anderer"), "lz"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##   2.000   4.200   4.800   4.683   5.400   6.200       1
```



Mittelwert der Nicht-Frankfurter:innen ist deskriptiv niedriger als der der Frankfurter:innen.

**Voraussetzungsprüfung: Normalverteilung**


```r
par(mfrow=c(1,2))
lz.F <- fb22[which(fb22$ort=="Frankfurt"), "lz"]
hist(lz.F, xlim=c(1,9), ylim=c(0,.5), main="Lebenzufriedenheit\n(Frankfurter)", xlab="", ylab="", las=1, prob=T)
curve(dnorm(x, mean=mean(lz.F, na.rm=T), sd=sd(lz.F, na.rm=T)), col="red", lwd=2, add=T)
qqnorm(lz.F)
qqline(lz.F, col="red")
```

<img src="/lehre/statistik-i/gruppenvergleiche-unabhaengig-loesungen_files/figure-html/unnamed-chunk-13-1.png" style="display: block; margin: auto;" />

$\rightarrow$ Entscheidung: Normalverteilung wird nicht angenommen


```r
par(mfrow=c(1,2))
lz.a <- fb22[which(fb22$ort=="anderer"), "lz"]
hist(lz.a, xlim=c(1,9), main="Lebenszufriedenheit\n(Nicht-Frankfurter)", xlab="", ylab="", las=1, prob=T)
curve(dnorm(x, mean=mean(lz.a, na.rm=T), sd=sd(lz.a, na.rm=T)), col="red", lwd=2, add=T)
qqnorm(lz.a)
qqline(lz.a, col="red")
```

<img src="/lehre/statistik-i/gruppenvergleiche-unabhaengig-loesungen_files/figure-html/unnamed-chunk-14-1.png" style="display: block; margin: auto;" />

$\rightarrow$ Entscheidung: Normalverteilung wird nicht angenommmen 


**Hypothesen**

* Art des Effekts: Unterschiedshypothese  
* Richtung des Effekts: Gerichtet $\rightarrow$ gerichtete Hypothesen  
* Größe des Effekts: Unspezifisch  

Hypthesenpaar (statistisch):  

* $H_0$: $\eta_\text{Frankfurter} \le \eta_\text{nicht-Frankfurter}$  
* $H_1$: $\eta_\text{Frankfurter} >   \eta_\text{nicht-Frankfurter}$

**Spezifikation des Signifikanzniveaus**

$\alpha = .05$

**Durchführung des Wilcoxon-Tests**


```r
wilcox.test(fb22$lz ~ fb22$ort,           # abhängige Variable ~ unabhängige Variable
       paired = F,                   # Stichproben sind unabhängig 
       alternative = "greater",         # einseitige Testung: Gruppe1 (Frankfurter:innen) > Gruppe2 (Nicht-Frankfurter:innen) 
       conf.level = .95)             # alpha = .05 
```

```
## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  fb22$lz by fb22$ort
## W = 2775, p-value = 0.1515
## alternative hypothesis: true location shift is greater than 0
```



**Formales Berichten des Ergebnisses** 

Es wurde untersucht, ob außerhalb von Frankfurt wohnende Studierende unzufriedener im Leben sind als die in Frankfurt wohnenden. Deskriptiv  zeigt sich das erwartete Muster: die Nicht-Frankfurter:innen sind weniger zufrieden (_Mdn_ = 4.8, _IQB_ = [4.2 ; 5.4]) als die Frankfurter:innen (_Mdn_ = 5, _IQB_ = [4.2 ; 5.7]). Jedoch ist das Ergebnis des einseitigen Wilcoxon-Tests nicht signifikant (_W_ = 2775, _p_ = 0.151). Die Nullhypothese konnte nicht verworfen werden und wird beibehalten. 


</details>

## Aufgabe 3
Ist die Wahrscheinlichkeit dafür, innerhalb von Frankfurt zu wohnen, die gleiche für weibliche wie für männliche Erstsemester-Studierende der Psychologie?

<details><summary>Lösung</summary>
Beide Variablen sind nominalskaliert $\rightarrow \chi^2$-Test

**Voraussetzungen**  

1. Die einzelnen Beobachtungen sind voneinander unabhängig $\rightarrow$ ok
2. Jede Person lässt sich eindeutig einer Kategorie bzw. Merkmalskombination zuordnen $\rightarrow$ ok
3. Zellbesetzung für alle $n_{ij}$ > 5 $\rightarrow$ Prüfung anhand von Häufigkeitstabelle 


```r
fb22$geschlecht <- fb22$geschl
fb22$geschlecht[fb22$geschlecht=="anderes"] <- NA #Umkodieren von "anderes" in fehlenden Wert
fb22$geschlecht <- droplevels(fb22$geschlecht) #Level "anderes" wird eliminiert
tab <- table(fb22$geschlecht, fb22$ort)
tab
```

```
##            
##             Frankfurt anderer
##   weiblich         79      46
##   maennlich        15       8
```

$\rightarrow n_{ij}$ > 5 in allen Zellen gegeben

**Hypothesen**

* Art des Effekts: Zusammenhangshypothese
* Richtung des Effekts: Ungerichtet
* Größe des Effekts: Unspezifisch

Hyothesenpaar (inhaltlich):  

* $H_0$: Weibliche und männliche Studierende der Psychologie wohnen mit gleicher Wahrscheinlichkeit innerhalb bzw. außerhalb von Frankfurt.  
* $H_1$: Weibliche und männliche Studierende der Psychologie unterscheiden sich in der Wahrscheinlichkeit, innerhalb bzw. außerhalb von Frankfurt zu wohnen.  

Hypothesenpaar (statistisch):  

* $H_0$: $\pi_{ij} =    \pi_{i\bullet} \cdot \pi_{\bullet j}$  
* $H_1$: $\pi_{ij} \neq \pi_{i\bullet} \cdot \pi_{\bullet j}$ 

**Durchführung des $\chi^2$-Test in R**


```r
chisq.test(tab, correct=FALSE)
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  tab
## X-squared = 0.034116, df = 1, p-value = 0.8535
```



$\chi^2$ = 0.034, df = 1, _p_ = 0.853 $\rightarrow H_0$

**Effektstärke Phi ($\phi$)**


```r
library(psych)
phi(tab)
```

```
## [1] -0.02
```

**Ergebnisinterpretation**

Es wurde untersucht, ob sich männliche und weibliche Studierende in ihrem Wohnort (Frankfurt vs. außerhalb) unterscheiden. Zur Beantwortung der Fragestellung wurde ein Vierfelder-Chi-Quadrat-Test für unabhängige Stichproben berechnet. Der Zusammenhang zwischen Wohnort und Geschlecht ist nicht signifikant ($\chi^2$(1) = 0.034, _p_ = 0.853), somit wird die Nullhypothese beibehalten. Der Effekt ist von vernachlässigbarer Stärke ($\phi$ = -0.02). Männliche und weibliche Studierende wohnen also mit gleicher Wahrscheinlichkeit in Frankfurt bzw. außerhalb von Frankfurt.

</details>

