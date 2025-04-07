---
title: "Deskriptivstatistik für Intervallskalen - Übungen" 
type: post
date: '2019-10-18' 
slug: deskriptiv-intervall-uebungen
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [nehler, buchholz, zacharias, pommeranz]
weight:
lastmod: '2025-04-07'
featured: no
banner:
  image: "/header/frogs_on_phones.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1227907)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/deskriptiv-intervall
  - icon_pack: fas
    icon: star
    name: Lösungen
    url: /lehre/statistik-i/deskriptiv-intervall-loesungen
output:
  html_document:
    keep_md: true
---





### Vorbereitung

> Laden Sie zunächst den Datensatz `fb24` von der pandaR-Website durch die bekannten Befehle direkt ins Environment. Alternativ ist die Datei unter diesem [<i class="fas fa-download"></i> Link](/daten/fb24.rda) zum Download verfügbar. Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/deskriptiv-intervall/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.


## Aufgabe 1

Erstellen Sie im Datensatz `fb24` die Skalenwerte für die Subskala ruhig/unruhig der aktuellen Stimmung, die mit den Items mdbf3, mdbf6, mdbf9 und mdbf12 gemessen wurde. mdbf3 und mdbf9 sind invertiert und müssen rekodiert werden. Speichern sie diese als `ru_pre` im Datensatz `fb24` ab.

* Erstellen Sie den Skalenwert als Mittelwert der vier Items.

## Aufgabe 2

Bestimmen Sie für die Skala den gesamten Mittelwert und Median.

* Was vermuten Sie, aufgrund des Verhältnisses der beiden Maße der zentralen Tendenz, bezüglich der Schiefe der Verteilung?
* Prüfen Sie Ihre Vermutung anhand eines Histogramms!

## Aufgabe 3

Bestimmen Sie für den Skalenwert `ru_pre` die empirische Varianz und Standardabweichung. Achten Sie dabei darauf, ob es auf der Skala fehlende Werte gibt.

* Sind empirische Varianz und Standardabweichung größer oder kleiner als diejenige Schätzung, die mithilfe von `var()` oder `sd()` bestimmt wird?  


## Aufgabe 4

Erstellen Sie eine z-standardisierte Variante der Skala ruhig/unruhig und legen Sie diese im Datensatz als neue Variable `ru_pre_zstd` an.

* Erstellen Sie für die z-standardisierte Variable ein Histogramm.
* Was fällt Ihnen auf, wenn Sie dieses mit dem Histogramm der unstandardisierten Werte (Erinnerung: Variablennamen `ru_pre`) vergleichen?
* Erstellen Sie beide Histogramme noch einmal mit 40 angeforderten Breaks.
