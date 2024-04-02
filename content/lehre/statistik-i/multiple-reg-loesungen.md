---
title: "Multiple Regression - Lösungen" 
type: post
date: '2024-02-06' 
slug: multiple-reg-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [vogler] 
weight: 
lastmod: '2024-04-02'
featured: no
banner:
  image: "/header/stormies.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/89134)"
projects: []
expiryDate: 
publishDate: 
_build:
  list: never
reading_time: false
share: false
links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/multiple-reg
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/multiple-reg-aufgaben
output:
  html_document:
    keep_md: true
---

## Vorbereitung



> Laden Sie zunächst den Datensatz `fb23` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb23.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/multiple-regression/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb23)
```

```
## [1] 179  42
```

Der Datensatz besteht aus 179 Zeilen (Beobachtungen) und 42 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.


***

## Aufgabe 1

Ihr womöglich erstes Semester des Psychologie Studiums neigt sich dem Ende entgegen und die Klausuren rücken somit immer näher. Als vorbildliche\*r Student\*in sind Sie bereits fleißig am Lernen.
Jedoch beobachten Sie in manchen Kommilitoninnen und Kommilitonen, dass diese nicht so fleißig sind und eher vor sich hin prokrastinieren.
Sie vermuten, dass bestimmte Persönlichkeitsmerkmale die Prokrastinationstendenz (`prok`) vorhersagen könnten. Konkret vermuten Sie einen positiven Zusammenhang mit Neurotizismus (`neuro`) und einen negativen Zusammenhang mit Gewissenhaftigkeit (`gewis`). Im weiteren Verlauf sollen aber alle Eigenschaften aus dem Big Five Modell überprüft werden.

Dafür reduzieren Sie zunächst Ihren Datensatz auf die relevanten Variablen und entfernen sämtliche fehlende Werte:


```r
fb23_short <- subset(fb23, select = c("extra", "vertr", "gewis", "neuro", "offen", "prok"))

fb23_short <- na.omit(fb23_short)
```

<details>

<summary>Exkurs: Warum machen wir das?</summary>

Zum einen fällt es uns so leichter den Überblick über unsere Daten zu behalten.
Zum anderen ist uns bereits im Kapitel [Multiple Regression](/lehre/statistik-i/multiple-regression) eine Fehlermeldung bei der Verwendung des Befehls `anova()` in Kombination mit fehlenden Werten (`NA`) begegnet.
Da wir im Folgenden erneut mit den Big Five Variablen arbeiten, gehen wir dieser Fehlermeldung bereits im Vorhinein aus dem Weg.


```r
#Gibt es mindestens ein fehlenden Wert auf den 6 Variablen?
anyNA(fb23[, c("extra", "vertr", "gewis", "neuro", "offen", "prok")])
```

```
## [1] TRUE
```

```r
#Auf welcher Variable und wie viele NA's gibt es?
summary(fb23[, c("extra", "vertr", "gewis", "neuro", "offen", "prok")])
```

```
##      extra           vertr           gewis           neuro           offen           prok      
##  Min.   :1.000   Min.   :1.000   Min.   :1.500   Min.   :1.000   Min.   :1.50   Min.   :1.500  
##  1st Qu.:2.500   1st Qu.:3.000   1st Qu.:3.000   1st Qu.:2.500   1st Qu.:3.00   1st Qu.:2.200  
##  Median :3.000   Median :3.500   Median :3.500   Median :3.500   Median :4.00   Median :2.500  
##  Mean   :3.268   Mean   :3.463   Mean   :3.531   Mean   :3.355   Mean   :3.74   Mean   :2.545  
##  3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:4.50   3rd Qu.:2.950  
##  Max.   :5.000   Max.   :5.000   Max.   :5.000   Max.   :5.000   Max.   :5.00   Max.   :3.800  
##                  NA's   :1
```

```r
#ein NA auf vertr
```

</details>


-   Stellen Sie das oben beschriebene lineare Regressionsmodell auf.

<details>

<summary>Lösung</summary>


```r
mod_base <- lm(prok ~ neuro + gewis, data = fb23_short)
```

</details>


-   Überprüfen Sie die Voraussetzungen für die multiple lineare Regression.

<details>

<summary>Lösung</summary>

**Voraussetzungen:**

1.    Korrekte Spezifikation des Modells

2.    Messfehlerfreiheit der unabhängigen Variablen

3.    Unabhängigkeit der Residuen

4.    Homoskedastizität der Residuen

5.    Normalverteilung der Residuen



```r
# Korrekte Spezifikation des Modells --> Linearität

#Einfache Regressionsmodelle aufstellen
mod_neuro <- lm(prok ~ neuro, data = fb23_short)

mod_gewis <- lm(prok ~ gewis, data = fb23_short)

#Überprüfung der Linearität
par(mfrow = c(1, 2))

plot(fb23_short$prok ~ fb23_short$neuro, 
     xlab = "Neurotizismus", 
     ylab = "Prokrastinationstendenz")
lines(lowess(fb23_short$neuro, fb23_short$prok), col = "red")
abline(mod_neuro, col = "blue")


plot(fb23_short$prok ~ fb23_short$gewis, 
     xlab = "Gewissenhaftigkeit",
     ylab = "Prokrastinationstendenz")
lines(lowess(fb23_short$gewis, fb23_short$prok), col = "red")
abline(mod_gewis, col = "blue")
```

![](/lehre/statistik-i/multiple-reg-loesungen_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

Für beide Variablen sind klare lineare Verläufe erkennbar.


```r
#1x2 Ansicht der Plots beenden
dev.off()
```

```
## RStudioGD 
##         2
```

Bei der **Messfehlerfreiheit der unabhängigen Variablen** geht man davon aus, dass der Fragebogen den ich nutze fehlerfrei misst, insbesondere unsere unabhängigen Variablen. Wie bereits im Kapitel [Multiple Regression](/lehre/statistik-i/multiple-regression) besprochen ist das selten der Fall und wir können uns Reliabilitätsmaßen wie Cronbachs Alpha und McDonalds Omega bedienen um das Ausmaß des Fehlers zu quantifizieren.
Bei der Nennung dieser belassen wir es aber für diese Aufgabe mal und nehmen an dass diese Voraussetzung **nicht** verletzt ist.

Auch die Voraussetzung der **Unabhängigkeit der Residuen** ist inhaltlicher Natur. In diesem Fall gehen wir davon aus, dass Sie den Fragebogen am Anfang des Semesters weitgehend unabhängig voneinander bearbeitet haben. Somit ist auch diese Voraussetzung erfüllt.


```r
#Homoskedastizität der Residuen
plot(mod_base, which = 3)
```

![](/lehre/statistik-i/multiple-reg-loesungen_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

```r
car::ncvTest(mod_base) #nicht signifikant --> Homoskedastizität wird angenommen
```

```
## Non-constant Variance Score Test 
## Variance formula: ~ fitted.values 
## Chisquare = 1.538691, Df = 1, p = 0.21481
```


```r
#Normalverteilung der Residuen
car::qqPlot(mod_base)
```

![](/lehre/statistik-i/multiple-reg-loesungen_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

```
## 144 170 
## 140 166
```

```r
shapiro.test(mod_base$residuals) #nicht signifikant --> Normalverteilung wird angenommen
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  mod_base$residuals
## W = 0.99419, p-value = 0.7113
```

*Anmerkung:* Sowohl bei der Überprüfung der Homoskedastizität als auch der Normalverteilung bedienen wir uns Funktionen des `car`-Pakets. Dieses müssen wir nicht explizit mit dem `library()`-Befehl laden wenn wir zunächst den Namen des Pakets nennen, dann zwei Doppelpunkte und die Funktion folgen.
Dies ist selbst dann zu empfehlen wenn man die Pakete bereits geladen hat da so auch im Nachhinein ersichtlich ist aus welchem Paket welche Funktion genutzt wurde.

</details>


-   Neurotizismus (`neuro`) und Gewissenhaftigkeit (`gewis`) bilden bereits zwei der fünf Persönlichkeitsdimensionen nach dem Big Five Modell ab. Gibt es unter den verbleibenden drei Dimensionen einen weiteren signifikanten Prädiktor für die Prokrastinationstendenz (`prok`)? Gehen Sie schrittweise vor, indem Sie Ihr vorhandenes Modell um eine Persönlichkeitsdimension erweitern und dann testen, ob deren Inkrement signifikant ist.

<details>

<summary>Lösung</summary>


```r
#Extraversion
mod_base_extra <- lm(prok ~ neuro + gewis + extra, data = fb23_short)

anova(mod_base, mod_base_extra) #signifikant
```

```
## Analysis of Variance Table
## 
## Model 1: prok ~ neuro + gewis
## Model 2: prok ~ neuro + gewis + extra
##   Res.Df    RSS Df Sum of Sq      F  Pr(>F)  
## 1    175 28.240                              
## 2    174 27.409  1   0.83086 5.2745 0.02283 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
#Verträglichkeit
mod_base_vertr <- lm(prok ~ neuro + gewis + vertr, data = fb23_short)

anova(mod_base, mod_base_vertr) #nicht signifikant
```

```
## Analysis of Variance Table
## 
## Model 1: prok ~ neuro + gewis
## Model 2: prok ~ neuro + gewis + vertr
##   Res.Df    RSS Df Sum of Sq      F Pr(>F)
## 1    175 28.240                           
## 2    174 28.231  1 0.0084482 0.0521 0.8198
```

```r
#Offenheit für neue Erfahrungen
mod_base_offen <- lm(prok ~ neuro + gewis + offen, data = fb23_short)

anova(mod_base, mod_base_offen) #nicht signifikant
```

```
## Analysis of Variance Table
## 
## Model 1: prok ~ neuro + gewis
## Model 2: prok ~ neuro + gewis + offen
##   Res.Df    RSS Df Sum of Sq      F Pr(>F)
## 1    175 28.240                           
## 2    174 28.183  1   0.05707 0.3524 0.5536
```


```r
#Inkrement von Extraversion
summary(mod_base_extra)$r.squared - summary(mod_base)$r.squared 
```

```
## [1] 0.01747554
```



Extraversion lässt sich als einzige weitere Dimension der Big Five als signifikanter Prädiktor ($F = 5.27, p = 0.023$) für Prokrastinationstendenz in unser Modell aufnehmen. 
Dabei kann Extraversion zusätzlich 1.75% Varianz erklären.

Somit lautet unser finales Modell wie folgt:


```r
mod_final <- lm(prok ~ neuro + gewis + extra, data = fb23_short)

summary(mod_final)
```

```
## 
## Call:
## lm(formula = prok ~ neuro + gewis + extra, data = fb23_short)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.12466 -0.25241 -0.02128  0.26635  1.00898 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.04935    0.22818  13.364  < 2e-16 ***
## neuro        0.17663    0.03266   5.408 2.08e-07 ***
## gewis       -0.38529    0.03892  -9.900  < 2e-16 ***
## extra        0.08124    0.03537   2.297   0.0228 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.3969 on 174 degrees of freedom
## Multiple R-squared:  0.4235,	Adjusted R-squared:  0.4136 
## F-statistic: 42.61 on 3 and 174 DF,  p-value: < 2.2e-16
```



</details>


-   Interpretieren Sie das Regressionsgewicht von Gewissenhaftigkeit (`gewis`).

<details>

<summary>Lösung</summary>

Zwei Personen die den **gleichen** Neurotizismus- sowie Extraversions-Wert haben, sich aber um eine Einheit in der Gewissenhaftigkeit unterscheiden, unterscheiden sich um $\mp 0.39$ Einheiten in der Prokrastinationstendenz.

</details>


-   Wie viel Varianz (in %) erklärt das finale Modell?

<details>

<summary>Lösung</summary>


```r
summary(mod_final)$r.squared
```

```
## [1] 0.4235057
```

Der Determinationskoeffizient ($R^2 =$ 0.4235) besagt das 42.35% der Varianz in der Prokrastinationstendenz durch unser Modell aus drei Prädiktoren (`neuro`, `gewis`, `extra`) erklärt wird.  

</details>



## Aufgabe 2

Gehen Sie für die folgende Aufgabe von dem finalen Modell aus Aufgabe 1 aus.

Falls Sie dort Schwierigkeiten hatten, benutzen Sie das Kontrollergebnis.

<details>

<summary>Kontrollergebnis</summary>


```r
mod_final <- lm(prok ~ neuro + gewis + extra, data = fb23_short)
```

</details>


-   Welcher Prädiktor trägt am meisten zur Prognose der Prokrastinationstendenz (`prok`) bei?
  
<details>

<summary>Lösung</summary>

Hierfür betrachten wir unsere Regressionsgewichte:


```r
mod_final$coefficients
```

```
## (Intercept)       neuro       gewis       extra 
##  3.04934935  0.17662562 -0.38529030  0.08124088
```

Diese sind jedoch noch von der benutzten Skala abhängig weswegen wir noch keine Aussage darüber treffen können welches das "beste" Regressionsgewicht ist. Daher standardisieren wir unser Modell, um uns von der Skalenabhängigkeit zu befreien.
(Ausführlicher wurde dieses Vorgehen im Kapitel [Einfache Lineare Regression](/lehre/statistik-i/einfache-reg) besprochen.)


```r
library(lm.beta)
```


```r
mod_final_std <- lm.beta(mod_final)

summary(mod_final_std)
```

```
## 
## Call:
## lm(formula = prok ~ neuro + gewis + extra, data = fb23_short)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.12466 -0.25241 -0.02128  0.26635  1.00898 
## 
## Coefficients:
##             Estimate Standardized Std. Error t value Pr(>|t|)    
## (Intercept)  3.04935           NA    0.22818  13.364  < 2e-16 ***
## neuro        0.17663      0.33288    0.03266   5.408 2.08e-07 ***
## gewis       -0.38529     -0.57143    0.03892  -9.900  < 2e-16 ***
## extra        0.08124      0.14168    0.03537   2.297   0.0228 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.3969 on 174 degrees of freedom
## Multiple R-squared:  0.4235,	Adjusted R-squared:  0.4136 
## F-statistic: 42.61 on 3 and 174 DF,  p-value: < 2.2e-16
```

Das betragsmäßig größte standardisierte Regressionsgewicht hat Gewissenhaftigkeit mit -0.571.
Somit lässt sich die Aussage treffen das Gewissenhaftigkeit im Vergleich zu Neurotizismus und Extraversion am meisten zu der Vorhersage der Prokrastinationstendenz beiträgt.

</details>


-   Welche Prokrastinationstendenz (`prok`) sagt das finale Modell für eine Person hervor, die auf allen inkludierten Prädiktoren genau in der Mitte der Stichprobe (`fb23`) liegt (Mittelwerte)?

<details>

<summary>Lösung</summary>

Im Folgenden werden drei Lösungsansätze gezeigt, die sich in ihrer Komplexität unterscheiden. Sofern Sie auf einen der drei gekommen sind oder einen weiteren Ansatz gefunden haben der zum gleichen Ergebnis kommt, haben Sie die Aufgabe erfolgreich geeistert.


```r
#1. Ansatz
means <- data.frame(neuro = mean(fb23_short$neuro),
                    gewis = mean(fb23_short$gewis),
                    extra = mean(fb23_short$extra))

predict(mod_final, newdata = means)
```

```
##        1 
## 2.547753
```

**Erklärung:**

Hierbei handelt es sich um den standard Ansatz wenn es darum geht für eine neue Person mit folgenden Werten auf den Prädiktoren eine Vorhersage zu treffen.


```r
#2. Ansatz
mod_final_sc <- lm(prok ~ scale(neuro) + scale(gewis) + scale(extra), data = fb23_short)

mod_final_sc$coefficients[1]
```

```
## (Intercept) 
##    2.547753
```

**Erklärung:**

Schematisch können wir für unser Modell folgende Formel aufstellen:

\begin{align}
\hat{y} = b_1 * x_1 + b_2 * x_2 + b_3 * x_3 + b_0
\end{align}


Wenn wir uns an die Formel zum Standardisieren erinnern, lautet diese wie folgt:

\begin{align}
x_{std} = \frac{x - \bar{x}}{\hat{\sigma}}
\end{align}

Setzen wir die zweite Formel in die Erste ein erhalten wir:

\begin{align}
\hat{y} = b_1 * \frac{x_1 - \bar{x_1}}{\hat{\sigma_1}} + b_2 * \frac{x_2 - \bar{x_2}}{\hat{\sigma_2}} + b_3 * \frac{x_3 - \bar{x_3}}{\hat{\sigma_3}} + b_0
\end{align}

Nun interessiert uns die vorhergesagte Prokrastinationstendenz ($\hat{y}$) für eine Person die auf allen drei Variablen ($x_1, x_2, x_3$) genau den Mittelwert dieser Variable ($\bar{x_1}, \bar{x_2}, \bar{x_3}$) aufweist.
Setzen wir für $x_1, x_2, x_3$ die Mittelwerte ein sehen wir das in den Zählern nur noch Nullen übrigbleiben.


Unsere Formel reduziert sich dann auf:

\begin{align}
\hat{y} = b_0
\end{align}

--> Für eine Person, die auf allen standardisierten Prädiktoren genau den Mittelwert dieser Variable als eigenen Wert hat, ist die prognostizierte Prokrastinationstendenz gleich dem Intercept.


```r
#3. Ansatz
mean(fb23_short$prok)
```

```
## [1] 2.547753
```

**Erklärung:**

Aufgrund dessen wie unser Regressionsmodell mathematisch definiert ist, entspricht die vorhergesagte Prokrastinationstendenz für eine Person, die auf allen Prädiktorvariablen deren Mittelwert als eigenen Wert hat, der mittleren Prokrastinationstendenz in der Stichprobe aus der das Modell entstanden ist.

</details>

***
