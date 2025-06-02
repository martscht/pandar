---
title: "Scatterplots und interaktiven Grafiken mit ggplot2 - Übungen"
type: post
date: '2025-05-21'
slug: grafiken2-ggplot2-uebungen
categories: Statistik II Übungen
tags: []
subtitle: ''
summary: ''
authors: vonwissel
weight: 1
lastmod: '2025-05-21'
featured: no
banner:
  image: "/header/colorful_tiles.jpg"
  caption: "Created using DALL-E 2"
projects: []
reading_time: no
share: no

links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-ii/grafiken2-ggplot2
- icon_pack: fas
  icon: star
  name: Lösungen
  url: /lehre/statistik-ii/grafiken2-ggplot2-loesungen
output:
  html_document:
    keep_md: yes
    self_contained: false
private: 'true'
---



## Vorbereitung

Bitte führen Sie den folgenden R-Code aus, welcher die benötigten Pakete installiert, den Übungsdatensatz läd und das Theme für die Plots setzt. Zu Übungszwecken nutzen wir das gleiche Theme, welches Ihnen bereits aus den Inhalten dieses Kapitels bekannt ist.


``` r
# Installation und Laden des Pakets "ggplot2"
install.packages("ggplot2")
library(ggplot2)

# Installation und Laden des Pakets "plotly"
install.packages("plotly")
library(plotly)

# Installation und Laden des Pakets "gapminder"
install.packages("gapminder")
library(gapminder)

# Importieren des Übungsdatensatzes aus dem zuvor installierten Paket
data(gapminder)

# Laden und setzen des Pandar Themes
source('https://pandar.netlify.app/lehre/statistik-ii/pandar_theme.R')
theme_set(theme_pandar())
```

## Aufgabe 1

Mit **ggplot2** ist es auch möglich **Liniendiagramm** zu erstellen. Zwar wurde diese Art von Plots nicht zwingend in den Inhalten dieses Kapitels behandelt, sie werden jedoch mit der selben Logik erstellt, wie alle anderen Plots. Verwenden Sie dafür `geom_line()` statt z. B. `geom_bar()` für ein Balkendiagramm.

Erstellen Sie ein **Liniendiagramm**, das die Entwicklung der Lebenserwartung (*lifeExp*) in Deutschland über die Jahre (*year*) zeigt. Erstellen Sie zunächst ein Subset für das Land "Germany" (*country*) aus dem Datensatz *gapminder*.

## Aufgabe 2

Erstellen Sie zunächst einen Subdatensatz für das Jahr 2007 (*year*), welcher die Kontinente Africa, Americas, Asia und Europe umfasst (*continent*)!

Sie möchten nun einen **Scatterplot** erstellen, welcher den Zusammenhang zwischen dem BIP pro Kopf (*gdpPercap*) auf der X-Achse und der Lebenserwartung (*lifeExp*) auf der Y-Achse im Jahr 2007 visualisiert. Verwenden Sie den Kontinent (*continent*) zur Farbcodierung der Punkte. Nutzen Sie außerdem `scale_color_pandar()` um das Pandar Theme anzuwenden.

**Achtung:** Das BIP pro Kopf ist stark rechtsschief verteilt, d. h. wenige Länder haben extrem hohe Werte:
- Um diese Verzerrung zu verringern und Muster besser sichtbar zu machen, muss die x-Achse mit `scale_x_log10()` logarithmiert werden.
- Dadurch werden relative Unterschiede betont und eine bessere Vergleichbarkeit zwischen Ländern mit niedrigem und hohem Einkommen erreicht.
- Verwenden Sie diese Art der Darstellung bzw. Skalierung anstelle von `scale_size_continuous()`, welche Sie aus den Inhalten zu diesem Kapitel kennen.

## Aufgabe 3

Erstellen Sie auf Basis des Scatterplots aus Aufgabe 2 eine Variante mit **Facettierung** nach Kontinent, um separate Teilgrafiken für jeden Kontinent darzustellen.

- Speichern Sie idealerweiße den Plot aus Aufgabe 2 in einem Objekt und erweitern Sie dieses lediglich um die Facettierung.

## Aufgabe 4

Verwandeln Sie den Scatterplot aus Aufgabe 2 in eine interaktive Grafik mit **plotly**. 

Die Tooltips sollen folgende Informationen anzeigen:
- Land
- Lebenserwartung
- BIP pro Kopf (auf zwei Dezimalstellen gerundet)

