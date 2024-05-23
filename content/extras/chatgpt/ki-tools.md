---
title: 'Andere KI Tools'
subtitle: 'Hier wird noch gebaut...'
type: post
date: '2024-23-05'
lastmod: '2024-05-23'
slug: ki-tools
categories: ["ChatGPT"]
tags: ["ChatGPT"]
summary: ''
authors: []
weight: 3
featured: no
banner: 
  image: "/header/under_construction.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/724752)"
projects: []

reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /extras/chatgpt/ki-tools

output:
  html_document:
    keep_md: true
---

Allgemeiner Introtext

<details><summary>Übersicht über diesen Beitrag</summary>

  - Mit [welchen KI Tools](#eine-sammlung-von-ki-tools) kann man eigentlich so Datenanalyse betreiben?

</details>

# Eine Sammlung von KI Tools

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec purus nec nunc tincidunt tincidunt. Donec auctor, nunc nec.

## ChatGPT

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec purus nec nunc tincidunt tincidunt. Donec auctor, nunc nec.

## Julius.ai

In diesem Abschnitt kann man per Link [auf einen anderen Abschnitt](#eine-sammlung-von-ki-tools) verweisen. Außerdem können auch [Links zur anderen Beiträgen](/extras/chatgpt/prompts) oder z.B. zu den [KI Tools selbst](https://julius.ai/) eingefügt werden.

Auch Bilder vom Chat kann man mit der gleichen Vorgehensweise einfügen:

![](/extras/chatgpt/chatGPT1.png)

Um Dinge zu betonen, kann Text **fett**, *kursiv*, `code` oder ~~durchgestrichen~~ sein.

# Die Beispieldaten

Im Text kann direkt mit R-Code gearbeitet werden. Dieser kann als ganzer Chunk eingefügt werden:


```r
library(knitr)
kable(mtcars[1:4, ])
```



|               |  mpg| cyl| disp|  hp| drat|    wt|  qsec| vs| am| gear| carb|
|:--------------|----:|---:|----:|---:|----:|-----:|-----:|--:|--:|----:|----:|
|Mazda RX4      | 21.0|   6|  160| 110| 3.90| 2.620| 16.46|  0|  1|    4|    4|
|Mazda RX4 Wag  | 21.0|   6|  160| 110| 3.90| 2.875| 17.02|  0|  1|    4|    4|
|Datsun 710     | 22.8|   4|  108|  93| 3.85| 2.320| 18.61|  1|  1|    4|    1|
|Hornet 4 Drive | 21.4|   6|  258| 110| 3.08| 3.215| 19.44|  1|  0|    3|    1|

Diese Chunks haben verschiedene Optionen, hier die wichtigsten - in einer Liste:

  - `echo = FALSE` unterdrückt die Ausgabe des Codes
  - `eval = FALSE` führt den Code nicht aus
  - `fig = TRUE` gibt an, dass es sich um ein Bild handelt (z.B. ggplot)
  - `height = 4` und `width = 4` sind gut in Kombination mit Bildern

## Ursprüngliche Auswertung

Für die Auswertung kann es auch Sinn machen mit Formeln:


$$
  y = b_0 + b_1 \cdot x + \varepsilon
$$
oder Tabellen zu arbeiten:

| Hypothese | Verfahren | Ergebnis |
| --------- | --------- | -------- | 
| H1        | t-Test    | p < 0.05 |
| H2        | ANOVA     | p < 0.01 |
| H3        | Regression| R² = 0.2 |

Mehr Infos zur Nutzung von Markdown gibt es [hier](https://www.markdownguide.org/extended-syntax/). 
