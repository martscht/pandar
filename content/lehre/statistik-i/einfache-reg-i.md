---
title: "Regression I" 
type: post
date: '2019-10-18' 
slug: einfache-reg-i
categories: ["Statistik I"] 
tags: ["Regression", "Lineare Regression", "Streudiagramm", "Determinationskoeffizient"]
subtitle: ''
summary: 'In diesem Beitrag werden die einfache lineare Regression vorgestellt. Außerdem soll der Unterschied zwischen standardisierten und nicht-standardisierten Regressionsgewichten deutlich werden sowie die Berechnung des Determinationskoeffizienten R^2 und dessen Bedeutung geklärt werden.' 
authors: [winkler, neubauer, nehler, beitner]
weight: 11
lastmod: '2024-01-24'
featured: no
banner:
  image: "/header/modern_buildings.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/411588)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/einfache-reg-i
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-i/einfache-reg-i.R
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/einfache-reg-i-aufgaben
output:
  html_document:
    keep_md: true
---




{{< spoiler text = "Kernfragen dieser Lehreinheit" >}}
* Wie kann ein [Modell für den Zusammenhang](#Modell) von zwei Variablen erstellt werden?
* Wie können [Streudiagramme](#Streudiagramm) in R erstellt werden? Wie kann die Regressionsgerade in den Plot eingefügt werden?
* Wie können [standardisierte Regressionsgewichte](#Standardgewichte) geschätzt werden? Was ist der Unterschied zu nicht-standardisierten Regressionsgewichten?
* Wie wird der [Determinationskoeffizient $R^2$](#DetKoef) berechnet und was sagt er aus?
* Wie werden der [Determinationskoeffizient $R^2$](#Effekt) und der [Regressionsparameter _b_](#Inferenz) inferenzstatistisch überprüft?
{{< /spoiler >}}

***

## Vorbereitende Schritte {#prep}

Zu Beginn laden wir wie gewohnt den Datensatz und verteilen die relevanten Labels. Beachten Sie, dass diese Befehle bereits angewendet wurden. Wenn Sie die veränderten Daten abgespeichert oder noch aktiv haben, sind die folgenden Befehle natürlich nicht nötig.


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


****

## Einfache lineare Regression

Nachdem wir mit der Korrelation mit der gemeinsamen Betrachtung von zwei Variablen begonnen haben, werden wir jetzt lineare Modelle erstellen, uns Plots - inklusive Regressionsgerade - für Zusammenhänge anzeigen lassen und Determinationskoeffizienten berechnen. Korrelation und einfache Regression sind beides Verfahren, die sich mit dem Zusammenhang zweier Variablen befassen. Mithilfe einer Korrelation lässt sich die Stärke eines Zusammenhangs quantifizieren. Die einfache Regression hingegen verfolgt das Ziel, eine Variable mithilfe einer anderen Variable vorherzusagen. Die vorhergesagte Variable wird als Kriterium, Regressand oder auch abhängige Variable (AV) bezeichnet und üblicherweise mit $y$ symbolisiert. Die Variablen zur Vorhersage der abhängigen Variablen werden als Prädiktoren, Regressoren oder unabhängige Variablen (UV) bezeichnet und üblicherweise mit $x$ symbolisiert. Auch wenn wir in der Regression gezwungenermaßen einen gerichteten Zusammenhang angeben müssen (sprich, $x$ sagt $y$ vorher), so lässt eine Regression trotzdem keinen Schluss über kausale Zusammenhänge zu! Dies werden wir uns am Ende dieser Sitzung nochmal anschauen.


### Modellschätzung {#Modell}

Die Modellgleichung für die lineare Regression, wie sie in der Vorlesung besprochen wurde, lautet: $y_m = b_0 + b_1 x_m + e_m$

In R gibt es eine interne Schreibweise, die sehr eng an diese Form der Notation angelehnt ist. Mit `?formula` können Sie sich detailliert ansehen, welche Modelle in welcher Weise mit dieser Notation dargestellt werden können. R verwendet diese Notation für (beinahe) alle Modelle, sodass es sich lohnt, sich mit dieser Schreibweise vertraut zu machen. Die Kernelemente sind im Fall der linearen einfachen Regression:


```r
y ~ 1 + x
```

Diese Notation enthält fünf Elemente:

*  `y`: die abhängige Variable
*  `~`: die Notation für "regrediert auf" oder "vorhergesagt durch"
*  `1`: die Konstante 1
*  `+`: eine additive Verknüpfung der Elemente auf der rechten Seite der Gleichung
*  `x`: eine unabhängige Variable

Die Notation beschreibt also die Aussage "$y$ wird regrediert auf die Konstante $1$ und die Variable $x$". Die zu schätzenden Parameter $b_0$ und $b_1$ werden in dieser Notation nicht erwähnt, weil sie uns unbekannt sind.

R geht generell davon aus, dass immer auch der Achsenabschnitt $b_0$ geschätzt werden soll, sodass `y ~ x` ausreichend ist, um eine Regression mit einem Achsenabschnitt zu beschreiben. Wenn das Intercept unterdrückt werden soll, muss das mit `y ~ 0 + x` explizit gemacht werden.


Um nun eine einfache Regression an unserem Datensatz durchführen zu können, betrachten wir folgende Fragestellung:

* Zeigt die Extraversion (*extra*) aus dem Selbstbericht einen linearen Zusammenhang mit der selbst eingeschätzten "Nerdiness" (*nerd*)?

Für gewöhnlich würden Sie nun zuerst einmal die Voraussetzungen überprüfen. Diese werden wir in der kommenden [Sitzung](https://pandar.netlify.app//lehre/statistik-i/regression-ii/) ausführlich besprechen. Jetzt schauen wir uns die Daten erst einmal nur an. Dies tun wir mithilfe eines Scatterplots. Wenn wir darin den beobachteten lokalen Zusammenhang abbilden, können wir auch schon visuell beurteilen, ob der Zusammenhang denn auch linear ist.



```r
plot(fb23$extra, fb23$nerd, xlab = "Extraversion", ylab = "Nerdiness", 
     main = "Zusammenhang zwischen Extraversion und Nerdiness", xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb23$extra, fb23$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang
```

![](/lehre/statistik-i/einfache-reg-i_files/figure-html/unnamed-chunk-3-1.png)<!-- -->
 
 * `pch` verändert die Darstellung der Datenpunkte
 * `xlim` und `ylim` veränderen die X- bzw. Y-Achse 
 * mit `cex` könnte man noch die Größe der Datenpunkte anpassen

<b>Interpretation</b>: Eine lineare Beziehung scheint den Zusammenhang aus `extra` und `nerd` akkurat zu beschreiben. Ein bspw. u-förmiger Zusammenhang ist nicht zu erkennen.


In unserem Beispiel ist $x$ die Extraversion (`extra`) und $y$ die Nerdiness (`nerd`). Um das Modell zu schätzen, wird dann der `lm()` (für *linear model*) Befehl genutzt:


```r
lm(formula = nerd ~ 1 + extra, data = fb23)
```

```
## 
## Call:
## lm(formula = nerd ~ 1 + extra, data = fb23)
## 
## Coefficients:
## (Intercept)        extra  
##      3.7199      -0.2103
```

So werden die Koeffizienten direkt ausgegeben. Wenn wir mit dem Modell jedoch weitere Analysen durchführen möchten, müssen wir es einem Objekt im Environment zuweisen. Dafür legen wir es im Objekt `lin_mod` (steht für *lineares Modell*) ab. Hier in verkürzter Schreibweise (wir lassen die 1 als Repräsentant für den Achsenabschnitt weg):



```r
lin_mod <- lm(nerd ~ extra, fb23)                  #Modell erstellen und Ergebnisse im Objekt lin_mod ablegen
```

Aus diesem Objekt können mit `coef()` oder auch `lin_mod$coefficients` die geschätzten Koeffizienten extrahiert werden:


```r
coef(lin_mod) 
```

```
## (Intercept)       extra 
##   3.7198838  -0.2103006
```

```r
lin_mod$coefficients
```

```
## (Intercept)       extra 
##   3.7198838  -0.2103006
```

Falls man sich unsicher ist, wie dieses Modell zustande gekommen ist, kann man dies ausdrücklich erfragen:


```r
formula(lin_mod)
```

```
## nerd ~ extra
```

### Streu-Punktdiagramm mit Regressionsgerade {#Streudiagramm}

Das Streudiagramm haben wir zu Beginn schon abbilden lassen. Hier kann nun zusätzlich noch der geschätzte Zusammenhang zwischen den beiden Variablen als Regressiongerade eingefügt werden. Hierzu wird der Befehl `plot()` durch `abline()` ergänzt:


```r
# Scatterplot zuvor im Skript beschrieben
plot(fb23$extra, fb23$nerd, 
  xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb23$extra, fb23$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang
# Ergebnisse der Regression als Gerade aufnehmen
abline(lin_mod, col = 'red')
```

![](/lehre/statistik-i/einfache-reg-i_files/figure-html/unnamed-chunk-8-1.png)<!-- -->


In `lin_mod$coefficients` stehen die Regressionskoeffizienten $b_0$ unter `(Intercept)` zur Konstanten gehörend und $b_1$ unter dem Namen der Variable, die wir als Prädiktor nutzen. In diesem Fall also `extra`. Die Regressionsgleichung hat daher die folgende Gestalt: $y_i = 3.72 + -0.21 \cdot x + e_i$. 

Regressionsgleichung (unstandardisiert): 

$$\hat{y} = b_0 + b_1*x_m$$
$$\hat{y} = 3.72 + (-0.21)*x_m$$

**Interpretation der Regressionskoeffizienten:**  

* *$b_0$ (Achsenabschnitt)*: beträgt die Extraversion 0, wird eine Nerdiness von 3.72 vorhergesagt  
* *$b_1$ (Regressionsgewicht)*: mit jeder Steigerung der Extraversion um 1 Einheit wird eine um 0.21 Einheiten niedrigere (!) Nerdiness vorhergesagt


### Residuen Werte

Mit dem Befehl `lm()` werden auch automatisch immer die Residuen ($e_m$) geschätzt, die mit `residuals()` (oder alternativ: `resid()`) abgefragt werden können. Die Residuen betragen die Differenzen zu den vorhergesagten Werten bzw. zur Regressionsgeraden.


```r
residuals(lin_mod)
```

```
##            1            2            3            4            5            7 
##  1.182835060 -0.088981917 -0.545347963 -0.255648584  0.954652037  0.559802347 
##            8            9           10           11           12           13 
##  0.182835060  0.349501727  0.472534439 -0.088981917  0.893135681 -0.606864319 
##           14           15           16           17           18           19 
##  0.244351416 -0.176249825  0.472534439 -0.694132227  0.744351416  0.682835060 
##           20           21           22           23           24           25 
##  0.762233819  0.349501727 -0.360798894  0.139201106 -0.545347963  0.016168393 
##           26           27           28           29           30           31 
##  1.911018083 -0.088981917  0.121318704  0.411018083  0.121318704 -0.088981917 
##           32           33           34           35           36           37 
##  0.244351416 -0.273530986 -0.194132227  0.164952658  0.472534439 -0.465949204 
##           38           39           40           41           42           43 
## -0.299282537 -0.878681296 -0.001714009  0.393135681  0.639201106 -0.045347963 
##           44           45           46           47           48           49 
##  0.577684750  0.411018083  0.331619324 -0.712014630 -0.799282537  1.139201106 
##           50           51           52           53           54           55 
## -0.045347963  0.059802347  0.305867773 -0.360798894  0.516168393  0.226469014 
##           56           57           58           59           60           61 
## -0.273530986  1.349501727 -1.106864319  0.516168393 -0.922315250 -0.422315250 
##           62           63           64           65           66           67 
##  0.393135681  0.559802347 -0.606864319  0.595567152  0.454652037  0.621318704 
##           68           69           70           71           72           73 
##  0.972534439  0.621318704  0.428900486 -0.799282537 -0.545347963 -0.588981917 
##           74           75           76           77           78           79 
##  0.244351416 -1.817164940 -0.335047342 -0.817164940 -0.360798894 -0.255648584 
##           80           81           82           83           84           85 
##  0.077684750 -0.650498273 -1.483831607 -0.317164940 -0.378681296 -0.360798894 
##           86           87           88           89           90           91 
##  0.121318704  0.244351416 -0.027465561  0.516168393  0.182835060  0.911018083 
##           92           93           94           95           96           97 
##  0.534050796 -0.299282537  0.867384129  0.595567152 -0.378681296 -0.440197653 
##           98           99          101          102          103          104 
##  0.639201106  0.305867773  0.182835060 -0.650498273 -0.255648584 -0.588981917 
##          105          106          107          108          109          110 
## -0.440197653 -0.527465561 -0.755648584 -0.212014630  0.287985370 -0.150498273 
##          111          112          113          114          115          116 
##  0.744351416 -0.527465561  0.516168393  0.182835060 -0.694132227  0.305867773 
##          117          118          119          120          121          122 
## -0.212014630  0.621318704 -0.422315250  0.393135681 -0.237766181 -0.106864319 
##          123          124          126          127          128          129 
## -1.465949204 -0.483831607 -0.299282537  0.349501727  0.700717463  0.639201106 
##          130          131          132          133          134          135 
##  0.454652037 -0.799282537 -0.360798894  0.787985370  0.077684750  0.077684750 
##          136          137          138          139          140          141 
##  0.305867773 -0.527465561 -0.194132227 -0.071099514 -0.027465561 -1.255648584 
##          142          143          144          145          146          147 
## -0.273530986  0.034050796  0.831619324 -1.045347963  0.016168393  0.182835060 
##          148          149          150          151          152          153 
##  0.016168393  0.244351416 -0.422315250 -0.299282537  0.972534439 -0.212014630 
##          154          155          156          157          158          159 
## -0.378681296  1.139201106  0.287985370 -0.860798894 -0.001714009 -0.527465561 
##          160          161          162          163          164          165 
## -0.045347963  0.287985370 -0.835047342  1.516168393  0.059802347  0.121318704 
##          166          167          168          169          170          171 
## -0.440197653  0.182835060 -0.878681296 -0.755648584 -0.588981917  0.244351416 
##          172          173          174          175          176          177 
## -0.422315250 -0.360798894  0.831619324  0.657083509  0.954652037 -0.527465561 
##          178          179          180          181          182 
## -0.378681296 -0.817164940 -0.212014630  0.472534439 -1.132615871
```

Diese können auch als neue Variable im Datensatz angelegt werden und hätten dort die Bedeutung des "Ausmaßes an Nerdiness, das nicht durch Extraversion vorhergesagt werden kann" - also die Differenz aus vorhergesagtem und tatsächlich beobachtetem Wert der y-Variable (Nerdiness).


```r
fb23$res <- residuals(lin_mod)
```


### Vorhergesagte Werte

Die vorhergesagten Werte $\hat{y}$ können mit `predict()` ermittelt werden:


```r
predict(lin_mod)
```

```
##        1        2        3        4        5        7        8        9       10 
## 2.983832 3.088982 2.878681 3.088982 2.878681 2.773531 2.983832 2.983832 3.194132 
##       11       12       13       14       15       16       17       18       19 
## 3.088982 2.773531 2.773531 3.088982 3.509583 3.194132 3.194132 3.088982 2.983832 
##       20       21       22       23       24       25       26       27       28 
## 3.404433 2.983832 3.194132 3.194132 2.878681 2.983832 3.088982 3.088982 2.878681 
##       29       30       31       32       33       34       35       36       37 
## 3.088982 2.878681 3.088982 3.088982 2.773531 3.194132 2.668381 3.194132 3.299283 
##       38       39       40       41       42       43       44       45       46 
## 3.299283 2.878681 2.668381 2.773531 3.194132 2.878681 3.088982 3.088982 2.668381 
##       47       48       49       50       51       52       53       54       55 
## 2.878681 3.299283 3.194132 2.878681 2.773531 3.194132 3.194132 2.983832 2.773531 
##       56       57       58       59       60       61       62       63       64 
## 2.773531 2.983832 2.773531 2.983832 3.088982 3.088982 2.773531 2.773531 2.773531 
##       65       66       67       68       69       70       71       72       73 
## 3.404433 2.878681 2.878681 3.194132 2.878681 3.404433 3.299283 2.878681 3.088982 
##       74       75       76       77       78       79       80       81       82 
## 3.088982 2.983832 2.668381 2.983832 3.194132 3.088982 3.088982 2.983832 2.983832 
##       83       84       85       86       87       88       89       90       91 
## 2.983832 2.878681 3.194132 2.878681 3.088982 3.194132 2.983832 2.983832 3.088982 
##       92       93       94       95       96       97       98       99      101 
## 3.299283 3.299283 3.299283 3.404433 2.878681 2.773531 3.194132 3.194132 2.983832 
##      102      103      104      105      106      107      108      109      110 
## 2.983832 3.088982 3.088982 2.773531 3.194132 3.088982 2.878681 2.878681 2.983832 
##      111      112      113      114      115      116      117      118      119 
## 3.088982 3.194132 2.983832 2.983832 3.194132 3.194132 2.878681 2.878681 3.088982 
##      120      121      122      123      124      126      127      128      129 
## 2.773531 3.404433 2.773531 3.299283 2.983832 3.299283 2.983832 3.299283 3.194132 
##      130      131      132      133      134      135      136      137      138 
## 2.878681 3.299283 3.194132 2.878681 3.088982 3.088982 3.194132 3.194132 3.194132 
##      139      140      141      142      143      144      145      146      147 
## 3.404433 3.194132 3.088982 2.773531 3.299283 2.668381 2.878681 2.983832 2.983832 
##      148      149      150      151      152      153      154      155      156 
## 2.983832 3.088982 3.088982 3.299283 3.194132 2.878681 2.878681 3.194132 2.878681 
##      157      158      159      160      161      162      163      164      165 
## 3.194132 2.668381 3.194132 2.878681 2.878681 2.668381 2.983832 2.773531 2.878681 
##      166      167      168      169      170      171      172      173      174 
## 2.773531 2.983832 2.878681 3.088982 3.088982 3.088982 3.088982 3.194132 2.668381 
##      175      176      177      178      179      180      181      182 
## 3.509583 2.878681 3.194132 2.878681 2.983832 2.878681 3.194132 3.299283
```

Per Voreinstellung werden hier die vorhergesagten Werte aus unserem ursprünglichen Datensatz dargestellt. `predict()` erlaubt uns aber auch Werte von "neuen" Beobachtungen vorherzusagen. Nehmen wir an, wir würden die Extraversion von 5 neuen Personen beobachten (sie haben - vollkommen zufällig - die Werte 1, 2, 3, 4 und 5) und diese Beobachtungen in einem neuem Datensatz `extra_neu` festhalten:


```r
extra_neu <- data.frame(extra = c(1, 2, 3, 4, 5))
```

Anhand unseres Modells können wir für diese Personen auch ihre Nerdiness vorhersagen, obwohl wir diese nicht beobachtet haben:


```r
predict(lin_mod, newdata = extra_neu)
```

```
##        1        2        3        4        5 
## 3.509583 3.299283 3.088982 2.878681 2.668381
```

Damit diese Vorhersage funktioniert, muss im neuen Datensatz eine Variable mit dem Namen `extra` vorliegen. Vorhergesagte Werte liegen immer auf der Regressionsgeraden.

****

## Inferenzstatistische Überprüfung der Regressionsparameter _b_ {#Inferenz}

### Signifikanztestung der Regressionskoeffizienten

Nun möchten wir aber vielleicht wissen, ob der beobachtete Zusammenhang auch statistisch bedeutsam ist oder vielleicht nur durch Zufallen zustande gekommen ist. Zuerst kann die Betrachtung der Konfidenzintervalle helfen. Der Befehl `confint()` berechnet die Konfidenzintervalle der Regressionsgewichte.


```r
#Konfidenzintervalle der Regressionskoeffizienten
confint(lin_mod)
```

```
##                  2.5 %     97.5 %
## (Intercept)  3.3859075  4.0538600
## extra       -0.3087968 -0.1118044
```


Das Konfidenzintervall von -0.309 und -0.112 ist der Bereich, in dem wir den wahren Wert vermuten können. Zur Erinnerung: das 95% Konfidenzintervall  besagt, dass, wenn wir diese Studie mit der selben Stichprobengröße sehr oft wiederholen, 95% aller realisierten Konfidenzintervalle den wahren Wert für $b_1$ enthalten werden. Da die 0 nicht in diesem Intervall enthalten ist, ist 0 ein eher unwahrscheinlicher wahrer Wert für $b_1$.

* $b_1$  
    + H0: $b_1 = 0$, das Regressionsgewicht ist nicht von 0 verschieden.  
    + H1: $b_1 \neq 0$, das Regressionsgewicht ist von 0 verschieden. 
    
* $b_0$ (häufig nicht von Interesse)  
    + H0: $b_0 = 0$, der y-Achsenabschnitt ist nicht von 0 verschieden.  
    + H1: $b_0 \neq 0$, der y-Achsenabschnitt ist von 0 verschieden.  

Für beide Parameter ($b_1$ uns $b_0$) wird die H0 auf einem alpha-Fehler-Niveau von 5% verworfen, da die 0 nicht im jeweiligen 95% Konfidenzintervall enthalten ist.

Eine andere Möglichkeit zur interferenzstatistischen Überprüfung ergibt sich über die p-Werte der Regressionskoeffizienten. Diese werden über die `summary()`-Funktion ausgegeben. `summary()` fasst verschiedene Ergebnisse eines Modells zusammen und berichtet unter anderem auch Signifikanzwerte.


```r
#Detaillierte Modellergebnisse
summary(lin_mod)
```

```
## 
## Call:
## lm(formula = nerd ~ extra, data = fb23)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.81716 -0.42232 -0.00171  0.41996  1.91102 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.71988    0.16923  21.981   <2e-16 ***
## extra       -0.21030    0.04991  -4.214    4e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6033 on 177 degrees of freedom
## Multiple R-squared:  0.09116,	Adjusted R-squared:  0.08603 
## F-statistic: 17.75 on 1 and 177 DF,  p-value: 3.999e-05
```

Aus `summary()`: $p < \alpha$ $\rightarrow$ H1: Das Regressionsgewicht für den Prädiktor Extraversion ist signifikant von 0 verschieden. Der Zusammenhang von Extraversion und Nerdiness ist statistisch bedeutsam. 

Aus `summary()`: $p < \alpha$ $\rightarrow$ H1: der Achsenabschnitt ist signifikant von 0 verschieden. Beträgt die Extraversion 0 wird eine von 0 verschiedene Nerdiness vorhergesagt. 

Konfidenzinteralle und p-Werte für Regressionskoeffizienten kommen immer zu denselben Schlussfolgerungen in Bezug darauf, ob die H0 beibehalten oder verworfen wird!

****

### Determinationskoeffizient $R^2$ {#DetKoef}

Darüber hinaus können wir uns auch anschauen, wie gut unser aufgestelltes Modell generell zu den Daten passt und Varianz erklärt. Der Determinationskoeffizient $R^2$ ist eine Kennzahl zur Beurteilung der Anpassungsgüte einer Regression. Anhand dessen kann bewertet werden, wie gut Messwerte zu einem Modell passen. Das Bestimmtheitsmaß ist definiert als der Anteil, der durch die Regression erklärten Quadratsumme an der zu erklärenden totalen Quadratsumme. Es gibt somit an, wie viel Streuung in den Daten durch das vorliegende lineare Regressionsmodell „erklärt“ werden kann. Bei einer einfachen Regression entspricht $R^2$ dem Quadrat des Korrelationskoeffizienten, wie wir später noch sehen werden.

Um $R^2$ zu berechnen, gibt es verschiedene Möglichkeiten.

Für die Berechnung per Hand werden die einzelnen Varianzen benötigt:

$R^2 = \frac{s^2_{\hat{Y}}}{s^2_{Y}} = \frac{s^2_{\hat{Y}}}{s^2_{\hat{Y}} + s^2_{E}}$


```r
# Anhand der Varianz von lz
var(predict(lin_mod)) / var(fb23$nerd, use = "na.or.complete")
```

```
## [1] 0.09116145
```

```r
# Anhand der Summe der Varianzen
var(predict(lin_mod)) / (var(predict(lin_mod)) + var(resid(lin_mod)))
```

```
## [1] 0.09116145
```

Jedoch kann dieser umständliche Weg mit der Funktion `summary()`, die wir vorhin schon kennen gelernt haben, umgangen werden. Anhand des p-Werts kann hier auch die Signifikanz des $R^2$ überprüft werden.


```r
#Detaillierte Modellergebnisse
summary(lin_mod)
```

```
## 
## Call:
## lm(formula = nerd ~ extra, data = fb23)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.81716 -0.42232 -0.00171  0.41996  1.91102 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.71988    0.16923  21.981   <2e-16 ***
## extra       -0.21030    0.04991  -4.214    4e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6033 on 177 degrees of freedom
## Multiple R-squared:  0.09116,	Adjusted R-squared:  0.08603 
## F-statistic: 17.75 on 1 and 177 DF,  p-value: 3.999e-05
```

Determinationskoeffizient $R^2$ ist signifikant, da $p < \alpha$.

Der Determinationskoeffizient $R^2$ kann auch direkt über den Befehl `summary(lin_mod)$r.squared` ausgegeben werden:


```r
summary(lin_mod)$r.squared
```

```
## [1] 0.09116145
```



9.12% der Varianz von `nerd` können durch `extra` erklärt werden. Dieser Effekt ist nach Cohens (1988) Konvention als mittelstark zu bewerten, wenn keine Erkenntnisse in dem spezifischen Bereich vorliegen.

{{< intext_anchor Effekt >}}

**Cohens (1988) Konvention zur Interpretation von $R^2$:**  

Konventionen sind, wie bereits besprochen, heranzuziehen, wenn keine vorherigen Untersuchungen der Fragestellung oder zumindest in dem Forschungsbereich vorliegen. Die vorgeschlagenen Werte von $R^2$ entsprechen dabei dem Quadrat der in der [letzten Sitzung](/lehre/statistik-i/korrelation) genannten Konventionen für $r$.

* ~ .01: schwacher Effekt  
* ~ .09: mittlerer Effekt  
* ~ .25: starker Effekt  

****

### Standardisierte Regressionsgewichte {#Standardgewichte}

Bei einer Regression (besonders wenn mehr als ein Prädiktor in das Modell aufgenommen wird wie in der nächsten [Sitzung](/lehre/statistik-i/einfache-reg-ii/)) kann es sinnvoll sein, die standardisierten Regressionskoeffizienten zu betrachten, um die Erklärungs- oder Prognosebeiträge der einzelnen unabhängigen Variablen (unabhängig von den bei der Messung der Variablen gewählten Einheiten) miteinander vergleichen zu können, z. B. um zu sehen, welche Variable den größten Beitrag zur Prognose der abhängigen Variable leistet. Außerdem ist es hierdurch möglich, die Ergebnisse zwischen verschiedenen Studien zu vergleichen, die `nerd` und `extra` gemessen haben, jedoch in unterschiedlichen Einheiten. Durch die Standardisierung werden die Regressionskoeffizienten vergleichbar.
Die Variablen werden mit `scale()` standardisiert (z-Transformation; Erwartungswert gleich Null und die Varianz gleich Eins gesetzt). Mit `lm()` wird das Modell berechnet.


```r
s_lin_mod <- lm(scale(nerd) ~ scale(extra), fb23) # standardisierte Regression
s_lin_mod
```

```
## 
## Call:
## lm(formula = scale(nerd) ~ scale(extra), data = fb23)
## 
## Coefficients:
##  (Intercept)  scale(extra)  
##   -1.240e-16    -3.019e-01
```
Eine andere Variante, bei der die z-Standardisierung automatisch im Hintergrund passiert und nicht von uns manuell durch `scale()` erfolgen muss, liefert die Funktion `lm.beta()` aus dem gleichnamigen Paket `lm.beta`.   

Nach der (ggf. nötigen) Installation müssen wir das Paket für die Bearbeitung laden.


```r
# Paket erst installieren (wenn nötig): install.packages("lm.beta")
library(lm.beta)
```

Die Funktion `lm.beta()` muss auf ein Ergebnis der normalen `lm()`-Funktion angewendet werden. Wir haben dieses Ergebnis im Objekt `lin_mod` hinterlegt. Anschließend wollen wir uns für die Interpretation wieder das `summary()` ausgeben lassen. Natürlich kann man diese Schritte auch mit der Pipe lösen, was als Kommentar noch aufgeführt ist.


```r
lin_model_beta <- lm.beta(lin_mod)
summary(lin_model_beta) # lin_mod |> lm.beta() |> summary()
```

```
## 
## Call:
## lm(formula = nerd ~ extra, data = fb23)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.81716 -0.42232 -0.00171  0.41996  1.91102 
## 
## Coefficients:
##             Estimate Standardized Std. Error t value Pr(>|t|)    
## (Intercept)  3.71988           NA    0.16923  21.981   <2e-16 ***
## extra       -0.21030     -0.30193    0.04991  -4.214    4e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6033 on 177 degrees of freedom
## Multiple R-squared:  0.09116,	Adjusted R-squared:  0.08603 
## F-statistic: 17.75 on 1 and 177 DF,  p-value: 3.999e-05
```

Wir sehen, dass die ursprüngliche Ausgabe um die Spalte `standardized` erweitert wurde. An der standardisierten Lösung fällt auf, dass das Intercept als `NA` angezeigt wird. Dies liegt wie bereits besprochen daran, dass beim Standardisieren die Mittelwerte aller Variablen (Prädiktoren und Kriterium, bzw. unabhängige und abhängige Variable) auf 0 und die Standardabweichungen auf 1 gesetzt werden. Somit muss das Intercept hier genau 0 betragen, weshalb auf eine Schätzung verzichtet werden kann. 

Die Interpretation standardisierter Regressionsgewichte weicht leicht von der Interpration unstandardisierter Regressionsgewichte ab. Der Achsenabschnitt ist 0, da die Regressionsgerade durch den Mittelwert beider Variablen geht, die beide auch 0 sind. Das Regressionsgewicht hingegen beinhaltet die erwartete Veränderung von -0.21 Standardabweichungen in Nerdiness bei einer Standardabweichung mehr in Extraversion.

****

### Korrelation vs. Regression 

Wie bereits weiter oben angesprochen, gibt es bei der einfachen linearen Regression (1 Prädiktor) einen Zusammenhang zur Produkt-Moment-Korrelation. Dies wollen wir jetzt uns nochmal genauer anschauen.

In diesem Falle ist nämlich das standardisierte Regressionsgewicht identisch zur Produkt-Moment-Korrelation aus Prädiktor (`extra`) und Kriterium (`nerd`).


```r
cor(fb23$nerd, fb23$extra)   # Korrelation
```

```
## [1] -0.3019295
```

```r
coef(s_lin_mod)["scale(extra)"] # Regressionsgewicht
```

```
## scale(extra) 
##   -0.3019295
```

```r
round(coef(s_lin_mod)["scale(extra)"],3) == round(cor(fb23$nerd, fb23$extra),3)
```

```
## scale(extra) 
##         TRUE
```

Entsprechend ist das Quadrat der Korrelation identisch zum Determinationskoeffizienten des Modells mit standardisierten Variablen...


```r
cor(fb23$nerd, fb23$extra)^2   # Quadrierte Korrelation
```

```
## [1] 0.09116145
```

```r
summary(s_lin_mod)$r.squared  # Det-Koeffizient Modell mit standardisierten Variablen
```

```
## [1] 0.09116145
```

```r
round((cor(fb23$nerd, fb23$extra)^2),3) == round(summary(s_lin_mod)$r.squared, 3)
```

```
## [1] TRUE
```

... und unstandardisierten Variablen.


```r
cor(fb23$nerd, fb23$extra)^2   # Quadrierte Korrelation
```

```
## [1] 0.09116145
```

```r
summary(lin_mod)$r.squared  # Det-Koeffizient Modell mit unstandardisierten Variablen
```

```
## [1] 0.09116145
```

```r
round((cor(fb23$nerd, fb23$extra)^2),3) == round(summary(lin_mod)$r.squared, 3)
```

```
## [1] TRUE
```

Der standardisierte Korrelationskoeffizient in einer einfachen linearen Regression liefert also dieselben Informationen wie eine Produkt-Moment-Korrelation. Daraus wird auch ersichtlich, dass ein Regressionskoeffizient (genau wie eine Korrelation) nicht zulässt, auf die Richtung des Effekts (Kausalität) zu schließen. 
