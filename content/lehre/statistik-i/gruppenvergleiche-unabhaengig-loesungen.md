---
title: "Tests für unabhängige Stichproben - Lösungen" 
type: post
date: '2023-11-22' 
slug: gruppenvergleiche-unabhaengig-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [koehler, buchholz, goldhammer] 
lastmod: '2025-02-07'
featured: no
banner:
  image: "/header/writing_math.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/662606)"
projects: []
expiryDate: ''
publishDate: ''
_build:
  list: never
reading_time: false
share: false
output:
  html_document:
    keep_md: true
---




## Vorbereitung

> Laden Sie zunächst den Datensatz `fb24` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb24.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/gruppenvergleiche-unabhaengig/#prep) vorausgesetzt werden, teils inklusive derer, die erst im Beitrag vorgenommen werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

**Datenaufbereitung**


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

***

## Aufgabe 1
Unterscheiden sich Studierende, die sich für Allgemeine Psychologie (Variable "fach") interessieren, im Persönlichkeitsmerkmal Offenheit für neue Erfahrungen (auch Intellekt, "offen") von Studierenden, die sich für Klinische Psychologie interessieren? Normalverteilung des Merkmals in der Population darf angenommen werden. 

<details><summary>Lösung</summary>

**Deskriptivstatistische Beantwortung der Fragestellung: grafisch**


```r
data1 <- fb24[ (which(fb24$fach=="Allgemeine"|fb24$fach=="Klinische")), ]
data1$fach <- droplevels(data1$fach)
boxplot(data1$offen ~ data1$fach,
        xlab="Interessenfach", ylab="Offenheit für neue Erfahrungen", 
        las=1, cex.lab=1.5, 
        main="Interessenfach und Offenheit")
```

![](/gruppenvergleiche-unabhaengig-loesungen_files/unnamed-chunk-2-1.png)<!-- -->


**Deskriptivstatistische Beantwortung der Fragestellung: statistisch**



```r
# Überblick

library(psych)
describeBy(data1$offen, data1$fach)
```

```
## 
##  Descriptive statistics by group 
## group: Allgemeine
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 41 3.78 1.04      4    3.86 1.48 1.5   5   3.5 -0.54    -0.89 0.16
## ---------------------------------------------------------------------------- 
## group: Klinische
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 88 3.95 0.88      4    4.04 0.74   1   5     4 -0.94     0.72 0.09
```

```r
# Berechnung der empirischen Standardabweichung, da die Funktion describeBy() nur Populationsschätzer für Varianz und Standardabweichung berichtet

offen.A <- data1$offen[(data1$fach=="Allgemeine")]
sigma.A <- sd(offen.A)
n.A <- length(offen.A[!is.na(offen.A)])
sd.A <- sigma.A * sqrt((n.A-1) / n.A)
sd.A 
```

```
## [1] 1.02439
```

```r
offen.B <- data1$offen[(data1$fach=="Klinische")]
sigma.B <- sd(offen.B)
n.B <- length(offen.B[!is.na(offen.B)])
sd.B <- sigma.B * sqrt((n.B-1) / n.B)
sd.B
```

```
## [1] 0.872691
```

Mittelwert der Allgemeinen Psychologen (_M_ = 3.78, _SD_ = 1.02) unterscheidet sich deskriptivstatistisch vom Mittelwert der Klinischen (_M_ = 3.95, _SD_ = 0.87).


**Voraussetzungsprüfung: Normalverteilung**

Nicht nötig, da Normalverteilung in der Population angenommen werden darf (s. Aufgabenstellung). 

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
leveneTest(data1$offen ~ data1$fach)
```

```
## Levene's Test for Homogeneity of Variance (center = median)
##        Df F value Pr(>F)
## group   1  2.6563 0.1056
##       127
```

```r
levene <- leveneTest(data1$offen ~ data1$fach)
f <- round(levene$`F value`[1], 2)
p <- round(levene$`Pr(>F)`[1], 3)
```

_F_(1, 127) = 2.66, _p_ = 0.106 $\rightarrow$ Das Ergebnis ist nicht signifikant, die $H_0$ wird beibehalten und Varianzhomogenität angenommen.

**Durchführung des _t_-Tests**


```r
t.test(data1$offen ~ data1$fach,           # abhängige Variable ~ unabhängige Variable
       #paired = F,                   # Stichproben sind unabhängig 
       alternative = "two.sided",         # zweiseitige Testung
       var.equal = T,                # Varianzhomogenität ist gegeben (-> Levene-Test)
       conf.level = .95)             # alpha = .05 
```

```
## 
## 	Two Sample t-test
## 
## data:  data1$offen by data1$fach
## t = -0.95661, df = 127, p-value = 0.3406
## alternative hypothesis: true difference in means between group Allgemeine and group Klinische is not equal to 0
## 95 percent confidence interval:
##  -0.5166728  0.1799211
## sample estimates:
## mean in group Allgemeine  mean in group Klinische 
##                 3.780488                 3.948864
```



**Formales Berichten des Ergebnisses**

Es wurde untersucht, ob sich Studierende, die sich für Allgemeine Psychologie interessieren, im Persönlichkeitsmerkmal Offenheit für neue Erfahrungen von Studierenden, die sich für Klinische Psychologie interessieren, unterscheiden. Deskriptiv liegt ein solcher Unterschied vor: Die Mittelwerte betragen 3.78 (Allgemeine, _SD_ = 1.02) und 3.95 (Klinische, _SD_ = 0.87). Der entsprechende _t_-Test zeigt jedoch ein nicht signifikantes Ergebnis (_t_(_df_ = 127, zweis.) = -0.96, _p_ = 0.341). Die Nullhypothese konnte nicht verworfen werden und wird beibehalten. Die Studierenden sind im Persönlichkeitsmerkmal 'Offenheit für neue Erfahrungen' unabhängig davon, ob sie sich für Allgemeine Psychologie oder für Klinische Psychologie interessieren.

</details>

## Aufgabe 2
Sind Studierende, die außerhalb von Frankfurt wohnen ("ort"), zufriedener im Leben ("lz") als diejenigen, die innerhalb von Frankfurt wohnen?  

<details><summary>Lösung</summary>

**Deskriptivstatistische Beantwortung der Fragestellung: grafisch**


```r
boxplot(fb24$lz ~ fb24$ort,
        xlab="Wohnort", ylab="Lebenszufriedenheit", 
        las=1, cex.lab=1.5, 
        main="Wohnort und Lebenszufriedenheit")
```

![](/gruppenvergleiche-unabhaengig-loesungen_files/unnamed-chunk-8-1.png)<!-- -->

**Deskriptivstatistische Beantwortung der Fragestellung: statistisch**


```r
library(psych)
describeBy(fb24$lz, fb24$ort)
```

```
## 
##  Descriptive statistics by group 
## group: FFM
##    vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 112 4.89 1.17      5    4.96 1.19   2   7     5 -0.49     -0.4 0.11
## ---------------------------------------------------------------------------- 
## group: anderer
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 77 4.97 1.13      5    5.01 1.19   2   7     5 -0.33    -0.57 0.13
```

```r
summary(fb24[which(fb24$ort=="FFM"), "lz"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   2.000   4.000   5.000   4.889   5.800   7.000
```

```r
summary(fb24[which(fb24$ort=="anderer"), "lz"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   2.000   4.200   5.000   4.966   5.800   7.000
```



Der Mittelwert der Frankfurter:innen ist deskriptiv niedriger als der der Nicht-Frankfurter:innen. Dagegen ist der Median der Nicht-Frankfurter:innen und der Frankfurter:innen deskriptiv identisch.

**Voraussetzungsprüfung: Normalverteilung**


```r
par(mfrow=c(1,2))
lz.F <- fb24[which(fb24$ort=="FFM"), "lz"]
hist(lz.F, xlim=c(1,9), ylim=c(0,0.5), main="Lebenzufriedenheit\n(Frankfurter)", xlab="", ylab="", las=1, prob=T)
curve(dnorm(x, mean=mean(lz.F, na.rm=T), sd=sd(lz.F, na.rm=T)), col="red", lwd=2, add=T)
qqnorm(lz.F)
qqline(lz.F, col="red")
```

<img src="/gruppenvergleiche-unabhaengig-loesungen_files/unnamed-chunk-11-1.png" style="display: block; margin: auto;" />

$\rightarrow$ Entscheidung: Normalverteilung wird nicht angenommmen


```r
par(mfrow=c(1,2))
lz.a <- fb24[which(fb24$ort=="anderer"), "lz"]
hist(lz.a, xlim=c(1,9), main="Lebenszufriedenheit\n(Nicht-Frankfurter)", xlab="", ylab="", las=1, prob=T)
curve(dnorm(x, mean=mean(lz.a, na.rm=T), sd=sd(lz.a, na.rm=T)), col="red", lwd=2, add=T)
qqnorm(lz.a)
qqline(lz.a, col="red")
```

<img src="/gruppenvergleiche-unabhaengig-loesungen_files/unnamed-chunk-12-1.png" style="display: block; margin: auto;" />

$\rightarrow$ Entscheidung: Normalverteilung wird angenommmen 


**Hypothesen**

* Art des Effekts: Unterschiedshypothese  
* Richtung des Effekts: Gerichtet $\rightarrow$ gerichtete Hypothesen  
* Größe des Effekts: Unspezifisch  

Hypthesenpaar (statistisch):  

* $H_0$: $\eta_\text{Frankfurter} \ge \eta_\text{nicht-Frankfurter}$  
* $H_1$: $\eta_\text{Frankfurter} <   \eta_\text{nicht-Frankfurter}$

**Spezifikation des Signifikanzniveaus**

$\alpha = .05$

**Durchführung des Wilcoxon-Tests**


```r
wilcox.test(fb24$lz ~ fb24$ort,           # abhängige Variable ~ unabhängige Variable
       #paired = F,                   # Stichproben sind unabhängig (Default)
       alternative = "less",         # einseitige Testung: Gruppe1 (Frankfurter:innen) < Gruppe2 (Nicht-Frankfurter:innen) 
       conf.level = .95)             # alpha = .05 
```

```
## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  fb24$lz by fb24$ort
## W = 4208, p-value = 0.3895
## alternative hypothesis: true location shift is less than 0
```



**Formales Berichten des Ergebnisses** 

Es wurde untersucht, ob außerhalb von Frankfurt wohnende Studierende zufriedener im Leben sind als die in Frankfurt wohnenden. Deskriptiv  zeigt sich, dass die Nicht-Frankfurter:innen genauso zufrieden sind (_Mdn_ = 5, _IQB_ = [4.2 ; 5.8]) wie die Frankfurter:innen (_Mdn_ = 5, _IQB_ = [4 ; 5.8]). Der entsprechende Wilcoxon-Test zeigt ebenfalls ein nicht signifikantes Ergebnis (_W_ = 4208, _p_ = 0.39). Die Nullhypothese konnte nicht verworfen werden und wird beibehalten. Die Studierenden sind gleich zufrieden, unabhängig von ihrem Wohnort.


</details>

## Aufgabe 3

Ist die Wahrscheinlichkeit dafür, neben dem Studium einen Job ("job") zu haben, die gleiche für Erstsemesterstudierende der Psychologie die in einer Wohngemeinschaft wohnen wie für Studierenden die bei ihren Eltern wohnen ("wohnen")? 

<details><summary>Lösung</summary>
Beide Variablen sind nominalskaliert $\rightarrow \chi^2$-Test

**Voraussetzungen**  

1. Die einzelnen Beobachtungen sind voneinander unabhängig $\rightarrow$ ok
2. Jede Person lässt sich eindeutig einer Kategorie bzw. Merkmalskombination zuordnen $\rightarrow$ ok
3. Zellbesetzung für alle $n_{ij}$ > 5 $\rightarrow$ Prüfung anhand von Häufigkeitstabelle 


```r
wohnsituation <- fb24[(which(fb24$wohnen=="WG"|fb24$wohnen=="bei Eltern")),] # Neuer Datensatz der nur Personen beinhaltet, die entweder bei den Eltern oder in einer WG wohnen
levels(wohnsituation$wohnen)
```

```
## [1] "WG"         "bei Eltern" "alleine"    "sonstiges"
```

```r
wohnsituation$wohnen <- droplevels(wohnsituation$wohnen) 
# Levels "alleine" und "sonstiges" wurden eliminiert
levels(wohnsituation$wohnen)
```

```
## [1] "WG"         "bei Eltern"
```

```r
tab <- table(wohnsituation$wohnen, wohnsituation$job)
tab
```

```
##             
##              nein ja
##   WG           36 25
##   bei Eltern   40 20
```

$\rightarrow n_{ij}$ > 5 in allen Zellen gegeben

**Hypothesen**

* Art des Effekts: Zusammenhangshypothese
* Richtung des Effekts: Ungerichtet
* Größe des Effekts: Unspezifisch

Hyothesenpaar (inhaltlich):  

* $H_0$: Studierende die in einer WG wohnen und Studierende die bei ihren Eltern wohnen haben mit gleicher Wahrscheinlichkeit einen Job bzw. keinen Job.  
* $H_1$: Studierende die in einer WG wohnen und Studierende die bei ihren Eltern wohnen unterscheiden sich in der Wahrscheinlichkeit einen Job bzw. keinen Job neben dem Studium zu haben.  

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
## X-squared = 0.75787, df = 1, p-value = 0.384
```



$\chi^2$ = 0.758, df = 1, p = 0.384 $\rightarrow H_0$

**Effektstärke Phi ($\phi$)**


```r
library(psych)
phi(tab)
```

```
## [1] -0.08
```

**Ergebnisinterpretation**

Es wurde untersucht, ob sich Studierende die in einer WG wohnen und Studierende die bei ihren Eltern wohnen darin unterscheiden, ob sie einen Job haben oder nicht (Job vs. kein Job). Zur Beantwortung der Fragestellung wurde ein Vierfelder-Chi-Quadrat-Test für unabhängige Stichproben berechnet. Der Zusammenhang zwischen Wohnsituation und Berufstätigkeit ist nicht signifikant ($\chi^2$(1) = 0.758, _p_ = 0.384), somit wird die Nullhypothese beibehalten. Der Effekt ist von vernachlässigbarer Stärke ($\phi$ = -0.08). Studierende die in einer WG wohnen und Studierende die bei ihren Eltern wohnen haben also mit gleicher Wahrscheinlichkeit einen Job bzw. keinen Job. 

</details>
