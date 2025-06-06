---
title: Funktionen und Loops - Lösungen
type: post
date: '2025-04-26'
slug: loops-funktionen-loesungen
categories: Statistik II Übungen
tags: []
subtitle: ''
summary: ''
authors: vonwissel
weight: 1
lastmod: '2025-05-13'
featured: no
banner:
  image: /header/sprinkled_lollipops.jpg
  caption: '[Courtesy of pxhere](https://pxhere.com/en/photo/1457161)'
projects: []
reading_time: no
share: no
links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-ii/loops-funktionen
- icon_pack: fas
  icon: pen-to-square
  name: Übungen
  url: /lehre/statistik-ii/loops-funktionen-uebungen
output:
  html_document:
    keep_md: yes
private: 'true'
---

## Vorbereitung

Bitte laden Sie für die folgenden Aufgaben die Übungsdatensatze *mdbf* und *fb24*:


```r
# Übungsdatensatz für Aufgabe 3
load(url("https://pandar.netlify.app/daten/mdbf.rda"))
# Übungsdatensatz für Aufgabe 4
load(url("https://pandar.netlify.app/daten/fb24.rda"))
```

## Aufgabe 1

Eigene Funktionen helfen, Arbeitsschritte effizient zusammenzufassen.
- Schreiben Sie eine eigene Funktion namens *quadriere*, die eine Zahl entgegennimmt und deren Quadrat zurückgibt.
- Testen Sie die Funktion mit den Werten 3 und 7.

<details>

<summary>Lösung</summary>

``` r
# Funktion mit dem Namen 'quadriere' erstellen
quadriere <- function(x) {
  # Variable x beinhaltet die Eingabe und wird innerhalb der Funktion zur weiteren Verarbeitung verwendet
  # Die Variable kann beliebig benannt werden (wie in den weiteren Lösungen zu sehen)
  # return() definiert die Ausgabe der Funktion
  return(x^2) 
}

# Funktion testen
quadriere(3)
quadriere(7)
```

</details>

## Aufgabe 2

Mit *if*-Abfragen kann die Ausführung von Code gesteuert werden.
- Schreiben Sie eine Funktion *alterstest*, die ein Alter als Eingabe erhält und zurückgibt:
  - „Volljährig“, wenn das Alter mindestens 18 ist,
  - „Minderjährig“, wenn das Alter darunter liegt.
- Testen Sie Ihre Funktion mit den Werten 16 und 22.

<details>

<summary>Lösung</summary>

``` r
# Funktion mit dem Namen 'alterstest' erstellen
alterstest <- function(alter) {
  if (alter >= 18) {
    return("Volljährig")    # Falls Alter >= 18 Ausgabe "Volljährig"
  } else {
    return("Minderjährig")  # Falls Alter < 18 Ausgabe "Minderjährig"
  }
}

# Funktion testen mit Beispielen
alterstest(16)
alterstest(22)
```

</details>

## Aufgabe 3

Ziel dieser Aufgabe ist es, alle **negativ** gepolten Items im mdbf-Datensatz in eine positive Richtung umzucodieren.
Folgende Items sind negativ gepoolt: `"stim3", "stim4", "stim5", "stim7", "stim9", "stim11"`

- Erstellen Sie zunächst eine Kopie des Datensatzes *mdbf* (z. B. *mdbf_r*).
- Speichern Sie alle negativ gepolten Variablen in einem Vektor neg.
- Rekodieren Sie die Items mit einem for-Loop, indem Sie die Werte wie folgt umdrehen: `-1 * (x - 5)` 
- Überprüfen Sie den Erfolg der Rekodierung durch die Berechnung der Korrelation vor und nach der Umkodierung für *stim3*.
  - Hinweis: Die Korrelation sollte -1 betragen

<details>

<summary>Lösung</summary>

``` r
# Kopie des Datensatzes erstellen
mdbf_r <- mdbf

# Namen Negative Items in Vektor speichern
neg <- c("stim3", "stim4", "stim5", "stim7", "stim9", "stim11")

# for-Schleife über alle negativen Items zur Rekodierung. Endet nach dem letzten Element des Vektors 'neg'
for (i in neg) {
  # i ist ein Platzhalter, der in jedem Schleifendurchlauf ein Element im Vektor 'neg' annimmt
  # z. B. i = "stim3" im ersten Durchlauf, dann "stim4", usw.
  
  # Aus mdbf_r[, i] wird folglrich mdbf_r[,"stim3"] im ersten Durchlauf
  # so wird die entsprechende Spalte im Datensatz dynamisch ausgewählt
  
  mdbf_r[, i] <- -1 * (mdbf[, i] - 5) # Umkodierung ins Positive: 1 wird zu 4, 2 zu 3, 3 zu 2, 4 zu 1
}

# Überprüfung der Umkodierung am Beispiel stim3
# Die Korrelation sollte -1 betragen, da die Umkodierung eine Spiegelung ist
cor(mdbf$stim3, mdbf_r$stim3)
```

</details>

## Aufgabe 4

Im zugehörigen Kapitel haben wir die Funktion *var_eigen* zur Ausgabe der Varianz und Stichprobengröße erstellt:


```r
var_eigen <- function(x, empirical = TRUE){
  n <- length(x)
  x_quer <- mean(x)
  if (empirical == TRUE) {
    var <- sum((x - x_quer)^2) / n
  } else {
    var <- sum((x - x_quer)^2) / (n - 1)
  }
  return(list(Varianz = var, Stichprobengroesse = n))
}
```

Nach Anwendung der Funktion auf alle numerischen Variablen im Datensatz *fb24*, haben wir festgestellt, dass die Berechnung für einige der Variablen fehltschlägt, da diese NAs beinhalten. Folgende *for*-Schleife haben wir dazu genutzt:


```r
for (i in names(fb24)) {
  print(i)
  if (is.character(fb24[, i])) {
    print("Eine character Variable.")
  } else {
    print(var_eigen(x = fb24[, i], empirical = TRUE))
  }
}
```

Erweitern Sie nun die Funktion *var_eigen* um ein logisches Argument *na.rm*.
Wird `na.rm = TRUE` gesetzt, sollen fehlende Werte aus der Berechnung ausgeschlossen werden.
- Achten Sie darauf, dass die Berechnung von *n* auf der bereinigten Stichprobe basiert.
- Testen Sie die neue Funktion sowohl mit als auch ohne `na.rm = TRUE`.
- Wenden Sie sie anschließend mit `na.rm = TRUE` auf alle **numerischen** Variablen in *fb24* an.

<details>

<summary>Lösung</summary>

``` r
# Funktion zur Varianzberechnung inkl. Option zur NA-Behandlung
var_eigen <- function(x, empirical = TRUE, na.rm = FALSE) {
  if (na.rm == TRUE) {
    x <- x[!is.na(x)]  # NAs entfernen, wenn na.rm = TRUE
  }
  n <- length(x)       # Stichprobengröße
  if (n == 0) return(list(Varianz = NA, Stichprobengroesse = 0))  # Leerer Vektor
  
  x_quer <- mean(x)    # Mittelwert berechnen
  
  # Varianzberechnung je nach Definition
  if (empirical == TRUE) {
    var <- sum((x - x_quer)^2) / n
  } else {
    var <- sum((x - x_quer)^2) / (n - 1)
  }
  
  return(list(Varianz = var, Stichprobengroesse = n))
}

# Anwendung der Funktion var_eigen() auf alle numerischen Variablen im fb24 Datensatz
for (i in names(fb24)) {
  print(i)                        # Ausgabe des Namen der Variable (Spaltenname im Datensatz)
  if (is.character(fb24[, i])) {  # Ausschluss für Variablen vom Typ character
    print("Eine character Variable.")
  } else {
    print(var_eigen(fb24[[i]], empirical = TRUE, na.rm = TRUE))  # Aufruf mit neuem na.rm Argument
  }
}
```

</details>
