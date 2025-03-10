---
title: Nutzung von Paketen und Bestimmung Deskriptivstatistiken
type: post
date: '2025-02-28'
slug: fdz-packages-descriptive
categories: ["fdz"]
tags: ["Grafiken", "Regression"]
subtitle: ''
summary: ''
authors: [nehler]
weight: 2
lastmod: '2025-03-10'
featured: no
banner:
  image: "/header/metal_beams_electricity.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/140211)"
projects: []

reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /workshops/fdz/fdz-packages-descriptive
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /workshops/fdz/fdz-packages-descriptive.R
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /workshops/fdz/fdz-packages-descriptive-aufgaben
  - icon_pack: fas
    icon: star
    name: Lösungen
    url: /workshops/fdz/fdz-packages-descriptive-loesungen


output:
  html_document:
    keep_md: true
---





Nachdem wir im letzten Skript die Grundlagen von `R` und `RStudio` kennengelernt haben, wollen wir uns nun mit der Nutzung von Paketen und der Bestimmung von Deskriptivstatistiken beschäftigen. Hierfür wollen wir mit einem leicht angepassten Datensatz aus einer Studie von Pennington et al. aus dem Jahre 2021 ([Link zum Artikel](https://doi.org/10.1111/jasp.12711)) arbeiten. 

Wie bereits im letzten Skript angekündigt, können Dateien grundsätzlich auch per Klick in R eingelesen werden. In diesem Fall gibt es jedoch zwei Herausforderungen. Da es sich um eine Excel-Datei handelt, bringt die Basisinstallation von R nicht die notwendige Funktionalität mit, um sie direkt zu verarbeiten. Zudem enthält die Datei mehrere Arbeitsblätter, wobei das erste als Codebook dient. Das erschwert das Einlesen über die grafische Oberfläche. Um diese Probleme zu lösen, werden wir zunächst die erforderlichen Funktionalitäten installieren und uns dann damit beschäftigen, wie sich die Datei direkt per Code einlesen lässt.

## Pakete

Nicht alle Funktionen, die wir in `R` verwenden können, sind in der Basisinstallation enthalten. Es gibt sogenannte Pakete, die zusätzlich installiert werden müssen, bevor wir die darin implementierten Funktionen nutzen können. Dies liegt daran, dass es einfach viel zu viele Pakete in R gibt und diese die Festplatte eines Computers überfordern würden, wenn sie alle auf einmal installiert wären.

Beispielsweise die Funktion, die wir benötigen, um einen Excel Datensatz einzulesen, können wir erst verwenden, wenn wir das entsprechende Paket `readxl` installiert haben. Dies tun wir mittels der Funktion `install.packages()`.


``` r
#### Datensatz einlesen (vorbereiten) ----
# Installation eines Paketes Für Einladen Excel Dateien 
install.packages('readxl')
```

Mit der Installation eines Pakets sind die darin implementierten Funktionen noch nicht direkt nutzbar. Dies soll bei dem Besitz von vielen Paketen davor schützen, den Arbeitsspeicher zu überlasten. Pakete müssen demnach vor der Nutzung noch mit der Funktion `library()` in die aktuelle Session geladen werden.


``` r
library(readxl) # Paket aktivieren
```

Die Installation ist also (abgesehen von Updates) nur einmal nötig, während das Aktivieren beim Start jeder neuen Session erfolgen muss.

Das Prinzip vom Installieren und Laden von Paketen wird [hier](/lehre/statistik-i/tests-konfidenzintervalle/) ausführlicher beschrieben. 

## Datensatz einladen

Der Datensatz, mit dem wir im Folgenden arbeiten werden, wurde Ihnen zur Verfügung gestellt und sollte im Selben Ordner liegen, in dem Sie auch das Skript speichern. Um den Datensatz nun in `R` zu laden, müssen wir das _Working Directory_ unter Umständen verschieben. Wie wir im letzten Skript gelernt haben, handelt es sich bei dem _Working Directory_ um den Ordner, in dem `R` in unserem lokalen System nach Dateien schaut. Wir haben auch gelernt, dass man mit `setwd()` das aktuelle _Working Directory_ ändern kann. Hier ein kleiner Trick, um sich die Arbeit zu erleichtern, wenn das Skript und die benötigten Dateien im selben Ordner abgelegt sind. Es gibt einen Code-Chunk, der das _Working Directory_ automatisch auf den Ort zu setzen, wo das `R`-Skript abgespeichert ist (natürlich muss dafür das Skript auch tatsächlich abgespeichert sein). Der Code, um ebendas umzusetzen, ist etwas kompliziert und wird deshalb hier nicht genauer erklärt.  


``` r
# Working Directory auf den Ort setzen, an dem das Skript abgespeichert ist
rstudioapi::getActiveDocumentContext()$path |>
  dirname() |>
  setwd()
```


Grundsätzlich funktioniert das Einladen eines Datensatzes verschieden je nach Format, in dem der Datensatz vorliegt. Wir konzentrieren uns hier nun auf das Einlesen von einem Worksheet aus einer Excel Datei. Das Worksheet aus der Excel-Datei `Pennington_2021.xlsx`, das wir für unsere Analyse verwenden wollen, heißt `Study_Data`. In der Funktion `read_excel()` wird zuerst der Name der Datei und dann der Name des Worksheets im Argument `sheet` angegeben. 


``` r
# Aus einer Excel Datei ein Worksheet einlesen
data <- read_excel("Pennington_2021.xlsx", sheet = "Study 1 Year 7 Data")
```

Nun sollte im Environmnet ein Datensatz namens `data` vorliegen, der die Daten enthält.

Anmerkungen: Sollten Sie dieses Skript unabhängig vom Workshop lesen, gibt es die zugrundeliegenden Daten auch auf dem [OSF](https://osf.io/snqwr). Allerdings habe ich die für den Workshop ein paar Anpassungen vorgenommen, die hier [hier](//workshops/fdz/fdz_data_prep.R) beschrieben werden. Am einfachsten wäre es, diesen Befehl auszuführen, der die Daten einliest und direkt in dem von mir durchgeführten Stil anpasst.


``` r
# Daten anhand vorbereitetem Skript aus dem OSF einlesen
source("https://pandar.netlify.app/workshops/fdz/fdz_data_prep.R")
```

## Arbeit mit Datensatz

Zunächst wollen wir uns in unserem Datensatz etwas orientieren. Dazu lassen wir die Anzahl an Messungen und Variablen ausgeben `dim()`, sowie die Variablennamen `names()`. 


``` r
#### Arbeit mit Datensatz ----
##### Übersicht über den Datensatz -----
dim(data)      # Anzahl Zeilen und Spalten
```

```
## [1] 300  25
```

``` r
names(data)    # Spaltennamen
```

```
##  [1] "Year"                         "Gender"                      
##  [3] "Ethnicity"                    "Total_Mindset"               
##  [5] "Total_Competence_Maths"       "Total_Competence_English"    
##  [7] "Total_Competence_Science"     "Total_SelfEsteem"            
##  [9] "Total_SocialSelfEsteem"       "Total_AcademicSelfEfficacy"  
## [11] "Total_SelfConcept_Maths"      "Total_SelfConcept_English"   
## [13] "Total_SelfConcept_Science"    "SubjectSTEndorsement_Maths"  
## [15] "SubjectSTEndorsement_English" "SubjectSTEndorsement_Science"
## [17] "SubjectSTEndorsement_ICT"     "CareerSTEndorsement_Maths"   
## [19] "CareerSTEndorsement_English"  "CareerSTEndorsement_Science" 
## [21] "CareerSTEndorsement_ICT"      "Eng_AttainmentData"          
## [23] "Maths_AttainmentData"         "Science_AttainmentData"      
## [25] "Computing_AttainmentData"
```
Während `names()` hier die Spaltennamen ausgibt, gibt `dim()` bei einem Datensatz als ersten Eintrag die Anzahl an Zeilen und als zweiten die Anzahl an Spalten aus. Da wir hier jede:n Schüler:in hinsichtlich jeder Variable nur einmal gemesen haben, entspricht die Anzahl an Zeilen der Anzahl an Schüler:innen und die Anzahl an Spalten der Anzahl an Variablen.

Häufig benötigt man Befehle zur Datensatzreduktion häufig, um Analysen für einen bestimmten Teil der Daten durchzuführen. Die Auswahl einer einzelnen Variable funktioniert mit dem `$` Zeichen.


``` r
data$Year  # spezifische Spalte anzeigen lassen
```

```
##   [1] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
##  [11] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
##  [21] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
##  [31] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
##  [41] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
##  [51] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
##  [61] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
##  [71] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
##  [81] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
##  [91] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
## [101] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
## [111] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
## [121] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
## [131] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
## [141] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
## [151] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
## [161] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
## [171] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7"
## [181] "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year7" "Year8" "Year8" "Year8"
## [191] "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8"
## [201] "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8"
## [211] "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8"
## [221] "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8"
## [231] "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8"
## [241] "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8"
## [251] "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8"
## [261] "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8"
## [271] "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8"
## [281] "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8"
## [291] "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8" "Year8"
```

Die Variable `Year` enthält die Klassenstufen der Schüler*innen. Hierbei handelt es sich offentlich um Text, da nicht einfach nur eine Zahl sondern auch das Beiwort `Year` enthalten ist. Einzelne Daten sind in `R` jeweils in einem spezifischen Format abgelegt, das man mit `class` erfragen kann.


``` r
class(data$Year)   # Typ der Variable anzeigen lassen
```

```
## [1] "character"
```

Text wird dabei üblicherweise als `character` bezeichnet. Es gibt aber auch Variablen, die numerisch vorliegen - in R Sprache `numeric` vorliegen. Ein Beispiel hierfür wäre die Variable `Total_Competence_Maths`, die die Kompetenz in Mathematik angibt


``` r
class(data$Total_Competence_Maths)   # Typ der Variable anzeigen lassen
```

```
## [1] "numeric"
```

Weitere Datentypen lernen wir im verlauf dieses Tutorials kennen. 

Neben der Möglichkeit der Variablenselektion über das `$`-Zeichen, gibt es auch die Möglichkeit, eckige Klammern zu verwenden. Diese können in R sehr allgemein eingesetzt werden. Bei einem Datensatz können wir dabei entweder Zeilen oder Spalten Auswählen. 


``` r
data[3,]    # fünfte Zeile anzeigen lassen
```

```
## # A tibble: 1 × 25
##   Year  Gender Ethnicity     Total_Mindset Total_Competence_Maths Total_Competence_English
##   <chr>  <dbl> <chr>                 <dbl>                  <dbl>                    <dbl>
## 1 Year7      1 White British            28                      4                        4
## # ℹ 19 more variables: Total_Competence_Science <dbl>, Total_SelfEsteem <dbl>,
## #   Total_SocialSelfEsteem <dbl>, Total_AcademicSelfEfficacy <dbl>,
## #   Total_SelfConcept_Maths <dbl>, Total_SelfConcept_English <dbl>,
## #   Total_SelfConcept_Science <dbl>, SubjectSTEndorsement_Maths <dbl>,
## #   SubjectSTEndorsement_English <dbl>, SubjectSTEndorsement_Science <dbl>,
## #   SubjectSTEndorsement_ICT <dbl>, CareerSTEndorsement_Maths <dbl>,
## #   CareerSTEndorsement_English <dbl>, CareerSTEndorsement_Science <dbl>, …
```

``` r
data[,1]    # erste Spalte anzeigen lassen
```

```
## # A tibble: 300 × 1
##    Year 
##    <chr>
##  1 Year7
##  2 Year7
##  3 Year7
##  4 Year7
##  5 Year7
##  6 Year7
##  7 Year7
##  8 Year7
##  9 Year7
## 10 Year7
## # ℹ 290 more rows
```

Anstelle einer Zahl kann auch der Name der jeweiligen Zeile oder Spalte verwendet werden. Üblicherweise haben nur die Spalten in unseren Datensätzen Namen, aber diese sind uns dafür umso besser bekannt, da es die Variablennamen sind.


``` r
data[ , "Year"]    # Spalte Year anzeigen lassen
```

```
## # A tibble: 300 × 1
##    Year 
##    <chr>
##  1 Year7
##  2 Year7
##  3 Year7
##  4 Year7
##  5 Year7
##  6 Year7
##  7 Year7
##  8 Year7
##  9 Year7
## 10 Year7
## # ℹ 290 more rows
```

Auch wenn mit den eckigen Klammern eigentlich alle möglichen Datenaufbereitungsweisen möglich sind, hat sich inzwischen in der praktischen Anwendung die Nutzung von Paketen durchgesetzt. Diese bieten meist eine einfachere Syntax. Im Tutorial werden wir daher auf die Nutzung von `dplyr` zurückgreifen. Dieses muss zunächst natürlich installiert werden. 


``` r
install.packages('dplyr') # Installation des Pakets
```

Anschließend kann es aktiviert werden.


``` r
library(dplyr)   # Laden des Pakets
```

Die Auswahl einzelner Spalten funktioniert in `dplyr` mit der Funktion `select()`. In `dplyr` ist es üblich, den Datensatz immer als Startpunkt zu benutzen und dann mit Pipes zu arbeiten. Allerdings wird nicht die native Pipe aus R verwendet, sondern die Pipe aus dem Paket `magrittr`, die mit `%>%` aufgerufen wird. Dieses wird bei der Installation von `dyplyr` automatisch mitinstalliert und auch beim Aufruf aktiviert, also müssen wir uns hierum keine Gedanken machen.


``` r
data %>% select(Year)   # dplyr Funktion zur Auswahl einer Spalte (Year)
```

```
## # A tibble: 300 × 1
##    Year 
##    <chr>
##  1 Year7
##  2 Year7
##  3 Year7
##  4 Year7
##  5 Year7
##  6 Year7
##  7 Year7
##  8 Year7
##  9 Year7
## 10 Year7
## # ℹ 290 more rows
```

Die Auswahl von Zeilen funktioniert mit der Funktion `slice()`. 


``` r
data %>% slice(3)   # dplyr Funktion zur Auswahl der dritten Zeile
```

```
## # A tibble: 1 × 25
##   Year  Gender Ethnicity     Total_Mindset Total_Competence_Maths Total_Competence_English
##   <chr>  <dbl> <chr>                 <dbl>                  <dbl>                    <dbl>
## 1 Year7      1 White British            28                      4                        4
## # ℹ 19 more variables: Total_Competence_Science <dbl>, Total_SelfEsteem <dbl>,
## #   Total_SocialSelfEsteem <dbl>, Total_AcademicSelfEfficacy <dbl>,
## #   Total_SelfConcept_Maths <dbl>, Total_SelfConcept_English <dbl>,
## #   Total_SelfConcept_Science <dbl>, SubjectSTEndorsement_Maths <dbl>,
## #   SubjectSTEndorsement_English <dbl>, SubjectSTEndorsement_Science <dbl>,
## #   SubjectSTEndorsement_ICT <dbl>, CareerSTEndorsement_Maths <dbl>,
## #   CareerSTEndorsement_English <dbl>, CareerSTEndorsement_Science <dbl>, …
```

Auch im weiteren Tutorial werden wir zur Datenaufbereitung Funktionen aus `dplyr`, aber auch aus Basis-`R` nutzen. Wir wollen diese aber an spezifischen Anwendungsfelder besprechen.

## Deskriptivstatistiken

Als anwendungsnahe Beispiel für die Datenaufbereitung wollen wir Deskriptivstatistiken berechnen. 

### Faktoren am Beispiel absolute Häufigkeiten

Starten wir zunächst mit der einfachsten Deskriptivstatistik: absolute Häufigkeiten. Beispielsweise könnten wir für die Stichprobenbeschreibung die Geschlechterverteilung in unserem Datensatz betrachten. Die Funktion für die Berechnung von Häufigkeiten ist `table()`. Die zugehörige Variable in unserem Datensatz heißt `Gender`.


``` r
#### Deskriptivstatistiken ----
##### Faktoren am Beispiel absolute Häufigkeiten -----
table(data$Gender)   # Absolute Häufigkeiten
```

```
## 
##   1   2 
## 151 149
```

Wir sehen in der Ausgabe, dass es zwei Ausprägungen auf der Variable gab und eine dabei 151 Mal, die andere 149 Mal vorkam. In Zusammenarbeit mit dem Codebook können wir uns erschließen, dass die häufigere Ausprägung den Frauen zugehörig ist. Für die Erstellung von Grafiken wäre es aber natürlich gut, wenn diese Information auch in R hinterlegt wäre. Wir hätten natürlich die Möglichkeit, es in eine Varaible des Typen `character` umzuwandeln, die wir bereits kennengelernt haben. Üblicher wäre in der Praxis aber die Umwandlung in eine Faktor-Variable. Hierfür können wir die alte Variable im Datensatz mit sich selbst überschreiben, indem wir den uns bekannten Zuweisungspfeil verwenden. Die Funktion `factor()` erwartet für die Umwandlung einer `numeric` in eine `factor` Variable die Variable, die umgewandelt werden soll. Außerdem müssen die aktuell existierenden numerischen Ausprägungen `levels` und die nun dazugehörigen Labels `labels` angegeben werden.


``` r
# Faktor erstellen für das Geschlecht
data$Gender <- factor(data$Gender, 
                         levels = c(1, 2),
                         labels = c("weiblich", "männlich"))
```

Wenn wir nun die Variable auf ihren Typen prüfen, wird sie als `factor` ausgewiesen. 


``` r
class(data$Gender)   # Typ der Variable anzeigen lassen
```

```
## [1] "factor"
```

Und die Übersicht über die Häufigkeiten ist jetzt auch direkt informativer.


``` r
table(data$Gender)   # Absolute Häufigkeiten für den Faktor
```

```
## 
## weiblich männlich 
##      151      149
```

Betrachten wir außerdem noch die absoluten Häufigkeiten der Klassenstufen. 


``` r
table(data$Year)   # Absolute Häufigkeiten für die Klassenstufen
```

```
## 
## Year7 Year8 
##   187   113
```

Wir sehen, dass hier die Funktion `table()` auch für eine `character` Variable funktioniert. Für einige Funktionen wird das Vorliegen einer kategorialen Variable als Faktor-Variable (und nicht `character`) allerdings vorausgesetzt, weshalb es häufig Sinn macht, die Umwandlung vorzunehmen. Die Verwandlung von `character` in `factor` ist dabei auch in der Regel einfacher als die Umwandlung von `numeric` in `factor`, da die Labels bereits vorliegen. Es kann einfach die Funktion `as.factor()` verwendet werden. 


``` r
data$Year <- as.factor(data$Year)  # Umwandlung in Faktor
class(data$Year)                   # Typ der Variable anzeigen lassen
```

```
## [1] "factor"
```

Wir haben hier die Informationen nun auf Englisch vorliegen und in einer nicht sehr leserlichen Variante (ohne Leerzeichen). Wenn wir nun konsistent sein wollen, können wir die Ausprägungen noch anpassen - also die einzelnen Stufen des Faktors umbenennen. Dies ist ein relativ häufiges Vorgehen, wenn man die Datensätze noch für die Zeichnung von Legenden in Grafiken verschönern möchte. Am einfachsten geht diese Rekodierung mit einer Funktion aus dem `forcats` Paket.


``` r
install.packages('forcats') # Installation des Pakets
```


``` r
library(forcats)            # Laden des Pakets
```

Die benötigte Funktion ist `fct_recode()`. Diese erwartet als Argumente die Variable, die umkodiert werden soll, sowie die neuen und alten Bezeichnungen. Die neuen werden dabei zuerst erwartet und mit einem `=` vom alten Wert getrennt.


``` r
# Faktorstufen umbenennen
data$Year <- fct_recode(data$Year, 
                        "7. Schuljahr" = "Year7",
                        "8. Schuljahr" = "Year8")
```

Abschließend lassen wir uns auch zu `Year` nochmal die absoluten Häufigkeiten ausgeben.


``` r
table(data$Year)    # Absolute Häufigkeiten 
```

```
## 
## 7. Schuljahr 8. Schuljahr 
##          187          113
```

### Fehlende Werte am Beispiel Mittelwert

Ein weiterer wichtiger Aspekt der Datenaufbereitung ist der Umgang mit fehlenden Werten. Zunächst einmal ist es natürlich wichtig, die Kodierung im zugrundeliegenden Datensatz zu kennen. Betrachten wir die absoluten Häufigkeiten der Variable `Total_Competence_Maths`, die die Kompetenz in Mathematik angibt, entsteht folgendes Bild. 


``` r
##### Fehlende Werte am Beispiel Mittelwert -----
table(data$Total_Competence_Maths)   # Absolute Häufigkeiten
```

```
## 
##  -9   1   2   3   4   5 
##   1   6  11  70 148  64
```

Wir sehen, dass es neben den Skalenwerten 1, 2, 3, 4 und 5 auch den Wert -9 gibt, der in dem Codebook als Repräsentant für fehlende Werte genannt wird. Es ist wichtig, dass wir uns bewusst sind, dass `R` diese Zuordnung nicht bewusst ist. Bestimmen wir bspw. das Minimum der Werte in der Variable mit der Funktion `min()`, wird -9 als Minimum ausgegeben. 


``` r
min(data$Total_Competence_Maths)     # Minimum der Variable
```

```
## [1] -9
```

Fehlende Werte werden in `R` hingegen mit `NA` kodiert. Wenn diese Kodierung noch nicht vorliegt, müssen wir diese also einführen. In `dplyr` gibt es dafür die Funktion `na_if()` die alle Werte, die einem bestimmten Wert entsprechen, in `NA` umwandelt. 


``` r
# Wert als fehlend rekodieren
data$Total_Competence_Maths <- data$Total_Competence_Maths %>% 
  na_if(-9)
```

Wenn wir jetzt wieder die absoluten Häufigkeiten betrachten, sehen wir, dass der Wert -9 nicht mehr vorkommt. 


``` r
table(data$Total_Competence_Maths)  # Absolute Häufigkeiten
```

```
## 
##   1   2   3   4   5 
##   6  11  70 148  64
```

Die Funktion `table()` ignoriert also einfach die fehlende Werte auf der Variable und gibt uns keinen Hinweis darauf. Außer wir würden die Gesamtsumme bilden gibt es hier keine Anzeichen für das Fehlen. Die Herangehensweise von Funktionen an fehlende Werte ist aber insgesamt nicht sehr konsistent. Betrachten wir beispielsweise den Mittelwert (`mean()`) der Variable, passiert folgendes:


``` r
mean(data$Total_Competence_Maths)   # Default Mittelwert bei Vorliegen fehlender Werte
```

```
## [1] NA
```

Die Funktion `mean()` unterdrückt also Berechnungen, sobald ein fehlender Wert auf der Variable vorliegt. Wenn man trotzdem ein Ergebnis unter Ausschluss der fehlenden Werte haben möchte gibt es das zusätzliche Argument `na.rm`, das man mit `TRUE` ausfüllen muss. 


``` r
mean(data$Total_Competence_Maths, na.rm = TRUE) # Mittelwert unter Ausschluss fehlender Werte
```

```
## [1] 3.846154
```

Die fehlenden Werte auf der Variable werden also für den Moment in der Bestimmung des Mittwelwerts ausgeschlossen, aber nicht dauerhaft aus dem Datensatz entfernt. Wenn wir als zusätzliche Information erhalten wollen, wie viele fehlende Werte auf der Variable vorliegen, können wir die Einträge auf der Variable mit `is.na()` überprüfen.


``` r
is.na(data$Total_Competence_Maths) # Überprüfung auf fehlende Werte
```

```
##   [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [15] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [29] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [43] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [57] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
##  [71] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [85] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [99] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [113] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [127] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [141] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [155] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [169] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [183] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [197] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [211] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [225] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [239] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [253] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [267] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [281] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [295] FALSE FALSE FALSE FALSE FALSE FALSE
```

Die Funktion `is.na()` gibt uns für jeden Eintrag auf der Variable `TRUE` zurück, wenn es sich um einen fehlenden Wert handelt, und `FALSE`, wenn es sich um einen vorhandenen Wert handelt. Die Darstellung von `TRUE` und `FALSE` haben wir dabei schon bei den logischen Überprüfungen im ersten Tutorial gesehen. Diesen Typ von Variable nennt man in R `logical`. Ein Fakt, den man sich dabei merken kann, ist, dass `TRUE` als 1 und `FALSE` als 0 kodiert wird. Wenn wir jetzt also nicht die `TRUE` Einträge selbst zählen wollen, können wir einfach die Funktion `sum()` verwenden. 


``` r
sum(is.na(data$Total_Competence_Maths)) # Anzahl fehlender Werte
```

```
## [1] 1
```
 
Wenig überraschend liegt auf dieser Variable im Datensatz ein fehlender Wert vor. Das hatten wir auch bereits bei den absoluten Häufigkeiten gesehen. 
 
### Erstellung neuer Variablen

Da wir nicht immer alle Variablen direkt im Rohdatensatz haben, ist eine übliche Aufgabe bei der Datenaufbereitung auch die Erstellung von Variablen aus den vorliegenden Informationen. Hier gibt es natürlich eine Menge von Möglichkeiten, die nicht im Tutorial komplett abgedeckt werden können. Fokussieren wollen wir uns daher auf zwei übergeordnete Vorgehen: Erstellen einer Gruppierungsvariable und Erstellen eines Skalenscores. 


``` r
#### Erstellung neuer Variablen ----
```

#### Bilden von Fragebogenscores

Fragebogenscores aus Items zu erstellen, ist eine sehr grundlegende Aufgabe. In unserem Datensatz ist das dem Erscheinen nach bereits passiert, sodass wir hier etwas kreativ werden müssen. Stellen wir uns vor, dass es für die beiden im Datensatz enthaltenen Competence Werte auch noch einen gemeinsamen Fragebogenscore, der als Mittelwert der drei Variablen abgebildet werden soll gibt. 

Die Variablen heißen `Total_Competence_Maths`, `Total_Competence_English` und `Total_Competence_Science`. Wir könnten also einfach den Mittelwert der drei Variablen bilden. Die ersten beiden Variablen haben wir bereits auf fehlende Werte überprüft und behandelt. Fehlt also noch die dritte Variable. 


``` r
##### Bilden von Fragebogenscores -----
table(data$Total_Competence_Science)    # Betrachten der absoluten Häufigkeiten
```

```
## 
##  -9   1   2   3   4   5 
##   2  14  30 105 107  42
```

``` r
# fehlende Werte -9 sind vorhanden und müssen behandelt werden
data$Total_Competence_Science <- data$Total_Competence_Science %>% 
  na_if(-9)
```

Zur Berechnung der Variablen lernen wir zunächst eine Familie an Funktionen kennen, die speziell in der Arbeit mit zweidimensionalen Objekten (Zeilen, Spalte), wie es Datensätz sind, wertvoll sind. Mit `rowSums()`, `rowMeans()`, `colSums()` und `colMeans()` können wir die Summen und Mittelwerte von Zeilen und Spalten berechnen. Bspw. könnten wir den Mittelwert aller Variablen im Datensatz mit `colMeans()` berechnen. 


``` r
colMeans(data)   # Mittelwert aller Variablen
```

```
## Error in colMeans(data): 'x' must be numeric
```

Hier entsteht allerdings ein Fehler, da nicht alle unsere Variablen `numeric` sind, also eine Mittelwert Bestimmung Sinn macht. Erst Spalte 4 ist eine `numeric` Variable und dann bis zu Spalte 25 alle. Wir haben bereits gelernt, dass wir mit den eckigen Klammern eine Spalte auwählen können. Allerdings können wir auch mehrere Spalten auswählen, indem wir die Spaltennummern in einem Vektor zusammenfassen. Jetzt wäre es sehr anstrengend alle Zahlen von 4 bis 25 einzutippen. Daher können wir uns einem Trick behelfen. Mit dem Doppelpunkt können wir R kennzeichen, dass zwischen zwei Grenzen alle ganzen Zahlen in einem Vektor repräsentiert werden.


``` r
4:25    # Vektor von 4 bis 25
```

```
##  [1]  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
```

Um jetzt also den Mittelwert aller Variablen von Spalte 4 bis 25 zu berechnen, können wir die eckigen Klammern verwenden. Wir müssen den den Vektor von 4 bis 25 nach dem Komma Schreiben, da es sich um die Spalten handelt, die wir auswählen wollen. 


``` r
colMeans(data[,4:25])    # Mittelwert aller Variablen von Spalte 4 bis 25
```

```
##                Total_Mindset       Total_Competence_Maths     Total_Competence_English 
##                    30.650000                           NA                     3.610000 
##     Total_Competence_Science             Total_SelfEsteem       Total_SocialSelfEsteem 
##                           NA                    17.406667                    28.613333 
##   Total_AcademicSelfEfficacy      Total_SelfConcept_Maths    Total_SelfConcept_English 
##                    12.060000                    13.446667                    10.416667 
##    Total_SelfConcept_Science   SubjectSTEndorsement_Maths SubjectSTEndorsement_English 
##                    12.893333                     5.070000                     4.400000 
## SubjectSTEndorsement_Science     SubjectSTEndorsement_ICT    CareerSTEndorsement_Maths 
##                     5.293333                     5.643333                     5.536667 
##  CareerSTEndorsement_English  CareerSTEndorsement_Science      CareerSTEndorsement_ICT 
##                     4.313333                     5.396667                     5.773333 
##           Eng_AttainmentData         Maths_AttainmentData       Science_AttainmentData 
##                     8.136667                     7.300000                     7.886667 
##     Computing_AttainmentData 
##                     6.010000
```

Beachten Sie auch hier, dass einige Mittelwerte als `NA` ausgegeben werden, da im Datensatz fehlende Werte vorliegen. Nun wollen wir aber die Mittelwerte über zwei Items hinweg für alle Personen bilden - das bedeutet stattdessen brauchen wir die Mittelwerte über die Zeilen. Hierfür können wir die Funktion `rowMeans()` verwenden. Anstatt von Zahlen zur Auswahl der Spalten, können wir auch die Spaltennamen verwenden. Dies ist hier eventuell einfacher, da uns die Spaltennummern nicht immer bekannt sind, aber die Namen der Variablen wahrscheinlich schon.


``` r
# Mittelwerte aller Zeilen für drei Variablen
rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")])
```

```
##   [1] 2.666667 3.000000 4.000000 4.000000 2.666667 4.333333 3.333333 4.000000 3.333333
##  [10] 4.666667 4.333333 3.666667 3.333333 3.666667 2.333333 4.000000 5.000000 4.333333
##  [19] 4.333333 3.666667 3.333333 4.000000 3.333333 3.000000 4.000000 3.333333 4.333333
##  [28] 4.000000 3.333333 3.333333 3.666667 3.666667 2.666667 4.666667 3.333333 3.000000
##  [37] 2.666667 2.666667 1.666667 4.333333 2.666667 4.000000 3.333333 3.333333 4.000000
##  [46] 4.000000 4.666667 3.333333 3.666667 3.666667 3.666667 4.666667 4.333333 4.000000
##  [55] 3.000000 3.333333 3.666667 3.333333 3.333333 3.000000 4.000000 3.666667 3.666667
##  [64] 3.666667 4.000000 2.666667 4.333333 3.666667 1.000000       NA 5.000000 3.333333
##  [73] 3.333333 3.666667 3.333333 3.666667 3.666667 4.000000 3.333333 3.666667 2.666667
##  [82] 2.000000 3.666667 2.666667 4.333333 3.666667 3.666667 3.333333 3.000000 3.666667
##  [91] 3.666667 3.000000 3.333333 4.333333 2.333333 3.333333 3.000000 3.333333 4.000000
## [100] 3.666667 4.333333 3.333333 4.333333 2.666667 4.333333 3.666667 3.333333 3.333333
## [109] 3.000000 4.333333 3.666667 5.000000 3.000000 3.333333 4.000000 4.000000 3.333333
## [118] 4.000000 3.666667 3.666667 3.333333 3.000000 3.000000 4.333333 3.666667 4.333333
## [127] 4.000000 3.333333       NA 4.666667 3.666667 4.666667 2.333333 4.000000 3.666667
## [136] 2.333333 3.666667 3.333333 4.333333 3.000000 4.333333 4.000000 4.000000 4.333333
## [145] 4.000000 3.333333 3.000000 3.666667 4.333333 3.666667 3.666667 2.333333 4.333333
## [154] 3.333333 4.000000 4.333333 3.666667 3.000000 5.000000 3.333333 1.000000 4.333333
## [163] 3.000000 3.666667 3.333333 3.666667 3.333333 2.666667 2.000000 3.666667 3.666667
## [172] 3.333333 3.000000 4.000000 3.666667 3.666667 4.666667 3.666667 3.333333 4.666667
## [181] 4.000000 2.666667 3.666667 3.333333 1.333333 4.000000 2.333333 3.000000 3.666667
## [190] 4.333333 4.333333 3.000000 3.000000 4.000000 4.000000 4.000000 3.333333 2.333333
## [199] 2.333333 4.333333 4.666667 3.666667 3.666667 4.666667 4.666667 3.000000 4.000000
## [208] 4.000000 3.666667 4.000000 3.333333 3.666667 3.666667 4.333333 5.000000 5.000000
## [217] 3.666667 4.000000 4.000000 4.333333 2.666667 3.000000 3.333333 4.000000 3.666667
## [226] 4.000000 3.666667 3.666667 3.333333 3.666667 4.333333 4.000000 4.666667 4.000000
## [235] 3.333333 3.333333 3.666667 4.333333 3.666667 4.666667 3.666667 3.000000 3.000000
## [244] 4.000000 3.000000 4.333333 3.666667 3.666667 3.666667 4.000000 4.333333 4.000000
## [253] 4.666667 3.333333 3.333333 3.333333 4.333333 3.333333 4.000000 3.333333 4.666667
## [262] 4.666667 4.000000 3.666667 4.000000 3.666667 3.000000 3.000000 4.000000 3.333333
## [271] 4.333333 4.666667 3.666667 3.666667 4.000000 4.333333 4.333333 4.000000 4.000000
## [280] 4.000000 3.333333 3.666667 3.666667 3.666667 3.666667 4.666667 3.333333 5.000000
## [289] 3.666667 4.666667 4.000000 3.333333 3.666667 3.333333 4.666667 4.666667 4.000000
## [298] 3.333333 3.666667 4.333333
```

Um aus diesem Wissen jetzt neue Variablen zu erstellen, gibt es sehr viele Möglichkeiten. Um unseren Fokus in der Datenaufbereitung weiter auf `dplyr` zu halten, können wir mit `mutate()` eine neue Variable erstellen. Wir sagen in der Funktion den Namen der neuen Variable `Total_Competence` und nach dem `=` die Art und Weise der Berechnung. Hier fügen wir einfach den eben berechneten Mittelwert hinzu. 


``` r
# Skalenmittelwert mit dplyr erstellen
data <- data %>%
  mutate(Total_Competence = rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")]))
```

Nun haben wir eine neue Variable im Datensatz, die den Mittelwert der drei Kompetenzvariablen enthält.


``` r
data$Total_Competence   # Anzeigen der neuen Variable
```

```
##   [1] 2.666667 3.000000 4.000000 4.000000 2.666667 4.333333 3.333333 4.000000 3.333333
##  [10] 4.666667 4.333333 3.666667 3.333333 3.666667 2.333333 4.000000 5.000000 4.333333
##  [19] 4.333333 3.666667 3.333333 4.000000 3.333333 3.000000 4.000000 3.333333 4.333333
##  [28] 4.000000 3.333333 3.333333 3.666667 3.666667 2.666667 4.666667 3.333333 3.000000
##  [37] 2.666667 2.666667 1.666667 4.333333 2.666667 4.000000 3.333333 3.333333 4.000000
##  [46] 4.000000 4.666667 3.333333 3.666667 3.666667 3.666667 4.666667 4.333333 4.000000
##  [55] 3.000000 3.333333 3.666667 3.333333 3.333333 3.000000 4.000000 3.666667 3.666667
##  [64] 3.666667 4.000000 2.666667 4.333333 3.666667 1.000000       NA 5.000000 3.333333
##  [73] 3.333333 3.666667 3.333333 3.666667 3.666667 4.000000 3.333333 3.666667 2.666667
##  [82] 2.000000 3.666667 2.666667 4.333333 3.666667 3.666667 3.333333 3.000000 3.666667
##  [91] 3.666667 3.000000 3.333333 4.333333 2.333333 3.333333 3.000000 3.333333 4.000000
## [100] 3.666667 4.333333 3.333333 4.333333 2.666667 4.333333 3.666667 3.333333 3.333333
## [109] 3.000000 4.333333 3.666667 5.000000 3.000000 3.333333 4.000000 4.000000 3.333333
## [118] 4.000000 3.666667 3.666667 3.333333 3.000000 3.000000 4.333333 3.666667 4.333333
## [127] 4.000000 3.333333       NA 4.666667 3.666667 4.666667 2.333333 4.000000 3.666667
## [136] 2.333333 3.666667 3.333333 4.333333 3.000000 4.333333 4.000000 4.000000 4.333333
## [145] 4.000000 3.333333 3.000000 3.666667 4.333333 3.666667 3.666667 2.333333 4.333333
## [154] 3.333333 4.000000 4.333333 3.666667 3.000000 5.000000 3.333333 1.000000 4.333333
## [163] 3.000000 3.666667 3.333333 3.666667 3.333333 2.666667 2.000000 3.666667 3.666667
## [172] 3.333333 3.000000 4.000000 3.666667 3.666667 4.666667 3.666667 3.333333 4.666667
## [181] 4.000000 2.666667 3.666667 3.333333 1.333333 4.000000 2.333333 3.000000 3.666667
## [190] 4.333333 4.333333 3.000000 3.000000 4.000000 4.000000 4.000000 3.333333 2.333333
## [199] 2.333333 4.333333 4.666667 3.666667 3.666667 4.666667 4.666667 3.000000 4.000000
## [208] 4.000000 3.666667 4.000000 3.333333 3.666667 3.666667 4.333333 5.000000 5.000000
## [217] 3.666667 4.000000 4.000000 4.333333 2.666667 3.000000 3.333333 4.000000 3.666667
## [226] 4.000000 3.666667 3.666667 3.333333 3.666667 4.333333 4.000000 4.666667 4.000000
## [235] 3.333333 3.333333 3.666667 4.333333 3.666667 4.666667 3.666667 3.000000 3.000000
## [244] 4.000000 3.000000 4.333333 3.666667 3.666667 3.666667 4.000000 4.333333 4.000000
## [253] 4.666667 3.333333 3.333333 3.333333 4.333333 3.333333 4.000000 3.333333 4.666667
## [262] 4.666667 4.000000 3.666667 4.000000 3.666667 3.000000 3.000000 4.000000 3.333333
## [271] 4.333333 4.666667 3.666667 3.666667 4.000000 4.333333 4.333333 4.000000 4.000000
## [280] 4.000000 3.333333 3.666667 3.666667 3.666667 3.666667 4.666667 3.333333 5.000000
## [289] 3.666667 4.666667 4.000000 3.333333 3.666667 3.333333 4.666667 4.666667 4.000000
## [298] 3.333333 3.666667 4.333333
```

#### Bilden einer neuen kategorialen Variable

Anstelle des gesamten Fragebogenscores ist es nun so, dass Kinder, die auf allen vorliegenden Kompetenzskalen einen Wert von 4 oder höher haben, als High Achiever gelten sollen. Alle Kinder mit Werten von 1 sollen als Low Achiever gelten. Alle anderen Kinder sollen als Medium Achiever gelten. 

Mit `dplyr` können wir wieder mit der Funktion `mutate()` arbeiten. Allerdings ist es diesmal ja nicht eine einfache Berechnung wie beim Fragebogenscore, sondern eine bedingte Zuteilung. Hierfür gibt es in `dplyr` die Funktion `case_when()`. Diese erwartet eine Reihe von Bedingungen, die nacheinander abgearbeitet werden. Die Bedingungen werden mit `~` von den Ergebnissen getrennt. Die hier aufgeführten Bedingungsabfragen basieren auf den logischen Abfragen, die wir bereits kennen gelernt haben.


``` r
##### Bilden einer neuen kategorialen Variable -----

# Neue Variable erstellen
data <- data %>%
  mutate(Achiever = case_when(
    Total_Competence_Maths >= 4 & 
    Total_Competence_English >= 4 & 
    Total_Competence_Science >= 4 ~ "High Achiever",
    
    Total_Competence_Maths == 1 & 
    Total_Competence_English == 1 & 
    Total_Competence_Science == 1 ~ "Low Achiever",
    
    TRUE ~ "Medium Achiever"  # Alle anderen Fälle
  ))
```

Betrachten wir die Häufigkeiten der neuen Variable, sehen wir, dass korrekt drei Kategorien erstellt wurden.


``` r
table(data$Achiever)   # Absolute Häufigkeiten der neuen Variable
```

```
## 
##   High Achiever    Low Achiever Medium Achiever 
##              90               2             208
```


### Mehrfache Durchführung von Operationen

Das Ersetzen der fehlenden Werte haben wir jeweils einzeln für Variablen durchgeführt. Wenn wir das für mehrere Variablen durchführen wollen, können das wie in jeder Programmiersprache mit einem `for` Loop lösen. Empfohlen wird für `R` allerdings die Verwendung der `apply`-Funktionen oder, wenn man mit `dplyr` arbeitet, die Verwendung der bekannten `mutate()` Funktion in Kombination mit `across()`. In `across()` können wir als ersetes Argument die Variablen auswählen, auf die die Funktion angewendet werden soll. Als zweites Argument muss die Funktion aufgeführt werden, die überall durchgeführt werden soll - in diesem Fall also `na_if()`. `.x` repräsentiert dabei die Variable auf die die Funktion angewendet wird. Wenn wir alle Variablen betrachten wollen, können wir in `dplyr` die Funktion `everything()` verwenden. 


``` r
#### Mehrfache Durchführung von Operationen ----
# Ersetzen von -9 durch NA
data <- data %>%
  mutate(across(everything(), ~ na_if(.x, -9)))
```

```
## Error in `mutate()`:
## ℹ In argument: `across(everything(), ~na_if(.x, -9))`.
## Caused by error in `across()`:
## ! Can't compute column `Year`.
## Caused by error in `na_if()`:
## ! Can't convert `y` <double> to match type of `x` <factor<6de5f>>.
```

Hier kommt leider zunächst einmal eine Fehlermeldung. Das liegt daran, dass unser `na_if` Eintrag von -9 numerische Variablen erwartet. Wir müssen also spezifischer sein und die Variablen auswählen, die numerisch sind. Statt `everything()` können wir auch `where()` verwenden. Diese Funktion kann kann genauer bestimmen, welche Spalten verwendet werden sollen. Wir wollen alle numerischen Variablen - anstatt diese per Hand zu suchen, können wir die Funktion `is.numeric()` verwenden. Diese gibt für eine Variable `TRUE` zurück, wenn es sich um eine numerische Variable handelt und `FALSE`, wenn es sich um eine kategoriale Variable handelt. Beispiel:


``` r
class(data$Year)   # Check des Typen von Year
```

```
## [1] "factor"
```

``` r
is.numeric(data$Year)   # Überprüfung auf numerische Variable - nicht numerisch
```

```
## [1] FALSE
```

``` r
class(data$Total_Competence_Maths)   # Check des Typen von Total_Competence_Maths
```

```
## [1] "numeric"
```

``` r
is.numeric(data$Total_Competence_Maths)   # Überprüfung auf numerische Variable - numerisch
```

```
## [1] TRUE
```

Wir können also die `where()` Funktion in Kombination mit `is.numeric()` verwenden, um alle numerischen Variablen auszuwählen. 


``` r
# Ersetzen von -9 durch NA auf numerischen Variablen
data <- data %>%
  mutate(across(where(is.numeric), ~ na_if(.x, -9)))
```

Nun sind alle fehlenden Werte auf den numerischen Variablen ersetzt.

### Erstellen Gruppierter Deskriptivstatistiken

Bisher haben wir den Mittelwert nur auf einer Variable über die gesamte Stichprobe hinweg bestimmt. Allerdings benötigen wir auch oft deskriptive Informationen für einzelne Gruppen. Stellen wir uns also vor, wir wollen die Höhe des allgemeinen Selbstwertgefühls getrennt für unsere drei Achiever-Gruppen betrachten. 

In `dplyr` gibt es dafür die Funktion `group_by()`. Diese erwartet als Argument die Variable, nach der gruppiert werden soll.  


``` r
#### Erstellen Gruppierter Deskriptivstatistiken ----
# Gruppierung nach Achiever
data %>%
  group_by(Achiever) 
```

```
## # A tibble: 300 × 27
## # Groups:   Achiever [3]
##    Year        Gender Ethnicity Total_Mindset Total_Competence_Maths Total_Competence_Eng…¹
##    <fct>       <fct>  <chr>             <dbl>                  <dbl>                  <dbl>
##  1 7. Schulja… weibl… White Br…            36                      4                      3
##  2 7. Schulja… weibl… White Br…            34                      2                      4
##  3 7. Schulja… weibl… White Br…            28                      4                      4
##  4 7. Schulja… weibl… White Br…            38                      4                      4
##  5 7. Schulja… weibl… White Br…            26                      3                      3
##  6 7. Schulja… weibl… White Br…            29                      4                      4
##  7 7. Schulja… weibl… White Br…            32                      3                      4
##  8 7. Schulja… weibl… White Br…            31                      4                      3
##  9 7. Schulja… weibl… White Br…            28                      3                      5
## 10 7. Schulja… weibl… White Br…            30                      5                      4
## # ℹ 290 more rows
## # ℹ abbreviated name: ¹​Total_Competence_English
## # ℹ 21 more variables: Total_Competence_Science <dbl>, Total_SelfEsteem <dbl>,
## #   Total_SocialSelfEsteem <dbl>, Total_AcademicSelfEfficacy <dbl>,
## #   Total_SelfConcept_Maths <dbl>, Total_SelfConcept_English <dbl>,
## #   Total_SelfConcept_Science <dbl>, SubjectSTEndorsement_Maths <dbl>,
## #   SubjectSTEndorsement_English <dbl>, SubjectSTEndorsement_Science <dbl>, …
```

Das alleine tut aber noch nicht so viel. In Kombination mit `summarise()` die gewünschten Deskriptivstatistiken berechnen.

``` r
# Gruppierung nach Achiever und Berechnung des Mittelwerts
data %>%
  group_by(Achiever) %>%
  summarise(mean(Total_SelfEsteem))
```

```
## # A tibble: 3 × 2
##   Achiever        `mean(Total_SelfEsteem)`
##   <chr>                              <dbl>
## 1 High Achiever                         NA
## 2 Low Achiever                          NA
## 3 Medium Achiever                       NA
```

Wenn man die Variable noch schön benennen möchte kann man das in der `summarise()` Funktion machen. 


``` r
# Gruppierung nach Achiever und Berechnung des Mittelwerts samt Benennung
data %>%
  group_by(Achiever) %>%
  summarise(Mean_SelfEsteem = mean(Total_SelfEsteem))
```

```
## # A tibble: 3 × 2
##   Achiever        Mean_SelfEsteem
##   <chr>                     <dbl>
## 1 High Achiever                NA
## 2 Low Achiever                 NA
## 3 Medium Achiever              NA
```

## Fazit

In diesem Tutorial haben wir zunächst die Logik von Paketen in `R` kennengelernt und uns dann stark auf die Datenaufbereitung mittels des `dplyr` Pakets konzentriert. Die Verwendungen waren dabei an der Berechnung von Deskriptivstatistiken orientiert. Im [nächsten Tutorial](/workshops/fdz/fdz-plots-lm) gehen wir auf die Erstellung von Basisgrafiken ein und lernen außerdem die Syntax für die Durchführung von Regressionsanalysen kennen. 

