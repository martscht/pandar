---
title: Wiederholung von Grundlagen in R - Lösungen
type: post
date: '2025-04-14'
slug: einleitung-statistik-ii-loesungen
categories: Statistik II Übungen
tags: []
subtitle: ''
summary: ''
authors: vonwissel
weight: 1
lastmod: '2025-05-13'
featured: no
banner:
  image: /header/cat_with_glasses.jpg
  caption: '[Courtesy of pxhere](https://pxhere.com/en/photo/846937)'
projects: []
reading_time: no
share: no
links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-ii/einleitung-statistik-ii
- icon_pack: fas
  icon: pen-to-square
  name: Übungen
  url: /lehre/statistik-ii/einleitung-statistik-ii-uebungen
output:
  html_document:
    keep_md: yes
private: 'true'
---



## Aufgabe 1

Aktualisieren Sie alle R Pakete auf die neueste Version. Installieren Sie das Paket `car` (falls noch nicht geschehen) und laden Sie dieses Paket anschließend. Optional: Geben Sie danach aus, welche Version des Pakets aktuell installiert ist.

<details>

<summary>Lösung</summary>


```r
# Pakete aktualisieren
update.packages(ask = FALSE)

# Paket car installieren (ausführen falls noch nicht installiert)
install.packages("car")

# Alternativ: Automatisiert überprüfen, ob das Paket installiert ist
# if (!requireNamespace("car", quietly = TRUE)) {
#  install.packages("car")
# }

# Paket car laden
library(car)

# Version des Pakets ausgeben
packageVersion("car")
```

</details>

## Aufgabe 2

Erstellen Sie in R einen numerischen Vektor mit den Zahlen 3, 7, 12, 15 und einen logischen Vektor mit den Werten TRUE, FALSE, TRUE, TRUE. Kombinieren Sie beide Vektoren anschließend in einem Datensatz (`data.frame`) und geben Sie die Struktur (`str()`) des Datensatzes aus.

<details>

<summary>Lösung</summary>


```r
# Numerischer Vektor
zahlen <- c(3, 7, 12, 15)

# Logischer Vektor
logik <- c(TRUE, FALSE, TRUE, TRUE)

# Kombination in einem data.frame
daten <- data.frame(zahlen, logik)

# Struktur des Datensatzes ausgeben
str(daten)
```

```
## 'data.frame':	4 obs. of  2 variables:
##  $ zahlen: num  3 7 12 15
##  $ logik : logi  TRUE FALSE TRUE TRUE
```

</details>

## Aufgabe 3

Erstellen Sie einen kleinen Datensatz (`data.frame`) mit den Variablen Alter (numerisch) und Geschlecht (faktorisiert mit den Ausprägungen „männlich“ und „weiblich“). Der Datensatz soll fünf Beobachtungen enthalten. Filtern Sie anschließend die Beobachtungen, sodass nur Personen älter als 25 Jahre übrig bleiben. Geben Sie die Anzahl der verbleibenden Beobachtungen aus.

<details>

<summary>Lösung</summary>


```r
# Datensatz erstellen
alter <- c(22, 30, 27, 19, 34)

geschlecht <- factor(c(1, 2, 2, 1, 2), 
                     labels = c("männlich", "weiblich"))

df <- data.frame(alter, geschlecht)

# Filtern nach Alter > 25
gefiltert <- df[df$alter > 25, ]

# Anzahl der verbleibenden Beobachtungen ausgeben
nrow(gefiltert)
```

```
## [1] 3
```

</details>
