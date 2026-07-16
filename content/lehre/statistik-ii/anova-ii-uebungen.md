---
title: Zweifaktorielle ANOVA - Übung
type: post
date: '2026-07-15'
slug: anova-ii-uebungen
categories: Statistik II Übungen
tags: []
subtitle: '2-fakt. ANOVA Übungen'
summary: Übungsmaterial zur zweifaktoriellen ANOVA
authors: [pommeranz]
weight: 1
lastmod: '2026-07-16'
featured: no
banner:
  image: "/header/heart_alien.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1293359)"
projects: []
reading_time: no
share: no
private: 'true'
links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-ii/anova-ii
  - icon_pack: fas
    icon: pen-to-square
    name: Lösungen
    url: /lehre/statistik-ii/anova-ii-loesungen
output:
  html_document:
    keep_md: true
---




## Vorbereitung

Bitte laden Sie den folgenden Datensatz welcher Items aus einem Machiavellismus-Fragebogen enthält herunter, um die nachfolgende Aufgabe zu lösen. Der Datensatz enthält viele Angaben zur Persönlichkeit und demografischen Daten. Kern ist aber der 20 Items umfassende Machiavellismusfragebogen von Christie und Geis (1970) und die daraus ableitbare 4-faktorielle Struktur des Konzepts (Corral & Calvete, 2000).


``` r
# Datensatz laden
load(url("https://pandar.netlify.app/daten/mach.rda"))
```

Weiterhin werden für die Ausführung der Aufgaben die Pakete `afex` und `emmeans` empfohlen. Eventuell müssen diese installiert werden. 


``` r
# Paket für Anova-Durchführung
# Paket installieren falls nicht vorhanden
if (!requireNamespace("afex", quietly = TRUE)) {
  install.packages("afex")
}
if (!requireNamespace("emmeans", quietly = TRUE)) {
  install.packages("emmeans")
}
```

In jedem Fall müssen sie aktiviert werden.


``` r
# Paket laden 
library(afex)
library(emmeans)
```

## Aufgabe 1: Variablen aufbereiten
Erstellen Sie zunächst für die Variablen `education` und `urban` jeweils einen Faktor. Für `education` ist die Codierung `1 = Less than High School`, `2 = High School`, `3 = University degree` und`4 = Graduate degree`. Für `urban` ist es `1 = Rural (country side)`, `2 = Suburban` und `3 = Urban (city, town)`.


## Aufgabe 2: Deskriptivstatistik & folgende Erwartungshaltung
Betrachten Sie nun nach der Erstellung der Faktoren deskriptistatistisch, welchen Effekt Bildung und Ländlichkeit des Wohnortes auf negative zwischenmenschliche Taktiten `nit` haben. Hierbei interessieren uns sowohl Unterschiede zwischen den Stufen, als auch mögliche Interaktionseffekte.

## Aufgabe 3: Zweifaktorielle ANOVA
Führen Sie die zweifaktorielle ANOVA durch. Interpretieren Sie den Output. Welcher Quadratsummentyp eignet sich für die Untersuchung der Haupteffekte?


## Aufgabe 4: Post-Hoc: Spezifische Gruppenunterschiede
Stellen sie nun Kontraste für folgende Gruppenvergleiche auf:
Für ländliche Lage:
"`Rural` vs Rest"
"`Suburban` vs `Urban`"

sowie für Bildung:
"`Less than Highschool` vs Rest"
"`Highschool` vs `University degree` & `Graduate degree`"
"`University degree` vs `Graduate degree`".

Beschreiben Sie kurz die Ergebnisse jedes Kontrasts.


## Aufgabe 5: Grafische Darstellung der Gruppenstatistik
[In dem PandaR Tutorial](/lehre/statistik-ii/anova-ii) finden Sie eine Anleitung, wie Sie für die ANOVA eine schöne Grafik mit ggplot2 erstellen können. Erstellen Sie eine Grafik, die die Mittelwertsunterschiede der zweifaktoriellen ANOVA visualisiert.


