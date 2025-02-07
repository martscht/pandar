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
lastmod: '2025-02-07'
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



> Laden Sie zunächst den Datensatz `fb24` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb24.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/multiple-reg/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb24)
```

```
## [1] 192  44
```

Der Datensatz besteht aus 192 Zeilen (Beobachtungen) und 44 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.


***

## Aufgabe 1

Ihr womöglich erstes Semester des Psychologie Studiums neigt sich dem Ende entgegen und die Klausuren rücken somit immer näher. Als vorbildliche\*r Student\*in sind Sie bereits fleißig am Lernen.
Jedoch beobachten Sie in manchen Kommilitoninnen und Kommilitonen, dass diese nicht so fleißig sind und eher vor sich hin prokrastinieren.
Sie vermuten, dass bestimmte Persönlichkeitsmerkmale die Prokrastinationstendenz (`prok`) vorhersagen könnten. Konkret vermuten Sie einen positiven Zusammenhang mit Neurotizismus (`neuro`) und einen negativen Zusammenhang mit Gewissenhaftigkeit (`gewis`). Im weiteren Verlauf sollen aber alle Eigenschaften aus dem Big Five Modell überprüft werden.

Dafür reduzieren Sie zunächst Ihren Datensatz auf die relevanten Variablen und entfernen sämtliche fehlende Werte:


```r
fb24_short <- subset(fb24, select = c("extra", "vertr", "gewis", "neuro", "offen", "prok"))

fb24_short <- na.omit(fb24_short)
```

<details>

<summary>Exkurs: Warum machen wir das?</summary>

Zum einen fällt es uns so leichter den Überblick über unsere Daten zu behalten.
Zum anderen ist uns bereits im Kapitel [Multiple Regression](/lehre/statistik-i/multiple-reg) eine Fehlermeldung bei der Verwendung des Befehls `anova()` in Kombination mit fehlenden Werten (`NA`) begegnet.
Da wir im Folgenden erneut mit den Big Five Variablen arbeiten, gehen wir dieser Fehlermeldung bereits im Vorhinein aus dem Weg.


```r
#Gibt es mindestens ein fehlenden Wert auf den 6 Variablen?
anyNA(fb24[, c("extra", "vertr", "gewis", "neuro", "offen", "prok")])
```

```
## [1] TRUE
```

```r
#Auf welcher Variable und wie viele NA's gibt es?
summary(fb24[, c("extra", "vertr", "gewis", "neuro", "offen", "prok")])
```

```
##      extra           vertr           gewis          neuro           offen            prok      
##  Min.   :1.000   Min.   :1.000   Min.   :1.50   Min.   :1.000   Min.   :1.000   Min.   :2.100  
##  1st Qu.:2.500   1st Qu.:3.000   1st Qu.:3.00   1st Qu.:3.000   1st Qu.:3.000   1st Qu.:2.500  
##  Median :3.500   Median :3.500   Median :3.50   Median :3.500   Median :4.000   Median :2.700  
##  Mean   :3.277   Mean   :3.484   Mean   :3.49   Mean   :3.408   Mean   :3.809   Mean   :2.685  
##  3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:4.00   3rd Qu.:4.000   3rd Qu.:4.500   3rd Qu.:2.900  
##  Max.   :5.000   Max.   :5.000   Max.   :5.00   Max.   :5.000   Max.   :5.000   Max.   :3.200  
##  NA's   :1       NA's   :1       NA's   :1      NA's   :1       NA's   :1       NA's   :2
```

```r
#ein NA auf vertr
```

</details>


-   Stellen Sie das oben beschriebene lineare Regressionsmodell auf.

<details>

<summary>Lösung</summary>


```r
mod_base <- lm(prok ~ neuro + gewis, data = fb24_short)
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
mod_neuro <- lm(prok ~ neuro, data = fb24_short)

mod_gewis <- lm(prok ~ gewis, data = fb24_short)

#Überprüfung der Linearität
par(mfrow = c(1, 2))

plot(fb24_short$prok ~ fb24_short$neuro, 
     xlab = "Neurotizismus", 
     ylab = "Prokrastinationstendenz")
lines(lowess(fb24_short$neuro, fb24_short$prok), col = "red")
abline(mod_neuro, col = "blue")


plot(fb24_short$prok ~ fb24_short$gewis, 
     xlab = "Gewissenhaftigkeit",
     ylab = "Prokrastinationstendenz")
lines(lowess(fb24_short$gewis, fb24_short$prok), col = "red")
abline(mod_gewis, col = "blue")
```

![](/multiple-reg-loesungen_files/unnamed-chunk-6-1.png)<!-- -->

Für beide Variablen sind klare lineare Verläufe erkennbar.


```r
#1x2 Ansicht der Plots beenden
dev.off()
```

```
## null device 
##           1
```

Bei der **Messfehlerfreiheit der unabhängigen Variablen** geht man davon aus, dass der Fragebogen den man nutzt fehlerfrei misst, insbesondere unsere unabhängigen Variablen. Wie bereits im Kapitel [Multiple Regression](/lehre/statistik-i/multiple-regression) besprochen ist das selten der Fall und wir können uns Reliabilitätsmaßen wie Cronbachs Alpha und McDonalds Omega bedienen um das Ausmaß des Fehlers zu quantifizieren.
Bei der Nennung dieser belassen wir es aber für diese Aufgabe mal und nehmen an dass diese Voraussetzung **nicht** verletzt ist.

Auch die Voraussetzung der **Unabhängigkeit der Residuen** ist inhaltlicher Natur. In diesem Fall gehen wir davon aus, dass Sie den Fragebogen am Anfang des Semesters weitgehend unabhängig voneinander bearbeitet haben. Somit ist auch diese Voraussetzung erfüllt.


```r
#Homoskedastizität der Residuen
plot(mod_base, which = 3)
```

![](/multiple-reg-loesungen_files/unnamed-chunk-8-1.png)<!-- -->

```r
car::ncvTest(mod_base) #nicht signifikant --> Homoskedastizität wird angenommen
```

```
## Non-constant Variance Score Test 
## Variance formula: ~ fitted.values 
## Chisquare = 0.8027976, Df = 1, p = 0.37026
```


```r
#Normalverteilung der Residuen
car::qqPlot(mod_base)
```

![](/multiple-reg-loesungen_files/unnamed-chunk-9-1.png)<!-- -->

```
## 109 169 
## 107 167
```

```r
shapiro.test(mod_base$residuals) #nicht signifikant --> Normalverteilung wird angenommen
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  mod_base$residuals
## W = 0.9892, p-value = 0.1608
```

*Anmerkung:* Sowohl bei der Überprüfung der Homoskedastizität als auch der Normalverteilung bedienen wir uns Funktionen des `car`-Pakets. Dieses müssen wir nicht explizit mit dem `library()`-Befehl laden wenn wir zunächst den Namen des Pakets nennen, dann zwei Doppelpunkte und die Funktion folgen.
Dies ist selbst dann zu empfehlen wenn man die Pakete bereits geladen hat da so auch im Nachhinein ersichtlich ist aus welchem Paket welche Funktion genutzt wurde.

</details>


-   Neurotizismus (`neuro`) und Gewissenhaftigkeit (`gewis`) bilden bereits zwei der fünf Persönlichkeitsdimensionen nach dem Big Five Modell ab. Gibt es unter den verbleibenden drei Dimensionen einen weiteren signifikanten Prädiktor für die Prokrastinationstendenz (`prok`)? Gehen Sie schrittweise vor, indem Sie Ihr vorhandenes Modell um eine Persönlichkeitsdimension erweitern und dann testen, ob deren Inkrement signifikant ist.

<details>

<summary>Lösung</summary>


```r
#Extraversion
mod_base_extra <- lm(prok ~ neuro + gewis + extra, data = fb24_short)

anova(mod_base, mod_base_extra) #nicht signifikant
```

```
## Analysis of Variance Table
## 
## Model 1: prok ~ neuro + gewis
## Model 2: prok ~ neuro + gewis + extra
##   Res.Df    RSS Df  Sum of Sq      F Pr(>F)
## 1    187 10.056                            
## 2    186 10.056  1 0.00032934 0.0061 0.9379
```

```r
#Verträglichkeit
mod_base_vertr <- lm(prok ~ neuro + gewis + vertr, data = fb24_short)

anova(mod_base, mod_base_vertr) #nicht signifikant
```

```
## Analysis of Variance Table
## 
## Model 1: prok ~ neuro + gewis
## Model 2: prok ~ neuro + gewis + vertr
##   Res.Df    RSS Df Sum of Sq      F Pr(>F)
## 1    187 10.056                           
## 2    186 10.030  1  0.025336 0.4698 0.4939
```

```r
#Offenheit für neue Erfahrungen
mod_base_offen <- lm(prok ~ neuro + gewis + offen, data = fb24_short)

anova(mod_base, mod_base_offen) #nicht signifikant
```

```
## Analysis of Variance Table
## 
## Model 1: prok ~ neuro + gewis
## Model 2: prok ~ neuro + gewis + offen
##   Res.Df    RSS Df Sum of Sq      F Pr(>F)
## 1    187 10.056                           
## 2    186 10.019  1  0.036619 0.6798 0.4107
```


```r
#Inkrement von Extraversion
summary(mod_base_extra)$r.squared - summary(mod_base)$r.squared 
```

```
## [1] 3.19783e-05
```



Keine weitere Dimension der Big Five  kommt als weiterer signifikanter Prädiktor für Prokrastinationstendenz bei unserem Modell in Frage. 

Somit lautet unser finales Modell weiterhin wie folgt:


```r
mod_final <- lm(prok ~ neuro + gewis, data = fb24_short)

summary(mod_final)
```

```
## 
## Call:
## lm(formula = prok ~ neuro + gewis, data = fb24_short)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.64691 -0.16143  0.01391  0.16999  0.50266 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  2.593601   0.097272  26.663   <2e-16 ***
## neuro        0.036029   0.017932   2.009   0.0459 *  
## gewis       -0.008946   0.019212  -0.466   0.6420    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.2319 on 187 degrees of freedom
## Multiple R-squared:  0.02358,	Adjusted R-squared:  0.01314 
## F-statistic: 2.258 on 2 and 187 DF,  p-value: 0.1074
```



</details>


-   Interpretieren Sie das Regressionsgewicht von Gewissenhaftigkeit (`gewis`).

<details>

<summary>Lösung</summary>

Zwei Personen die den **gleichen** Neurotizismus-Wert haben, sich aber um eine Einheit in der Gewissenhaftigkeit unterscheiden, unterscheiden sich um $\pm 0.01$ Einheiten in der Prokrastinationstendenz.

</details>


-   Wie viel Varianz (in %) erklärt das finale Modell?

<details>

<summary>Lösung</summary>


```r
summary(mod_final)$r.squared
```

```
## [1] 0.02358257
```

Der Determinationskoeffizient ($R^2 =$ 0.0236) besagt das 2.36% der Varianz in der Prokrastinationstendenz durch unser Modell aus zwei Prädiktoren (`neuro`, `gewis`) erklärt wird.  

</details>



## Aufgabe 2

Gehen Sie für die folgende Aufgabe von dem finalen Modell aus Aufgabe 1 aus.

Falls Sie dort Schwierigkeiten hatten, benutzen Sie das Kontrollergebnis.

<details>

<summary>Kontrollergebnis</summary>


```r
mod_final <- lm(prok ~ neuro + gewis, data = fb24_short)
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
##  (Intercept)        neuro        gewis 
##  2.593601258  0.036028798 -0.008945736
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
## lm(formula = prok ~ neuro + gewis, data = fb24_short)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.64691 -0.16143  0.01391  0.16999  0.50266 
## 
## Coefficients:
##              Estimate Standardized Std. Error t value Pr(>|t|)    
## (Intercept)  2.593601           NA   0.097272  26.663   <2e-16 ***
## neuro        0.036029     0.146086   0.017932   2.009   0.0459 *  
## gewis       -0.008946    -0.033855   0.019212  -0.466   0.6420    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.2319 on 187 degrees of freedom
## Multiple R-squared:  0.02358,	Adjusted R-squared:  0.01314 
## F-statistic: 2.258 on 2 and 187 DF,  p-value: 0.1074
```

Das betragsmäßig größte standardisierte Regressionsgewicht hat der Neurotizismus mit 0.146.
Somit lässt sich die Aussage treffen, das Neurotizismus im Vergleich zu Gewissenhaftigkeit am meisten zu der Vorhersage der Prokrastinationstendenz beiträgt.

</details>


-   Welche Prokrastinationstendenz (`prok`) sagt das finale Modell für eine Person hervor, die auf allen inkludierten Prädiktoren genau in der Mitte der Stichprobe (`fb24`) liegt (Mittelwerte)?

<details>

<summary>Lösung</summary>

Im Folgenden werden drei Lösungsansätze gezeigt, die sich in ihrer Komplexität unterscheiden. Sofern Sie auf einen der drei gekommen sind oder einen weiteren Ansatz gefunden haben der zum gleichen Ergebnis kommt, haben Sie die Aufgabe erfolgreich geeistert.


```r
#1. Ansatz
means <- data.frame(neuro = mean(fb24_short$neuro),
                    gewis = mean(fb24_short$gewis))

predict(mod_final, newdata = means)
```

```
##        1 
## 2.685263
```

**Erklärung:**

Hierbei handelt es sich um den standard Ansatz wenn es darum geht für eine neue Person mit folgenden Werten auf den Prädiktoren eine Vorhersage zu treffen.


```r
#2. Ansatz
mod_final_sc <- lm(prok ~ scale(neuro) + scale(gewis), data = fb24_short)

mod_final_sc$coefficients[1]
```

```
## (Intercept) 
##    2.685263
```

**Erklärung:**

Schematisch können wir für unser Modell folgende Formel aufstellen:

\begin{align}
\hat{y} = b_1 * x_1 + b_2 * x_2 + b_0
\end{align}


Wenn wir uns an die Formel zum Standardisieren erinnern, lautet diese wie folgt:

\begin{align}
x_{std} = \frac{x - \bar{x}}{\hat{\sigma}}
\end{align}

Setzen wir die zweite Formel in die Erste ein erhalten wir:

\begin{align}
\hat{y} = b_1 * \frac{x_1 - \bar{x_1}}{\hat{\sigma_1}} + b_2 * \frac{x_2 - \bar{x_2}}{\hat{\sigma_2}} + b_0
\end{align}

Nun interessiert uns die vorhergesagte Prokrastinationstendenz ($\hat{y}$) für eine Person die auf beiden Variablen ($x_1, x_2$) genau den Mittelwert dieser Variable ($\bar{x_1}, \bar{x_2}$) aufweist.
Setzen wir für $x_1, x_2$ die Mittelwerte ein sehen wir das in den Zählern nur noch Nullen übrigbleiben.


Unsere Formel reduziert sich dann auf:

\begin{align}
\hat{y} = b_0
\end{align}

$\rightarrow$ Für eine Person, die auf allen standardisierten Prädiktoren genau den Mittelwert dieser Variable als eigenen Wert hat, ist die prognostizierte Prokrastinationstendenz gleich dem Intercept.


```r
#3. Ansatz
mean(fb24_short$prok)
```

```
## [1] 2.685263
```

**Erklärung:**

Aufgrund dessen wie unser Regressionsmodell mathematisch definiert ist, entspricht die vorhergesagte Prokrastinationstendenz für eine Person, die auf allen Prädiktorvariablen deren Mittelwert als eigenen Wert hat, der mittleren Prokrastinationstendenz in der Stichprobe aus der das Modell entstanden ist.

</details>

***
