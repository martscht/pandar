---
title: "Verteilungen - Aufgaben" 
type: post
date: '2019-10-18' 
slug: verteilungen-aufgaben 
categories: []
tags: ["Statistik I Aufgaben"] 
subtitle: ''
summary: '' 
authors: [nehler] 
weight: 
lastmod: '2023-10-08'
featured: no
banner:
  image: "/header/PsyBSc2_verteilungen.png"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1087694)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/verteilungen
  - icon_pack: fas
    icon: star
    name: Lösungen
    url: /lehre/statistik-i/verteilungen-loesungen
output:
  html_document:
    keep_md: true
---





## Aufgabe 1

Bei einem Gewinnspiel auf dem Jahrmarkt wird aus zwei Töpfen eine Kugel gezogen. In beiden Töpfen gibt es jeweils eine Kugel der Farben rot, grün, blau und gelb.

* Wie viele Kombinationsmöglichkeiten an Ziehungen gibt es, wenn jeweils eine Kugel gezogen wird. Lassen Sie sich diese ausgeben.
* Wenn mindestens eine der beiden gezogenen Kugeln grün ist, gewinnen Sie das Spiel. Lassen Sie sich von R ausgeben, wie viele mögliche Ziehungskombinationen einen Gewinn beinhalten.

## Aufgabe 2

Eine typischer Münzwurf bietet die Optionen Kopf oder Zahl.

* Simulieren Sie mithilfe von R einen Münzwurf.
* Replizieren Sie diesen Wurf nun fünf Mal. Lassen Sie sich dabei in einem abgespeicherten Objekt logisch (`FALSE` oder `TRUE`) ausgeben, ob die Münze Kopf angezeigt hat. Verwenden Sie zur Konstanthaltung einen Seed von 1901.
* Welchem Wert würde sich der Mittelwert des eben abgespeicherten Objektes im unendlichen Fall annähern?


## Aufgabe 3

Sie wollen an einem Gewinnspiel mit Losen teilnehmen. Dafür hat der Veranstalter ein computerbasiertes Vorgehen, in dem in 70% der Fällen Nieten angezeigt werden.

* Wie wahrscheinlich ist es, dass Sie in 10 Versuchen genau 4 Mal einen Gewinn erhalten?
* Plotten Sie die Wahrscheinlichkeitsverteilung für die 10 Versuche!
* Wie wahrscheinlich ist es, dass Sie in 10 Versuchen minimal 5 Gewinne erhalten?
* Wie wahrscheinlich ist es, dass Sie minimal 6 und höchstens 8 Gewinne erhalten?
* Der Preis pro Gewinn beträgt 2€. Sollten Sie bei einem Einsatz von 5€ pro 10 Versuche mitspielen?


## Aufgabe 4

Ein Fragebogen zum Thema Stressempfinden wird so konzipiert, dass die Verteilung der Testwerte einer Normalverteilung mit einem Mittelwert von 50 und einer Standardabweichung von 10 folgt.

* Zeichnen Sie die Dichtefunktion für Testwerte zwischen 30 und 70!
* Standardisieren Sie die Verteilung gedanklich. Welche Ihnen bekannte Verteilung wäre das? Zeichnen Sie zur Hilfe die Dichtefunktion für Werte zwischen -2 und 2 mit einem Mittelwert von 0 und einer Standardabweichung von 1.
* Nach dem Ausfüllen des Fragebogens erhalten zwei Personen Ihre Ergebnisse. Person 1 hat einen z-Wert von 0.5, während Person 2 einen Wert von 66 auf der beschriebenen Skala erreicht. Wer empfindet höheren Stress?
* Für welchen z-Wert gilt stets die Aussage, dass die Verteilungsfunktion den y-Wert von 0.5 erreicht?
* Zeichnen Sie die Verteilungsfunktion für die Standardnormalverteilung in den bereits verwendeten Grenzen.

## Aufgabe 5

Zum Abschluss werden wir auch hier eine Variable aus unserem Datensatz betrachten. Dabei wird es um Neurotizismus gehen. Den Datensatz haben wir bereits heruntergeladen, können ihn aber auch online abrufen. Beachten müssen wir, dass bereits Veränderungen vorgenommen wurden, die [hier](/lehre/statistik-i/verteilungen/#prep) zusammengefasst werden.

* Laden Sie den Datensatz zunächst in ihr Environment ein und überprüfen Sie, ob die Variable `neuro` den passenden Typ für unsere Betrachtung hat!
* Überprüfen Sie, ob die Variable fehlende Werte enthält. Bestimmen Sie anschließend den Mittelwert der Variable.
* Erstellen Sie für die Variable ein Histogramm mit sinnvollen Begrenzungen auf der x-Achse und der theoretisch erwarteten Normalverteilung. Bewerten Sie auch hinsichtlich der Passung!
* Führt die Betrachtung des Histogramms und eine Betrachtung eines QQ-Plots zum selben Ergebnis? Zusatz: Versuchen Sie, die Linie im Plot rot zu färben!
