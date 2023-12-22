---
title: ggplot2 Intro
type: post
date: '2021-07-02'
slug: ggplotting-intro
categories: ["ggplotting"]
tags: ["ggplotting"] 
subtitle: ''
summary: '' 
authors: [schultze, buchholz] 
weight: 2
lastmod: '2023-12-22'
featured: no
banner:
  image: "/header/splattered_paint.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/140106)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /workshops/ggplotting/ggplotting-intro
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /workshops/ggplotting/ggplotting-intro.R
output:
  html_document:
    keep_md: true
---


## Einleitung

Das Paket `ggplot2` ist das umfangreichste und am weitesten verbreitete Paket zur Grafikerstellung in R.  Seine Beliebtheit liegt vor allem an zwei Dingen: Es ist sehr eng mit der kommerziellen Seite von RStudio verwoben (Autor ist auch hier Hadley Wickham) und es folgt stringent einer "Grammatik der Grafikerstellung". Aus dem zweiten Punkt leitet sich auch sein Name ab: das "gg" steht für "Grammar of Graphics" und geht auf das gleichnamige Buch von Leland Wilkinson zurück, in dem auf 700 kurzen Seiten eine grammatikalische Grundstruktur für das Erstellen von Grafiken zur Datendarstellung hergeleitet und detailliert erklärt wird.

Weil `ggplot2` so beliebt ist, gibt es online tausende von Quellen mit Tutorials, Beispielen und innovativen Ansätzen zur Datenvisualisierung. Vom Autor des Pakets selbst gibt es ein [Überblickswerk über Data-Science als e-Book](https://r4ds.had.co.nz/), in dem sich auch [ein Kapitel](https://r4ds.had.co.nz/data-visualisation.html) mit `ggplot2` befasst. Wie wir noch besprechen werden ist es Teil des [tidyverse](https://www.tidyverse.org/) und somit direkt in eine Umgebung aus verschiedenen Paketen für Datenmanagement und -darstellung integriert.

## Beispieldaten {#Beispieldaten}

Wir benutzen für unsere Interaktion mit `ggplot2` öffentlich zugängliche Daten aus verschiedenen Quellen, die dankenswerterweise von [Gapminder](https://www.gapminder.org/) zusammengetragen werden. Für diesen Abschnitt gucken wir uns dafür mal an, wie viel verschiedene Länder in die Bildung investieren - diese Daten stammen ursprünglich von der [Weltbank](https://data.worldbank.org).

Alle, die daran interessiert sind, wie diese Daten von Gapminder bezogen und für die Weitervewendung aufbereitet werden, können das Ganze [im Beitrag zur Datenaufbereitung](/post/ggplotting-daten) noch genauer nachlesen. Für alle, die das überspringen und endlich Bilder machen wollen, gibt es auch schon den [`<svg aria-hidden="true" role="img" viewBox="0 0 512 512" style="height:1em;width:1em;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:currentColor;overflow:visible;position:relative;"><path d="M288 32c0-17.7-14.3-32-32-32s-32 14.3-32 32V274.7l-73.4-73.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l128 128c12.5 12.5 32.8 12.5 45.3 0l128-128c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L288 274.7V32zM64 352c-35.3 0-64 28.7-64 64v32c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V416c0-35.3-28.7-64-64-64H346.5l-45.3 45.3c-25 25-65.5 25-90.5 0L165.5 352H64zm368 56a24 24 0 1 1 0 48 24 24 0 1 1 0-48z"/></svg>`{=html} fertigen Datesatz zum Download](/post/edu_exp.rda). Auch den kann man aber direkt in R laden, ohne erst die Datei herunterladen und speichern zu müssen:


```r
load(url('https://pandar.netlify.com/post/edu_exp.rda'))
```




Eine kurze Erläuterung der Variablenbedeutungen:
  
  - `geo`: Länderkürzel, das zur Identifikation der Länder über verschiedene Datenquellen hinweg genutzt wird
  - `Country`: der Ländername im Englischen
  - `Wealth`: Wohlstandseinschätzung des Landes, unterteilt in fünf Gruppen 
  - `Region`: Einteilung der Länder in die vier groben Regionen `africa`, `americas`, `asia` und `europe`
  - `Year`: Jahreszahl
  - `Population`: Bevölkerung
  - `Expectancy`: Lebenserwartung eines Neugeborenen, sollten die Lebensumstände stabil bleiben.
  - `Income`: Stetiger Wohlstandsindikator für das Land (GDP pro Person)
  - `Primary`: Staatliche Ausgaben pro Schüler*in in der primären Bildung als Prozent des `income` (GDP pro Person)
  - `Secondary`: Staatliche Ausgaben pro Schüler*in in der sekundären Bildung als Prozent des `income` (GDP pro Person)
  - `Tertiary`: Staatliche Ausgaben pro Schüler\*in oder Student\*in in der tertiären Bildung als Prozent des `income` (GDP pro Person)
  - `Index`: Education Index des United Nations Development Programme


Eine Ausprägung von 100 auf der Variable `primary` in Deutschland hieße also zum Beispiel, dass pro Schüler*in in der Grundschule das Äquivalent der Wirtschaftsleistung einer bzw. eines Deutschen ausgegeben würde. 50 hieße entsprechend, dass es die Hälfte dieser Wirtschaftsleistung in diese spezifische Schulausbildung investiert wird.

Der Datensatz mit dem wir arbeiten sieht also so aus:


```r
head(edu_exp)
```

```
##   geo     Country     Wealth
## 1 afg Afghanistan low_income
## 2 afg Afghanistan low_income
## 3 afg Afghanistan low_income
## 4 afg Afghanistan low_income
## 5 afg Afghanistan low_income
## 6 afg Afghanistan low_income
##   Region Year Population
## 1   asia 1997   19357126
## 2   asia 1998   19737770
## 3   asia 1999   20170847
## 4   asia 2000   20779957
## 5   asia 2001   21606992
## 6   asia 2002   22600774
##   Expectancy Income Primary
## 1      53.74    865      NA
## 2      52.80    800      NA
## 3      54.43    735      NA
## 4      54.63    687      NA
## 5      54.76    646      NA
## 6      55.65   1016      NA
##   Secondary Tertiary    Index
## 1        NA       NA 13.33333
## 2        NA       NA 13.33333
## 3        NA       NA 14.00000
## 4        NA       NA 14.66667
## 5        NA       NA 14.66667
## 6        NA       NA 15.33333
```


## `ggplot2` Grundprinzipien {#Grundprinzipien}

In `ggplot2` werden immer Daten aus **einem** `data.frame` dargestellt. Das heißt, dass wir nicht, wie bei `plot` oder `hist` aus R selbst Vektoren oder Matrizen nutzen können. Daten müssen immer so aufbereitet sein, dass der grundlegende Datensatz sinnvoll benannte Variablen enthält und in dem Format vorliegt, in dem wir die Daten visualisieren wollen. Das hat zwar den Nachteil, dass wir Datensätze umbauen müssen, wenn wir Dinge anders darstellen wollen, aber hat auch den Vorteil, dass wir alle Kenntnisse über Datenmanagement im Allgemeinen auf den Umgang mit `ggplot2` übertragen können. 

Bevor wir loslegen können, muss natürlich `ggplot2` installiert sein und geladen werden:


```r
library(ggplot2)
```

```
## Warning: Paket 'ggplot2' wurde
## unter R Version 4.3.2 erstellt
```

Im Kern bestehen Abbildungen in der Grammatik von `ggplot2` immer aus drei Komponenten:

  - Daten, die angezeigt werden sollen
  - Geometrie, die vorgibt welche Arten von Grafiken (Säulendiagramme, Punktediagramme, usw.) genutzt werden
  - Ästhetik, die vorgibt, wie die Geometrie und Daten aufbereitet werden (z.B. Farben)

In den folgenden Abschnitten werden wir versuchen, diese drei Komponenten so zu nutzen, dass wir informative und eventuell auch ansehnliche Abbildungen generieren.

## Schichten

In `ggplot2` werden Grafiken nicht auf einmal mit einem Befehl erstellt, sondern bestehen aus verschiedenen Schichten. Diese Schichten werden meistens mit unterschiedlichen Befehlen erzeugt und dann so übereinandergelegt, dass sich am Ende eine Abbildung ergibt.

Die Grundschicht sind die Daten. Dafür haben wir im vorherigen Abschnitt `edu_exp` als Datensatz aufbereitet. Benutzen wir zunächst nur die Daten für Spanien um nicht direkt tausende von Datenpunkten auf einmal zu sehen. Ich habe Spanien ausgesucht, weil es bezüglich der Bildungs- und Arbeitsmarktsituation für junge Personen ein Land mit vielen "interssanten Konstellationen" ist.


```r
esp <- subset(edu_exp, geo == 'esp')
```


```r
ggplot(esp)
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

Was entsteht ist eine leere Fläche. Wie bereits beschrieben, besteht eine Abbildung in `ggplot2` immer aus den drei Komponenten Daten, Geometrie und Ästhetik. Bisher haben wir nur eine festgelegt. Als erste Ästhetik sollten wir festlegen, welche Variablen auf x- und y-Achse dargestellt werden sollen. Nehmen wir naheliegenderweise die Zeit (x-Achse) und die Ausgaben für Grundschulbildung:


```r
ggplot(esp, aes(x = Year, y = Primary))
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/unnamed-chunk-7-1.png)<!-- -->


Ästhetik wird in `ggplot2` über den `aes`-Befehl erzeugt. Jetzt fehlt uns noch die geometrische Form, mit der die Daten abgebildet werden sollen. Für die Geometrie-Komponente stehen in `ggplot2` sehr viele Funktionen zur Verfügung, die allesamt mit `geom_` beginnen. Eine Übersicht über die Möglichkeiten findet sich z.B. [hier](https://ggplot2.tidyverse.org/reference/#section-layer-geoms). Naheliegende Möglichkeiten für den Zeitverlauf sind eine Linie (`geom_line`) und mehrere Punkte (`geom_point`). Neue Schichten werden in ihrer eigenen Funktion erzeugt und mit dem einfachen `+` zu einem bestehenden Plot hinzugefügt. Für ein Liniendiagramm sieht das Ganze also einfach so aus:


```r
ggplot(esp, aes(x = Year, y = Primary)) + 
  geom_line()
```

```
## Warning: Removed 2 rows containing
## missing values (`geom_line()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/simple-line-1.png)<!-- -->

Der immense Vorteil des Schichtens besteht darin, dass wir gleichzeitig mehrere Visualisierungsformen nutzen können. Das Prinizp bleibt das gleiche wie vorher: wir fügen Schichten mit dem `+` hinzu. Wir können also Punkte und Linien direkt miteinander kombinieren:


```r
ggplot(esp, aes(x = Year, y = Primary)) + 
  geom_line() + 
  geom_point()
```

```
## Warning: Removed 2 rows containing
## missing values (`geom_line()`).
```

```
## Warning: Removed 2 rows containing
## missing values (`geom_point()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/simple-dot-lines-1.png)<!-- -->

## Plots als Objekte

Einer der Vorteile, die sich durch das Schichten der Abbildungen ergibt ist, dass wir Teile der Abbildung als Objekte definieren können und sie in verschiedenen Varianten wieder benutzen können. Das hilft besonders dann, wenn wir unterschiedliche Geometrie in einer gemeinsamen Abbildung darstellen wollen oder z.B. erst einmal eine Abbildung definieren wollen, bevor wir Feinheiten adjustieren.



```r
basic <- ggplot(esp, aes(x = Year, y = Primary))
```

In `basic` wird jetzt die *Anleitung* für die Erstellung der Grafik gespeichert. Erstellt wird die Grafik aber erst, wenn wir das Objekt aufrufen. Dabei können wir das Objekt auch mit beliebigen anderen Komponenten über `+` kombinieren:


```r
basic + geom_point()
```

```
## Warning: Removed 2 rows containing
## missing values (`geom_point()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/object_combos-1.png)<!-- -->

Damit die Beispiele im weiteren Verlauf auch selbstständig funktionieren, wird unten immer der gesamte Plot aufgeschrieben. Aber für eigene Übungen oder Notizen ist es durchaus praktischer mit dieser Objekt Funktionalität zu arbeiten, um so zu umgehen, dass man immer wieder die gleichen Abschnitte aufschreiben muss.

## Farben und Ästhetik {#Farben}

Oben hatte ich schon erwähnt, dass Ästhetik die dritte Komponente ist und als Beispiel Farbe genannt. Das stimmt nicht immer: die Farbe der Darstellung muss nicht zwingend eine Ästhetik sein. Gucken wir uns zunächst an, wie es aussieht, wenn wir die Farbe der Darstellung ändern wollen:


```r
ggplot(esp, aes(x = Year, y = Primary)) +
  geom_point(color = 'blue')
```

```
## Warning: Removed 2 rows containing
## missing values (`geom_point()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/simple-blue-1.png)<!-- -->

Alle Punkte haben die Farbe geändert. Eine Ästhetik im Sinne der `ggplot`-Grammatik ist aber immer abhängig von den Daten. Die globale Vergabe von Farbe ist also keine Ästhetik. Sie ist es nur, wenn wir sie von Ausprägungen der Daten abhängig machen. Das funktioniert z.B. so:


```r
ggplot(esp, aes(x = Year, y = Primary)) +
  geom_point(aes(color = Primary))
```

```
## Warning: Removed 2 rows containing
## missing values (`geom_point()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/gradient-tertiary-1.png)<!-- -->

Über den Befehl `aes` definieren wir eine Ästhetik und sagen `ggplot`, dass die Farbe der Punkte von der Ausprägung auf der Variable `Primary` abhängen soll. Die Farbe kann aber natürlich auch von jeder anderen Variable im Datensatz abhängen. Wie das aussehen kann gucken wir uns im kommenden Abschnitt an.

## Gruppierte Abbildungen

Im letzten Abschnitt hatten wir die Daten auf Spanien reduziert. In diesem Abschnitt wollen wir gleichzeitig mehrere Länder betrachten können. Dafür müssen wir wieder zunächst die Daten auswählen, die relevant sind. Wir beschränken uns in diesem Fall auf die fünf bevölkerungsreichsten Länder Europas, für die ausreichend viele Datenpunkte vorliegen: das Vereinigte Königreich, Frankreich, Italien, Spanien und Polen.


```r
sel <- subset(edu_exp, geo %in% c('gbr', 'fra', 'ita', 'esp', 'pol'))
```

Wenn wir jetzt mit dem gleichen Vorgehen wie oben die Abbildung erstellen, wird es etwas chaotischer, weil unklar ist, welche Punkte sich auf welches Land beziehen:


```r
ggplot(sel, aes(x = Year, y = Primary)) +
  geom_point()
```

```
## Warning: Removed 18 rows containing
## missing values (`geom_point()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/grouped-chaos-1.png)<!-- -->

Um das zu umgehen, können wir natürlich die Ästhetik der Farben benutzen:


```r
ggplot(sel, aes(x = Year, y = Primary)) +
  geom_point(aes(color = Country))
```

```
## Warning: Removed 18 rows containing
## missing values (`geom_point()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/grouped-points-1.png)<!-- -->

Wie Sie sehen ergibt sich automatisch eine Legende auf der rechten Seite, die jedem Land eine Farbe zuweist. Wir können auch hier wieder eine Kombination aus Punkten und Linien nutzen:


```r
ggplot(sel, aes(x = Year, y = Primary)) +
  geom_point(aes(color = Country)) + 
  geom_line(aes(color = Country))
```

```
## Warning: Removed 18 rows containing
## missing values (`geom_point()`).
```

```
## Warning: Removed 15 rows containing
## missing values (`geom_line()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/grouped-dot-lines-1.png)<!-- -->

Das Problem ist hier, dass wir die Ästhetik für jede Geomtrie wiederholen müssen. Stattdessen können wir in `ggplot` auch allgemein eine Gruppierung vornehmen, die für alle Geometrien übernommen wird:


```r
ggplot(sel, aes(x = Year, y = Primary, color = Country)) +
  geom_point() + geom_line()
```

## Mehrere Variablen

Bisher haben wir auf der x-Achse nur die Zeit und auf der y-Achse nur die Ausgaben für die Grundschulbildung betrachtet. Durch das Schicht-System können wir auf unsere bisherigen Abbildungen aber auch zusätzliche Variablen - oder sogar komplett andere Datensätze - abbilden. Wenn wir uns z.B. gleichzeitig die Ausgaben für Primäre, Sekundäre und Tertiäre Bildung in Spanien angucken wollen, können wir wie folgt vorgehen:


```r
ggplot(esp, aes(x = Year)) +
  geom_line(aes(y = Primary), color = 'red') +
  geom_line(aes(y = Secondary), color = 'green') + 
  geom_line(aes(y = Tertiary), color = 'blue') 
```

```
## Warning: Removed 2 rows containing
## missing values (`geom_line()`).
## Removed 2 rows containing
## missing values (`geom_line()`).
## Removed 2 rows containing
## missing values (`geom_line()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/multivar-1.png)<!-- -->

*Achtung:* Wenn mehrere Variablen im gleichen Diagramm abgebildet werden, sollten Sie einen sinnvollen Achsentitel wählen. Hier wird per Voreinstellung der Name der ersten Variable für die Beschriftung der y-Achse gewählt. Weiter unten wird erklärt, wie die Achsenbeschriftung geändert werden kann. 

Diese Vorgehensweise ist zwar möglich aber nicht wirklich im Sinne des Erfinders. Eigentlich will `ggplot2` von uns, dass wir solche Untscheidungen über Gruppierung der Daten erzeugen. Dafür müssten wir unsere Daten ins long-Format übertragen, sodass wir statt dieser "breiten" Struktur:

| geo | Year | Primary | Secondary | Tertiary |
| --- | --- | --- | --- | --- |
| esp | 1998 | 16.97009 | 23.87749 | 19.62106 |
| esp | 1999 | 17.73268 | 24.05752 | 19.38165 |
| ... | ... | ... | ... | ... |

diese "lange" Struktur erhalten:

| geo | Year | Type | Expense |
| --- | --- | --- | --- |
| esp | 1998 | Primary | 16.97009 |
| esp | 1998 | Secondary | 23.87749 | 
| esp | 1998 | Tertiary | 19.62106 |
| esp | 1999 | Primary | 17.73268 |
| esp | 1999 | Secondary | 24.05752 | 
| esp | 1999 | Tertiary | 19.38165 |
| ... | ... | ... | ... | ... |

In diesem Format angekommen, haben wir dann wieder die Möglichkeit mit Gruppierungen anhand der neuen `Type` Variable so zu verfahren, wie wir es oben schon gesehen haben. Um eine solche Umstellung vorzunehmen, können wir den `reshape` Befehl nutzen:


```r
sel_long <- reshape(sel, direction = 'long',
  varying = c('Primary', 'Secondary', 'Tertiary'),
  v.names = 'Expense',
  timevar = 'Type',
  times = c('Primary', 'Secondary', 'Tertiary'))
```

Der entstandene Datensatz hat jetzt das von `ggplot2` so geliebte lange Datenformat:


```r
head(sel_long)
```

```
##           geo Country
## 1.Primary esp   Spain
## 2.Primary esp   Spain
## 3.Primary esp   Spain
## 4.Primary esp   Spain
## 5.Primary esp   Spain
## 6.Primary esp   Spain
##                Wealth Region
## 1.Primary high_income europe
## 2.Primary high_income europe
## 3.Primary high_income europe
## 4.Primary high_income europe
## 5.Primary high_income europe
## 6.Primary high_income europe
##           Year Population
## 1.Primary 1997   40035286
## 2.Primary 1998   40201561
## 3.Primary 1999   40454472
## 4.Primary 2000   40824745
## 5.Primary 2001   41319431
## 6.Primary 2002   41919593
##           Expectancy Income
## 1.Primary      78.72  26448
## 2.Primary      78.90  27473
## 3.Primary      78.91  28589
## 4.Primary      79.39  29967
## 5.Primary      79.66  30951
## 6.Primary      79.82  31395
##              Index    Type
## 1.Primary 53.33333 Primary
## 2.Primary 54.00000 Primary
## 3.Primary 54.66667 Primary
## 4.Primary 56.00000 Primary
## 5.Primary 56.66667 Primary
## 6.Primary 56.66667 Primary
##            Expense id
## 1.Primary       NA  1
## 2.Primary 16.97009  2
## 3.Primary 17.73268  3
## 4.Primary 17.22694  4
## 5.Primary 17.52693  5
## 6.Primary 17.76286  6
```

Damit können wir jetzt die drei verschiedenen Variablen als gruppierte Beobachtungen darstellen und das gleiche Schema wie schon oben benutzen. Dafür wählen wir aber Spanien aus unserem Langen Datensatz aus und geben nur diese Daten mit der Pipe `|>` an `ggplot` weiter:


```r
subset(sel_long, geo == 'esp') |> 
  ggplot(aes(x = Year, y = Expense, color = Type)) +
    geom_line() + geom_point()
```

```
## Warning: Removed 6 rows containing
## missing values (`geom_line()`).
```

```
## Warning: Removed 6 rows containing
## missing values (`geom_point()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/multivar-grouped-1.png)<!-- -->


## Faceting

Wenn wir die Kombination aus allen Bildungsniveaus und unseren fünf Ländern in der gleichen Abbildung darstellen wollen, könnte das ein wenig unübersichtlich werden. Eine Möglichkeit, Übersichtlichkeit zu bewahren ist das sogenannte Faceting. Dabei wird eine Abbildung anhand von Ausprägungen auf einer oder mehr Variablen in verschiedene Abbildungen unterteilt. Für unseren Fall können wir uns in einer Abbildung z.B. eine Facet für jedes Bildungsniveau anzeigen lassen:


```r
ggplot(sel_long, aes(x = Year, y = Expense, color = Country)) +
  geom_point() + geom_line() +
  facet_wrap(~ Type)
```

```
## Warning: Removed 50 rows containing
## missing values (`geom_point()`).
```

```
## Warning: Removed 15 rows containing
## missing values (`geom_line()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/multivar-faceted-1.png)<!-- -->

In `facet_wrap` wird mit der R Gleichungsnotation gearbeitet: hier wird der Plot anhand der unabhängigen Variablen hinter der Tilde in Gruppen eingeteilt. Das gibt auch wieder die Möglichkeit mit `+` mehrere Variablen zu definieren, die zum Faceting benutzt werden sollen. Wenn wir Gruppen anhand von zwei Variablen bilden bietet es sich außerdem an `facet_grid` zu benutzen. Ein solcher Grid wäre z.B. die gleichzeitige Einteilung nach Typ und Land:


```r
ggplot(sel_long, aes(x = Year, y = Expense, color = Country)) +
  geom_point() + geom_line() +
  facet_grid(Type ~ Country)
```

```
## Warning: Removed 50 rows containing
## missing values (`geom_point()`).
```

```
## Warning: Removed 15 rows containing
## missing values (`geom_line()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/multivar-gridded-1.png)<!-- -->

Hier unterteilt die Variable vor der Tilde die Facets in Zeilen, die Variable nach der Tilde in Spalten. Per Voreinstellung wird beim Faceting eine gemeinsame Skalierung der x- und y-Achsen für alle Teilabbildungen festgelegt. Das kann mit dem Argument `scales` in der `facet_wrap` Funktion umgangen werden:


```r
ggplot(sel_long, aes(x = Year, y = Expense, color = Country)) +
  geom_point() + geom_line() +
  facet_grid(Type ~ Country, scales = 'free')
```

```
## Warning: Removed 50 rows containing
## missing values (`geom_point()`).
```

```
## Warning: Removed 15 rows containing
## missing values (`geom_line()`).
```

![](/workshops/ggplotting/ggplotting-intro_files/figure-html/multivar-scaled-1.png)<!-- -->

Während das zwar schöner aussieht sei aber dazu gesagt, dass wir hier die Interpretierbarkeit der Grafik dahingehend einschränken, dass Abbildungen in unterschiedlichen Zeilen nicht mehr direkt miteinander verglichen werden können. 

***

Damit haben wir alle grundlegenden Funktionalitäten von `ggplot2` am Beispiel eines Punkte bzw. Liniendiagramms besprochen. Leider würden so alle Abbildungen immer gleich aussehen, weswegen wir im [Abschnitt zum Anpassen von Abbildungen](/post/ggplotting-themes) genau besprechen werden, wie man ggplots nach eigenem Geschmack gestalten kann. Wer sich auch gerne mal die Erstellung von Balkendiagrammen, Boxplots, Violinplots oder sogar... Tortendiagrammen ansehen will wird im [Abschnitt zur anderen Plot-Typen](/post/ggplotting-ggplotpourri) fündig.
