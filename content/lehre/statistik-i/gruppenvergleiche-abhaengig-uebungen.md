---
title: Tests für abhängige Stichproben - Übungen
type: post
date: '2019-10-18'
slug: gruppenvergleiche-abhaengig-uebungen
categories: Statistik I Übungen
tags: []
subtitle: ''
summary: ''
authors:
- walter
- nehler
weight: ~
lastmod: '2026-10-22'
featured: no
banner:
  image: /header/consent_checkbox.jpg
  caption: '[Courtesy of pxhere](https://pxhere.com/en/photo/449195)'
projects: []
reading_time: no
share: no
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
    keep_md: yes
private: 'true'
---





## Vorbereitung

> Laden Sie zunächst den Datensatz `fb26` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb26.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/gruppenvergleiche-abhaengig/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

**Datenaufbereitung**


``` r
#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb26.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb26$hand_factor <- factor(fb26$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb26$fach <- factor(fb26$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb26$ziel <- factor(fb26$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb26$wohnen <- factor(fb26$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))
fb26$fach_klin <- factor(as.numeric(fb26$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))
fb26$ort <- factor(fb26$ort, levels=c(1,2), labels=c("FFM", "anderer"))
fb26$job <- factor(fb26$job, levels=c(1,2), labels=c("nein", "ja"))
fb26$unipartys <- factor(fb26$uni3,
                             levels = 0:1,
                             labels = c("nein", "ja"))

# Rekodierung invertierter Items
fb26$mdbf4_r <- -1 * (fb26$mdbf4 - 4 - 1)
fb26$mdbf11_r <- -1 * (fb26$mdbf11 - 4 - 1)
fb26$mdbf3_r <-  -1 * (fb26$mdbf3 - 4 - 1)
fb26$mdbf9_r <-  -1 * (fb26$mdbf9 - 4 - 1)
fb26$mdbf5_r <- -1 * (fb26$mdbf5 - 4 - 1)
fb26$mdbf7_r <- -1 * (fb26$mdbf7 - 4 - 1)

# Berechnung von Skalenwerten
fb26$wm_pre  <- fb26[, c('mdbf1', 'mdbf5_r', 
                        'mdbf7_r', 'mdbf10')] |> rowMeans()
fb26$gs_pre  <- fb26[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb26$ru_pre <-  fb26[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb26$ru_pre_zstd <- scale(fb26$ru_pre, center = TRUE, scale = TRUE)
```

## Aufgabe 1
Zu Beginn und nach der ersten Pratikumssitzung wurden Sie als Studierende nach Ihrem Befinden zum Zeitpunkt der Umfrage befragt. Hierbei wurde unteranderem erhoben, wie wach (hohe Werte) oder müde (niedrige Werte) Sie sich zu beiden Zeitpunkten gefühlt haben (Variable `wm_pre` und `wm_post`). Nun wollen Sie untersuchen, ob die Teilnahme am Statistikpraktikum einen Einfluss auf das Befinden der Studierenden hat. Sie gehen davon aus, dass sich die Angaben zu Wach vor und nach dem Praktikum unterscheidet ohne eine Richtung anzunehmen.


* Stellen Sie zunächst das Hypothesenpaar der Testung inhaltich und auch mathematisch auf. Spezifizieren Sie das Signifikanzniveau. Dieses soll so gewählt werden, dass wir die Nullhypothese in 1 von 20 Fällen fälschlicherweise verwerfen würden.
* Bestimmen Sie die deskriptivstatistischen Maße und bewerten Sie diese im Hinblick auf die Hypothesen. Beachten Sie, dass bei der späteren inferenzstatistischen Testung nur Personen eingehen, die zu beiden Messzeitpunkten Angaben gemacht haben. Schließen Sie also Personen mit fehlenden Werten auf einer (oder beiden) Variablen vor der Berechnung der deskriptivstatistischen Maße aus.
* Welcher inferenzstatistische Test ist zur Überprüfung der Hypothesen am geeignetsten? Prüfen Sie die Voraussetzungen dieses Tests.
* Führen Sie die inferenzstatistische Testung durch.
* Bestimmen Sie unabhängig von der Signifikanzentscheidung die zugehörige Effektstärke.
* Berichten Sie die Ergebnisse formal (in schriftlicher Form).

