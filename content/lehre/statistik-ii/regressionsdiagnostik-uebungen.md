---
title: "Regressionsdiagnostik - Übungen" 
type: post
date: '2025-08-21'
slug: regressionsdiagnostik-uebungen
categories: Statistik II Übungen
tags: ["Regression", "Zusammenhangsanalyse", "Erklärte Varianz", "Voraussetzungsprüfung"]
subtitle: ''
summary: ''
authors: [vonwissel]
weight: 1
lastmod: '2025-08-22'
featured: no
banner:
  image: "/header/vegan_produce.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/687666)"
projects: []
reading_time: false
share: false
private: 'true'

links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-ii/regressionsdiagnostik
- icon_pack: fas
  icon: star
  name: Lösungen
  url: /lehre/statistik-ii/regressionsdiagnostik-loesungen
output:
  html_document:
    keep_md: yes
---


## Vorbereitung

Laden Sie zunächst die benötigten Pakete und das Datenset **Prestige** aus dem Paket **carData**. Sollten Sie einzelne Pakete noch nicht installiert haben, installieren Sie diese über `install.packages()`.


``` r
# Pakete laden
library(car)
library(carData)
library(lm.beta) # Für standardisierte Regressionskoeffizienten
library(lmtest) # für die Testung der Regressionsgewichte
library(sandwich) # für die Berechnung der HC3 Standardfehler

# Daten laden
data("Prestige", package = "carData")
```

## Aufgabe 1: Modellaufstellung und erste Diagnose

1. Schätzen Sie ein multiples Regressionsmodell mit *prestige* als Kriterium und *education*, *income*, *women* als Prädiktoren.
   - Welche der vier Prädiktoren sind statistisch Signifikant?
2. Ermitteln Sie zusätzlich die standardisierte Regressionskoeffizienten.
   - Was sagen die die stand. Gewichte aus?
3. Erstellen Sie die vier Standarddiagnoseplots.
   - Welcher der Plots kann zur Diagnostik welcher Vorrausetzung herangezogen wrden?

## Aufgabe 2: Homoskedastizität prüfen

##### Diagnostik

1. Prüfen Sie grafisch die Homoskedastizität der Residuen.
2. Führen Sie zusätzlich einen geeigneten Test durch, um zu Prüfen, ob die Varianz der Residuen *signifikant linear* mit den vorhergesagten Werten zusammenhängt.

##### Umgang mit Heteroskedastizität

3. Im Falle von Heteroskedastizität können robuste, korrigierte Standardfehler als **eine** Möglichkeit herangezogen werden, um dem "Problem" entgegenzuwirken. Bestimmten Sie bitte die korrigerte Standardfehler (`HC3`). Auch falls die Homoskedastizitätannahme nicht verletzt sein sollte (Zu Übungszwecken).

## Aufgabe 3: Normalverteilung der Residuen prüfen

##### Diagnostik

1. Erstellen Sie ein **Histogramm** und einen **Q–Q-Plot** der Residuen.
2. Führen Sie zusätzlich den **Shapiro–Wilk-Test** durch

##### Umgang mit Abweichungen der Normalverteilung

3. Unabhänghig davon ob die Normalverteilungsannahme in dieser Übung verletzt sein sollte, führen Sie bitte eine geeignete Transformation der AV durch. Wie im zugehörigen PandaR Beitrag beschrieben, stellt dies *eine* der Möglichkeiten zum Umgang bei Vorrausetzungsverletzung dar.

## Aufgabe 4: Multikollinearität prüfen

1. Erstellen Sie eine **Korrelationsmatrix** der Prädiktoren, um festzustellen, ob zwei oder mehrere Prädiktoren hoch miteinander korrelieren (Multikollinearität).
2. Berechnen Sie die **Varianzinflationsfaktoren** (`VIF`) sowie die **Toleranzwerte**.

## Aufgabe 5: Einflussreiche Beobachtungen identifizieren

1. Erstellen Sie mit der Funktion `influencePlot()` ein “Blasendiagramm” zur simultanen grafischen Darstellung von Hebelwerten, studentisierten Residuen und Cooks Distanz. 
2. Ermitteln Sie mögliche Ausreiser bzw. auffälligen Fälle.
3. Überlegen Sie anhand des zugehörigen PandaR Beitrages wie Sie mit diesen Fällen umgehen möchten. 
