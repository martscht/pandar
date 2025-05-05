---
title: "Funktionen und Loops - Lösungen" 
type: post
date: '2025-04-26'
slug: loops-funktionen-loesungen
categories: ["Statistik II Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [vonwissel] 
weight: 1
lastmod: "2025-04-26"
featured: no
banner: 
  image: "/header/sprinkled_lollipops.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1457161)"
projects: []
reading_time: false
share: false

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
    keep_md: true
---

## Aufgabe 1

Eigene Funktionen helfen, Arbeitsschritte effizient zusammenzufassen.
- Schreiben Sie eine eigene Funktion namens *quadriere*, die eine Zahl entgegennimmt und deren Quadrat zurückgibt.
- Testen Sie die Funktion mit den Werten 3 und 7.

<details>

<summary>Lösung</summary>

``` r
# Funktion erstellen
quadriere <- function(x) {
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
# Funktion erstellen
alterstest <- function(alter) {
  if (alter >= 18) {
    return("Volljährig")
  } else {
    return("Minderjährig")
  }
}

# Funktion testen
alterstest(16)
alterstest(22)
```

</details>

## Aufgabe 3

### Vorbereitung

Bitte laden Sie folgenden Übungsdatensatz *mdbf*:


``` r
load(url("https://pandar.netlify.app/daten/mdbf.rda"))
```

### Aufgabe

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

# Negative Items definieren
neg <- c("stim3", "stim4", "stim5", "stim7", "stim9", "stim11")

# Umcodierung mit for-loop
for (i in neg) {
  mdbf_r[, i] <- -1 * (mdbf[, i] - 5)
}

# Prüfung der Umkodierung (z. B. für stim3)
cor(mdbf$stim3, mdbf_r$stim3)
```

</details>

## Aufgabe 4

Im zugehörigen Kapitel haben wir die Funktion *var_eigen* zur Ausgabe der Varianz und Stichprobengröße erstellt:


``` r
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


``` r
for (i in names(fb24)) {
  print(i)
  if (is.character(fb24[, i])) {
    print("Eine character Variable.")
  } else {
    print(var_eigen(x = fb24[, i], empirical = TRUE))
  }
}
```

### Vorbereitung

Bitte laden Sie folgenden Übungsdatensatz *mdbf*:


``` r
load(url("https://pandar.netlify.app/daten/fb24.rda"))
```

### Aufgabe

Erweitern Sie die Funktion *var_eigen* um ein logisches Argument *na.rm*.
Wird `na.rm = TRUE` gesetzt, sollen fehlende Werte aus der Berechnung ausgeschlossen werden.
- Achten Sie darauf, dass die Berechnung von *n* auf der bereinigten Stichprobe basiert.
- Testen Sie die neue Funktion sowohl mit als auch ohne `na.rm = TRUE`.
- Wenden Sie sie anschließend mit `na.rm = TRUE` auf alle **numerischen** Variablen in *fb24* an.

<details>

<summary>Lösung</summary>

``` r
# Erweiterte Funktion mit na.rm-Argument
var_eigen <- function(x, empirical = TRUE, na.rm = FALSE) {
  if (na.rm == TRUE) {
    x <- x[!is.na(x)]
  }
  n <- length(x)
  if (n == 0) return(list(Varianz = NA, Stichprobengroesse = 0))
  
  x_quer <- mean(x)
  
  if (empirical == TRUE) {
    var <- sum((x - x_quer)^2) / n
  } else {
    var <- sum((x - x_quer)^2) / (n - 1)
  }
  
  return(list(Varianz = var, Stichprobengroesse = n))
}

# For-Schleife für alle Variablen
for (i in names(fb24)) {
  print(i)
  if (is.character(fb24[, i])) {
    print("Eine character Variable.")
  } else {
    print(var_eigen(fb24[[i]], empirical = TRUE, na.rm = TRUE))
  }
}
```

</details>
