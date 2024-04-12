---
title: "Tests für unabhängige Stichproben - Lösungen" 
type: post
date: '2022-12-09' 
slug: gruppenvergleiche-unabhaengig-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [koehler, buchholz, goldhammer, walter, nehler] 
lastmod: '2024-03-27'
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

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/gruppenvergleiche-unabhaengig
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/gruppenvergleiche-unabhaengig-aufgaben
    
output:
  html_document:
    keep_md: true
---




## Vorbereitung

> Laden Sie zunächst den Datensatz `fb23` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb23.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/gruppenvergleiche-unabhaengig/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.




***

## Aufgabe 1
Wir wollen untersuchen, ob sich Studierende, die sich für Allgemeine Psychologie (Variable `fach`) interessieren, im Persönlichkeitsmerkmal Offenheit für neue Erfahrungen (auch Intellekt, `offen`) von Studierenden, die sich für Klinische Psychologie interessieren, unterscheiden? Gehen Sie in der Beantwortung der Fragen davon aus, dass wir einen $t$-Test durchführen werden. Die Testung der Voraussetzungen werden wir im Laufe der Aufgabe durchführen.

* Untersuchen Sie die Fragestellung zunächst rein deskriptiv. Bestimmen Sie dafür die Mittelwerte und empirischen Standardabweichungen der beiden Gruppen. 

<details><summary>Lösung</summary>

In der Variable `fach` liegen 5 verschiedene Fächer vor. Es interessieren aber nur zwei Ausprägungen davon, weshalb wir ein Subset aus unseren Daten bilden. Dieses legen wir in einem neuen Datensatz ab, den wir `data1` nennen, da er zur ersten Aufgabe gehört. 


```r
table(fb23$fach)
```

```
## 
##  Allgemeine Biologische Entwicklung   Klinische Diag./Meth. 
##          30          31          19          82           5
```

```r
data1 <- fb23[fb23$fach=="Allgemeine"|fb23$fach=="Klinische", ]
```

Damit im neuen Datensatz die alten Levels nicht mehr existieren (und bspw. bei Nutzung von `table()` mit einer Häufigkeit von 0 angezeigt werden), verwenden wir den Befehl `droplevels()`.


```r
table(data1$fach)
```

```
## 
##  Allgemeine Biologische Entwicklung   Klinische Diag./Meth. 
##          30           0           0          82           0
```

```r
data1$fach <- droplevels(data1$fach)
table(data1$fach)
```

```
## 
## Allgemeine  Klinische 
##         30         82
```

Beachten Sie, dass dieses Vorgehen aber keine Personen ausschließt, die das Lieblingsfach nicht angegeben haben. Dies können wir aber durch eine weitere Reduktion des Datensatzes erreichen.


```r
data1 <- data1[!is.na(data1$fach),]
```

**Deskriptivstatistische Beantwortung der Fragestellung: grafisch**


```r
boxplot(data1$offen ~ data1$fach,
        xlab="Interessenfach", ylab="Offenheit für neue Erfahrungen", 
        las=1, cex.lab=1.5, 
        main="Interessenfach und Offenheit")
```

![](/lehre/statistik-i/gruppenvergleiche-unabhaengig-loesungen_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

**Deskriptivstatistische Beantwortung der Fragestellung: statistisch**
Die `describeBy()` Funktion aus dem Paket `psych` kann uns helfen, direkt die deskriptiven Maße getrennt für unsere beiden Gruppen zu erstellen.


```r
library(psych)
describeBy(x = data1$offen, group = data1$fach)
```

```
## 
##  Descriptive statistics by group 
## group: Allgemeine
##    vars  n mean   sd median trimmed  mad min max range skew kurtosis   se
## X1    1 30 3.67 0.82    3.5    3.67 0.74   2   5     3 0.11       -1 0.15
## -------------------------------------------------------------------------------------- 
## group: Klinische
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 82 3.77 0.98      4    3.86 0.74 1.5   5   3.5 -0.58    -0.59 0.11
```
Allerdings haben wir auch gelernt, dass die Funktion `describeBy()` nur Populationsschätzer für Varianz und Standardabweichung berichtet. Deshalb müssen wir die empirische Schätzung mittels der Korrektur durchführen. Hierfür gibt es natürlich verschiedene Wege. Wir ziehen uns in dem Code alle Offenheits-Werte, die Personen mit den jeweiligen Fächern angegeben haben und legen Sie jeweils in ein Objekt (`offen_A` und `offen_K`) ab. Diese Objekte sind Vektoren und enthalten somit NUR die Offenheits-Werte. Allerdings müssen wir hier fehlende Werte beachten, da es sein könnte, dass eine Person zwar die Frage nach ihrem Lieblingsfach, aber nicht die Frage nach ihrer Offenheit. In dem Beispiel kommt das zwar nicht vor, aber zur Sicherheit haben wir den Code allgemein gültig geschrieben.


```r
offen_A <- data1$offen[(data1$fach=="Allgemeine")]
sigma_A <- sd(offen_A)
n_A <- length(offen_A[!is.na(offen_A)])
sd_A <- sigma_A * sqrt((n_A - 1) / n_A)
sd_A 
```

```
## [1] 0.8096639
```

```r
offen_K <- data1$offen[(data1$fach=="Klinische")]
sigma_K <- sd(offen_K)
n_K <- length(offen_K[!is.na(offen_K)])
sd_K <- sigma_K * sqrt((n_K-1) / n_K)
sd_K
```

```
## [1] 0.9759146
```

Mittelwert der Allgemeinen Psychologen ($M = 3.67$, $SD = 0.81$ unterscheidet sich deskriptivstatistisch vom Mittelwert der Klinischen ($M = 3.77$, $SD = 0.98$).

</details>

* Formulieren Sie die Hypothesen basierend auf der Aufgabenstellung inhaltlich und statistisch.

<details><summary>Lösung</summary>

**Hypothesen**

* Art des Effekts: Unterschiedshypothese  
* Richtung des Effekts: Ungerichtet $\rightarrow$ ungerichtete Hypothesen  
* Größe des Effekts: Unspezifisch  

Hypothesenpaar (inhaltlich):

* $H_0$: Die Offenheitswerte unterscheiden sich nicht zwischen Studierenden, die als Lieblingsfach klinische, und Studierenden, die als Lieblingsfach allgemeine Psychologie angegeben haben.
* $H_1$: Die Offenheitswerte unterscheiden sich zwischen Studierenden, die als Lieblingsfach klinische, und Studierenden, die als Lieblingsfach allgemeine Psychologie angegeben haben.

Hypothesenpaar (statistisch):  

* $H_0$: $\mu_\text{Allgemeine} =   \mu_\text{Klinische}$
* $H_1$: $\mu_\text{Allgemeine} \ne \mu_\text{Klinische}$

</details>


* Welche Voraussetzung gibt es für die Durchführung des $t$-Tests. Bewerten Sie, ob diese gegeben sind und prüfen Sie diese gegebenenfalls.

<details><summary>Lösung</summary>

Die zusätzlichen Voraussetzungen sind die folgenden:

1.  zwei unabhängige Stichproben $\rightarrow$ ist gegeben
2.  die einzelnen Messwerte innerhalb der Gruppen sind voneinander unabhängig (Messwert einer Vpn hat keinen Einfluss auf den Messwert einer anderen) $\rightarrow$ kann als gegeben angeommen werden
3.  das untersuchte Merkmal ist in den Grundgesamtheiten der beiden Gruppen normalverteilt $\rightarrow$ (ggf.) optische Prüfung
4.  Homoskedastizität: Varianzen der Variablen innerhalb der beiden Populationen sind gleich $\rightarrow$ Levene-Test


**Voraussetzungsprüfung: Normalverteilung**

```r
par(mfrow=c(1,2))
hist(offen_K, xlim=c(0.5,5.5), ylim=c(0,0.5), main="Offenheit\n(Klinische)", xlab="", ylab="", las=1, prob=T)
curve(dnorm(x, mean=mean(offen_K, na.rm=T), sd=sd(offen_K, na.rm=T)), col="red", lwd=2, add=T)
qqnorm(offen_K)
qqline(offen_K, col="red")
```

<img src="/lehre/statistik-i/gruppenvergleiche-unabhaengig-loesungen_files/figure-html/unnamed-chunk-8-1.png" style="display: block; margin: auto;" />



```r
par(mfrow=c(1,2))
hist(offen_A, xlim=c(0.5,5.5), main="Offenheit\n(Allgemeine)", xlab="", ylab="", las=1, prob=T)
curve(dnorm(x, mean=mean(offen_A, na.rm=T), sd=sd(offen_A, na.rm=T)), col="red", lwd=2, add=T)
qqnorm(offen_A)
qqline(offen_A, col="red")
```

<img src="/lehre/statistik-i/gruppenvergleiche-unabhaengig-loesungen_files/figure-html/unnamed-chunk-9-1.png" style="display: block; margin: auto;" />

Wir sehen anhand der Abbildungen, dass unsere empirischen Verteilungen nicht den theoretischen Normalverteilungen entsprechen, was vor allem na einem Deckeneffekt liegt (viele Personen haben die maximale Offenheit gewählt). Gleichzeitig wissen wir durch den zentralen Grenzwertsatz, dass die Stichprobenkennwerteverteilung bei großem $N$ bei kleineren Verletzungen der Symmetrie trotzdem der gewünschten Verteilung folgt. Da wir eine große Stichprobe und keine starke Verletzung der Symmetrie vorliegen haben, bleiben wir erstmal bei der Durchführung des $t$-Tests und untersuchen die Varianzhomogenität.

**Voraussetzungsprüfung: Varianzhomogenität**


```r
library(car)
leveneTest(data1$offen ~ data1$fach)
```

```
## Levene's Test for Homogeneity of Variance (center = median)
##        Df F value Pr(>F)
## group   1  0.6047 0.4385
##       110
```


$F$(1, 110) = 0.6, $p$ = 0.438 $\rightarrow$ Das Ergebnis ist nicht signifikant, die $H_0$ wird beibehalten und Varianzhomogenität angenommen.
</details>

* Führen Sie abschließend den t-Test und berichten Sie die Ergebnisse formal. $\alpha$ soll den Wert 0.05 haben.

<details><summary>Lösung</summary>

**Durchführung des _t_-Tests**


```r
t.test(data1$offen ~ data1$fach,           # abhängige Variable ~ unabhängige Variable
       paired = F,                   # Stichproben sind unabhängig 
       alternative = "two.sided",         # zweiseitige Testung
       var.equal = T,                # Varianzhomogenität ist gegeben (-> Levene-Test)
       conf.level = .95)             # alpha = .05 
```

```
## 
## 	Two Sample t-test
## 
## data:  data1$offen by data1$fach
## t = -0.50521, df = 110, p-value = 0.6144
## alternative hypothesis: true difference in means between group Allgemeine and group Klinische is not equal to 0
## 95 percent confidence interval:
##  -0.5002719  0.2970199
## sample estimates:
## mean in group Allgemeine  mean in group Klinische 
##                 3.666667                 3.768293
```



**Formales Berichten des Ergebnisses**

Es wurde untersucht, ob sich Studierende, die sich für Allgemeine Psychologie interessieren, im Persönlichkeitsmerkmal Offenheit für neue Erfahrungen von Studierenden, die sich für Klinische Psychologie interessieren, unterscheiden. Deskriptiv liegt ein solcher Unterschied vor: Die Mittelwerte betragen 3.67 (Allgemeine, $SD = 0.81$) und 3.77 (Klinische, $SD = 0.98$). Der entsprechende $t$-Test zeigt jedoch ein nicht signifikantes Ergebnis (_t_(_df_ = 110, zweis.) = -0.51, $p$ = 0.614). Die Nullhypothese konnte nicht verworfen werden und wird beibehalten. Die Studierenden unterscheiden sich nicht im Persönlichkeitsmerkmal *Offenheit für neue Erfahrungen* unabhängig davon, ob sie sich für Allgemeine Psychologie oder für Klinische Psychologie interessieren.

</details>

## Aufgabe 2

In dieser Aufgabe soll untersucht werden, ob sich Studierende mit Wohnort in Frankfut, sich selbst zu Beginn der Praktikumsstizung als wacher eingestuft haben als Studierende, die nicht in Frankfurt wohnen. Für die Untersuchung soll der Mittelwert der beiden Gruppen betrachtet werden.

* Zunächst geht es an die Datenvorbereitung. Verwandeln Sie die Variable Ort in einen Faktor, bei dem eine `1` für `FFM` und eine `2` für `anderer` steht. **ACHTUNG**: Wenn Sie den Appendix des Tutorials durchgearbeitet haben, ist dieser Schritt nicht nötig.

<details><summary>Lösung</summary>


```r
# Achtung, nur einmal durchführen (ansonsten Datensatz neu einladen und Code erneut durchlaufen lassen!)
fb23$ort <- factor(fb23$ort, levels=c(1,2), labels=c("FFM", "anderer"))
```

</details>

* Außerdem muss der Skalenwert (`wm_pre`) noch erstellt werden. Dieser setzt sich aus den Mittelwerten der Fragen 2, 5, 7 und 10 des MDBF zusammen. Beachten Sie dabei, dass es 4 Antwortkategorien gab und die Items 5 und 7 vor der Skalenbildung invertiert werden müssen.

<details><summary>Lösung</summary>


```r
# Rekodierung invertierter Items
fb23$mdbf5_pre_r <- -1 * (fb23$mdbf5_pre - 4 - 1)
fb23$mdbf7_pre_r <- -1 * (fb23$mdbf7_pre - 4 - 1)

# Berechnung von Skalenwerten
fb23$wm_pre  <- fb23[, c('mdbf1_pre', 'mdbf5_pre_r', 
                        'mdbf7_pre_r', 'mdbf10_pre')] |> rowMeans()
```

</details>

* Leiten Sie aus der Fragestellung die Hypothesen inhaltlich und statistisch ab.

<details><summary>Lösung</summary>

**Hypothesen**

* Art des Effekts: Unterschiedshypothese  
* Richtung des Effekts: Gerichtet $\rightarrow$ gerichtete Hypothesen  
* Größe des Effekts: Unspezifisch  

Hypothesenpaar (inhaltlich):

* $H_0$: Studierende, die in Frankfurt wohnen, schätzen sich selbst zu Beginn des Praktikums weniger oder gleich wach ein als Studierende, die nicht in Frankfurt wohnen.
* $H_1$: Studierende, die in Frankfurt wohnen, schätzen sich selbst zu Beginn des Praktikums wacher ein als Studierende, die nicht in Frankfurt wohnen.

Hypothesenpaar (statistisch):  

* $H_0$: $\mu_\text{FFM} \leq   \mu_\text{andere}$
* $H_1$: $\mu_\text{FFM} > \mu_\text{andere}$

</details>

* Nehmen Sie alle Voraussetzungen als gegeben an und führen Sie direkt den t-Test durch. Nutzen Sie als Signifikanzniveau $\alpha = 0.01$ und treffen Sie eine Entscheidung hinsichtlich der Hypothesen.

<details><summary>Lösung</summary>



```r
t.test(fb23$wm_pre ~ fb23$ort,           # abhängige Variable ~ unabhängige Variable
       paired = F,                   # Stichproben sind unabhängig 
       alternative = "greater",         # einseitige Testung
       var.equal = T,                # Varianzhomogenität ist gegeben (-> Levene-Test)
       conf.level = .99)             # alpha = .05 
```

```
## 
## 	Two Sample t-test
## 
## data:  fb23$wm_pre by fb23$ort
## t = 0.38003, df = 172, p-value = 0.3522
## alternative hypothesis: true difference in means between group FFM and group anderer is greater than 0
## 99 percent confidence interval:
##  -0.1851268        Inf
## sample estimates:
##     mean in group FFM mean in group anderer 
##              2.673246              2.637500
```

In der inferenzstatistischen Testung zeigt sich kein signifikanter Unterschied. Wir würden also die $H_0$ beibehalten, auch wenn der Mittelwert der Gruppe FFM deskriptiv ein wenig größer ist.

</details>



## Aufgabe 3

In dieser Aufgabe wollen wir die Frage beantworten, ob Studierende die auf Unipartys gehen (`uni3`), sich in Ihrer Lebenszufriedenheit von denen unterscheiden (`lz`), die dies nicht tun. Im Tutorial haben Sie bereits gelernt, dass Lebenszufriedenheit als schiefverteilt angenommen werden kann. Wählen Sie also einen Test, der diese Schiefe berücksichtigt.

* Welcher Test wäre an dieser Stelle geeignet. Leiten Sie aus der Fragestellung die passenden Hypothesen für diesen Test ab.

<details><summary>Lösung</summary>

**Hypothesen**

* Art des Effekts: Unterschiedshypothese  
* Richtung des Effekts: Ungerichtet $\rightarrow$ ungerichtete Hypothesen  
* Größe des Effekts: Unspezifisch  

Hypothesenpaar (inhaltlich):

* $H_0$: Studierende, die Unipartys besuchen, erreichen im Mittel gleiche Werte der Lebenszufriedenheit wie Studierende, die diese Partys nicht besuchen.
* $H_1$: Studierende, die Unipartys besuchen, erreichen im Mittel unterschiedliche Werte der Lebenszufriedenheit als Studierende, die diese Partys nicht besuchen.

Hypothesenpaar (statistisch):  

* $H_0$: $\eta_\text{Unipartys} \neq \eta_\text{keine Unipartys}$  
* $H_1$: $\eta_\text{Unipartys} =   \eta_\text{keine Unipartys}$

</details>

* Erstellen Sie eine neue Variable `unipartys` in unserem Datensatz `fb23`. Diese soll als Faktor vorliegen und aus `uni3` erstellt werden, wobei `0` für `nein` und `1` für `ja` steht.

<details><summary>Lösung</summary>

```r
# Nominalskalierte Variablen in Faktoren verwandeln
fb23$unipartys <- factor(fb23$uni3,
                             levels = 0:1,
                             labels = c("nein", "ja"))
```


</details>


* Betrachten Sie die deskriptivstatistischen Kennwerte und ordnen Sie diese hinsichtlich unserer Hypothese ein.

<details><summary>Lösung</summary>

**Deskriptivstatistische Beantwortung der Fragestellung: grafisch**


```r
boxplot(fb23$lz ~ fb23$unipartys,
        ylab="Lebenszufriedenheit", 
        las=1, cex.lab=1.5, 
        main="Unipartys und Lebenszufriedenheit")
```

![](/lehre/statistik-i/gruppenvergleiche-unabhaengig-loesungen_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

**Deskriptivstatistische Beantwortung der Fragestellung: statistisch**


```r
describeBy(fb23$lz, fb23$unipartys)
```

```
## 
##  Descriptive statistics by group 
## group: nein
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 94 4.96 1.12    5.2    5.05 0.89 1.4   7   5.6 -0.84     0.69 0.12
## -------------------------------------------------------------------------------------- 
## group: ja
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 83  5.3 0.96    5.4    5.35 1.19 2.8   7   4.2 -0.45    -0.55 0.11
```



Rein deskriptiv unterscheiden sich die beiden Gruppen in ihrer mittleren Lebenszufriedenheit

</details>

* Welche Voraussetzungen hat der von Ihnen ausgewählte Test? Beurteilen Sie die Voraussetzungen und testen Sie diese gegebenenfalls.

<details><summary>Lösung</summary>

1.  zwei unabhängige Stichproben $\rightarrow$ ok
2.  die einzelnen Messwerte sind innerhalb der beiden Gruppen voneinander unabhängig (Messwert einer Vpn hat keinen Einfluss auf den Messwert einer anderen) $\rightarrow$ ok
3.  das untersuchte Merkmal ist stetig (mindestens singulär-ordinal skaliert) $\rightarrow$ Fragebogenscore mit begrenzter Anzahl, aber wir nehmen diese als nahe genug an $\infty$ an
4.  das Merkmal folgt in beiden Gruppen der gleichen Verteilung

**Voraussetzungsprüfung: gleiche Verteilung**


```r
par(mfrow=c(1,2))
lz_party <- fb23[which(fb23$unipartys=="ja"), "lz"]
hist(lz_party, xlim=c(1,9), ylim=c(0,0.5), main="Lebenzufriedenheit\n(Unipartys)", xlab="", ylab="", las=1, prob=T)
curve(dnorm(x, mean=mean(lz_party, na.rm=T), sd=sd(lz_party, na.rm=T)), col="red", lwd=2, add=T)
qqnorm(lz_party)
qqline(lz_party, col="red")
```

<img src="/lehre/statistik-i/gruppenvergleiche-unabhaengig-loesungen_files/figure-html/unnamed-chunk-21-1.png" style="display: block; margin: auto;" />



```r
par(mfrow=c(1,2))
lz_noparty <- fb23[which(fb23$unipartys=="nein"), "lz"]
hist(lz_noparty, xlim=c(1,9), main="Lebenszufriedenheit\n(Keine Unipartys)", xlab="", ylab="", las=1, prob=T)
curve(dnorm(x, mean=mean(lz_noparty, na.rm=T), sd=sd(lz_noparty, na.rm=T)), col="red", lwd=2, add=T)
qqnorm(lz_noparty)
qqline(lz_noparty, col="red")
```

<img src="/lehre/statistik-i/gruppenvergleiche-unabhaengig-loesungen_files/figure-html/unnamed-chunk-22-1.png" style="display: block; margin: auto;" />


```r
leveneTest(fb23$lz ~ fb23$unipartys)
```

```
## Levene's Test for Homogeneity of Variance (center = median)
##        Df F value Pr(>F)
## group   1  0.3436 0.5585
##       175
```


</details>

* Führen Sie abschließend die inferenzstatistische Prüfung durch und berichten Sie die Ergebnisse formal. $\alpha$ soll den Wert 0.05 haben.

<details><summary>Lösung</summary>

**Durchführung des Wilcoxon-Tests**


```r
wilcox.test(fb23$lz ~ fb23$unipartys, # abhängige Variable ~ unabhängige Variable
       paired = F,                   # Stichproben sind unabhängig 
       alternative = "two.sided",      # zweiseitige Testung 
       conf.level = .95)             # alpha = .05 
```

```
## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  fb23$lz by fb23$unipartys
## W = 3229.5, p-value = 0.0481
## alternative hypothesis: true location shift is not equal to 0
```



**Formales Berichten des Ergebnisses** 

Es wurde untersucht, ob Studierende, die auf Unipartys gehen, sich in der Lebenszufriedenheit von denen unterscheiden, die das nicht tun. Deskriptiv  zeigt sich, dass die Uniparty-Gänger:innen zufriedener sind ($Mdn = 5.4$) als die, die das nicht tun ($Mdn = 5.2$). entsprechende Wilcoxon-Test zeigt ein signifikantes Ergebnis ($W = 3229.5$, $p = 0.048$). Die Nullhypothese wird daher verworfen. Studierende, die auf Unipartys gehen, unterscheiden sich im Mittel in ihrer Lebenszufriedenheit von denen, die dies nicht tun.


</details>



## Appendix

Hier finden Sie noch eine Aufgabe, die den im Appendix des Tutorials behandelten Test abfragt.

<details><summary> Aufgabe zum Appendix </summary>

Ist die Wahrscheinlichkeit dafür, neben dem Studium einen Job (`job`) zu haben, die gleiche für Erstsemesterstudierende der Psychologie die in einer Wohngemeinschaft wohnen wie für Studierenden die bei ihren Eltern wohnen (`wohnen`)? Führen Sie die Testung mit $\alpha = 0.05$ durch.

<details><summary>Lösung</summary>

Beide Variablen sind nominalskaliert $\rightarrow \chi^2$-Test

**Vorbereitung der Daten**

Die Variable `job` wurde schon im Appendix des Tutorials erstellt. Trotzdem hier nochmal zur Sicherheit, damit das Dokument der Lösungen in sich stimmig ist. Wenn Sie diesen Befehl schon ausgeführt haben, sollten Sie ihn aber nicht nochmal ausführen. Sonst müssen Sie den Datensatz neu laden und bis zu diesem Zeitpunkt wieder ausführen.


```r
fb23$job <- factor(fb23$job, levels=c(1,2), labels=c("nein", "ja"))
```

Weiterhin gibt es bei der Variable `wohnen` mehr als die beiden Ausprägungen, die wir vergleichen wollen. Also reduzieren wir den Datensatz und legen den neuen Datensatz unter dem Namen `data4` für die dritte Aufgabe ab.


```r
data4 <- fb23[(which(fb23$wohnen=="WG"|fb23$wohnen=="bei Eltern")),] # Neuer Datensatz der nur Personen beinhaltet, die entweder bei den Eltern oder in einer WG wohnen
levels(data4$wohnen)
```

```
## [1] "WG"         "bei Eltern" "alleine"    "sonstiges"
```

```r
data4$wohnen <- droplevels(data4$wohnen) 
# Levels "alleine" und "sonstiges" wurden eliminiert
levels(data4$wohnen)
```

```
## [1] "WG"         "bei Eltern"
```

**Voraussetzungen**  

1. Die einzelnen Beobachtungen sind voneinander unabhängig $\rightarrow$ ok
2. Jede Person lässt sich eindeutig einer Kategorie bzw. Merkmalskombination zuordnen $\rightarrow$ ok
3. Zellbesetzung für alle $n_{ij}$ > 5 $\rightarrow$ Prüfung anhand von Häufigkeitstabelle 


```r
tab <- table(data4$wohnen, data4$job)
tab
```

```
##             
##              nein ja
##   WG           30 25
##   bei Eltern   23 17
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
## X-squared = 0.08196, df = 1, p-value = 0.7747
```



$\chi^2$ = 0.082, df = 1, p = 0.775 $\rightarrow H_0$

**Effektstärke Phi ($\phi$)**


```r
library(psych)
phi(tab)
```

```
## [1] -0.03
```

**Ergebnisinterpretation**

Es wurde untersucht, ob sich Studierende die in einer WG wohnen und Studierende die bei ihren Eltern wohnen darin unterscheiden, ob sie einen Job haben oder nicht (Job vs. kein Job). Zur Beantwortung der Fragestellung wurde ein Vierfelder-Chi-Quadrat-Test für unabhängige Stichproben berechnet. Der Zusammenhang zwischen Wohnsituation und Berufstätigkeit ist nicht signifikant ($\chi^2$(1) = 0.082, _p_ = 0.775), somit wird die Nullhypothese beibehalten. Der Effekt ist von vernachlässigbarer Stärke ($\phi$ = -0.03). Studierende die in einer WG wohnen und Studierende die bei ihren Eltern wohnen haben also mit gleicher Wahrscheinlichkeit einen Job bzw. keinen Job. 
</details>
</details>
