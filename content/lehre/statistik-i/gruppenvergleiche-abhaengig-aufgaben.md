---
title: "Tests für abhängige Stichproben - Aufgaben" 
type: post
date: '2019-10-18' 
slug: gruppenvergleiche-abhaengig-aufgaben
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [walter, nehler]
weight:
lastmod: '2024-12-05'
featured: no
banner:
  image: "/header/consent_checkbox.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/449195)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/gruppenvergleiche-abhaengig
  - icon_pack: fas
    icon: star
    name: Lösungen
    url: /lehre/statistik-i/gruppenvergleiche-abhaengig-loesungen
output:
  html_document:
    keep_md: true
---





## Vorbereitung

> Laden Sie zunächst den Datensatz `fb24` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb24.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/gruppenvergleiche-abhaengig/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.


## Aufgabe 1
Zu Beginn und nach der ersten Pratikumssitzung wurden Sie als Studierende nach Ihrem Befinden zum Zeitpunkt der Umfrage befragt. Hierbei wurde unteranderem erhoben, wie wach (hohe Werte) oder müde (niedrige Werte) Sie sich zu beiden Zeitpunkten gefühlt haben (Variable `wm_pre` und `wm_post`). Nun wollen Sie untersuchen, ob die Teilnahme am Statistikpraktikum einen Einfluss auf das Befinden der Studierenden hat. Sie gehen davon aus, dass sich die Angaben zu Wach vor und nach dem Praktikum unterscheidet ohne eine Richtung anzunehmen.



* Stellen Sie zunächst das Hypothesenpaar der Testung inhaltich und auch mathematisch auf. Spezifizieren Sie das Signifikanzniveau. Dieses soll so gewählt werden, dass wir die Nullhypothese in 1 von 20 Fällen fälschlicherweise verwerfen würden.
* Bestimmen Sie die deskriptivstatistischen Maße und bewerten Sie diese im Hinblick auf die Hypothesen. Beachten Sie, dass bei der späteren inferenzstatistischen Testung nur Personen eingehen, die zu beiden Messzeitpunkten Angaben gemacht haben. Schließen Sie also Personen mit fehlenden Werten auf einer (oder beiden) Variablen vor der Berechnung der deskriptivstatistischen Maße aus.
* Welcher inferenzstatistische Test ist zur Überprüfung der Hypothesen am geeignetsten? Prüfen Sie die Voraussetzungen dieses Tests.
* Führen Sie die inferenzstatistische Testung durch.
* Bestimmen Sie unabhängig von der Signifikanzentscheidung die zugehörige Effektstärke.
* Berichten Sie die Ergebnisse formal (in schriftlicher Form).

