---
title: Einfaktorielle ANOVA - Übung
type: post
date: '2025-04-07'
slug: anova-i-uebungen
categories: Statistik II Übungen
tags: ["ANOVA", "Post-Hoc", "Einfaktoriell"]
subtitle: '1-fakt. ANOVA Übungen'
summary: Übungsmaterial zur einfaktoriellen ANOVA
authors: [pommeranz, nehler]
weight: 1
lastmod: '2026-07-08'
featured: no
banner:
  image: "/header/earth_and_moon_space.jpg"
caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/804791)"
projects: []
reading_time: no
share: no
private: 'true'
links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-ii/anova-i
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-ii/anova-i.R
  - icon_pack: fas
    icon: pen-to-square
    name: Lösungen
    url: /lehre/statistik-ii/anova-i-loesungen
output:
  html_document:
    keep_md: true
---



## Vorbereitung

Bitte laden Sie den folgenden Datensatz herunter, der Items aus einem Machiavellismus-Fragebogen enthält, um die nachfolgende Aufgabe bearbeiten zu können. Der Datensatz enthält verschiedene Angaben zur Persönlichkeit sowie demografische Informationen. Im Mittelpunkt steht jedoch der 20 Items umfassende Machiavellismus-Fragebogen von Christie und Geis (1970) sowie die daraus ableitbare vierfaktorielle Struktur des Konzepts (Corral & Calvete, 2000). Weitere Details zum Fragebogen und seinen Items finden Sie auch [hier](https://pandar.netlify.app/daten/datensaetze/#machiavellismus-fragebogen-mach).


``` r
# Datensatz laden
load(url("https://pandar.netlify.app/daten/mach.rda"))
```

Weiterhin werden die Pakete `afex` und `emmeans` benötigt, die eventuell auch noch installiert werden müssen.


``` r
# Pakete installieren falls nicht vorhanden
if (!requireNamespace("afex", quietly = TRUE)) {
  install.packages("afex")
}
if (!requireNamespace("emmeans", quietly = TRUE)) {
  install.packages("emmeans")
}
# Pakete laden 
library(afex)
library(emmeans)
```

## Aufgabe 1

- Verschaffen Sie sich zunächst eine Übersicht über die Struktur des Datensatzes. Testen Sie anschließend auf einem $\alpha$-Niveau von 5%, ob sich die Bildungsstufen signifikant hinsichtlich des Skalenwerts zur zynischen Sicht auf die menschliche Natur (*cynical view on human nature*) unterscheiden. Ziehen Sie dafür bei Bedarf die im Aufgabentext verlinkte Übersicht zur Hilfe.
- Versuchen Sie, aus der Analyse mit `afex` die drei Quadratsummen zu bestimmen: die Quadratsumme zwischen den Gruppen, die Fehlerquadratsumme und die Gesamtquadratsumme.
- Berechnen Sie den empirischen F-Wert manuell, indem Sie die aus dem Paket bestimmten Quadratsummen und Freiheitsgrade verwenden.



## Aufgabe 2

- Die ANOVA in der vorherigen Aufgabe war signifikant. Nun ist interessant, zwischen welchen Bildungsstufen sich die Mittelwerte unterscheiden. Führen Sie daher paarweise Vergleiche zwischen allen Gruppen durch und verwenden Sie eine geeignete Korrektur für multiples Testen.
