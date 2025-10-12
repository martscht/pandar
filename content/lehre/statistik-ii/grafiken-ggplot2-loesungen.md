---
title: Grafiken mit ggplot2 - Lösungen
type: post
date: '2025-05-05'
slug: grafiken-ggplot2-loesungen
categories: Statistik II Übungen
tags: []
subtitle: ''
summary: ''
authors: vonwissel
weight: 1
lastmod: '2025-05-21'
featured: no
banner:
  image: /header/colorful_bubbles.jpg
  caption: '[Courtesy of pxhere](https://pxhere.com/de/photo/569459)'
projects: []
reading_time: no
share: no
links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-ii/grafiken-ggplot2
- icon_pack: fas
  icon: pen-to-square
  name: Übungen
  url: /lehre/statistik-ii/grafiken-ggplot2-uebungen
output:
  html_document:
    keep_md: yes
    self_contained: false
private: 'true'
---




## Vorbereitung

Installieren und laden Sie das Paket *ggplot2*, sofern noch nicht geschehen.


``` r
install.packages("ggplot2")
library(ggplot2)
```

Kopieren Sie nun bitte folgenden R-Code um den Übungsdatensatz *mach* zu laden und weitere vorbereitende Schritte auszuführen:


``` r
load(url("https://pandar.netlify.app/daten/mach.rda"))

# Variable hand (Schreibhand) als Faktor definieren
mach$hand <- factor(mach$hand,                # Ausgangsvariable
                      levels = 1:3,               # Faktorstufen
                      labels = c("rechts", "links", "beide"))   # Bedeutung

# Variable gender (Geschlecht) als Faktor definieren
mach$gender <- factor(mach$gender,
                      levels = 1:3,
                      labels = c("weiblich", "männlich", "divers"))

# Variable urban (Ort des Aufwachsens) als Faktor definieren
mach$urban <- factor(mach$urban,
                      levels = 1:3,
                      labels = c("Rural (country side)", "Suburban", "Urban (town / city)"))

# Definition von drei Farben als Hex-Codes zur Verwendung in Aufgabe 4
mach_colors <- c("#00618f", "#e3ba0f", "#ad3b76")
```

## Aufgabe 1

Erstellen Sie ein einfaches Balkendiagramm für die Variable *hand* aus dem *mach*-Datensatz.
- Formatieren Sie die Farbe der Balken in Abhängigkeit der Variable *hand*
- Wenden Sie das Theme `theme_minimal()` an.

<details>

<summary>Lösung</summary>


``` r
ggplot(mach, aes(x = hand)) +    # Erstellen eines leeren ggplots für den Datensatz 'mach' und der Variable 'hand' auf der x-Achse
  geom_bar(aes(fill = hand)) +   # Erweitern um eine Ebene mit Balkendiagramm. Festlegen der Farben der Balken in Abhängigkeit der Variable 'hand'
  theme_minimal()                # Verwendung des gefragten Themes
```

</details>

## Aufgabe 2

Visualiseren Sie für jedes der drei Geschlechter (Variable *gender*) die Häufigkeit der Schreibhand (Variable *hand*). Es sollen drei Balken pro Schreibhand dargestellt werden.
- Formatieren Sie die Farbe der Balken in Abhängigkeit der Variable *gender*
- Fügen Sie einen schwarzen Rand zu den Balken hinzu
- Stellen Sie die Balken nebeneinander dar. (Die Voreinstellung gibt die Balken in einer gestaplten Ansicht aus.)

<details>

<summary>Lösung</summary>


``` r
ggplot(mach, aes(x = hand, group = gender)) +                         # Grundstruktur: x-Achse = 'hand', gruppiert nach 'gender'
  geom_bar(aes(fill = gender), color = 'black', position = 'dodge')   # Balken farbig nach Geschlecht, mit schwarzem Rand, nebeneinander dargestellt 
```

</details>

## Aufgabe 3

Erweitern Sie das gruppierte Balkendiagramm aus Aufgabe 2 um geeignete Beschriftungen.
- Vergeben Sie jeweils Titel und Untertitel, sowie Achsen- und Legendentitel

<details>

<summary>Lösung</summary>


``` r
ggplot(mach, aes(x = hand, group = gender)) +  
  geom_bar(aes(fill = gender), color = "black", position = "dodge") +  # Gruppiertes Balkendiagramm wie in Aufgabe 2
  labs(x = "Schreibhand", y = "Anzahl", fill = "Geschlecht") +         # Achsen- und Legendentitel ergänzen
  ggtitle("Verteilung der Schreihand nach Geschlecht",                 # Haupttitel
          "(Daten aus dem mach-Datensatz)")                            # Untertitel
```

</details>

## Aufgabe 4

Verwenden Sie nun die in der Variable *mach_colors* (Siehe Vorbereitung oben) manuell definierte Farbpalette, um die Balken mit den von uns gewählten Farben anzupassen.

<details>

<summary>Lösung</summary>


``` r
ggplot(mach, aes(x = hand, group = gender)) +  
  geom_bar(aes(fill = gender), color = "black", position = "dodge") +  # Gruppiertes Balkendiagramm
  scale_fill_manual(values = mach_colors) +                            # Eigene Farbpalette anwenden
  labs(x = "Schreibhand", y = "Anzahl", fill = "Geschlecht") +         # Beschriftungen setzen
  ggtitle("Verteilung der Schreihand nach Geschlecht",
          "(Daten aus dem mach-Datensatz)")
```

</details>

## Aufgabe 5

Versuchen Sie unter der Verwendung der Variablen *urban* und *pvhn* die folgende Abbildung nachzubauen! 

![Boxplot Aufgabe 5](/grafiken-ggplot2-aufgabe5.png)

<details>

<summary>Lösung</summary>


``` r
ggplot(mach, aes(x = urban, y = pvhn, fill = urban)) +
  geom_boxplot() +
  scale_fill_manual(values = mach_colors) +
  theme_minimal() +
  labs(
    x = "Childhood Environment",             # x-Achsenbeschriftung
    y = "Positive View of Human Nature",     # y-Achsenbeschriftung
    fill = "Urbanization Level"              # Erklärende Legende statt Variablennamen "urban"
  ) +
  ggtitle(
    "Positive View of Human Nature by Childhood Environment",  # Title des Boxplots
    subtitle = "Grouped by self-reported urbanization level"   # Subtitle des Boxplots
  )
```

</details>
