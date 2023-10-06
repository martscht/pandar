---
title: "Regression" 
type: post
date: '2019-10-18' 
slug: regression 
categories: ["Statistik I"] 
tags: ["Regression", "Lineare Regression", "Streudiagramm", "Determinationskoeffizient"]
subtitle: ''
summary: 'In diesem Beitrag werden die lineare Regression und ihre Voraussetzungen vorgestellt. Außerdem soll der Unterschied zwischen standardisierten und nicht-standardisierten Regressionsgewichten deutlich werden sowie die Berechnung des Determinationskoeffizienten R^2 und dessen Bedeutung geklärt werden.' 
authors: [winkler, neubauer, nehler]
weight: 9
lastmod: '2023-10-06'
featured: no
banner:
  image: "/header/BSc2_Regression.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/411588)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/regression
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-i/regression.R
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/regression-aufgaben
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

fb22$ort <- factor(fb22$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb22$job <- factor(fb22$job, levels=c(1,2), labels=c("nein", "ja"))
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

# Weitere Standardisierungen
fb22$nerd_std <- scale(fb22$nerd)
fb22$neuro_std <- scale(fb22$neuro)
```


****

## Lineare Regression

Nachdem wir mit der Korrelation mit der gemeinsamen Betrachtung von zwei Variablen begonnen haben, werden wir jetzt lineare Modelle erstellen, uns Plots - inklusive Regressionsgerade - für Zusammenhänge anzeigen lassen und Determinationskoeffizienten berechnen.
Hierzu betrachten wir folgende Fragestellung:

* Zeigt die Extraversion (*extra*) aus dem Selbstbericht einen linearen Zusammenhang mit der selbst eingeschätzten "Nerdiness" (*nerd*)?

### Voraussetzungen:

1. *Linearität*: Zusammenhang muss linear sein $\rightarrow$ Grafische Überprüfung (Scatterplot)  
2. *Varianzhomogenität (Homoskedastizität) der Fehler*: der Fehler jedes Wertes der UV hat annährend die gleiche Varianz  
3. *Normalverteilung der Fehlervariablen*  
4. *Unabhängigkeit der Fehler*  

Die Voraussetzungen 2-4 können erst geprüft werden, nachdem das Modell schon gerechnet wurde, weil sie sich auf die Fehler (Residuen: Differenz aus beobachtetem und vorhergesagtem Wert für y) beziehen!

Deshalb erstellen wir zunächst das Regressionsmodell - wir werden weiter unten diesen Befehl - die Funktion `lm()` genauer besprechen, für's erste ist wichtig zu wissen, dass die relevanten Ergebnisse des Regressionsmodells im Objekt `lin_mod` abgespeichert werden.


```r
lin_mod <- lm(nerd ~ extra, fb22)                  #Modell erstellen und Ergebnisse im Objekt lin_mod ablegen
```

**zu 1. Linearität: Zusammenhang muss linear sein $\rightarrow$ Grafische Überprüfung (Scatterplot)**


```r
plot(fb22$extra, fb22$nerd, xlab = "Extraversion", ylab = "Nerdiness", 
     main = "Zusammenhang zwischen Extraversion und Nerdiness", xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb22$extra, fb22$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang
```

![](/lehre/statistik-i/stat-i-regression_files/figure-html/unnamed-chunk-3-1.png)<!-- -->
 
 * `pch` verändert die Darstellung der Datenpunkte
 * `xlim` und `ylim` veränderen die X- bzw. Y-Achse 
 * mit `cex` könnte man noch die Größe der Datenpunkte anpassen

<b>Interpretation</b>: Eine lineare Beziehung scheint den Zusammenhang aus `extra` und `nerd` akkurat zu beschreiben. Ein bspw. u-förmiger Zusammenhang ist nicht zu erkennen.


**zu Voraussetzungen 2-4:**

Mithilfe der Ergebnisse aus dem Regressionsmodell im Objekt `lin_mod` können wir nun überprüfen, ob die weiteren Voraussetzungen der linearen Regression erfüllt sind. 


```r
par(mfrow = c(2, 2)) #vier Abbildungen gleichzeitig
plot(lin_mod)
```

![](/lehre/statistik-i/stat-i-regression_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

```r
par(mfrow = c(1, 1)) #wieder auf eine Abbildung zurücksetzen
```

*Interpretation der Abbildungen:*  

* *Residuals vs. Fitted*: geeignet um Abweichungen von der Linearität und Verletzungen der Homoskedastizität aufzudecken $\rightarrow$ soll möglichst unsystematisch aussehen, rote Anpassungslinie (y-MW bedingt auf X) verläuft parallel zur x-Achse  
* *Normal Q-Q*: Zeigt Annäherung der Normalverteilung durch Residuen $\rightarrow$ Punkte sollen auf die Diagonalen liegen  
* *Scale-Location*: Prüfung der Homoskedastizität, zeigt Zusammenhang zwischen Streuung der Residuen und vorhergesagten Werten $\rightarrow$ rote Anpassungslinie (y-MW bedingt auf X) sollte parallel zur x-Achse verlaufen
* *Residuals vs. Leverage*: Einflussreiche Datenpunkte liegen „weit draußen“, außerhalb einer der grau gestrichelten Linie.  Dies trifft auf keine Beobachtung in unserer Stichprobe zu (die grau gestrichelte Linie ist in dieser Abbildung nicht zu sehen; kein Punkt liegt außerhalb dieses Bereichs) $\rightarrow$  Somit lassen sich hier keine potentiell problematischen einflussreichen Datenpunkte identifizieren 

In diesem Fall ist alles weitestgehend erfüllt. Da wir uns hier im Rahmen einer grafischen Überprüfung befinden, ist es natürlich schwer direkte Richtlinien festzulegen. Die Fähigkeit zur Einordnung einer Verletzung stärkt sich mit der Erfahrung - also der Betrachtung im Rahmen von sehr vielen Analysen. Wir verweisen [hier](https://data.library.virginia.edu/diagnostic-plots/) zur Veranschaulichung auch auf ein Beispiel mit starken Verletzungen.


**Alternativer Weg zur Prüfung der Normalverteilung der Residuen**

Da wir uns die Residuen (also die Fehler in der Vorhersage) direkt vom Modell ausgeben lassen können, können wir zur Überprüfung ihrer Verteilung auch unsere schon bekannten Befehle nutzen. Hier wird nochmal ein Histogramm und ein QQ-Plot gezeichnet, weiterhin wird die inferenzstatistische Testung durchgeführt. 


```r
res1 <- residuals(lin_mod)   #Residuen speichern 

#QQ
qqnorm(res1)
qqline(res1)
```

![](/lehre/statistik-i/stat-i-regression_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```r
#Histogramm
hist(res1, prob = T,ylim = c(0,1))    #prob: TRUE, da wir uns auf die Dichte beziehen
curve(dnorm(x, 
            mean = mean(res1, na.rm = T), 
            sd = sd(res1, na.rm = T)),
      main = "Histogram of residuals", ylab = "Residuals",
      col = "blue", add = T)   #add: soll Kurve in Grafik hinzugefügt werden?
```

![](/lehre/statistik-i/stat-i-regression_files/figure-html/unnamed-chunk-5-2.png)<!-- -->

```r
#Shapiro
shapiro.test(res1)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  res1
## W = 0.99446, p-value = 0.8122
```

Die Plots weisen auf keine Verletzung der Annahme hin. Auch der p-Wert ist größer als .05 $\rightarrow$ Die Nullhypothese konnte nicht verworfen werden und wird beibehalten: Für die Residuen wird also Normalverteilung angenommen. Somit sind alle Voraussetzungen zur Durchführung der linearen Regression erfüllt.


### Modellschätzung {#Modell}

Die Modellgleichung für die lineare Regression, wie sie in der Vorlesung besprochen wurde, lautet: $y_m = b_0 + b_1 x_m + e_m$

In R gibt es eine interne Schreibweise, die sehr eng an diese Form der Notation angelehnt ist. Mit `?formula` können Sie sich detailliert ansehen, welche Modelle in welcher Weise mit dieser Notation dargestellt werden können. R verwendet diese Notation für (beinahe) alle Modelle, sodass es sich lohnt, sich mit dieser Schreibweise vertraut zu machen. Die Kernelemente sind im Fall der linearen Regression


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

In unserem Beispiel ist $x$ die Extraversion (`extra`) und $y$ die Nerdiness (`nerd`). Um das Modell zu schätzen, wird dann der `lm()` (für "linear model") Befehl genutzt:


```r
lm(formula = nerd ~ 1 + extra, data = fb22)
```

```
## 
## Call:
## lm(formula = nerd ~ 1 + extra, data = fb22)
## 
## Coefficients:
## (Intercept)        extra  
##      3.8554      -0.2156
```

So werden die Koeffizienten direkt ausgegeben. Wir haben das Modell bereits abgespeichert, da wir es für die Überprüfung der Voraussetzungen benötigt haben. Hierzu muss das Modell einem Objekt zugewiesen werden. Hier in verkürzter Schreibweise (wir lassen die 1 als Repräsentant für den Achsenabschnitt weg):


```r
lin_mod <- lm(nerd ~ extra, fb22)
```

Aus diesem Objekt können mit `coef()` die geschätzten Koeffizienten extrahiert werden:


```r
coef(lin_mod)
```

```
## (Intercept)       extra 
##   3.8553535  -0.2156064
```

Falls man sich unsicher ist, wie dieses Modell zustande gekommen ist, kann man dies ausdrücklich erfragen:


```r
formula(lin_mod)
```

```
## nerd ~ extra
## <environment: 0x15990b0b8>
```

Wie wir bereits weiter oben gesehen haben, werden mit dem Befehl `lm()` auch automatisch immer die Residuen ($e_m$) geschätzt, die mit `residuals()` (oder alternativ: `resid()`) abgefragt werden können.


```r
residuals(lin_mod)
```

```
##         1897         1898         1899         1900         1901         1902         1903         1904         1905 
## -0.595769219  0.953170506  1.394307035  0.173738771  0.850329183  0.458132379  0.570897447 -0.434064425  0.668776898 
##         1906         1907         1908         1909         1910         1912         1914         1915         1916 
##  0.389345163 -0.424140680  0.129760918  1.173738771  0.007072104 -0.541867621 -0.046829494 -0.095769219  0.070897447 
##         1917         1918         1919         1920         1921         1922         1923         1924         1925 
##  0.840405437 -0.875200955  0.065935575  0.394307035 -1.257474013  0.119837173  0.345367310  0.394307035 -0.149670817 
##         1926         1927         1928         1929         1930         1931         1932         1934         1935 
##  0.678700643  0.232602241  0.232602241 -0.051791367  0.453170506  0.060973702  0.619837173 -1.439026298 -0.321299357 
##         1936         1937         1938         1939         1940         1941         1942         1943         1944 
## -0.541867621  0.345367310  0.737564114  0.345367310  0.178700643  1.070897447  0.516995849 -0.375200955 -0.257474013 
##         1945         1946         1947         1948         1949         1950         1951         1953         1954 
##  0.948208633  0.291465712  0.453170506 -0.811375611  1.124799045  0.173738771 -0.546829494  0.119837173 -1.100731092 
##         1955         1956         1957         1958         1959         1960         1961         1962         1963 
##  0.458132379  1.007072104  0.340405437  0.056011829 -0.257474013  0.963094251 -1.262435886  0.286503839 -0.164556435 
##         1964         1965         1966         1967         1968         1969         1970         1971         1972 
## -0.159594563 -1.105692965  0.056011829  0.904230781  0.512033977  0.232602241  0.345367310 -0.600731092 -0.385124700 
##         1974         1975         1976         1977         1978         1979         1980         1981         1982 
## -0.331223102 -0.380162827 -0.375200955  0.012033977  0.012033977 -0.272359631 -0.434064425 -1.213496161 -0.595769219 
##         1985         1986         1987         1988         1989         1990         1991         1992         1994 
## -1.492927896  0.232602241  0.301389457 -0.767397759 -0.046829494  0.296427585  0.178700643 -0.875200955  0.512033977 
##         1995         1996         1997         1998         1999         2000         2001         2002         2003 
## -0.100731092  0.237564114 -0.154632690  0.070897447 -0.605692965  1.781541967  0.012033977 -1.041867621 -0.654632690 
##         2004         2006         2008         2009         2011         2012         2013         2017         2018 
## -0.321299357 -0.267397759 -0.992927896 -0.046829494  0.678700643 -0.713496161  0.178700643 -0.713496161 -0.708534288 
##         2021         2022         2023         2024         2027         2028         2031         2032         2034 
##  0.516995849  0.173738771 -0.159594563  0.953170506  0.463094251 -1.095769219  0.512033977 -0.036905749 -0.600731092 
##         2035         2036         2039         2040         2041         2042         2043         2044         2045 
## -0.429102553  0.012033977 -0.316337484 -1.036905749 -0.262435886  0.399268908 -0.659594563 -0.659594563 -0.370239082 
##         2046         2047         2048         2049         2050         2051         2052         2054         2058 
##  0.129760918 -1.105692965  0.512033977  0.345367310 -0.041867621  1.453170506  0.619837173  0.796427585 -0.434064425 
##         2060         2061         2062         2063         2065         2066         2067         2068         2069 
##  0.178700643 -0.487966023 -0.326261229  1.129760918  0.286503839  1.232602241 -0.659594563 -0.546829494  0.237564114 
##         2070         2071         2072         2073         2074         2075         2076         2077         2078 
##  0.737564114 -0.487966023 -0.551791367 -1.375200955  0.237564114  0.619837173  0.512033977  0.060973702 -0.605692965 
##         2079         2080         2081         2082         2083         2084 
## -0.041867621  0.399268908  0.458132379 -0.041867621 -0.100731092 -0.885124700
```

Diese können auch als neue Variable im Datensatz angelegt werden und hätten dort die Bedeutung des "Ausmaßes an Nerdiness, das nicht durch Extraversion vorhergesagt werden kann" - also die Differenz aus vorhergesagtem und tatsächlich beobachtetem Wert der y-Variable (Nerdiness).


```r
fb22$res <- residuals(lin_mod)
```

Die folgenden Ergebnisse aus `lin_mod` werden wir verwenden. In `lin_mod$coef` stehen die Regressionskoeffizienten $b_0$ unter `(Intercept)` zur Konstanten gehörend und $b_1$ unter dem Namen der Variable, die wir als Prädiktor nutzen. In diesem Fall also `extra`. Die Regressionsgleichung hat daher die folgende Gestalt: $y_i = 3.86 + -0.22 \cdot x + e_i$. 

Regressionsgleichung (unstandardisiert): 

$$\hat{y} = b_0 + b_1*x_m$$
$$\hat{y} = 3.86 + (-0.22)*x_m$$

**Interpretation der Regressionskoeffizienten:**  

* *b0 (Regressionsgewicht)*: beträgt die Extraversion 0, wird eine Nerdiness von 3.86 vorhergesagt  
* *b1 (Regressionsgewicht)*: mit jeder Steigerung der Extraversion um 1 Einheit wird eine um 0.22 Einheiten niedrigere (!) Nerdiness vorhergesagt

### Vorhergesagte Werte

Die vorhergesagten Werten $\hat{y}$ können mit `predict()` ermittelt werden:


```r
predict(lin_mod)
```

```
##     1897     1898     1899     1900     1901     1902     1903     1904     1905     1906     1907     1908     1909 
## 3.262436 3.046829 2.939026 2.992928 3.316337 3.208534 3.262436 3.100731 2.831223 2.777322 3.424141 3.370239 2.992928 
##     1910     1912     1914     1915     1916     1917     1918     1919     1920     1921     1922     1923     1924 
## 2.992928 3.208534 3.046829 3.262436 3.262436 2.992928 3.208534 3.100731 2.939026 3.424141 3.046829 3.154633 2.939026 
##     1925     1926     1927     1928     1929     1930     1931     1932     1934     1935     1936     1937     1938 
## 3.316337 3.154633 3.100731 3.100731 2.885125 3.046829 2.939026 3.046829 2.939026 3.154633 3.208534 3.154633 3.262436 
##     1939     1940     1941     1942     1943     1944     1945     1946     1947     1948     1949     1950     1951 
## 3.154633 3.154633 3.262436 3.316337 3.208534 3.424141 2.885125 3.208534 3.046829 3.478042 3.208534 2.992928 3.046829 
##     1953     1954     1955     1956     1957     1958     1959     1960     1961     1962     1963     1964     1965 
## 3.046829 3.100731 3.208534 2.992928 2.992928 2.777322 3.424141 3.370239 3.262436 3.046829 2.831223 2.992928 2.939026 
##     1966     1967     1968     1969     1970     1971     1972     1974     1975     1976     1977     1978     1979 
## 2.777322 3.262436 3.154633 3.100731 3.154633 3.100731 2.885125 2.831223 3.046829 3.208534 3.154633 3.154633 2.939026 
##     1980     1981     1982     1985     1986     1987     1988     1989     1990     1991     1992     1994     1995 
## 3.100731 3.046829 3.262436 2.992928 3.100731 3.531944 3.100731 3.046829 3.370239 3.154633 3.208534 3.154633 3.100731 
##     1996     1997     1998     1999     2000     2001     2002     2003     2004     2006     2008     2009     2011 
## 3.262436 3.154633 3.262436 2.939026 2.885125 3.154633 3.208534 3.154633 3.154633 3.100731 2.992928 3.046829 3.154633 
##     2012     2013     2017     2018     2021     2022     2023     2024     2027     2028     2031     2032     2034 
## 3.046829 3.154633 3.046829 3.208534 3.316337 2.992928 2.992928 3.046829 3.370239 3.262436 3.154633 3.370239 3.100731 
##     2035     2036     2039     2040     2041     2042     2043     2044     2045     2046     2047     2048     2049 
## 3.262436 3.154633 3.316337 3.370239 3.262436 3.100731 2.992928 2.992928 3.370239 3.370239 2.939026 3.154633 3.154633 
##     2050     2051     2052     2054     2058     2060     2061     2062     2063     2065     2066     2067     2068 
## 3.208534 3.046829 3.046829 3.370239 3.100731 3.154633 3.154633 2.992928 3.370239 3.046829 3.100731 2.992928 3.046829 
##     2069     2070     2071     2072     2073     2074     2075     2076     2077     2078     2079     2080     2081 
## 3.262436 3.262436 3.154633 2.885125 3.208534 3.262436 3.046829 3.154633 2.939026 2.939026 3.208534 3.100731 3.208534 
##     2082     2083     2084 
## 3.208534 3.100731 2.885125
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
## 3.639747 3.424141 3.208534 2.992928 2.777322
```

Damit diese Vorhersage funktioniert, muss im neuen Datensatz eine Variable mit dem Namen `extra` vorliegen.


### Streu-Punktdiagramm mit Regressionsgerade {#Streudiagramm}

Das Streudiagramm haben wir zu Beginn schon abbilden lassen. Hier kann zusätzlich noch der geschätzte Zusammenhang zwischen den beiden Variablen als Regressiongerade eingefügt werden. Hierzu wird der Befehl `plot()` durch `abline()` ergänzt:


```r
# Scatterplot zuvor im Skript beschrieben
plot(fb22$extra, fb22$nerd, 
  xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb22$extra, fb22$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang
# Ergebnisse der Regression als Gerade aufnehmen
abline(lin_mod, col = 'red')
```

![](/lehre/statistik-i/stat-i-regression_files/figure-html/unnamed-chunk-16-1.png)<!-- -->


### Standardisierte Regressionsgewichte {#Standardgewichte}

Bei einer Regression (besonders wenn mehr als ein Prädiktor in das Modell aufgenommen wird) kann es sinnvoll sein, die standardisierten Regressionskoeffizienten zu betrachten, um die Erklärungs- oder Prognosebeiträge der einzelnen unabhängigen Variablen (unabhängig von den bei der Messung der Variablen gewählten Einheiten) miteinander vergleichen zu können, z. B. um zu sehen, welche Variable den größten Beitrag zur Prognose der abhängigen Variable leistet. Außerdem ist es hierdurch möglich, die Ergebnisse zwischen verschiedenen Studien zu vergleichen, die `nerd` und `extra` gemessen haben, jedoch in unterschiedlichen Einheiten. Durch die Standardisierung werden die Regressionskoeffizienten vergleichbar.
Die Variablen werden mit `scale()` standardisiert (z-Transformation; Erwartungswert gleich Null und die Varianz gleich Eins gesetzt). Mit `lm()` wird das Modell berechnet.


```r
s_lin_mod <- lm(scale(nerd) ~ scale(extra), fb22)
s_lin_mod
```

```
## 
## Call:
## lm(formula = scale(nerd) ~ scale(extra), data = fb22)
## 
## Coefficients:
##  (Intercept)  scale(extra)  
##    8.487e-16    -2.335e-01
```

****

### Determinationskoeffizient $R^2$ {#DetKoef}

Der Determinationskoeffizient $R^2$ ist eine Kennzahl zur Beurteilung der Anpassungsgüte einer Regression. Anhand dessen kann bewertet werden, wie gut Messwerte zu einem Modell passen.
Das Bestimmtheitsmaß ist definiert als der Anteil, der durch die Regression erklärten Quadratsumme an der zu erklärenden totalen Quadratsumme. Es gibt somit an, wie viel Streuung in den Daten durch das vorliegende lineare Regressionsmodell „erklärt“ werden kann. Bei einer einfachen Regression entspricht $R^2$ dem Quadrat des Korrelationskoeffizienten.

Um $R^2$ zu berechnen, gibt es verschiedene Möglichkeiten.

Für die Berechnung per Hand werden die einzelnen Varianzen benötigt:

$R^2 = \frac{s^2_{\hat{Y}}}{s^2_{Y}} = \frac{s^2_{\hat{Y}}}{s^2_{\hat{Y}} + s^2_{E}}$


```r
# Anhand der Varianz von lz
var(predict(lin_mod)) / var(fb22$nerd, use = "na.or.complete")
```

```
## [1] 0.05451483
```

```r
# Anhand der Summe der Varianzen
var(predict(lin_mod)) / (var(predict(lin_mod)) + var(resid(lin_mod)))
```

```
## [1] 0.05451483
```

Jedoch kann dieser umständliche Weg umgangen werden.
Mit der Funktion `summary()` kann ein Überblick über verschiedene Ergebnisse eines Modells gewonnen werden. Für lineare Modelle werden mit diesem Befehl unter anderem auch die Koeffizienten angezeigt. Anhand des p-Werts kann hier auch die Signifikanz des $R^2$ überprüft werden.


```r
#Detaillierte Modellergebnisse
summary(lin_mod)
```

```
## 
## Call:
## lm(formula = nerd ~ extra, data = fb22)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.49293 -0.43406  0.05601  0.39927  1.78154 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.85535    0.24733  15.588  < 2e-16 ***
## extra       -0.21561    0.07166  -3.009  0.00306 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6359 on 157 degrees of freedom
## Multiple R-squared:  0.05451,	Adjusted R-squared:  0.04849 
## F-statistic: 9.052 on 1 and 157 DF,  p-value: 0.003057
```

Determinationskoeffizient $R^2$ ist signifikant, da $p < \alpha$.

Der Determinationskoeffizient $R^2$ kann auch direkt über den Befehl `summary(lin_mod)$r.squared` ausgegeben werden:


```r
summary(lin_mod)$r.squared
```

```
## [1] 0.05451483
```



5.45% der Varianz von `nerd` können durch `extra` erklärt werden. Dieser Effekt ist nach Cohens (1988) Konvention als schwach bis mittelstark zu bewerten, wenn keine Erkenntnisse in dem spezifischen Bereich vorliegen.

{{< intext_anchor Effekt >}}

**Cohens (1988) Konvention zur Interpretation von $R^2$:**  

Konventionen sind, wie bereits besprochen, heranzuziehen, wenn keine vorherigen Untersuchungen der Fragestellung oder zumindest in dem Forschungsbereich vorliegen. Die vorgeschlagenen Werte von $R^2$ entsprechen dabei dem Quadrat der in der [letzten Sitzung](/lehre/statistik-i/korrelation) genannten Konventionen für $r$.

* ~ .01: schwacher Effekt  
* ~ .09: mittlerer Effekt  
* ~ .25: starker Effekt  

****

### Korrelation vs. Regression 

Im Falle einer einfachen linearen Regression (1 Prädiktor) ist das standardisierte Regressionsgewicht identisch zur Produkt-Moment-Korrelation aus Prädiktor (`extra`) und Kriterium (`nerd`)


```r
cor(fb22$nerd, fb22$extra)   # Korrelation
```

```
## [1] -0.2334841
```

```r
s_lin_mod <- lm(scale(nerd) ~ scale(extra), fb22) # Regression mit standardisierten Variablen
s_lin_mod
```

```
## 
## Call:
## lm(formula = scale(nerd) ~ scale(extra), data = fb22)
## 
## Coefficients:
##  (Intercept)  scale(extra)  
##    8.487e-16    -2.335e-01
```

```r
round(coef(s_lin_mod)["scale(extra)"],3) == round(cor(fb22$nerd, fb22$extra),3)
```

```
## scale(extra) 
##         TRUE
```

Entsprechend ist das Quadrat der Korrelation identisch zum Determinationskoeffizienten des Modells mit standardisierten Variablen...

```r
cor(fb22$nerd, fb22$extra)^2   # Quadrierte Korrelation
```

```
## [1] 0.05451483
```

```r
summary(s_lin_mod)$ r.squared  # Det-Koeffizient Modell mit standardisierten Variablen
```

```
## [1] 0.05451483
```

```r
round((cor(fb22$nerd, fb22$extra)^2),3) == round(summary(s_lin_mod)$ r.squared, 3)
```

```
## [1] TRUE
```
... und unstandardisierten Variablen

```r
cor(fb22$nerd, fb22$extra)^2   # Quadrierte Korrelation
```

```
## [1] 0.05451483
```

```r
summary(lin_mod)$ r.squared  # Det-Koeffizient Modell mit unstandardisierten Variablen
```

```
## [1] 0.05451483
```

```r
round((cor(fb22$nerd, fb22$extra)^2),3) == round(summary(lin_mod)$ r.squared, 3)
```

```
## [1] TRUE
```

Der standardisierte Korrelationskoeffizient in einer einfachen linearen Regression liefert also dieselben Informationen wie eine Produkt-Moment-Korrelation. Daraus wird auch ersichtlich, dass ein Regressionskoeffizient (genau wie eine Korrelation) nicht zulässt, auf die Richtung des Effekts (Kausalität) zu schließen. 


****

## Inferenzstatistische Überprüfung der Regressionsparameter _b_ {#Inferenz}


**Signifikanztestung der Regressionskoeffizienten:**

Zuerst kann die Betrachtung der Konfidenzintervalle helfen. Der Befehl `confint()` berechnet die Konfidenzintervalle der Regressionsgewichte.

```r
#Konfidenzintervalle der Regressionskoeffizienten
confint(lin_mod)
```

```
##                  2.5 %      97.5 %
## (Intercept)  3.3668258  4.34388110
## extra       -0.3571501 -0.07406269
```

Das Konfidenzintervall von -0.357 und -0.074 ist der Bereich, in dem wir den wahren Wert vermuten können. Zur Erinnerung: das 95% Konfidenzintervall  besagt, dass, wenn wir diese Studie mit der selben Stichprobengröße sehr oft wiederholen, 95% aller realisierten Konfidenzintervalle den wahren Wert für $b_1$ enthalten werden. Da die 0 nicht in diesem Intervall enthalten ist, ist 0 ein eher unwahrscheinlicher wahrer Wert für $b_1$.

* $b_1$  
    + H0: $b_1 = 0$, das Regressionsgewicht ist nicht von Null verschieden.  
    + H1: $b_1 \neq 0$, das Regressionsgewicht ist von Null verschieden. 
    
* $b_0$ (häufig nicht von Interesse)  
    + H0: $b_0 = 0$, der y-Achsenabschnitt ist nicht von Null verschieden.  
    + H1: $b_0 \neq 0$, der y-Achsenabschnitt ist von Null verschieden.  

Für beide Parameter ($b_1$ uns $b_0$) wird die H0 auf einem alpha-Fehler-Niveau von 5% verworfen, da die 0 nicht im jeweiligen 95% Konfidenzintervall enthalten ist.

Eine andere Möglichkeit zur interenzstatitschen Überpüfung ergibt sich über die p-Werte der Regressionskoeffizienten. Diese werden über die `summary()`Funktion ausgegeben.


```r
#Detaillierte Modellergebnisse
summary(lin_mod)
```

```
## 
## Call:
## lm(formula = nerd ~ extra, data = fb22)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.49293 -0.43406  0.05601  0.39927  1.78154 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.85535    0.24733  15.588  < 2e-16 ***
## extra       -0.21561    0.07166  -3.009  0.00306 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6359 on 157 degrees of freedom
## Multiple R-squared:  0.05451,	Adjusted R-squared:  0.04849 
## F-statistic: 9.052 on 1 and 157 DF,  p-value: 0.003057
```

Aus `summary()`: $p < \alpha$ $\rightarrow$ H1: Das Regressionsgewicht für den Prädiktor Extraversion ist signifikant von Null verschieden. Der Zusammenhang von Extraversion und Nerdiness ist statistisch bedeutsam. 

Aus `summary()`: $p < \alpha$ $\rightarrow$ H1: der Achsenabschnitt ist signifikant von Null verschieden. Beträgt die Extraversion Null wird eine von 0 verschiedene Nerdiness vorhergesagt. 

Konfidenzinteralle und p-Werte für Regressionskoeffizienten kommen immer zu denselben Schlussfolgerungen in Bezug darauf, ob die H0 beibehalten oder verworfen wird!
