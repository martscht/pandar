---
title: "Deskriptivstatistik für Intervallskalen - Aufgaben" 
type: post
date: '2019-10-18' 
slug: deskriptiv-intervall-aufgaben
categories: [] 
tags: ["Statistik I Übungen"] 
subtitle: ''
summary: '' 
authors: [nehler, buchholz]
weight:
lastmod: '2023-11-01'
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

> Laden Sie zunächst den Datensatz `fb23` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb23.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/deskriptiv-intervall/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.


## Aufgabe 1

Erstellen Sie im Datensatz `fb23` die Skalenwerte für die Naturverbundenheit, die mit den Items nr1 bis nr6 gemessen wurde. Keines der Items ist invertiert.


* Erstellen Sie den Skalenwert als Mittelwert der sechs Items.

## Aufgabe 2

Bestimmen Sie für die Skala den gesamten Mittelwert und Median.

* Was vermuten Sie, aufgrund des Verhältnisses der beiden Maße der zentralen
Tendenz, bezüglich der Schiefe der Verteilung?
* Prüfen Sie Ihre Vermutungen anhand eins Histogramms!

## Aufgabe 3

Bestimmen Sie für den Skalenwert `nr_ges` die empirische Varianz und Standardabweichung. Achten Sie dabei darauf, ob es auf der Skala fehlende Werte gibt.

* Sind empirische Varianz und Standardbweichung größer oder kleiner als diejenige Schätzung, die mithilfe von `var()` oder `sd()` bestimmt wird?  


## Aufgabe 4

Erstellen Sie eine z-standardisierte Variante der Skala zur Naturverbundenheit als `nr_ges_z`.

* Erstellen Sie für `nr_ges_z` ein Histogramm.
* Was fällt Ihnen auf, wenn Sie dieses mit dem Histogramm der unstandardisierten Werte `nr_ges` vergleichen?
* Erstellen Sie beide Histogramme noch einmal mit 20 angeforderten Breaks.
