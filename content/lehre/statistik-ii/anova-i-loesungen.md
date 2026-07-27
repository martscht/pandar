---
title: Einfaktorielle ANOVA - Lösung
type: post
date: '2025-04-07'
slug: anova-i-loesungen
categories: Statistik II Übungen
tags: ["ANOVA", "Post-Hoc", "Einfaktoriell"]
subtitle: '1-fakt. ANOVA Lösungen'
summary: Lösungen der Übung zur einfaktoriellen ANOVA
authors: [pommeranz, nehler]
weight: 1
lastmod: '2026-07-16'
featured: no
banner:
  image: "/header/earth_and_moon_space.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/804791)"
projects: []
reading_time: no
share: no
private: 'true'
links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-ii/anova-i
  - icon_pack: fas
    icon: pen-to-square
    name: Übungen
    url: /lehre/statistik-ii/anova-i-uebungen
output:
  html_document:
    keep_md: true
---



## Vorbereitung

Bitte laden Sie den folgenden Datensatz herunter, der Items aus einem Machiavellismus-Fragebogen enthält, um die nachfolgende Aufgabe bearbeiten zu können. Der Datensatz enthält verschiedene Angaben zur Persönlichkeit sowie demografische Informationen. Im Mittelpunkt steht jedoch der 20 Items umfassende Machiavellismus-Fragebogen von Christie und Geis (1970) sowie die daraus ableitbare vierfaktorielle Struktur des Konzepts (Corral & Calvete, 2000). Weitere Details zum Fragebogen und seinen Items finden Sie auch [hier](https://pandar.netlify.app/daten/datensaetze/#machiavellismus-fragebogen-mach).


``` r
# Datensatz laden
load(url("https://pandar.netlify.app/daten/mach.rda"))
```

Weiterhin werden die Pakete `afex` und `emmeans` benötigt, die eventuell auch noch installiert werden müssen.


``` r
# Pakete installieren falls nicht vorhanden
if (!requireNamespace("afex", quietly = TRUE)) {
  install.packages("afex")
}
if (!requireNamespace("emmeans", quietly = TRUE)) {
  install.packages("emmeans")
}
# Pakete laden 
library(afex)
library(emmeans)
```

## Aufgabe 1

- Verschaffen Sie sich zunächst eine Übersicht über die Struktur des Datensatzes. Testen Sie anschließend auf einem $\alpha$-Niveau von 5%, ob sich die Bildungsstufen signifikant hinsichtlich des Skalenwerts zur zynischen Sicht auf die menschliche Natur (*cynical view on human nature*) unterscheiden. Ziehen Sie dafür bei Bedarf die im Aufgabentext verlinkte Übersicht zur Hilfe.
- Versuchen Sie, aus der Analyse mit `afex` die drei Quadratsummen zu bestimmen: die Quadratsumme zwischen den Gruppen, die Fehlerquadratsumme und die Gesamtquadratsumme.
- Berechnen Sie den empirischen F-Wert manuell, indem Sie die aus dem Paket bestimmten Quadratsummen und Freiheitsgrade verwenden.


<details>
<summary>Lösung</summary>

Zunächst können wir uns mit der Funktion `head()` einen ersten Überblick über den Datensatz verschaffen.


``` r
# Überblick
head(mach)
```

```
##   TIPI1 TIPI2 TIPI3 TIPI4 TIPI5 TIPI6 TIPI7 TIPI8 TIPI9 TIPI10 education urban gender engnat age
## 1     6     5     6     1     7     3     7     4     7      1         2     3      1      1  26
## 2     2     5     6     2     4     6     5     4     6      5         2     2      1      1  18
## 3     1     7     6     7     5     7     1     4     1      4         1     1      2      1  15
## 4     6     5     5     7     7     2     6     2     2      3         4     3      2      2  31
## 5     2     5     5     6     7     6     5     3     4      5         2     2      1      2  20
## 6     2     4     6     2     3     7     5     2     7      1         1     1      1      2  17
##   hand religion orientation race voted married familysize  nit      pit     cvhn pvhn
## 1    1        7           1   30     1       2          5 4.00 2.666667 3.833333 2.00
## 2    1        1           1   60     2       1          2 5.00 1.166667 3.833333 2.75
## 3    1        2           2   10     2       1          2 5.00 1.000000 4.000000 2.00
## 4    1        6           1   60     1       3          2 3.75 2.166667 3.000000 1.50
## 5    1        4           3   60     1       1          2 4.75 1.666667 2.666667 2.00
## 6    1        1           1   70     2       1          3 4.00 2.666667 3.166667 2.25
```

Die interessierenden Variablen sind hier `education` für die Bildungsstufe und `cvhn` für den zynischen Blick auf die Natur des Menschen. Gleichzeitig sehen wir, dass es keine ID-Variable gibt, welche die Versuchspersonen identifiziert. Diese müssen wir daher zunächst ergänzen.


``` r
# Erstellen einer ID-Variable
mach$id <- 1:nrow(mach)
```

Nun können wir das ANOVA-Modell definieren. Dabei verwenden wir die Funktion `aov_4()`. Die Schreibweise ist mit der Regressionsschreibweise verwandt: Zunächst wird die abhängige Variable angegeben, danach die unabhängige Variable. Mit `summary()` können wir uns anschließend die Ergebnisse ausgeben lassen.



``` r
# Erstellen des ANOVA-Objekts
mach_anova <- aov_4(cvhn ~ education + (1|id), data = mach)
```

```
## Converting to factor: education
```

```
## Contrasts set to contr.sum for the following variables: education
```

``` r
# Ergebnisse
summary(mach_anova)
```

```
## Anova Table (Type 3 tests)
## 
## Response: cvhn
##           num Df den Df     MSE      F      ges    Pr(>F)    
## education      3  65147 0.64929 336.05 0.015239 < 2.2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Die Ergebnisse deuten auf signifikante Unterschiede zwischen den Bildungsstufen hin.

Im abgelegten Objekt können wir uns spezifisch die Quadratsummen anzeigen lassen. Diese sind in der enthaltenen ANOVA-Tabelle unter `Sum Sq` abgelegt. Da der Variablenname ein Leerzeichen enthält, müssen wir ihn mit Backticks kennzeichnen, damit `R` ihn trotzdem als zusammengehörigen Namen erkennt. Für die totale Quadratsumme können die Quadratsumme zwischen den Gruppen und die Quadratsumme innerhalb der Gruppen addiert werden. 


``` r
# Quadratsumme zwischen Gruppen
mach_anova$Anova$`Sum Sq`[2]
```

```
## [1] 654.5752
```

``` r
# Quadratsumme innerhalb der Gruppen
mach_anova$Anova$`Sum Sq`[3]
```

```
## [1] 42299.12
```

``` r
# Totale Quadratsumme
mach_anova$Anova$`Sum Sq`[2] + mach_anova$Anova$`Sum Sq`[3]
```

```
## [1] 42953.69
```

Eben haben wir bereits gesehen, wie wir an die Quadratsummen gelangen. Bei den Freiheitsgraden funktioniert dies auf dieselbe Weise. Anschließend müssen diese Werte nur noch in mittlere Quadratsummen umgerechnet werden. Daraus kann dann der empirische F-Wert bestimmt werden.


``` r
# Quadratsumme zwischen Gruppen
QS_zw <- mach_anova$Anova$`Sum Sq`[2]
# Quadratsumme innerhalb der Gruppen
QS_in <- mach_anova$Anova$`Sum Sq`[3]
# Freiheitsgrade zwischen und innerhalb
df_zw <- mach_anova$Anova$`Df`[2]
df_in <- mach_anova$Anova$`Df`[3]
# Mittlere Quadratsumme
MQS_zw <- QS_zw / df_zw
MQS_in <- QS_in / df_in
# Empirischer F-Wert
F_emp <- MQS_zw / MQS_in
# Vergleich mit dem Wert des afex-Objekts
F_emp == mach_anova$anova_table$F
```

```
## [1] TRUE
```

</details>

## Aufgabe 2

- Die ANOVA in der vorherigen Aufgabe war signifikant. Nun ist interessant, zwischen welchen Bildungsstufen sich die Mittelwerte unterscheiden. Führen Sie daher paarweise Vergleiche zwischen allen Gruppen durch und verwenden Sie eine geeignete Korrektur für multiples Testen.

<details>
<summary>Lösung</summary>

Generell können präzisere Untersuchungen nach einer ANOVA mit dem Paket `emmeans` durchgeführt werden. Die Fragestellung läuft auf einen Post-hoc-Test hinaus. Für die Nutzung des Pakets muss zunächst ein entsprechendes Objekt erstellt werden. Anschließend kann mit der Funktion `pairs()` ein Test der paarweisen Gruppenunterschiede durchgeführt werden. Eine passende Anpassung des $\alpha$-Niveaus ist hier die Tukey-Methode, da diese ebenfalls für den Vergleich aller Gruppenunterschiede vorgesehen ist.




``` r
# Erstellen Objekt für die Nutzung emmeans Paket
emm_mach_anova <- emmeans(mach_anova, ~ education)

# Durchführung paarweiser Testungen mit Tukey Korrektur
pairs(emm_mach_anova, adjust = "tukey")
```

```
##  contrast                estimate      SE    df t.ratio p.value
##  education1 - education2   0.0793 0.01100 65147   7.244 <0.0001
##  education1 - education3   0.2259 0.01100 65147  20.452 <0.0001
##  education1 - education4   0.2989 0.01220 65147  24.415 <0.0001
##  education2 - education3   0.1465 0.00746 65147  19.644 <0.0001
##  education2 - education4   0.2195 0.00914 65147  24.023 <0.0001
##  education3 - education4   0.0730 0.00925 65147   7.890 <0.0001
## 
## P value adjustment: tukey method for comparing a family of 4 estimates
```

Es werden signifikante Unterschiede zwischen allen Bildungsstufen angezeigt.

</details>
