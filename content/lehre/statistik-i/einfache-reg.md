---
title: "Einfache Lineare Regression" 
type: post
date: '2019-10-18' 
slug: einfache-reg
categories: ["Statistik I"] 
tags: ["Regression", "Lineare Regression", "Streudiagramm", "Determinationskoeffizient"]
subtitle: ''
summary: 'In diesem Beitrag werden die einfache lineare Regression vorgestellt. Außerdem soll der Unterschied zwischen standardisierten und nicht-standardisierten Regressionsgewichten deutlich werden sowie die Berechnung des Determinationskoeffizienten R² und dessen Bedeutung geklärt werden.' 
authors: [winkler, neubauer, nehler, beitner]
weight: 11
lastmod: '2025-04-07'
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
    url: /lehre/statistik-i/einfache-reg
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-i/einfache-reg.R
  - icon_pack: fas
    icon: pen-to-square
    name: Übungen
    url: /lehre/statistik-i/einfache-reg-uebungen
output:
  html_document:
    keep_md: true
---




<details><summary><b>Kernfragen dieser Lehreinheit</b></summary>

* Wie kann ein [Modell für den Zusammenhang](#Modell) von zwei Variablen erstellt werden?
* Wie können [Streudiagramme](#Streudiagramm) in R erstellt werden? Wie kann die Regressionsgerade in den Plot eingefügt werden?
* Wie können [standardisierte Regressionsgewichte](#Standardgewichte) geschätzt werden? Was ist der Unterschied zu nicht-standardisierten Regressionsgewichten?
* Wie wird der [Determinationskoeffizient $R^2$](#DetKoef) berechnet und was sagt er aus?
* Wie werden der [Determinationskoeffizient $R^2$](#Effekt) und der [Regressionsparameter _b_](#Inferenz) inferenzstatistisch überprüft?

</details>

***

## Vorbereitende Schritte {#prep}

Den Datensatz `fb24` haben wir bereits über diesen [{{< icon name="download" pack="fas" >}} Link heruntergeladen](/daten/fb24.rda) und können ihn über den lokalen Speicherort einladen oder Sie können Ihn direkt mittels des folgenden Befehls aus dem Internet in das Environment bekommen. Im letzten Tutorial und den dazugehörigen Aufgaben haben wir bereits Änderungen am Datensatz durchgeführt, die hier nochmal aufgeführt sind, um den Datensatz auf dem aktuellen Stand zu haben: 


``` r
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


****

## Einfache lineare Regression

Nachdem wir mit der Korrelation mit der gemeinsamen Betrachtung von zwei Variablen begonnen haben, werden wir jetzt lineare Modelle erstellen, uns Plots - inklusive Regressionsgerade - für Zusammenhänge anzeigen lassen und Determinationskoeffizienten berechnen. Korrelation und einfache Regression sind beides Verfahren, die sich mit dem Zusammenhang zweier Variablen befassen. Mithilfe einer Korrelation lässt sich die Stärke eines Zusammenhangs quantifizieren. Die einfache Regression hingegen verfolgt das Ziel, eine Variable mithilfe einer anderen Variable vorherzusagen. Die vorhergesagte Variable wird als Kriterium, Regressand oder auch abhängige Variable (AV) bezeichnet und üblicherweise mit $y$ symbolisiert. Die Variablen zur Vorhersage der abhängigen Variablen werden als Prädiktoren, Regressoren oder unabhängige Variablen (UV) bezeichnet und üblicherweise mit $x$ symbolisiert. Auch wenn wir in der Regression gezwungenermaßen einen gerichteten Zusammenhang angeben müssen (sprich, $x$ sagt $y$ vorher), so lässt eine Regression trotzdem keinen Schluss über kausale Zusammenhänge zu! Dies werden wir uns am Ende dieser Sitzung nochmal anschauen.


### Modellschätzung {#Modell}

Die Modellgleichung für die lineare Regression, wie sie in der Vorlesung besprochen wurde, lautet: $y_m = b_0 + b_1 x_m + e_m$

In R gibt es eine interne Schreibweise, die sehr eng an diese Form der Notation angelehnt ist. Mit `?formula` können Sie sich detailliert ansehen, welche Modelle in welcher Weise mit dieser Notation dargestellt werden können. R verwendet diese Notation für (beinahe) alle Modelle, sodass es sich lohnt, sich mit dieser Schreibweise vertraut zu machen. Die Kernelemente sind im Fall der linearen einfachen Regression:


``` r
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

Für gewöhnlich würden Sie nun zuerst einmal die Voraussetzungen überprüfen. Diese werden wir in der kommenden [Sitzung](/lehre/statistik-i/multiple-reg/) ausführlich besprechen. Jetzt schauen wir uns die Daten erst einmal nur an. Dies tun wir mithilfe eines Scatterplots. Wenn wir darin den beobachteten lokalen Zusammenhang abbilden, können wir auch schon visuell beurteilen, ob der Zusammenhang denn auch linear ist.



``` r
plot(fb24$extra, fb24$nerd, xlab = "Extraversion", ylab = "Nerdiness", 
     main = "Zusammenhang zwischen Extraversion und Nerdiness", xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb24$extra, fb24$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang
```

![](/einfache-reg_files/unnamed-chunk-3-1.png)<!-- -->
 
 * `pch` verändert die Darstellung der Datenpunkte
 * `xlim` und `ylim` veränderen die X- bzw. Y-Achse 
 * mit `cex` könnte man noch die Größe der Datenpunkte anpassen

<b>Interpretation</b>: Eine lineare Beziehung scheint den Zusammenhang aus `extra` und `nerd` akkurat zu beschreiben. Ein bspw. u-förmiger Zusammenhang ist nicht zu erkennen.


In unserem Beispiel ist $x$ die Extraversion (`extra`) und $y$ die Nerdiness (`nerd`). Um das Modell zu schätzen, wird dann der `lm()` (für *linear model*) Befehl genutzt:


``` r
lm(formula = nerd ~ 1 + extra, data = fb24)
```

```
## 
## Call:
## lm(formula = nerd ~ 1 + extra, data = fb24)
## 
## Coefficients:
## (Intercept)        extra  
##      3.8236      -0.2376
```

So werden die Koeffizienten direkt ausgegeben. Wenn wir mit dem Modell jedoch weitere Analysen durchführen möchten, müssen wir es einem Objekt im Environment zuweisen. Dafür legen wir es im Objekt `lin_mod` (steht für *lineares Modell*) ab. Hier in verkürzter Schreibweise (wir lassen die 1 als Repräsentant für den Achsenabschnitt weg):



``` r
lin_mod <- lm(nerd ~ extra, fb24)                  #Modell erstellen und Ergebnisse im Objekt lin_mod ablegen
```

Aus diesem Objekt können mit `coef()` oder auch `lin_mod$coefficients` die geschätzten Koeffizienten extrahiert werden:


``` r
coef(lin_mod) 
```

```
## (Intercept)       extra 
##   3.8235795  -0.2375652
```

``` r
lin_mod$coefficients
```

```
## (Intercept)       extra 
##   3.8235795  -0.2375652
```

Falls man sich unsicher ist, wie dieses Modell zustande gekommen ist, kann man dies ausdrücklich erfragen:


``` r
formula(lin_mod)
```

```
## nerd ~ extra
```

### Streu-Punktdiagramm mit Regressionsgerade {#Streudiagramm}

Das Streudiagramm haben wir zu Beginn schon abbilden lassen. Hier kann nun zusätzlich noch der geschätzte Zusammenhang zwischen den beiden Variablen als Regressiongerade eingefügt werden. Hierzu wird der Befehl `plot()` durch `abline()` ergänzt:


``` r
# Scatterplot zuvor im Skript beschrieben
plot(fb24$extra, fb24$nerd, 
  xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb24$extra, fb24$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang
# Ergebnisse der Regression als Gerade aufnehmen
abline(lin_mod, col = 'red')
```

![](/einfache-reg_files/unnamed-chunk-8-1.png)<!-- -->


In `lin_mod$coefficients` stehen die Regressionskoeffizienten $b_0$ unter `(Intercept)` zur Konstanten gehörend und $b_1$ unter dem Namen der Variable, die wir als Prädiktor nutzen. In diesem Fall also `extra`. Die Regressionsgleichung hat daher die folgende Gestalt: $y_i = 3.82 + -0.24 \cdot x + e_i$. 

Regressionsgleichung (unstandardisiert): 

$$\hat{y} = b_0 + b_1*x_m$$
$$\hat{y} = 3.82 + (-0.24)*x_m$$

**Interpretation der Regressionskoeffizienten:**  

* *$b_0$ (Achsenabschnitt)*: beträgt die Extraversion 0, wird eine Nerdiness von 3.82 vorhergesagt  
* *$b_1$ (Regressionsgewicht)*: mit jeder Steigerung der Extraversion um 1 Einheit wird eine um 0.24 Einheiten niedrigere (!) Nerdiness vorhergesagt


### Residuen Werte

Mit dem Befehl `lm()` werden auch automatisch immer die Residuen ($e_m$) geschätzt, die mit `residuals()` (oder alternativ: `resid()`) abgefragt werden können. Die Residuen betragen die Differenzen zu den vorhergesagten Werten bzw. zur Regressionsgeraden.


``` r
residuals(lin_mod)
```

```
##            1            2            3            4            5            6            7            8 
## -0.135753476 -0.539985357 -0.277550571  0.532768274  0.437000155 -0.087869417  0.293347976 -0.562999845 
##            9           10           11           12           13           14           15           16 
##  0.793347976 -1.277550571  0.937000155  0.937000155 -0.802420143 -0.825434631  0.460014643 -0.277550571 
##           17           18           19           20           21           22           23           24 
## -0.277550571  0.174565369  0.674565369  0.793347976  0.818217548  0.364246524 -0.039985357  0.699434941 
##           25           26           27           28           29           30           31           32 
## -1.610883905 -0.419347666 -0.825434631  0.080652334 -0.039985357 -0.992101297  0.484884214  1.078797250 
##           33           35           36           37           38           39           40           41 
##  0.341232036 -0.729666512 -0.158767964  0.745463917  1.437000155 -1.158767964  0.151550881  0.603666822 
##           42           43           44           45           46           47           48           49 
##  0.126681310  0.078797250  0.293347976 -1.039985357  0.174565369 -0.396333178 -0.206652024  1.055782762 
##           50           51           52           53           54           55           56           57 
##  0.412130583  0.055782762  0.555782762  0.626681310  0.293347976  0.389116095  0.341232036 -0.610883905 
##           58           59           60           61           62           63           64           65 
## -1.254536083  0.437000155  0.674565369 -0.229666512  0.126681310 -0.302420143 -0.754536083 -0.087869417 
##           66           67           68           69           70           71           72           73 
##  0.318217548  1.245463917 -0.110883905 -0.992101297  0.578797250 -0.610883905  1.078797250  0.960014643 
##           74           75           76           77           78           79           80           81 
##  0.222449429  0.078797250 -0.325434631  0.199434941 -0.373318690  0.412130583 -1.181782452 -0.633898393 
##           82           83           84           86           87           88           89           90 
##  0.818217548 -1.229666512 -0.421202750 -1.562999845 -0.396333178 -0.421202750 -0.087869417 -0.706652024 
##           91           92           93           94           95           96           97           98 
## -0.087869417  0.460014643  0.793347976 -1.087869417 -1.015115786  0.437000155 -0.992101297 -0.992101297 
##           99          100          101          102          103          104          105          106 
## -0.539985357 -0.825434631 -0.325434631 -0.039985357  1.103666822  0.245463917  0.197579857  0.460014643 
##          107          108          109          110          111          112          113          114 
##  0.507898703 -0.444217238  0.007898703  0.199434941  0.603666822  0.151550881 -0.110883905 -0.586014333 
##          115          116          117          118          119          120          121          122 
##  0.437000155  0.603666822 -0.492101297  0.626681310 -0.039985357  1.007898703  0.651550881  0.651550881 
##          123          124          125          126          127          128          129          130 
## -0.754536083 -0.373318690 -0.062999845  0.818217548  0.793347976  0.389116095 -0.635753476 -0.396333178 
##          131          132          133          134          135          136          137          138 
##  0.555782762 -0.133898393 -0.325434631  1.199434941  0.412130583 -0.086014333  0.697579857  0.078797250 
##          139          140          141          142          143          144          145          146 
## -1.039985357 -0.706652024  0.174565369 -0.539985357  0.151550881  0.055782762  0.484884214 -0.158767964 
##          147          148          149          150          151          152          153          154 
##  0.270333488 -1.777550571 -0.562999845  0.651550881  0.412130583  0.293347976 -0.658767964 -0.515115786 
##          155          156          157          158          159          160          161          162 
##  0.270333488  0.674565369  0.937000155  0.484884214  1.007898703  0.197579857  0.460014643 -0.373318690 
##          163          164          165          166          167          168          169          170 
##  0.530913191 -1.015115786 -0.396333178  0.270333488  0.412130583 -0.229666512 -0.848449119  0.222449429 
##          171          172          173          174          175          176          177          178 
## -0.706652024 -0.325434631 -0.681782452  0.080652334 -0.562999845  0.960014643  1.293347976  0.626681310 
##          179          180          181          182          183          184          185          186 
## -0.873318690 -0.396333178 -0.825434631  0.674565369 -0.896333178 -0.181782452  0.437000155  0.080652334 
##          187          188          189          190          191          192 
## -0.348449119  1.126681310  0.341232036 -0.610883905 -0.206652024 -1.302420143
```

Die Residuen haben die Bedeutung des "Ausmaßes an Nerdiness, das nicht durch Extraversion vorhergesagt werden kann" - also die Differenz aus vorhergesagtem und tatsächlich beobachtetem Wert der y-Variable (Nerdiness).

### Vorhergesagte Werte

Die vorhergesagten Werte $\hat{y}$ können mit `predict()` ermittelt werden:


``` r
predict(lin_mod)
```

```
##        1        2        3        4        5        6        7        8        9       10       11       12 
## 2.635753 2.873319 3.110884 3.467232 3.229667 2.754536 2.873319 3.229667 2.873319 3.110884 3.229667 3.229667 
##       13       14       15       16       17       18       19       20       21       22       23       24 
## 2.635753 2.992101 2.873319 3.110884 3.110884 2.992101 2.992101 2.873319 3.348449 2.635753 2.873319 3.467232 
##       25       26       27       28       29       30       31       32       33       35       36       37 
## 3.110884 3.586014 2.992101 3.586014 2.873319 2.992101 3.348449 2.754536 2.992101 3.229667 2.992101 2.754536 
##       38       39       40       41       42       43       44       45       46       47       48       49 
## 3.229667 2.992101 3.348449 3.229667 2.873319 2.754536 2.873319 2.873319 2.992101 3.229667 2.873319 3.110884 
##       50       51       52       53       54       55       56       57       58       59       60       61 
## 2.754536 3.110884 3.110884 2.873319 2.873319 3.110884 2.992101 3.110884 2.754536 3.229667 2.992101 3.229667 
##       62       63       64       65       66       67       68       69       70       71       72       73 
## 2.873319 2.635753 2.754536 2.754536 3.348449 2.754536 3.110884 2.992101 2.754536 3.110884 2.754536 2.873319 
##       74       75       76       77       78       79       80       81       82       83       84       86 
## 3.110884 2.754536 2.992101 3.467232 2.873319 2.754536 3.348449 3.467232 3.348449 3.229667 2.754536 3.229667 
##       87       88       89       90       91       92       93       94       95       96       97       98 
## 3.229667 2.754536 2.754536 2.873319 2.754536 2.873319 2.873319 2.754536 3.348449 3.229667 2.992101 2.992101 
##       99      100      101      102      103      104      105      106      107      108      109      110 
## 2.873319 2.992101 2.992101 2.873319 3.229667 2.754536 2.635753 2.873319 2.992101 3.110884 2.992101 3.467232 
##      111      112      113      114      115      116      117      118      119      120      121      122 
## 3.229667 3.348449 3.110884 3.586014 3.229667 3.229667 2.992101 2.873319 2.873319 2.992101 3.348449 3.348449 
##      123      124      125      126      127      128      129      130      131      132      133      134 
## 2.754536 2.873319 3.229667 3.348449 2.873319 3.110884 2.635753 3.229667 3.110884 3.467232 2.992101 3.467232 
##      135      136      137      138      139      140      141      142      143      144      145      146 
## 2.754536 3.586014 2.635753 2.754536 2.873319 2.873319 2.992101 2.873319 3.348449 3.110884 3.348449 2.992101 
##      147      148      149      150      151      152      153      154      155      156      157      158 
## 3.229667 3.110884 3.229667 3.348449 2.754536 2.873319 2.992101 3.348449 3.229667 2.992101 3.229667 3.348449 
##      159      160      161      162      163      164      165      166      167      168      169      170 
## 2.992101 2.635753 2.873319 2.873319 2.635753 3.348449 3.229667 3.229667 2.754536 3.229667 3.348449 3.110884 
##      171      172      173      174      175      176      177      178      179      180      181      182 
## 2.873319 2.992101 3.348449 3.586014 3.229667 2.873319 2.873319 2.873319 2.873319 3.229667 2.992101 2.992101 
##      183      184      185      186      187      188      189      190      191      192 
## 3.229667 3.348449 3.229667 3.586014 3.348449 2.873319 2.992101 3.110884 2.873319 2.635753
```

Per Voreinstellung werden hier die vorhergesagten Werte aus unserem ursprünglichen Datensatz dargestellt. `predict()` erlaubt uns aber auch Werte von "neuen" Beobachtungen vorherzusagen. Nehmen wir an, wir würden die Extraversion von 5 neuen Personen beobachten (sie haben - vollkommen zufällig - die Werte 1, 2, 3, 4 und 5) und diese Beobachtungen in einem neuem Datensatz `extra_neu` festhalten:


``` r
extra_neu <- data.frame(extra = c(1, 2, 3, 4, 5))
```

Anhand unseres Modells können wir für diese Personen auch ihre Nerdiness vorhersagen, obwohl wir diese nicht beobachtet haben:


``` r
predict(lin_mod, newdata = extra_neu)
```

```
##        1        2        3        4        5 
## 3.586014 3.348449 3.110884 2.873319 2.635753
```

Damit diese Vorhersage funktioniert, muss im neuen Datensatz eine Variable mit dem Namen `extra` vorliegen. Vorhergesagte Werte liegen immer auf der Regressionsgeraden.

****

## Inferenzstatistische Überprüfung der Regressionsparameter _b_ {#Inferenz}

### Signifikanztestung der Regressionskoeffizienten

Nun möchten wir aber vielleicht wissen, ob der beobachtete Zusammenhang auch statistisch bedeutsam ist oder vielleicht nur durch Zufallen zustande gekommen ist. Zuerst kann die Betrachtung der Konfidenzintervalle helfen. Der Befehl `confint()` berechnet die Konfidenzintervalle der Regressionsgewichte.


``` r
#Konfidenzintervalle der Regressionskoeffizienten
confint(lin_mod)
```

```
##                  2.5 %     97.5 %
## (Intercept)  3.5044578  4.1427013
## extra       -0.3307513 -0.1443791
```



Das Konfidenzintervall von -0.331 und -0.144 ist der Bereich, in dem wir den wahren Wert vermuten können. Zur Erinnerung: das 95% Konfidenzintervall  besagt, dass, wenn wir diese Studie mit der selben Stichprobengröße sehr oft wiederholen, 95% aller realisierten Konfidenzintervalle den wahren Wert für $b_1$ enthalten werden. Da die 0 nicht in diesem Intervall enthalten ist, ist 0 ein eher unwahrscheinlicher wahrer Wert für $b_1$.

* $b_1$  
    + H0: $b_1 = 0$, das Regressionsgewicht ist nicht von 0 verschieden.  
    + H1: $b_1 \neq 0$, das Regressionsgewicht ist von 0 verschieden. 
    
* $b_0$ (häufig nicht von Interesse)  
    + H0: $b_0 = 0$, der y-Achsenabschnitt ist nicht von 0 verschieden.  
    + H1: $b_0 \neq 0$, der y-Achsenabschnitt ist von 0 verschieden.  

Für beide Parameter ($b_1$ uns $b_0$) wird die H0 auf einem alpha-Fehler-Niveau von 5% verworfen, da die 0 nicht im jeweiligen 95% Konfidenzintervall enthalten ist.

Eine andere Möglichkeit zur interferenzstatistischen Überprüfung ergibt sich über die p-Werte der Regressionskoeffizienten. Diese werden über die `summary()`-Funktion ausgegeben. `summary()` fasst verschiedene Ergebnisse eines Modells zusammen und berichtet unter anderem auch Signifikanzwerte.


``` r
#Detaillierte Modellergebnisse
summary(lin_mod)
```

```
## 
## Call:
## lm(formula = nerd ~ extra, data = fb24)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -1.7775 -0.4801  0.0788  0.4787  1.4370 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.82358    0.16177  23.636  < 2e-16 ***
## extra       -0.23757    0.04724  -5.029 1.15e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6601 on 188 degrees of freedom
##   (2 Beobachtungen als fehlend gelöscht)
## Multiple R-squared:  0.1186,	Adjusted R-squared:  0.1139 
## F-statistic: 25.29 on 1 and 188 DF,  p-value: 1.146e-06
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


``` r
# Anhand der Varianz von lz
var(predict(lin_mod)) / var(fb24$nerd, use = "na.or.complete")
```

```
## [1] 0.1185758
```

``` r
# Anhand der Summe der Varianzen
var(predict(lin_mod)) / (var(predict(lin_mod)) + var(resid(lin_mod)))
```

```
## [1] 0.1185758
```

Jedoch kann dieser umständliche Weg mit der Funktion `summary()`, die wir vorhin schon kennen gelernt haben, umgangen werden. Anhand des p-Werts kann hier auch die Signifikanz des $R^2$ überprüft werden.


``` r
#Detaillierte Modellergebnisse
summary(lin_mod)
```

```
## 
## Call:
## lm(formula = nerd ~ extra, data = fb24)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -1.7775 -0.4801  0.0788  0.4787  1.4370 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.82358    0.16177  23.636  < 2e-16 ***
## extra       -0.23757    0.04724  -5.029 1.15e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6601 on 188 degrees of freedom
##   (2 Beobachtungen als fehlend gelöscht)
## Multiple R-squared:  0.1186,	Adjusted R-squared:  0.1139 
## F-statistic: 25.29 on 1 and 188 DF,  p-value: 1.146e-06
```

Determinationskoeffizient $R^2$ ist signifikant, da $p < \alpha$.

Der Determinationskoeffizient $R^2$ kann auch direkt über den Befehl `summary(lin_mod)$r.squared` ausgegeben werden:


``` r
summary(lin_mod)$r.squared
```

```
## [1] 0.1185758
```



11.86% der Varianz von `nerd` können durch `extra` erklärt werden. Dieser Effekt ist nach Cohens (1988) Konvention als mittelstark zu bewerten, wenn keine Erkenntnisse in dem spezifischen Bereich vorliegen.

{{< intext_anchor Effekt >}}

**Cohens (1988) Konvention zur Interpretation von $R^2$:**  

Konventionen sind, wie bereits besprochen, heranzuziehen, wenn keine vorherigen Untersuchungen der Fragestellung oder zumindest in dem Forschungsbereich vorliegen. Die vorgeschlagenen Werte von $R^2$ entsprechen dabei dem Quadrat der in der [letzten Sitzung](/lehre/statistik-i/korrelation) genannten Konventionen für $r$.

* ~ .01: schwacher Effekt  
* ~ .09: mittlerer Effekt  
* ~ .25: starker Effekt  

****

### Standardisierte Regressionsgewichte {#Standardgewichte}

Bei einer Regression (besonders wenn mehr als ein Prädiktor in das Modell aufgenommen wird wie in der nächsten [Sitzung](/lehre/statistik-i/multiple-reg/)) kann es sinnvoll sein, die standardisierten Regressionskoeffizienten zu betrachten, um die Erklärungs- oder Prognosebeiträge der einzelnen unabhängigen Variablen (unabhängig von den bei der Messung der Variablen gewählten Einheiten) miteinander vergleichen zu können, z. B. um zu sehen, welche Variable den größten Beitrag zur Prognose der abhängigen Variable leistet. Außerdem ist es hierdurch möglich, die Ergebnisse zwischen verschiedenen Studien zu vergleichen, die `nerd` und `extra` gemessen haben, jedoch in unterschiedlichen Einheiten. Durch die Standardisierung werden die Regressionskoeffizienten vergleichbar.
Die Variablen werden mit `scale()` standardisiert (z-Transformation; Erwartungswert gleich Null und die Varianz gleich Eins gesetzt). Mit `lm()` wird das Modell berechnet.


``` r
s_lin_mod <- lm(scale(nerd) ~ scale(extra), fb24) # standardisierte Regression
s_lin_mod
```

```
## 
## Call:
## lm(formula = scale(nerd) ~ scale(extra), data = fb24)
## 
## Coefficients:
##  (Intercept)  scale(extra)  
##     -0.00218      -0.34476
```
Gut zu wissen: `scale()` verwendet zur Standardisierung alle vorliegenden Werte der Variable. In unserem Datensatz hat allerdings eine Person einen  Wert auf `extra`, jedoch einen fehlenden Wert auf `nerd`. Die Standardisierung findet daher nicht an exakt den gleichen Personen statt.

Eine andere Variante, bei der die z-Standardisierung automatisch im Hintergrund passiert und nicht von uns manuell durch `scale()` erfolgen muss, liefert die Funktion `lm.beta()` aus dem gleichnamigen Paket `lm.beta`.   

Nach der (ggf. nötigen) Installation müssen wir das Paket für die Bearbeitung laden.


``` r
# Paket erst installieren (wenn nötig): install.packages("lm.beta")
library(lm.beta)
```

```
## Warning: Paket 'lm.beta' wurde unter R Version 4.4.2 erstellt
```

Die Funktion `lm.beta()` muss auf ein Ergebnis der normalen `lm()`-Funktion angewendet werden. Wir haben dieses Ergebnis im Objekt `lin_mod` hinterlegt. Anschließend wollen wir uns für die Interpretation wieder das `summary()` ausgeben lassen. Natürlich kann man diese Schritte auch mit der Pipe lösen, was als Kommentar noch aufgeführt ist.


``` r
lin_model_beta <- lm.beta(lin_mod)
summary(lin_model_beta) # lin_mod |> lm.beta() |> summary()
```

```
## 
## Call:
## lm(formula = nerd ~ extra, data = fb24)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -1.7775 -0.4801  0.0788  0.4787  1.4370 
## 
## Coefficients:
##             Estimate Standardized Std. Error t value Pr(>|t|)    
## (Intercept)  3.82358           NA    0.16177  23.636  < 2e-16 ***
## extra       -0.23757     -0.34435    0.04724  -5.029 1.15e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6601 on 188 degrees of freedom
##   (2 Beobachtungen als fehlend gelöscht)
## Multiple R-squared:  0.1186,	Adjusted R-squared:  0.1139 
## F-statistic: 25.29 on 1 and 188 DF,  p-value: 1.146e-06
```

Wir sehen, dass die ursprüngliche Ausgabe um die Spalte `standardized` erweitert wurde. An der standardisierten Lösung fällt auf, dass das Intercept als `NA` angezeigt wird. Dies liegt wie bereits besprochen daran, dass beim Standardisieren die Mittelwerte aller Variablen (Prädiktoren und Kriterium, bzw. unabhängige und abhängige Variable) auf 0 und die Standardabweichungen auf 1 gesetzt werden. Somit muss das Intercept hier genau 0 betragen, weshalb auf eine Schätzung verzichtet werden kann. 

Die Interpretation standardisierter Regressionsgewichte weicht leicht von der Interpration unstandardisierter Regressionsgewichte ab. Der Achsenabschnitt ist 0, da die Regressionsgerade durch den Mittelwert beider Variablen geht, die beide auch 0 sind. Das Regressionsgewicht hingegen beinhaltet die erwartete Veränderung von -0.24 Standardabweichungen in Nerdiness bei einer Standardabweichung mehr in Extraversion.

****

### Korrelation vs. Regression 

Wie bereits weiter oben angesprochen, gibt es bei der einfachen linearen Regression (1 Prädiktor) einen Zusammenhang zur Produkt-Moment-Korrelation. Dies wollen wir jetzt uns nochmal genauer anschauen.

In diesem Falle ist nämlich das standardisierte Regressionsgewicht identisch zur Produkt-Moment-Korrelation aus Prädiktor (`extra`) und Kriterium (`nerd`).


``` r
cor(fb24$nerd, fb24$extra, use = "pairwise")   # Korrelation
```

```
## [1] -0.3443484
```

``` r
coef(s_lin_mod)["scale(extra)"] # Regressionsgewicht
```

```
## scale(extra) 
##   -0.3447595
```

``` r
round(coef(s_lin_mod)["scale(extra)"],2) == round(cor(fb24$nerd, fb24$extra,use = "pairwise"),2)
```

```
## scale(extra) 
##         TRUE
```
Hier unterscheiden sich die Koeffizienten jedoch an der dritten Nachkommastlle. Das liegt daran, dass bei der Standardisierung von `extra` und `nerd` lediglich fehlende Werte auf der jeweiligen Variable ausgeschlossen werden mussten. Bei `cor()` müssen jedoch beide Variablen auf ihre fehlenden Werte hin betrachtet werden. Wie zuvor erwähnt, liegt in unserem Datensatz eine Person vor, die einen Wert auf `extra`, jedoch einen fehlenden Wert auf `nerd` aufweist. Der unterschiedliche Umgang mit fehlenden Werten führt hier daher zu einer kleinen Abweichung. Diese ist jedoch inhaltlich nicht relevant. Wir umgehen das Problem daher, indem wir uns lediglich die ersten beiden Nachkommastellen ausgebelen lassen.

Entsprechend ist das Quadrat der Korrelation identisch zum Determinationskoeffizienten des Modells mit standardisierten Variablen...


``` r
cor(fb24$nerd, fb24$extra,  use = "pairwise")^2   # Quadrierte Korrelation
```

```
## [1] 0.1185758
```

``` r
summary(s_lin_mod)$r.squared  # Det-Koeffizient Modell mit standardisierten Variablen
```

```
## [1] 0.1185758
```

``` r
round((cor(fb24$nerd, fb24$extra, use = "pairwise")^2),3) == round(summary(s_lin_mod)$r.squared, 3)
```

```
## [1] TRUE
```

... und unstandardisierten Variablen.


``` r
cor(fb24$nerd, fb24$extra,  use = "pairwise")^2   # Quadrierte Korrelation
```

```
## [1] 0.1185758
```

``` r
summary(lin_mod)$r.squared  # Det-Koeffizient Modell mit unstandardisierten Variablen
```

```
## [1] 0.1185758
```

``` r
round((cor(fb24$nerd, fb24$extra,  use = "pairwise")^2),3) == round(summary(lin_mod)$r.squared, 3)
```

```
## [1] TRUE
```

Der standardisierte Korrelationskoeffizient in einer einfachen linearen Regression liefert also dieselben Informationen wie eine Produkt-Moment-Korrelation. Daraus wird auch ersichtlich, dass ein Regressionskoeffizient (genau wie eine Korrelation) nicht zulässt, auf die Richtung des Effekts (Kausalität) zu schließen. 
