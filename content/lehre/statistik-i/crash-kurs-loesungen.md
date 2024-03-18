---
title: "R Crash-Kurs - Lösungen" 
type: post
date: '2020-11-09' 
slug: crash-kurs-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [schultze] 
lastmod: '2024-03-18'
featured: no
banner:
  image: "/header/toy_car_crash.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1217289)"
projects: []

expiryDate: ''
publishDate: ''
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/crash-kurs
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/crash-kurs-aufgaben

_build:
  list: never
output:
  html_document:
    keep_md: true
---

## R als Taschenrechner



1. Bestimmen Sie das Ergebnis von $3 + 7 \cdot 12$

<details><summary>Lösung</summary>


```r
3 + 7 * 12
```

```
## [1] 87
```

</details>


2. Prüfen Sie mit logischen Operatoren, ob das Ergebnis aus der letzten Aufgabe dasselbe ist, wie $3 \cdot 29$

<details><summary>Lösung</summary>


```r
(3 + 7 * 12) == (3 * 29)
```

```
## [1] TRUE
```

</details>


3. Bestimmen Sie $\sqrt{115}$ und legen Sie das (ganzzahlig) gerundete Ergebnis in einem Objekt namens `zahl` ab.

<details><summary>Lösung</summary>


```r
zahl <- round(sqrt(115))
```

</details>


4. Folgende Syntax verursacht einen Fehler: `6 * 1,56`. Wodurch kommt dieser Fehler zustande?

<details><summary>Lösung</summary>


```r
6 * 1,56
```

```
## Error: <text>:1:6: unexpected ','
## 1: 6 * 1,
##          ^
```

In der Syntax wird fälschlicherweise das Komma als Dezimaltrennzeichen genutzt. Wenn man das Komma durch einen Punkt ersetzt, funktioniert die Syntax problemlos:


```r
6 * 1.56
```

```
## [1] 9.36
```

</details>


***

## Daten erstellen

In folgender Tabelle sind die fünf schnellsten Zeiten im Finale des 100m Sprint der Frauen bei den Olympischen Sommerspielen 2020 in Tokyo dargestellt:

Sprinterin | Zeit (in s)
------ | -----------
Elaine Thompson-Herah | 10.61
Shelly-Ann Fraser-Pryce | 10.74
Shericka Jackson | 10.76
Marie-Josee Ta Lou | 10.91
Ajla del Ponte | 10.97


5. Erstellen Sie einen Vektor `sprinterin` und einen Vektor `zeit`, die die jeweiligen Informationen aus der Tabelle enthalten. Prüfen Sie, welchen Typ diese beiden Vektoren haben.

<details><summary>Lösung</summary>

Erstellen der Vektoren:


```r
sprinterin <- c('Elaine Thompson-Herah', 'Shelly-Ann Fraser-Pryce', 'Shericka Jackson', 'Marie-Josee Ta Lou', 'Ajla del Ponte')
zeit <- c(10.61, 10.74, 10.76, 10.91, 10.97)
```

Prüfen der Typen:


```r
class(sprinterin)
```

```
## [1] "character"
```

```r
class(zeit)
```

```
## [1] "numeric"
```

`sprinterin` ist ein `character` weil es Text enthält; `zeit` ist numerisch.

</details>


6. Führen Sie die beiden Vektoren in einem Datensatz zusammen. Stellen Sie sicher, dass die Variable `sprinterin` nicht in einen Faktor umgewandelt wird.

<details><summary>Lösung</summary>

Per Voreinstellung wurden bis zur R-Version 4.0.0 `character` Vektoren beim Zusammenführen in `data.frame`s in den Typ `factor` umgewandelt. Sollten Sie also eine älter Version benutzen, kann es hier zu Komplikationen kommen:


```r
olymp <- data.frame(sprinterin, zeit)
str(olymp)
```

```
## 'data.frame':	5 obs. of  2 variables:
##  $ sprinterin: chr  "Elaine Thompson-Herah" "Shelly-Ann Fraser-Pryce" "Shericka Jackson" "Marie-Josee Ta Lou" ...
##  $ zeit      : num  10.6 10.7 10.8 10.9 11
```

In diesem Fall (R-Version 4.1.1) werden die Namen als `character` beibehalten. Das unterschiedliche Verhalten unterschiedlicher R-Versionen liegt daran, dass mit R-Version 4.0.0 die Voreinstellung des Arguments `stringsAsFactors` in der Funktion `data.frame()` geändert wurde. Das Argument und dessen Voreinstellung findet man mit `help(data.frame)`. Da steht im Abschnitt _Arguments_:

 | 
--- | ---------
`stringsAsFactors` | logical: should character vectors be converted to factors? The ‘factory-fresh’ default has been TRUE previously but has been changed to FALSE for R 4.0.0. |

In älteren Versionen muss dieses Argument also händisch auf `FALSE` gesetzt werden, um das gewünschte Ergebnis zu erreichen.


```r
olymp <- data.frame(sprinterin, zeit, stringsAsFactors = FALSE)
str(olymp)
```

```
## 'data.frame':	5 obs. of  2 variables:
##  $ sprinterin: chr  "Elaine Thompson-Herah" "Shelly-Ann Fraser-Pryce" "Shericka Jackson" "Marie-Josee Ta Lou" ...
##  $ zeit      : num  10.6 10.7 10.8 10.9 11
```

</details>


7. Lassen Sie sich via Elementenauswahl die Zeit von Shericka Jackson ausgeben.

<details><summary>Lösung</summary>


```r
olymp[3, 2]         # dirkete Auswahl via Position
```

```
## [1] 10.76
```

```r
olymp[3, 'zeit']    # Variablenauswahl per Name
```

```
## [1] 10.76
```

```r
olymp[olymp$sprinterin == 'Shericka Jackson', 'zeit']  # Filterauswahl
```

```
## [1] 10.76
```

</details>


8. Nehmen Sie die 6. schnellste Läuferin, Mujinha Kambundji, und ihre Zeit von  10.99 Sekunden in den Datensatz auf.

<details><summary>Lösung</summary>


```r
olymp[6, ] <- c('Muljinga Kambundji', 10.99)
olymp
```

```
##                sprinterin  zeit
## 1   Elaine Thompson-Herah 10.61
## 2 Shelly-Ann Fraser-Pryce 10.74
## 3        Shericka Jackson 10.76
## 4      Marie-Josee Ta Lou 10.91
## 5          Ajla del Ponte 10.97
## 6      Muljinga Kambundji 10.99
```

</details>


9. Fügen Sie die Nationalität der Läuferinnen als Variable zum Datensatz hinzu.

<details><summary>Lösung</summary>

Die Nationalitäten finden sich übersichtlich z.B. auf [der Wikipedia-Seite zum 100m Sprint in Tokyo](https://de.wikipedia.org/wiki/Olympische_Sommerspiele_2020/Leichtathletik_%E2%80%93_100_m_(Frauen)#Finale). 

Variante 1: Neuen Vektor erstellen und über `cbind` oder `data.frame` hinzufügen.


```r
nation <- c('Jamaika', 'Jamaika', 'Jamaika', 'Elfenbeinküste', 'Schweiz', 'Schweiz')
full <- data.frame(olymp, nation)   # via data.frame
# Alternative: via cbind
  # full <- cbind(olymp, nation)
full
```

```
##                sprinterin  zeit         nation
## 1   Elaine Thompson-Herah 10.61        Jamaika
## 2 Shelly-Ann Fraser-Pryce 10.74        Jamaika
## 3        Shericka Jackson 10.76        Jamaika
## 4      Marie-Josee Ta Lou 10.91 Elfenbeinküste
## 5          Ajla del Ponte 10.97        Schweiz
## 6      Muljinga Kambundji 10.99        Schweiz
```

Variante 2: Vektor direkt im Datensatz anlegen.


```r
olymp$nation <- c('Jamaika', 'Jamaika', 'Jamaika', 'Elfenbeinküste', 'Schweiz', 'Schweiz')
olymp
```

```
##                sprinterin  zeit         nation
## 1   Elaine Thompson-Herah 10.61        Jamaika
## 2 Shelly-Ann Fraser-Pryce 10.74        Jamaika
## 3        Shericka Jackson 10.76        Jamaika
## 4      Marie-Josee Ta Lou 10.91 Elfenbeinküste
## 5          Ajla del Ponte 10.97        Schweiz
## 6      Muljinga Kambundji 10.99        Schweiz
```


</details>


10. Bestimmen Sie die Summe der Zeiten!

<details><summary>Lösung</summary>

*Hinweis*: Die Summe des Objekts `zeit` ist hier nicht mehr angebracht, weil die 6. Sprinterin direkt dem Datensatz hinzugefügt wurde. Dadurch hat sich das Verhalten unseres Datensatzes geändert:


```r
sum(olymp$zeit)
```

```
## Error in sum(olymp$zeit): invalid 'type' (character) of argument
```

```r
str(olymp)
```

```
## 'data.frame':	6 obs. of  3 variables:
##  $ sprinterin: chr  "Elaine Thompson-Herah" "Shelly-Ann Fraser-Pryce" "Shericka Jackson" "Marie-Josee Ta Lou" ...
##  $ zeit      : chr  "10.61" "10.74" "10.76" "10.91" ...
##  $ nation    : chr  "Jamaika" "Jamaika" "Jamaika" "Elfenbeinküste" ...
```

Es entsteht ein Fehler, der besagt, dass `zeit` im Datensatz als `character` und nicht numerisch abgelegt ist. Das ist dadurch passiert, dass die Daten von Mujinga Kambundji händisch hinzufügt wurden. Es gibt zwei Möglichkeiten damit umzugehen. Die Erste ist eine ad-hoc Korrektur der Variablentypen:


```r
olymp$zeit <- as.numeric(olymp$zeit)
str(olymp)
```

```
## 'data.frame':	6 obs. of  3 variables:
##  $ sprinterin: chr  "Elaine Thompson-Herah" "Shelly-Ann Fraser-Pryce" "Shericka Jackson" "Marie-Josee Ta Lou" ...
##  $ zeit      : num  10.6 10.7 10.8 10.9 11 ...
##  $ nation    : chr  "Jamaika" "Jamaika" "Jamaika" "Elfenbeinküste" ...
```

Die Zweite ist es, das Problem bereits beim Hinzufügen von Daten zu umgehen. Dazu erstellen wir erst einmal den `olymp` Datensatz mit fünf Sprinterinnen aus den ursprünglichen Objekten erneut, um die Ausgangslage wiederherzustellen. Dann fügen wir die sechste Sprinterin eigenen, einzeiligen `data.frame` hinzu:


```r
olymp <- data.frame(sprinterin, zeit)
olymp[6, ] <- data.frame('Muljinga Kambundji', 10.99)
str(olymp)
```

```
## 'data.frame':	6 obs. of  2 variables:
##  $ sprinterin: chr  "Elaine Thompson-Herah" "Shelly-Ann Fraser-Pryce" "Shericka Jackson" "Marie-Josee Ta Lou" ...
##  $ zeit      : num  10.6 10.7 10.8 10.9 11 ...
```

In beiden Fällen kann anschließend mit `sum` gearbeitet werden:


```r
sum(olymp$zeit)
```

```
## [1] 64.98
```

</details>


***

## Datenmanagement

Die folgenden Aufgaben beziehen sich auf den Datensatz **fb23**, den Sie [<i class="fas fa-download"></i> hier als CSV finden](/daten/fb23.csv). Sofern Sie es nicht bereits getan haben, setzen Sie das Working Directory auf den Ordner, in dem Sie den Datensatz gespeichert haben und laden Sie diesen Datensatz als Objekt `fb23`.

<details><summary>Vorbereitung</summary>

Lokale Datei öffnen:


```r
setwd(...)
```

```r
fb23 <- read.table('fb23.csv', 
  header = TRUE, 
  sep = ',')
```

Online Datei öffnen:


```r
fb23 <- read.table('https://pandar.netlify.app/daten/fb23.csv', 
  header = TRUE,
  sep = ',')
```

</details>


11. Der [Variablenübersicht](/lehre/statistik-i/variablen.pdf) können Sie die Variablennamen, Variablenbedeutungen und die Kodierschemata entnehmen. Die Variable `ziel` kodiert die Arbeitsbranchen, in denen Sie und Ihre Kommilitoninnen und Kommilitonen nach dem Abschluss tätig sein wollen. Wandeln Sie diese Variable in einen Faktor um und vergeben Sie die entsprechenden Labels.

<details><summary>Lösung</summary>


```r
str(fb23$ziel)
```

```
##  int [1:179] 2 2 2 2 2 2 NA 4 2 2 ...
```

Variante 1: Umwandeln und anschließend Labels vergeben.


```r
# Umwandung von numeric in factor
fb23$ziel <- as.factor(fb23$ziel)
# Vergabe von levels
levels(fb23$ziel) <- c('Wirtschaft', 'Therapie', 'Forschung', 'Andere')
```

Variante 2: In einem Schritt umwandeln und Labels vergeben.


```r
fb23$ziel <- factor(fb23$ziel,
  labels = c('Wirtschaft', 'Therapie', 'Forschung', 'Andere'))
```


```r
str(fb23$ziel)
```

```
##  Factor w/ 4 levels "Wirtschaft","Therapie",..: 2 2 2 2 2 2 NA 4 2 2 ...
```

</details>


12. Erstellen eine Variable `uni`, die darlegt, wie viele der Uniangebote eine Teilnehmerin oder ein Teilnehmer bereits in Anspruch genommen hat (aus den Variablen `uni1` bis `uni4`).

<details><summary>Lösung</summary>

Variante 1: Taschenrechnen mit Vektoren.


```r
fb23$uni <- fb23$uni1 + fb23$uni2 + fb23$uni3 + fb23$uni4
str(fb23$uni)
```

```
##  int [1:179] 1 4 1 3 2 1 0 2 2 1 ...
```

Variante 2: Zeilen-spezifische Summen bilden.


```r
fb23$uni <- rowSums(fb23[, c('uni1', 'uni2', 'uni3', 'uni4')])
str(fb23$uni)
```

```
##  num [1:179] 1 4 1 3 2 1 0 2 2 1 ...
```

</details>


13. Nutzen Sie die `subset` Funktion um einen Datensatz zu erstellen, der nur die Personen enthält, die nach dem Abschluss in der Psychotherapie tätig sein wollen. Nennen Sie diesen `therapie`.
  + Nutzen Sie die Hilfe um herauszufinden, wie `subset` funktioniert.
  + Sie können im [auf der Seite zum Crash-Kurs](/lehre/statistik-i/crash-kurs) nachschlagen, wie logische Operationen in `R` durchgeführt werden!


<details><summary>Lösung</summary>


```r
help(subset)
```


```r
therapie <- subset(fb23,            # Voller Datensatz
  subset = fb23$ziel == 'Therapie'  # Auswahlkriterium
  )
str(therapie)
```

```
## 'data.frame':	106 obs. of  41 variables:
##  $ mdbf1_pre  : int  4 2 4 NA 3 3 3 2 3 3 ...
##  $ mdbf2_pre  : int  2 2 3 3 3 2 2 1 4 2 ...
##  $ mdbf3_pre  : int  3 4 2 2 2 3 2 2 1 1 ...
##  $ mdbf4_pre  : int  2 2 1 2 1 1 3 3 2 1 ...
##  $ mdbf5_pre  : int  3 2 3 2 2 1 2 4 1 3 ...
##  $ mdbf6_pre  : int  2 1 2 2 2 2 2 2 2 2 ...
##  $ mdbf7_pre  : int  4 3 3 1 1 2 3 3 1 3 ...
##  $ mdbf8_pre  : int  3 2 3 2 3 3 3 2 3 3 ...
##  $ mdbf9_pre  : int  2 4 1 2 3 3 2 3 1 1 ...
##  $ mdbf10_pre : int  3 2 3 3 2 4 2 2 2 3 ...
##  $ mdbf11_pre : int  3 2 1 2 2 1 2 4 1 1 ...
##  $ mdbf12_pre : int  1 1 2 3 2 2 3 2 3 3 ...
##  $ lz         : num  5.4 3.4 4.4 4.4 6.4 5.6 4.8 6 5.4 5.4 ...
##  $ extra      : num  3.5 3 4 3 4 4.5 2.5 3 4.5 4.5 ...
##  $ vertr      : num  1.5 3 3.5 4 4 4.5 3 3.5 3.5 3 ...
##  $ gewis      : num  4.5 4 5 3.5 3.5 4 3.5 4 3.5 4 ...
##  $ neuro      : num  5 5 2 4 3.5 4.5 4.5 4 3 3 ...
##  $ offen      : num  5 5 4.5 3.5 4 4 4 3 3 5 ...
##  $ prok       : num  1.8 3.1 1.5 1.6 2.7 3.3 2.4 3.1 2.7 2.6 ...
##  $ nerd       : num  4.17 3 2.33 2.83 3.83 ...
##  $ grund      : chr  "Berufsziel" "Interesse am Menschen" "Interesse und Berufsaussichten" "Wissenschaftliche Ergänzung zu meinen bisherigen Tätigkeiten (Arbeit in der psychiatrischen Akutpflege, Gestalt"| __truncated__ ...
##  $ fach       : int  4 4 4 4 4 4 4 NA 4 4 ...
##  $ ziel       : Factor w/ 4 levels "Wirtschaft","Therapie",..: 2 2 2 2 2 2 2 2 2 2 ...
##  $ wissen     : int  5 4 5 4 2 3 3 3 3 3 ...
##  $ therap     : int  5 5 5 5 4 5 5 5 5 4 ...
##  $ lerntyp    : int  3 3 1 3 3 1 3 3 1 1 ...
##  $ hand       : int  2 2 2 2 2 2 1 2 2 2 ...
##  $ job        : int  1 1 1 1 2 2 1 2 2 2 ...
##  $ ort        : int  2 1 1 1 1 2 1 2 1 1 ...
##  $ ort12      : int  2 1 2 2 2 1 2 1 2 2 ...
##  $ wohnen     : int  4 1 1 1 1 2 3 2 1 1 ...
##  $ uni1       : int  0 1 0 1 0 0 0 0 0 0 ...
##  $ uni2       : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ uni3       : int  0 1 0 0 1 0 1 0 1 1 ...
##  $ uni4       : int  0 1 0 1 0 0 0 0 0 0 ...
##  $ attent_pre : int  6 6 6 6 6 6 5 5 6 5 ...
##  $ gs_post    : num  3 2.75 4 2.5 3.75 NA 3.75 2.5 3.5 3.25 ...
##  $ wm_post    : num  2 1 3.75 2.75 3 NA 3.25 2 1.5 3 ...
##  $ ru_post    : num  2.25 1.5 3.75 3.5 3 NA 2.75 2.75 3.25 2.5 ...
##  $ attent_post: int  6 5 6 6 6 NA 5 3 6 5 ...
##  $ uni        : num  1 4 1 3 2 1 2 1 2 2 ...
```

</details>

  
14. Speichern Sie den neuen Datensatz als **therapie.rds** im RDS-Format ab.

<details><summary>Lösung</summary>


```r
saveRDS(therapie, 'therapie.rds')
```

</details>
