---
title: "Inferenz und Modellauswahl in der multiplen Regression - Übungen" 
type: post
date: '2025-06-04'
slug: multreg-inf-mod-loesungen
categories: Statistik II Übungen
tags: []
subtitle: ''
summary: ''
authors: [vonwissel]
weight: 1
lastmod: '2025-06-04'
featured: no
banner:
  image: "/header/man_with_binoculars.jpg"
  caption: "[Courtesy of pxhere](https://www.pexels.com/photo/man-looking-in-binoculars-during-sunset-802412/)"
projects: []
reading_time: no
share: no
private: 'true'

links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-ii/multreg-inf-mod
- icon_pack: fas
  icon: star
  name: Lösungen
  url: /lehre/statistik-ii/multreg-inf-mod-loesungen
output:
  html_document:
    keep_md: yes
---



## Vorbereitung

In dieser Übung wird ein Datensatz aus einer Studie von [Frischlich et al. (2021)](https://doi.org/10.1080/15534510.2021.1966499) verwendet, die sich mit der Wirkung verzerrter politischer Berichterstattung beschäftigt. In der zugrundeliegenden Studie lasen Proband:innen einen Artikel aus dem rechtsextremen *Compact Magazin*, in dem eine migrationskritische Position dargestellt wurde. Die Glaubwürdigkeit dieses Artikels wurde anschließend eingeschätzt.

Es handelt sich um eine Teilstichprobe, in der nur Artikel mit verzerrter Darstellung und nur Teilnehmende mit rechtsgerichteter politischer Grundhaltung enthalten sind.

Der Datensatz enthält ausschließlich **Skalenwerte** (keine fehlenden Werte). Es wird davon ausgegangen, dass alle Prädiktoren in Beziehung zur wahrgenommenen **Glaubwürdigkeit** stehen.

| Variable     | Bedeutung                                      | Wertebereich               |
|--------------|------------------------------------------------|----------------------------|
| credibility  | Glaubwürdigkeit des Artikels                   | Skalenwert (1–7)           |
| leaning      | Politische Tendenz                             | 1 = extrem links, 9 = extrem rechts |
| rwa          | Rechtsextremer Autoritarismus                  | Skalenwert                 |
| cm           | Verschwörungsmentalität                        | Skalenwert                 |
| threat       | Wahrgenommene Bedrohung durch Geflüchtete     | Skalenwert                 |
| marginal     | Gefühl der Marginalisierung                    | Skalenwert                 |

Bitte führen Sie den folgenden R-Code aus, um den Datensatz zu laden und alle nötigen Pakete zu installieren.


``` r
# Installation und Laden benötigter Pakete
install.packages("olsrr")
library(olsrr)

# Laden des Übungsdatensatzes
source("https://pandar.netlify.app/daten/Data_Processing_distort.R")

# Filterung des Datensatzes
# -> Nur Artikel mit rechtspopulistischer Ausrichtung und verzerrt dargestellt
# -> Auswahl relevanter Variablen

distort <- subset(distort,
  subset = type == "distorted" & ideology == "rightwing",
  select = c("credibility", "leaning", "rwa", "cm", "threat", "marginal"))
```

## Aufgabe 1 

Erstellen Sie ein multiples Regressionsmodell zur Vorhersage der Glaubwürdigkeit (`credibility`) durch alle sechs Prädiktoren. Speichern Sie das Modell in einem Objekt namens `mod_unrestricted`.

- Geben Sie die Regressionskoeffizienten aus und interpretieren Sie den Omnibustest der multiplen Regression.
- Welche der Prädiktoren trägt signifikant zur Vorhersage der Glaubwürdigkeit bei?

## Aufgabe 2

Nutzen Sie `mod_unrestricted`, um den `credibility`-Wert einer hypothetischen Person vorherzusagen. Legen Sie dazu zunächst ein Dataframe mit folgenden Werten an:
- `leaning = 8`, `attention = 4`, `rwa = 5.5`, `cm = 5.5`, `threat = 6`, `marginal = 4`

Berechnen Sie anschließend den vorhergesagten Wert inklusive Konfidenzintervall.

## Aufgabe 3

Erstellen Sie ein weiteres Modell (`mod_restricted`), das nur `leaning`, `rwa` und `cm` als Prädiktoren enthält. 

Vergleichen Sie `mod_restricted` mit `mod_unrestricted`. Ist das vollständige Modell signifikant besser?

## Aufgabe 4

Nutzen Sie zur **automatisierten Modellauswahl** die Funktion `ols_step_both_p()` aus dem Paket `olsrr`. Verwenden Sie dafür das bereits zuvor erstellte Modell `mod_unrestricted`, das alle Prädiktoren umfasst. Führen Sie anschließend `ols_step_both_p()` mit `p_enter = .05`, `p_remove = .10` und `details = TRUE` aus, um den vollständigen Auswahlprozess zu verfolgen.

## Aufgabe 5

Führen Sie nun eine **schrittweise Modellsuche** mit `step()` durch, ausgehend von `mod_unrestricted`. Verwenden Sie die Richtung "both" (Vorwärts- und Rückwärtsselektion).

Vergleichen Sie das resultierende Modell mit `mod_unrestricted` anhand von AIC und erklärter Varianz (R²).
