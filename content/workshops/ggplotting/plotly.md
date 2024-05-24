---
title: "plotly"
type: post
date: '2021-07-06'
slug: plotly
categories: ["ggplotting"]
tags: ["ggplotting"]
subtitle: 'Interaktive Grafiken aus ggplotly'
summary: '' 
authors: [schultze] 
weight: 5
lastmod: '2024-05-24'
featured: no
banner:
  image: "/header/vr_biking.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1173944)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /workshops/ggplotting/plotly
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /workshops/ggplotting/plotly.R
output:
  html_document:
    keep_md: true
---


In den bisherigen Sitzungen zu ggplotting hatten wir gesehen, wie man [einfache Grafiken erstellt](/post/ggplotting-intro) und so [anpasst](/post/ggplotting-themes), dass sie z.B. dem corporate design entsprechen oder sogar ansehnlich für den Druck sind. Uns aus dem leicht staubigen Gedanken lösend, dass Datendarstellungen am Ende gedruckt werden müssen, hatten wir uns auch noch damit befasst, wie man [Grafiken so animiert](/post/ggplotting-gganimate), dass man in der Lage ist, z.B. Veränderungen über die Zeit zu verdeutlichen. In diesem letzten großen Abschnitt soll es uns darum gehen, die aktive Rolle in der Datendarstellung nicht allein beim Ersteller oder der Erstellerin zu verorten, sondern auch den Rezipientinnen und Rezipienten die aktive Auseinandersetzung mit der Datenlage zu ermöglichen. Dafür sehen wir uns an, wie man mit `plotly` interaktive Grafiken erstellt.

## Ein bisschen Hintergrund

Plotly is kein R-spezifisches Paket, sondern eigentlich ein ganzes System, mit dem man anhand verschiedener Methoden und Ansätze Dashboards zur Datenvisualisierung erstellen kann. Besonders seit März 2020 haben Datenvisualisierungsdashboards in den Alltag von uns allen Einzug gehalten. Besonders zu Beginn der Covid-19 Pandemie war das [Dashboard der Johns Hopkins Universität](https://coronavirus.jhu.edu/map.html) omnipräsent. Seit Beginn 2021 ist die etwas positivere Perspektive in der Vordergrund gerückt, sodass Seiten wie das vom Bundersministerium für Gesundheit erstellte [Impfdashboard](https://impfdashboard.de/) stärker in Erscheinung getreten sind. Aber auch über diese spezifischen Daten hinaus gibt es inzwischen auf vielen Seiten die Möglichkeit, mit öffentlich zugänglichen Daten direkt zu interagieren. Die von [uns genutzten Daten](/post/ggplotting-daten) stammen alle  von [Gapminder](https://www.gapminder.org), die natürlich auch auf ihrer Website [ein eigenes Dashboard](https://www.gapminder.org/tools) zur Verfügung stellen.

Die Idee von plotly ist es, ein integratives Tool zur Verfügung zu stellen, mit dem man ohne vertiefte Kenntnisse von JavaScript solche Dashboards erstellen kann und sie anhand der gängigsten Programmiersprachen zur Datenverarbeitung und -analyse (z.B. R oder Python) bedienen und anpassen kann. Dazu bietet plotly natürlich [eine eigene Website](https://plotly.com/) mit diversen Anleitungen und Informationen. Es sei an dieser Stelle erwähnt, dass plotly dabei zwar die Möglichkeiten zur Erstellung von Dashboards gratis und open-source zur Verfügung stellt, hinter dem gesamten Vorhaben aber ein Geschäftsmodell steht, was darauf fokussiert ist, das Hosting der Dashboards gegen Bezahlung zu übernehmen.

Für uns ist aber vor allem erst einmal relevant, was man mit den Tools so anfangen kann, die uns gratis zu verfügung gestellt werden. Dafür gibt es eine [Dash Galerie](https://dash-gallery.plotly.host/Portal/), auf der man eine Vielzahl wunderschöner und außerordentlich aufwändig gestalteter Plotly-Dashboards sehen kann.

## Plotly für R

Der für uns relevante Teil der Plotly-o-spähre ist das R-Paket `plotly`, welches uns die grundlegenden Tools zur Verfügung stellt, um interaktive Grafiken zu erstellen. Dafür müssen wir, wie immer, das Paket erst installieren und laden:


```r
install.packages('plotly')
```

```r
library('plotly')
```

Dieses Paket bietet uns die Möglichkeit, über die `plot_ly`-Funktion interaktive Grafiken zu erstellen. Aber anstatt uns zu zwingen etwas komplett neues lernen zu müssen, erlaubt uns das Paket auch, mit `ggplot()` erstellte Grafiken in interaktive Grafiken zu übersetzen! Dafür gibt es die Funktion `ggplotly()`. Wie uns mitgeteilt wird, hat `plotly` schon automatisch `ggplot2` geladen, damit das Ganze funktioniert.

## Unser Beispiel

Wie in den bisherigen Abschnitten, nutzen wir den Ausschnitt zu Investitionen in die Bildung und den von [UNDP](https://www.undp.org/) ermittelten Bildungsindex. Die Daten können wir erneut direkt in R von dieser Seite beziehen:


```r
load(url('https://pandar.netlify.com/daten/edu_exp.rda'))
```


Wie schon in den bisherigen Abschnitten werden wir auch hier wieder mit Gruppierungen arbeiten. Um beide in ordentliche Formate zu überführen, die hinterher auch ansehnliche Legenden erzeugen, wandeln wir sowohl `Wealth` als auch `Region` in Faktoren um:


```r
edu_exp$Wealth <- factor(edu_exp$Wealth,
  levels = c('high_income', 'upper_middle_income', 'lower_middle_income', 'low_income'),
  labels = c('High', 'Upper Mid.', 'Lower Mid.', 'Low'))
edu_exp$Region <- factor(edu_exp$Region,
  levels = c('europe', 'asia', 'americas', 'africa'),
  labels = c('Europe', 'Asia', 'Americas', 'Africa'))
```

Die von uns [erstellten Themes und Farbschemata](/post/ggplotting-themes) können wir wieder direkt `source()`n: 


```r
source('https://pandar.netlify.com/post/ggplotting-theme-source.R')
```


Rufen wir uns erneut unsere Abbildung zur Darstellung des Bildungsindex (`Index`) in Abhängigkeit von den Investitionen in die Grundschulbildung vor Augen. Erneut beschränken wir uns dabei zunächst auf das Jahr 2013.


```r
scatter2013 <- subset(edu_exp, Year == 2013) |>
  ggplot(aes(x = Primary, y = Index, color = Wealth)) +
    geom_point() +
    labs(x = 'Investment on Primary Eduction',
    y = 'UNDP Education Index',
    color = 'Country Wealth\n(GDP per Capita)') +
    ggtitle('Impact of Primary Education Investments', subtitle = 'Data for 2013') +
    theme_pandar() + scale_color_pandar()
scatter2013
```

```
## Warning: Removed 99 rows containing missing values or values outside the scale range (`geom_point()`).
```

![](/workshops/ggplotting/plotly_files/figure-html/og-scatter-1.png)<!-- -->

Hier gibt es direkt einige Dinge, die durch Interaktivität ein besseres Verständnis der Datenlage ermöglich würden: wie schon im Beitrag [zu Animationen](/post/ggplotting-gganimate) könnten wir hier versuchen, die Daten aus mehreren Jahren darzustellen (und dabei die Auswahl der Nutzerin oder dem Nutzer zu überlassen). Uns könnte auch interessieren, wie verschiedene Modelle den Zusammenhang zwischen den Variablen darstellen bzw. vereinfachen würden und diese in der Grafik anzeigen lassen. Vor allem aber liegt auf der Hand, dass wir durch Interaktivität die Möglichkeit gewinnen genauer zu wissen, was uns jeder einzelne Punke sagen kann.

## Anwenden von `ggplotly`

Wie schon erwähnt, können wir unsere ggplots direkt in interaktive Plots umwandeln lassen, indem wir unser `ggplot`-Objekt an die Funktion `ggplotly()` übergeben. Das hat gegenüber der plotly-eigenen `plot_ly` den Nachteil, dass wir ein bisschen Flexibilität in der späteren Anpassung der interaktiven Optionen einbüßen, aber hat den immensen Vorteil, dass alle Dinge, die wir uns für den Umgang mit ggplot aneignen auch hier direkt anwendbar sind. So werden z.B. auch alle Farb- und Theme-Anpassungen direkt von plotly übernommen:


```r
ggplotly(scatter2013)
```

<!-- definitely make this more pretty at some point in the future --> 
<iframe src="plotly1.html" width="100%" height="500"></iframe>

Schon so erhöht sich das Ausmaß in dem man sich mit der Grafik auseinandersetzen kann, für Nutzer*innen deutlich. Sie können an dieser Stelle weiterlesen, um eine Beschreibung der interaktiven Funktionen dieses Plots zu lesen, oder es einfach ausprobieren! Für die Wenigen, die sich für Ersteres entscheiden, hier eine Erläuterung der Funktionen:

Wenn sie mit dem Cursor über einen Datenpunkt hovern, erhalten Sie genauere Informationen über diesen spezifischen Datenpunkt (die sogenannte "hoverinfo"). Im aktuellen Fall sind das die genauen Ausprägungen der drei Variablen, die im Plot auch verarbeitet sind. Außerdem kann man mit dem Cursor einen Bereich im Plot markieren um in diesen herein zu zoomen. Die dritte Möglichkeit, mit dem Datenfenster zu interagieren, stellt die Legende dar. Hier kann man durch einfachen Klick die Datenpunkte der gewählten Gruppen aus- und einblenden.

Über diese Möglichkeiten hinaus bietet Plotly oben rechts einige Navigationsbuttons an. Von links nach rechts:

  * Die Abbildung mit aktuellen Einstellungen als .png speichern.
  * Das oben beschriebene Verhalten, mit dem man in bestimmte Bereiche des Plots hereinzoomen kann. Die Voreinstellung.
  * Das Zoom-Verhalten ausschalten und stattdessen in den Pan-Modus wechseln.
  * In den Box-Select Modus wechseln, um rechteckige Regionen von Datenpunkten auszuwählen.
  * In den Lasso-Select Modus wechseln, um chaotische Regionen von Datenpunkten auszuwählen.
  * Zoom in.
  * Zoom out.
  * Automatische Skalierung von x und y wählen.
  * Auf die ursprüngliche Skalierung von x und y zurück setzen.
  * "Spike lines" anzeigen, die dabei helfen, den Datenpunkt auf x und y zu verorten.
  * Die Hoverinfo des nächstgelegenen Datenpunkts anzeigen. Die Voreinstellung.
  * Die Hoverinfos von, auf der x-Achse naheliegenden Datenpunkten anzeigen.
  
Wie man sieht, sind das per Voreinstellung ziemlich viele Optionen, die bei weitem nicht immer alle nötig oder sinnvoll sind. Aber besonders zu Beginn können sie dabei helfen, die Daten genauer unter die Lupe zu nehmen.

## Hoverinfo anpassen

Die Voreinstellung, in der Hoverinfo die drei bereits in der Abbildung dargestellten Variablen genauer anzugeben ist zwar intuitiv, aber in den meisten Fällen wollen wir dadurch ja *zusätzliche* Information gewinnen. Sehen wir uns zuerst an, wie man generell anpassen kann, was in der Hoverinfo erscheint.

Die `ggplotly`-Funktion, die wir nutzen, um unseren `ggplot` in eine interaktive Grafik zu überführen, nimmt das Argument `tooltip` entgegen. Die Hilfe unter `?ggplotly` gibt dabei folgende Auskunft:

| <!-- -->  | <!-- --> |
| - | -------- |
| `tooltip` | a character vector specifying which aesthetic mappings to show in the tooltip. The default, "all", means show all the aesthetic mappings (including the unofficial "text" aesthetic). The order of variables here will also control the order they appear. For example, use `tooltip = c("y", "x", "colour")` if you want y first, x second, and colour last. |

Dieses Argument erlaubt uns also die angezeigte Hoverinfo auszuwählen, indem wir die Ästhetiken auswählen, die angezeigt werden sollen. Hier ist es wichtig auf die Unterscheidung zwischen Ästhetiken und den zugrundliegenden Variablen zu achten! Wir können der Hilfe zufolge in unserem Fall also z.B.


```r
ggplotly(scatter2013, 
  tooltip = c('colour', 'x', 'y'))
```


nutzen, um im Tooltip erste Informationen zur farbgebenden Variable (`Wealth`), dann zur x-Achse (`Primary`) und dann zur y-Achse (`Index`) anzeigen zu lassen. Leider werden wir hier von der Hilfe angelogen. Es ist ein [seit 4 Jahren bekannter Bug](https://github.com/ropensci/plotly/issues/849), dass diese Sortierung nicht für die Übersetzung von ggplots funktioniert (wenn wir in Plotlys eigener Sprache schreiben würden, würde es funktionieren). Darüber hinaus ist es besonders bei färbenden Ästhetiken wichtig darauf zu achten, dass Plotly (anders als ggplot) *nicht* die Amerikanische Schreibweise des Arguments als `color` akzeptiert, sondern ausschließlich die überall anders genutzte Schreibweise `colour`. 

Der generell akzeptierte Workaround für all diese Probleme ist bereits im Hilfetext versteckt: "(including the unofficial "text" aesthetic)". Für unsere Hoverinfos können wir also eine Ästhetik namens `text` nutzen, um nicht bereits im Plot enthaltene Informationen in gewünschter Reihenfolge anzeigen zu lassen. Dazu können wir entweder unseren gesamten Plot mit der Zusatzästhetik neu generieren, oder die Infos mit einer weiteren Schicht Punkte an den Plot übergeben. Obwohl die zweite Fassung wesentlich unumständlicher klingt:


```r
scatter2013 <- scatter2013 +
  geom_point(aes(text = '...'))
```

hat sie den Nachteil, dass eben eine *zusätzliche* Punkteschicht eingeführt wird, was mitunter unvorhergesehene Konsequenzen nach sich ziehen kann. Daher entscheide ich mich, den Plot noch einmal vollständig neu zu generieren und dabei die `text` Ästhetik global zu definieren. (Geheimtipp: mit dem Zusatzpaket `ggedit` können über den Befehl `remove_geom()` auch Schichten aus erstellten Plots entfernt werden, was diesen Schritt mitunter verkürzen kann).

Die neue Ästhetik `text` kann genau das enthalten, was sie verspricht: Text. Damit wir für jeden Datenpunkt eine eigene Beschriftung bekommen müssen wir also Text erzeugen, der von den Daten abhängt. Zum Glück bietet uns R mit `paste` eine relativ komfortable Weise, um massenweise Text zu erstellen. Z.B. könnten wir als Label für Spanien haben wollen:


```
## Spain
## Region: Europe
## GDP/Capita: 24368.96824
```

Damit erhalten wir Informationen zum Land, der Region und eine detailliertere Einschätzung der Wirtschaftsleistung. Diese ist relevant, weil die Variable auf unserer x-Achse (`Primary`) ja maßgeblich von dieser beeinflusst wird. Die Kategorie von `Wealth` wird durch die Färbung der Hoverinfo ausgegeben und  `Primary` und `Index` sind bereits in der Position des Punktes kodiert, sodass ich diese hier zunächst weglasse.

`paste()` (und die Schwesterfunktion `paste0()`) kleben Textbausteine und Variablenausprägungen in einen `character` Vektor zusammen. Für die oben dargestellte Kombination benötigen wir also:


```r
paste0(Country, 
  '</br></br>Region: ', Region, 
  '</br>GDP/Capita: ', Income)
```

für unsere `text`-Ästhetik. So werden für jede Zeile unseres Datensatzes die Ausprägungen der drei aufgeführten Variablen mit den dazwischenstehenden Textbausteinen verbunden. Dieses Vorgehen hat den Vorteil, dass wir hier auch Variablen verarbeiten können, also nicht nur angezeigte oder rohe Informationen anzeigen können. Häufig bietet es sich z.B. an mit `round()` zu arbeiten, um die Anzeige übersichtlich zu halten. Wir können z.B. auch eine Zusatzinformation wie "Investment per Student" (also der numerische Dollar-Wert, der pro Schüler*in in der Grundschule pro Jahr durch dieses Land investiert wird - natürlich eine außerordentlich grobe Approximation) erzeugen:


```r
paste0(Country, 
  '</br></br>Region: ', Region, 
  '</br>GDP/Capita: ', Income, 
  '</br>Investment/Student: ', round((Primary/100)*Income))
```

Was z.B. für Spanien in Folgendem resultieren würde:


```
## Spain
## Region: Europe
## GDP/Capita: 24368.96824
## Investment/Student: 4295
```

Die `</br>` in unserer Ästhetik sind einfache Zeilenumbrüche (*breaks*) in HTML, die Sprache in die unser Plot für die Anzeige übersetzt wird, bevor er vom Browser angezeigt werden kann.


```r
scatter2013 <- subset(edu_exp, Year == 2013) |>
  ggplot(aes(x = Primary, y = Index, color = Wealth,
    text = paste0(Country, 
      '</br></br>Region: ', Region, 
      '</br>GDP/Capita: ', Income, 
      '</br>Investment/Student: ', round((Primary/100)*Income)))) +
    geom_point() +
    labs(x = 'Investment on Primary Eduction',
    y = 'UNDP Education Index',
    color = 'Country Wealth\n(GDP per Capita)') +
    ggtitle('Impact of Primary Education Investments', 
      subtitle = 'Data for 2013') +
    theme_pandar() + scale_color_pandar()
```

So erstellen wir jetzt also den neuen ggplot. In dessen Anzeige hat sich überhaupt nichts geändert, weil `text` keine offizielle Ästhetik von `ggplot` ist. Wenn wir `ggplotly` darauf hinweisen, dass in dieser Ästhetik aber wichtige Information enthalten ist, wird diese im interaktiven Plot berücksichtigt. Als neue Grafik, mit neuer Hoverinfo ergibt sich als:


```r
ggplotly(scatter2013,
  tooltip = 'text')
```

<!-- definitely make this more pretty at some point in the future --> 
<iframe src="plotly2.html" width="100%" height="500"></iframe>

## Navigierbare Animation

Im [Beitrag zu `gganimate`](/post/ggplotting-gganimate) hatten wir bereits gesehen, wie wir "vorgefertigte" Animationen erzeugen können. Also letztendlich Animationen, die von allen in gleicher Weise gesehen werden. Schon dort hatten wir gesehen, dass dies ein gutes Mittel sein kann, um den Fokus der Betrachter*innen auf bestimmte Veränderungen zu lenken. In diesem Block geht es uns aber genau darum, allen die Möglichkeit zu geben, die Datenlage nach eigenem Gutdünken zu erkunden.

Wie schon im letzten Abschnitt geht das Einführen von Animationen leider wieder damit einher, dass wir eine neue *globale* Ästhetik definieren - was bedeutet, dass wir erneut unseren `ggplot` vollständig erzeugen müssen. Die für Animationen von `ggplotly()` genutzte Ästhetik heißt, naheliegenderweise, `frame`. Wie schon bei Animationen mit `gganimate` macht es darüber hinaus Sinn, die Zuordnung der Punkte über verschiedene Jahre hinweg zum gleichen Land sicherzustellen:


```r
scatter <- ggplot(edu_exp, aes(x = Primary, y = Index, color = Wealth,
  frame = Year, group = Country,
  text = paste0(Country, 
    '</br></br>Region: ', Region, 
    '</br>GDP/Capita: ', Income, 
    '</br>Investment/Student: ', round((Primary/100)*Income)))) +
  geom_point() +
  labs(x = 'Investment on Primary Eduction',
  y = 'UNDP Education Index',
  color = 'Country Wealth\n(GDP per Capita)') +
  ggtitle('Impact of Primary Education Investments') +
  theme_pandar() + scale_color_pandar()
```

Darüber hinaus benutzen wir jetzt wieder den gesamten Datensatz `edu_exp` und nicht mehr die Auswahl für 2013 - dadurch können wir natürlich auch den einschränkenden Untertitel wieder streichen. Diesen ggplot können wir jetzt erneut durch `ggplotly()` in eine interaktive Grafik umwandeln lassen. Bevor wir das tun, sehen wir uns aber an, welche Optionen wir für diese Animationen setzen können. Dazu gibt es `plotly` die Funktion `animation_opts`, die folgende Argumente entgegen nimmt:


```r
args(animation_opts)
```

```
## function (p, frame = 500, transition = frame, easing = "linear", 
##     redraw = TRUE, mode = "immediate") 
## NULL
```

`p` ist hier einfach der Plot, den wir zuvor mit `ggplotly()` erzeugt haben - wir können diesen also einfach durch die Pipe an die Optionen weiterreichen. `frame`kontrolliert dabei die Zeit, die zwischen verschiedenen Ausprägungen der `frame`-Ästhetik (in unserem Fall also `Year`) liegen soll und `transition` erlaubt darüber hinaus eine genaue Angabe der Dauer der Übergangsanimation. Per Voreinstellung sind diese beiden gleich lang, sodass keine Ruhezeiten bei den einzelnen Jahren entstünden. Um das zu umgehen und immer mal wieder einen Blick auf die Daten aus einem Jahr werfen zu können, können wir diese Zeit aber senken. Mit `transition = 200` hätten wir z.B. immer 200 Milisekunden Übergang und dann 300 Milisekunden in einem Jahr.

Das `easing` Argument ist extrem eng verwandt mit `ease_aes()`, was wir [bereits für `gganimate` besprochen hatten](/post/ggplotting-gganimate). Kurzgesagt geht es hierbei um die Art und Weise, in der der Übergang zwischen Zeiten interpoliert wird. Die beiden Ansätze sind sogar so eng verwandt, dass die in `?ease_aes()` aufgeführten Kombinationen aus Easing-Functions und Modifiers auch hier angewendet werden können. Das ist sogar außerordentlich praktisch, weil auch hier die `plotly`-eigene Dokumentation etwas dürftig ist. Für unseren Fall belassen wir es erst einmal beim linearen Übergang zwischen Zuständen, sodass wir bei folgendem Plot landen:


```r
ggplotly(scatter, 
  tooltip = 'text') |>
  animation_opts(transition = 200)
```

<!-- definitely make this more pretty at some point in the future --> 
<iframe src="plotly3.html" width="100%" height="500"></iframe>

Zunächst erhalten wir bei der Erstellung eine Warnung, die dadurch zustande kommt, dass im 1. Frame (`Year == 1997`) nicht alle Datenpunkte besetzt sind. Das ist ungünstig, aber leider in Fällen wie unseren, in dem wir auf erhobene und nicht geschätzte Informationen angewiesen sind, unvermeidlich. Wenn wir eine solche Animation mit `Income` und `Expectancy` duchführen würden, wäre das kein Problem, weil hier immer alle Daten vollständig sind.

Durch die Animation erhalten wir jetzt am unteren Rand der Abbildung einen Slider, mit dem wir gezielt zu einzelnen Jahren navigieren können. Das aktuelle Jahr wird uns daneben angezeigt. Darüber hinaus bekommen wir einen "Play" button, mit dem wir die Animation durch den Verlauf aller Jahre starten können. Wir können diese beiden Elemente auch einzeln mit `animation_slider` bzw. `animation_button` anpassen bzw. sogar ausschalten.

Zu bedenken ist dabei, dass diese Animationsfunktionalität jetzt mit den oben besprochenen Interaktionsmöglichkeiten mit dem Plot kombiniert werden können! Wir können also z.B. in die Region unter `Investment` von 20 und unter `Index` von 25 reinzoomen und uns nur die Entwicklung dieser Länder ansehen. Leider ist die Animation aber meines Wissens nach nicht mit der Selektion einzelner Gruppen (via Click auf die Legende) kombinierbar. Sollten jemand herausfinden, wie das umgesetzt werden kann, lassen Sie es mich wissen!

Ein feiner, aber durchaus verwirrender, Unterschied von Plotly und ggplot ist, dass die Objekte in Plotly immer weitergereicht und dabei durch die Funktionen geschleust werden (dafür nutze ich hier die Pipe `|>`). Bei ggplot war das anders! Dort haben wir unterschiedliche Komponenten immer mit `+` verbunden um eine Anleitung zu erstellen, die erst beim Aufruf der Abbildung ausgeführt wurde.

## Anpassung der Plots

Die Grundeigenschaften und das generelle Layout des Plots haben wir bislang über die Möglichkeiten von `ggplot` festgelegt. Während es generell eine gute Idee ist, erst die statische Grafik zu enwtickeln und zu formatieren, bevor man in die interaktive Fassung wechselt, gibt es dennoch einige Dinge, die am Ende spezifisch für die mit `plotly` erstellte Abbildung sind. 

Im Wesentlichen bietet `plotly` drei große Funktionen, mit denen wir die interaktiven Elemente einer Abbildung anpassen können, die durch `ggplotly()` entstanden ist:

| Funktion | Erläuterungen |
| --- | ------ |
| `layout()` | Komponenten der interaktiven Darstellung anpassen (z.B. die Formatierung der Legende) |
| `style()` | Komponenten der Datendarstellung anpassen (z.B. Formatierung der Hoverinfo) |
| `config()` | Einstellung in der Umsetzung anpassen (z.B. Plotly-Buttons) |

Mit allen drei Funktionen sind Anpassungen der Plots in einem Detail möglich, das den Rahmen hier dramatisch sprengen würde. Es sei dazu gesagt, dass [die detaillierte Dokumentation dieser Möglichkeiten](https://plotly.com/r/reference) häufig für die Python-Variante besser ausgearbeitet ist, sodass es sich lohnen kann, auch diese genauer unter die Lupe zu nehmen. Das ist inbesondere der Fall, weil viele Fragen in den Foren sich auf Umsetzungen mit Pyhton beziehen. Die meisten häufigen Einstellungen werden aber auch in der [R Dokumentation von Plotly](https://plotly.com/r/) ausreichend dargestellt und mit Beispielen illustriert. Darüber hinaus bietet das [Buch von Carson Sievert](https://plotly-r.com/index.html) einige detaillierte Anleitungen zum Umgang mit Plotly.

An den bisherigen Grafiken stört mich, dass die Plotly-Buttons die Legende überdecken und dadurch der Titel der Legende häufig nicht lesbar ist. Das könnten wir z.B. lösen, indem wir die Legende ein bisschen nach unten verschieben. Dafür gibt es in `layout` das Argument `legend`. Leider enthält die Hilfefunktion zu `?layout` nicht alle Argumente, aber diese werden dann einer Warnmeldung gelistet, wenn wir ein falsches Argument vorgeben. Um uns diesen Umweg zu ersparen, hier die Liste, die dann erscheint:


```
## 'layout' objects don't have these attributes: 'something.wrong'
## Valid attributes include:
## 'font', 'title', 'uniformtext', 'autosize', 'width', 'height', 'margin',
## 'computed', 'paper_bgcolor', 'plot_bgcolor', 'separators', 'hidesources',
## 'showlegend', 'colorway', 'datarevision', 'uirevision', 'editrevision', 
## 'selectionrevision', 'template', 'modebar', 'newshape', 'activeshape',
## 'meta', 'transition', '_deprecated', 'clickmode', 'dragmode', 'hovermode',
## 'hoverdistance', 'spikedistance', 'hoverlabel', 'selectdirection', 'grid',
## 'calendar', 'xaxis', 'yaxis', 'ternary', 'scene', 'geo', 'mapbox', 'polar',
## 'radialaxis', 'angularaxis', 'direction', 'orientation', 'editType',
## 'legend', 'annotations', 'shapes', 'images', 'updatemenus', 'sliders',
## 'colorscale', 'coloraxis', 'metasrc', 'barmode', 'bargap', 'mapType'
```

Wir sehen also, dass es für unseren Fall das `legend` Argument gibt. Alle Argumente sollten dann Listen sein, die weitere Unterargumente enthalten. Für die Positionierung unserer Legende könnten wir also Folgendes nutzen:


```r
layout(p, 
  legend = list(x = 100, y = .5))
```

Die beiden Koordinaten werden dabei *relativ* innerhalb des Plots bestimmt. `x = 0` entspricht also dem Nullpunkt der x-Achse, `x = .5` dem Mittelpunkt usw. Um etwas außerhalb des Plots zu positionieren können wir eine sehr große Zahl nehmen (hier `x = 100`). So positionieren wir die Legende also rechts außerhalb der Abbildung und auf der Mitte der y-Achse. Leider ist das Problem bei dieser Umsetzung, dass `ggplotly` den von `ggplot` gelieferten Legendentitel automatisch oben rechts in die Ecke setzt und uns keine Möglichkeit bietet, diesen zu verschieben. Also ist es erneut Zeit für einen Trick: den Titel in `ggplot` ausschalten (hier auf `NULL` gesetzt) und in `layout()` einen neuen erzeugen:


```r
scatter <- ggplot(edu_exp, aes(x = Primary, y = Index, color = Wealth,
  frame = Year, group = Country,
  text = paste0(Country, 
    '</br></br>Region: ', Region, 
    '</br>GDP/Capita: ', Income, 
    '</br>Investment/Student: ', round((Primary/100)*Income)))) +
  geom_point() +
  labs(x = 'Investment on Primary Eduction',
  y = 'UNDP Education Index',
  color = NULL) +
  ggtitle('Impact of Primary Education Investments') +
  theme_pandar() + scale_color_pandar()

interact <- ggplotly(scatter, tooltip = 'text') |>
  animation_opts(transition = 200) |>
  layout(legend = list(x = 100, y = .5, 
        title = list(text = 'Country Wealth</br></br>(GDP per Capita)')))
```

```r
interact
```


<!-- definitely make this more pretty at some point in the future --> 
<iframe src="plotly4.html" width="100%" height="500"></iframe>

In ähnlicher Weise funktionieren auch `style()` und `config()` für detaillierte Anpassungen der Grafiken. Mit `config()` können wir z.B. anpassen, welche der Buttons oben rechts angzeigt werden sollen. Z.B. könnten wir Zoom-In, Zoom-Out und das Lasso entfernen:


```r
interact |>
  config(modeBarButtonsToRemove = c('lasso2d', 'zoomIn2d', 'zoomOut2d'))
```

Eine vollständige Liste der möglichen Buttons lässt sich im [GitHub Repository von Plotly](https://github.com/plotly/plotly.js/blob/master/src/components/modebar/buttons.js) finden.


## Buttons zum Ein- und Ausblenden eines Smoothers

Mit `geom_smooth()` können in `ggplot2` einfache statistische Glättungen vorgenommen werden, um ein zusammengefasstes Bild des Zusammenhangs der dargestellten Variablen zu erhalten. Für unsere ursprüngliche Abbildung aus 2013 würde das z.B. so aussehen:


```r
scatter2013 <- subset(edu_exp, Year == 2013) |>
  ggplot(aes(x = Primary, y = Index)) +
    geom_smooth(method = 'gam', color = 'grey70', se = FALSE) + 
    geom_point(aes(color = Wealth)) +
    labs(x = 'Investment on Primary Eduction',
    y = 'UNDP Education Index',
    color = 'Country Wealth\n(GDP per Capita)') +
    ggtitle('Impact of Primary Education Investments', subtitle = 'Data for 2013') +
    theme_pandar() + scale_color_pandar()
scatter2013
```

```
## `geom_smooth()` using formula = 'y ~ s(x, bs = "cs")'
```

```
## Warning: Removed 99 rows containing non-finite outside the scale range (`stat_smooth()`).
```

```
## Warning: Removed 99 rows containing missing values or values outside the scale range (`geom_point()`).
```

![](/workshops/ggplotting/plotly_files/figure-html/og-smooth-1.png)<!-- -->

Hier nutze ich nicht die Voreinstellungen von `geom_smooth()` (den LOESS-Glätter), weil die Datenlage mit ca. 70 Ländern etwas dünn für einen so ausreißeranfälligen Glätter ist. Stattdessen nutze ich hier ein generalisiertes additives Modells (GAM), sodass die eingezeichnete Linie zumindest ein paar Modellannahmen unterliegt und nicht ausschließlich aus den Daten heraus erzeugt wird (eine Einführung in diese Modelle findet sich [auf dieser Seite von Michael Clark](https://m-clark.github.io/generalized-additive-models/building_gam.html)). Weil es uns hier zunächst nicht um inferenzstatistische Absicherung, sondern vor allem um die vereinfachte Zusammenfassung des Zusammenhangs geht, werden außerdem die Konfidenzintervalle ausgeblendet.

Sinn dieses Abschnitts ist es jetzt, genau solche Smoother interaktiv für jedes Jahr zugänglich zu machen und per Button ein- bzw. ausblenden zu können. Damit das möglich ist, müssen wir uns - erneut - eines Tricks bedienen. Aber beginnen wir erst mit dem `ggplot`, der die Grundlagen des interaktiven Plots darstellt:


```r
smooth <- ggplot(edu_exp, aes(x = Primary, y = Index, frame = Year)) +
  geom_smooth(method = 'gam', color = 'grey70', alpha = .2, se = FALSE) +
  geom_point(aes(color = Wealth,
        text = paste0(Country,
          '</br></br>Region: ', Region,
          '</br>GDP/Capita: ', Income,
          '</br>Investment/Student: ', round((Primary/100)*Income)))) +
  labs(x = 'Investment on Primary Eduction',
    y = 'UNDP Education Index',
    color = NULL) +
  ggtitle('Impact of Primary Education Investments') +
  theme_pandar() + scale_color_pandar()
```

```
## Warning in geom_point(aes(color = Wealth, text = paste0(Country, "</br></br>Region: ", : Ignoring unknown aesthetics: text
```

Weil die Hoverinfos und die Gruppeneinteilung in Wohlstandsgruppen nicht GAM-Geraden ausgegeben werden sollen, sondern nur für die tatsächlichen Datenpunkte, muss auch hier erneut der Grundlegende `ggplot` zusammengestellt werden. Dafür rutschen die Ästhetiken `color` und `text` in die `geom_point()` und werden nicht mehr global definiert. 

Nun der spannende Teil: um Buttons einzuführen müssen wir das Argument `updatemenus` des `layout()` in Plotly nutzen. Wie für beinahe alle Argumente liebt Plotly hier Listen von Listen von Listen. Sehen wir uns zunächst die gesamte Button-Definition an:


```r
menus <- list(
  list(type = 'buttons',
    x = 1.3, y = .2, align = 'left',
    buttons = list(
      list(method = 'restyle',
        args = list('line.color', 'rgba(179,179,179,1)'),
        label = 'Smoother On'),
      list(method = 'restlye',
        args = list('line.color', 'rgba(179,179,179,0)'),
        label = 'Smoother Off')
    ))
)
```

Diese Liste soll eine Liste von möglichen Änderungen der Menüs von Plotly sein. Einer der möglichen Typen für ein solches Menü sind Buttons, daher hier `type = 'buttons'`. Die folgenden Argumente dienen der Verortung der Buttons im Plot. Wie schon oben sind `x` und `y` hier relativ gemeint. Damit die Knöpfe unter unserer Legende angezeigt werden, positionieren wir sie mit `y = .2` etwas niedrieger und mit `x = 1.3` etwas außerhalb des eigentlichen Plot-Bereichs. Mit `align = 'left'` werden sie dann anschließend noch linksbündig eingerichtet.

Im Anschluss werden an das Argument `buttons` die zu definierenden Knöpfe in - wie sollte es anders sein? - Listenform angegeben. In Plotly werden vier Arten von Buttons unterschieden:

| Button | Erläuterung |
| --- | ------ |
| `restyle` | Oberflächeneigenschaften (z.B. Farben oder Punkt-Typen) der Datendarstellung verändern |
| `relayout` | Layout-Eigenschaften der gesamten Abbildung ändern |
| `update` | Datengrundlage (z.B. Auswahl eine Gruppe) verändern |
| `animate` | Änderungen der Animationsart, derzeit nur rudimentär implementier |

Wir wollen in diesem Fall "Obeflächeneigenschaften" verändern, weil wir lediglich Smoother ein- bzw. ausblenden wollen. Der vorhin angesprochene "Trick" besteht darin, dass wir unseren Smoother gar nicht verschwinden lassen, sondern nur die Oberflächeneigenschaften dahingehend ändern, dass er so durchsichtig wird, dass wir ihn nicht mehr sehen. Das erreichen wir dadurch, dass wir die `'line.color'` im RGBA-Format (Red Green Blue Alpha) so definieren, dass sie dem im `geom_smooth()` genutzten Grau entspricht. Für den Button `Smoother On` bekommt sie außerdem ein Alpha von 1 zugewiesen (vollständig undurchsichtig), für den Button `Smoother Off` bekommt sie ein Alpha von 0 zugewiesen (vollständig durchsichtig).

Das Ganze können wir mit unseren schon oben besprochenen `layout()`-Optionen kombinieren, sodass wir folgende, finale Abbildung erhalten:


```r
smoothly <- ggplotly(smooth, tooltip = 'text') |>
  animation_opts(transition = 200) |>
  layout(legend = list(x = 100, y = .5,
    title = list(text = 'Country Wealth</br></br>(GDP per Capita)')),
    updatemenus = menus)
smoothly
```

<!-- definitely make this more pretty at some point in the future --> 
<iframe src="plotly5.html" width="100%" height="500"></iframe>

***

In diesem Abschnitt haben wir nur die Oberfläche der Anpassungsmöglichkeiten mit Plotly angeschnitten. Eine Komponente, die hier noch vollkommen unangesprochen blieb, ist die Kombination solcher interaktiver Grafiken in vollständigen Dashboards. Dafür gibt es das Paket `dash`, welches [ebenfalls von Plotly angeboten](https://dashr.plotly.com/) wird. Für mehr Anpassungen einzelner, interaktiver Plots gibt es noch sehr viel mehr Details im bereits angesprochenen [Buch von Carson Sievert](https://plotly-r.com/index.html) und in der [offiziellen Dokumentation von Plotly](https://plotly.com/r/).
