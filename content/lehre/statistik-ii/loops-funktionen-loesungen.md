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

Schleifen (Loops) ermöglichen es, Code mehrfach auszuführen.
- Erstellen Sie eine *for*-Schleife, die die Zahlen 1 bis 5 nacheinander ausgibt.
- Passen Sie die Schleife anschließend so an, dass das Quadrat jeder Zahl ausgegeben wird. Nutzen Sie die Funktion *quadriere* aus Aufgabe 1.

<details>

<summary>Lösung</summary>

``` r
# Zahlen 1 bis 5 ausgeben
for (i in 1:5) {
  print(i)
}

# Quadrierte Zahlen 1 bis 5 ausgeben
for (i in 1:5) {
  print(quadriere(i))
}
```

</details>

## Aufgabe 4

Kombination von Funktion und Schleife.
- Schreiben Sie eine Funktion *summiere_vektor*, die die Summe aller Elemente eines numerischen Vektors berechnet, ohne die eingebaute Funktion *sum()* zu verwenden.
- Nutzen Sie eine Schleife innerhalb der Funktion.
- Testen Sie Ihre Funktion an einem Vektor Ihrer Wahl.

<details>

<summary>Lösung</summary>

``` r
# Funktion erstellen
summiere_vektor <- function(vec) {
  summe <- 0
  for (i in vec) {
    summe <- summe + i
  }
  return(summe)
}

# Funktion testen
summiere_vektor(c(2, 4, 6, 8))
summiere_vektor(1:5)
```

</details>
