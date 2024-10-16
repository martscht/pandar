---
title: "Tests für abhängige Stichproben" 
type: post
date: '2022-12-06' 
slug: gruppenvergleiche-abhaengig 
categories: ["Statistik I"] 
tags: ["Abhängige Stichproben", "t-Test", "Wilcoxon-Test", "Voraussetzungsprüfung"] 
subtitle: ''
summary: 'In diesem Beitrag werden abhängige Stichproben beleuchtet. Dabei geht es vor allem um die Durchführung des abhängigen t-Tests und des abhängigen Wilcoxon-Tests.' 
authors: [nehler, koehler, buchholz, irmer, liu] 
weight: 7
lastmod: '2024-03-27'
featured: no
banner:
  image: "/header/consent_checkbox.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/449195)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/gruppenvergleiche-abhaengig
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-i/gruppenvergleiche-abhaengig.R
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/gruppenvergleiche-abhaengig-aufgaben
output:
  html_document:
    keep_md: true
---





<details><summary><b>Kernfragen dieser Lehreinheit über Gruppenvergleiche</b></summary>

* Wie fertige ich [Deskriptivstatistiken](#Statistiken) (Grafiken, Kennwerte) zur Veranschaulichung des Unterschieds zwischen zwei Gruppen an?  
* Was sind [Voraussetzungen](#Vorraussetzungen) des abhängigen *t*-Tests und wie prüfe ich sie?
* Wie führe ich einen [abhängigen *t*-Test](#t-Test) in R durch?
* Wie berechne ich den [standardisierten Populationseffekt](#Populationseffekt) für abhängige Stichproben?  
* Wie führe ich einen [abhängigen Wilcoxon-Test](#Wilcox) in R durch?
* Wie [berichte](#Bericht) ich statistische Ergebnisse formal? 

</details>

***

## Vorbereitende Schritte {#prep}

Den Datensatz `fb23` haben wir bereits über diesen [<i class="fas fa-download"></i> Link heruntergeladen](/daten/fb23.rda) und können ihn über den lokalen Speicherort einladen oder Sie können Ihn direkt mittels des folgenden Befehls aus dem Internet in das Environment bekommen. In den vorherigen Tutorials und den dazugehörigen Aufgaben haben wir bereits Änderungen am Datensatz durchgeführt, die hier nochmal aufgeführt sind, um den Datensatz auf dem aktuellen Stand zu haben:


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

***

Nachdem wir uns mit **unabhängige Stichproben** in der ([letzten Sitzung](/lehre/statistik-i/gruppenvergleiche-unabhaengig)) beschäftigt haben wollen wir diesmal mit abhängigen Stichproben beschäftigen. Anwendungen dafür in der Praxis sind beispielsweise Zwillinge, Paare oder auch Messwiederholungen. Beide behandelten Fragestellungen in diesem Beitrag funktionieren mit Messwiederholung. Die Methoden sind aber auf andere Arten abhängiger Stichproben übertragbar.

***

## Mittelwertvergleich für abhängige Stichproben

Für den ersten Teil des Tutorials beschäftigen wir uns mit folgender Fragestellung: Gibt es einen Unterschied in den Werten der Subskalen 'Ruhig vs. Unruhig Stimmung' bei Psychologiestudierenden vor und nach der ersten Sitzung des Kurses? Wir nehmen in der Fragestellung keine Richtung vor, da wir für Unterschiede in beide Richtungen und Erklärungen vorstellen können. Ist nach dem Praktikum die Stimmung ruhiger, weil die Aufregung von der ersten Veranstaltung verflogen ist? Oder ist die Stimmung unruhiger, weil der erste Kontakt mit R stattgefunden hat?

Die Werte dieser Variablen zum zweiten Messzeitpunkt sind insofern voneinander abhängig, als dass jede Person dieselben Fragen zweimal beantwortet hat (Messwiederholung). Es gibt daher Faktoren innerhalb der Person, die einen gemeinsamen Teil der Varianz erzeugen. 

### Deskriptivstatistik

Wie immer beginnen wir mit der deskriptivstatistischen Analyse unserer Daten. Die beiden Variablen können wir bspw. mit dem `summary()`-Befehl näher betrachten.


```r
summary(fb23$ru_pre)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.00    2.25    3.00    2.73    3.25    4.00
```

```r
summary(fb23$ru_post)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##   1.000   2.500   3.000   2.951   3.500   4.000      32
```

Zunächst einmal ist offensichtlich, dass sich die Mittelwerte vor und nach der Sitzung unterscheiden. Die Frage bleibt aber bestehen, ob sich dieser Unterschied auf die Population verallgemeinern lässt. Weiterhin sticht hier direkt ins Auge, dass es nach in der Post-Variable fehlende Werte (32) gibt. Diese Personen können in die abhängige Testung nicht einbezogen werden und wir müssen das bei den folgenden Befehlen beachten.


Mithilfe von Histogrammen stellen wir jeweils die Verteilungen der Werte vor und nach der Sitzung dar, wobei in den Histogrammen eine vertikale Linie ergänzt ist, die den jeweiligen Mittelwert anzeigt.


```r
# Je ein Histogramm pro Werte, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert
par(mfrow=c(2,1), mar=c(3,3,2,0))
hist(fb23$ru_pre, 
     xlim=c(1,5),
     ylim = c(0,80),
     main="Subskalen 'Ruhig vs. Unruhig' vor der Sitzung", 
     xlab="", 
     ylab="", 
     las=1)
abline(v=mean(fb23$ru_pre, na.rm = T), 
       lwd=3,
       col="aquamarine3")

hist(fb23$ru_post, 
     xlim=c(1,5),
     ylim = c(0,80),
     main="Subskalen 'Ruhig vs. Unruhig' nach der Sitzung", 
     xlab="", 
     ylab="", 
     las=1)
abline(v=mean(fb23$ru_post, na.rm = T), 
       lwd=3,
       col="darksalmon")
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
par(mfrow=c(1,1)) #Zurücksetzen des Plotfensters, zuvor hatten wir "dev.off()" kennengelernt
```

Die Funktion `abline()` fügt diese zusätzliche Linie in die Grafik ein. Mit dem Zusatzargument `v` geben wir an, dass es sich um eine vertikale Linie handeln soll. Der Ort der vertikalen Linie wird auch direkt über das Argumen `v` gesteuert. In dem Code soll diese jeweils den Mittelwert der beiden Gruppen kennzeichnen. Insgesamt scheinen sich die beiden Verteilungen  zu unterscheiden: Der Mittelwert von nach der Sitzung liegt höher als der vor der Sitzung. Beachten Sie jedoch, dass hier Personen mit fehlenden Werten auf der Post-Variable noch nicht ausgeschlossen sind, wodurch die späteren Ergebnisse anders ausfallen könnten.


### Voraussetzungsprüfung {#Vorraussetzungen}

Um unsere inferenzstistische Entscheidung mittels der $t$-Verteilung abzusichern, die beim $t$-Test passieren würde, müssen wir dessen Voraussetzungen erfüllt sein: 

**Voraussetzungen für die Durchführung des *t*-Tests für abhängige Stichproben:**  

1. Die abhängige Variable ist intervallskaliert $\rightarrow$ ok  
2. Die Messwerte innerhalb der Paare dürfen sich gegenseitig beeinflussen/voneinander abhängig sein; keine Abhängigkeiten zwischen den Messwertpaaren $\rightarrow$ ok  
3. Die Differenzvariable $d$ muss in der Population normalverteilt sein $\rightarrow$ ggf. optische Prüfung

Wir müssen also nur die Voraussetzung der Normalverteilung der Differenzvariable $d$ zusätzlich prüfen. Es ist wie bei den unabhängigen Tests üblich, diese Annahme optisch basierend auf der Stichprobe zu testen. Da wir hier die Differenzvariable betrachten wollen, müssen wir diese zunächst erstellen. Dies geht zum Glück sehr einfach, indem wir die Werte aller Personen auf `ru_pre` jeweils von ihren `ru_post` Werten abziehen. Personen mit einem fehlenden Wert auf einer der beien Variable erhalten auf `difference` jetzt automatisch ein `NA`. Somit sind alle Werte in den Grafiken die, die dann auch in unsere inferenzstatistische Prüfung eingehen. Anschließend schauen wir uns das Histogramm der Differenzvariable und den QQ-Plot an:


```r
difference <- fb23$ru_post-fb23$ru_pre
hist(difference, 
     xlim=c(-3,3), 
     ylim = c(0,1),
     main="Verteilung der Differenzen", 
     xlab="Differenzen", 
     ylab="", 
     las=1, 
     freq = F)
curve(dnorm(x, mean=mean(difference, na.rm = T), sd=sd(difference, na.rm = T)), 
      col="blue", 
      lwd=2, 
      add=T)
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

```r
qqnorm(difference)
qqline(difference, col="blue")
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig_files/figure-html/unnamed-chunk-4-2.png)<!-- -->

Auf den Abbildungen sind kleine Abweichungen der Differenzen von der Normalverteilung zu sehen. Bei diesen geringen Abweichungen könnte man die Normalverteilung annehmen. Zusätzlich gilt (wie auch bei den Einstichproben- und unabhängigen Tests) der zentrale Grenzwertsatz. In Fällen, in denen die Stichprobe (also Anzahl an Messwertpaaren) ausreichend groß ist, folgt die Stichprobenkennwerteverteilung wegen auch unabhängig von der Verteilung der Differenzen in der Population der $t$-Verteilung. “Ausreichend groß” ist natürlich Auslegungssache, aber nochmal zur Erinnerung: Bei Stichproben ab $n \geq 30$ greift der Effekt, wenn das Merkmal zumindest symmetrisch verteilt ist. Andere Empfehlungen gehen besonders bei sehr schiefen Verteilungen in Richtung von 80 Messwertpaaren. Die kleinen Abweichungen von der Normalverteilung und die große Stichproben sprechen also dafür, dass unsere Stichprobenkennwerteverteilung der mittleren Differenz der $t$-Verteilung folgt. Wir können also mit der inferenzstatistischen Überprüfung starten.

### Durchführung des $t$-Test für abhängige Stichproben

Aus der Fragestellung lässt sich ableiten, dass es sich bei unserer Untersuchung um eine Unterschiedshypothese handelt, in der wir keine Richtung angenommen haben. Beginnen wir also damit, das Hypothesenpaar auszuarbeiten.

* $H_0$: Studierende sind vor und nach dem Praktikum gleich ruhig.
* $H_1$: Studierende sind vor und nach dem Praktikum unterschiedlich ruhig.

Etwas formaler ausgedrückt:

* $H_0$: $\mu_\text{vor} = \mu_\text{nach}$  bzw.  $\mu_{d} = 0$  
* $H_1$: $\mu_\text{vor} \ne \mu_\text{nach}$    bzw.  $\mu_{d} \ne 0$


Bevor wir jetzt die Rechnungen durchführen, sollten wir noch das Signifikanzniveau Untersuchung festlegen. Es soll hier 5% betragen. $\rightarrow$ $\alpha=.05$

{{<intext_anchor t-Test>}}

Wir verwenden hier die Funktion `t.test()`. Diesmal müssen wir allerdings die beiden Variablen einzeln der Funktion übergeben. Dies geschieht über die Argumente `x` und `y`. Das Argument `paired = T` führt dazu, dass der *t*-Test für abhängige (gepaarte) Stichproben durchgeführt wird.


```r
t.test(x = fb23$ru_post, y = fb23$ru_pre, # die beiden abhaengigen Variablen
      paired = T,                      # Stichproben sind abhaengig
      conf.level = .95)   
```

```
## 
## 	Paired t-test
## 
## data:  fb23$ru_post and fb23$ru_pre
## t = 4.353, df = 146, p-value = 2.511e-05
## alternative hypothesis: true mean difference is not equal to 0
## 95 percent confidence interval:
##  0.1123539 0.2992108
## sample estimates:
## mean difference 
##       0.2057823
```



Auf den ursprünglichen Variablen sind immer noch die Personen mit fehlenden Werten enthalten. Trotzdem meldet die Funktion `t.test()` kein Problem. Was passiert hier also? Ein Indiz können uns die Freiheitsgrade beiten, die mit $n-1$ bestimmt werden können. Hier wird deutlich, dass Personen mit fehlenden Werten auf einer der beiden Variablen einfach ignoriert werden. Aber man bekommt (außer der überraschend kleinen Freiheitsgraden im Vergleich zur Größer des Datensatzes keine) keine Warnungn dazu. Kommen wir zur Interpretation des Ergebnis. $t$(146) = 4.35 -- der zugehörige p-Wert ($p < .01$) ist somit kleiner als unser festelegtes $\alpha$. Wir verwerfen die $H_0$ und nehmen die $H_1$ an.



### Schätzung des standardisierten Populationseffekts {#Populationseffekt}

Formel: $$\text{Cohen's } d'' = \frac{\bar{d}} {\hat{sd}_{d}}$$
wobei  

* $\bar{d}$: Mittelwert der Differenz aller Wertepaare  
* $\hat{sd}_{d}$: geschätzte SD der Differenzen  

Wir führen die Berechnung von Cohen's $d$ für abhängige Stichproben zunächst von Hand durch. Dafür speichern wir uns die nötigen Größen ab und wenden dann die präsentierte Formel an:


```r
mean_d <- mean(difference, na.rm = T)
sd.d.est <- sd(difference, na.rm = T)
d_Wert <- mean_d/sd.d.est
d_Wert
```

```
## [1] 0.359032
```

**Berechnung mit Funktion `cohen.d()`**

```r
#alternativ:
#install.packages("effsize")
library("effsize")
```


```r
d2 <- cohen.d(fb23$ru_post, fb23$ru_pre, 
      paired = TRUE,  #paired steht fuer 'abhaengig'
      within = FALSE, #wir brauchen nicht die Varianz innerhalb
      na.rm = TRUE)   
d2
```

```
## 
## Cohen's d
## 
## d estimate: 0.359032 (small)
## 95 percent confidence interval:
##     lower     upper 
## 0.1915546 0.5265094
```

Mit dem Argument `within = T`, was der Default ist, wird für die Varianzberechnung die Varianz innerhalb der Gruppen herangezogen (vergleiche Formel Cohen's $d$ für unanghängige Stichproben).

Wie auch zu den vorherigen inferenzstatistischen Tests gibt es auch hier Konventionen nach Cohen (1988). Die Werte unterscheiden sich zwischen abhängigem und unabhängigem $t$-Test. Wir möchten aber nochmal betonen, dass diese Konventionen nur bei völliger Ahnungslosigkeit genutzt werden sollten und sonst Effekstärken im Rahmen des Anwendungsgebietes eingeordnet werden sollten.

_d''_ | Interpretation |
:-: | :------: |
~ .14 | kleiner Effekt |
~ .35 | mittlerer Effekt |
~ .57 | großer Effekt |

Zusammenfassend lässt sich sagen: Der standardisierte Populationseffekt beträgt $d_2''$ = 0.36 und ist laut Konventionen klein bis mittel. 


### Ergebnisinterpretation

Zunächst findet sich deskriptiv ein Unterschied: 
Der Mittelwert der Differenzen zwischen ruhig und unruhig beträgt 0.21. Zur Beantwortung der Fragestellung wurde ein ungerichteter $t$-Test für abhängige Stichproben durchgeführt. Der Unterschied zwischen den beiden Messzeitpunkten ist signifikant ($t$(146) = 4.35, $p < .01$), somit wird die Nullhypothese verworfen. Dieser Unterschied ist nach dem standardisierten Populationseffekt von $d_2''$ = 0.36 klein bis mittel.

***


## Medianvergleich für abhängige Stichprobe

Für den Medianvergleich bei abhängigen Stichproben kommen wir jetzt leider zu dem Punkt, dass alle Variablen in unserem Datensatz keine guten Voraussetzungen für den Test liefern, den wir an dieser Stelle präsentieren wollen: den Wilxocon-Vorzeichen-Rangtest. Wir haben zwar noch andere Variablen mit abhängigen Messungen (zu Beginn und am Ende des Praktikums), aber eine später präsentierte Voraussetzung für den Test ist, dass die Variable stetig ist. Damit können wir in unserem Datensatz nicht dienen. Wir müssen daher auf einen anderen Datensatz zugreifen, den wir aber direkt aus PandaR einladen können.


```r
load(url("https://pandar.netlify.app/daten/CBTdata.rda"))
```

Hierbei handelt es sich um fiktive Daten, die den Behandlungseffekt der kognitiv-behavioralen Verhaltenstherapie bei verschiedenen psychologischen Störungsbildern aufzeigen sollen. Wir können eine Übersicht über die enthaltenen Variablen erhalten, indem wir den `head()`-Befehl nutzen.


```r
head(CBTdata)
```

```
##   Age Gender Treatment Disorder BDI_pre SWL_pre BDI_post SWL_post
## 1  39 female       CBT      ANX      27      10       24       15
## 2  36 female       CBT      ANX      22      13       13       17
## 3  61 female       CBT      ANX      24      11       17       14
## 4  70 female       CBT      ANX      30      15       22       19
## 5  64 female       CBT      DEP      32      12       26       20
## 6  50 female       CBT      ANX      24      15       23       22
```

Es wird deutlich, dass eine Person zu zwei Zeitpunkten hinsichtlich ihres Depressionsscores (BDI) und ihrer Lebenszufriedenheit (DWL) erhoben wurden. Wir wollen uns im Tutorial auf die Depression konzentrieren. Die Werte der Variablen (`BDI_pre` und `BDI_post`) zu den beiden Messzeitpunkten sind somit voneinander abhängig.

Allerdings konzentrieren wir uns nicht auf den Vergleich von Mittelwerten, sondern auf den von Medianen. Der Grund dafür liegt in der theoretischen Überlegung, dass der Mittelwert des Depressionsscores kein adäquater Repräsentant für die Variable ist. Dies wäre bspw. durch einen cut-off Wert auf dem BDI Fragebogen zu erwarten (nur ab einem bestimmten Wert bekommt man überhaupt die Diagnose). Weiterhin könnte der Mittelwert durch sehr starke klinische Fälle (also Ausreißer) verzerrt werden, während der Median ein robusteres Maß darstellt, das den zentralen Trend der Daten dann besser widerspiegeln kann. 

Wir wollen also eine Unterschiedsmessung von `BDI_post` und `BDI_pre` vornehmen. Um dem ganzen noch mehr inhaltliche Bedeutung zu verleihen, reduzieren wir unseren Datensatz auf die Personen, die wirklich an der Therapie teilgenommen haben (nicht auf der Warteliste standen) und auf Personen, die als Diagnose Depression (keine andere psychische Erkrankung) erhalten haben. Dies können wir durch einen logischen Filter erreichen, mit dem wir die Daten überschreiben.


```r
CBTdata <- CBTdata[CBTdata$Treatment == "CBT" & 
                     CBTdata$Disorder == "DEP", ]
```

Der resultierende Datensatz sollte 60 Zeilen enthalten. Die Fragestellung soll nun spezfisch sein: Ist der Depressionscore nach der Intervention durch kognitiv-behaviorale Therapie niedriger als davor?

### Deskriptivstatistik {#Statistiken}

Wie immer beginnen wir mit der deskriptivstatistischen Analyse unserer Daten. Einige Informationen können wir beispielsweise durch den `summary()`-Befehl erhalten 


```r
summary(CBTdata$BDI_pre)
```

```
##        V1       
##  Min.   :13.00  
##  1st Qu.:19.75  
##  Median :22.00  
##  Mean   :22.20  
##  3rd Qu.:25.00  
##  Max.   :32.00
```

```r
summary(CBTdata$BDI_post)
```

```
##        V1       
##  Min.   : 9.00  
##  1st Qu.:13.00  
##  Median :18.00  
##  Mean   :17.90  
##  3rd Qu.:21.25  
##  Max.   :30.00
```

Es zeigt sich zunächst, dass es in dem Datensatz keine fehlenden Werte gibt. Weiterhin ist der Median des Depressionsscores vor der Testung höher als danach, was der Richtung unserer Hypothesen entspricht.

Lassen wir uns die statistischen Maße noch durch das Aufzeichnen einer Verteilung ergänzen. Nutzen wir hierfür das Histogramm. Im Titel können wir mit `\n` einen Zeilenumbruch erreichen.


```r
# Je ein Histogramm pro Gruppe, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert
par(mfrow=c(1,2), mar=c(3,3,2,0))
hist(CBTdata$BDI_pre, 
     main="Depressionsscore \nvor der Therapie", 
     breaks = 10)


hist(CBTdata$BDI_post, 
     main="Depressionsscore \nnach der Therapie",
     breaks = 10)
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

```r
par(mfrow=c(1,1)) #Zurücksetzen des Plotfensters
```

Wie vermutet haben wir sowohl vor als auch nach der Therapie. Hier sieht man direkt, dass es viele Ausreißer in beiden Messperioden gibt. Dies ist der Grund, warum der Median ein geeignetes Maß für die zentrale Tendenz ist.

### Voraussetzungsprüfung

Zunächst prüfen wir, ob wir zur Beantwortung der Fragestellung einen Wilcoxon-Tests-Test für abhängige Stichproben verwenden können: 

1.  die Messwerte innerhalb der Paare dürfen sich gegenseitig beeinflussen/voneinander abhängig sein; keine Abhängigkeiten zwischen den Messwertpaaren $\rightarrow$ ok
2.  die Variable ist stetig 
3.  die Differenzvariable ist hinsichtlich der Größe reliabel $\rightarrow$ bedeutete für uns, dass wir eine Intervallskalierung brauchen, damit die Differenzen zweier Messwertpaare vergleichbar sind
4.  die Differenzvariable ist symmetrisch verteilt (nicht notwendigerweise normalverteilt; ggf. grafische Prüfung oder Hintergrundwissen)

Die erste Voraussetzung nehmen wir wie beschrieben als gegeben an, da die Messwerte Prä und Post einer Messwiederholung entsprechen und zwischen den einzelnen Personen keine Abhängigkeiten bestehen sollten. Im strengen Sinn ist die Variable nicht stetig, da nicht alle Werte theoretisch möglich sind, also unendlich Ausprägungen möglich sind. Trotzdem haben wir im Histogramm bereits gesehen, dass einige Werte möglich waren und wir nehmen jetzt mal an, dass wir damit nah genug an unendlich dran sind. Hinsichtlich der Skalierung unserer Variable gehen wir davon aus, dass sie intervallskaliert ist, da wir uns mit einem Fragebogenscore beschäftigen. Diese Skalierung wird benötigt, da im ersten Schritt die Differenzen zwischen dem Prä- und dem Post-Wert 

Bleibt noch die Voraussetzung, die Verteilung der Differenzwerte zu betrachten. Dafür bileden wir zunächst einen Vektor mit dem Namen `dif_dep`, der die Differenzen aller Personen enthält. Anschließend schauen wir uns auch die zu diesem Vektor das Histogramm an.


```r
dif_dep <- CBTdata$BDI_post - CBTdata$BDI_pre
hist(dif_dep,
     main="Differenzen Depressionsscores",
     breaks = 10)
```

![](/lehre/statistik-i/gruppenvergleiche-abhaengig_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

Die Differenzen weisen Abweichungen von der Symmetri-Annahme vor. Jedoch sind dies nur einzelne, wenige Fälle, weshalb wir die inferenzstatistische Testung trotzdem durchführen.

### Durchführung des Wilcoxon-Vorzeichen-Rangtest für abhängige Stichproben

Aus unserer Fragestellung wird eine Unterschiedsyhpothese deutlich, die einen gerichteten Effekt postuliert. Das Hypothesenpaar sieht folgendermaßen aus:

* $H_0$: $\eta_\text{nach} \ge \eta_\text{vor}$    
* $H_1$: $\eta_\text{nach} < \eta_\text{vor}$    

Weiterhin muss das Signifikanzniveau vor der Untersuchung festgelegt werden. Es soll hier 5% betragen. $\rightarrow$ $\alpha=.05$.

{{<intext_anchor Wilcox>}}

Die Argumente der Funktion für den Wilcoxon-Vorzeichen-Rangsummentest für abhängige Stichproben sehen dem des $t$-Tests für abhängige Stichproben sehr ähnlich. 


```r
wilcox.test(x = CBTdata$BDI_pre, 
            y = CBTdata$BDI_post,    # die beiden abhängigen Gruppen
            paired = T,              # Stichproben sind abhängig
            alternative = "greater", # gerichtete Hypothese
            exact = F,               # Approximation?
            conf.level = .95)        # alpha = .05
```

```
## 
## 	Wilcoxon signed rank test with continuity correction
## 
## data:  CBTdata$BDI_pre and CBTdata$BDI_post
## V = 1640, p-value = 6.047e-10
## alternative hypothesis: true location shift is greater than 0
```



Durch das Argument `exact` kann angegeben werden, ob man einen exakten p-Wert oder eine Approximation ausgeben lassen will -- in spezifischen Konstellationen kann man diese Wahl trffen. Für Fälle mit Rangbindungen und Differenzen von 0 wird eine Approximation genutzt, die wir hier auch uns anzeigen lassen. Auch unsere Stichprobengröße führt dazu, dass die Approximation genutzt wird. Trotzdem steuern wir mit `exact = FALSE` auch bewusst an. Die Signifikanzentscheidung kann mit diesem Output direkt getroffen werden. Der empirische Wert liegt bei V = 1640 und für den zugehörigen p-Wert gilt: $p < .01$. Wir würden die H0 also verwerfen. Am Output fällt uns in Unterschied zum $t$-Test auf, dass kein Konfidenzintervall ausgegeben wird, was uns aber nicht weiter stört, da wir unsere Hypothesen prüfen konnten.


### Ergebnisinterpretation {#Bericht}

Da der Mittelwert für die Depressionsscores kein sinnvolles Maß für die zentrale Tendenz darstellt, wurde ein Wilcoxon-Vorzeichen-Rangtest für abhängige Stichproben durchgeführt, um die Medien zu vergleichen. Zunächst findet sich deskriptiv ein Unterschied: Vor der Therapie ist der Median des Depressionsscores größer 22 als nach der Therapie 18. Der Unterschied wurde bei einem Signifikanzniveau von alpha = .05 signifikant (_V_ = 1640, $p$ < .01). Somit wird die Nullhypothese verworfen und es wird angenommen, dass der Depressionsscore nach der Therapie niedriger ist als davor.
