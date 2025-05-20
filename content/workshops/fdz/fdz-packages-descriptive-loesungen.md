---
title: Nutzung von Paketen und Bestimmung Deskriptivstatistiken - Lösungen
type: post
date: '2025-02-28'
slug: fdz-packages-descriptive-loesungen
categories: []
tags: []
subtitle: ''
summary: ''
authors: nehler
lastmod: '2025-05-13'
featured: no
banner:
  image: /header/metal_beams_electricity.jpg
  caption: '[Courtesy of pxhere](https://pxhere.com/en/photo/1217289)'
projects: []
expiryDate: ''
publishDate: ''
reading_time: no
share: no
links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /workshops/fdz/fdz-packages-descriptive
- icon_pack: fas
  icon: pen-to-square
  name: Aufgaben
  url: /workshops/fdz/fdz-packages-descriptive-aufgaben
_build:
  list: never
output:
  html_document:
    keep_md: yes
private: 'true'
---







Denken Sie bei allen Aufgaben daran, den Code im R-Skript sinnvoll zu gliedern und zu kommentieren.

## Teil 1

Falls Sie am Workshop teilnehmen, laden Sie, falls noch nicht geschehen, zunächst den Datensatz über die eben vorgestellten Befehle in Ihr Environment. Außerdem sind die nachfolgenden Befehle aus dem Tutorial noch wichtig, die Sie also durchführen sollten, wenn es noch nicht geschehen ist!


```r
# Pakete laden
library(readxl)
library(dplyr)
library(forcats)
# Pfad setzen
rstudioapi::getActiveDocumentContext()$path |>
  dirname() |>
  setwd()
# Daten einladen
data <- read_excel("Pennington_2021.xlsx", sheet = "Study 1 Year 7 Data")
# Faktoren anlegen
data$Gender <- factor(data$Gender, 
                         levels = c(1, 2),
                         labels = c("weiblich", "männlich"))
data$Year <- as.factor(data$Year)
data$Year <- fct_recode(data$Year, 
                        "7. Schuljahr" = "Year7",
                        "8. Schuljahr" = "Year8")
# fehlende Werte ersetzen
data$Total_Competence_Maths <- data$Total_Competence_Maths %>% 
  na_if(-9)
```

Falls Sie sich die Aufgaben unabhängig vom Workshop anschauen, werden folgende Schritte noch benötigt, die im Tutorial durchgeführt wurden.


```r
# Pakete laden
library(readxl)
```

```
## Warning: Paket 'readxl' wurde unter R Version 4.3.2 erstellt
```

```r
library(dplyr)
```

```
## 
## Attache Paket: 'dplyr'
```

```
## Das folgende Objekt ist maskiert 'package:car':
## 
##     recode
```

```
## Die folgenden Objekte sind maskiert von 'package:stats':
## 
##     filter, lag
```

```
## Die folgenden Objekte sind maskiert von 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(forcats)
```

```
## Warning: Paket 'forcats' wurde unter R Version 4.3.1 erstellt
```

```r
# Datensatz aus dem OSF einladen
source("https://pandar.netlify.app/workshops/fdz/fdz_data_prep.R")
```

```
## Lade nötiges Paket: httr
```

```
## Warning: Paket 'httr' wurde unter R Version 4.3.1 erstellt
```

```r
# Faktoren anlegen
data$Gender <- factor(data$Gender, 
                         levels = c(1, 2),
                         labels = c("weiblich", "männlich"))
data$Year <- as.factor(data$Year)
data$Year <- fct_recode(data$Year, 
                        "7. Schuljahr" = "Year7",
                        "8. Schuljahr" = "Year8")
# fehlende Werte ersetzen
data$Total_Competence_Maths <- data$Total_Competence_Maths %>% 
  na_if(-9)
```


1. Welchen Wert hat die 5. Person im Datensatz in der Variable `Total_Competence_English`? Lösen Sie die Aufgabe unter Verwendung der eckigen Klammern.

<details><summary>Lösung</summary>
Im Gegensatz zu dem Vorgehen im Tutorial wählen wir hier sowohl eine spezifische Zeile als auch eine spezifische Spalte aus. Wir müssen also vor und hinter dem Komma die entsprechenden Indizes angeben. Für die Spalte verwenden wir den Variablennamen, da es schneller ist, als die Spalte herauszufinden.


```r
#### Aufgaben des Tutorials zu Paketen und Deskriptivstatistiken ----
##### Teil 1 -----
###### Aufgabe 1 ------
data[5, "Total_Competence_English"] # Wert der 5. Person in der Variable Total_Competence_English
```

```
## # A tibble: 1 × 1
##   Total_Competence_English
##                      <dbl>
## 1                        3
```

</details>

2. Betrachten Sie den aktuellen Typ der Variable `Ethnicity`. Verwandeln Sie diesen über eine passende Funktion in einen Faktor. Was ist der Modalwert der Variable?

<details><summary>Lösung</summary>

Zunächst schauen wir uns die Variable einmal an.


```r
###### Aufgabe 2 ------
head(data$Ethnicity)   # Inhalt der Variable
```

```
## [1] "White British" "White British" "White British" "White British" "White British"
## [6] "White British"
```

```r
class(data$Ethnicity)  # Typ der Variable
```

```
## [1] "character"
```

Wir wissen nun, dass die Variable als `character` vorliegt. Um sie in einen Faktor umzuwandeln, nutzen wir die Funktion `factor()`.


```r
data$Ethnicity <- factor(data$Ethnicity)  # Umwandlung in Faktor
```

Nun können wir den Modalwert der Variable bestimmen. Dieser ist die Kategorie mit der häufigsten Ausprägung. Hierfür nutzen wir die Funktion `table()`.


```r
table(data$Ethnicity)  # Häufigkeiten der Kategorien
```

```
## 
## Any other Asian background Any other white background                    Chinese 
##                          1                          1                          1 
##                  Pakistani            White and Asian    White and Black African 
##                          1                          1                          2 
##              White British 
##                        293
```

Wenn wir jetzt nicht selbst nach der Kategorie suchen wollen, können wir die Funktion `which.max()` nutzen, um den Index der häufigsten Kategorie zu finden.


```r
table(data$Ethnicity) |> which.max() # Index der häufigsten Kategorie
```

```
## White British 
##             7
```

Es handelt sich dabei um die Kategorie 7 - `White British`.

</details>


3. Überprüfen Sie die Variable `Total_Competence_English` auf fehlende Werte. Wie viele fehlende Werte sind in der Variable enthalten? Kodieren Sie diese korrekt und den Median ( `median()`) der Variable.

<details><summary>Lösung</summary>

Um die Variable auf fehlende Werte zu prüfen, können wir die Anzahl der fehlenden Werte mit der Kombination aus `is.na()` und `sum()` bestimmen.


```r
###### Aufgabe 3 ------
is.na(data$Total_Competence_English) |> sum()  # Anzahl der fehlenden Werte
```

```
## [1] 0
```

Aktuell liegen hier keine fehlenden Werte vor. Allerdings haben wir auch gesehen, dass die Werte eventuell noch "falsch" als -9 kodiert sind. Betrachten wir die absoluten Häufigkeiten.


```r
table(data$Total_Competence_English)  # Häufigkeiten der Werte
```

```
## 
##  -9   1   2   3   4   5 
##   2   5  25  73 148  47
```

Hier fällt direkt wieder auf, dass -9 als Wert vorkommt. Wir können diesen Wert also ersetzen.


```r
data$Total_Competence_English <- data$Total_Competence_English %>% na_if(-9)  # Ersetzen der fehlenden Werte
```

Nun können wir den Median der Variable bestimmen. Wie beim Mittelwert muss hier das Argument `na.rm = TRUE` gesetzt werden, um fehlende Werte zu ignorieren.


```r
median(data$Total_Competence_English, na.rm = TRUE)  # Median der Variable
```

```
## [1] 4
```


</details>



4. Die Korrelation wird in R mit der Funktion `cor()` berechnet. Bestimmen Sie die Korrelation zwischen den Variablen `Total_Competence_Maths` und `Total_Competence_English`. Benutzen Sie die Hilfe für die Funktion, um das passende Argumente zum Umgang mit fehlenden Werte einzugeben.

<details><summary>Lösung</summary>

Zunächst einmal lässt sich hier festhalten, dass auch die Funktion `cor()` auf fehlende Werte dahingehend reagiert, das Ergebnis auch als `NA` auszugeben. 


```r
###### Aufgabe 4 ------
cor(data$Total_Competence_Maths, data$Total_Competence_English)  # Korrelation zwischen den Variablen
```

```
## [1] NA
```

In der Hilfe stellen wir fest, dass es hier nicht das Argument `na.rm` gibt, wie wir es von anderen Funktionen kennen. Wir können die Behandlung fehlender Werte jedoch über das Argument `use` beeinflussen. Dabei gibt es Unterschiede zwischen dem paarweisen und listenweisen Löschen von fehlenden Werten - aber bei einer Korrelation zwischen zwei Variablen macht das nichts aus.


```r
cor(data$Total_Competence_Maths, data$Total_Competence_English, use = "pairwise.complete.obs")  # Korrelation zwischen den Variablen
```

```
## [1] 0.2179307
```

</details>



5. Wie bereits geschildert führen die Autor:innen die Analyse des Datensatzes getrennt für die beiden Jahrgänge durch. Finden Sie heraus, wie man mit dem `dplyr`-Paket die Daten nach dem Merkmal `Year` filtern und einen Subdatensatz erstellen könnte, in dem nur der jüngere Jahrgang enthalten ist. Bestimmen Sie den Mittelwert der Variable `Total_Competence_Maths` in diesem Subdatensatz.

<details><summary>Lösung</summary>

In `dplyr` können wir die Funktion `filter()` nutzen, um die Daten nach bestimmten Kriterien zu filtern. Hier wollen wir die Daten nach dem Merkmal `Year` filtern. Die Anwendung benötigt die Angabe des Datensatzes und der Bedingung, die erfüllt sein muss. 


```r
###### Aufgabe 5 ------
filter(data, Year == "7. Schuljahr")  # Filtern der Daten nach dem Merkmal Year
```

```
## # A tibble: 187 × 25
##    Year   Gender Ethnicity Total_Mindset Total_Competence_Maths Total_Competence_Eng…¹
##    <fct>  <fct>  <fct>             <dbl>                  <dbl>                  <dbl>
##  1 7. Sc… weibl… White Br…            36                      4                      3
##  2 7. Sc… weibl… White Br…            34                      2                      4
##  3 7. Sc… weibl… White Br…            28                      4                      4
##  4 7. Sc… weibl… White Br…            38                      4                      4
##  5 7. Sc… weibl… White Br…            26                      3                      3
##  6 7. Sc… weibl… White Br…            29                      4                      4
##  7 7. Sc… weibl… White Br…            32                      3                      4
##  8 7. Sc… weibl… White Br…            31                      4                      3
##  9 7. Sc… weibl… White Br…            28                      3                      5
## 10 7. Sc… weibl… White Br…            30                      5                      4
## # ℹ 177 more rows
## # ℹ abbreviated name: ¹​Total_Competence_English
## # ℹ 19 more variables: Total_Competence_Science <dbl>, Total_SelfEsteem <dbl>,
## #   Total_SocialSelfEsteem <dbl>, Total_AcademicSelfEfficacy <dbl>,
## #   Total_SelfConcept_Maths <dbl>, Total_SelfConcept_English <dbl>,
## #   Total_SelfConcept_Science <dbl>, SubjectSTEndorsement_Maths <dbl>,
## #   SubjectSTEndorsement_English <dbl>, SubjectSTEndorsement_Science <dbl>, …
```

Damit ein Subdatensatz auch wirklich im Environment erscheint, müssen wir das Ergebnis der Funktion `filter()` einer neuen Variable zuweisen.


```r
data_year7 <- filter(data, Year == "7. Schuljahr")  # Filtern der Daten nach dem Merkmal Year
```

Mit diesem Subdatensatz können wir nun ganz normal arbeiten - bspw. den Mittelwert der Variable `Total_Competence_Maths` bestimmen.


```r
mean(data_year7$Total_Competence_Maths, na.rm = TRUE)  # Mittelwert der Variable Total_Competence_Maths
```

```
## [1] 3.784946
```

</details>





## Teil 2

Falls Sie am Workshop teilnehmen, laden Sie, falls noch nicht geschehen, zunächst den Datensatz über die eben vorgestellten Befehle in Ihr Environment. Außerdem sind die nachfolgenden Befehle aus dem Tutorial / den Aufgaben noch wichtig, die Sie also durchführen sollten, wenn es noch nicht geschehen ist!


```r
# Pakete laden
library(readxl)
library(dplyr)
library(forcats)
# Pfad setzen
rstudioapi::getActiveDocumentContext()$path |>
  dirname() |>
  setwd()
# Daten einladen
data <- read_excel("Pennington_2021.xlsx", sheet = "Study 1 Year 7 Data")
# Faktoren anlegen
data$Gender <- factor(data$Gender, 
                         levels = c(1, 2),
                         labels = c("weiblich", "männlich"))

data$Year <- as.factor(data$Year)
data$Year <- fct_recode(data$Year, 
                        "7. Schuljahr" = "Year7",
                        "8. Schuljahr" = "Year8")
data$Ethnicity <- as.factor(data$Ethnicity)
# Fehlende Werte ersetzen
data <- data %>%
  mutate(across(where(is.numeric), ~ na_if(.x, -9)))
# Skalenwerte berechnen
data <- data %>%
  mutate(Total_Competence = rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")]))
# Gruppierungsvariable erstellen
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

Falls Sie sich die Aufgaben unabhängig vom Workshop anschauen, werden folgende Schritte noch benötigt, die im Tutorial (und Teil 1 der Aufgaben) durchgeführt wurden.


```r
source("https://pandar.netlify.app/workshops/fdz/fdz_data_prep.R")
# Faktoren anlegen
data$Gender <- factor(data$Gender, 
                         levels = c(1, 2),
                         labels = c("weiblich", "männlich"))
data$Year <- as.factor(data$Year)
data$Year <- fct_recode(data$Year, 
                        "7. Schuljahr" = "Year7",
                        "8. Schuljahr" = "Year8")
data$Ethnicity <- as.factor(data$Ethnicity)
# Fehlende Werte ersetzen
data <- data %>%
  mutate(across(where(is.numeric), ~ na_if(.x, -9)))
# Skalenwerte berechnen
data <- data %>%
  mutate(Total_Competence = rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")]))
# Gruppierungsvariable erstellen
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




1. Erstellen Sie einen Skalenscore `Total_SelfConcept` als Mittelwert aus den Variablen `Total_SelfConcept_Maths`, `Total_SelfConcept_Science` und `Total_SelfConcept_English`. Berechnen Sie dann Mittelwert und Median der neuen Variable.

<details><summary>Lösung</summary>

Um den Skalenscore zu berechnen, können wir die Funktion `rowMeans()` nutzen. Diese berechnet den Mittelwert über die Zeilen eines Datensatzes. 


```r
##### Teil 2 -----
###### Aufgabe 1 ------
data$Total_SelfConcept <- rowMeans(data[, c("Total_SelfConcept_Maths", "Total_SelfConcept_Science", "Total_SelfConcept_English")])  # Berechnung des Skalenscores
```

Nun können wir den Mittelwert und Median der neuen Variable bestimmen. Dabei müssen wir auch hier drauf achten, fehlende Werte zu ignorieren.


```r
mean(data$Total_SelfConcept, na.rm = TRUE)  # Mittelwert der Variable
```

```
## [1] 12.71795
```

```r
median(data$Total_SelfConcept, na.rm = TRUE)  # Median der Variable
```

```
## [1] 12.66667
```
</details>

2. Finden Sie heraus, welche Person den höchsten Wert in der Variable `Total_SelfConcept` hat. Wie lautet der Wert?

<details><summary>Lösung</summary>

Um den höchsten Wert in einer Variable zu finden, können wir die Funktion `max()` nutzen. Auch hier müssen wir wieder darauf achten, fehlende Werte zu ignorieren.


```r
###### Aufgabe 2 ------
max(data$Total_SelfConcept, na.rm = TRUE)  # Höchster Wert in der Variable
```

```
## [1] 18.33333
```

Wie finden wir nun heraus, welche Person diesen Wert hat? Dafür können wir die Funktion `which.max()` nutzen, die uns den Index des höchsten Wertes zurückgibt.


```r
which.max(data$Total_SelfConcept)  # Index der Person mit dem höchsten Wert
```

```
## [1] 112
```

</details>


3. Die Forscherinnen wollen überprüfen, ob Sie für alle Jugendlichen bereits eine Karriere-Empfehlung machen können. Dafür muss auf einer (oder mehrerer) der 4 Leistungsvariablen (alle haben als Teil des Namens `AttainmentData`) ein Wert von über 10 für ein Kind vorliegen. Erstellen Sie eine neue kategoriale Variable mit dem Namen `Career_Recommendation`, die die Werte `Empfohlen` und `nicht_empfohlen` enthält. Bestimmen Sie dann den Anteil der Werte an Kindern, für die Empfehlungen gegeben werden kann.

<details><summary>Lösung</summary>

Hier muss also wie im Tutorial eine kategoriale Variable erstellt werden - aus vorliegenden numerischen Werten. Dafür können wir die Funktion `mutate()` und `case_when()` nutzen.


```r
###### Aufgabe 3 ------
data <- data %>%
  mutate(Career_Recommendation = case_when(
    Maths_AttainmentData > 10 |
    Science_AttainmentData > 10 |
    Eng_AttainmentData > 10 |
    Computing_AttainmentData > 10 ~ "Empfohlen",
    
    TRUE ~ "Nicht empfohlen"
  ))  # Erstellen der neuen Variable
```

Nun können wir den Anteil der Werte bestimmen, für die Empfehlungen gegeben werden können. Wir haben bereits gelernt, dass die absolute Häufigkeit mit `table()` bestimmt werden kann.


```r
table(data$Career_Recommendation)  # Absolute Häufigkeiten
```

```
## 
##       Empfohlen Nicht empfohlen 
##              92             208
```

Den Anteil könnten wir jetzt natürlich berechnen, indem wir die absolute Häufigkeit durch die Gesamtanzahl der Werte teilen. Allerdings gibt es auch eine Funktion, die das direkt für uns erledigt. `prop.table()` gibt uns den Anteil der Werte zurück, wenn es auf ein `table()`-Objekt angewendet wird. Wir können das direkt in einem Schritt mit der Pipe `|>` machen.


```r
table(data$Career_Recommendation) |> prop.table()  # Anteil der Werte
```

```
## 
##       Empfohlen Nicht empfohlen 
##       0.3066667       0.6933333
```

</details>
4. Untersuchen Sie deskriptiv hinsichtlich Mittelwert und Standardabweichung, ob sich das Mindset der Schülerinnen mit und ohne Karriereempfehlung unterscheidet.

<details><summary>Lösung</summary>

Zunächst einmal stellt sich die Frage, welche Variable das Mindset der Schülerinnen abbildet. Wenn wir dafür in das Codebook der Excel-Datei schauen oder auch in den Daten, sehen wir, dass es sich um die Variable `Total_Mindset` handelt. 

Das restliche Vorgehen ist eine Anpassung aus dem Tutorial. Allerdings können wir in `summarise()` anstatt einer auch mehrere Funktionen gleichzeitig nutzen. Wenn wir den Ergebnissen jeweils noch einen sprechenden Namen geben, wird die Ausgabe übersichtlicher.


```r
###### Aufgabe 4 ------
data %>%
  group_by(Career_Recommendation) %>%
  summarise(mean_mindset = mean(Total_Mindset, na.rm = TRUE),  # Mittelwert des Mindsets
            sd_mindset = sd(Total_Mindset, na.rm = TRUE))  # Standardabweichung des Mindsets
```

```
## # A tibble: 2 × 3
##   Career_Recommendation mean_mindset sd_mindset
##   <chr>                        <dbl>      <dbl>
## 1 Empfohlen                     32.5       4.13
## 2 Nicht empfohlen               31.2       4.48
```

</details>

5. In Teil 1 Aufgabe 4 haben wir bereits die Korrelation zwischen den Variablen `Total_Competence_Maths` und `Total_Competence_English` bestimmt. Dabei haben wir gesehen, dass das Argument `use` genutzt werden kann, um den Umgang mit fehlenden Werten für genau diese eine Berechnung zu steuern. In einigen Tutorials und auch in Code-Chunks, die von LLMs produziert werden, wird die Funktion `na.omit()` zum Ausschluss fehlender Werte auf dem gesamten Datensatz propagiert. Reduzieren Sie mit der Funktion den Datensatz auf einen Subdatensatz `data_red` und bestimmen Sie die Korrelation zwischen den Variablen `Total_Competence_Maths` und `Total_Competence_English` in diesem Subdatensatz. Versuchen Sie herauszufinden, wodurch die Unterschiede in den Ergebnissen zustande kommen.

<details><summary>Lösung</summary>
Zur Erinnerung nochmal das Ergebnis der Korrelation zwischen den Variablen `Total_Competence_Maths` und `Total_Competence_English` aus Teil 1 Aufgabe 4.


```r
###### Aufgabe 5 ------
cor(data$Total_Competence_Maths, data$Total_Competence_English, use = "pairwise.complete.obs")  # Korrelation zwischen den Variablen
```

```
## [1] 0.2179307
```

Nun können wir den Datensatz reduzieren. Dafür nutzen wir die Funktion `na.omit()`. Diese entfernt alle Zeilen, in denen mindestens ein fehlender Wert vorkommt.


```r
data_red <- na.omit(data)  # Reduzieren des Datensatzes
```

Die Variablennamen sind in dem Datensatz weiterhin die gleichen. Eine Behandlung fehlender Werte müssen wir in der `cor()`-Funktion nun nicht mehr angeben.


```r
cor(data_red$Total_Competence_Maths, data_red$Total_Competence_English)  # Korrelation zwischen den Variablen
```

```
## [1] 0.2047514
```

Die Erklärung für den Unterschied liegt in dem Effekt der `na.omit()`-Funktion. Diese entfernt alle Zeilen, in denen mindestens ein fehlender Wert vorkommt. Dadurch werden auch Personen ausgeschlossen, die auf Variablen fehlende Werte haben, die für die Korrelation nicht relevant sind. Das kann zu Unterschieden in den Ergebnissen führen. Unabhängig davon, dass auch paarweise und listenweiser Fallausschluss problematische Aspekte haben, ist es wichtig, dass die Funktion `na.omit()` nur in sehr spezifischen Fällen genutzt wird.

</details>
