---
title: Zweifaktorielle ANOVA - Lösung
type: post
date: '2026-07-15'
slug: anova-ii-loesungen
categories: Statistik II Übungen
tags: ["ANOVA", "Kontraste", "Zweifaktoriell"]
subtitle: '2-fakt. ANOVA Lösungen'
summary: Lösungen der Übung zur zweifaktoriellen ANOVA
authors: [pommeranz]
weight: 1
lastmod: '2026-07-16'
featured: no
banner:
  image: "/header/heart_alien.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1293359)"
projects: []
reading_time: no
share: no
private: 'true'
links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-ii/anova-ii
  - icon_pack: fas
    icon: pen-to-square
    name: Übungen
    url: /lehre/statistik-ii/anova-ii-uebungen
output:
  html_document:
    keep_md: true
---




## Vorbereitung

Bitte laden Sie den folgenden Datensatz welcher Items aus einem Machiavellismus-Fragebogen enthält herunter, um die nachfolgende Aufgabe zu lösen. Der Datensatz enthält viele Angaben zur Persönlichkeit und demografischen Daten. Kern ist aber der 20 Items umfassende Machiavellismusfragebogen von Christie und Geis (1970) und die daraus ableitbare 4-faktorielle Struktur des Konzepts (Corral & Calvete, 2000).


``` r
# Datensatz laden
load(url("https://pandar.netlify.app/daten/mach.rda"))
```

Weiterhin werden für die Ausführung der Aufgaben die Pakete `afex` und `emmeans` empfohlen. Eventuell müssen diese installiert werden. 


``` r
# Paket für Anova-Durchführung
# Paket installieren falls nicht vorhanden
if (!requireNamespace("afex", quietly = TRUE)) {
  install.packages("afex")
}
if (!requireNamespace("emmeans", quietly = TRUE)) {
  install.packages("emmeans")
}
```

In jedem Fall müssen sie aktiviert werden.


``` r
# Paket laden 
library(afex)
library(emmeans)
```

## Aufgabe 1: Variablen aufbereiten
Erstellen Sie zunächst für die Variablen `education` und `urban` jeweils einen Faktor. Für `education` ist die Codierung `1 = Less than High School`, `2 = High School`, `3 = University degree` und`4 = Graduate degree`. Für `urban` ist es `1 = Rural (country side)`, `2 = Suburban` und `3 = Urban (city, town)`.

<details><summary>Lösung</summary>


``` r
mach$education_fac <- factor(mach$education, levels=1:4, labels=c("Less than High School", "High School", "University degree", "Graduate degree"))
mach$urban_fac <- factor(mach$urban, levels = 1:3, labels = c("Rural", "Suburban", "Urban"))
```

</details>


## Aufgabe 2: Deskriptivstatistik & folgende Erwartungshaltung
Betrachten Sie nun nach der Erstellung der Faktoren deskriptistatistisch, welchen Effekt Bildung und Ländlichkeit des Wohnortes auf negative zwischenmenschliche Taktiten `nit` haben. Hierbei interessieren uns sowohl Unterschiede zwischen den Stufen, als auch mögliche Interaktionseffekte.

<details><summary>Lösung</summary>
Die Mittelwerte für alle Gruppenkonstellationen kann man beispielsweise mit `aggregate` erstellen lassen.


``` r
aggregate(nit ~ education_fac + urban_fac, mach, mean)
```

```
##            education_fac urban_fac      nit
## 1  Less than High School     Rural 3.491461
## 2            High School     Rural 3.440724
## 3      University degree     Rural 3.295031
## 4        Graduate degree     Rural 3.224247
## 5  Less than High School  Suburban 3.564225
## 6            High School  Suburban 3.484743
## 7      University degree  Suburban 3.316169
## 8        Graduate degree  Suburban 3.201780
## 9  Less than High School     Urban 3.607052
## 10           High School     Urban 3.530450
## 11     University degree     Urban 3.454017
## 12       Graduate degree     Urban 3.413716
```

``` r
aggregate(nit ~ urban_fac + education_fac, mach, mean)
```

```
##    urban_fac         education_fac      nit
## 1      Rural Less than High School 3.491461
## 2   Suburban Less than High School 3.564225
## 3      Urban Less than High School 3.607052
## 4      Rural           High School 3.440724
## 5   Suburban           High School 3.484743
## 6      Urban           High School 3.530450
## 7      Rural     University degree 3.295031
## 8   Suburban     University degree 3.316169
## 9      Urban     University degree 3.454017
## 10     Rural       Graduate degree 3.224247
## 11  Suburban       Graduate degree 3.201780
## 12     Urban       Graduate degree 3.413716
```

Eine Betrachtung der Werte lässt, besonders gegeben der Anzahl an Beobachtungen, mögliche Haupteffekte und Interaktionen zwischen und auf beiden Faktoren vermuten.
</details>

## Aufgabe 3: Zweifaktorielle ANOVA
Führen Sie die zweifaktorielle ANOVA durch. Interpretieren Sie den Output. Welcher Quadratsummentyp eignet sich für die Untersuchung der Haupteffekte?

<details><summary>Lösung</summary>
Für die Durchführung der ANOVA können wir das Paket `afex` nutzen. Zunächst muss die Variable `id` erstellt werden, die für jede Person eine eindeutige ID enthält.


``` r
mach$id <- 1:nrow(mach)

ano_zwei_fakt <- aov_4(nit ~ education_fac + urban_fac + education_fac * urban_fac+ (1|id), data = mach, type = 3)
```

```
## Contrasts set to contr.sum for the following variables: education_fac, urban_fac
```

``` r
summary(ano_zwei_fakt)
```

```
## Anova Table (Type 3 tests)
## 
## Response: nit
##                         num Df den Df    MSE        F       ges    Pr(>F)    
## education_fac                3  65139 1.1305 139.1722 0.0063688 < 2.2e-16 ***
## urban_fac                    2  65139 1.1305  77.6364 0.0023780 < 2.2e-16 ***
## education_fac:urban_fac      6  65139 1.1305   8.1254 0.0007479 8.423e-09 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
Da auch die Interaktion signifikant ist, nutzen wir hier die Quadratsummen des Typ 3. 
</details>

## Aufgabe 4: Post-Hoc: Spezifische Gruppenunterschiede
Stellen sie nun Kontraste für folgende Gruppenvergleiche auf:
Für ländliche Lage:
"`Rural` vs Rest"
"`Suburban` vs `Urban`"

sowie für Bildung:
"`Less than Highschool` vs Rest"
"`Highschool` vs `University degree` & `Graduate degree`"
"`University degree` vs `Graduate degree`".

Beschreiben Sie kurz die Ergebnisse jedes Kontrasts.

<details><summary>Lösung</summary>


``` r
emm_zweifakt <- emmeans(ano_zwei_fakt, ~ education_fac + urban_fac + education_fac:urban_fac)

# Stadt-Land Kontraste
contrast(emm_zweifakt,
  method = list(
    "Rural vs Rest" =
      c( 2, 2, 2, 2,
        -1,-1,-1,-1,
        -1,-1,-1,-1)
  ))
```

```
##  contrast      estimate     SE    df t.ratio p.value
##  Rural vs Rest   -0.669 0.0998 65139  -6.707 <0.0001
```

``` r
contrast(emm_zweifakt,
  method = list(
    "Suburban vs Urban" =
      c(0,0,0,0,
        1,1,1,1,
       -1,-1,-1,-1)
  ))
```

```
##  contrast          estimate     SE    df t.ratio p.value
##  Suburban vs Urban   -0.438 0.0419 65139 -10.473 <0.0001
```

``` r
# Bildungskontraste
contrast(emm_zweifakt,
  method = list(
    "Less vs Higher" =
      c( 3,-1,-1,-1,
         3,-1,-1,-1,
         3,-1,-1,-1)
  ))
```

```
##  contrast       estimate    SE    df t.ratio p.value
##  Less vs Higher     1.63 0.136 65139  11.957 <0.0001
```

``` r
contrast(emm_zweifakt,
  method = list(
    "High vs Uni+Grad" =
      c(0, 2,-1,-1,
        0, 2,-1,-1,
        0, 2,-1,-1)
  ))
```

```
##  contrast         estimate     SE    df t.ratio p.value
##  High vs Uni+Grad     1.01 0.0582 65139  17.303 <0.0001
```

``` r
contrast(emm_zweifakt,
  method = list(
    "Uni vs Grad" =
      c(0,0,1,-1,
        0,0,1,-1,
        0,0,1,-1)
  ))
```

```
##  contrast    estimate     SE    df t.ratio p.value
##  Uni vs Grad    0.225 0.0386 65139   5.844 <0.0001
```
</details>

## Aufgabe 5: Grafische Darstellung der Gruppenstatistik
[In dem PandaR Tutorial](/lehre/statistik-ii/anova-ii) finden Sie eine Anleitung, wie Sie für die ANOVA eine schöne Grafik mit ggplot2 erstellen können. Erstellen Sie eine Grafik, die die Mittelwertsunterschiede der zweifaktoriellen ANOVA visualisiert.

<details><summary>Lösung</summary>
Die Grundlage für die Zeichnung schaffen wir mit der `aggregate()`-Funktion. Diese fasst die Daten auf Basis der Mittelwerte zusammen. Den Rest kann man mit den bekannten `ggplot2`-Funktionen erledigen. Dafür muss das Paket natürlich auch aktiviert werden.


``` r
library(ggplot2)

aggregate(nit ~ education_fac + urban_fac, mach, mean) |> 
  ggplot(aes(x = education_fac, y = nit, color = urban_fac, group = urban_fac)) +
    geom_point() +
    geom_line() +
    labs(x = "Education", y = "Mittelwert NIT", color = "Urban")
```

![](/anova-ii-loesungen_files/unnamed-chunk-8-1.png)<!-- -->
</details>

