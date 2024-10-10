---
title: "Tag 02" 
type: post
date: '2024-10-09' 
slug: refresher-day2 
categories: ["refresheR"] 
tags: ["refresheR"] 
subtitle: ''
summary: '' 
authors: [stephan, gruetzner, vogler] 
weight: 2
lastmod: '2024-10-10'
featured: no
banner:
  image: "/header/rice-field.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/1271196)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /workshops/refresher/refresher-day2
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /workshops/refresher/refresher-day2.R
  - icon_pack: fas
    icon: pen-to-square
    name: Übungen
    url: /workshops/refresher/refresher-uebungen/#ubung-3-abschlussaufgabe
output:
  html_document:
    keep_md: true
    
---



<details><summary><b>Themen (CLICK ME)</b></summary>

* [ggplot2](#ggplot) - Eine Einführung in das Erstellen von Grafiken in R
* [t-Test](#tTest) - Einstichproben, Unabhängige und Abhängige 
* [Regression](#reg) - Einfache und multiple lineare Regression

</details>

***

## Einleitende Worte

Dieser Beitrag ist im Rahmen des R Workshops für angehende KliPPs Masterstudierende entstanden. Die hier aufgeführten Inhalte sind alles andere als originell und sollten als Zusammenfassung der [Statistik I](/lehre/main/#statistik-i) und [Statistik II](/lehre/main/#statistik-ii) Beiträge verstanden werden. Der Verdienst gehört den Autoren der Beiträge. Wir empfehlen für eine auführlichere Behandlung der Themen in den entsprechenden Beiträgen nachzulesen.

***

## ggplot2 {#ggplot}

### Einleitung

Das Paket `ggplot2` ist das umfangreichste und am weitesten verbreitete Paket zur Grafikerstellung in `R`.  Seine Beliebtheit liegt vor allem an zwei Dingen: Es ist sehr eng mit der kommerziellen Seite von `RStudio` verwoben (Autor ist auch hier Hadley Wickham) und es folgt stringent einer "Grammatik der Grafikerstellung". Aus dem zweiten Punkt leitet sich auch sein Name ab: das "gg" steht für "Grammar of Graphics" und geht auf das gleichnamige Buch von Leland Wilkinson zurück, in dem auf 700 kurzen Seiten eine grammatikalische Grundstruktur für das Erstellen von Grafiken zur Datendarstellung hergeleitet und detailliert erklärt wird.

Weil `ggplot2` so beliebt ist, gibt es online tausende von Quellen mit Tutorials, Beispielen und innovativen Ansätzen zur Datenvisualisierung. Vom Autor des Pakets selbst gibt es ein [Überblickswerk über Data-Science als e-Book](https://r4ds.hadley.nz/), in dem sich auch [ein Kapitel](https://r4ds.hadley.nz/data-visualize.html) mit `ggplot2` befasst.

Für jede Seminar- und Abschlussarbeit sind Abbildungen unersetzbar und `ggolot2` bietet euch im Unterschied zu Base-R Plots viele einfache Anpassungsmöglichkeiten. 

<details><summary>Abschnitte in diesem Thema</summary>

- Eine kurze Beschreibung der [Beispieldaten](#beispieldaten)
- Die [Grundprinzipien](#grundprinzipien) von `ggplot2` - [Schichten](#schichten), [Plots als Objekte](#plots-als-objekte) und [Gruppierung von Daten](#gruppierte-abbildungen)
- Wie Abbildungen [angepasst werden](#abbildungen-anpassen) können: mit [Themes](#themes), [Beschriftungen](#beschriftung) und [Farbpaletten](#farbpaletten)

</details>

### Beispieldaten

Wir benutzen für unsere Interaktion mit `ggplot2` öffentlich zugängliche Daten aus verschiedenen Quellen, die ich in einem Anflug von Selbstlosigkeit bereits für Sie zusammengetragen habe. Alle, die daran interessiert sind, wie diese Daten bezogen und für die Weiterverwendung aufbereitet werden, können das Ganze [im kurzen Beitrag zur Datenaufbereitung](/workshops/ggplotting/ggplotting-daten) noch genauer nachlesen. In den Daten geht es im Wesentlichen um die Ausgaben für Bildung, die Länder weltweit so tätigen. Für alle, die das überspringen und einfach Bilder machen wollen, gibt es auch schon den [{{< icon name="download" pack="fas" >}} fertigen Datensatz zum Download](/daten/edu_exp.rda). Auch den kann man aber direkt in `R` laden, ohne erst die Datei herunterladen und speichern zu müssen:


``` r
load(url('https://pandar.netlify.app/daten/edu_exp.rda'))
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
  - `Primary`: Staatliche Ausgaben pro Schüler:in in der primären Bildung als Prozent des `income` (GDP pro Person)
  - `Secondary`: Staatliche Ausgaben pro Schüler:in in der sekundären Bildung als Prozent des `income` (GDP pro Person)
  - `Tertiary`: Staatliche Ausgaben pro Schüler:in oder Student:in in der tertiären Bildung als Prozent des `income` (GDP pro Person)
  - `Index`: Education Index des United Nations Development Programme


Eine Ausprägung von 100 auf der Variable `Primary` in Deutschland hieße also zum Beispiel, dass pro Schüler:in in der Grundschule das Äquivalent der Wirtschaftsleistung einer/eines Deutschen ausgegeben würde. 50 hieße dementsprechend, dass es die Hälfte dieser Wirtschaftsleistung in diese spezifische Schulausbildung investiert wird.

Der Datensatz, mit dem wir arbeiten, sieht also so aus:


``` r
head(edu_exp)
```

```
##   geo     Country     Wealth Region Year Population Expectancy   Income
## 1 afg Afghanistan low_income   asia 1997   17788819       50.7       NA
## 2 afg Afghanistan low_income   asia 1998   18493132       50.0       NA
## 3 afg Afghanistan low_income   asia 1999   19262847       50.8       NA
## 4 afg Afghanistan low_income   asia 2000   19542982       51.0       NA
## 5 afg Afghanistan low_income   asia 2001   19688632       51.1       NA
## 6 afg Afghanistan low_income   asia 2002   21000256       51.6 344.2242
##   Primary Secondary Tertiary Index
## 1      NA        NA       NA  0.18
## 2      NA        NA       NA  0.19
## 3      NA        NA       NA  0.20
## 4      NA        NA       NA  0.20
## 5      NA        NA       NA  0.21
## 6      NA        NA       NA  0.22
```


### `ggplot2` Grundprinzipien {#grundprinzipien}

In `ggplot2` werden immer Daten aus **einem** `data.frame` dargestellt. Das heißt, dass wir nicht, wie bei `plot` oder `hist` aus `R` selbst Vektoren oder Matrizen nutzen können. Daten müssen immer so aufbereitet sein, dass der grundlegende Datensatz sinnvoll benannte Variablen enthält und in dem Format vorliegt, in welchem wir die Daten visualisieren wollen. Das hat zwar den Nachteil, dass wir Datensätze umbauen müssen, wenn wir Dinge anders darstellen wollen, aber hat auch den Vorteil, dass wir alle Kenntnisse über Datenmanagement im Allgemeinen auf den Umgang mit `ggplot2` übertragen können. 

Bevor wir loslegen können, muss natürlich `ggplot2` installiert sein und geladen werden:


``` r
library(ggplot2)
```

Im Kern bestehen Abbildungen in der Grammatik von `ggplot2` immer aus drei Komponenten:

  - Daten, die angezeigt werden sollen
  - Geometrie, die vorgibt welche Arten von Grafiken (Säulendiagramme, Punktediagramme, usw.) genutzt werden
  - Ästhetik, die vorgibt, wie die Geometrie und Daten aufbereitet werden (z.B. Farben)

In den folgenden Abschnitten werden wir versuchen, diese drei Komponenten so zu nutzen, dass wir informative und eventuell auch ansehnliche Abbildungen generieren.

#### Schichten

In `ggplot2` werden Grafiken nicht auf einmal mit einem Befehl erstellt, sondern bestehen aus verschiedenen Schichten. Diese Schichten werden meistens mit unterschiedlichen Befehlen erzeugt und dann so übereinandergelegt, dass sich am Ende eine Abbildung ergibt.

Die Grundschicht sind die Daten. Dafür haben wir im vorherigen Abschnitt `edu_exp` als Datensatz geladen. Zum Anfang sollten wir erst einmal einen Teildatensatz benutzen, um nicht direkt tausende von Datenpunkten auf einmal zu sehen. Gucken wir also einfach zehn Jahre in die Vergangenheit und nutzen das Jahr 2014: 


``` r
edu_2014 <- subset(edu_exp, Year == 2014)
```

Um diese Daten in eine Schicht der Grafik zu überführen, können wir sie einfach direkt als einziges Argument an den `ggplot`-Befehl übergeben:


``` r
ggplot(edu_2014)
```

![](/workshops/refresher/refresher-day2_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

Was entsteht ist eine leere Fläche. Wie bereits beschrieben, besteht eine Abbildung in `ggplot2` immer aus den drei Komponenten Daten, Geometrie und Ästhetik. Bisher haben wir nur eine festgelegt. Als erste Ästhetik sollten wir festlegen, welche Variablen auf den Achsen dargestellt werden sollen. Im letzten Semester war der erste Plot, den wir uns angeguckt hatten ein Balkendiagramm (über Tortendiagramme werden wie nie wieder reden). Bei diesen waren auf der x-Achse immer die Kategorien einer nominalskalierte Variable und auf der y-Achse die Häufigkeit dieser Kategorien dargestellt.  


``` r
ggplot(edu_2014, aes(x = Wealth))
```

![](/workshops/refresher/refresher-day2_files/figure-html/empty_bar1-1.png)<!-- -->

Ästhetik wird in `ggplot2` über den `aes`-Befehl erzeugt. Auf der x-Achse tauchen direkt die Ausprägungen der Variable auf, die wir dieser "Ästhetik" zugewiesen haben. Man sieht, dass hier einfach die Inhalte der Variable übernommen werden:


``` r
unique(edu_2014$Wealth)
```

```
## [1] "low_income"          "lower_middle_income" "upper_middle_income"
## [4] "high_income"
```
Die sind zum einen etwas unübersichtlich und zum anderen (besonders wichtig) nicht sonderlich schön. Deswegen sollten wir die Variable in einen Faktor umwandeln und etwas leserlichere Labels vergeben:


``` r
edu_2014$Wealth <- factor(edu_2014$Wealth, levels = c('low_income', 'lower_middle_income', 'upper_middle_income', 'high_income'),
  labels = c('Low', 'Lower Mid', 'Upper Mid', 'High'))

# Labels ausgeben lassen
levels(edu_2014$Wealth)
```

```
## [1] "Low"       "Lower Mid" "Upper Mid" "High"
```
Ich habe in diesem Fall nur vier der möglichen Ausprägungen als `levels` deklariert - das führt dazu, dass die ausgelassenen Ausprägungen im gerade entstandenen Faktor als fehlende Werte (`NA`) kategorisiert werden. 

Wenn wir jetzt noch einmal die Fläche aufspannen, sehen wir direkt eine etwas schönere Benennung:


``` r
ggplot(edu_2014, aes(x = Wealth))
```

![](/workshops/refresher/refresher-day2_files/figure-html/empty_bar2-1.png)<!-- -->
In diesem Schritt wird noch einmal deutlich, was ich gerade bereits angesprochen hatte:

> Daten müssen immer so aufbereitet sein, dass der grundlegende Datensatz sinnvoll benannte Variablen enthält und in dem Format vorliegt, in welchem wir die Daten visualisieren wollen.
>
> -- ich, vor wenigen Minuten

Wenn uns also etwas in unserer Abbildung nicht gefällt, ist der Ansatz in `ggplot` immer, die Daten anzupassen, weil Plots lediglich eine Darstellung dieser Daten sind. 

Jetzt fehlt uns noch die geometrische Form, mit der die Daten abgebildet werden sollen. Für die Geometrie-Komponente stehen in `ggplot2` sehr viele Funktionen zur Verfügung, die allesamt mit `geom_` beginnen. Eine Übersicht über die Möglichkeiten findet sich z.B. [hier](https://ggplot2.tidyverse.org/reference/#section-layer-geoms). Naheliegenderweise nehmen wir für ein Balkendiagramm _bar_ als die geometrische Form (`geom_bar`), die wir darstellen wollen. Neue Schichten werden in ihrer eigenen Funktion erzeugt und mit dem einfachen `+` zu einem bestehenden Plot hinzugefügt. Für ein Balkendiagramm sieht das Ganze also einfach so aus:


``` r
ggplot(edu_2014, aes(x = Wealth)) +
  geom_bar()
```

![](/workshops/refresher/refresher-day2_files/figure-html/simple_scatter-1.png)<!-- -->

Der immense Vorteil des Schichtens besteht darin, dass wir gleichzeitig mehrere Visualisierungsformen nutzen können. Das Prinzip bleibt das gleiche wie vorher: wir fügen Schichten mit dem `+` hinzu. Wir können also z.B. für Zeitverläufe einfach Punkte und Linien direkt miteinander kombinieren, oder für Abbildungen die Fehlerbalken direkt hinzufügen.

In der Abbildung sieht es zunächst ganz danach aus, als hätten hauptsächlich reiche Länder Daten bereitgestellt.

#### Plots als Objekte

Einer der Vorteile, die sich durch das Schichten der Abbildungen ergibt ist, dass wir Teile der Abbildung als Objekte definieren können und sie in verschiedenen Varianten wieder benutzen können. Das hilft besonders dann, wenn wir unterschiedliche Geometrie in einer gemeinsamen Abbildung darstellen wollen oder z.B. erst einmal eine Abbildung definieren wollen, bevor wir Feinheiten adjustieren.



``` r
basic <- ggplot(edu_2014, aes(x = Wealth))
```

In `basic` wird jetzt die *Anleitung* für die Erstellung der Grafik gespeichert. Erstellt wird die Grafik aber erst, wenn wir das Objekt aufrufen. Dabei können wir das Objekt auch mit beliebigen anderen Komponenten über `+` kombinieren:


``` r
basic + geom_bar()
```

![](/workshops/refresher/refresher-day2_files/figure-html/object_combos-1.png)<!-- -->

Damit die Beispiele im weiteren Verlauf auch selbstständig funktionieren, wird unten immer der gesamte Plot aufgeschrieben. Aber für Ihre eigenen Übungen oder Notizen ist es durchaus praktischer mit dieser Objekt Funktionalität zu arbeiten, um so zu umgehen, dass man immer wieder die gleichen Abschnitte aufschreiben muss.

#### Farben und Ästhetik {#Farben}

Oben wurde erwähnt, dass Ästhetik die dritte Komponente ist und als Beispiel wird die Farbe genannt. Das stimmt nicht immer: die Farbe der Darstellung muss nicht zwingend eine Ästhetik sein. Gucken wir uns zunächst an, wie es aussieht, wenn wir die Farbe der Darstellung ändern wollen:


``` r
ggplot(edu_2014, aes(x = Wealth)) +
  geom_bar(fill = 'blue', color = 'grey40')
```

![](/workshops/refresher/refresher-day2_files/figure-html/unnamed-chunk-9-1.png)<!-- -->
Bei Balken wird die Farbe des Balkens durch das Argument `fill` bestimmt - das Argument `color` bestimmt hingegen nur die Farbe des Rands. In diesem Fall haben alle Balken die Farbe geändert. Eine _Ästhetik_ im Sinne der `ggplot`-Grammatik ist immer abhängig von den Daten. Die globale Vergabe von Farbe ist also keine Ästhetik. Sie ist es nur, wenn wir sie von Ausprägungen der Daten abhängig machen. Das funktioniert z.B. so:


``` r
ggplot(edu_2014, aes(x = Wealth)) +
  geom_bar(aes(fill = Wealth), color = 'grey40')
```

![](/workshops/refresher/refresher-day2_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

Über den Befehl `aes` definieren wir eine Ästhetik und sagen `ggplot`, dass die Farbe der Balken von der Ausprägung auf der Variable `Wealth` abhängen soll. Die Farbe kann aber natürlich auch von jeder anderen Variable im Datensatz abhängen - dadurch können wir die Farbe als dritte Dimension in der Darstellung unserer Daten nutzen.

#### Gruppierte Abbildungen

Die Balken der Abbildung zeigen uns jetzt erst einmal an, wie viele arme, mittlere und reiche Länder im Datensatz enthalten sind. Interessant wird es aber vor allem dann, wenn wir verschiedene Variablen zueinander in Beziehung setzen - z.B. könnten wir den "Reichtum" der Länder mit deren geografischer Lage in Verbindung setzen. Diese ist sehr grob in der Variable `Region` abgebildet: 


``` r
# Tabelle der vier "Kontinent", die sich im Datensatz befinden, Amerikas zusammengefasst, kein Australien
table(edu_2014$Region)
```

```
## 
##   africa americas     asia   europe 
##       54       35       59       48
```
Die Variable ist als `character` im Datensatz abgelegt, was `ggplot` leider überhaupt nicht mag. Deswegen sollten wir sie zunächst in einen Faktor umwandeln:


``` r
edu_2014$Region <- factor(edu_2014$Region, levels = c('africa', 'americas', 'asia', 'europe'),
  labels = c('Africa', 'Americas', 'Asia', 'Europe'))
```

Jetzt können wir die Balken nach Regionen gruppieren:


``` r
ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40')
```

![](/workshops/refresher/refresher-day2_files/figure-html/stacked-barplot-1.png)<!-- -->
Per Voreinstellung wird in `ggplot` ein sogenannter "stacked" Barplot erstellt, bei dem die Balken übereinander gestapelt werden. Üblicher ist aber häufig die Darstellung nebeneinander. Dafür können wir z.B. das `position`-Argument anpassen:


``` r
ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40', position = 'dodge')
```

![](/workshops/refresher/refresher-day2_files/figure-html/grouped-barplot-1.png)<!-- -->


### Abbildungen anpassen

Die Abbildungen, die wir bisher erstellt haben, nutzen alle das in `ggplot2` voreingestellte Design. Auch wenn es sicherlich einen theoretisch sehr gut fundierten Grund gibt, dass der Hintergrund der Abbildung in einem demotivierenden Grauton gehalten sein sollte, gibt es Designs, die man schöner finden kann. Im folgenden gucken wir uns an, wie man seine Abbildungen nach seinen eigenen Vorlieben anpassen kann.

#### Themes

In `ggplot2` werden die Grundeigenschaften von Abbildungen in "Themes" zusammengefasst. Mit `?theme_test` erhält man eine Auflistung aller Themes, die von `ggplot2` direkt zur Verfügung gestellt werden. Diese 10 Themes sind erst einmal sehr konservative Einstellungen für die Eigenschaften von Grafiken. Sehen wir uns meinen persönlichen Favoriten, das sehr dezente `theme_minimal()` an. Dazu legen wir die Grundanleitung der Abbildung für 2014 zunächst in einem Objekt ab (das ist nicht notwendig, soll nur im Folgenden den Fokus auf die Themes legen):


``` r
bars <- ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40', position = 'dodge')
```

Um das Theme einer Abbildung zu verändern, können Sie es - wie Geometrie - mit dem `+` hinzufügen.


``` r
bars + theme_minimal()
```

![](/workshops/refresher/refresher-day2_files/figure-html/theme-minimal-1.png)<!-- -->

Gegenüber der Voreinstellung (`theme_grey`) verändert sich hier, dass der Hintergrund jetzt nicht mehr grau ist und das Raster stattdessen in Hellgrau gehalten ist.Die Eigenschaften der Abbildung hinsichtlich des Aussehens von Hintergrund usw. bleiben davon aber unberührt.

Über die von `ggplot2` direkt mitgelieferten Themes hinaus gibt es beinahe unzählige weitere Pakete, in denen vordefinierte Themes enthalten sind. Eine der beliebtesten Sammlungen findet sich im Paket `ggthemes`.


``` r
install.packages('ggthemes')
library(ggthemes)
```



Dieses Paket liefert (neben anderen optischen Erweiterungen) über 20 neue Themes, die häufig den Visualisierungen in kommerzieller Software oder in bestimmten Publikationen nachempfunden sind. In Anlehnung an weit verbreitete Grundprinzipien zur Grafikgestaltung nutzen wir als allererstes natürlich das nach Tuftes "maximal Data, minimal Ink"-Prinzip erstellte Theme:


``` r
bars + theme_tufte()
```

![](/workshops/refresher/refresher-day2_files/figure-html/tufte-1.png)<!-- -->

Wenn uns ein Theme so gefällt, dass wir dieses für alle Plots benutzen wollen, können wir es mit `theme_set()` als neue Voreinstellung definieren. Wie gesagt, mag ich den minimalistischen Stil von `theme_minimal()`, weil er wenig von den Daten ablenkt:


``` r
theme_set(theme_minimal())
```

Dieser Befehl sollte allerdings mit Vorsicht genossen werden, weil er globale Einstellungen in `R` verändert, ohne davor zu warnen, dass eventuell vorherige Einstellungen verloren gehen. Zur Sicherheit können wir mit 


``` r
theme_set(theme_grey())
```

jederzeit zurück in die ursprünglichen Voreinstellungen.

#### Beschriftung

Eine der wichtigsten Komponenten jeder Abbildung ist die Beschriftung. Nur wenn ausreichend gut gekennzeichnet ist, was wir darstellen, können wir darauf hoffen, dass die Information vermittelt wird, die wir vermitteln wollen. Zunächst ist es sinnvoll, die Achsen ordentlich zu beschriften. Per Voreinstellung werden hierzu die Namen der Variablen genutzt. Wir können also eine nützliche Beschriftung auch dadurch erzwingen, dass wir die Variablen im Datensatz ordentlich benennen. Besonders wenn die Achsen aber Zusatzinformationen (wie z.B. "(in %)") enthalten sollen, ist es aber unumgänglich die Benennung hinterher zu ergänzen. Darüber hinaus kann es sinnvoll sein, einer Grafik Titel und Untertitel zu geben.

Für unsere Abbildung wäre es sinnvoll, neben einem Titel auch eine aussagekräftigere Beschriftung der Achsen und der Legende vorzunehmen. 


``` r
ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40', position = 'dodge') +
  labs(x = 'Country Wealth (GDP per Capita)',
    y = 'Count',
    fill = 'World Region') +
  ggtitle('Categorization of Countries in GapMinder Data', '(Data for 2014)')
```

![](/workshops/refresher/refresher-day2_files/figure-html/labeled-1.png)<!-- -->

Die `labs`-Funktion ermöglicht uns das Vergeben von *Labels* für die Variablen, die wir als Ästhetiken in `aes()` festgehalten haben. `x` ersetzt also den Variablennamen von `Primary`, der per Voreinstellung zur Beschriftung herangezogen wird. Das Gleiche gilt dann auch für `y` und `color` ersetzt den Titel der Legende. Die `ggtitle`-Funktion nimmt zwei Argumente entgegen: den Titel und einen Untertitel.

Damit wir unsere Grafik in späteren Abschnitten wiederverwenden können, legen wir sie hier wieder in einem Objekt ab:


``` r
bars <- ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40', position = 'dodge') +
  labs(x = 'Country Wealth (GDP per Capita)',
    y = 'Count',
    fill = 'World Region') +
  ggtitle('Categorization of Countries in GapMinder Data', '(Data for 2014)')
```

Eine weitere Möglichkeit um Achsenbeschriftungen hinzuzufügen und darüberhinaus auch weitere Charakteristika der Achsen zu verändern ist über die Funktionen der Familie `scale_*aesthetic*_*specification*`. Anpassbar ist z.B.:
- Achsentitel
- Achsenbreaks
- Achsenlimits
- Achsenbeschriftung
- Achsenpadding
- (und noch vieles mehr: alpha, color, fill, shape, linesize, size, etc.


``` r
ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40', position = 'dodge') +
  scale_y_continuous(name = 'Count',
                     limits = c(0,40),
                     breaks = seq(0,40,5)
                     ) + 
  scale_x_discrete(name = 'Country Wealth (GDP per Capita)') +
  ggtitle('Categorization of Countries in GapMinder Data', '(Data for 2014)')
```

![](/workshops/refresher/refresher-day2_files/figure-html/unnamed-chunk-19-1.png)<!-- -->
Die Auswahl einer Bearbeitungsmöglichkeit bleibt einem selbst überlassen. Tipp: Wenn nur wenig bearbeitet werden soll (z.B. Beschriftung und Achsengrenzen) ist die Lösung mit `labs`und `lim` einfacher.

#### Farbpaletten

Bisher haben wir gesehen, wie die "Rahmenbedingungen" der Grafik mit unserem Theme angepasst werden können - also wie Titel und Hintergrund geändert werden oder wir festlegen, welche Achsen wie beschriftet werden. Was dabei bisher konstant war, war die Farbgebung, die aufgrund der Gruppierungsvariable `Region` zustande kommt. Damit ist jetzt Schluss.

In `ggplot2` wird die Vergabe von Farben in der Ästhetik anhand von zwei Dingen unterschieden: der Geometrie und dem Skalenniveau der Variable, die die Färbung vorgibt. Kontinuierliche Variablen (Variablen, die in `R` als `numeric` definiert sind) werden anhand eines Blau-Farbverlaufs dargestellt, diskrete Variablen (Variablen, die in `R` als `factor` definiert sind) anhand eines vordefinierten Schemas unterschiedlicher Farben. Dieses Schema ist das [Brewer Farbschema](http://colorbrewer2.org/), welches ursprünglich für Kartendarstellungen entwickelt wurde. 

Nehmen wir an, dass wir unsere Abbildung irgendwo drucken möchten - Farbdruck ist wahnsinnig teuer. Um mit Grautönen zu arbeiten, können wir z.B. `scale_fill_grey` benutzen:


``` r
bars + scale_fill_grey()
```

![](/workshops/refresher/refresher-day2_files/figure-html/unnamed-chunk-20-1.png)<!-- -->

Das bei den [Themes](#Themes) erwähnte Paket `ggthemes` enthält auch weitere Farbpaletten, die Sie nutzen können, um Ihren Plot nach Ihren Vorlieben zu gestalten. Wichtig ist beispielsweise, dass es eine Palette namens `colorblind` hat, die Farben so auswählt, dass sie auch von Personen mit Farbblindheit differenziert werden können. Wir können aber natürlich auch unsere ganz eigene Farbpalette definieren - z.B. die offizielle Farbpalette des Corporate Designs der Goethe Universität, wie sie auch in den Lehrveranstaltungen des Bachelors und Masters benutzt wird.

Für diese Palette können wir zunächst in einem Objekt die Farben festhalten, die wir benötigen. In `ggplot2` ist es dabei am gängigsten, Farben entweder [über Worte auszuwählen](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf) oder via [hexadezimaler Farbdefinition](https://www.color-hex.com/) zu bestimmen. Für die fünf Farben, die von der Corporate Design Abteilung der Goethe Uni definiert werden ergibt sich folgendes Objekt:


``` r
gu_colors <- c('#00618f', '#e3ba0f', '#ad3b76', '#737c45', '#c96215')
```

Dieses Objekt können wir dann nutzen, um mit `scale_fill_manual` selbstständig Farben zuzuweisen:


``` r
bars + scale_fill_manual(values = gu_colors)
```

![](/workshops/refresher/refresher-day2_files/figure-html/unnamed-chunk-22-1.png)<!-- -->

Die Zuordnung der Farben erfolgt anhand der Reihenfolge in `gu_colors` und der Reihenfolge der Ausprägungen von `Region`. Letztere ist - wie sie bestimmt festgestellt haben - alphabetisch. Wie häufig in `ggplot2` können Sie die Daten ändern (also mit `relevel` die Reihenfolge der Ausprägungen ändern) um Veränderungen in der Darstellung zu bewirken.

### Verschiedene Plots
Im Folgenden werden noch ein paar Beispiele für den Einsatz von `ggplots`dargestellt, um euch zu zeigen, welche Möglichkeiten sich so bieten. Wie bereits zum Anfang erwähnt, gibt es unzählige Quellen mit Tipps und Infos zu den Möglichkeiten. Eine hilfreiche Übersicht möglicher Darstellungsformen in Abhängigkeit eurer Daten findet ihr bei [Data to Viz] (https://www.data-to-viz.com/). 

### Deskriptivstatistik

Die Verteilung eines numerischen Variable könnt ihr per Boxplot... 

``` r
ggplot(
  data = edu_2014,
  aes(y = Index)
  ) +
  geom_boxplot() +
  theme_minimal() +
  labs(y = 'Education Index des United Nations Development Programme')
```

```
## Warning: Removed 4 rows containing non-finite outside the scale range
## (`stat_boxplot()`).
```

![](/workshops/refresher/refresher-day2_files/figure-html/unnamed-chunk-23-1.png)<!-- -->
oder Histogramm...

``` r
ggplot(
  data = edu_2014,
  aes(x = Index)
  ) +
  geom_histogram(fill = "lightgrey", color = "white") +
  theme_minimal() +
  scale_x_continuous(name = 'Education Index des United Nations Development Programm',
                     limits = c(0,1),
                     breaks = seq(0,1,0.1)) + 
  scale_y_continuous(name = 'Anzahl',
                     limits = c(0,20),
                     breaks = seq(0,20,5))
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

```
## Warning: Removed 5 rows containing non-finite outside the scale range
## (`stat_bin()`).
```

```
## Warning: Removed 2 rows containing missing values or values outside the scale range
## (`geom_bar()`).
```

![](/workshops/refresher/refresher-day2_files/figure-html/unnamed-chunk-24-1.png)<!-- -->
... oder beispielsweise als Density-Plot (gut um die Verteilung, Schiefe und Kurtosis zu betrachten) dargestellt werden:

``` r
ggplot(
  data = edu_2014,
  aes(x = Index)
  ) +
  geom_density() +
  theme_minimal() +
  labs(x = 'Education Index des United Nations Development Programme')
```

```
## Warning: Removed 4 rows containing non-finite outside the scale range
## (`stat_density()`).
```

![](/workshops/refresher/refresher-day2_files/figure-html/unnamed-chunk-25-1.png)<!-- -->


***

## t-Test {#tTest}

### Was erwartet uns?
Nun wollen wir uns unserem ersten inferenzstatistischen Test in R widmen. Um eine Aussage darüber zu treffen ob ein statistisch signifikanter Unterschied in dem Mittelwert unserer Stichprobe und der Population besteht haben Sie im Bachelor wohl den t-Test kennengelernt. Genauer den Einstichproben t-Test. Neben diesem behandeln wir später noch die t-Tests für den Mittelwertsvergleich von unabhängigen und abhängigen Stichproben.

### Daten einlesen

Der Datensatz den wir für die Analyse benutzen stammt aus der 3. Teilstudie von Firschlich et al. (2021). Hier wurde in einem experimentellen Design untersucht, welche Auswirkungen neutrale vs. ideologische geladene Berichterstattung auf Wahrnehmung und Glaubhaftigkeitseinschätzung eines Nachrichtenbeitrags über einen deutschen Politiker hat. Es wurde außerdem noch die Verschwörungsmentalität und das Gefühl der Marginalisierung erhoben.


``` r
source("https://pandar.netlify.app/daten/Data_Processing_distort.R")

# Kategoriale Variablen in Faktoren umwandeln
distort$east <- factor(distort$east,
                       levels = c(0, 1),
                       labels = c("westdeutsch", "ostdeutsch"))

distort$stud <- factor(distort$stud,
                       levels = c(0, 1),
                       labels = c("Nicht Studi", "Studi"))
```

Weitere Informationen zu den Variablen finden Sie [hier](/daten/datensaetze/#distorted-news).

### Einstichproben t-Test

#### Formeln {#Formeln}

Der t-Test basiert auf folgender Formel:
  
$$t_{emp} = \frac{\bar{x} - {\mu}}{\hat\sigma_{\bar{x}}}$$
wobei sich der Standardfehler (*SE*)  des Mittelwerts wie folgt zusammensetzt:
  
$$\hat\sigma_{\bar{x}} = {\frac{{\hat\sigma}}{\sqrt{n}}}$$

Da die Standardabweichung in der Population nicht bekannt ist, muss diese mittels Nutzung der Standardabweichung der Stichprobe geschätzt werden. Dies funktioniert über die Funktion `sd()`.

#### Hypothese



Als Sie die demographischen Daten ihrer Stichprobe betrachten fällt ihnen auf das die Gruppe der Studierenden mit einem Anteil von 29.535865% überrepräsentiert ist. Außerdem haben Sie erst letztens in einer Studie gelesen das Studierende eine unterdurchschnittlich geringen Verschwörungsglauben aufweisen.
Daher haben Sie die Vermutung dass die Stichprobe die sie erhoben haben eine signifikant niedrigere Verschwörungsmentalität (`cm`) aufweist als die Population ($\mu = 5.4$)
Unsere Forschungshypothese lautet nun wie folgt:

$H_0$: Die mittlere Verschwörungsmentalität unserer Stichprobe ist gleich oder höher als die Verschöwrungsmentailität der Population.

$H_1$: Die mittlere Verschwörungsmentalität unserer Stichprobe ist kleiner als die Verschöwrungsmentailität der Population.

In der mathematischen Hypothesennotation:

$$H_0: \mu_0 \leq \mu_1$$
  
$$H_1: \mu_0 > \mu_1$$

#### Deskriptiv {#desk}

Bevor wir in die inferenzstatistische Analyse einsteigen, ist es immer gut, sich einen Überblick über die deskriptiven Werte zu verschaffen. Wir können uns nun unser zuvor erworbenes Wissen über Pakete zu nutze machen um einen effizienten deskriptivstatistischen Überblick zu erhalten. Hier am Beispiel von `psych` und `skimr`.


``` r
# Pakete einlesen
library(psych)
library(skimr)

# Deskriptivstatistik
psych::describe(distort$cm)
```

```
##    vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 474  4.8 1.58      5     4.9 1.48   1   7     6 -0.46    -0.58 0.07
```

``` r
skimr::skim(distort$cm)
```


Table: Data summary

|                         |           |
|:------------------------|:----------|
|Name                     |distort$cm |
|Number of rows           |474        |
|Number of columns        |1          |
|_______________________  |           |
|Column type frequency:   |           |
|numeric                  |1          |
|________________________ |           |
|Group variables          |None       |


**Variable type: numeric**

|skim_variable | n_missing| complete_rate| mean|   sd| p0| p25| p50| p75| p100|hist  |
|:-------------|---------:|-------------:|----:|----:|--:|---:|---:|---:|----:|:-----|
|data          |         0|             1|  4.8| 1.58|  1|   4|   5|   6|    7|▂▂▆▆▇ |
#### Voraussetzungen

Inferenzstatistische Tests haben für ihre Durchführung immer Voraussetzungen. Diese können in Anzahl und Art variieren. Verletzungen von Voraussetzungen verzerren verschiedene Aspekte der Testung. Für manche Verletzungen gibt es Korrekturen, andere führen dazu, dass man ein anderes Verfahren wählen muss. Wir werden uns im Laufe des Semesters mit vielen Voraussetzungen beschäftigen. Für den Einstichproben-t-Test ist die Liste der Voraussetzungen nicht sehr lange:

  
1. mindestens intervallskalierte abhängige Variable
2. Bei *n* < 30 : Normalverteilung der abhängigen Variable in der Population.
  
Die erste Voraussetzung lässt sich nicht mathematisch sondern theoretisch prüfen. Sie ist natürlich essentiell, da wir hier mit Mittelwerten und Varianzen rechnen und wir bereits gelernt haben, dass diese erst ab dem Intervallskalenniveau genutzt werden sollten. Wir haben außerdem gelernt, dass Skalenwerte häufig als intervallskaliert angenommen werden. Da Verschöwrungsmentalität (`cm`) ein solcher Skalenwert ist, können wir die Voraussetzung als gegeben annehmen,

Kommen wir zu der zweiten Voraussetzung. Für die inferenzstatistische Testung bestimmen wir die Position unseres empirischen Mittelwerts in der Stichprobenkennwerteverteilung der Mittelwerte. Für diese nehmen wir eine spezifische Form an - sie soll der $t$-Verteilung (übergehend bei $n \rightarrow \infty$ in eine $z$-Verteilung) folgen. Für diese Annahme ist die Normalverteilung der Variablen in unserer Stichprobe eine hinreichende Voraussetzung. Das heißt, wenn diese gegeben ist, folgt die Stichprobenkennwerteverteilung der von uns angenommenen Form. Wie wir später besprechen werden, ist die Normalverteilung aber keine notwendige Voraussetzung. Zunächst wollen wir uns die optische Prüfung der Normalverteilung vornehmen später wird auch noch die inferenzstatistische Testungen folgen. Die einfachste optische Prüfung ist das Zeichnen eines QQ-Plots.

Dabei hilft uns das zuvor installierte `car` Paket.


``` r
# Paket einlesen
library(car)

# QQ-Plot zeichnen
car::qqPlot(distort$cm)
```

![](/workshops/refresher/refresher-day2_files/figure-html/unnamed-chunk-29-1.png)<!-- -->

```
## [1] 63 80
```

Auf der x-Achse sind diejenige Positionen notiert, die unter Gültigkeit der theoretischen Form der Normalverteilung zu erwarten wären. Auf der y-Achse wird die beobachtete Position eines Messwerts abgetragen.

Entspricht nun unsere empirische Datenmenge der angenommenen Normalverteilung perfekt, würden alle Punkte auf der Geraden in der Mitte liegen. Auch hier gilt natürlich, dass die Bewertung letztlich eine gewisse Subjektivität hat. Die Punkte sollten nicht zu weit von der Geraden entfernt liegen.

Nach dem Plot zu urteilen könnte eine Verletzung der Normalverteilungsannahme hier vorliegen. Allerdings können wir uns behelfen und den Test trotzdem durchführen. Die Normalverteilungsannahme darf nämlich verletzt sein, wenn die Stichprobe mindestens 30 Personen umfasst. In diesen Fällen wird das inferenzstatistische Ergebnis nicht verzerrt. Dann gilt der *zentrale Grenzwertsatz*: Die Stichprobenkennwertverteilung der Mittelwerte nähert sich einer Normalverteilung an, unabhängig davon wie das Merkmal selbst in der Population verteilt ist. Die Stichprobengröße von 30 ist allerdings nur eine Daumenregel - bei starken Verletzungen sollte man sich auch überlegen, ob der Mittelwert der beste Repräsentant für die mittlere Ausprägung der Variable darstellt.

#### `t.test`-Funktion

Wir könnten nun die zuvor berechneten [deskriptivstatistischen Werte](#desk) in die weiter oben gezeigte [Formel](#Formeln) einsetzen und so den Einstichproben t-Test berechnen. Zum Glück schafft R hier jedoch mit der `t.test()`-Funktion abhilfe.


``` r
t.test(distort$cm,
       mu = 5.4,
       alternative = "less",
       conf.level = 0.95)
```

```
## 
## 	One Sample t-test
## 
## data:  distort$cm
## t = -8.2677, df = 473, p-value = 6.962e-16
## alternative hypothesis: true mean is less than 5.4
## 95 percent confidence interval:
##      -Inf 4.919266
## sample estimates:
## mean of x 
##  4.799578
```



Die Funktion braucht im Einstichprobenfall neben den Werten der Stichprobe noch das Argument `mu`, in dem der Populationsmittelwert festgehalten wird. `alternative` gibt an, ob wir in unseren Hypothesen eine Richtung haben (`two.sided` für ungerichtete Hypothesen, `less` oder `greater` für gerichtete Hypothesen). Da unsere Hypothese $H_1$ den Stichprobenmittelwert als kleiner als den Populationsmittelwert annimmt, wählen wir in diesem Fall `less`. In `conf.level` geben wir $1 - \alpha$ mit Hilfe dieses Arguments bestimmt R das Konfidenzintervall.

Im Output sind bereits die wichtigsten Informationen enthalten. Wir erhalten den empirischen t-Wert $t_{emp}$ = -8.267669. Außerdem können wir auf Grund des ausgegebenen p-Werts erkennen das unser Ergebnis signifikant ist. Die Freiheitsgrade (`df`) werden auch berichtet.

#### Effektstärke

Letztlich wollen wir uns nur kurz dem Effektstärkemaß des t-Tests widmen, Cohen's d. Auch hier können wir uns dank eine R Funktion (`cohen.d()`) aus dem `effsize` Paket die Formel sparen.


``` r
library(effsize)

effsize::cohen.d(distort$cm,
                 f = NA,
                 mu = 5.4,
                 conf.level = 0.95)
```

```
## 
## Cohen's d (single sample)
## 
## d estimate: -0.3797466 (small)
## Reference mu: 5.4
## 95 percent confidence interval:
##      lower      upper 
## -0.5618764 -0.1976168
```



Die Funktion nimmt ähnliche Argumente entgegen wie die `t.test()`-Funktion. Neu ist die Besonderheit das wir `f` = `NA` setzen. Aus der Argument Beschreibung der Funktion entnehmen wir für f "if NA a single sample effect size is computed" und da das Argument per default nicht auf `NA` steht müssen wir dies selbst noch angeben.

Die Effektstärke bei unserer Hypothese beträgt $d$ = -0.3797466.


### t-Test für Unabhängige Stichproben

Nachdem wir uns zuletzt mit dem Unterschied zwischen dem Mittelwert einer Stichprobe und einem von uns theoretisch postulierten Wert ($\mu$) auseinandergesetzt haben, fokussieren wir uns nun auf Unterschiede zwischen zwei Gruppen. Hierbei muss zwischen unabhängigen und abhängigen Stichproben unterschieden werden - um den ersten Fall geht es uns hier, den Zweiten gucken wir uns später an.

Den Einstichproben t-Test haben wir noch etwas ausführlicher behandelt, da wir aber nun die `t.test()`-Funktion kennen und lieben gelernt haben reduzieren wir die Inhalte für den (un-)abhängigen t-Test auf das Nötigste.

#### Hypothese

Die beim Schreiben dieses Artikels erst kürzlich stattgefundenen Landtagswahlen in drei ostdeutschen Bundesländern haben in den Medien erneut Fragen über Rechtspopulismus und den Graben zwischen Ost- und Westdeutschen aufgeworfen.

Als Autoren wollen wir zu diesen Themen keine politische Meinung darstellen, die folgende Hypothese ist mit einem Funken Blauäugigkeit zu sehen.

Nach einem Marathon an Spiegel Dokumentationen zu dem Themenkomplex "neue Rechte" haben Sie gelernt das Rechtspopulisten schnell Hand in Hand mit sogenannten Verschwörungstheoretikern gehen. Da sich eine bestimmte teils gesichert rechtsextreme Partei großer Beliebtheit in den östlichen Landtagswahlen erfreute wollen Sie ihre Hypothese nun testen.

$H_0$: Ostdeutsche weisen im Mittel eine gleiche oder geringere Verschwörungsmentalität auf als Westdeutsche.

$H_1$: Ostdeutsche weisen im Mittel eine höhere Verschwörungsmentalität auf als Westdeutsche.

#### Voraussetzungen

Die Voraussetzungen des t-Tests für unabhängige Stichproben lauten:

1. Beide Stichproben sind unabhängig voneinander.
2. Die einzelnen Messwerte innerhalb der zwei Gruppen sind unabhängig voneinander.
3. Die abhängige Variable ist in der Population der beiden Gruppen normalverteilt.
4. Die Varianz der abhängigen Variable ist innerhalb der Gruppen gleich (Homoskedastizität).

Die ersten beiden Voraussetzungen lassen sich nicht rechnerisch überprüfen. Unser Experimentaldesign gibt vor ob diese erfüllt sind. In unserem Fall sind sie das.

Die letzten beiden Voraussetzungen können wir rechnerisch überprüfen. Bei dem Einstichproben t-Test hatten wir erwähnt das die Normalverteilungsannahme auf mit inferenzstatistischen Tests überprüft werden kann. Einer dieser Test ist der Shapiro-Wilk-Test den wir in R mit der fast gleichnamigen Funktion (`shapiro.test()`) ausführen können.


``` r
# AV Spalte für die beiden Gruppen auftrennen
west_data <- subset(distort, subset = east == "westdeutsch")
ost_data <- subset(distort, subset = east == "ostdeutsch")

shapiro.test(west_data$cm)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  west_data$cm
## W = 0.95215, p-value = 3.157e-10
```

``` r
shapiro.test(ost_data$cm)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  ost_data$cm
## W = 0.90941, p-value = 0.0001466
```

Der Test fällt in beiden Gruppen signifikant aus. Demnach müssten wir die Normalverteilungsannahme verwerfen. Da wir uns aber an den *zentralen Grenzwertsatz* erinnern und in beiden Gruppen $n > 30$ können wir auch hier die Annahme als gegeben ansehen.

Übrig bleibt die Homoskedastizitätsannahme die wir mit Hilfe des levene-Tests überprüfen können. Dafür findet sich im `car` Paket die Funktion `leveneTest()`.


``` r
# Paket einlesen
library(car)     #wenn nicht schon geschehen

# Levene Test
car::leveneTest(distort$cm ~ distort$east)
```

```
## Levene's Test for Homogeneity of Variance (center = median)
##        Df F value Pr(>F)
## group   1  0.0186 0.8916
##       472
```

Zunächst müssen wir feststellen, der Test ist nicht signifikant und die Varianz der abhängigen Variable in den beiden Gruppen somit gleich. Die Annahme wird als gegeben angesehen.

In der Funktion haben wir eine besondere Formulierung der Argumente vorgenommen. Vereinfacht könnte man sagen: $AV \sim UV$
Diese Art der Formulierung können wir immer dann nutzen wenn wir einen Datensatz (`distort`) haben bei dem in einer Spalte alle Werte unserer abhängigen Variable (`cm`) stehen und eine weitere Spalte unsere Stichprobe in Gruppen einteilt (`east`).

#### `t.test`

Da wir die Voraussetzungen überprüft haben können wir nun mit dem Test fortfahren.


``` r
t.test(distort$cm ~ distort$east, # abhängige Variable ~ unabhängige Variable
       alternative = "less",      # die erste Ausprägung "westdeutsch" soll "less" Verschwörungsmentalität aufweisen
       var.equal = TRUE,          # Homoskedastizität liegt vor
       conf.level = 0.95)         # alpha = 5%
```

```
## 
## 	Two Sample t-test
## 
## data:  distort$cm by distort$east
## t = -1.9973, df = 472, p-value = 0.02318
## alternative hypothesis: true difference in means between group westdeutsch and group ostdeutsch is less than 0
## 95 percent confidence interval:
##        -Inf -0.0730321
## sample estimates:
## mean in group westdeutsch  mean in group ostdeutsch 
##                  4.741422                  5.159091
```



Anhand der Ergebnisse können wir folgende Aussage treffen: Ostdeutsche weisen eine signifkiant niedrigere Verschwörungsmentalität als Westdeutsche auf ($t$(472) = -1.9973348, $p$ = 0.0231812).

#### Effektstärke


``` r
effsize::cohen.d(distort$cm ~ distort$east,
                 conf.level = 0.95)
```

```
## 
## Cohen's d
## 
## d estimate: -0.2649952 (small)
## 95 percent confidence interval:
##        lower        upper 
## -0.526248710 -0.003741679
```


### t-Test für Abhängige Stichproben

Nachdem wir uns mit unabhängige Stichproben beschäftigt haben wollen wir uns diesmal mit abhängigen Stichproben beschäftigen. Anwendungen dafür in der Praxis sind beispielsweise Zwillinge, Paare oder auch Messwiederholungen. Im Folgenden betrachten wir Messwiederholungen, aber die gezeigten Methoden sind auf andere Arten abhängiger Stichproben übertragbar.

#### Daten einlesen

Zunächst laden wir einen neuen Datensatz ein. Die Daten stammen von Psychologiestudierenden der Kohorte WiSe 23/24. Der Fragebogen erfasste Daten zur aktuellen Stimmung, Persönlichkeit (Big5), dem Studium sowie demografische Daten. Außerdem wurde für manche Skalen ein zweiter Messzeitpunkt erhoben.


``` r
load(url('https://pandar.netlify.app/daten/fb23.rda'))

# Rekodierung invertierter Items
fb23$mdbf4_pre_r <- -1 * (fb23$mdbf4_pre - 4 - 1)
fb23$mdbf11_pre_r <- -1 * (fb23$mdbf11_pre - 4 - 1)
fb23$mdbf3_pre_r <-  -1 * (fb23$mdbf3_pre - 4 - 1)
fb23$mdbf9_pre_r <-  -1 * (fb23$mdbf9_pre - 4 - 1)
fb23$mdbf5_pre_r <- -1 * (fb23$mdbf5_pre - 4 - 1)
fb23$mdbf7_pre_r <- -1 * (fb23$mdbf7_pre - 4 - 1)

# Berechnung von Skalenwerten
fb23$wm_pre  <- fb23[, c('mdbf1_pre', 'mdbf5_pre_r', 
                        'mdbf7_pre_r', 'mdbf10_pre')] |> rowMeans()
fb23$gs_pre  <- fb23[, c('mdbf1_pre', 'mdbf4_pre_r', 
                        'mdbf8_pre', 'mdbf11_pre_r')] |> rowMeans()
fb23$ru_pre <-  fb23[, c("mdbf3_pre_r", "mdbf6_pre", 
                         "mdbf9_pre_r", "mdbf12_pre")] |> rowMeans()
```

Wie Sie sehen haben wir noch ein paar Items rekodiert um dann entsprechende Skalenwerte zu bilden.

#### Hypothese

Zwischen den beiden Messzeitpunkten liegt der Besuch des ersten Statistik Praktikums der Befragten. Ohne jeglichen Hintergedanken stellen Sie sich die Frage ob sich die Stimmung der Studierenden (`gs`) zwischen den zwei Messzeitpunkten verändert hat.

$H_0$: Die Stimmung der Psychologiestudierenden ist gleich über die beiden Messzeitpunkte hinweg.

$H_1$: Die Stimmung der Psychologiestudierenden hat sich über die beiden Messzeitpunkte verändert.

#### Voraussetzungen

Die Voraussetzungen des t-Tests für abhängige Stichproben lauten:

1. Die abhängige Variable ist intervallskaliert.
2. Die Messwertpaare sind unabhängig voneinander.
3. Die Differenzvariable d ist in der Population normalverteilt.

Auch hier lassen sich die ersten beiden Voraussetzungen nicht rechnerisch überprüfen. Unser Experimentaldesign gibt vor ob diese erfüllt sind. In unserem Fall sind sie das.

Die dritte Voraussetzung können wir rechnerisch überprüfen. Die Differenzvariable d wird berechnet in dem wir die Werte aller Personen auf `gs_pre` jeweils von ihren `gs_post` Werten abziehen. Anschließende wenden wir erneut den Shapiro-Wilk-Test an.


``` r
fb23$gs_diff <- fb23$gs_post - fb23$gs_pre

shapiro.test(fb23$gs_diff)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fb23$gs_diff
## W = 0.9608, p-value = 0.0003585
```

Der Test fällt signifikant aus. Auch hier können wir jedoch auf Basis des *zentralen Grenzwertsatzes* mit dem Test fortfahren. Zunächst schauen wir uns die Normalverteilung noch einmal optisch an.


``` r
car::qqPlot(fb23$gs_diff)
```

![](/workshops/refresher/refresher-day2_files/figure-html/unnamed-chunk-41-1.png)<!-- -->

```
## [1]  7 81
```

Der QQ-Plot lässt erkennen das es Ausreißer an beiden Extremen gibt die wahrscheinlich dazu geführt haben das der Shpiro-Wilk-Test signifikant ausfiehl. Wir fahren dennoch wie zuvor über den *zentralen Grenzwertsatz* begründet mit dem Test fort.

#### `t.test`


``` r
t.test(fb23$gs_post, fb23$gs_pre,
       paired = TRUE,
       alternative = "two.sided",
       conf.level = 0.95)
```

```
## 
## 	Paired t-test
## 
## data:  fb23$gs_post and fb23$gs_pre
## t = 1.5647, df = 145, p-value = 0.1198
## alternative hypothesis: true mean difference is not equal to 0
## 95 percent confidence interval:
##  -0.01802428  0.15501058
## sample estimates:
## mean difference 
##      0.06849315
```



Im Vergleich mit dem t-Test für unabhängige Stichproben haben wir das Argument `paired` auf `TRUE` gesetzt, per default ist es auf `FALSE`. Damit sagen wir der Funktion das es sich um abhängige Messungen handelt, den Rest erledigt R.

Anhand der Ergebnisse können wir nun folgende Aussage treffen: Die Stimmung der Psychologiestudierenden vor und nach dem Besuch des ersten Statistik Praktika unterscheidet sich nicht signifikant. ($t$(145) = 1.5647014, $p$ = 0.1198328).

#### Effektstärke


``` r
effsize::cohen.d(fb23$gs_post, fb23$gs_pre, # Messzeitpunkte
                 paired = TRUE,             # abhängige Stichproben
                 conf.level = 0.95,         # alpha = 5%
                 within = FALSE,            # Korrektur die wir nicht brauchen         
                 na.rm = TRUE)              # da NAs in den Daten vorkommen
```

```
## 
## Cohen's d
## 
## d estimate: 0.1294956 (negligible)
## 95 percent confidence interval:
##      lower      upper 
## -0.0340734  0.2930646
```

***
