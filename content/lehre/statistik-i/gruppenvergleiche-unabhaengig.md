---
title: "Tests für unabhängige Stichproben" 
type: post
date: '2019-10-18' 
slug: gruppenvergleiche-unabhaengig 
categories: ["Statistik I"] 
tags: ["t-Test", "chi2-test", "Wilcoxon-Test", "unabhängig"] 
subtitle: ''
summary: '' 
authors: [koehler, buchholz, irmer, nehler, goldhammer] 
weight: 6
lastmod: '2023-10-04'
featured: no
banner:
  image: "/header/BSc2_test_unabh_stpr.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1217289)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/gruppenvergleiche-unabhaengig
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-i/gruppenvergleiche-unabhaengig.R
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/gruppenvergleiche-unabhaengig-aufgaben
output:
  html_document:
    keep_md: true
    
---
  


{{< spoiler text="Kernfragen dieser Lehreinheit über Gruppenvergleiche" >}}
* Wie fertige ich [Deskriptivstatistiken](#Statistiken) (Grafiken, Kennwerte) zur Veranschaulichung des Unterschieds zwischen zwei Gruppen an?
* Was sind [Voraussetzungen](#Vorraussetzungen) des *t*-Tests und wie prüfe ich sie?
* Wie führe ich einen [*t*-Test](#t-Test) in R durch?\
* Wie berechne ich die [Effektstärke](#Effektstärke) Cohen's *d*?\
* Wie führe ich den [Wilcoxon-Test](#Wilcox) (auch "Mann-Whitney-Test", "U-Test", "Mann-Whitney-U-Test", "Wilcoxon-Rangsummentest") in R durch?\
* Wie führe ich den [Vierfelder-Chi-Quadrat-Test](#Chi-Sq) in R durch?
{{< /spoiler >}}

***

## Was erwartet Sie?

Nachdem wir uns zuletzt mit dem Unterschied zwischen dem Mittelwert einer Stichprobe und dem Mittelwert der dazugehörigen Population, aus der die Stichprobe stammt, auseinandergesetzt haben, fokussieren wir uns nun auf Unterschiede zwischen zwei Gruppen (also zwei Stichproben). Hierbei muss zwischen unabhängigen und abhängigen Stichproben unterschieden werden.

## Aufbau der Sitzungen zu Gruppenvergleichen

1.  Fragestellung A: Erreichen Studentinnen und Studenten im Nerdiness Personality Attributes-Test im Durchschnitt gleich hohe Testwerte? (*t-Test und Cohen's d für unabhängige Stichproben*)
2.  Fragestellung B: Stimmen Studentinnen dem Item "Ich denke immer darüber nach, wie meine Taten sich auf die Umwelt auswirken" stärker zu als Studenten? (*Wilcoxon-Test für unabhängige Stichproben*)
3.  Fragestellung C: Haben Studierende mit Wohnort in Uninähe (Frankfurt) mit gleicher Wahrscheinlichkeit einen Nebenjob wie Studierende, deren Wohnort außerhalb von Frankfurt liegt? (*Vierfelder-*$\chi^2$-Test)

***

## Vorbereitende Schritte {#prep}

Wie man anhand der Fragestellungen bereits gesehen hat, beschäftigen wir uns mit den Werten aus unserem Datensatz. Diesen haben wir bereits unter diesem [<i class="fas fa-download"></i> Link herunterladen](/daten/fb22.rda) und können ihn über den lokalen Speicherort einladen oder Sie können Ihn direkt mittels des folgenden Befehls aus dem Internet in das Environment bekommen. In den vorherigen Tutorials und den dazugehörigen Aufgaben haben wir bereits Änderungen am Datensatz durchgeführt, die hier nochmal aufgeführt sind, um den Datensatz auf dem aktuellen Stand zu haben: 


```r
#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/post/fb22.rda'))  

# Nominalskalierte Variablen in Faktoren verwandeln
fb22$geschl_faktor <- factor(fb22$geschl,
                             levels = 1:3,
                             labels = c("weiblich", "männlich", "anderes"))
fb22$fach <- factor(fb22$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb22$ziel <- factor(fb22$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb22$wohnen <- factor(fb22$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

# Skalenbildung

fb22$prok2_r <- -1 * (fb22$prok2 - 5)
fb22$prok3_r <- -1 * (fb22$prok3 - 5)
fb22$prok5_r <- -1 * (fb22$prok5 - 5)
fb22$prok7_r <- -1 * (fb22$prok7 - 5)
fb22$prok8_r <- -1 * (fb22$prok8 - 5)

# Prokrastination
fb22$prok_ges <- fb22[, c('prok1', 'prok2_r', 'prok3_r',
                          'prok4', 'prok5_r', 'prok6',
                          'prok7_r', 'prok8_r', 'prok9', 
                          'prok10')] |> rowMeans()
# Naturverbundenheit
fb22$nr_ges <-  fb22[, c('nr1', 'nr2', 'nr3', 'nr4', 'nr5',  'nr6')] |> rowMeans()
fb22$nr_ges_z <- scale(fb22$nr_ges) # Standardisiert

# Weitere Standardisierugen
fb22$nerd_std <- scale(fb22$nerd)
fb22$neuro_std <- scale(fb22$neuro)
```


***

## 1. Fragestellung A: Erreichen Studenten im Nerdiness Personality Attributes-Test im Durchschnitt einen höheren Testwert als Studentinnen? {#Statistiken}

### 1.1 Vorbereitung (Daten aufbereiten)

Die Gruppierungsvariable in unserer Fragestellung muss für die Nutzung der Funktionen in `R` als Faktor vorliegen. Bei uns soll es um das Geschlecht gehen. Wir können wir mit `is.factor()` überprüfen, ob die Variable `geschl` im Datensatz ein Faktor ist. 


```r
is.factor(fb22$geschl)
```

```
## [1] FALSE
```

Diese Funktion gibt uns einen boolschen Wert (`TRUE` oder `FALSE`) wieder und beantwortet damit unsere Frage, ob das Geschlecht ein `factor` ist oder nicht. Wir sehen aufgrund der Antwort als `FALSE`, dass die Variable `geschl` nicht als Faktor vorliegt.

Allerdings haben wir in der Vorbereitung gesehen, dass wir bereits eine Variable erstellt haben, die das Geschlecht als Faktor repräsentiert. Diese hatten wir `geschl_faktor` genannt. Auch das können wir nochmal überprüfen:


```r
is.factor(fb22$geschl_faktor)
```

```
## [1] TRUE
```

Hier wird ein `TRUE` ausgegeben - die Variable ist also ein Faktor. Auch die `levels` können wir bestimmen


```r
levels(fb22$geschl_faktor)
```

```
## [1] "weiblich" "männlich" "anderes"
```

Der Faktor hat also 3` Stufen, die bei der Beantwortung möglich gewesen wären.

### 1.2. Deskriptivstatistik

Im ersten Schritt wollen wir uns die Daten deskriptiv anschauen. Das geht entweder grafisch oder deskriptivstatistisch.

#### 1.2.1. grafisch

Wir werfen zunächst vorbereitend einen tabellarischen Blick auf die Variable Geschlecht.


```r
table(fb22$geschl_faktor)
```

```
## 
## weiblich männlich  anderes 
##      125       23        1
```

Insgesamt gibt es nur eine Person, welche die Option "anderes" ausgewählt hat. Leider lässt sich über einen Datenpunkt allein keine Varianz bestimmen und auch keine Inferenzstatistik betreiben. Aus diesem Grund müssen wir uns hier auf "männlich" und "weiblich" beschränken und verwenden im Folgenden den gekürzten Datensatz `dataB`:


```r
# nur Männer und Frauen auswählen:
dataB <- fb22[ (fb22$geschl_faktor=="männlich"|fb22$geschl_faktor=="weiblich"), ]  
dataB$geschl_faktor <- droplevels(dataB$geschl_faktor) # levels aus den Datensatz entfernen, die keine Erhebungen haben
```

Mithilfe eines Boxplots, bzw. mithilfe von Histogrammen, lassen sich Unterschiede zwischen Gruppen gut untersuchen. Wir verwenden hier einige Zusatzeinstellungen, um die Grafiken übersichtlicher und auch ein wenig ansprechender zu gestalten.


```r
# Gruppierter Boxplot :
boxplot(dataB$nerd ~ dataB$geschl_faktor, 
        xlab="Geschlecht", ylab="Nerdiness", 
        las=1, cex.lab=1.5, 
        main="Nerdiness je nach Geschlecht")
```

![](/lehre/statistik-i/gruppenvergleiche-unabhaengig_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

```r
# Je ein Histogramm pro Gruppe, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert
par(mfrow=c(2,1), mar=c(3,2,2,0))
hist(dataB[(dataB$geschl_faktor=="weiblich"), "nerd"], main="Testwert (weiblich)", 
     xlim=c(0,6), xlab="", ylab="", las=1)
abline(v=mean(dataB[(dataB$geschl_faktor=="weiblich"), "nerd"], na.rm=T), col="aquamarine3", lwd=3)
hist(dataB[(dataB$geschl_faktor=="männlich"), "nerd"], main="Testwert (männlich)", 
     xlim=c(0,6), xlab="", ylab="", las=1)
abline(v=mean(dataB[(dataB$geschl_faktor=="männlich"), "nerd"], na.rm=T), col="darksalmon", lwd=3)
```

![](/lehre/statistik-i/gruppenvergleiche-unabhaengig_files/figure-html/unnamed-chunk-7-2.png)<!-- -->

`dataB$nerd ~ dataB$geschl_faktor` ist die Formelnotation in `R`, welche Sie im Rahmen der Regression noch genauer kennenlernen werden. Links von der `~` (Tilde) steht die abhängige Variable (hier der Testwert), deren Mittelwertsunterschiede durch die unabhängige Variable (hier Geschlecht) rechts der `~` erklärt werden soll. Der Befehl `par(mfrow=c(2,1), mar=c(3,2,2,0))` bewirkt, dass 2 Grafiken untereinander dargestellt werden - und zwar im selben Plot. Das Argument `mfrow` definiert ein Plot-Array mit der angebenen Anzahl von Zeilen und Spalten (wobei  mit `mfrow` die Plots zeilenweise verteilt werden; alternativ mit `mfcol`). Mit dem Argument `mar` werden für unten, links, oben und rechts die Randabstände spezifiziert.  Spielen Sie doch einmal selbst an den Einstellungen herum und schauen nach, was die Argumente jeweils bewirken!

Damit von nun an nicht immer zwei Grafiken in einem Plot dargestellt werden, können wir die Einstellungen folgendermaßen zurücksetzen:


```r
dev.off()
```

```
## null device 
##           1
```

#### 1.2.2. deskriptivstatistisch

Wir können uns auch Deskriptivstatistiken ansehen. Bspw. könnten wir uns die Mittelwerte oder die SDs etc. ausgeben lassen. Dazu nehmen wir entweder die `summary()` und wählen die entsprechenden Fälle aus oder wir machen uns das `psych`-Paket zunutze. Dieses muss zuvor installiert sein (`install.packages()`). Falls dem so ist, kann das Paket mit `library()` eingeladen werden. Die Funktion, die uns interessiert, heißt `describeBy()`, welche die Gruppenaufteilung bereits für uns übernimmt.


```r
# umständlich:
summary(dataB$nerd[(dataB$geschl_faktor=="weiblich")])  # Gruppe 1: Studentinnen
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##   1.500   2.667   3.167   3.104   3.500   4.667      10
```

```r
summary(dataB$nerd[(dataB$geschl_faktor=="männlich")]) # Gruppe 2: Studenten
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##   1.833   2.917   3.333   3.370   3.917   4.500      10
```

```r
# komfortabler:
library(psych)
describeBy(x = dataB$nerd, group = dataB$geschl_faktor)        # beide Gruppen im Vergleich 
```

```
## 
##  Descriptive statistics by group 
## group: weiblich
##    vars   n mean   sd median trimmed  mad min  max range  skew kurtosis
## X1    1 125  3.1 0.62   3.17     3.1 0.74 1.5 4.67  3.17 -0.05    -0.13
##      se
## X1 0.06
## ------------------------------------------------------- 
## group: männlich
##    vars  n mean   sd median trimmed  mad  min max range  skew kurtosis
## X1    1 23 3.37 0.69   3.33     3.4 0.74 1.83 4.5  2.67 -0.34    -0.71
##      se
## X1 0.14
```

Achtung, bei den hier berichteten `sd` handelt es sich nicht um die Stichprobenkennwerte, sondern um die Populationsschätzer. Daher berechnen wir die Standardabweichung auch nochmals per Hand:


```r
nerd_weiblich <- dataB$nerd[(dataB$geschl_faktor=="weiblich")]
sigma_weiblich <- sd(nerd_weiblich, na.rm = T)
n_weiblich <- length(nerd_weiblich[!is.na(nerd_weiblich)])
sd_weiblich <- sigma_weiblich * sqrt((n_weiblich-1) / n_weiblich)
sd_weiblich
```

```
## [1] 0.6206319
```

```r
nerd_männlich <- dataB$nerd[(dataB$geschl_faktor=="männlich")]
sigma_männlich <- sd(nerd_männlich, na.rm = T)
n_männlich <- length(nerd_männlich[!is.na(nerd_männlich)])
sd_männlich <- sigma_männlich * sqrt((n_männlich-1) / n_männlich)
sd_männlich
```

```
## [1] 0.6737962
```

### 1.3. Voraussetzungsprüfung {#Vorraussetzungen}

Damit wir den Ergebnissen des *t*-Tests trauen können, müssen dessen Voraussetzungen erfüllt sein.

**Voraussetzungen für die Durchführung des *t*-Tests**

1.  die abhängige Variable ist intervallskaliert $\rightarrow$ ok
2.  die einzelnen Messwerte sind voneinander unabhängig (Messwert einer Vpn hat keinen Einfluss auf den Messwert einer anderen) $\rightarrow$ ok\
3.  das untersuchte Merkmal ist in den Grundgesamtheiten der beiden Gruppen normalverteilt $\rightarrow$ (ggf.) optische Prüfung\
4.  Homoskedastizität: Varianzen der Variablen innerhalb der Populationen sind gleich $\rightarrow$ Levene-Test

**zu 3): Optische Prüfung auf Normalverteilung in den beiden Gruppen**

Falls das Merkmal in der Population normalverteilt ist und die Stichproben groß genug sind, darf diese Voraussetzung generell als erfüllt betrachtet werden ($\rightarrow$ Zentraler Grenzwertsatz). Für kleinere Stichproben empfiehlt sich eine optische Prüfung auf Normalverteilung. Zur optischen Prüfung auf Normalverteilung gibt es mehrere Möglichkeiten, von denen zwei im Folgenden erläutert und dann jeweils durchgeführt werden.

-   Möglichkeit 1: die bei Normalverteilung erwartete Dichtefunktion über das Histogramm legen und so die Übereinstimmung beurteilen\
-   Möglichkeit 2: QQ-Plot (quantile-quantile): es wird die beobachtete Position eines Messwerts gegen diejenige Position, die unter Gültigkeit der Normalverteilung zu erwarten wäre, abgetragen. Bei Normalverteilung liegen die Punkte (in etwa) auf einer Geraden.


```r
# Gruppe 1 (weiblich) 
par(mfrow=c(1,2))
nerd_weiblich <- dataB[(dataB$geschl_faktor=="weiblich"), "nerd"]
hist(nerd_weiblich, xlim=c(0,6), ylim=c(0,.8), main="Nerdiness Testwert (weiblich)", xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, mean=mean(nerd_weiblich, na.rm=T), sd=sd(nerd_weiblich, na.rm=T)), col="blue", lwd=2, add=T)
qqnorm(nerd_weiblich)
qqline(nerd_weiblich, col="blue")
```

<img src="/lehre/statistik-i/gruppenvergleiche-unabhaengig_files/figure-html/unnamed-chunk-11-1.png" style="display: block; margin: auto;" />

Mithilfe von `curve()` kann eine Linie in eine Grafik eingezeichnet werden. Hierbei bezeichnet `x` die x-Koordinate. `dnorm()` hatten wir bereits kennen gelernt. Diese Funktion beschreibt die Dichte der Normalverteilung. Die Normalverteilung ist eindeutig durch ihren Mittelwert und durch ihre Standardabweichung definiert. Wir müssen `dnorm()` also jeweils den empirischen Mittelwert sowie die empirische Standardabweichung übergeben. Das Argument `add = T` ist nötig, da sonst ein neuer Plot für die Kurve erstellt wird. Durch `add = T` wird sie dem Histogramm hinzugefügt. Damit die Dichte sichtbar ist, muss im Histogramm zuvor das Argument `probability = T` gewählt werden. Ansonsten würden absolute Häufigkeiten anstatt der relativen Häufigkeiten abgetragen werden. Den `qqnorm()`-Befehl hatten wir auch bereits kennen gelernt. Mit `qqline()` erhalten wir die nötige Linie, auf welcher die Punkte einigermaßen liegen müssen, damit sie als normalverteilt einzustufen sind.

$\rightarrow$ Normalverteilung kann für Gruppe 1 (weiblich) angenommen werden

Wir wiederholen die Befehle von zuvor auch für die zweite Gruppe:


```r
# Gruppe 2 (männlich)
par(mfrow=c(1,2))
nerd_männlich <- dataB[(dataB$geschl_faktor=="männlich"), "nerd"]
hist(nerd_männlich, xlim=c(0,6), ylim=c(0,.8), main="Nerdiness Testwert (männlich)", xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, mean=mean(nerd_männlich, na.rm=T), sd=sd(nerd_männlich, na.rm=T)), col="blue", lwd=2, add=T)
qqnorm(nerd_männlich)
qqline(nerd_männlich, col="blue")
```

<img src="/lehre/statistik-i/gruppenvergleiche-unabhaengig_files/figure-html/unnamed-chunk-12-1.png" style="display: block; margin: auto;" />

$\rightarrow$ Normalverteilung kann auch für Gruppe 2 (männlich) einigermaßen angenommen werden (hierbei ist zu beachten, dass die Gruppe der Studenten im Vergleich zur Gruppe der Studentinnen deutlich kleiner ist)

Damit von nun an nicht immer zwei Grafiken in einem Plot dargestellt werden, können wir die Einstellungen folgendermaßen zurücksetzen:


```r
dev.off()
```

```
## null device 
##           1
```

**zu 4) Test auf Homoskedastizität (Levene-Test)**

Das Hypothesenpaar im Levene-Test lautet:

-   $H_0$: Homoskedastizität ist gegeben.\
-   $H_1$: Homoskedastizität ist nicht gegeben.

Ein nicht-signifikantes Ergebnis (*p* \> .05) zeigt also Homoskedastizität an. Den Levene-Test können wir mit Hilfe des `car`-Pakets durchführen (dieses muss natürlich vorher installiert sein). Die nötige Funktion heißt `leveneTest()`. Sie nimmt eine Formel entgegen, die die Punktzahl ihrer jeweiligen Gruppe zuweist. Links von der `~` (Tilde) steht die abhängige Variable (hier der Nerdiness-Testwert), deren Mittelwertsunterschied durch die unabhängige Variable (hier Geschlecht) rechts der `~` erklärt werden soll. Wir merken uns also, dass die Gruppenzugehörigkeit rechts der `~` stehen muss.


```r
library(car)
leveneTest(dataB$nerd ~ dataB$geschl_faktor)
```

```
## Levene's Test for Homogeneity of Variance (center = median)
##        Df F value Pr(>F)
## group   1   0.569 0.4519
##       146
```



*F*(1,146) = 0.57, *p* = 0.452 $\rightarrow$ Das Ergebnis ist nicht signifikant, die $H_0$ wird beibehalten. Homoskedastizität wird angenommen.

Für Fragestellung A sind somit alle Voraussetzungen für die Durchführung des *t*-Test erfüllt. :-) Hätte der Levene-Test keine Homoskedastizität angezeigt (*p* \<. 05), so kann der *t*-Test trotzdem, nach Korrektur der Freiheitsgrade ("Welch-Korrektur"), durchgeführt werden (s.u.). Die Welch-Korrektur berücksichtigt die Unterschiedlichkeit der Varianzen und wird durch das Argument `var.equal = F` angefordert (sie ist im Übrigen auch der Default in `R`!).

### 1.4. Inferenzstatistik: *t*-Test {#t-Test}

Zur Erinnerung:

> Fragestellung A: "Erreichen Studentinnen und Studenten im Nerdiness Personality Attributes-Test im Durchschnitt gleich hohe Testwerte?"

$\rightarrow$ Fragestellung ist ungerichtet, erfordert also auch eine ungerichtete Hypothese.

**Hypothesen**

-   Art des Effekts: Unterschiedshypothese
-   Richtung des Effekts: Ungerichtet
-   Größe des Effekts: Unspezifisch

Hypothesenpaar (inhaltlich):

-   $H_0$: Studentinnen und Studenten unterscheiden sich nicht im Nerdiness-Testwert.\
-   $H_1$: Studentinnen und Studenten unterscheiden sich im Nerdiness-Testwert.

Hypothesenpaar (statistisch):

-   $H_0$: $\mu_\text{weiblich} = \mu_\text{männlich}$ bzw. $\mu_\text{weiblich} - \mu_\text{männlich} = 0$\
-   $H_1$: $\mu_\text{weiblich} \ne \mu_\text{männlich}$ bzw. $\mu_\text{weiblich} - \mu_\text{männlich} \ne 0$

**Signifikanzniveau**

Das Signifikanzniveau muss vor der Untersuchung festgelegt werden. Es soll hier 5% betragen. $\rightarrow \alpha=.05$

**Durchführung des *t*-Tests in R: Funktion `t.test()`**

Wir hatten im Rahmen des Einstichproben-*t*-Tests bereits die Funktion `t.test()` kennengelernt. Diese nutzen wir wieder. Wir übergeben dieser wieder die Formel, die wir bereits im Boxplot und im Levene-Test verwendet haben. Außerdem wählen wir einige Zusatzargumente, die dann zum Zweistichproben-*t*-Test für unabhängige Stichproben führt:


```r
t.test(dataB$nerd ~ dataB$geschl_faktor,       # abhängige Variable ~ unabhängige Variable
      paired = FALSE,                   # Stichproben sind unabhängig 
      alternative = "two.sided",        # zweiseitige Testung (Default)
      var.equal = TRUE,                 # Homoskedastizität liegt vor (-> Levene-Test)
      conf.level = .95)                 # alpha = .05 (Default)
```

```
## 
## 	Two Sample t-test
## 
## data:  dataB$nerd by dataB$geschl_faktor
## t = -1.8477, df = 146, p-value = 0.06667
## alternative hypothesis: true difference in means between group weiblich and group männlich is not equal to 0
## 95 percent confidence interval:
##  -0.5496253  0.0184949
## sample estimates:
## mean in group weiblich mean in group männlich 
##               3.104000               3.369565
```



*t*(*df* = 146, zweis.) = -1.848, *p* = 0.067 $\rightarrow$ nicht signifikant, $H_0$ wird beibehalten.

### 1.5. Berechnung der Effektstärke Cohen's *d* {#Effektstärke}

Wir wissen nun, dass sich die Mittelwertsdifferenz nicht auf die Population verallgemeinern lässt. Dennoch wollen wir zur Eindordnung des Ergebnisses die Effektstärke ermitteln: Cohen's *d* gibt den standardisierten Mittelwertsunterschied zwischen zwei Gruppen an. "Standardisiert" bedeutet, dass wir uns nicht mehr auf der Originalmetrik befinden (hier: Nerdiness-Testwert), sondern mit Standardabweichungen arbeiten. Ein Wert von 1 zeigt also an, dass sich die Gruppenmittelwerte um eine Standardabweichung voneinander unterscheiden. Die Effektstärke berechnet sich wie folgt:

$$ d = \frac{\bar{x}_1-\bar{x}_2} {\hat{\sigma}_{inn}} $$ wobei

$$ {\hat{\sigma}_{inn}} = \sqrt{ \frac{{\hat{\sigma}_1^2}*(n_1-1) + {\hat{\sigma}^2_2}*(n_2-1)} {(n_1-1) + (n_2-1)} }$$ Cohen (1988) hat folgende Konventionen zur Beurteilung der Effektstärke *d* vorgeschlagen, die man heranziehen kann, um den Effekt "bei kompletter Ahnungslosigkeit" einschätzen zu können (wissen wir mehr über den Sachverhalt, so sollten Effektstärken lieber im Bezug zu anderen Studienergebnissen interpretiert werden):

|  *d*  |  Interpretation  |
|:-----:|:----------------:|
| \~ .2 |  kleiner Effekt  |
| \~ .5 | mittlerer Effekt |
| \~ .8 |  großer Effekt   |

**Berechnung von Hand**

Wir führen die Berechnung von Cohen's *d* zunächst von Hand durch. Dafür speichern wir uns die nötigen Größen ab und wenden dann die präsentierte Formel an:


```r
nerd_weiblich <- dataB[(dataB$geschl_faktor=="weiblich"), "nerd"]
mw_weiblich <- mean(nerd_weiblich, na.rm=T)
n_weiblich <- length(nerd_weiblich[!is.na(nerd_weiblich)])
sigma_qu_weiblich <- var(nerd_weiblich, na.rm=T) 

nerd_männlich <- dataB[(dataB$geschl_faktor=="männlich"), "nerd"]
mw_männlich <- mean(nerd_männlich, na.rm=T)
n_männlich <- length(nerd_männlich[!is.na(nerd_männlich)])
sigma_qu_männlich <- var(nerd_männlich, na.rm=T) 

sigma_inn <- sqrt((sigma_qu_weiblich* (n_weiblich - 1) + sigma_qu_männlich* (n_männlich - 1)) / (n_weiblich-1 + n_männlich-1))

d1 <- (mw_weiblich - mw_männlich) / sigma_inn
d1
```

```
## [1] -0.419214
```

**Berechnung mit Funktion `cohen.d()`**

Natürlich gibt es in `R` auch eine angenehmere Alternative:


```r
#alternativ:
#install.packages("effsize")
library("effsize")
```


```r
d2 <- cohen.d(dataB$nerd, dataB$geschl_faktor, na.rm=T)
d2
```

```
## 
## Cohen's d
## 
## d estimate: -0.419214 (small)
## 95 percent confidence interval:
##       lower       upper 
## -0.87020194  0.03177397
```

Die Effektstärke für diesen Mittelwertsunterschied beträgt *d* = -0.419.

### 1.6. Ergebnisinterpretation

Es wurde untersucht, ob sich Studentinnen und Studenten in dem Nerdiness-Testwert unterscheiden. Tatsächlich findet sich deskriptiv ein Unterschied: Studentinnen weisen einen durchschnittlichen Wert von 3.104 (*SD* = 0.621) auf, während die Studenten einen Wert von 3.37 (*SD* = 0.674) aufweisen. Dies entspricht nach Cohens Konvention (1988) einem kleinen bis mittleren Effekt (*d* = -0.419).

Zur Beantwortung der Fragestellung wurde ein *t*-Test unter Annahme von Homoskedastizität (*F*(1,146) = 0.57, *p* = 0.452) durchgeführt. Der Gruppenunterschied ist nicht signifikant (*t*(*df* = 146, zweis.) = -1.848, *p* = 0.067), somit wird die Nullhypothese beibehalten und die Alternativhypothese nicht angenommen. Studentinnen und Studenten unterscheiden sich im Nerdiness-Testwert nicht bedeutsam.

***

## 2. Fragestellung B: Stimmen Studentinnen dem Item "Ich denke immer darüber nach, wie meine Taten sich auf die Umwelt auswirken" stärker zu als Studenten?

Wir widmen uns nun der 2. Fragestellung. Dazu prüen wir, ob Item nr2 ("Ich denke immer darüber nach, wie meine Taten sich auf die Umwelt auswirken") zur Messung von Naturverbundenheit von Studentinnen zustimmender beantwortet wird.

### 2.1 Vorbereitung (Daten einlesen, Daten aufbereiten)

Wir benutzen die für Fragestellung A aufbereiteten Daten (`dataB`) und müssen hier nichts weiter tun.

### 2.2. Deskriptivstatistik

Nun folgt die deskriptive Untersuchung, ob Unterschiede über das Geschlecht vorliegen.

#### 2.2.1. grafisch

Wir beginnen mit einer grafischen Auseinandersetzung mit der Fragestellung und erstellen einen Boxplot für die Variable nr2 pro Geschlecht.


```r
# Gruppierter Boxplot:
boxplot(dataB$nr2 ~ dataB$geschl_faktor, 
        xlab="Geschlecht", ylab="nr2", 
        las=1, cex.lab=1.5, 
        main="nr2 nach Geschlecht")
```

![](/lehre/statistik-i/gruppenvergleiche-unabhaengig_files/figure-html/unnamed-chunk-21-1.png)<!-- -->

Graphisch ist kein Unterschied zu erkennen.

#### 2.2.2. statistisch

Nun schauen wir uns das Ganze wieder deskriptivstatistisch an.


```r
describeBy(dataB$nr2, dataB$geschl_faktor) # beide Gruppen im Vergleich
```

```
## 
##  Descriptive statistics by group 
## group: weiblich
##    vars   n mean sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 125 3.78  1      4    3.86 1.48   1   5     4 -0.61    -0.29 0.09
## ------------------------------------------------------- 
## group: männlich
##    vars  n mean   sd median trimmed  mad min max range  skew kurtosis
## X1    1 23 3.39 1.12      4    3.47 1.48   1   5     4 -0.58    -0.37
##      se
## X1 0.23
```

```r
# Interquartilsbereich (IBQ) über summary()
summary( dataB[(dataB$geschl_faktor=="weiblich"), "nr2"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##   1.000   3.000   4.000   3.776   4.000   5.000      10
```

```r
summary( dataB[(dataB$geschl_faktor=="männlich"), "nr2"]) 
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##   1.000   3.000   4.000   3.391   4.000   5.000      10
```



Deskriptiv weist die Gruppe der männlichen Studierenden den gleichen Median auf wie die Gruppe der weiblichen Studierenden. Auch die Interquartilbereiche unterscheiden sich nicht.

### 2.3. Voraussetzungsprüfung

Um diese Beobachtung inferenzstatistisch zu untermauern, müssen wir den richtigen Test durchführen. Wir beginnen damit, die Voraussetzungen des *t*-Tests zu untersuchen:

**Voraussetzungen für die Durchführung des *t*-Tests:**

1.  die abhängige Variable ist intervallskaliert $\rightarrow$ nicht ok\
2.  die einzelnen Messwerte sind voneinander unabhängig (Messwert einer Vpn hat keinen Einfluss auf den Messwert einer anderen) $\rightarrow$ ok\
3.  das untersuchte Merkmal ist in den Grundgesamtheiten der beiden Gruppen normalverteilt $\rightarrow$ (ggf.) optische Prüfung\
4.  Homoskedastizität: Varianzen der Variablen innerhalb der Populationen sind gleich $\rightarrow$ Levene-Test

Da die erste Voraussetzung nicht erfüllt ist - das Item nr2 ist eine lediglich ordinalskalierte Variable - wollen wir nun einen Wilcoxon-Test (für unabhängige Stichproben) durchführen. Auch für diesen Test gilt es, Voraussetzungen zu untersuchen:

**Voraussetzungen für die Durchführung des Wilcoxon-Tests (für unabhängige Stichproben):**

1.  die abhängige Variable ist stetig (zumindest ordinal-skaliert) $\rightarrow$ ok\
2.  die einzelnen Messwerte sind voneinander unabhängig (Messwert einer Vpn hat keinen Einfluss auf den Messwert einer anderen) $\rightarrow$ ok\
3.  das Merkmal folgt in beiden Gruppen der gleichen Verteilung $\rightarrow$ (ggf.) optische Prüfung\
4.  Streuung der Variablen für beide Gruppen ist innerhalb der Populationen gleich $\rightarrow$ Folgt aus der Voraussetzung 3 $\rightarrow$  als Indiz können wir in bestimmten Fällen den Levene-Test nutzen


**zu 3): Optische Prüfung auf Vergleichbarkeit der Verteilungsform in den beiden Gruppen**


```r
#Gruppe 1 (weiblich) 
par(mfrow=c(1,2))

nr2_w <- dataB[(dataB$geschl_faktor=="weiblich"), "nr2"]
hist(nr2_w, xlim=c(0,6), ylim=c(0,.6), main="Item nr2 (weiblich)", xlab="", ylab="", las=1, probability=T, breaks = c(.5:5.5))

nr2_m <- dataB[(dataB$geschl_faktor=="männlich"), "nr2"]
hist(nr2_m, xlim=c(0,6), ylim=c(0,.6), main="Item nr2 (männlich)", xlab="", ylab="", las=1, probability=T, breaks = c(.5:5.5))
```

<img src="/lehre/statistik-i/gruppenvergleiche-unabhaengig_files/figure-html/unnamed-chunk-24-1.png" style="display: block; margin: auto;" />

$\rightarrow$ Vergleichbarkeit der Verteilungsform in den beiden Gruppen ist einigermaßen gegeben $\rightarrow$ spricht für Wilcoxon-Test


**zu 4) Test auf Gleichheit der Streuungen (Levene-Test)**

Das Hypothesenpaar im Levene-Test lautet:

-   $H_0$: Homoskedastizität ist gegeben.\
-   $H_1$: Homoskedastizität ist nicht gegeben.

Ein nicht-signifikantes Ergebnis (*p* \> .05) zeigt also Homoskedastizität an.


```r
library(car)
leveneTest(dataB$nr2 ~ dataB$geschl_faktor)
```

```
## Levene's Test for Homogeneity of Variance (center = median)
##        Df F value Pr(>F)
## group   1   0.757 0.3857
##       146
```



$F$(1, 146) = 0.76, p = 0.386 $\rightarrow$ $H_0$ wird beibehalten: Homoskedastizität wird angenommen

### 2.4. Inferenzstatistik: Wilcoxon-Test {#Wilcox}

Da die abhängige Variable (nr2) nur Ordinalskalenniveau aufweist, führen wir nun den Wilcoxon-Test (für unabhängige Stichproben) durch.

Zur Erinnerung:

> Fragestellung B: "Stimmen Studentinnen dem Item 'Ich denke immer darüber nach, wie meine Taten sich auf die Umwelt auswirken' (nr2) *stärker* zu als Studenten?"

$\rightarrow$ Fragestellung ist gerichtet, erfordert also auch eine gerichtete Hypothese.

**Hypothesen**

-   Art des Effekts: Unterschiedshypothese
-   Richtung des Effekts: Gerichtet
-   Größe des Effekts: Unspezifisch

Hypothesenpaar (inhaltlich):

-   $H_0$: Studentinnen stimmen Item nr2 weniger oder genauso stark zu wie Studenten.\
-   $H_1$: Studentinnen stimmen Item nr2 stärker zu als Studenten.

Hypothesenpaar (statistisch):

-   $H_0$: $\eta_\text{weiblich} \leq \eta_\text{männlich}$ bzw. $\eta_\text{weiblich} - \eta_\text{männlich} \leq 0$\
-   $H_1$: $\eta_\text{weiblich} \gt \eta_\text{männlich}$ bzw. $\eta_\text{weiblich} - \eta_\text{männlich} \gt 0$

**Signifikanzniveau**

Das Signifikanzniveau muss vor der Untersuchung festgelegt werden. Es soll hier 5% betragen. $\rightarrow \alpha = .05$

**Durchführung des Wilcoxon-Tests in R: Funktion `wilcox.test()`**

Die Funktion `wilcox.test()` nimmt im Grunde die gleichen Argumente entgegen wie die Funktion `t.test()`. Damit wir die gerichtete Hypothese in die richtige Richtung aufstellen können, müssen wir wissen, welches das erste Level des Faktors Geschlecht ist:


```r
levels(dataB$geschl_faktor) # wichtig zu wissen: die erste der beiden Faktorstufen ist "weiblich" 
```

```
## [1] "weiblich" "männlich"
```

Da die erste Faktorstufe "weiblich" ist, wissen wir, dass die gerichtete Hypothese "\>" lauten muss, also "greater":


```r
wilcox.test(dataB$nr2 ~ dataB$geschl_faktor,     # abhängige Variable ~ unabhängige Variable
            paired = FALSE,               # Stichproben sind unabhängig
            alternative = "greater",      # einseitige Testung, und zwar so, dass Gruppe1(w)-Gruppe2(m) > 0
            conf.level = .95)             # alpha = .05
```

```
## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  dataB$nr2 by dataB$geschl_faktor
## W = 1719.5, p-value = 0.05846
## alternative hypothesis: true location shift is greater than 0
```



$W$ = 1719.5, p = 0.058 $\rightarrow$ Ergebnis ist nicht signfikant, $H_0$ wird beibehalten.

### 2.5. Ergebnisinterpretation

Es wurde untersucht, ob Studentinnen dem Item "Ich denke immer darüber nach, wie meine Taten sich auf die Umwelt auswirken" (nr2) stäker zustimmen als Studenten. Deskriptiv besteht kein Unterschied in der Zustimmung: Beide Gruppen weisen einen Median von 4 auf ($IQB_w$ = [3; 4]; $IQB_m$ = [3; 4]). Zur Beantwortung der Fragestellung wurde ein Wilcoxon-Test durchgeführt. Der Gruppenunterschied über das Geschlecht ist nicht statistisch bedeutsam (*W* = 1719.5, *p* = 0.058). Somit wird die Nullhypothese beibehalten: Studentinnen stimmen Item nr2 nicht stärker zu als Studenten.

***

## 3. Fragestellung C: Haben Studierende mit Wohnort in Uninähe (Frankfurt) mit gleicher Wahrscheinlichkeit einen Nebenjob wie Studierende, deren Wohnort außerhalb von Frankfurt liegt? {#fragestellung-c}

Gehen wir nun zur 3. Fragestellung über. Wir verwenden wieder den vollen Datensatz `fb22`.

Zusätzlich zur Gruppenvariable ist in diesem Beispiel auch die abhängige Variable nominalskaliert. Um Fragen wie diese zu beantworten, werden daher die Populationswahrscheinlichkeiten (`job`: ja [`ja`] vs. nein [`nein`]) zwischen den beiden Gruppen (`ort`: Frankfurt [`FFM`] vs. außerhalb [`andere`]) miteinander verglichen. Diese Prüfung erfolgt mithilfe der $\chi^2$-Verteilung $\rightarrow \chi^2$-Test.

### 3.1. Datenaufbereitung

Zunächst müssen wir den `ort` und den `job` als Faktor abspeichern und entsprechende Labels vergeben. Damit wir hier keine Probleme bekommen, müssen wir zunächst prüfen, ob die Variablen ein `factor` sind:


```r
is.factor(fb22$ort)
```

```
## [1] FALSE
```

```r
is.factor(fb22$job)
```

```
## [1] FALSE
```

Dies ist bei beiden nicht der Fall, weswegen wir hier die Variable als Faktor ablegen können. Wir verwenden die Labels, die wir oben bereits in Klammern geschrieben haben.


```r
# Achtung, nur einmal durchführen (ansonsten Datensatz neu einladen und Code erneut durchlaufen lassen!)
fb22$ort <- factor(fb22$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb22$job <- factor(fb22$job, levels=c(1,2), labels=c("nein", "ja"))
```

### 3.2. Deskriptivstatistik/Voraussetzungsprüfung

Wir wollen wieder Deskriptivstatistiken betrachten und die Voraussetzungen des $\chi^2$-Tests prüfen.

**Voraussetzungen:**

1.  Die einzelnen Beobachtungen sind voneinander unabhängig $\rightarrow$ ok (durch das Studiendesign anzunehmen)
2.  Jede Person lässt sich eindeutig einer Kategorie bzw. Merkmalskombination zuordnen $\rightarrow$ ok (durch das Studiendesign anzunehmen)
3.  Zellbesetzung für alle $n_{ij}$ \> 5 $\rightarrow$ Prüfung anhand von Häufigkeitstabelle

**zu Punkt 3) Zellbesetzung *n* \> 5**

Jede Zelle muss mindestens 5 Fälle aufzeigen, da die Ergebnisse sonst verzerrt werden.


```r
tab <- table(fb22$ort, fb22$job)
tab
```

```
##          
##           nein ja
##   FFM       60 35
##   anderer   37 17
```

$\rightarrow n_{ij}$ \> 5 in allen Zellen gegeben.

### 3.3. Inferenzstatistische Beantwortung der Fragestellung

Kommen wir nun zur inferenzstatistischen Prüfung unserer Hypothese.

**Hypothesen**

-   Art des Effekts: Zusammenhangshypothese\
-   Richtung des Effekts: Ungerichtet\
-   Größe des Effekts: Unspezifisch

Hypothesenpaar (inhaltlich):

-   $H_0$: Studierende mit Wohnort in Uninähe haben mit gleicher Wahrscheinlichkeit einen Nebenjob wie Studierende, deren Wohnort außerhalb von Frankfurt liegt.\
-   $H_1$: Studierende mit Wohnort in Uninähe haben mit einer höheren oder niedrigeren Wahrscheinlichkeit einen Nebenjob als Studierende, deren Wohnort außerhalb von Frankfurt liegt.

Hypothesenpaar (statistisch):

-   $H_0$: $\pi_{ij} = \pi_{i\bullet} \cdot \pi_{\bullet j}$\
-   $H_1$: $\pi_{ij} \neq \pi_{i\bullet} \cdot \pi_{\bullet j}$

wobei $\pi_{ij}$ die Wahrscheinlichkeit, in Zelle $ij$ zu landen, ist. Betrachten wir die Häufigkeitstabelle, dann entspricht dies der Wahrscheinlichkeit der Ausprägung der $i$-ten Zeile (Variable: Wohnortnähe) und der $j$-ten Spalte (Variable: Nebenjob). $\pi_{i\bullet}$ beschreibt die Wahrscheinlichkeit, die Ausprägung der $i$-ten Zeile (Variable: Wohnortnähe) zu haben. $\pi_{\bullet j}$ beschreibt die Wahrscheinlichkeit, die Ausprägung der der $j$-ten Spalte (Variable: Nebenjob) zu haben. Die beiden betrachteten Variablen sind voneinander unabhängig, wenn die Wahrscheinlichkeit für das Auftreten von Y (Nebenjob) nicht davon abhängt, welches X (Wohnort) vorliegt. Ist dies der Fall, lässt sich die Wahrscheinlichkeit für das Auftreten der Kombination der Merkmalsausprägungen in das Produkt der Einzelwahrscheinlichkeiten zerlegen. Bspw. sollte sich die Wahrscheinlichkeit in Frankfurt zu wohnen und keinen Nebenjob zu haben, ausdrücken lassen (gleich sein) mit der Wahrscheinlichkeit in Frankfurt zu wohnen multipliziert mit der Wahrscheinlichkeit keinen Nebenjob zu haben: $\pi_\text{FFM,nein}=\pi_{\text{FFM},\bullet}\cdot\pi_{\bullet,\text{nein}}$ (unter $H_0$).

**Signifikanzniveau** $\alpha$

Die Irrtumswahrscheinlichkeit soll 5% betragen. $\rightarrow \alpha=.05$

#### 3.3.1. Vierfelder-$\chi^2$-Test in R: "manuelle" Berechnung über Formel {#Chi-Sq}

**erwartete Häufigkeiten berechnen**

Für jede Zelle lassen sich die unter Gültigkeit der Nullhypothese erwarteten Häufigkeiten $e_{ij}$ bestimmen (hier sind $n_{i\bullet}$ und $n_{\bullet j}$ die absoluten Häufigkeiten), die zu den Wahrscheinlichkeiten aus dem Hypothesenpaar gehören:

$$e_{ij} = \frac{n_{i\bullet} \cdot n_{\bullet j}}{n}$$

$n_{i\bullet}$ und $n_{\bullet j}$ lassen sich über die Randsummen bestimmen (sie symbolisieren eigentlich: $n_{i\bullet}=n\hat{\pi}_{i\bullet}$, mit $n$ als Stichprobengröße). Diese hängen wir unseren Daten an. Anschließend erstellen wir einen neuen Datensatz und fügen alle erwarteten Häufigkeiten dort ein.


```r
tab_mar <- addmargins(tab) # Randsummen zu Tabelle hinzufügen
tab_mar
```

```
##          
##           nein  ja Sum
##   FFM       60  35  95
##   anderer   37  17  54
##   Sum       97  52 149
```

```r
expected <- data.frame(nein=c((tab_mar[1,3]*tab_mar[3,1])/tab_mar[3,3],
                              (tab_mar[2,3]*tab_mar[3,1])/tab_mar[3,3]),
                       ja=c((tab_mar[1,3]*tab_mar[3,2])/tab_mar[3,3],
                            (tab_mar[2,3]*tab_mar[3,2])/tab_mar[3,3]))
expected
```

```
##       nein       ja
## 1 61.84564 33.15436
## 2 35.15436 18.84564
```

Bspw. für die Kombination (FFM, nein) ergibt sich eine erwartete Häufigkeit von 61.85, welcher eine beobachtete Häufigkeit von 60 gegenüber steht. Mit dem $\chi^2$-Test können wir nun bestimmen, ob diese Unterschiede statistisch bedeutsam groß sind.

**Prüfgröße** $\chi^2$ berechnen

Formel: $$\chi^2 = \sum_{i=1}^{2}{ \sum_{j=1}^{2}{ \frac{(n_{ij}-e_{ij})^2} {e_{ij}}}}$$


```r
chi_quadrat_Wert <- (tab[1,1]-expected[1,1])^2/expected[1,1]+
                    (tab[1,2]-expected[1,2])^2/expected[1,2]+
                    (tab[2,1]-expected[2,1])^2/expected[2,1]+
                    (tab[2,2]-expected[2,2])^2/expected[2,2]
chi_quadrat_Wert
```

```
## [1] 0.435471
```

**Signfikanztestung: per Vergleich von empirischem und kritischem** $\chi^2$

Die Freiheitsgrade berechnen sich aus der Anzahl der untersuchten Kategorien: $df = (p - 1) \cdot (k - 1)$. Hier, im Fall des Vierfelder-$\chi^2$-Tests also mit $df = 1$, wobei

-   *p*: Anzahl Kategorien Variable "ort" = 2\
-   *k*: Anzahl Kategorien Variable "job" = 2

Zur Bestimmung des kritischen Wertes und des $p$-Wertes ziehen wir die jeweiligen Funktionen der $\chi^2$ -Verteilung heran:


```r
qchisq(.95, 1) # kritischer Wert
```

```
## [1] 3.841459
```

```r
pchisq(chi_quadrat_Wert, 1, lower.tail = FALSE) # p-Wert
```

```
## [1] 0.5093166
```

Insgesamt ergibt sich damit.

-   *df* = 1
-   $\chi^2_{krit}$ = 3.84
-   $\chi^2_{emp}$ = 0.435
-   $\chi^2_{emp} < \chi^2_{krit}$ $\rightarrow H_0$ wird beibehalten
-   $p$ = 0.509
-   $p$-Wert \> $\alpha$-Fehlerniveau $\rightarrow H_0$ wird beibehalten

Daraus lässt sich zusammenfassen: Die Wohnnähe zur Uni hängt nicht damit zusammen, ob ein Nebenjob ausgeübt wird $\chi^2$(df=1)=0.435, $p$ = 0.509.

#### 3.3.2. Vierfelder-$\chi^2$-Test in R: Funktion `chisq.test()`

Die Funktion `chisq.test()` übernimmt die Arbeit für uns, wenn wir ihr einfach eine 4-Feldertabelle übergeben. Als Argumente brauchen wir hauptsächlich das Objekt mit den Häufigkeiten. Weiterhin müssen wir das Argument `correct` mit `FALSE` angeben. Ansonsten würde standardmäßig die Kontinuitätskorrektur nach Yates durchgeführt werden. Diese ist als Alternative gedacht, wenn nicht der $\chi^2$-Verteilung gefolgt wird. Ein Indiz dafür sind bspw. sehr kleine Zahlen in manchen Kombinationen der Faktoren. Da wir hier in jeder Zelle einen größeren Wert hatten, brauchen wir diese Korrektur nicht.


```r
chisq.test(tab,        # Kreuztabelle
           correct=F)  # keine Kontinuinitätskorrektur nach Yates
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  tab
## X-squared = 0.43547, df = 1, p-value = 0.5093
```

Das Ergebnis unterscheidet sich natürlich nicht zu unserer händischen Berechnung. Die Wohnnähe zur Uni hängt nicht damit zusammen, ob ein Nebenjob ausgeübt wird.

### 3.4. Effektstärken

Auch für den $\chi^2$-Test gibt es die Möglichkeit zur Einordnung der Effektstärke. Dabei haben Sie in der Vorlesung zwei Varianten kennengelernt. 

**Yules Q**

Dieses berechnet sich als

$$Q=\frac{n_{11}n_{22}-n_{12}n_{21}}{n_{11}n_{22}+n_{12}n_{21}},$$

welches einen Wertebereich von [-1,1] aufweist und analog zur Korrelation interpretiert werden kann. 1 steht in diesem Fall für einen perfekten positiven Zusammenhang (dazu in der entsprechenden Sitzung mehr).

In `R` sieht das so aus:


```r
effekt_YulesQ <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
                 (tab[1,1]*tab[2,2]+tab[1,2]*tab[2,1])
effekt_YulesQ
```

```
## [1] -0.1187905
```

**Phi** ($\phi$)

Auch kann man $\phi$ bestimmen:

$$\phi = \frac{n_{11}n_{22}-n_{12}n_{21}}{\sqrt{(n_{11}+n_{12})(n_{11}+n_{21})(n_{12}+n_{22})(n_{21}+n_{22})}}$$ welches einen Wertebereich von [-1,1] aufweist und analog zur Korrelation interpretiert werden kann. 1 steht in diesem Fall für einen perfekten positiven Zusammenhang (dazu in der entsprechenden Sitzung mehr).

In `R` sieht das so aus:


```r
effekt_phi <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
  sqrt((tab[1,1]+tab[1,2])*(tab[1,1]+tab[2,1])*(tab[1,2]+tab[2,2])*(tab[2,1]+tab[2,2]))
effekt_phi
```

```
## [1] -0.0540613
```

**Umsetzung mit `R`**

Das Ganze lässt sich auch mit dem `psych` und der darin enthaltenen Funktion `phi()` umsetzen:


```r
# alternativ mit psych Paket
library(psych)
phi(tab, digits = 8)
```

```
## [1] -0.0540613
```

```r
Yule(tab)
```

```
## [1] -0.1187905
```

```r
# Äquivalentes Ergebnis mittels Pearson-Korrelation (kommt in den nächsten Sitzungen)
# (dichotome Variablen)
ort_num <- as.numeric(fb22$ort)
job_num <- as.numeric(fb22$job)
cor(ort_num, job_num, use="pairwise")
```

```
## [1] -0.0540613
```

Cohen (1988) hat folgende Konventionen zur Beurteilung der Effektstärke $\phi$ vorgeschlagen, die man heranziehen kann, um den Effekt "bei kompletter Ahnungslosigkeit" einschätzen zu können (wissen wir mehr über den Sachverhalt, so sollten Effektstärken lieber im Bezug zu anderen Studienergebnissen interpretiert werden):

|  $|\phi|$  |  Interpretation  |
|:-----:|:----------------:|
| \~ .1 |  kleiner Effekt  |
| \~ .3 | mittlerer Effekt |
| \~ .5 |  großer Effekt   |

Der Wert für den Zusammenhang der beiden Variablen ist also bei völliger Ahnungslosigkeit als klein einzuschätzen.

### 3.5. Ergebnisinterpretation

Es wurde untersucht, ob Studierende mit Wohnort in Uninähe (also in Frankfurt) mit gleicher Wahrscheinlichkeit einen Nebenjob haben wie Studierende, deren Wohnort außerhalb von Frankfurt liegt. Zur Beantwortung der Fragestellung wurde ein Vierfelder-Chi-Quadrat-Test für unabhängige Stichproben berechnet. Der Zusammenhang zwischen Wohnort und Nebenjob ist nicht signifikant ($\chi^2$(1) = 0.435, *p* = 0.509), somit wird die Nullhypothese beibehalten. Der Effekt ist von vernachlässigbarer Stärke ($\phi$ = -0.054). Studierende mit Wohnort in Uninähe haben mit gleicher Wahrscheinlichkeit einen Nebenjob wie Studierende, deren Wohnort außerhalb von Frankfurt liegt.