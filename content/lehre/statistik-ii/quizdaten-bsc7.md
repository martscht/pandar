---
title: Alte Daten für die Quiz
type: post
date: '2021-04-21'
slug: quizdaten-bsc7
categories: [""]
tags: ["Daten"]
subtitle: ''
summary: 'Auf dieser Seite finden sich alle Datensätze für die Studienleistungen in PsyBSc2. Die Durchführung der Quiz findet auf der Lernplattform moodle für die Teilnehmenden des Moduls statt.'
authors: [nehler, rouchi, irmer]
lastmod: '2025-02-07'
featured: no
banner:
  image: "/header/abstract_building.jpg"
  caption: '[Courtesy of pxhere](https://pxhere.com/en/photo/18153)'
projects: []

reading_time: false 
share: false

links:
  # - icon_pack: fas
  #   icon: book
  #   name: Inhalte
  #   url: /lehre/klipps/regression-ausreisser
  # - icon_pack: fas
  #   icon: terminal
  #   name: Code
  #   url: /lehre/klipps/regression-ausreisser.R
  # - icon_pack: fas
  #   icon: pen-to-square
  #   name: Quizdaten
  #   url: /lehre/klipps/regression-ausreisser-quizdaten

output:
  html_document:
    keep_md: true
---






## Quiz 1: Wiederholung und `ggplot2` {#Quiz1}

Die Fragen zum Quiz bezüglich Wiederholung und `ggplot2` stammen aus dem bereits im ersten Tutorial bearbeiteten Machiavellismusfragebogen. Sie können den Datensatz direkt aus dem Internet in ihren Workspace in `R` laden. Der funktionierende Befehl sieht so aus:


```r
load(url("https://courageous-donut-84b9e9.netlify.app/post/mach.rda"))
```

Die hier verwendeten Daten stammen aus dem [Open-Source Psychometrics Project](https://openpsychometrics.org/_rawdata/), einer Online-Plattform, die eine Sammlung an Daten aus verschiedensten Persönlichkeitstests zur Verfügung stellt. Wir haben schon Modifikationen für Sie darin vorgenommen. Natürlich können Sie den Datensatz "mach.rda" auch {{< icon name = "download" pack = "fas">}}[hier](https://courageous-donut-84b9e9.netlify.app/post/mach.rda) herunterladen, um ihn dann lokal zu lagern.

Der Datensatz erhält viele Angaben zur Persönlichkeit und zu demografischen Daten. Kern ist aber der 20 Items umfassende Machiavellismusfragebogen von Christie und Geis (1970) und die daraus ableitbare 4-faktorielle Struktur des Konzepts (Corral & Calvete, 2000). Die Skalenwerte dieser vier Faktoren haben wir bereits im Datensatz angelegt:

| Variable | Bedeutung |
| --- | --- |
| `nit` | _Negative interpersonal tactics_ |
| `pit` | _Positive interpersonal tactics_ |
| `cvhn` | _Cynical view of human nature_ |
| `pvhn` | _Positive view of human nature_ |

Der Struktur dieser vier Faktoren liegt die Idee zugrunde, dass Machiavellismus in zwei Konzepte - Taktiken und Überzeugungen - unterteilt werden kann. _Taktiken_ stellen dabei vor allem eigene Verhaltensweisen im Umgang mit anderen Menschen dar, während _Überzeugungen_ sich auf die grundlegende Natur anderer Menschen und ihrer Absichten beziehen. Innerhalb dieser beiden Konzepte wird noch einmal zwischen positiven und negativen Aspekten unterschieden. So stellt beispielsweise Item 2 "The best way to handle people is to tell them what they want to hear" einen negativen Umgang mit anderen Menschen dar. Das Item 8 "Generally speaking, people won't work hard unless they're forced to do so" stellt eine zynische Überzeugung bezüglich der grundlegenden Eigenschaften anderer Menschen dar.

Neben diesen Skalenwerten enthält der Datensatz auch diverse Variablen zu demografischem Hintergrund und allgemeinen Angaben über die Personen. Im Quiz sind davon folgende relevant:

| Variable | Bedeutung |
| --- | --- |
| `TIPI7` | Wärme einer Person |
| `voted` | Teilnahme an der letzten Wahl (1 = Ja, 2 = Nein) |
| `hand` | Schreibhand (1 = rechts, 2 = links, 3 = beide) |
| `education` | Höchstes, abgeschlossenes Bildungsniveau |

***

## Quiz 2: Partial- & Semipartialkorrelation und Multiple Regression {#Quiz2}
 
Der Beispieldatensatz enthält Daten zur Lesekompetenz aus der deutschen Stichprobe der PISA-Erhebung in Deutschland 2009. Sie können den im Folgenden verwendeten Datensatz "PISA2009.rda" {{< icon name = "download" pack = "fas">}}[hier](https://courageous-donut-84b9e9.netlify.app/post/PISA2009.rda) herunterladen. Alternativ können Sie ihn auch direkt über diesen Befehl in Ihr Environment einladen.


```r
load(url("https://courageous-donut-84b9e9.netlify.app/post/PISA2009.rda"))
```

Im Datensatz sind viele Variablen der pädagogischen Forschung erhalten, die im Folgenden erklärt werden. Nicht alle davon werden für dieses Quiz benötigt und die wichtigen werden stets im Quiz selbst auch nochmal namentlich erwähnt.

| Variable | Bedeutung |
| --- | --- |
| `Grade` | Klassenstufe |
| `Age` | Alter in Jahren |
| `Female` | Geschlecht (0 = m, 1 = w) |
| `Reading` | Lesekompetenz |
| `JoyRead` | Lesefreude |
| `LearnMins` | Lernzeit in Minuten für Deutsch |
| `HISEI` | Sozialstatus ("highest international socio-economic index of occupational status") |
| `CultPoss` | Fragebogen-Score für kulturelle Besitztümer zu Hause (z. B. klassische Literatur, Kunstwerke) |
| `Books` | Anzahl Bücher zu Hause |
| `TVs` | Anzahl Fernseher zu Hause |
| `Computers` | Anzahl Computer zu Hause |
| `Cars` | Anzahl Autos zu Hause |
| `MigHintergrund` | Migrationshintergrund (0=beide Eltern in D geboren, 1=min. 1 Elternteil im Ausland geboren) |
| `FatherEdu` | Bildungsabschluss des Vaters (International Standard Classification of Education) |
| `MotherEdu` | Bildungsabschluss der Mutter (International Standard Classification of Education) |

***

## Quiz 3: Modelloptimierung und Voraussetzungsprüfung {#Quiz3}

Die Daten für dieses Quiz entsprechen denen aus dem zweiten Quiz. Um Verwirrung zu vermeiden, wird die Beschreibung hier nochmal aufgeführt.

Der Beispieldatensatz enthält Daten zur Lesekompetenz aus der deutschen Stichprobe der PISA-Erhebung in Deutschland 2009. Sie können den im Folgenden verwendeten Datensatz "PISA2009.rda" {{< icon name = "download" pack = "fas">}}[hier](https://courageous-donut-84b9e9.netlify.app/post/PISA2009.rda) herunterladen. Alternativ können Sie ihn auch direkt über diesen Befehl in Ihr Environment einladen.


```r
load(url("https://courageous-donut-84b9e9.netlify.app/post/PISA2009.rda"))
```

Im Datensatz sind viele Variablen der pädagogischen Forschung erhalten, die im Folgenden erklärt werden. Nicht alle davon werden für dieses Quiz benötigt und die wichtigen sind stets im Quiz auch nochmal namentlich erwähnt.

| Variable | Bedeutung |
| --- | --- |
| `Grade` | Klassenstufe |
| `Age` | Alter in Jahren |
| `Female` | Geschlecht (0 = m, 1 = w) |
| `Reading` | Lesekompetenz |
| `JoyRead` | Lesefreude |
| `LearnMins` | Lernzeit in Minuten für Deutsch |
| `HISEI` | Sozialstatus ("highest international socio-economic index of occupational status") |
| `CultPoss` | Fragebogen-Score für kulturelle Besitztümer zu Hause (z. B. klassische Literatur, Kunstwerke) |
| `Books` | Anzahl Bücher zu Hause |
| `TVs` | Anzahl Fernseher zu Hause |
| `Computers` | Anzahl Computer zu Hause |
| `Cars` | Anzahl Autos zu Hause |
| `MigHintergrund` | Migrationshintergrund (0=beide Eltern in D geboren, 1=min. 1 Elternteil im Ausland geboren) |
| `FatherEdu` | Bildungsabschluss des Vaters (International Standard Classification of Education) |
| `MotherEdu` | Bildungsabschluss der Mutter (International Standard Classification of Education) |

***

## Quiz 4: Einfaktorielle und zweifaktorielle ANOVA {#Quiz4}

Im ersten Teil des Quiz verwenden wir den Datensatz `Behandlungsform.rda`. Sie können den Datensatz {{< icon name = "download" pack = "fas">}}[hier](https://courageous-donut-84b9e9.netlify.app/post/Behandlungsform.rda) herunterladen. Er kann aber auch wie gewohnt direkt von `PandaR` eingeladen werden.


```r
load(url("https://courageous-donut-84b9e9.netlify.app/post/Behandlungsform.rda"))
```

In dem Datensatz sind die Ausprägungen von 100 Personen auf 6 Variablen abgetragen. Für das Quiz sind dabei zwei Variablen relevant, die diesmal relativ selbsterklärend sind. KVT steht dabei für kognitive Verhaltenstherapie.

| Variable | Bedeutung |
| --- | --- |
| `Depression` | Depressivitätsausprägung |
| `Therapieform` | Form der Therapie (Kontrolle, KVT, blended Care KVT) |


Im zweiten Teil des Quiz arbeiten wir mit dem `nature`-Datensatz. Sie können den Datensatz {{< icon name = "download" pack = "fas">}}[hier](https://courageous-donut-84b9e9.netlify.app/post/nature.rda) herunterladen. Gleichzeitig kann er aber auch einfach über den folgenden Link direkt eingeladen werden.


```r
load(url("https://courageous-donut-84b9e9.netlify.app/post/nature.rda"))
```

Der Datensatz behandelt die Naturverbundenheit in 6 Items. Weiterhin sind Informationen hinsichtlich des Wohnortes vorhanden. Die Tabelle zeigt nochmal Variablennamen und Bedeutungen.

| Variable | Bedeutung |
| --- | --- |
| `Q1A` bis `Q6A` | Items zur Naturverbundenheit |
| `urban` | Typ des Wohnortes |
| `continent` | Kontinent des Wohnortes |

***

## Quiz 5: Varianzanalyse mit Messwiederholung {#Quiz5}

Für das Quiz wurde der Datensatz zum **Alkoholkonsum von Jugendlichen** von Curran, Stice und Chassin (1997), der auch schon im Tutorial verwendet wurde, um weitere Messzeitpunkte erweitert, um ein neues Setting für das Quiz zu demonstrieren. Die neuen Daten sind also nicht mehr aus der Studie bzw. gemessen, sondern enthalten zusätzliche simulierte Werte.

Sie können den Datensatz {{< icon name = "download" pack = "fas">}}[hier](https://courageous-donut-84b9e9.netlify.app/post/alc_extended.rda) herunterladen. So laden wir die Daten direkt über `PandaR`:


```r
load(url("https://courageous-donut-84b9e9.netlify.app/post/alc_extended.rda"))
```

Im Environment sollten nun zwei Datensätze erscheinen. Wie bereits beschrieben, handelt es sich bei diesen um Erweiterungen des ursprünglichen Datensatzes. Der Datensatz `alc17` hat eine Variable mehr (`alcuse.17`), während `alc18` nochmal 2 weitere zusätzliche Variablen (`treat` und `alcuse.18`) hat. Im Quiz wird stets beschrieben, mit welchem Datensatz Sie arbeiten sollen.

Insgesamt existieren die folgenden Variablen:

| Variable | Bedeutung | Kodierung |
| --- | --- | --- |
| `id` | Personen-Identifikator |  |
| `male` | Geschlecht | 0 = weiblich, 1 = männlich |
| `peer` | berichtetes Ausmaß, in dem Peers Alkohol konsumieren | 0 = keine, 5 = alle |
| `coa` | Kind eines/einer Alkoholiker:in ("child of alcoholic") | 0 = nein, 1 = ja |
| `alcuse.14` | selbstberichtete Häufigkeit, mit der Alkohol im Alter von 14 Jahren konsumiert wird | 0 = nie, 7 = täglich |
| `alcuse.15` | selbstberichtete Häufigkeit, mit der Alkohol im Alter von 15 Jahren konsumiert wird | 0 = nie, 7 = täglich |
| `alcuse.16` | selbstberichtete Häufigkeit, mit der Alkohol im Alter von 16 Jahren konsumiert wird | 0 = nie, 7 = täglich |
| `alcuse.17` | selbstberichtete Häufigkeit, mit der Alkohol im Alter von 17 Jahren konsumiert wird | 0 = nie, 7 = täglich |
| `treat` | Behandlung | 0 = nein, 1 = ja |
| `alcuse.18` | selbstberichtete Häufigkeit, mit der Alkohol im Alter von 18 Jahren konsumiert wird | 0 = nie, 7 = täglich |

***
 
## Quiz 6: Quadratische & Interaktionseffekte und Loops & Funktionen {#Quiz6}

Für dieses Quiz werden überwiegend selbstständig Daten erzeugt oder Code geschrieben. Für den ersten Teil des Quizzes verwenden wir einen simulierten Datensatz, der einige nennenswerte Aspekte der moderierten Regression aufzeigt. Den Datensatz können Sie {{< icon name = "download" pack = "fas">}}[hier](https://courageous-donut-84b9e9.netlify.app/post/Interaction.rda) herunterladen oder Sie laden ihn direkt via


```r
load(url("https://courageous-donut-84b9e9.netlify.app/post/Interaction.rda"))
```

Der Datentsatz besteht aus $n=1234$ Beobachtungen auf 3 Variablen:

| Variable | Beispiel | Bedeutung |
| --- | --- | --- |
| `Y` | Arbeitszufriedenheit | Abhängige Variable |
| `X1` | Arbeitskomplexität | Prädiktor 1 |
| `X2` | Handlungsspielraum | Prädiktor 2 |


Da die Daten simuliert sind, tragen sie keine inhaltliche Bedeutung. Sie könnten sich beispielsweise folgende Variablen vorstellen: _`Y` = Arbeitszufriedenheit, `X1` = Arbeitskomplexität, `X2` = Handlungsspielraum. In diesem Setting ist es sinnvoll, nichtlineare Effekte zu untersuchen, da anzunehmen wäre, dass zu leichte Arbeit als langweilig und zu komplexe Arbeit als überfordernd eingeschätzt werden könnte und sich entsprechend beides negativ auf die Zufriedenheit auswirkt (Annahme quadratischer Effekt von Komplexität). Genauso kann angenommen werden, dass sich Handlungsspielraum besonders bei komplexen Jobs positiv auswirkt (Annahme einer Interaktion). Auch könnte es einen Sättigungseffekt von Handlungsspielraum geben, sodass nur bis zu einem bestimmten Punkt mehr Handlungsspielraum auch zu einer höheren Zufriedenheit führt (Annahme quadratischer Effekt von Handlungsspielraum). **Das sind natürlich nur Beispiele zur Verdeutlichung, die Daten wurden keinen echten Zusammenhängen nachempfunden.**_

***

## Weiterer Datensatz
Der `mdbf`-Datensatz enthält 98 Beobachtungen auf 12 Variablen, allesamt Items des **M**ehr**d**imensionalen **B**efindlichkeits**f**ragebogens. In diesem Fragebogen werden Adjektive zur Beschreibung der aktuellen Stimmung genutzt, um die drei Dimensionen der Stimmung - Gut vs. Schlecht, Wach vs. Müde und Ruhig vs. Unruhig - zu erheben. Dafür laden wir zunächst {{< icon name = "download" pack = "fas">}}[hier](https://courageous-donut-84b9e9.netlify.app/post/mdbf.rda) den mdbf-Datensatz herunter oder wir laden ihn direkt von der `PandaR`-Website, und schauen uns die ersten Zeilen an.


```r
load(url("https://courageous-donut-84b9e9.netlify.app/post/mdbf.rda"))
```

| Variable | Adjektiv | Richtung | Dimension | 
| --- | --- | --- | --- |
| `stim1` | zufrieden | positiv | Gut vs. Schlecht |
| `stim2` | ausgeruht | positiv | Wach vs. Müde |
| `stim3` | ruhelos | negativ | Ruhig vs. Unruhig |
| `stim4` | schlecht | negativ | Gut vs. Schlecht |
| `stim5` | schlapp | negativ | Wach vs. Müde |
| `stim6` | gelassen | positiv | Ruhig vs. Unruhig |
| `stim7` | müde | negativ | Wach vs. Müde |
| `stim8` | gut | positiv | Gut vs. Schlecht |
| `stim9` | unruhig | negativ | Ruhig vs. Unruhig |
| `stim10` | munter | positiv | Wach vs. Müde |
| `stim11` | unwohl | negativ | Gut vs. Schlecht |
| `stim12` | entspannt | positiv | Ruhig vs. Unruhig |

In der Spalte *Dimension* sehen wir, dass die Items 3 verschiedene Dimensionen abbilden: *Gut vs. Schlecht*, *Wach vs. Müde* und *Ruhig vs. Unruhig*. Die Items sind dabei unterschiedlich gepolt - die Adjektive "ausgeruht" und "schlapp" erfassen beide die Dimension *Wach vs. Müde*, jedoch in unterschiedlicher Ausrichtung.
