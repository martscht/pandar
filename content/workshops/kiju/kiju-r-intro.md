---
title: "Einführung in R und R-Studio"
type: post
date: '2023-02-23'
slug: kiju-r-intro
categories: ["KiJu"]
tags: ["Intro"]
subtitle: ''
summary: ''
authors: [nehler, schreiner]
weight: 1
lastmod: '2024-01-10'
featured: no
banner:
  image: "/header/lightbeams_converging_night.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/113795)"
projects: []

reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /workshops/kiju/kiju-r-intro
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /workshops/kiju/kiju-r-intro.R


output:
  html_document:
    keep_md: true
---




## Einordnung der Begriffe

`R` und RStudio werden meist Synonym verwendet. Dabei gibt es eigentlich einen Unterschied. Während `R` eine Sprache ist, auf der also unsere ganze Syntax basieren wird, bietet RStudio eine benutzerfreundlichere Oberfläche. Weitere Infos zu den beiden Bestandteilen finden sich [hier](/lehre/statistik-i/crash-kurs/#R). Eine Beschreibung der Oberfläche kann man [hier](/lehre/statistik-i/crash-kurs/#RStudio) finden. Dort wird auch die Funktionalität der einzelnen Fenster beschrieben und die Wichtigkeit eines Skripts erläutert.

## Überschriften und Kommentare

Reiner Code als Skript ist aus mehreren Gründen nicht gut. Andere Personen haben es ohne Kommentare in einem Skript viel schwerer, die dargestellten Schritte nachzuvollziehen. Darüber hinaus weiß man häufig selbst später nicht mehr genau, was man an spezifischen Stellen versucht hat zu erreichen. `R` bietet daher Möglichkeiten zur Gliederung anhand von Überschriften und Kommentaren - beide involvieren die Nutzung von `#`.


```r
#### Überschrift ----
# Kommentar
```

## Einfache Rechenoperationen und Logik

Natürlich bietet `R` erstmal ganz klassisch die Möglichkeit, Operationen eines Taschenrechners durchzuführen. Neben Addition und Subtraktion mit offensichtlicher Zeichenbelegung werden folgende Zeichen genutzt:


```r
2 * 3 # Multiplikation
```

```
## [1] 6
```

```r
2 / 3 # Division
```

```
## [1] 0.6666667
```

```r
2 ^ 3 # Potenz
```

```
## [1] 8
```

Eine wichtige Grundlage ist außerdem die Nutzung von logischen Abfragen. Dabei kann `R` für uns überprüfen, ob zwei Einträge bspw. gleich sind oder sich voneinander unterscheiden. Folgende Abfragen wären bspw. möglich: 


```r
2 == 3 # ist gleich?
```

```
## [1] FALSE
```

```r
2 != 3 # ist ungleich?
```

```
## [1] TRUE
```

```r
2 < 3  # ist kleiner?
```

```
## [1] TRUE
```

Weitere Informationen finden sich [hier](/lehre/statistik-i/crash-kurs/#Taschenrechner).

## Funktionen

In `R` können wir auf Funktionen zurückgreifen, um nicht alles, was ausgeführt werden soll, selbst schreiben zu müssen. Funktionen in R haben folgende generelle Struktur: 


```r
funktion(argument1, argument2, ...)
```
Wir schauen uns zunächst ein simples Beispiel einer Funktion an:


```r
log(x = 2, base = 3)
```

```
## [1] 0.6309298
```

```r
log(3, 2)
```

```
## [1] 1.584963
```

```r
log(base = 3, x = 2)
```

```
## [1] 0.6309298
```
Offenbar muss man entweder die Reihenfolge der Argumente kennen, dann kann man es sich sparen, die Namen der Argumente zu benennen. Wenn man die Reihenfolge jedoch nicht kennnt, ist es erforderlich, die Namen anzugeben. 
Weil man beides nicht unbedingt kennt und einem auch die Bedeutung der Argumente unter Umständen nicht klar ist, gibt es die Möglichkeit `R` nach Hilfe zu fragen. 


```r
help(log)
```

Hier könnt ihr klicken, um mehr zu [Funktionen](/lehre/statistik-i/crash-kurs/#Funktionen) und zur [Hilfe](/lehre/statistik-i/crash-kurs/#Hilfe) zu erfahren.

## Objekte und das Environment

Nicht immer ist es notwendig, dass uns Ergebnisse direkt in der Konsole ausgedruckt werden. Mitunter wollen wir Ergebnisse eigentlich nur zwischenspeichern, um sie dann weiter zu verwenden. 
Dafür bietet `R` die Möglichkeit, Ergebnisse in sogenannten Objekten abzulegen. Die Zuweisung eines Ergebnisses zu einem Objekt erfolgt über den Zuweisungspfeil `<-`.
Diese Zuweisung bewirkt, dass Ergebnisse nicht in der Konsolte angezeigt, sondern im Environment abgelegt werden. 



```r
num <- log(x = 2, base = 3)
```

Objekte können dann auch in anderen Funktionen genutzt werden. In diesem Crash-Kurs sind Objekte nur Zahlen, aber wir werden später sehen, dass auch andere Sachen Objekte sein können.


```r
num_sqrt <- sqrt(num)
num_sqrt
```

```
## [1] 0.7943109
```

Eine detaillierte Aufbereitung zu Objekten und dem Environment ist an diesem [Ort](/lehre/statistik-i/crash-kurs/#Environment) zu finden.

## Pakete

Nicht alle Funktionen, die wir in `R` verwenden können, sind in der Basisinstallation enthalten. Es gibt sogenannte Pakete, die zusätzlich installiert werden müssen, bevor wir die darin implementierten Funktionen nutzen können. 
Beispielsweise die Funktion, die wir benötigen, um einen SPSS Datensatz einzulesen, können wir erst verwenden, wenn wir das entsprechende Paket `haven` installiert haben. Dies tun wir mittels der Funktion `install.packages()`.


```r
# Installation Für Einladen SPSS Datensätze 
install.packages('haven', dependencies = TRUE)
```

Mit der Installation eines Pakets sind die darin implementierten Funktionen noch nicht direkt nutzbar. Das Paket muss jetzt nämlich noch mit der Funktion `library` in die aktuelle Session geladen werden.



```r
library(haven)
```

Das Prinzip vom Installieren und Laden von Paketen wird [hier](/lehre/statistik-i/tests-konfidenzintervalle/) ausführlicher beschrieben. 

## Datensatz einladen

Der Datensatz, mit dem wir im Folgenden arbeiten werden, ist unter [diesem Link](/daten/fb22_mod.sav) auffindbar. Um den Datensatz nun in `R` zu laden, müssen wir das sogenannte _Working Directory_ unter Umständen verschieben. Bei dem _Working Directory_ handelt es sich um den Ordner, in dem `R` in unserem lokalen System nach Dateien schaut. Um einen Ordner als _Working Directoy_ zu bestimmen, müssen wir `R` den Pfad zu diesem Ordner mit dem Befehl `setwd()` mitteilen. Mit `getwd()` erfahren wir den Ordnerpfad des aktuellen _Working Directorys_. 



```r
getwd()
setwd("~/Pfad/zu/Ordner")
```

Wie im Workshop besprochen, kann es hilfreich sein, dass _Working Directory_ automatisch auf den Ort zu setzen, wo das `R`-Skript abgespeichert ist. (Natürlich muss dafür das Skript auch tatsächlich abgespeichert sein.) Der Code, um ebendas umzusetzen, ist etwas kompliziert und deshalb hier nicht genauer erklärt. Es funktioniert aber ganz einfach, indem ihr Folgendes kopiert: 


```r
rstudioapi::getActiveDocumentContext()$path |>
  dirname() |>
  setwd()
```

Grundsätzlich funktioniert das Einladen eines Datensatzes verschieden je nach Format, in dem der Datensatz vorliegt. Wir konzentrieren uns erst einmal auf ein gängiges SPSS Format, das SAV Format. Dateien im SAV Format können mit einer Funktion eingelesen werden, die sich in dem eben aktivierten Paket `haven` befindet: 


```r
data <- read_sav(file = "fb22_mod.sav")
```




## Arbeit mit Datensatz

Zunächst wollen wir uns in unserem Datensatz etwas orientieren. Dazu lassen wir die Anzahl an Messungen und Variablen ausgeben, sowie die Variablennamen. 


```r
dim(data)
```

```
## [1] 153  36
```

```r
names(data)
```

```
##  [1] "prok1"   "prok2"   "prok3"   "prok4"   "prok5"   "prok6"  
##  [7] "prok7"   "prok8"   "prok9"   "prok10"  "nr1"     "nr2"    
## [13] "nr3"     "nr4"     "nr5"     "nr6"     "lz"      "extra"  
## [19] "vertr"   "gewis"   "neuro"   "intel"   "nerd"    "grund"  
## [25] "fach"    "ziel"    "lerntyp" "geschl"  "job"     "ort"    
## [31] "ort12"   "wohnen"  "uni1"    "uni2"    "uni3"    "uni4"
```

Häufig benötigt man Befehle zur Datensatzreduktion häufig, um Analysen für einen bestimmten Teil der Daten durchzuführen.
Die Auswahl einer einzelnen Variable funktioniert mit dem `$` Zeichen.


```r
data$extra
```

```
##   [1] 2.75 3.75 4.25 2.50 3.00 2.75 4.75 5.00 2.00 2.25 4.00 3.00
##  [13] 2.75 2.75 4.00 3.00 3.50 4.25 2.00 3.75 3.25 4.25 3.25 3.50
##  [25] 3.50 4.50 3.75 4.25 3.75 4.25 3.25 3.00 3.25 2.75 3.25 3.25
##  [37] 2.75 2.50 3.00 2.00 4.50 3.00 3.75 1.75 3.00 4.00 3.75 3.50
##  [49] 3.00 4.00 4.00 5.00 2.00 2.25 2.75 3.75 4.75 4.00 4.25 5.00
##  [61] 2.75 3.25 3.50 3.25 3.50 4.50 4.75 3.75 3.00 3.25 3.25 4.25
##  [73] 3.50 3.75 2.75 4.00 3.50 1.50 3.50 3.75 2.25 3.25 3.00 3.25
##  [85] 3.50 2.75 3.25 2.75 4.25 4.50 3.25 3.00 3.25 3.25 3.50 4.00
##  [97] 3.75 3.25 3.75 3.25 3.75 3.00 2.50 4.00 4.00 3.75 2.25 2.75
## [109] 3.25 2.25 3.50 2.75 3.25 2.50 2.25 2.75 3.50 4.00 4.00 2.25
## [121] 2.25 4.25 3.25 3.25 3.00 3.75 3.75 2.25 3.50 3.25 3.25 4.00
## [133] 2.25 3.75 3.50 4.00 3.75 2.75 2.75 3.25 4.50 3.00 2.75 3.75
## [145] 3.25 4.25 4.25 3.00 3.50 3.00 3.00 3.50 4.50
## attr(,"format.spss")
## [1] "F4.2"
```

Die Variable `extra` enthält die Ausprägungen in der Extraversion der Studierenden. Hierbei handelt es sich offenbar um Skalenwerte. Wie man selbst aus mehreren Items einen Skalenwert erstellt, schauen wir uns später auch noch an. 

Daten sind jeweils in einer spezifischen Format abgelegt, das man mit `class` erfragen kann.


```r
class(data$extra)
```

```
## [1] "numeric"
```

Die Skalenwerte sind in diesem Fall also numerisch. Betrachten wir nun einmal Daten, die in Textform vorliegen. Die Variable `grund` enthält die von den Studierenden genannten Gründe für die Aufnahme des Psychologie-Studiums.  
(Wenn ihr das ausführt, sollte mehr in der Konsole erscheinen, wir haben hier zur Übersichtlichkeit weniger anzeigen lassen.)


```r
data$grund
class(data$grund)
```


```
##  [1] "Interesse"                                                                                                                                 
##  [2] "Allgemeines Interesse schon seit der Kindheit"                                                                                             
##  [3] "menschliche Kognition wichtig und rätselhaft; Interesse für Psychoanalyse; Schnittstelle zur Linguistik"                                   
##  [4] "Ich kann viel in Psychologie über mich und meine Mitmenschen lernen."                                                                      
##  [5] "Interesse an dem Beruf des Therapeuten sowie an der Forschung"                                                                             
##  [6] "Einer von einigen Interessensbereichen mit dem man etwas beruflich anfangen kann; mit Philosophie oder Geschichte wird man halt arbeitslos"
##  [7] "durch den Orientierungstest"                                                                                                               
##  [8] "Interesse und eigene Erfahrung"                                                                                                            
##  [9] "interessant und anspruchsvoll"                                                                                                             
## [10] "Zentrum meiner Interessen: Politik, Philosophie"
```

```
## [1] "character"
```

Das Format, in dem diese Daten gespeichert sind, wird als `character` bezeichnet. 
Die Ausprägung jeder Person in der Variable `grund` ist individuell, weil jede Person ihren eigenen Text verfasst hat. 
Es gibt aber auch Variablen mit text-Ausprägungen, die sich wiederholen. Ein Beispiel hierfür wäre das Geschlecht, bei dem jeder Person eine der drei Ausprägungen "männlich", "weiblich" oder "divers" zugeordnet wird. 


```r
data$geschl
```

```
##   [1]  1  2  2  1 NA  2  1  1  1  2  1  1  1  1  1  1  1  1  2  1
##  [21] NA  1  1  1  1  2  1  1  1  1  1  1  1  2  1  1  1  1  1  1
##  [41]  1  1  1  1  1  1  1 NA  1  2  1  2  1  1  1  2  1 NA NA  1
##  [61]  3  1  1  1  1  1  1  1  1  1  1  1  2  2  2  1  2  2  1  1
##  [81]  1  1  1  1  1  1  1  1 NA  1  1  1  1  1  1 NA  2  1  1  1
## [101]  1 NA  1 NA  1  1  2  1  1  1  1  1  1  1  1  1  1  1  1  2
## [121]  1  1 NA  2  1  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1
## [141]  1  1  1  1  1  1  1  1  1  1  2  1  1
## attr(,"format.spss")
## [1] "F8.2"
```

```r
class(data$geschl)
```

```
## [1] "numeric"
```

Wir stellen fest, dass das Geschlecht beim Einlesen erstmal numerisch vorliegt. (Die NAs ignorieren wir zunächst und kommen später nochmal darauf zu sprechen.) 
Die Bedeutung der Zahlen sollte aber zugeordnet werden; zum einen aus optischen Gründen bei der Auswertung, aber auch im Sinne der Funktionalität, wie wir im zweiten Abschnitt des Workshops noch sehen werden. 
Eine solche Art von Variable wird als Faktor-Variable bezeichnet. Die Übertragung der numerisch vorliegenden Variable Geschlecht in eine Faktor-Variable lässt sich einfach mit dem Befehl `factor()` umsetzen. Im Datensatz speichern wir die erstellte Faktor-Variable in einer neuen Spalte ab. 
<br>
Anmerkung: Die Funktion `c()` öffnet einen Vektor, also eine Datenreihe. 


```r
data$geschl_faktor <- factor(data$geschl,                                   # Ausgangsvariable
                             levels = c(1, 2, 3),                           # Faktorstufen
                             labels = c("weiblich", "männlich", "anderes")) # Label für Faktorstufen
```

Die soeben transformierte Variable können wir jetzt nochmal betrachten, indem wir sie uns in der Konsole ausgeben lassen und den `class()`-Befehl auf sie anwenden. 


```r
data$geschl_faktor
```

```
##   [1] weiblich männlich männlich weiblich <NA>     männlich
##   [7] weiblich weiblich weiblich männlich weiblich weiblich
##  [13] weiblich weiblich weiblich weiblich weiblich weiblich
##  [19] männlich weiblich <NA>     weiblich weiblich weiblich
##  [25] weiblich männlich weiblich weiblich weiblich weiblich
##  [31] weiblich weiblich weiblich männlich weiblich weiblich
##  [37] weiblich weiblich weiblich weiblich weiblich weiblich
##  [43] weiblich weiblich weiblich weiblich weiblich <NA>    
##  [49] weiblich männlich weiblich männlich weiblich weiblich
##  [55] weiblich männlich weiblich <NA>     <NA>     weiblich
##  [61] anderes  weiblich weiblich weiblich weiblich weiblich
##  [67] weiblich weiblich weiblich weiblich weiblich weiblich
##  [73] männlich männlich männlich weiblich männlich männlich
##  [79] weiblich weiblich weiblich weiblich weiblich weiblich
##  [85] weiblich weiblich weiblich weiblich <NA>     weiblich
##  [91] weiblich weiblich weiblich weiblich weiblich <NA>    
##  [97] männlich weiblich weiblich weiblich weiblich <NA>    
## [103] weiblich <NA>     weiblich weiblich männlich weiblich
## [109] weiblich weiblich weiblich weiblich weiblich weiblich
## [115] weiblich weiblich weiblich weiblich weiblich männlich
## [121] weiblich weiblich <NA>     männlich weiblich männlich
## [127] weiblich weiblich weiblich weiblich weiblich weiblich
## [133] weiblich weiblich weiblich weiblich weiblich weiblich
## [139] weiblich weiblich weiblich weiblich weiblich weiblich
## [145] weiblich weiblich weiblich weiblich weiblich weiblich
## [151] männlich weiblich weiblich
## Levels: weiblich männlich anderes
```

```r
class(data$geschl_faktor)
```

```
## [1] "factor"
```

Wir kommen jetzt noch einmal kurz auf die NA zu sprechen: Sie repräsentieren in `R` fehlende Werte. Einige Befehle zu fehlenden Werten finden sich [hier](//lehre/statistik-i/deskriptiv-nominal-ordinal/#Fehlend).


Bisher haben wir gesehen, wie einzelne Variablen ausgewählt werden können und wie man deren Typ überprüfen kann. 
Es ist aber auch möglich, mehrere Variablen (also Spalten) auszuwählen, ebenso wie mehrere Zeilen. Mit dem Doppelpunkt `:` lässt sich ein Vektor erstellen, der alle Zahlen enthält, die sich zwischen den angegebene Grenzen (vor und nach dem Doppelpunkt) befinden. 



```r
data[1:5,]
```

```
## # A tibble: 5 × 37
##   prok1 prok2 prok3 prok4 prok5 prok6 prok7 prok8 prok9 prok10
##   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl>
## 1     1     3     4     2     3     4     3     3     1      3
## 2     4     3     2     4     1     4     2     4     4      4
## 3     3     3     2     4     2     4     2     3     4      3
## 4     2     1     4     3     2     1     2     4     1      1
## 5     2     4     2     2     3     2     3     2     1      3
## # ℹ 27 more variables: nr1 <dbl>, nr2 <dbl>, nr3 <dbl>,
## #   nr4 <dbl>, nr5 <dbl>, nr6 <dbl>, lz <dbl>, extra <dbl>,
## #   vertr <dbl>, gewis <dbl>, neuro <dbl>, intel <dbl>,
## #   nerd <dbl>, grund <chr>, fach <chr>, ziel <chr>,
## #   lerntyp <chr>, geschl <dbl>, job <dbl>, ort <dbl>,
## #   ort12 <chr>, wohnen <dbl>, uni1 <dbl>, uni2 <dbl>,
## #   uni3 <dbl>, uni4 <dbl>, geschl_faktor <fct>
```

```r
data[,1:3]
```

```
## # A tibble: 153 × 3
##    prok1 prok2 prok3
##    <dbl> <dbl> <dbl>
##  1     1     3     4
##  2     4     3     2
##  3     3     3     2
##  4     2     1     4
##  5     2     4     2
##  6     2     2     3
##  7     2     3     2
##  8     4     3     2
##  9     2     3     3
## 10     3     1     2
## # ℹ 143 more rows
```

```r
data[,c("prok1", "prok2", "prok3")]
```

```
## # A tibble: 153 × 3
##    prok1 prok2 prok3
##    <dbl> <dbl> <dbl>
##  1     1     3     4
##  2     4     3     2
##  3     3     3     2
##  4     2     1     4
##  5     2     4     2
##  6     2     2     3
##  7     2     3     2
##  8     4     3     2
##  9     2     3     3
## 10     3     1     2
## # ℹ 143 more rows
```

Diese Möglichkeit der Auswahl von Zeilen oder Spalten lässt sich auch mit der bereits gelernten Logik verknüpfen.  Wir können beispielsweise alle Zeilen auswählen, für die die Ausprägung einer Variable einer bestimmten Bedingung entspricht: 


```r
data[data$geschl_faktor == "weiblich" | data$geschl_faktor == "männlich",]
```

```
## # A tibble: 152 × 37
##    prok1 prok2 prok3 prok4 prok5 prok6 prok7 prok8 prok9 prok10
##    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl>
##  1     1     3     4     2     3     4     3     3     1      3
##  2     4     3     2     4     1     4     2     4     4      4
##  3     3     3     2     4     2     4     2     3     4      3
##  4     2     1     4     3     2     1     2     4     1      1
##  5    NA    NA    NA    NA    NA    NA    NA    NA    NA     NA
##  6     2     2     3     2     3     2     3     3     2      1
##  7     2     3     2     3     4     2     3     4     3      1
##  8     4     3     2     4     2     4     3     2     4      4
##  9     2     3     3     1     3     2     3     4     2      1
## 10     3     1     2     2     3     2     3     4     3      4
## # ℹ 142 more rows
## # ℹ 27 more variables: nr1 <dbl>, nr2 <dbl>, nr3 <dbl>,
## #   nr4 <dbl>, nr5 <dbl>, nr6 <dbl>, lz <dbl>, extra <dbl>,
## #   vertr <dbl>, gewis <dbl>, neuro <dbl>, intel <dbl>,
## #   nerd <dbl>, grund <chr>, fach <chr>, ziel <chr>,
## #   lerntyp <chr>, geschl <dbl>, job <dbl>, ort <dbl>,
## #   ort12 <chr>, wohnen <dbl>, uni1 <dbl>, uni2 <dbl>, …
```


## Einfache Deskriptivstatistik

Viele Befehle für die einfache Deskriptivstatistik gehören direkt zu den Basisfunktionen von `R`.


```r
table(data$geschl_faktor)   # Häufigkeiten
```

```
## 
## weiblich männlich  anderes 
##      121       21        1
```

```r
mean(data$extra)            # Mittelwert
```

```
## [1] 3.370915
```

```r
cor(data$prok1, data$prok2) # Korrelation
```

```
## [1] -0.2479138
```

Weitere deskriptive Operationen sind in vielen anderen Tutorials zu finden - hauptsächlich in [PsyBSc2](/lehre/main/#statistik-i).


Schauen wir uns jetzt noch an, wie sich die Erstellung von Skalenwerten als Kombination der Datensatzauswahl und einfachen deskriptiven Funktionen umsetzen lässt. 
Wir wollen dafür beispielhaft für die Variable Naturverbundenheit einen Skalenwert erstellen, der sich als der Mittelwert aus den ensprechenden 6 Items ergibt. Jede Person (also jede Reihe) erhält ihren Mittelwert. 


```r
data$nr_ges <- rowMeans(data[,c("nr1", "nr2", "nr3", "nr4", "nr5", "nr6")])
```

Mehr zu der Erstellung von Skalenwerten und dem in diesem Zusammenhang unter Umständen erforderliche Rekodieren von Items findet sich [hier](/lehre/statistik-i/deskriptiv-intervall/#Rekodieren).

## Fazit

Wir haben nun erste Befehle kennengelernt, uns aber besonders mit der Art der Datenverarbeitung beschäftigt. Das nächste Tutorial beginnt dann mit der linearen Modellierung. Im Folgenden finden sich noch Anwendungen des gelernten Codes. 

## Anwendungen

1. Erstelle einen Faktor aus der Variable "wohnen", die folgendermaßen kodiert ist: 1 - WG, 2 - bei Eltern, 3 - alleine, 4 - sonstiges.

<details><summary>Lösung</summary>


```r
class(data$wohnen)
```

```
## [1] "numeric"
```

```r
data$wohnen_faktor <- factor(data$wohnen,                                   
                             levels = c(1, 2, 3, 4),                                
                             labels = c("WG", "bei Eltern", "alleine", "sonstiges")) 

str(data$wohnen_faktor)
```

```
##  Factor w/ 4 levels "WG","bei Eltern",..: 2 2 3 2 NA 2 1 3 2 1 ...
```

</details>

2. Reduziere den Datensatz mittels der `subset()`-Funktion auf diejenigen, die in einer WG leben und lege die Reduktion in einem neuen Objekt ab. Nutze dafür die interne Hilfe.

<details><summary>Lösung</summary>


```r
data_WG <- subset(data, 
                  subset = wohnen_faktor == "WG"
                  )
```

</details>

3. Erstelle im gesamten Datensatz einen Skalenwert für alle positiv formulierten Perfektionismus-Items (1, 4, 6, 9 und 10).

<details><summary>Lösung</summary>


```r
data$prok <- rowMeans(data[,c("prok1", "prok4", "prok6", "prok9", "prok10")])
```

</details>

4. Bestimme den Mittelwert, das Minimum und das Maximum für die eben bestimmten Werte.

<details><summary>Lösung</summary>


```r
mean(data$prok)
```

```
## [1] 2.688889
```

```r
min(data$prok)
```

```
## [1] 1.2
```

```r
max(data$prok)
```

```
## [1] 4
```

</details>
