---
title: "Itemanalyse"
type: post
date: '2022-12-06'
slug: diagnostik-itemanalyse
categories: ["Diagnostik"]
tags: ["Fragebogen", "Seminar"]
subtitle: ''
summary: ''
authors: [schnatz, farugie]
weight: 1
lastmod: '2025-02-17'
featured: no
banner:
  image: "/header/business_meeting.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/1459637)"
projects: []

reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/diagnostik/diagnostik-itemanalyse

output:
  html_document:
    keep_md: true
---




## Daten laden 

Bevor wir mit der Analyse beginnen können, muss der Datensatz eingelesen werden. Hierfür gibt es mehrere Packages, die diesen ersten Schritt erleichtern. Mit dem Package `foreign` können besonders gut SPSS-Dateien (.sav) geladen werden. Mit dem Package `readr` (aus der Familie des `tidyverse`) können ansonsten die typischsten  Datenformate (wie unter anderem .csv, .tsv und .txt) geladen werden. Schließlich gibt es noch das `readxl` Package, mit dem Excel-Dateien (.xls und .xlsx) eingelesen werden können. Für unseren Beispieldatensatz benötigen wir das Package `readr`. Wir laden hierbei das komplette tidyvere-package, welches im Hintergrund das readr-Package sowie noch andere relevante Packages läd (z.B. `dplyr`).


``` r
library(tidyverse) 
library(dplyr)
library(here)
data_gis_raw <- read_csv(url("https://raw.githubusercontent.com/jlschnatz/PsyBSc8_Diagnostik/main/src/data/GIS-data.csv"))
head(data_gis_raw) 
```

```
## # A tibble: 6 × 28
##      id   sex   ses marital profession education  GIS1  GIS2  GIS3  GIS4  GIS5  GIS6  GIS7  GIS8
##   <dbl> <dbl> <dbl>   <dbl>      <dbl>     <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1     1     1     2       1          3         5     4     3     3     3     3     3     4     4
## 2     2     1     2       1          1         3     4     3     3     4     4     4     4     4
## 3     3     1     2       3          1         3     4     3     4     4     3     3     3     4
## 4     4     1     2       1          1         3     4     3     0     3     3     4     4     4
## 5     5     0     1       1          5         5     3     4     4     3     3     4     4     4
## 6     6     1     1       2          2         5     4     3     3     4     4     4     3     3
## # ℹ 14 more variables: GIS9 <dbl>, GIS10 <dbl>, GIS11 <dbl>, GIS12 <dbl>, GIS13 <dbl>,
## #   GIS14 <dbl>, GIS15 <dbl>, GIS16 <dbl>, GIS17 <dbl>, GIS18 <dbl>, GIS19 <dbl>, GIS20 <dbl>,
## #   GIS21 <dbl>, Age <dbl>
```


## Erstellen des Hauptdatensatzes

Für die Itemanalyse brauchen wir nur die Items ohne den soziodemographischen Angaben. Daher erstellen wir einen Datensatz, der nur die Items und keine soziodemographische Angaben enthält. Dies ist mit der `select()` Funktion des dplyr-Packages sehr einfach (die Funktion gibt es in verschiedenen Paketen, daher sagen wir `R` explizit, dass es aus diesem Paket genommen werden soll mit den beiden Doppelpunkten `dplyr::select()`) Da alle Items mit dem Prefix "GIS" beginnen können wir uns eine kleine Helper-Funktion `starts_with()` des dplyr-Packages zu Nutze machen, um die Variables auszuwählen.


``` r
data_gis_item <- dplyr::select(data_gis_raw, starts_with("GIS"))
data_gis_item <- dplyr::select(data_gis_raw, 7:27) # Alternative 
colnames(data_gis_item) # Ausgabe der Spalten des Datensatzes
```

```
##  [1] "GIS1"  "GIS2"  "GIS3"  "GIS4"  "GIS5"  "GIS6"  "GIS7"  "GIS8"  "GIS9"  "GIS10" "GIS11"
## [12] "GIS12" "GIS13" "GIS14" "GIS15" "GIS16" "GIS17" "GIS18" "GIS19" "GIS20" "GIS21"
```

Bevor wir mit der deskriptiven Analyse beginnen, sollten wir noch überprüfen, ob es fehlende Werte (NAs) im Datensatz gibt. 


``` r
anyNA(data_gis_item)
```

```
## [1] FALSE
```

``` r
sum(is.na(data_gis_item)) # Alternative
```

```
## [1] 0
```

In diesem Fall, sind keine fehlenden Werte vorhanden. Es müssen also keine Werte entfernt werden. Wenn in eurem eigenen Fragebogen fehlenden Werte vorkommen sollten, können sie durch die Funktion `na.omit()` oder `drop_na()` (tidyr-Package der tidyverse Familie) entfernt werden.


``` r
na.omit(data_gis_item)
drop_na(data_gis_item)
```

## Deskriptive Analyse

Bevor wir die Itemanalyse durchführen, wollen wir uns zunächst ein wenig mit den Daten vertraut machen. Hierfür benötigen wir zwei Packages: . Das `psych`-Package beinhaltet sehr viele Funktionen und Befehle, die auch für viele andere Analysen  hilfreich sind. Das Package `janitor` ist eine bessere Alternative zum Basis-Befehl `table()` und ist besonders informativ bei Häufigkeitstabellen.

Für die Berechnung deskriptiver Kennwerte (Mittelwert, Standardabweichung, Median, etc.) können wir die `describe()` Funktion des psych-Packages verwenden:


``` r
library(psych)
describe(data_gis_item) 
```

```
##       vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## GIS1     1 300 3.44 0.74      4    3.55 0.00   0   4     4 -1.78     4.54 0.04
## GIS2     2 300 3.29 0.79      3    3.42 1.48   0   4     4 -1.49     3.30 0.05
## GIS3     3 300 3.25 0.89      3    3.40 1.48   0   4     4 -1.23     1.30 0.05
## GIS4     4 300 3.39 0.73      4    3.52 0.00   0   4     4 -1.21     1.68 0.04
## GIS5     5 300 3.23 0.68      3    3.31 0.00   1   4     3 -0.76     1.02 0.04
## GIS6     6 300 3.11 0.82      3    3.19 1.48   0   4     4 -0.79     0.63 0.05
## GIS7     7 300 3.27 0.90      3    3.44 1.48   0   4     4 -1.52     2.34 0.05
## GIS8     8 300 3.26 0.97      3    3.46 1.48   0   4     4 -1.56     2.12 0.06
## GIS9     9 300 3.15 1.03      3    3.35 1.48   0   4     4 -1.37     1.42 0.06
## GIS10   10 300 2.98 0.88      3    3.08 1.48   0   4     4 -0.88     0.84 0.05
## GIS11   11 300 3.27 0.73      3    3.37 0.00   0   4     4 -1.14     2.18 0.04
## GIS12   12 300 3.41 0.81      4    3.56 0.00   0   4     4 -1.62     2.89 0.05
## GIS13   13 300 3.29 0.82      3    3.43 1.48   0   4     4 -1.64     3.73 0.05
## GIS14   14 300 3.13 0.92      3    3.28 1.48   0   4     4 -1.20     1.41 0.05
## GIS15   15 300 3.16 0.75      3    3.26 0.00   1   4     3 -0.90     1.03 0.04
## GIS16   16 300 3.22 0.96      3    3.42 1.48   0   4     4 -1.64     2.70 0.06
## GIS17   17 300 3.11 0.93      3    3.26 1.48   0   4     4 -1.31     1.84 0.05
## GIS18   18 300 2.57 1.23      3    2.71 1.48   0   4     4 -0.87    -0.31 0.07
## GIS19   19 300 3.22 0.87      3    3.35 1.48   0   4     4 -1.26     1.76 0.05
## GIS20   20 300 2.96 0.91      3    3.06 1.48   0   4     4 -0.81     0.38 0.05
## GIS21   21 300 3.03 0.92      3    3.15 1.48   0   4     4 -1.00     0.88 0.05
```

Wenn wir nur eine spezifische Variable deskriptiv betrachten wollen (z.B. das Alter), kann in der gleichen Funktion die Variable direkt angesteuert werden.


``` r
describe(data_gis_raw$Age)
```

```
##    vars   n  mean   sd median trimmed  mad min max range skew kurtosis   se
## X1    1 300 66.53 6.17     65   65.77 5.93  55  90    35  1.2     1.58 0.36
```

Für alle kategoriellen Daten (z.B. Geschlecht, SÖS, Bildung) benötigen keine Mittelwerte oder Standardabweichungen, sondern nutzen Häufigkeitsverteilung zur deskriptiven Beschreibung. Hier kommt jetzt das janitor-Package zum Einsatz.


``` r
library(janitor)
tabyl(data_gis_raw$sex)
```

```
##  data_gis_raw$sex   n   percent
##                 0 104 0.3466667
##                 1 196 0.6533333
```

Wir bekommen die relativen und absoluten Häufigkeiten für männliche und weibliche Probanden ausgegeben. Falls es fehlenden Werte gäbe, müssten diese im Bericht auch angegeben werden. Dies ist ebenfalls mit der gleichen Funktion durch die Spezifizierung eineszusätzlichen Arguments möglich.


``` r
tabyl(data_gis_raw$sex, show_na = TRUE) 
```
Hier ist der Output genau gleich (das ist ja in dem Datensatz keine NAs gibt).

**Tipp für den Bericht:**

Für die Abschlussberichte, braucht ihr die ganzen deskriptiven Informationen in APA7 formatierten Tabellen. Hierfür eignet sich besonders das Pacakge `sjPlot`. Als Beispiel speichern wir zunächst die die vorherige deskriptive Statistik bezüglich des Alters als ein Objekt ab. Danach erstellen wir mit einer Funktion des genannten Packages eine schön formatierte Tabelle.


``` r
library(sjPlot)
descr_age <- describe(data_gis_raw$Age)
tab_df(x = descr_age)
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align:left; ">vars</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">n</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">mean</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">sd</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">median</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">trimmed</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col7">mad</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col8">min</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col9">max</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 0">range</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 1">skew</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 2">kurtosis</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 3">se</th>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; border-bottom: double; ">1</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">300</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">66.53</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">6.17</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">65</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">65.77</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col7">5.93</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col8">55</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col9">90</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 0">35</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 1">1.20</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 2">1.58</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 3">0.36</td>
</tr>
</table>

Die erstellte Tabelle kann sogar direkt als Word-Dokument abgespeichert werden, um danach noch weiter angepasst zu werden (z.B. Erstellen von Fußnoten, Tabellen-Titel, etc.). Wichtig dabei ist, dass nur die Endung .doc und nicht .docx funktioniert.


``` r
tab_df(
  x = descr_age,
  file = "table_descr_age.doc"
  )
```

Auch für die mit tabyl() erstellten Ergebnisse können wir eine Tabelle erstellen


``` r
descr_sex <- tabyl(data_gis_raw$sex)
tab_df(descr_sex)
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align:left; ">data_gis_raw.sex</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">n</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">percent</th>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">0</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">104</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.35</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; border-bottom: double; ">1</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">196</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">0.65</td>
</tr>
</table>


Zudem können wir mit dem psych-Package auch eine Tabelle nach Gruppen erstellen. Dieser Output kann dann mit einer ähnlichen Funktion des sjPlot Package in einer Tabelle dargestellt werden.


``` r
descr_age_by_sex <- describeBy(x = data_gis_raw$Age,
           group = data_gis_raw$sex) 
print(descr_age_by_sex)
```

```
## 
##  Descriptive statistics by group 
## group: 0
##    vars   n  mean   sd median trimmed  mad min max range skew kurtosis   se
## X1    1 104 66.88 6.67     65   66.01 5.93  55  90    35 1.25     1.76 0.65
## ------------------------------------------------------------------------ 
## group: 1
##    vars   n  mean  sd median trimmed  mad min max range skew kurtosis   se
## X1    1 196 66.35 5.9     65   65.67 5.93  55  89    34 1.12     1.16 0.42
```

``` r
tab_dfs(
  x = descr_age_by_sex,
  titles = c("Weiblich","Männlich"),
  )
```

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">Weiblich</caption>
<tr>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align:left; ">vars</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">n</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">mean</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">sd</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">median</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">trimmed</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col7">mad</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col8">min</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col9">max</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 0">range</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 1">skew</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 2">kurtosis</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 3">se</th>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; border-bottom: double; ">1</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">104</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">66.88</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">6.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">65</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">66.01</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col7">5.93</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col8">55</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col9">90</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 0">35</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 1">1.25</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 2">1.76</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 3">0.65</td>
</tr>
</table>
<p>&nbsp;</p><table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">M&auml;nnlich</caption>
<tr>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align:left; ">vars</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">n</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">mean</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">sd</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">median</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">trimmed</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col7">mad</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col8">min</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col9">max</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 0">range</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 1">skew</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 2">kurtosis</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 3">se</th>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; border-bottom: double; ">1</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">196</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">66.35</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">5.90</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">65</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">65.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col7">5.93</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col8">55</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col9">89</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 0">34</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 1">1.12</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 2">1.16</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 3">0.42</td>
</tr>
</table>

Es gibt auch die Möglichkeit mehrere Tabellen in ein Dokument zu packen und diese in einem Word-Dokument zu speichern:



``` r
tab_dfs(
  x = list(descr_age, descr_sex), 
  titles = c("Descriptives of Age", "Descriptives of Sex")
  )
```

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">Descriptives of Age</caption>
<tr>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align:left; ">vars</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">n</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">mean</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">sd</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">median</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">trimmed</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col7">mad</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col8">min</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col9">max</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 0">range</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 1">skew</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 2">kurtosis</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; 3">se</th>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; border-bottom: double; ">1</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">300</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">66.53</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">6.17</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">65</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">65.77</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col7">5.93</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col8">55</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col9">90</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 0">35</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 1">1.20</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 2">1.58</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; 3">0.36</td>
</tr>
</table>
<p>&nbsp;</p><table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">Descriptives of Sex</caption>
<tr>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align:left; ">data_gis_raw$sex</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">n</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">percent</th>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">0</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">104</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.35</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; border-bottom: double; ">1</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">196</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">0.65</td>
</tr>
</table>



``` r
tab_dfs(
  x = list(descr_age, descr_sex), 
  titles = c("Descriptives of Age","Descriptives of Sex"),
  file = "descriptives_all.doc" # wieder als .doc abspeichern
  )
```


## Itemanalyse

 Für die Itemanalyse benötigen wir den Datensatz in denen nur die Items vorhanden sind. Diesen haben wir bereits in einem vorherigen Schritt erstellt. Bevor wir die Itemanalyse jedoch durchführen, müssen wir alle Items, die inverse kodiert sind rekodieren.
 
 Dafür speichern wir alle inversen Items zunächst in einem Vektor ab. Anschließend verwenden wir die` mutate()` Funktion des `dplyr`-Package, mit welcher wir Variablen manupulieren/verändern können. Wir müssen dabei den Zusatz `across()` hinzunehmen, da wir mehreren Variablen gleichzeitig verändern wollen. Das Argument `.cols` gibt dabei an, welche Variablen wir verändern wollen. Mit dem Argument `.fns` spezifizieren wir, welche Funktion wir auf die Variablen anwenden wollen. Wir verwenden die Funktion `rec()` aus dem `sjmisc` Package. Die etwas ungewöhnliche Schreibweise mit der Tilde `~`und dem `.x` setzt sich wie folgt zusammen: Die Tilde müssen wir immer dann verwenden, wenn wir bei der Funktion, die wir anwenden  zusätzlich Argumente spezifizieren (`rec = "0=4; 1=3; 2=2; 3=1; 4=0"`). Das `.x` verwenden wir als Platzhalter für alle Variablen, die wir verändern wollen (GIS9, GIS16, GIS17 und GIS18). Schließlich können wir mit dem `.names` Argument einen Namen für alle veränderten Variablen spezifizieren. Das Prefix `{col}` steht dabei für den ursprünglichen Variablennamen (z.B. GIS9). Mit dem Zusatz `{col_r}` wird hängen wir dem Präfix noch ein Suffix an (GIS9 -> GIS9_r). Das Suffix kennzeichnet dabei, dass wir die Items rekodiert haben.
 

``` r
library(sjmisc)
inverse_items <- c("GIS9","GIS16","GIS17","GIS18") 
data_gis_rec <- data_gis_item %>% 
  mutate(across(
    .cols = inverse_items, 
    .fns = ~rec(x = .x, rec = "0=4; 1=3; 2=2; 3=1; 4=0"),
    .names = "{col}_r")
    ) %>% 
  dplyr::select(-inverse_items) 
colnames(data_gis_rec)
```

```
##  [1] "GIS1"    "GIS2"    "GIS3"    "GIS4"    "GIS5"    "GIS6"    "GIS7"    "GIS8"    "GIS10"  
## [10] "GIS11"   "GIS12"   "GIS13"   "GIS14"   "GIS15"   "GIS19"   "GIS20"   "GIS21"   "GIS9_r" 
## [19] "GIS16_r" "GIS17_r" "GIS18_r"
```
 
 Jetzt können wir die Itemanalyse durchführen. Wir verwenden dafür eine Funktion aus dem sjPlot Package.


``` r
sjt.itemanalysis(
  df = data_gis_rec,
  factor.groups.titles = "Erste Itemanalyse"
  )
```

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">Erste Itemanalyse</caption>
<tr>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align:left;text-align:left; ">Row</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">Missings</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">Mean</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">SD</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">Skew</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">Item Difficulty</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col7">Item Discrimination</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col8">&alpha; if deleted</th>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS1</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.44</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.74</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.8</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.86</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.60</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS2</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.29</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.79</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.5</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.47</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.84</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS3</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.25</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.89</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.25</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.59</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS4</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.39</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.73</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.85</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.61</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS5</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.23</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.68</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-0.77</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.63</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS6</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.11</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-0.8</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.78</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.58</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS7</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.27</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.9</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.53</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.55</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS8</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.26</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.97</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.57</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.59</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS10</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">2.98</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.88</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-0.89</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.75</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.62</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS11</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.27</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.73</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.16</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS12</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.41</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.64</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.85</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS13</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.29</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.66</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.68</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS14</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.13</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.92</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.21</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.78</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.63</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS15</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.16</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.75</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-0.9</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.79</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.62</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS19</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.87</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.28</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.80</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.65</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS20</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">2.96</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.91</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.74</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.73</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.82</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS21</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.03</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.92</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.01</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.76</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS9_r</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.85</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">1.03</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">1.39</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.21</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">-0.28</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.87</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS16_r</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.78</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.96</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">1.65</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.19</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">-0.14</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.86</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS17_r</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.89</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.93</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">1.32</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">-0.26</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.87</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; border-bottom: double; ">GIS18_r</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">1.43</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">1.23</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">0.88</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">0.36</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col7">-0.20</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col8">0.87</td>
</tr>
<tr>
<td colspan="9" style="font-style:italic; border-top:double black; text-align:right;">Mean inter-item-correlation=0.242 &middot; Cronbach's &alpha;=0.845</td>
</tr>
</table>

Wir sehen, dass die Variablen der Reihenfolge nach wie sie im Dataframe auftauchen, in die Tabelle aufgenommen werden. Dadurch sind die rekodierten Variablen am Ende der Tabelle platziert. Wir können die Reihenfolge der Items ändern, indem wir diese in einem Vektor spezifizieren. Anschließend verwenden wir wieder die `select()` Funktion und bringen dadurch die Variablen in die gewünschte Reihenfolge.


``` r
col_order <- c(
  "GIS1","GIS2","GIS3","GIS4","GIS5","GIS6",
  "GIS7","GIS8","GIS9_r","GIS10", "GIS11",
  "GIS12","GIS13","GIS14","GIS15","GIS16_r",
  "GIS17_r","GIS18_r", "GIS19","GIS20","GIS21"
  )
data_gis_rec2 <- dplyr::select(data_gis_rec, all_of(col_order))
sjt.itemanalysis(
  df = data_gis_rec2,
  factor.groups.titles = "Desktiptive Ergebnisse der Itemanalyse (mit angepasster Reihenfolge)"
  )
```

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">Desktiptive Ergebnisse der Itemanalyse (mit angepasster Reihenfolge)</caption>
<tr>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align:left;text-align:left; ">Row</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">Missings</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">Mean</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">SD</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">Skew</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">Item Difficulty</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col7">Item Discrimination</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col8">&alpha; if deleted</th>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS1</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.44</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.74</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.8</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.86</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.60</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS2</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.29</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.79</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.5</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.47</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.84</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS3</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.25</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.89</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.25</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.59</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS4</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.39</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.73</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.85</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.61</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS5</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.23</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.68</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-0.77</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.63</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS6</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.11</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-0.8</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.78</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.58</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS7</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.27</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.9</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.53</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.55</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS8</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.26</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.97</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.57</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.59</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS9_r</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.85</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">1.03</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">1.39</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.21</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">-0.28</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.87</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS10</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">2.98</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.88</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-0.89</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.75</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.62</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS11</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.27</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.73</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.16</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS12</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.41</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.64</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.85</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS13</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.29</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.66</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.68</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS14</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.13</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.92</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.21</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.78</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.63</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS15</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.16</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.75</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-0.9</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.79</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.62</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS16_r</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.78</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.96</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">1.65</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.19</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">-0.14</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.86</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS17_r</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.89</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.93</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">1.32</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">-0.26</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.87</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS18_r</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">1.43</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">1.23</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.88</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.36</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">-0.20</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.87</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS19</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.87</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.28</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.80</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.65</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.83</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS20</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">2.96</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.91</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.74</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.73</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.82</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; border-bottom: double; ">GIS21</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">3.03</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">0.92</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">-1.01</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">0.76</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col7">0.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col8">0.83</td>
</tr>
<tr>
<td colspan="9" style="font-style:italic; border-top:double black; text-align:right;">Mean inter-item-correlation=0.242 &middot; Cronbach's &alpha;=0.845</td>
</tr>
</table>

Wir sehen, dass alle invers gestellten Items eine schlechte Trennschärfe besitzen. Deswegen müssen diese aus der weiteren Analyse ausgeschlossen werden. Alle anderen Items besitzen sehr hohe Trennschärfen und können somit beibehalten werden.



``` r
drop_discrm <- c("GIS9_r", "GIS16_r","GIS17_r", "GIS18_r")
data_gis_final <- dplyr::select(data_gis_rec2, -all_of(drop_discrm))
```

Mit diesem Datensatz können wir nun die finale Itemanalyse durchführen:


``` r
sjt.itemanalysis(
  df = data_gis_final,
  factor.groups.titles = "Finale Itemanalyse"
  )
```

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">Finale Itemanalyse</caption>
<tr>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align:left;text-align:left; ">Row</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">Missings</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">Mean</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">SD</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">Skew</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; ">Item Difficulty</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col7">Item Discrimination</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; col8">&alpha; if deleted</th>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS1</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.44</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.74</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.8</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.86</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.62</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS2</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.29</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.79</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.5</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.49</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.94</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS3</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.25</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.89</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.25</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.65</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS4</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.39</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.73</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.85</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS5</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.23</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.68</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-0.77</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS6</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.11</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-0.8</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.78</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.64</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS7</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.27</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.9</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.53</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.60</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.94</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS8</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.26</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.97</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.57</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.68</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS10</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">2.98</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.88</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-0.89</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.75</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.63</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS11</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.27</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.73</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.16</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.70</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS12</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.41</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.81</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.64</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.85</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.73</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS13</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.29</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-1.66</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.75</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS14</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.13</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.92</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.21</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.78</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.67</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS15</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">3.16</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.75</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-0.9</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.79</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.66</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">GIS19</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">3.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.87</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">-1.28</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; ">0.80</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col7">0.70</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; background-color:#f2f2f2; ">GIS20</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">2.96</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.91</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">-0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; ">0.74</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col7">0.76</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; background-color:#f2f2f2; col8">0.93</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; border-bottom: double; ">GIS21</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">0.00 %</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">3.03</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">0.92</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">-1.01</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; ">0.76</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col7">0.69</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: double; col8">0.93</td>
</tr>
<tr>
<td colspan="9" style="font-style:italic; border-top:double black; text-align:right;">Mean inter-item-correlation=0.472 &middot; Cronbach's &alpha;=0.937</td>
</tr>
</table>

Abschließend gibt es noch die Möglichkeit, McDonald´s $\omega$ als ein alternatives Reliabilitätsmaß (zusätzlich zu Cronbach´s $\alpha$) zu bestimmen. 


``` r
omega_items <- omega(data_gis_final,
                     plot = FALSE)
omega_items$omega.tot
```

```
## [1] 0.948647
```

``` r
omega_items$alpha
```

```
## [1] 0.9381681
```

***
