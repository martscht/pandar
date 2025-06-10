---
title: Datensätze
type: post
date: '2022-04-11'
slug: datensaetze
categories: ["Daten"]
tags:
  - Daten
subtitle: 'Übersicht über alle verwendeten Datensätze auf pandaR'
summary: ''
authors: [rouchi, schultze]
featured: no
banner:
  image: "/header/fire_exit.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/126532)"
projects: []

reading_time: false
share: false

output:
  html_document:
    keep_md: true
---




Auf der folgenden Seite werden alle Datensätze aufgeführt, mit denen in den verschiedenen Tutorials auf `pandaR` gearbeitet wird. Die Datensätze sind alphabetisch sortiert und können teilweise direkt über diese Seite heruntergeladen werden. Hier eine Übersicht:

| Beschreibung | Direkter Download |
| ----- | --- |
| [Achtsamkeit und Depression](#achtsamkeit-und-depression-raw_data) |  [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/awz3d/download) |
| [Alkoholkonsum von Jugendlichen](#alkoholkonsum-von-jugendlichen-alc) | [{{< icon name="download" pack="fas" >}} `alc` ](/daten/alc.rda) |
[Arbeitsstress bei Call-Center-Mitarbeiter:innen](#arbeitsstress-bei-call-center-mitarbeiterinnen-stressatwork) | [{{< icon name="download" pack="fas" >}} `StressAtWork` ](/daten/StressAtWork.rda) |
| [Bildungsinvestitionen auf der Welt](#bildungsinvestitionen-auf-der-welt-edu_exp) | [{{< icon name="download" pack="fas" >}} `edu_exp` ](/daten/edu_exp.rda) 
| [Bullyingprävention bei Jugendlichen](#bullyingprävention-bei-jugendlichen-fairplayer) | [{{< icon name="download" pack="fas" >}} `fairplayer` ](/daten/faiplayer.rda) |
| [Depressivität](#depressivität-depression) | [{{< icon name="download" pack="fas" >}} `Depression` ](/daten/Depression.rda) |
| [Die Big Five Persönlichkeitsdimensionen](#die-big-five-persönlichkeitsdimensionen-big5) | [{{< icon name="download" pack="fas" >}} `Big5` ](/daten/Big5_EFA.rda) |
| [Distorted News](#distorted-news-osf) | [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/download/k4xcv/) |
| [Effektivität der CBT bei Depression](#effektivität-der-cbt-bei-depression-f2f_cbt) | _Teil des Pakets `metafor`_ |
| [Einstellungsentscheidungen](#einstellungsentscheidungen-assessment) | [{{< icon name="download" pack="fas" >}} `Assessment` ](/daten/Assessment.rda) |
|  [Entwicklung der Weltbevölkerung](#entwicklung-der-weltbevölkerung-worldpopulation) | [{{< icon name="download" pack="fas" >}} `WorldPopulation` ](/daten/WorldPopulation.rda) |
| [Erfahrungen in Beziehungen](#erfahrungen-in-beziehungen-ecr) | [{{< icon name="download" pack="fas" >}} `ecr` ](/daten/ecr.rda)
| [Fragebogendaten aus dem ersten Semester 22](#fragebogendaten-aus-dem-ersten-semester-fb22) |  [{{< icon name="download" pack="fas" >}} `fb22` ](/daten/fb22.rda) |
| [Fragebogendaten aus dem ersten Semester 23](#fragebogendaten-aus-dem-ersten-semester-fb23) | [{{< icon name="download" pack="fas" >}} `fb23`](/daten/fb23.rda) |
| [Fragebogendaten aus dem ersten Semester 24](#fragebogendaten-aus-dem-ersten-semester-fb24) | [{{< icon name="download" pack="fas" >}} `fb24`](/daten/fb24.rda) |
| [Gender, Drug, and Depression](#gender-drug-and-depression-osf) | [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/prc92/download) |
| [Gewissenhaftigkeit und Medikamenteneinnahme](#gewissenhaftigkeit-und-medikamenteneinnahme-data_combined) |  _Teil des Pakets `metafor`_ |
| [Hauptkomponentenanalyse](#hauptkomponentenanalyse-pca) | [{{< icon name="download" pack="fas" >}} `PCA` ](/daten/PCA.RData) |
| [HeckData (keine Ahnung, worum es bei diesem Datensatz eigentlich geht)](#heckdata-heckdata) | [{{< icon name="download" pack="fas" >}} `HeckData` ](/daten/HeckData.rda) |
| [Internetintervention für psychische Störungen](#internetintervention-für-psychische-störungen-osf) | [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/zc8ut/download) |
| [Interozeptive Aufmerksamkeit und Genauigkeit](#interozeptive-aufmerksamkeit-und-genauigkeit-body) | [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/j6ef3/download) |
| [Items der Generic Conspiracist Beliefs Scale](#items-der-generic-conspiracist-beliefs-scale-conspiracy_cfa) | [{{< icon name="download" pack="fas" >}} `conspiracy_cfa` ](/daten/conspiracy_cfa.rda) |
| [Kooperationsbereitschaft von Geschwistern](#kooperationsbereitschaft-von-geschwistern-datakooperation) | _via Syntax erstellt_ |
| [Kulturelle Unterschiede in Korruptionsbestrafung](#kulturelle-unterschiede-in-korruptionsbestrafung-punish) | [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/4wypx/download)
| [Lesekompetenz in der PISA-Erhebung](#lesekompetenz-in-der-pisa-erhebung-pisa2009) | [{{< icon name="download" pack="fas" >}} `PISA2009` ](/daten/PISA2009.rda) |
| [Machiavellismus-Fragebogen](#machiavellismus-fragebogen-mach) | [{{< icon name="download" pack="fas" >}} `mach` ](/daten/mach.rda) |
| [Major Depression](#major-depression-data) | [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/g6ya4/download) |
| [Mehrdimensionaler Befindlichkeitsfragebogen](#mehrdimensionaler-befindlichkeitsfragebogen-mdbf) | [{{< icon name="download" pack="fas" >}} `mdbf` ](/daten/mdbf.rda) |
| [Mental Health and Social Contact During the COVID-19 Pandemic](#mental-health-and-social-contact-during-the-covid-19-pandemic-data) | [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/qev5n/download) |
| [Naturverbundenheit](#naturverbundenheit-nature) | [{{< icon name="download" pack="fas" >}} `nature` ](/daten/nature.rda) |
| [Nerdiness](#nerdiness-nerddata) | [{{< icon name="download" pack="fas" >}} `NerdData` ](/daten/NerdData.rda) |
| [Parental Burnout](#parental-burnout-burnout) | [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/qev5n/download) |
| [Psychisches Wohlbefinden von Individuen während des Lockdowns in Frankreich](#psychisches-wohlbefinden-von-individuen-während-des-lockdowns-in-frankreich-lockdown) | [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/dc6me/download)
| [Quasi-Experimentelle Therapiestudie](#quasi-experimentelle-therapiestudie-cbtdata) | [{{< icon name="download" pack="fas" >}} `CBTdata` ](/daten/CBTdata.rda) |
| [Schulleistungen](#schulleistungen-schulleistungen) | [{{< icon name="download" pack="fas" >}} `Schulleistungen` ](/daten/Schulleistungen.rda) |
| [Skalenwerte der Generic Conspiracist Beliefs Scale](#skalenwerte-der-generic-conspiracist-beliefs-scale-conspiracy) | [{{< icon name="download" pack="fas" >}} `conspiracy` ](/daten/conspiracy.rda) |
| [Students in Classes](#students-in-classes-studentsinclasses) | [{{< icon name="download" pack="fas" >}} `StudentsInClasses` ](/daten/StudentsInClasses.rda) |
| [Therapieerfolg](#therapieerfolg-therapy) | [{{< icon name="download" pack="fas" >}} `Therapy` ](/daten/Therapy.rda) |
| [Titanic](#titanic-titanic) |  [{{< icon name="download" pack="fas" >}} `Titanic` ](/daten/Titanic.rda) |
| [Traumatische Erlebnisse und psychische Störungen](#traumatische-erlebnisse-und-psychische-störungen-trauma) | [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/a9vun/download) |
| [Trivia](#trivia-trivia) | [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/download/7ekb4/)
| [Vegan](#vegan-vegan) | [{{< icon name="download" pack="fas" >}} OSF ](https://osf.io/download/rctkf/)
| [Vergleich von Behandlungsformen](#vergleich-von-behandlungsformen-behandlungsform) | [{{< icon name="download" pack="fas" >}} `Behandlungsform` ](daten/Behandlungsform.rda)
| [Xmas](#xmas-xmas) | [{{< icon name="download" pack="fas" >}} `Xmas` ](/daten/Xmas.rda) |

---

## Achtsamkeit und Depression (`raw_data`)

<!-- <details> -->
<!--   <summary>Datensatz</summary> -->
### Beschreibung

Beim Datensatz stammt von Rubin (2020) und ist auf dem `Open Science Framework` zu finden. Er beschäftigt sich mit der Untersuchung von Variablen, die den Zusammenhang zwischen Achtsamkeit und Depression mithilfe einer Netzwerkanalyse untersuchen wollen.

### Datensatz laden


```r
raw_data <- readRDS(url("https://osf.io/awz3d/download"))
```


```r
names(raw_data) <- c("observe", "describe", "awaren.", "nonjudg.",
                     "nonreact.", "interest",  "emotions",  "sleep",
                     "tired",  "appetite", "selfim.",
                     "concentr.", "speed")
```

### Größe

Der Datensatz besteht aus 384 Beobachtungen auf 13 Variablen.

### Variablen

In der folgenden Tabelle erfolgt eine Übersicht der wichtigsten Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| ---- | ---- | ---- |
| `observe` | Wahrnehmen | 1 = Nie oder selten zutreffend, 5 = Sehr oft oder immer zutreffend |
| `describe` | Beschreiben |  1 = Nie oder selten zutreffend, 5 = Sehr oft oder immer zutreffend  |
| `awaren.` | Bewusst handeln |  1 = Nie oder selten zutreffend, 5 = Sehr oft oder immer zutreffend |
| `nonjudg.` | Nichturteilen |  1 = Nie oder selten zutreffend, 5 = Sehr oft oder immer zutreffend  |
| `nonreact.` | Nichtreagieren |  1 = Nie oder selten zutreffend, 5 = Sehr oft oder immer zutreffend  |
| `interest` | Interessensverlust | *standardisierter Skalenwert* |
| `emotions` | anhaltende gedrückte Stimmung | *standardisierter Skalenwert* |
| `sleep` | Schlaflosigkeit | *standardisierter Skalenwert* |
| `tired` | Müdigkeit | *standardisierter Skalenwert* |
| `appetite` | Appetitstörung | *standardisierter Skalenwert* |
| `selfim.` | negatives Selbstbild | *standardisierter Skalenwert* |
| `concentr.` | Konzentrationsschwierigkeiten | *standardisierter Skalenwert* |
| `speed` | Hemmung von Antrieb und Denken | *standardisierter Skalenwert* |

Die Variablen *observe*, *describe*, *awareness*, *nonjudging* und *nonreactivity* bezeichnen die **fünf Facetten der Achtsamkeit** von Baer et al. (2006). Die 8 weiteren Variablen beschreiben eine dysfunktionale, meist negative Veränderung in dem bezeichneten Lebensaspekt im Zuge einer **Depression**.

### Fehlende Werte

Im Datensatz liegen keine fehlenden Werte vor.

<!-- </details> -->

### Auftreten
Achtsamkeit und Depression wird in [Netzwerkanalyse im Querschnitt](/lehre/klipps-legacy/querschnittliche-netzwerke-legacy) [[Klipps Legacy](/category/klipps-legacy/)] genutzt.

---

## Alkoholkonsum von Jugendlichen (`alc`)

<!-- <details><summary>Datensatz</summary> -->

### Beschreibung
Der Datensatz stammt aus einer Erhebung von Curran, Stice und Chassin (1997) in der der **Alkoholkonsum von Jugendlichen** längsschnittlich untersucht wurde. Dazu wurde der Selbstbericht über den eigenen Alkoholkonsum mit 14, 15 und 16 Jahren, sowie die Trinkgewohnheiten der Eltern und Peers erfragt. Zusätzlich wurden demografische Variablen erhoben.

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/alc.rda"))
```

### Größe
Der Datensatz besteht aus 82 Beobachtungen auf 7 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Bedeutung | Kodierung |
| --- | ---- | ---- |
| `id` | Personenidentifikator | *Nummer* |
| `male` | Geschlecht | 0 = weiblich, 1 = männlich |
| `peer` | berichtetes Ausmaß, in dem Peers Alkohol konsumieren | 0 = keine, 5 = alle |
| `coa` | Kind eines/einer Alkoholiker:in ("child of alcoholic") | 0 = nein, 1 = ja |
| `alcuse.14` | selbstberichtete Häufigkeit, mit der Alkohol im Alter von 14 Jahren konsumiert wird | 0 = nie, 7 = täglich |
| `alcuse.15` | selbstberichtete Häufigkeit, mit der Alkohol im Alter von 15 Jahren konsumiert wird | 0 = nie, 7 = täglich |
| `alcuse.16` | selbstberichtete Häufigkeit, mit der Alkohol im Alter von 16 Jahren konsumiert wird | 0 = nie, 7 = täglich |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.

### Auftreten
Alc wird in [Varianzanalyse mit Messwiederholung](/lehre/statistik-ii/anova-iii) [[Statistik II](/category/statistik-ii/)] genutzt.

### Erweiterung 

Für das Quiz ANOVA III in PsyBSc7 wurde der Datensatz nochmal in zwei getrennten Formaten erweitert. Die erweiterten Daten sind simulationsbasiert. Die Daten können mit folgendem Befehl eingeladen werden:


```r
load(url("https://pandar.netlify.app/daten/alc_extended.rda"))
```

Im Environment erscheinen zwei Datensätze. Der Datensatz `alc17` hat eine Variable mehr (`alcuse.17`), während `alc18` nochmal 2 weitere zusätzliche Variablen (`treat` und `alcuse.18`) hat.

Hier folgt nochmal eine genauere Aufstellung der simulierten Variablen.

| Variable | Bedeutung | Kodierung |
| --- | --- | --- |
| `alcuse.17` | selbstberichtete Häufigkeit, mit der Alkohol im Alter von 17 Jahren konsumiert wird | 0 = nie, 7 = täglich |
| `treat` | Behandlung | 0 = nein, 1 = ja |
| `alcuse.18` | selbstberichtete Häufigkeit, mit der Alkohol im Alter von 18 Jahren konsumiert wird | 0 = nie, 7 = täglich |

<!-- </details> -->

---

## Arbeitsstress bei Call-Center-Mitarbeiter:innen (`StressAtWork`)

<!-- <details><summary>Datensatz</summary> -->

### Beschreibung
Der Datensatz ist eine Zusammenstellung aus mehreren Studien der Arbeits- und Organisationspsychologie-Abteilung der Goethe-Universität, in welchem Call-Center-Mitarbeiter:innen untersucht wurden. Der Datensatz enthält das Geschlecht der Proband:innen, sowie ausgewählte Messungen der Variablen Zeitdruck und Arbeitsorganisationale Probleme aus dem Instrument zur stressbezogenen Tätigkeitsanalyse (ISTA) von Semmer, Zapf und Dunckel (1999), Psychosomatische Beschwerden (auch "Befindlichkeit") aus der Psychosomatischen Beschwerdenliste von Mohr (1986), sowie Messungen zu Subskalen von Burnout: Emotionale Erschöpfung und Leistungserfüllung aus Maslachs Burnout-Inventar (Maslach & Jackson, 1986) in der deutschen Übersetzung von Büssing und Perrar (1992).

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/StressAtWork.rda"))
```

### Größe
Der Datensatz besteht aus 305 Beobachtungen auf 34 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Bedeutung | Kodierung |
| --- | ---- | ---- |
| `sex` | Geschlecht der Proband:innen | 1 = weiblich, 2 = männlich |
| `zd1`, `zd2` & `zd6` | Zeitdruck | 1 = Trifft nicht zu, 5 = Trifft voll und ganz zu |
| `aop3`, `aop4` & `aop8` | Arbeitsorganisationale Probleme | 1 = Trifft nicht zu, 5 = Trifft voll und ganz zu |
| `bf1`-`bf20` | Psychosomatische Beschwerden | 1 = Trifft nicht zu, 5 = Trifft voll und ganz zu |
| `bo1`, `bo6`, `b19` & `b12` | Emotionale Erschöpfung | 1 = Trifft nicht zu, 7 = Trifft voll und ganz zu |
| `bo7`, `bo8`& `bo21` | Leistungserfüllung | 1 = Trifft nicht zu, 7 = Trifft voll und ganz zu |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.

<!-- </details> -->

### Auftreten
StressAtWork wird in [Modelle für Gruppenvergleiche](/lehre/fue-ii/msa) [[Fue II](/category/fue-ii/)] und [Pfadanalysen und Strukturgleichungsmodelle](/lehre/fue-ii/sem) [[Fue II](/category/fue-ii/)] genutzt.

---

## Bildungsinvestitionen auf der Welt (`edu_exp`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Wir benutzen für unsere Interaktion mit `ggplot2` öffentlich zugängliche Daten aus verschiedenen Quellen, die dankenswerterweise von [Gapminder](https://www.gapminder.org/) zusammengetragen werden. Für diesen Abschnitt gucken wir uns dafür mal an, wie viele verschiedene Länder in die Bildung investieren - diese Daten stammen ursprünglich von der [Weltbank](https://data.worldbank.org).

### Datensatz laden

```r
load(url('https://pandar.netlify.app/daten/edu_exp.rda'))
```

### Größe
Der Datensatz besteht aus 4316 Beobachtungen auf 12 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt |
| --- | ---- |
| `geo` | Länderkürzel, das zur Identifikation der Länder über verschiedene Datenquellen hinweg genutzt wird |
| `Country` | der Ländername im Englischen |
| `Wealth` | Wohlstandseinschätzung des Landes, unterteilt in fünf Gruppen |
| `Region` | Einteilung der Länder in die vier groben Regionen `africa`, `americas`, `asia` und `europe` |
|`Year` | Jahreszahl |
| `Population` | Bevölkerung |
| `Expectancy` | Lebenserwartung eines Neugeborenen, sollten die Lebensumstände stabil bleiben |
| `Income` | Stetiger Wohlstandsindikator für das Land (GDP pro Person) |
| `Primary` | Staatliche Ausgaben pro Schüler:in in der primären Bildung als Prozent des `income` (GDP pro Person) |
| `Secondary` | Staatliche Ausgaben pro Schüler:in in der sekundären Bildung als Prozent des `income` (GDP pro Person) |
|`Tertiary` | Staatliche Ausgaben pro Schüler:in oder Student:in in der tertiären Bildung als Prozent des `income` (GDP pro Person) |
| `Index` | Education Index des United Nations Development Programme |

### Fehlende Werte
Insgesamt liegen im Datensatz 10147 fehlende Werte vor. Folgende Variablen enthalten keine fehlenden Werte:

* `geo`
* `Country`
* `Wealth`
* `Region`
* `Year`
* `Population`

<!-- </details> -->

### Auftreten
edu_exp wird in [Grafiken mit ggplot2](/lehre/statistik-ii/grafiken-ggplot2) [[Statistik II](/category/statistik-ii/)], [Scatterplots und interaktiven Grafiken mit ggplot2](/lehre/statistik-ii/grafiken2-ggplot2) [[Statistik II](/category/statistik-ii/)], [gganimate](/workshops/ggplotting/gganimate) [[Ggplotting](/category/ggplotting/)], [ggplotpourri](/workshops/ggplotting/ggplotpourri) [[Ggplotting](/category/ggplotting/)], [Datenaufbereitung für ggplotting](/workshops/ggplotting/ggplotting-daten) [[Ggplotting](/category/ggplotting/)], [Explorative Grafiken](/workshops/ggplotting/ggplotting-exploration) [[Ggplotting](/category/ggplotting/)], [ggplot2 Intro](/workshops/ggplotting/ggplotting-intro) [[Ggplotting](/category/ggplotting/)], [Hübschere Grafiken mit ggplot](/workshops/ggplotting/ggplotting-themes) [[Ggplotting](/category/ggplotting/)], [plotly](/workshops/ggplotting/plotly) [[Ggplotting](/category/ggplotting/)], [Tag 01](/workshops/refresher/refresher-day1) [[Refresher](/category/refresher/)], [Tag 02](/workshops/refresher/refresher-day2) [[Refresher](/category/refresher/)] und [Übungen](/workshops/refresher/refresher-uebungen) [[Refresher](/category/refresher/)] genutzt.

---

## Bullyingprävention bei Jugendlichen (`fairplayer`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Der Datensatz stammt aus einer Studie von Bull, Schultze & Scheithauer (2009), in der die Effektivität eines Interventionsprogramms zur Bullyingprävention bei Jugendlichen untersucht wurde.

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/fairplayer.rda"))
```

### Größe
Der Datensatz besteht aus 155 Beobachtungen auf 31 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| --- | ---- | ---- |
| `id` | Personenidentifikator | Nummerierung |
| `class` | Klasse | Zahl |
| `grp` | Interventionsgruppe | 1 = CG, 2 = IGS, 3 = IGL |
| `sex` | Geschlecht | 1 = weiblich, 2 = männlich |
| `ra1t1`-`ra1t3` | 1. Item zur relationalen Aggression zu drei Messzeitpunkten  | 1 = trifft nicht zu, 5 = trifft voll und ganz zu |
| `ra2t1`-`ra2t3` | 2. Item zur relationalen Aggression zu drei Messzeitpunkten  | 1 = trifft nicht zu, 5 = trifft voll und ganz zu |
| `ra3t1`-`ra3t3` | 3. Item zur relationalen Aggression zu drei Messzeitpunkten  | 1 = trifft nicht zu, 5 = trifft voll und ganz zu |
| `em1t1`-`em1t3` | 1. Item zur Empathie zu drei Messzeitpunkten  | 1 = trifft nicht zu, 5 = trifft voll und ganz zu |
| `em2t1`-`em2t3` | 2. Item zur Empathie zu drei Messzeitpunkten  | 1 = trifft nicht zu, 5 = trifft voll und ganz zu |
| `em3t1`-`em3t3` | 3. Item zur Empathie zu drei Messzeitpunkten  | 1 = trifft nicht zu, 5 = trifft voll und ganz zu |
| `si1t1`-`si1t3` | 1. Item zur Sozialen Intelligenz zu drei Messzeitpunkten  | 1 = trifft nicht zu, 5 = trifft voll und ganz zu |
| `si2t1`-`si2t3` | 2. Item zur Sozialen Intelligenz zu drei Messzeitpunkten  | 1 = trifft nicht zu, 5 = trifft voll und ganz zu |
| `si3t1`-`si3t3` | 3. Item zur Sozialen Intelligenz zu drei Messzeitpunkten  | 1 = trifft nicht zu, 5 = trifft voll und ganz zu |

### Fehlende Werte
In dem Datensatz liegen 830 fehlende Werte vor. Folgende Variablen enthalten keine fehlenden Werte:

* `id`

<!-- </details> -->

### Auftreten
fairplayer wird in [Einführung in lavaan](/lehre/fue-ii/lavaan-intro) [[Fue II](/category/fue-ii/)] und [Übungen](/workshops/refresher/refresher-uebungen) [[Refresher](/category/refresher/)] genutzt.

---

## Depressivität (`Depression`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Beim Datensatz handelt es sich um fiktive Daten bezüglich Depressionswerten in Beziehung zu einigen weiteren Variablen.

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/Depression.rda"))
```

### Größe
Der Datensatz besteht aus 90 Beobachtungen auf 6 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Kodierung |
| --- | ---- |
| `Lebenszufriedenheit` | 1 - 10 |
| `Episodenanzahl` | 1 - 10 |
| `Depressivitaet` | 1 - 10 |
| `Neurotizismus` | 1 - 10 |
| `Intervention` | 1 = Kontrollgruppe, 2 = verhaltenstherapiebasiertes Coaching, 3 = verhaltenstherapiebasiertes Coaching inklusive Gruppenübung | 
| `Geschlecht` | 0 = männlich, 1 = weiblich | 


### Fehlende Werte
In dem Datensatz liegen keine fehlenden Werte vor.

<!-- </details> -->

### Auftreten
depression wird in [Einleitung und Wiederholung KliPPs](/lehre/klipps-legacy/einleitung-klipps-legacy) [[Klipps Legacy](/category/klipps-legacy/)], [Multiple Regression und Ausreißerdiagnostik](/lehre/klipps-legacy/regression-ausreisser-klipps-legacy) [[Klipps Legacy](/category/klipps-legacy/)] und [Partial- & Semipartialkorrelation](/lehre/statistik-ii/partial) [[Statistik II](/category/statistik-ii/)] genutzt.

---

## Die Big Five Persönlichkeitsdimensionen (`Big5`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Der Originaldatensatz ist ein Onlinedatensatz, wird seit 2012 erfasst und ist auf [openpsychometrics.org](https://openpsychometrics.org/_rawdata/) als *.zip* downloadbar. Bisher haben über **19700** Probanden aus der ganzen Welt teilgenommen. Zu jeder der fünf Facetten gibt es 10 Fragen. Der Fragebogen ist auf [personality-testing.info](http://personality-testing.info/tests/BIG5.php) einzusehen.
Um das Ganze etwas übersichtlicher zu gestalten, betrachten wir einen gekürzten Datensatz. Im Datensatz *Big5_EFA.rda* befinden sich 15 Items aus dem Big-5 Persönlichkeitsfragebogen. Hier werden von den 10 Items pro Facette jeweils die ersten drei verwendet.


### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/Big5_EFA.rda"))
```

### Größe
Der Datensatz besteht aus 19711 Beobachtungen auf 19 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der wichtigsten Variablen und ihre Bedeutungen. Die jeweiligen Items sind von 1 bis 5 skaliert.

| Variable | Itemwortlaut |
| --- | ---- |
| `E1` | "I am the life of the party." |
| `E2` | "I don't talk a lot." |
| `E3` | "I feel comfortable around people." |
| `N1` | "I get stressed out easily." |
| `N2` | "I am relaxed most of the time." |
| `N3` | "I worry about things." |
| `A1` | "I feel little concern for others." |
| `A2` | "I am interested in people." |
| `A3` | "I insult people." |
| `C1` | "I am always prepared." |
| `C2` | "I leave my belongings around." |
| `C3` | "I pay attention to details." |
| `O1` | "I have a rich vocabulary." |
| `O2` | "I have difficulty understanding abstract ideas." |
| `O3` | "I have a vivid imagination." |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.

<!-- </details> -->

### Auftreten
Big5 wird in [Exploratorische Faktorenanalyse](/lehre/fue-ii/fue-efa) [[Fue II](/category/fue-ii/)] genutzt.

---

## Distorted News (`OSF`)

#### Beschreibung
Im Datensatz sind die Daten aus der 3. Teilstudie von Firschlich et al. (2021) enthalten. Dabei wurde in einem experimentellen Design untersucht, welche Auswirkung neutrale vs. ideologisch geladene Berichterstattung auf Wahrnehmung und Glaubhaftigkeitseinschätzung eines Nachrichtenbeitrags über einen deutschen Politiker hat. Der experimentelle Effekt soll dabei durch verschiedene Einstellungen moderiert werden. Distales outcome ist die Einschätzung des Politikers, von dem der Artikel handelt.

Frischlich, L., Hellmann, J.H., Brinkschulte, F., Becker, M., & Back, M.D. (2021). Right-wing authoritarianism, conspiracy mentality, and susceptibility to distorted alternative news. _Social Influence, 16_(1), 24-64, DOI: 10.1080/15534510.2021.1966499.

#### Datensatz laden

Der Datensatz wird in einem Skript reduziert und Variablen umbenannt. Dieses Skript kann mit folgendem Befehl ausgeführt werden:


```r
source("https://pandar.netlify.app/daten/Data_Processing_distort.R")
```



Im Environment erscheint dadurch der Datensatz `distort`.

### Größe
Der Datensatz besteht aus 474 Beobachtungen auf 17 Variablen.

### Variablen

In der folgenden Tabelle erfolgt eine Übersicht der ausgewählten Variablen und ihrer Bedeutungen.

| Variable | Bedeutung | Kodierung |
| --- | ---- | ---- |
| `id` | Teilnehmer:innen-ID |  |
| `sex` | Geschlecht | 1 = weiblich, 2 = männlich, 3 = divers |
| `age` | Alter |  |
| `stud` | Student:innenstatus | 0 = nein, 1 = ja |
| `east` | Wohnort in Ostdeutschland | 0 = nein, 1 = ja |
| `state` | Bundesland |  |
| `type` | Artikeltyp | 1 = verzerrt, 2 = neutral |
| `ideology` | Ideologie des Artikels | 1 = links, 2 = rechts |
| `leaning` | Politische Tendenz | 1 = extrem links, 5 = moderat, 9 = extrem rechts  |
| `attitude` | Einstellung zum Politiker | _Skalenwert_ |
| `views` | Mittelwert allgemeiner politischer Tendenz und sozialpolitischer Tendenz | 1 = ???, 5 = moderat, 9 = ??? |
| `rwa` | Rechtsextreme Autoritarismus | _Skalenwert_ |
| `cm` | Verschwörungsmentalität | _Skalenwert_ |
| `credibility` | Glaubwürdigkeit des Artikels | _Skalenwert_ |
| `perception` | Wahrnehmung des Politikers | _Skalenwert_ |
| `threat` | Bedrohung durch Geflüchtete | _Skalenwert_ |
| `marginal` | Gefühl der Marginalisierung | _Skalenwert_ |

### Fehlende Werte

Dieser Datensatz wurde zuvor mit einfacher Imputation ergänzt und enthält daher keine fehlenden Werte.

### Auftreten
OSF distort wird in [Inferenz und Modellauswahl in der multiplen Regression - Übungen](/lehre/statistik-ii/multreg-inf-mod-uebungen) [[Statistik II](/category/statistik-ii/)], [Tag 02](/workshops/refresher/refresher-day2) [[Refresher](/category/refresher/)] und [Übungen](/workshops/refresher/refresher-uebungen) [[Refresher](/category/refresher/)] genutzt.

---

## Effektivität der CBT bei Depression (`F2F_CBT`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Der Datensatz ist `R`-eigenen Paket `metafor` von Viechtbauer (2010) enthalten und stammt von einer Studie von López-López et al. (2019). Die Autor:innen haben die Effektivität der CBT (cognitive behavioural therapy [kognitive Verhaltenstherapie]) bei Depression untersucht und diese mit verschiedenen Kontrollbedingungen und unterschiedlichen Arten der CBT verglichen.

### Datensatz laden

```r
library(metafor)
F2F_CBT <- dat.lopez2019[dat.lopez2019$treatment == "F2F CBT",] # wähle nur Fälle mit F2F CBT
```

### Größe
Der Datensatz besteht aus 71 Beobachtungen auf 23 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Bedeutung | Kodierung |
| --- | ---- | ---- |
| `study` | verwendete Studie | *Autor:innen* |
| `treatment` | verwendete Therapieart oder Kontrollgruppe | "F2F CBT" = "Angesicht zu Angesicht"-CBT, “Multimedia CBT” = Online-CBT, “Placebo” = Placebo-Kontrollgruppe, “Wait list” = Wartelistenkontrollgruppe, “Hybrid CBT” = Mischung aus F2F und Multimedia, “No treatment” = klassische Kontrollgruppw, “TAU” = Treatment as Usual [Standardtherapie] |
| `scale` | Messinstrument Depression | BDI = Beck's Depressionsinventar, HAM-24 = Hamilton Rating Scale for Depression-24, PHQ-9 = Patient Health Questionnaire-9, HAM-17 = Hamilton Rating Scale for Depression-17, CES-D = Center for Epidemiologic Studies Depression Scale, BSI = Brief Symptom Inventory, SDS = Sheehan Disability Scale |
| `n` | Stichprobengröße | *n* |
| `diff` | standardisierte Differenz zwischen vor und nach der Intervention | Cohen's *d* |
| `se` | Standardfehler von `diff` | *se* |
| `group` | Dummy-Variable | 0 = Einzeltherapie, 1 = Gruppentherapie |
| `tailored` | gibt an, ob die Therapie individuell auf Patient:in zugeschnitten wurde | 0 = nein, 1 = ja |
| `sessions` | Anzahl der Therapiesitzungen | *Anzahl* |
| `length` | durchschnittliche Sitzungslänge | *Länge* |
| `intensity` | Intensität der Therapie | Produkt aus `session` und `length` |
| `multi` | Intervention enthielt Multimedia-Elemente | 0 = nein, 1 = ja |
| `cog` | Intervention enthielt kognitive Techniken  | 0 = nein, 1 = ja |
| `ba` | Intervention enthielt behaviorale Aktivierung  | 0 = nein, 1 = ja |
| `psed` | Intervention enthielt Psychoedukation  | 0 = nein, 1 = ja |
| `home` |  Intervention enthielt Hausaufgaben  | 0 = nein, 1 = ja |
| `prob` | Intervention enthielt Problemlösen  | 0 = nein, 1 = ja |
| `soc` | Intervention enthielt Training sozialer Kompetenzen  | 0 = nein, 1 = ja |
| `relax` | Intervention enthielt Entspannungstechniken  | 0 = nein, 1 = ja |
| `goal` | Intervention enthielt Zielsetzung  | 0 = nein, 1 = ja |
| `final` | Intervention enthielt Abschlussgespräch  | 0 = nein, 1 = ja |
| `mind` | Intervention enthielt Achtsamkeit  | 0 = nein, 1 = ja |
| `act` | Intervention enthielt *Acceptance and Commitment Therapy*  | 0 = nein, 1 = ja |

### Fehlende Werte
Im Datensatz liegen 20 fehlende Werte vor. Auf folgenden Variablen liegen keine fehlenden Werte vor:

* `authors`
* `year`
* `ni`
* `ri`
* `controls`
* `design`
* `a_measure`
* `c_measure`
* `meanage`
* `quality`

<!-- </details> -->

### Auftreten
F2F_CBT wird in [Metaanalysen in R](/lehre/klipps-legacy/metaanalysen-mw-legacy) [[Klipps Legacy](/category/klipps-legacy/)] genutzt.

---

## Einstellungsentscheidungen (`Assessment`)
### Beschreibung
Bei dem Datensatz handelt es sich um ein simuliertes Datenbeispiel zu Einstellungsentscheidungen in jungen Start-Ups.

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/Assessment.rda"))
```

### Größe
Der Datensatz besteht aus 1672 Beobachtungen auf 4 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt |
| --- | ---- |
| `Hired` | gibt an, ob die jeweilige Person eingestellt wurde |
| `Age` | ist das Alter in Jahren |
| `Expertise` | ist die Expertise der jeweiligen Person als Selbsteinschätzung auf einer 7-stufigen Likert-Skala |
| `Party` | gibt die politische Orientierung der Person in 3 Abstufungen an (Elected, right, left) |

### Fehlende Werte
In dem Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->

### Auftreten
Assessment wird in [Daten für die Übungen](/lehre/fue-i/msc1-daten) [[Fue I](/category/fue-i/)] genutzt.

---

## Entwicklung der Weltbevölkerung (`WorldPopulation`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Der Datensatz stammt von `Gapminder` und enthält Daten zur Entwicklung der Weltbevölkerung. Die Dokumentation des Datensatzes sowie seine Datenquellen sind hier einzusehen: [gapminder.org-Dokumentationen](https://www.gapminder.org/data/documentation/gd003/).

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/WorldPopulation.rda"))
```

### Größe
Der Datensatz besteht aus 221 Beobachtungen auf 2 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Bedeutung |
| --- | --- |
| `Year` | Jahreszahl |
| `Population` | Weltbevölkerung |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->

### Auftreten
WorldPopulation wird in [Regression V: nichtlineare Regression - exponentielles Wachstum](/lehre/statistik-ii/regression-v) [[Statistik II](/category/statistik-ii/)] genutzt.

---

## Erfahrungen in Beziehungen (`ecr`)

### Beschreibung
Die hier verwendeten Daten stammen aus dem ["Open-Source Psychometrics Project"](https://openpsychometrics.org/_rawdata/), einer Online-Plattform, die eine Sammlung an Daten aus verschiedensten Persönlichkeitstests zur Verfügung stellt. Bei den hier bereitgestellten Daten handelt es sich um eine Auswahl von Daten, die ausschließlich aus Deutschland stammt. Im Zentrum stehen die 36 Items der "Experiences in Close Relationships" Skala von Brennan et al. (1998).

### Datensatz laden

```r
load(url('https://pandar.netlify.com/daten/ecr.rda'))
```


### Größe
Der Datensatz besteht aus 554 Beobachtungen auf 38 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| --- | ---- | ---- |
| `gender` | Geschlecht | 1 = male, 2 = female, 3 = nonbinare |
| `age` | Alter |  |
| `Q1` | I prefer not to show a partner how I feel deep down. | 1 = strongly disagree; 5 = strongly agree |
| `Q2` | I worry about being abandoned. | 1 = strongly disagree; 5 = strongly agree |
| `Q3` | I am very comfortable being close to romantic partners. | 1 = strongly disagree; 5 = strongly agree |
| `Q4` | I worry a lot about my relationships. | 1 = strongly disagree; 5 = strongly agree |
| `Q5` | Just when my partner starts to get close to me I find myself pulling away. | 1 = strongly disagree; 5 = strongly agree |
| `Q6` | I worry that romantic partners wont care about me as much as I care about them. | 1 = strongly disagree; 5 = strongly agree |
| `Q7` | I get uncomfortable when a romantic partner wants to be very close. | 1 = strongly disagree; 5 = strongly agree |
| `Q8` | I worry a fair amount about losing my partner. | 1 = strongly disagree; 5 = strongly agree |
| `Q9` | I don't feel comfortable opening up to romantic partners. | 1 = strongly disagree; 5 = strongly agree |
| `Q10` | I often wish that my partner's feelings for me were as strong as my feelings for him/her. | 1 = strongly disagree; 5 = strongly agree |
| `Q11` | I want to get close to my partner, but I keep pulling back. | 1 = strongly disagree; 5 = strongly agree |
| `Q12` | I often want to merge completely with romantic partners, and this sometimes scares them away. | 1 = strongly disagree; 5 = strongly agree |
| `Q13` | I am nervous when partners get too close to me. | 1 = strongly disagree; 5 = strongly agree |
| `Q14` | I worry about being alone. | 1 = strongly disagree; 5 = strongly agree |
| `Q15` | I feel comfortable sharing my private thoughts and feelings with my partner. | 1 = strongly disagree; 5 = strongly agree |
| `Q16` | My desire to be very close sometimes scares people away. | 1 = strongly disagree; 5 = strongly agree |
| `Q17` | I try to avoid getting too close to my partner. | 1 = strongly disagree; 5 = strongly agree |
| `Q18` | I need a lot of reassurance that I am loved by my partner. | 1 = strongly disagree; 5 = strongly agree |
| `Q19` | I find it relatively easy to get close to my partner. | 1 = strongly disagree; 5 = strongly agree |
| `Q20` | Sometimes I feel that I force my partners to show more feeling, more commitment. | 1 = strongly disagree; 5 = strongly agree |
| `Q21` | I find it difficult to allow myself to depend on romantic partners. | 1 = strongly disagree; 5 = strongly agree |
| `Q22` | I do not often worry about being abandoned. | 1 = strongly disagree; 5 = strongly agree |
| `Q23` | I prefer not to be too close to romantic partners. | 1 = strongly disagree; 5 = strongly agree |
| `Q24` | If I can't get my partner to show interest in me, I get upset or angry. | 1 = strongly disagree; 5 = strongly agree |
| `Q25` | I tell my partner just about everything. | 1 = strongly disagree; 5 = strongly agree |
| `Q26` | I find that my partner(s) don't want to get as close as I would like. | 1 = strongly disagree; 5 = strongly agree |
| `Q27` | I usually discuss my problems and concerns with my partner. | 1 = strongly disagree; 5 = strongly agree |
| `Q28` | When I'm not involved in a relationship, I feel somewhat anxious and insecure. | 1 = strongly disagree; 5 = strongly agree |
| `Q29` | I feel comfortable depending on romantic partners. | 1 = strongly disagree; 5 = strongly agree |
| `Q30` | I get frustrated when my partner is not around as much as I would like. | 1 = strongly disagree; 5 = strongly agree |
| `Q31` | I don't mind asking romantic partners for comfort, advice, or help. | 1 = strongly disagree; 5 = strongly agree |
| `Q32` | I get frustrated if romantic partners are not available when I need them. | 1 = strongly disagree; 5 = strongly agree |
| `Q33` | It helps to turn to my romantic partner in times of need. | 1 = strongly disagree; 5 = strongly agree |
| `Q34` | When romantic partners disapprove of me, I feel really bad about myself. | 1 = strongly disagree; 5 = strongly agree |
| `Q35` | I turn to my partner for many things, including comfort and reassurance. | 1 = strongly disagree; 5 = strongly agree |
| `Q36` | I resent it when my partner spends time away from me. | 1 = strongly disagree; 5 = strongly agree |

### Fehlende Werte
Im Datensatz liegen 2 fehlenden Werte vor. Fehlende Werte sind dabei ausschließlich auf der Variable `gender` zu finden.

### Auftreten
ecr wird aktuell in keinem Beitrag genutzt.

---

## Fragebogendaten aus dem ersten Semester (`fb22`)

<!-- <details><summary>Datensatz</summary> -->

### Beschreibung
Der Datensatz `fb22` besteht aus Daten, die von den Studierenden selbst in den ersten Wochen der Veranstaltung PsyBSc2 erhoben wurden. Hierbei wurden eine Reihe von Variablen via eines Fragebogens auf `formr.org` erfragt und anschließend zu einem Datensatz zusammengefügt. Die Daten basieren somit auf wahren - anonymisierten - Werten der Studierenden. Der Fragebogen erfasst Daten zur Prokrastinationstendenz, Naturverbundenheit, Persönlichkeit (gemessen an den Big5), dem Studium sowie demografische Daten.

### Datensatz laden

```r
load(url('https://pandar.netlify.app/daten/fb22.rda'))
```

### Größe
Der Datensatz besteht aus 159 Beobachtungen auf 36 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| ---- | ---- | ---- |
| `prok1` - `prok10` | Items zur Prokrastinationstendenz *(Items 2,3,5,7 & 8 sind invertiert)* | 1 = "stimmt nicht", 4 = "stimmt genau" |
| `nr1` - `nr6` | Items zur Naturverbundenheit | 1 = stimme nicht zu, 5 = stimme zu |
| `lz` | Lebenszufriedenheit | *Skalenwert* |
| `extra` | Extraversion | *Skalenwert* |
| `vertr` | Verträglichkeit | *Skalenwert* |
| `gewis` | Gewissenhaftigkeit | *Skalenwert* |
| `neuro` | Neurotizismus | *Skalenwert* |
| `intel` | Intellekt | *Skalenwert* |
| `nerd` | Nerdiness Personality Attributes | *Skalenwert* |
| `grund` | Gründe für das Psychologiestudium | *Freitext* |
| `fach` | Interessenfach | 1 = Allgemeine, 2 = Biologische, 3 = Entwicklung, 4 = Klinische, 5 = Diag./Meth. |
| `ziel` | Arbeitsbranche nach Abschluss | 1 = Wirtschaft, 2 = Therapie, 3 = Forschung, 4 = Andere |
| `lerntyp` | Lerntyp | 1 = alleine, 2 = Gruppe, 3 = Mischtyp |
| `geschl` | Geschlecht | 1 = weiblich, 2 = männlich, 3 = anderes |
| `job` | Nebentätigkeit | 1 = nein, 2 = ja |
| `ort` | Derzeitiger Wohnort | 1 = Frankfurt, 2 = anderer |
| `ort12` | Wohnort vor 12 Monaten | 1 = Hessen, 2 = Deutschland, 3 = Ausland |
| `wohnen` | Aktuelle Wohnsituation | 1 = WG, 2 = bei Eltern, 3 = alleine, 4 = sonstiges |
| `uni1` - `uni4` | In Anspruch genommene Uni-Angebote | 0 = nein, 1 = ja |

### Fehlende Werte
Insgesamt liegen im Datensatz 102 fehlende Werte vor. Folgende Variablen enthalten keine fehlenden Werte:

* `prok1`
* `prok2`
* `prok3`
* `prok5`
* `prok6`
* `prok7`
* `prok8`
* `prok9`
* `prok10`
* `nr1`
* `nr2`
* `nr4`
* `nr5`
* `nr6`
* `vertr`
* `extra`
* `gewis`
* `neuro`
* `intel`
* `nerd`
* `uni1`
* `uni2`
* `uni3`
* `uni4`
<!-- </details> -->

### Auftreten
fb22 wird in [Freiwillige Übungsaufgaben (alle Abschnitte)](/lehre/statistik-i/zusatz-aufgaben) [[Statistik I](/category/statistik-i/)] und [Gewichtete Regression](/lehre/statistik-ii/gewichtete-reg) [[Statistik II](/category/statistik-ii/)] genutzt.

---

## Fragebogendaten aus dem ersten Semester (`fb23`)

<!-- <details><summary>Datensatz</summary> -->

### Beschreibung
Der Datensatz `fb23` besteht aus Daten, die von den Studierenden selbst in den ersten Wochen der Veranstaltung PsyBSc2 erhoben wurden. Hierbei wurden eine Reihe von Variablen via eines Fragebogens auf `formr.org` erfragt und anschließend zu einem Datensatz zusammengefügt. Die Daten basieren somit auf wahren - anonymisierten - Werten der Studierenden. Der Fragebogen erfasst Daten zur aktuellen Stimmung, Persönlichkeit (gemessen an den Big5), dem Studium sowie demografische Daten.

### Datensatz laden

```r
load(url('https://pandar.netlify.app/daten/fb23.rda'))
```

### Größe
Der Datensatz besteht aus 179 Beobachtungen auf 40 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| ---- | ---- | ---- |
| `mdbf1` - `mdbf12` | Items zur aktuellen Stimmung | 1 = stimmt nicht, 4 = stimmt genau |
| `lz` | Lebenszufriedenheit | *Skalenwert* |
| `extra` | Extraversion | *Skalenwert* |
| `vertr` | Verträglichkeit | *Skalenwert* |
| `gewis` | Gewissenhaftigkeit | *Skalenwert* |
| `neuro` | Neurotizismus | *Skalenwert* |
| `offen` | Offenheit für neue Erfahrungen | *Skalenwert* |
| `prok` | Prokrastinationstendenz | *Skalenwert* |
| `nerd` | Nerdiness Personality Attributes | *Skalenwert* |
| `grund` | Gründe für das Psychologiestudium | *Freitext* |
| `fach` | Interessenfach | 1 = Allgemeine, 2 = Biologische, 3 = Entwicklung, 4 = Klinische, 5 = Diag./Meth. |
| `ziel` | Arbeitsbranche nach Abschluss | 1 = Wirtschaft, 2 = Therapie, 3 = Forschung, 4 = Andere |
| `wissen` | Interesse an wissenschaftlichen Grundlagen | 1 = überhaupt nicht, 5 = sehr |
| `therap` | Interesse an anwendungsbezogenen Aspekten | 1 = überhaupt nicht, 5 = sehr |
| `lerntyp` | Lerntyp | 1 = alleine, 2 = Gruppe, 3 = Mischtyp |
| `hand` | Schreibhand | 1 = links, 2 = rechts |
| `job` | Nebentätigkeit | 1 = nein, 2 = ja |
| `ort` | Derzeitiger Wohnort | 1 = Frankfurt, 2 = anderer |
| `ort12` | Wohnort vor 12 Monaten | 1 = Hessen, 2 = Deutschland, 3 = Ausland |
| `wohnen` | Aktuelle Wohnsituation | 1 = WG, 2 = bei Eltern, 3 = alleine, 4 = sonstiges |
| `uni1` - `uni4` | In Anspruch genommene Uni-Angebote (*Studienberatung, Orientierungswoche, Uniparties, Unisport*) | 0 = nein, 1 = ja |
| `attent_pre` | Gewissenhafte Beantwortung (1. Befragung) | 1 = überhaupt nicht, 6 = voll und ganz |
| `gs_post` | Gute vs. Schlechte Stimmung (2. Befragung) | *Skalenwert* |
| `wm_post` | Wach vs. Müde (2. Befragung) | *Skalenwert* |
| `ru_post` | Ruhig vs. Unruhig (2. Befragung) | *Skalenwert* |
| `attent_post` | Gewissenhafte Beantwortung (2. Befragung) | 1 = überhaupt nicht, 6 = voll und ganz |

### Fehlende Werte
Insgesamt liegen im Datensatz 222 fehlende Werte vor. Folgende Variablen enthalten keine fehlenden Werte:

* `mdbf2`
* `mdbf3`
* `mdbf4`
* `mdbf5`
* `mdbf6`
* `mdbf7`
* `mdbf8`
* `mdbf9`
* `mdbf10`
* `mdbf11`
* `mdbf12`
* `extra`
* `gewis`
* `neuro`
* `offen`
* `prok`
* `nerd`
* `uni1`
* `uni2`
* `uni3`
* `uni4`

<!-- </details> -->

### Auftreten
fb23 wird in [Tag 02](/workshops/refresher/refresher-day2) [[Refresher](/category/refresher/)] genutzt.


---

## Fragebogendaten aus dem ersten Semester (`fb24`)

<!-- <details><summary>Datensatz</summary> -->

### Beschreibung
Der Datensatz `fb24` besteht aus Daten, die von den Studierenden selbst in den ersten Wochen der Veranstaltung PsyBSc2 erhoben wurden. Hierbei wurden eine Reihe von Variablen via eines Fragebogens auf SoSciSurvey erfragt und anschließend zu einem Datensatz zusammengefügt. Die Daten basieren somit auf wahren - anonymisierten - Werten der Studierenden. Der Fragebogen erfasst Daten zur aktuellen Stimmung, Persönlichkeit (gemessen an den Big5), dem Studium sowie demografische Daten.

### Datensatz laden

```r
load(url('https://pandar.netlify.app/daten/fb24.rda'))
```



### Größe
Der Datensatz besteht aus 179 Beobachtungen auf 40 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| ---- | ---- | ---- |
| `mdbf1` - `mdbf12` | Items zur aktuellen Stimmung | 1 = stimmt nicht, 4 = stimmt genau |
| `time_pre` | Bearbeitungszeit des MDBF | *Zeit in Sekunden* |
| `lz` | Lebenszufriedenheit | *Skalenwert* |
| `extra` | Extraversion | *Skalenwert* |
| `vertr` | Verträglichkeit | *Skalenwert* |
| `gewis` | Gewissenhaftigkeit | *Skalenwert* |
| `neuro` | Neurotizismus | *Skalenwert* |
| `offen` | Offenheit für neue Erfahrungen | *Skalenwert* |
| `prok` | Prokrastinationstendenz | *Skalenwert* |
| `nerd` | Nerdiness Personality Attributes | *Skalenwert* |
| `grund` | Gründe für das Psychologiestudium | *Freitext* |
| `fach` | Interessenfach | 1 = Allgemeine, 2 = Biologische, 3 = Entwicklung, 4 = Klinische, 5 = Diag./Meth. |
| `ziel` | Arbeitsbranche nach Abschluss | 1 = Wirtschaft, 2 = Therapie, 3 = Forschung, 4 = Andere |
| `wissen` | Interesse an wissenschaftlichen Grundlagen | 1 = überhaupt nicht, 5 = sehr |
| `therap` | Interesse an anwendungsbezogenen Aspekten | 1 = überhaupt nicht, 5 = sehr |
| `lerntyp` | Lerntyp | 1 = alleine, 2 = Gruppe, 3 = Mischtyp |
| `hand` | Schreibhand | 1 = links, 2 = rechts |
| `job` | Nebentätigkeit | 1 = nein, 2 = ja |
| `ort` | Derzeitiger Wohnort | 1 = Frankfurt, 2 = anderer |
| `ort12` | Wohnort vor 12 Monaten | 1 = Hessen, 2 = Deutschland, 3 = Ausland |
| `wohnen` | Aktuelle Wohnsituation | 1 = WG, 2 = bei Eltern, 3 = alleine, 4 = sonstiges |
| `uni1` - `uni4` | In Anspruch genommene Uni-Angebote (*Studienberatung, Orientierungswoche, Uniparties, Unisport*) | 0 = nein, 1 = ja |
| `attent_pre` | Gewissenhafte Beantwortung (1. Befragung) | 1 = überhaupt nicht, 6 = voll und ganz |
| `gs_post` | Gute vs. Schlechte Stimmung (2. Befragung) | *Skalenwert* |
| `wm_post` | Wach vs. Müde (2. Befragung) | *Skalenwert* |
| `ru_post` | Ruhig vs. Unruhig (2. Befragung) | *Skalenwert* |
| `time_post` | Bearbeitungszeit des MDBF | *Zeit in Sekunden* |
| `attent_post` | Gewissenhafte Beantwortung (2. Befragung) | 1 = überhaupt nicht, 6 = voll und ganz |

### Fehlende Werte
Insgesamt liegen im Datensatz 379 fehlende Werte vor. Folgende Variablen enthalten keine fehlenden Werte:

* `mdbf2`
* `mdbf3`
* `mdbf4`
* `mdbf5`
* `mdbf6`
* `mdbf7`
* `mdbf8`
* `mdbf9`
* `mdbf10`
* `mdbf11`
* `mdbf12`
* `extra`
* `gewis`
* `neuro`
* `offen`
* `prok`
* `nerd`
* `uni1`
* `uni2`
* `uni3`
* `uni4`

<!-- </details> -->

### Auftreten
fb24 wird in [Deskriptivstatistik für Intervallskalen - Übungen](/lehre/statistik-i/deskriptiv-intervall-uebungen) [[Statistik I](/category/statistik-i/)], [Deskriptivstatistik für Intervallskalen](/lehre/statistik-i/deskriptiv-intervall) [[Statistik I](/category/statistik-i/)], [Deskriptivstatistik für Nominal- und Ordinalskalen - Übungen](/lehre/statistik-i/deskriptiv-nominal-ordinal-uebungen) [[Statistik I](/category/statistik-i/)], [Deskriptivstatistik für Nominal- und Ordinalskalen](/lehre/statistik-i/deskriptiv-nominal-ordinal) [[Statistik I](/category/statistik-i/)], [Einfache Lineare Regression - Übungen](/lehre/statistik-i/einfache-reg-uebungen) [[Statistik I](/category/statistik-i/)], [Einfache Lineare Regression](/lehre/statistik-i/einfache-reg) [[Statistik I](/category/statistik-i/)], [Tests für abhängige Stichproben - Übungen](/lehre/statistik-i/gruppenvergleiche-abhaengig-uebungen) [[Statistik I](/category/statistik-i/)], [Tests für abhängige Stichproben](/lehre/statistik-i/gruppenvergleiche-abhaengig) [[Statistik I](/category/statistik-i/)], [Tests für unabhängige Stichproben - Übungen](/lehre/statistik-i/gruppenvergleiche-unabhaengig-uebungen) [[Statistik I](/category/statistik-i/)], [Tests für unabhängige Stichproben](/lehre/statistik-i/gruppenvergleiche-unabhaengig) [[Statistik I](/category/statistik-i/)], [Korrelation - Übungen](/lehre/statistik-i/korrelation-uebungen) [[Statistik I](/category/statistik-i/)], [Korrelation](/lehre/statistik-i/korrelation) [[Statistik I](/category/statistik-i/)], [Matrixalgebra](/lehre/statistik-i/matrixalgebra) [[Statistik I](/category/statistik-i/)], [Multiple Regression - Übungen](/lehre/statistik-i/multiple-reg-uebungen) [[Statistik I](/category/statistik-i/)], [Multiple Regression](/lehre/statistik-i/multiple-reg) [[Statistik I](/category/statistik-i/)], [Tests und Konfidenzintervalle - Übungen](/lehre/statistik-i/tests-konfidenzintervalle-uebungen) [[Statistik I](/category/statistik-i/)], [Tests und Konfidenzintervalle](/lehre/statistik-i/tests-konfidenzintervalle) [[Statistik I](/category/statistik-i/)], [Funktionen und Loops - Übungen](/lehre/statistik-ii/loops-funktionen-uebungen) [[Statistik II](/category/statistik-ii/)] und [Funktionen und Loops](/lehre/statistik-ii/loops-funktionen) [[Statistik II](/category/statistik-ii/)] genutzt.


---


## Gender, Drug, and Depression (`osf`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Der Datensatz liegt auf dem `Open Science Framework` und stammt aus einer Untersuchung von [Jing, Page-Gould & Iankilevitch (2019)](https://osf.io/kabxn), die den Effekt einer Drogenabhängigkeit auf das individuelle Depressionslevel einer Person untersucht haben.

### Datensatz laden


```r
library(haven)
osf <- read_sav(file = url("https://osf.io/prc92/download"))
```

### Größe
Der Datensatz besteht aus 55602 Beobachtungen auf 38 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| --- | ---- | ---- |
| `ANYDUMMY` | Drogenabhängigkeit | 0 = nicht vorhanden, 1 = vorhanden |
| `GENDER_R` | Geschlecht | 0 = weiblich, 1 = männlich |
| `Depression_lvl` | Depressionswert | 0 - 9 |

### Fehlende Werte
In dem Datensatz liegen 184784 fehlende Werte vor. Auf folgenden der für die Untersuchungen relevanten Variablen liegen keine fehlenden Werte vor:

* `GENDER_R`

<!-- </details> -->

### Auftreten
OSF Gender, Drug and Depression wird in [Logistische Regression](/lehre/klipps-legacy/logistische-regression-klinische-legacy) [[Klipps Legacy](/category/klipps-legacy/)] genutzt.


---

## Gewissenhaftigkeit und Medikamenteneinnahme (`data_combined`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Der Datensatz stammt aus dem `R`-eigenen Paket `metafor` von Viechtbauer (2010) und beinhaltet Variablen, die im Zusammenhang mit Gewissenhaftigkeit und der Einnahme von Medikamenten stehen. Es handelt sich hierbei um eine Meta-Analyse mehrerer Studien:

Molloy, G. J., O'Carroll, R. E., & Ferguson, E. (2014). Conscientiousness and medication adherence: A meta-analysis. Annals of Behavioral Medicine, 47(1), 92–101. [https://doi.org/10.1007/s12160-013-9524-4](https://doi.org/10.1007/s12160-013-9524-4)

### Datensatz laden

```r
library(metafor)
load(url('https://pandar.netlify.app/daten/reliabilites.molloy2014.rda'))
```

Im nächsten Schritt sollte der Datensatz mit den Reliabilitäten und der ursprüngliche Datensatz zusammen gefasst werden. Dafür gibt es einige Möglichkeiten. Hier ist ein Beispiel aufgeführt: 


```r
data_combined <- dat.molloy2014
data_combined$rel1 <- reliabilites.molloy2014$RelGewissenhaftigkeit
data_combined$rel2 <- reliabilites.molloy2014$RelCondition
head(data_combined)
```

### Größe
Der Datensatz besteht aus 16 Beobachtungen auf 12 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Bedeutung | Kodierung |
| --- | ---- | ---- |
| `authors` | Autor:innen der Studie | *Skalenwert* |
| `year` | Jahr der Veröffentlichung | *Jahreszahl* |
| `ni` | Stichprobengröße | *n* |
| `ri` | Korrelationskoeffizient | *r* |
| `controls` | Kontrollgruppe | none = nicht vorhanden, multiple = mehrere Gruppen vorhanden |
| `design` | Studiendesign | prospective = Prospektive Studie, cross-sectional = Querschnittstudie |
| `a_measure` | Methodik zur Messung der *medication adherence* (Medikamenteneinnahme) | self-report = Selbstbericht, other = andere |
| `c_measure` | Methodik zur Messung der *conscientiousness* (Gewissenhaftigkeit) | NEO = NEO-Persönlichkeits-Inventar, other = andere |
| `meanage` | Altersmittelwert der Stichprobe | *Arithmetisches Mittel* |
| `quality` | Qualitätsindex der Studie | 0 - 4 |
| `rel1` | Reliabilität Gewissenhaftigkeit | *Reliabilitätskoeffizient* |
| `rel2` | Reliabilität Condition | *Reliabilitätskoeffizient* |

### Fehlende Werte
Im Datensatz liegen 4 fehlende Werte vor. Auf folgenden Variablen liegen keine fehlenden Werte vor:

* `study`
* `treatment`
* `scale`
* `n`
* `diff`
* `se`
* `group`
* `tailored`
* `cog`
* `ba`
* `psed`
* `home`
* `prob`
* `soc`
* `relax`
* `goal`
* `final`
* `mind`
* `act`

<!-- </details> -->

### Auftreten
data_combined wird in [Daten für die Quiz](/lehre/klipps-legacy/quizdaten-klipps-legacy) [[Klipps Legacy](/category/klipps-legacy/)] genutzt.


---

## Hauptkomponentenanalyse (`PCA`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Der Beispieldatensatz enthält simulierte Daten zu unbekannten Variablen. Eine abhängige und sechs unabhängige Variablen liegen vor.

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/PCA.RData"))
```

### Größe
Der Datensatz besteht aus 36 Beobachtungen auf 7 Variablen.

### Variablen
Die Namen der Variablen sind nichtssagend, um Untersuchereffekte bei der Analyse auszuschließen.

| Variable | Kodierung |
| --- | --- |
| `x1` | *Standardisierter Skalenwert* |
| `x2` | *Standardisierter Skalenwert* |
| `x3` | *Standardisierter Skalenwert* |
| `x4` | *Standardisierter Skalenwert* |
| `x5` | *Standardisierter Skalenwert* |
| `x6` | *Standardisierter Skalenwert* |
| `y` | *Standardisierter Skalenwert* |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.

<!-- </details> -->

### Auftreten
PCA wird in [Hauptkomponentenanalyse](/lehre/fue-i/pca) [[Fue I](/category/fue-i/)] genutzt.

---

## HeckData (`HeckData`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Keine Ahnung, zu welcher Thematik dieser Beispieldatensatz Daten enthält. Falls irgendwann jemand ambitioniert ist, das herauszufinden, sollte sich diese Person wahrscheinlich an Julian Irmer wenden, der den Datensatz in seinem Tutorial zu Selektionseffekten (/lehre/simulation/selektionseffekte) erwähnt hat. 

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/HeckData.rda"))
```

### Größe
Der Datensatz besteht aus ... Beobachtungen auf ... Variablen.

### Variablen
Die Namen der Variablen...

| Variable | Kodierung |
| --- | --- |
| `Platzhalter` | *Platzhalter* |


### Fehlende Werte
Im Datensatz liegen ...

<!-- </details> -->

### Auftreten
HeckData wird in [Selektionseffekte](/lehre/forschungsmodul/selektionseffekte) [[Forschungsmodul](/category/forschungsmodul/)] genutzt.

---

## Internetintervention für psychische Störungen (`osf`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Der Datensatz liegt auf dem `Open Science Framework` und stammt aus einer Untersuchung von [Schaeuffele et al. (2020)](https://psyarxiv.com/528tw/), die den Effekt des Unified Protocol (UP) als Internetintervention für bestimmte psychische Störungen untersucht haben. In der Untersuchung wurden psychopathologische Symptome und therapiebezogene Variablen über einen Zeitraum von 6 Monaten erhoben.

### Datensatz laden


```r
osf <- read.csv(file = url("https://osf.io/zc8ut/download"))
osf <- osf[, c("ID", "group", "stratum", "bsi_post", "swls_post", "pas_post")]
```

### Größe
Der Datensatz besteht aus 129 Beobachtungen auf 6 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| --- | ---- | ---- |
| `ID` | Personenidentifikator | *Nummer* |
| `group` | Gruppenzugehörigkeit | Treatment = Treatmentgruppe, Waitlist = Wartelistenkontrollgruppe |
| `stratum` | Krankheitsbild | ANX = Angststörung, DEP = Depression, SOM = somatische Belastungsstörung |
| `bsi_post` | Symptomschwere | 0 - 212 |
| `swls_post` | Satisfaction with Life Scale (Lebenszufriedenheit) | 5 - 35 |
| `pas_post` | Panic and Agoraphobia Screening (Panikstörung & Agoraphobie) | 0 - 52 |

### Fehlende Werte
In dem Datensatz liegen 96 fehlende Werte vor. Auf folgenden Variablen liegen keine fehlenden Werte vor:

* `ID`
* `group`
* `stratum`

<!-- </details> -->

### Auftreten
OSF Internetintervention für psychische Störungen wird in [ANCOVA und moderierte Regression](/lehre/klipps-legacy/ancova-moderierte-regression-legacy) [[Klipps Legacy](/category/klipps-legacy/)], [ANOVA vs. Regression](/lehre/klipps-legacy/anova-regression-legacy) [[Klipps Legacy](/category/klipps-legacy/)] und [Tag 01](/workshops/refresher/refresher-day1) [[Refresher](/category/refresher/)] genutzt.


---

## Interozeptive Aufmerksamkeit und Genauigkeit (`body`)

### Beschreibung

Der Datensatz liegt auf dem `Open Science Framework` und stammt aus einer Untersuchung von [Campos, Barbosa Rocha und Barbosa (2022)](https://osf.io/hmtz9), in der es um die Abgrenzung von interozeptiver (die Wahrnehmung der vegetativen Prozesse des eigenen Körpers) Aufmerksamkeit und Genauigkeit geht.

### Datensatz laden

Der Datensatz liegt im OSF im `.sav` Dateiformat (dem Datenformat in dem SPSS seine Daten abspeichert) vor. Daher müssen die Daten mithilfe einer der vielen verschiedenen Import-Funktionen eingelesen werden. Hier nutzen wir dafür die Funktion `read_sav` aus dem Paket `haven`, welches R-Studio primär nutzt, um Daten zu importieren und daher bereits installiert sein sollte.


```r
library(haven)
body <- haven::read_sav(file = url('https://osf.io/43xv5/download'))
```

Der Datensatz enthält neben den zusammengefassten Skalenwerten auch die einzelnen Items der beiden zentralen Skalen (IAS und BPQ), welche wir für diese Anwendung entfernen, um die Daten etwas übersichtlicher zu gestalten. Wir beschränken uns also auf die ersten 27 Variablen im Datensatz:


```r
body <- body[, 1:27]
```

### Größe
Der eingeschränkte Datensatz besteht aus 134 Beobachtungen auf 27 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| --- | ---- | ---- |
| `id` | Probanden-ID |  |
| `Age` | Alter | Alter in Jahren |
| `Sex` | Geschlecht | 0 = weiblich, 1 = männlich |
| `Nationality` | Nationalität | 0 = andere, 1 = Portugiesisch |
| `PortugueseFirstLanguage` | Muttersprache | 0 = andere, 1 = Portugiesisch |
| `EducationCategorical` | Höchster Bildungsabschluss | 0 = kein Abschluss, 1 = Grundschule, 2 = mittlere Reife, 3 = Abitur/High School, 4 = Bachelor, 5 = Master, 6 = Doktorgrad |
| `EducationYears` | Jahre im Bildungssystem | 
| `Student` | Schüler\*in oder Student\*in? | 0 = nein, 1 = ja 
| `Employed` | Angestelltenverhältnis? | 0 = nein, 1 = ja
| `Unemployed` | Arbeitslos? | 0 = nein, 1 = ja
| `StayAtHome` | Hausfrau/-mann? | 0 = nein, 1 = ja
| `Retired` | Im Ruhestand? | 0 = nein, 1 = ja
| `OccupationalStatusOther` | Anderes Beschäftigungsverhältnis? | 0 = nein, 1 = ja
| `UniversityStudent` | Student*in? | 0 = nein, 1 = ja ( _fehlerhafte Kopie der Variable `Student`_ ) 
| `PsychiatricHistory` | Psychische Störung in der Vergangenheit? | 0 = nein, 1 = ja
| `NeurologicalHistory` | Neurologische Störung in der Vergangenheit? | 0 = nein, 1 = ja
| `ChronicCondition` | Chronische Krankheiten? | 0 = nein, 1 = ja 
| `Medication` | Aktuell Medikamenteneinnahme? | 0 = nein, 1 = ja
| `Device` | Gerät an dem Fragebogen ausgefüllt wird | 0 = Computer, 1 = Smartphone, 2 = Tablet, 3 = anderes
| `IAS_TotalScore` | _Interoceptive Accuracy Scale_ | _Skalenwert_
| `IAS_TotalScore_Retest` | _Interoceptive Accuracy Scale_, 2. Erhebung | _Skalenwert_
| `BPQ_BodyAwareness` | _Body Perception Questionnaire_, Aufmerksamkeits-Dimension | _Skalenwert_
| `BPQ_BodyAwareness_Retest` | _Body Perception Questionnaire_, Aufmerksamkeits-Dimension, 2. Erhebung | _Skalenwert_
| `BPQ_AutonomicReactivity` | _Body Perception Questionnaire_, Reaktivitäts-Dimension | _Skalenwert_
| `BPQ_AutonomicReactivity_Retest` | _Body Perception Questionnaire_, Reaktivitäts-Dimension, 2. Erhebung | _Skalenwert_
| `BPQ_Time_Retest` | Zeit um BPQ auszufüllen, 2. Erhebung | in Sekunden
| `IAS_Time_Retest` | Zeit um IAS auszufüllen, 2. Erhebung | in Sekunden

### Fehlende Werte

In dem Datensatz liegen 92 fehlende Werte vor. Diese sind allesamt auf der fehlerhaft kodierten Variablen `UniversityStudent` zu finden.

### Auftreten
body wird aktuell in keinem Beitrag genutzt.


---

## Items der Generic Conspiracist Beliefs Scale (`conspiracy_cfa`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Die Daten stammen aus der Erhebung zur Validierung der *Generic Conspiracist Beliefs Scale* (GCBS; Brotherton, French, & Pickering, 2013). Die Daten finden Sie öffentlich zugänglich auf der [Open Psychometrics Website](http://openpsychometrics.org/_rawdata/GCBS.zip). Der Fragebogen besteht aus insgesamt 15 Aussagen, die die Proband:innen jeweils von 1 ("definitely not true") bis 5 ("definitely true") hinsichtlich ihres Wahrheitsgehalts einschätzen sollen. 

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/conspiracy_cfa.rda"))
```


### Größe
Der Datensatz besteht aus ... Beobachtungen auf ... Variablen. 


### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Bedeutung | Kodierung |
| --- | ---- | ---- |
| `edu` | höchster Bildungsabschluss | 1 = not highschool, 2 = highschool, 3 = college |
| `urban` | Typ des Wohnortes | 1 = rural, 2 = suburban, 3 = urban |
| `gender` | Geschlecht | 1 = male, 2 = female, 3 = other |
| `age` | Alter | *Freitext* |

| Variable | Facette | Itemwortlaut |
| --- | --- | ------ |
| `Q1` | `GM` | The government is involved in the murder of innocent citizens and/or well-known public figures, and keeps this a secret |
| `Q2` | `GC` | The power held by heads of state is second to that of small unknown groups who really control world politics |
| `Q3` | `EC` | Secret organizations communicate with extraterrestrials, but keep this fact from the public |
| `Q4` | `PW` | The spread of certain viruses and/or diseases is the result of the deliberate, concealed efforts of some organization |
| `Q5` | `CI` | Groups of scientists manipulate, fabricate, or suppress evidence in order to deceive the public |
| `Q6` | `GM` | The government permits or perpetrates acts of terrorism on its own soil, disguising its involvement |
| `Q7` | `GC` | A small, secret group of people is responsible for making all major world decisions, such as going to war |
| `Q8` | `EC` | Evidence of alien contact is being concealed from the public |
| `Q9` | `PW` | Technology with mind-control capacities is used on people without their knowledge |
| `Q10` | `CI` | New and advanced technology which would harm current industry is being suppressed |
| `Q11` | `GM` | The government uses people as patsies to hide its involvement in criminal activity |
| `Q12` | `GC` | Certain significant events have been the result of the activity of a small group who secretly manipulate world events |
| `Q13` | `EC` | Some UFO sightings and rumors are planned or staged in order to distract the public from real alien contact |
| `Q14` | `PW` | Experiments involving new drugs or technologies are routinely carried out on the public without their knowledge or consent |
| `Q15` | `CI` | A lot of important information is deliberately concealed from the public out of self-interest |


### Fehlende Werte
Im Datensatz liegen 186 fehlende Werte vor. Die folgenden Variablen enthalten keine fehlenden Werte:

* `edu`
* `age`
* `Q10`

<!-- </details> -->
### Auftreten - VERALTET
conspiracy_cfa wird in [Konfirmatorische Faktorenanalyse](/lehre/fue-ii/fue-cfa) [[Fue II](/category/fue-ii/)] genutzt.



---

## Kooperationsbereitschaft von Geschwistern (`dataKooperation`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Der Datensatz stammt aus [Eid, Gollwitzer & Schmitt: "Statistik und Forschungsmethoden" (4. Auflage, S.370)](https://ubffm.hds.hebis.de/Record/HEB366849158). Es wurde die Kooperationsbereitschaft von verschiedenen Geschwisterteilen innerhalb einer Familie erhoben. Die Paare bestehen hierbei aus beiden Geschwisterteilen, von denen jeweils die Kooperationsbereitschaft gemessen wurde.

### Datensatz laden

```r
dataKooperation <- data.frame(Paar = 1:10, Juenger = c(0.49,0.25,0.51,0.55,0.35,0.54,0.24,0.49,0.38,0.50), Aelter = c(0.4,0.25,0.31,0.44,0.25,0.33,0.26,0.38,0.23,0.35))
```

### Größe
Der Datensatz besteht aus 10 Beobachtungen auf 3 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt |
| --- | ---- |
| `Paar` | Nummer des Geschwisterpaares  |
| `Juenger` | Kooperationsbereitschaft des jüngeren Geschwisterteils  |
| `Aelter` | Kooperationsbereitschaft des älteren Geschwisterteils  |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->

### Auftreten
Datakooperation wird aktuell in keinem Beitrag genutzt.


---

## Kulturelle Unterschiede in Korruptionsbestrafung (`punish`)

### Beschreibung
Die Daten stammen aus einer [kuturellen Unterschieden in der Einschätzung von verschiedenen Aspekten der Bestechung](https://onlinelibrary.wiley.com/doi/10.1111/ajsp.12509){target="_blank"}. Die hier genutzten Daten sind ein Auszug aus den im [Artikel von Hong-Zhi et al., 2021](https://onlinelibrary.wiley.com/doi/10.1111/ajsp.12509) für Studie 1 genutzten Daten.


### Datensatz laden

Die Daten können direkt vom [{{< icon name="download" pack="fas" >}} OSF heruntergeladen ](https://osf.io/4wypx/download) werden. Allerdings werden einige Schritte durchlaufe, um die Daten auf die nötigen Variablen zu reduzieren, welche mit 


```r
source("https://pandar.netlify.app/daten/Data_Processing_punish.R")
```

direkt durchgeführt werden können. Zur Nachvollziehbarkeit, hier noch einmal der Inhalt dieses Skripts:


```r
#### Data preparation file for punishment severity evaluation ----
# for the paper see: https://onlinelibrary.wiley.com/doi/10.1111/ajsp.12509

punish <- foreign::read.spss('https://osf.io/4wypx/download', use.value.labels = TRUE,
  to.data.frame = TRUE)

punish <- punish[, c('culture_group', 'bribery_type', 'age', 'gender',
  'gains_everage', 'difficulties_everage', 'noticed_probability_everage',
  'punishment_probability_everage', 'punishment_severity_everage')]
names(punish) <- c('country', 'bribe', 'age', 'gender', 'gains', 'difficult', 
  'notice', 'probable', 'severe')

levels(punish$age) <- c(levels(punish$age), 'over 50')
punish$age[punish$age %in% c('51-60', '61-70', 'over 70')] <- 'over 50'
punish$age <- droplevels(punish$age)
```

### Größe
Der Datensatz besteht aus 174 Beobachtungen auf 9 Variablen.

### Variablen

Der Datensatz enthält (in reduzierter Fassung) folgende Variablen:

| Variable | Inhalt | Kodierung |
| --- | ---- | ---- |
| `country` | Land  | 1 = China, 2 = U.S |
| `bribe` | Ebene der beurteilten Bestechungssituation (experimentelle Kondition)
| `age` | Alter in vier Kategorien | 1 = 21 - 30, 2 = 31 - 40, 3 = 41 - 50, 4 = over 50 |
| `gender` | Geschlecht | 1 = female, 2 = male |
| `gains` | Gewinn durch Bestechung | _Mittelwert über fünf Situationen_ (1 bis 10) |
| `difficult` | Schwierigkeit in der Umsetzung der Handlung, die durch Bestechung erwirkt werden soll | _Mittelwert über fünf Situationen_ (1 bis 10) |
| `notice` | Wahrscheinlichkeit mit der Bestechung entdeckt wird | _Mittelwert über fünf Situationen_ (1 bis 10) |
| `probable` | Wahrscheinlichkeit mit der es zur Bestrafung kommt | _Mittelwert über fünf Situationen_ (1 bis 10) |
| `severe` | Schweregrad der erwarteten Bestrafung | _Mittelwert über fünf Situationen_ (1 bis 10) |

Bei den Variablen `gains` bis `severe` handelt es sich um individuelle Einschätzungen, die für fünf verschiedene schriftlich dargestellte Situationen eingeschätzt werden sollten. Hier werden die Mittelwerte über die fünf Situationen genutzt.

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.

### Auftreten
punish wird in [Regression mit nominalskalierten Prädiktoren](/lehre/statistik-ii/ancova-regression) [[Statistik II](/category/statistik-ii/)] genutzt.


---

## Lesekompetenz in der PISA-Erhebung (`PISA2009`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Der Beispieldatensatz enthält Daten zur Lesekompetenz aus der deutschen Stichprobe der PISA-Erhebung in Deutschland 2009. Im Datensatz sind viele Variablen der pädagogischen Forschung enthalten, die im Folgenden erklärt werden.


### Datensatz laden


```r
load(url("https://pandar.netlify.app/daten/PISA2009.rda"))
```

### Größe
Der Datensatz besteht aus 150 Beobachtungen auf 15 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Bedeutung |
| --- | ----- |
| `Grade` | Klassenstufe |
| `Age` | Alter in Jahren |
| `Female` | Geschlecht (0 = m, 1 = w) |
| `Reading` | Lesekompetenz |
| `JoyRead` | Lesefreude |
| `LearnMins` | Lernzeit in Minuten für Deutsch |
| `HISEI` | Sozialstatus (*Highest International Socio-Economic Index of occupational status*) |
| `CultPoss` | Fragebogen-Score für kulturelle Besitztümer zu Hause (z. B. klassische Literatur, Kunstwerke) |
| `Books` | Anzahl Bücher zu Hause |
| `TVs` | Anzahl Fernseher zu Hause |
| `Computers` | Anzahl Computer zu Hause |
| `Cars` | Anzahl Autos zu Hause |
| `MigHintergrund` | Migrationshintergrund (0 = beide Eltern in D geboren, 1 = min. 1 Elternteil im Ausland geboren) |
| `FatherEdu` | Bildungsabschluss des Vaters (*International Standard Classification of Education*) |
| `MotherEdu` | Bildungsabschluss der Mutter (*International Standard Classification of Education*) |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->

### Auftreten
PISA2009 wird in [Daten für die Quiz](/lehre/statistik-ii/quizdaten-bsc7) [[Statistik II](/category/statistik-ii/)] und [Regression IV: quadratische und moderierte Regression](/lehre/statistik-ii/regression-iv) [[Statistik II](/category/statistik-ii/)] genutzt.


---

## Machiavellismus-Fragebogen (`mach`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Die hier verwendeten Daten stammen aus dem ["Open-Source Psychometrics Project"](https://openpsychometrics.org/_rawdata/), einer Online-Plattform, die eine Sammlung an Daten aus verschiedensten Persönlichkeitstests zur Verfügung stellt. Wir haben bereits eine kleine Aufbereitung der Daten durchgeführt, damit wir leichter in die Analysen starten können. Auf der genannten Seite kann man Fragebögen selbst ausfüllen, und so zum Datenpool beitragen. Der hier verwendete Datensatz enthält Items aus einem Machiavellismus-Fragebogen, den Sie bei Interesse [hier](https://openpsychometrics.org/tests/MACH-IV/) selbst ausfüllen können. 
Der Datensatz erhält viele Angaben zur Persönlichkeit und demografischen Daten. Kern ist aber der 20 Items umfassende Machiavellismusfragebogen von Christie und Geis (1970) und daraus ableitbare 4-faktorielle Struktur des Konzepts (Corral & Calvete, 2000). Die Skalenwerte dieser vier Faktoren haben wir bereits im Datensatz angelegt.

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/mach.rda"))
```

### Größe
Der Datensatz besteht aus 65151 Beobachtungen auf 26 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| --- | ---- | ---- |
| `TIPI1` - `TIPI10` | Persönlichkeitseigenschaften  | 1 = "Stimme gar nicht zu", 7 = "Stimme voll und ganz zu" |
| `education` | *How much education have you completed?* | 1 = Less than High School, 2 = High School, 3 = University degree, 4 = Graduate degree |
| `urban` | *What type of area did you live when you were a child?*  | 1 = Rural (country side), 2 = Suburban, 3 = Urban (city, town) |
| `gender` | *What is your gender?*  | 1 = Male, 2 = Female, 3 = Other |
| `engnat` | *Is English your native language?*  | 1 = Yes, 2 = No |
| `age` | *How many years old are you?*  | *Freitext* |
| `hand` | *What hand do you use to write with?*  | 1 = Right, 2 = Left, 3 = Both |
| `religion` | *What is your religion?* | 1 = Agnostic, 2 = Atheist, 3 = Buddhist, 4 = Christian(Catholic), 5 = Christian(Mormon), 6 = Christian(Protestant), 7 = Christian(Other), 8 = Hindu, 9 = Jewish, 10 = Muslim, 11 = Sikh, 12 = Other |
| `orientation` | *What is your sexual orientation?*  | 1 = Heterosexual, 2 = Bisexual, 3 = Homosexual, 4 = Asexual, 5 = Other|
| `race` | *What is your race?*  | 1 = Asian, 2 = Arab, 3 = Black, 4 = Indigenous Australian, 5 = Native American, 6 = White/European, 7 = Other |
| `voted` | *Have you voted in a national election in the past year?*  | 1 = Yes, 2 = No |
| `married` | *What is your marital status?*  | 1 = Never married, 2 = Currently married, 3 = Previously married |
| `familysize` | *Including you, how many children did your mother have?*  | *Freitext* |
| `nit` | *Negative interpersonal tactics*  | *Skalenwert* |
| `pit` | *Positive interpersonal tactics*  | *Skalenwert* |
| `cvhn` | *Cynical view of human nature*  | *Skalenwert* |
| `pvhn` | *Positive view of human nature* | *Skalenwert* |

### Fehlende Werte
Insgesamt liegen im Datensatz 19 fehlende Werte vor. Diese liegen ausschließlich auf der Variable `familysize` vor. Alle restlichen Variablen enthalten keine fehlenden Werte.

<!-- </details> -->

### Auftreten
mach wird in [Wiederholung von Grundlagen in R](/lehre/statistik-ii/einleitung-statistik-ii) [[Statistik II](/category/statistik-ii/)], [Grafiken mit ggplot2 - Übungen](/lehre/statistik-ii/grafiken-ggplot2-uebungen) [[Statistik II](/category/statistik-ii/)] und [Daten für die Quiz](/lehre/statistik-ii/quizdaten-bsc7) [[Statistik II](/category/statistik-ii/)] genutzt.

---

## Major Depression (`data`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Der Datensatz stammt aus einer Erhebung von Epskamp et al. (2018a), welche auf dem `Open Science Framework` zu finden ist. Die Daten befassen sich mit einer einzelnen Person. Dabei handelt es sich laut der Autor:innen um eine Person, die sich nach einer Major-Depression-Diagnose in der Behandlung befand. Die Fragen wurden von der teilnehmenden Person 5 Mal am Tag über 14 Tage hinweg ausgefüllt. Es wurden psychopathologische Symptome erfasst und untersucht, wie diese miteinander in Verbindung stehen könnten. Publiziert wurden die Ergebnisse der Studie in folgendem Paper:

Epskamp, S., van Borkulo, C. D., van der Veen, D. C., Servaas, M., Isvoranu, A.-M., Riese, H., & Cramer, A. O. J. (2020, September 21). Personalized Network Modeling in Psychopathology: The Importance of Contemporaneous and Temporal Connections. [https://doi.org/10.17605/OSF.IO/C8WJZ](https://doi.org/10.17605/OSF.IO/C8WJZ)

### Datensatz laden


```r
data <- read.csv(url("https://osf.io/g6ya4/download"))
```

### Größe
Der Datensatz besteht aus 70 Beobachtungen auf 8 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen. Die untersuchte Person sollte bei jeder der folgenden Symptome angeben, inwiefern sie auf sie zutreffen.

| Variable | Inhalt | Kodierung |
| --- | --- | ----- |
| `relaxed` | entspannt | 1 = Trifft überhaupt nicht zu, 7 = Trifft voll und ganz zu |
| `sad` | traurig | 1 = Trifft überhaupt nicht zu, 7 = Trifft voll und ganz zu |
| `nervous` | nervös | 1 = Trifft überhaupt nicht zu, 7 = Trifft voll und ganz zu |
| `concentration` | konzentriert | 1 = Trifft überhaupt nicht zu, 7 = Trifft voll und ganz zu |
| `tired` | müde  | 1 = Trifft überhaupt nicht zu, 7 = Trifft voll und ganz zu |
| `rumination` | ruminierend | 1 = Trifft überhaupt nicht zu, 7 = Trifft voll und ganz zu |
| `bodily.discomfort` | körperlich wohl  | 1 = Trifft überhaupt nicht zu, 7 = Trifft voll und ganz zu |
| `time` | Zeitpunkt der Erfassung  | *Datum & Uhrzeit* |

### Fehlende Werte
In dem Datensatz liegen 35 fehlende Werte vor. Folgende Variablen enthalten keine fehlenden Werte:

* `time`

<!-- </details> -->

### Auftreten
Major Depression (data) wird in [Dynamische Netzwerkanalyse](/lehre/klipps-legacy/dynamische-netzwerke-legacy) [[Klipps Legacy](/category/klipps-legacy/)] genutzt.

---

## Mehrdimensionaler Befindlichkeitsfragebogen (`mdbf`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Beim Datensatz handelt es sich um eine Erhebung, die 2017 an der Freien Universität Berlin durchgeführt wurde. Die Items stammten dabei aus dem Mehrdimensionalen Befindlichkeitsfragebogen von Steyer et al. (1997). In diesem Fragebogen werden Adjektive zur Beschreibung der aktuellen Stimmung genutzt, um die drei Dimensionen der Stimmung - Gut vs. Schlecht, Wach vs. Müde und Ruhig vs. Unruhig - zu erheben.

### Datensatz laden


```r
load(url("https://pandar.netlify.app/daten/mdbf.rda"))
```

### Größe
Der Datensatz besteht aus 98 Beobachtungen auf 12 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

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

In der Spalte *Dimension* sehen wir, dass die Items 3 verschiedene Dimensionen abbilden: *Gut vs. Schlecht*, *Wach vs. Müde* und *Ruhig vs. Unruhig*. Die Items sind dabei unterschiedlich gepolt - die Adjektive "ausgeruht" und "schlapp" erfasst beide die Dimension *Wach vs. Müde*, jedoch in unterschiedlicher Ausrichtung.

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->

### Auftreten
mdbf wird in [Funktionen und Loops - Übungen](/lehre/statistik-ii/loops-funktionen-uebungen) [[Statistik II](/category/statistik-ii/)] und [Daten für die Quiz](/lehre/statistik-ii/quizdaten-bsc7) [[Statistik II](/category/statistik-ii/)] genutzt.

---

## Mental Health and Social Contact During the COVID-19 Pandemic (`data`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Beim Datensatz handelt es sich um längsschnittliche Daten bezüglich psychischer Gesundheit und sozialer Kontakte während der COVID-19-Pandemie. Die Datensatzaufbereitung (Fallreduktion, Detrending, Variablenauswahl, etc.) haben wir bereits für Sie erledigt. Die Daten wurden ursprünglich im Rahmen folgenden Papers erhoben und sind auf dem `Open Science Framework` zu finden:

Fried, E. I., Papanikolaou, F., & Epskamp, S. (2021). Mental Health and Social Contact During the COVID-19 Pandemic: An Ecological Momentary Assessment Study. _Clinical Psychological Science_. [https://doi.org/10.1177/21677026211017839](https://doi.org/10.1177/21677026211017839)
 

### Datensatz laden


```r
source(url("https://pandar.netlify.app/daten/Data_Processing_Quiz4b.R"))
```

Sie erhalten einmal den Datensatz `data` und eine Aufzählung aller Variablen, die Knoten im Netzwerk sein sollen, mit `rel_vars`.

### Größe
Der Datensatz besteht aus 70 Beobachtungen auf 8 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Bedeutung | Kodierung |
| --- | ---- | --- |
| `id` | Personenidentifikator | 10 |
| `Relax` | *I found it difficult to relax* | 1 - 5 |
| `Irritable` | *I felt (very) irritable* | 1 - 5 |
| `Worry` | *I was worried about different things* | 1 - 5 |
| `Nervous` | *I felt nervours, anxious, or on edge* | 1 - 5 |
| `Future` | *I felt that I had nothing to look forward* | 1 - 5 |
| `Anhedonia` | *I couldn't seem to experience any positive feeling at all* | 1 - 5 |
| `Tired` | *I felt tired* | 1 - 5 |
| `Alone` | *I felt like I lack companionship, or that I am not close to people* | 1 - 5 |
| `Social_offline` | *I spent __ on meaningful, offline, social interaction* | 1 = 0 min, 2 = 1-15 min, 3 = 15-60 min, 4 = 1-2 hr, 5 = >2 hr |
| `Social_online` | *I spent __ using social media to kill/pass the time* | 1 = 0 min, 2 = 1-15 min, 3 = 15-60 min, 4 = 1-2 hr, 5 = >2 hr |
| `Outdoors` | *I spent __ outside (outdoors)* | 1 = 0 min, 2 = 1-15 min, 3 = 15-60 min, 4 = 1-2 hr, 5 = >2 hr |
| `C19_occupied` | *I spent __ occupied with the coronavirus (e.g. watching news, thinking about it, talking to friends about it)* | 1 = 0 min, 2 = 1-15 min, 3 = 15-60 min, 4 = 1-2 hr, 5 = >2 hr |
| `C19_worry` | *I spent __ thinking about my own health or that of my close friends and family members regarding the coronavirus* | 1 = 0 min, 2 = 1-15 min, 3 = 15-60 min, 4 = 1-2 hr, 5 = >2 hr |
| `Home` | *I spent __ at home (including the home of parents/partner)* | 1 = 0 min, 2 = 1-15 min, 3 = 15-60 min, 4 = 1-2 hr, 5 = >2 hr |
| `day` | *I was worried about different things* | Tageszahl |
| `beep` | Benachrichtigung am jeweiligen Tag | 0 - 3 |

### Fehlende Werte
Im Datensatz liegen 42 fehlende Werte vor. Die folgenden Variablen enthalten keine fehlenden Werte:

* `id`
* `day`
* `beep`
* `conc`

</details>

### Auftreten
Mental Health and Social Contact During the COVID-19 Pandemic (data) wird in [Daten für die Quiz](/lehre/klipps-legacy/quizdaten-klipps-legacy) [[Klipps Legacy](/category/klipps-legacy/)] genutzt.

---

## Naturverbundenheit (`nature`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Der Datensatz behandelt die Naturverbundenheit, welche anhand von 6 Items gemessen wurde. Weiterhin sind Informationen hinsichtlich des Wohnortes vorhanden.

### Datensatz laden


```r
load(url("https://pandar.netlify.app/daten/nature.rda"))
```

### Größe
Der Datensatz besteht aus 490 Beobachtungen auf 8 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Bedeutung | Kodierung |
| --- | ---- | ---- |
| `Q1A` - `Q6A` | Items zur Naturverbundenheit | *Skalenwert* |
| `urban` | Typ des Wohnortes | 1 = rural, 2 = suburban, 3 = urban |
| `continent` | Kontinent des Wohnortes | 1 = Americas, 2 = Europe |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->

### Auftreten
nature wird in [Daten für die Quiz](/lehre/statistik-ii/quizdaten-bsc7) [[Statistik II](/category/statistik-ii/)] genutzt.


---

## Nerdiness (`NerdData`)
### Beschreibung
Bei dem Datensatz handelt es sich eine gekürzte Version von Daten zur "Nerdy Personality Attributes Scale", die auf der [Open Psychometrics Website](https://openpsychometrics.org/) erfasst wurden

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/NerdData.rda"))
```

### Größe
Der Datensatz besteht aus 300 Beobachtungen auf 80 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht eines Teils der erhobenen Variablen und ihre Bedeutungen.

NPAS-Items
| Variable | Inhalt |
| --- | ---- |
| `Q1`	 | I am interested in science. |
| `Q2`	 | I was in advanced classes. |
| `Q3`	 | I like to play RPGs. (Ex. D&D) |
| `Q4`	 | My appearance is not as important as my intelligence. |
| `Q5`	 | I collect books. |
| `Q6`	 | I prefer academic success to social success. |
| `Q7`	 | I watch science related shows. |
| `Q8`	 | I spend recreational time researching topics others might find dry or overly rigorous. 
| `Q9`	 | I like science fiction. |
| `Q10` | I would rather read a book than go to a party. |
| `Q11` | I am more comfortable with my hobbies than  | I am with other people. | 		
| `Q12` | I spend more time at the library than any other public place. |
| `Q13` | I would describe my smarts as bookish. |
| `Q14` | I like to read technology news reports. |
| `Q15` | I have started writing a novel. |
| `Q16` | I gravitate towards introspection. |
| `Q17` | I am more comfortable interacting online than in person. |
| `Q18` | I love to read challenging material. |
| `Q19` | I have played a lot of video games. |
| `Q20` | I was a very odd child. |
| `Q21` | I sometimes prefer fictional people to real ones. |
| `Q22` | I enjoy learning more than I need to. |
| `Q23` | I get excited about my ideas and research. |
| `Q24` | I am a strange person. |
| `Q25` | I care about super heroes. |
| `Q26` | I can be socially awkward at times. |

Ten Item Personality Inventory (TIPI) Items + "nerdy"
| Variable | Inhalt |
| --- | ---- |
| `TIPI1` | 	Extraverted, enthusiastic. | Extraversion |
| `TIPI2` | 	Critical, quarrelsome. | Agreeableness* |
| `TIPI3` | 	Dependable, self-disciplined. | Conscientiousness |
| `TIPI4` | 	Anxious, easily upset. | Neuroticism |
| `TIPI5` | 	Open to new experiences, complex. | Openness |
| `TIPI6` | 	Reserved, quiet. | Extraversion* |
| `TIPI7` | 	Sympathetic, warm. |  Agreeableness |
| `TIPI8` | 	Disorganized, careless. | Conscientiousness* |
| `TIPI9` | 	Calm, emotionally stable. | Neuroticism* |
| `TIPI10` | 	Conventional, uncreative. | Openness* |
| `nerdy` |      Nerdy. | Nerdiness |

### Fehlende Werte
In dem Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->


### Auftreten
NerdData wird in [Daten für die Übungen](/lehre/fue-i/msc1-daten) [[Fue I](/category/fue-i/)] genutzt.


---

## Parental Burnout (`burnout`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Die Daten stammen vom `Open Science Framework` und wurden im Rahmen dieses Papers erhoben:

Blanchard, M. A., Roskam, I., Mikolajczak, M., & Heeren, A. (2021). A network approach to parental burnout. _Child Abuse & Neglect, 111_, 104826. [https://doi.org/10.1016/j.chiabu.2020.104826](https://doi.org/10.1016/j.chiabu.2020.104826)

In der Untersuchung wurden charakteristische Merkmale von *Parental Burnout* untersucht und anhand einer Netzwerkanalyse ihre Zusammenhänge untersucht.

### Datensatz laden


```r
burnout <- read.csv(file = url("https://osf.io/qev5n/download"))
burnout <- burnout[,2:8]
```

### Größe
Der Datensatz besteht aus 1551 Beobachtungen auf 7 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der wichtigsten Variablen und ihre Bedeutungen.

| Variable | Bedeutung | Kodierung |
| --- | ---- | --- |
| `Exhaust` | *Emotional exhaustion* | 0 - 48 |
| `Distan` | *Emotional distancing* | 0 - 48 |
| `Ineffic` | *Parental accomplishment and efficacy* | 0 - 36 |
| `Neglect` | *Neglectful behaviors toward children* | 17 - 136 |
| `Violence` | *Violent behaviors toward children* | 15 - 120 |
| `PartEstrang` | *Partner Estrangement* | 5 - 40 |
| `PartConfl` | *Conflicts with partner* | 2 - 14 |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->


### Auftreten
burnout wird in [Daten für die Quiz](/lehre/klipps-legacy/quizdaten-klipps-legacy) [[Klipps Legacy](/category/klipps-legacy/)], [Inferenz und Modellauswahl in der multiplen Regression](/lehre/statistik-ii/multreg-inf-mod) [[Statistik II](/category/statistik-ii/)] und [Tag 02](/workshops/refresher/refresher-day2) [[Refresher](/category/refresher/)] genutzt.


---

## Psychisches Wohlbefinden von Individuen während des Lockdowns in Frankreich (`lockdown`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Die Daten stammen aus einer [Studie zum psychischen Wohlbefinden von Individuen während des pandemie-bedingten Lockdowns in Frankreich](https://www.frontiersin.org/articles/10.3389/fpsyg.2020.590276/full). 
Es handelt sich um hierarchische Daten mit Messzeitpunkten auf Ebene 1 und Individuen auf Ebene 2.

### Datensatz laden

```r
library(dplyr)
library(ICC)
library(lme4)
library(interactions)
```


```r
# Daten einlesen und vorbereiten ----
lockdown <- read.csv(url("https://osf.io/dc6me/download"))

# Entfernen der Personen, für die weniger als zwei Messpunkte vorhanden sind
# (Auschluss von Fällen, deren ID nur einmal vorkommt)
lockdown <- lockdown[-which(lockdown$ID %in% names(which(table(lockdown$ID)==1))),] 

# Daten aufbereiten, Variablen auswählen extrahieren und in Nummern umwandeln
# Entfernen von Minderjährigen & unbestimmtes Gender mit den Funktionen filter() & select () aus dplyr.
lockdown <- lockdown %>%
  filter(Age > 18 & Gender == 1 | Gender == 2) %>%
  select(c("ID", "Wave", "Age", "Gender", "Income", "EWB","PWB","SWB",
           "IWB","E.threat","H.threat", "Optimism",
           "Self.efficacy","Hope","P.Wisdom","ST.Wisdom","Grat.being",
           "Grat.world","PD","Acc","Time","EWB.baseline","PWB.baseline",
           "SWB.baseline","IWB.baseline"))

# Standardisieren der AVs
lockdown[,c("EWB", "PWB", "SWB", "IWB")] <- scale(lockdown[,c("EWB", "PWB", "SWB", "IWB")])
# Standardisieren möglicher Prädiktoren
lockdown[,c("E.threat", "H.threat", "Optimism", "Self.efficacy", "Hope", "P.Wisdom", 
            "ST.Wisdom", "Grat.being", "Grat.world")] <-
  scale(lockdown[,c("E.threat", "H.threat", "Optimism", "Self.efficacy", "Hope", "P.Wisdom", 
            "ST.Wisdom", "Grat.being", "Grat.world")])
```

### Größe
Der Datensatz besteht aus 2192 Beobachtungen auf 25 Variablen.

### Variablen
In diesem Datensatz stehen die Daten eines Messzeitpunktes in je einer Zeile, d.h. die Daten einer Person stehen in mehreren Zeilen (diese Struktur wird oft auch als *long format* bezeichtet - im Kontrast zum *wide format*, bei dem die Daten jeder Person in einer Zeile in verschiedenen Variablen stehen). In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| --- | ---- | ---- |
| `ID` | Personenidentifikator  | *ID* |
| `Wave` | Erhebungswelle, zu der die Befragung erfolgt ist  | 0 - 5 |
| `Gender` | Geschlecht | 1 = männlich, 2 = weiblich |
| `Income` | Jährliches Einkommen |  |
| `EWB` | *Emotional Well-Being* | *standardisierter Skalenwert* |
| `PWB` | *Psychological Well-Being* | *standardisierter Skalenwert* |
| `SWB` | *Social Well-Being* | *standardisierter Skalenwert* |
| `E.threat` | *Economic threat* | *standardisierter Skalenwert* |
| `H.threat` | *Health threat* | *standardisierter Skalenwert* |
| `Optimism` | Optimismus | *standardisierter Skalenwert* |
| `Self.efficacy` | Selbstwirksamkeit | *standardisierter Skalenwert* |
| `Hope` | Hoffnung | *standardisierter Skalenwert* |
| `P.Wisdom` | *Personal Wisdom* | *standardisierter Skalenwert* |
| `ST.Wisdom` | *Self-transcendent Wisdom* | *standardisierter Skalenwert* |
| `Grat.being` | *Gratitude of Being* | *standardisierter Skalenwert* |
| `Grat.world` | *Gratitude toward the World* | *standardisierter Skalenwert* |
| `PD` | *Peaceful disengagement* | *standardisierter Skalenwert* |
| `Acc` | Akzeptanz | *standardisierter Skalenwert* |
| `Time` | Dauer, die sich eine Person zum jeweiligen Zeitpunkt bereits im Lockdown befindet | Zeit in Wochen |
| `EWB.baseline` | Baseline *Emotional Well-Being* | *standardisierter Skalenwert* |
| `PWB.baseline` | Baseline *Psychological Well-Being* | *standardisierter Skalenwert* |
| `SWB.baseline` | Baseline *Social Well-Being* | *standardisierter Skalenwert* |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.

<!-- </details> -->


### Auftreten
lockdown wird in [Hierarchische Regression](/lehre/klipps-legacy/hierarchische-regression-klinisch-legacy) [[Klipps Legacy](/category/klipps-legacy/)] und [Daten für die Quiz](/lehre/klipps-legacy/quizdaten-klipps-legacy) [[Klipps Legacy](/category/klipps-legacy/)] genutzt.


---

## Quasi-Experimentelle Therapiestudie (`CBTdata`)

<!-- <details><summary>Datensatz</summary> -->

### Beschreibung
Beim Datensatz handelt es sich um ein fiktives Datenbeispiel, bei dem Patient:innen, die an einer Depression oder einer Angststörung leiden, entweder mit einer kognitiven Verhaltenstherapie (CBT) behandelt oder in einer Wartekontrollgruppe belassen wurden. Eine zufällige Zuordnung war nicht vollständig möglich, da die Zuordnung von überweisenden Hausarzt-Praxen der Patient:innen mit beeinflusst werden konnte (z.B. durch Geltendmachung einer besonderen Dringlichkeit der Therapie).

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/CBTdata.rda"))
```

### Größe
Der Datensatz besteht aus 326 Beobachtungen auf 8 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der wichtigsten Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| --- | ----- | ---- |
| `Age` | Alter | *Alter* |
| `Gender` | Geschlecht | female = weiblich, male = männlich |
| `Treatment` | Behandlungsgruppenzugehörigkeit | CBT = kognitive Verhaltenstherapie, WL = Wartekontrolle |
| `Disorder` | psychische Störung | ANX = Angststörung, DEP = Depression |
| `BDI_pre` | Depressionswert gemessen mit Beck Depressions-Inventar vor Therapie | 0 - 63 |
| `SWL_pre` | Lebenszufriedenheit gemessen mit Satisfaction With Life Screening vor Therapie | 5 - 35 |
| `BDI_post` | Depressionswert gemessen mit Beck Depressions-Inventar nach Therapie | 0 - 63 |
| `SWL_post` | Lebenszufriedenheit gemessen mit Satisfaction With Life Screening nach Therapie | 5 - 35 |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->


### Auftreten
CBTdata wird in [Schätzung von Kausaleffekten 1](/lehre/klipps-legacy/kausaleffekte1-legacy) [[Klipps Legacy](/category/klipps-legacy/)] und [Schätzung von Kausaleffekten 2](/lehre/klipps-legacy/kausaleffekte2-legacy) [[Klipps Legacy](/category/klipps-legacy/)] genutzt.

---

## Schulleistungen (`Schulleistungen`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung

Der Datensatz erhält die Ergebnisse von 100 Schüler:innen, die einen Lese- (`reading`) und einen Mathematiktest (`math`) sowie einen allgemeinen Intelligenztest absolviert haben. Der Datensatz enthält zusätzlich die Variable `female` (0 = männlich, 1 = weiblich), die das Geschlecht der Schüler:innen angibt.  

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))
```

### Größe
Der Datensatz besteht aus 100 Beobachtungen auf 4 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt | Kodierung |
| --- | ---- | ---- |
| `female` | Geschlecht | 0 = Männlich (Nein), 1 = Weiblich (Ja) |
| `IQ` | Intelligenzquotient | *IQ-Wert* |
| `reading` | Leseleistung | *Skalenwert* |
| `math` | Matheleistung | *Skalenwert* |

### Fehlende Werte
In dem Datensatz liegen keine fehlenden Werte vor.

<!-- </details> -->

### Auftreten
Schulleistungen wird in [Einleitung und Wiederholung](/lehre/fue-i/einleitung-fue) [[Fue I](/category/fue-i/)], [Daten für die Übungen](/lehre/fue-i/msc1-daten) [[Fue I](/category/fue-i/)], [Regression und Ausreißerdiagnostik](/lehre/fue-i/regression-ausreisser-fue) [[Fue I](/category/fue-i/)], [Moderierte Regression](/lehre/statistik-ii/moderierte-reg) [[Statistik II](/category/statistik-ii/)], [Regressionsanalyse I](/lehre/statistik-ii/regression-i) [[Statistik II](/category/statistik-ii/)], [Regressionsanalyse II](/lehre/statistik-ii/regression-ii) [[Statistik II](/category/statistik-ii/)], [Regressionsanalyse III](/lehre/statistik-ii/regression-iii) [[Statistik II](/category/statistik-ii/)] und [Regression IV: quadratische und moderierte Regression](/lehre/statistik-ii/regression-iv) [[Statistik II](/category/statistik-ii/)] genutzt.


---

## Skalenwerte der Generic Conspiracist Beliefs Scale (`conspiracy`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Die Daten stammen aus der Erhebung zur Validierung der *Generic Conspiracist Beliefs Scale* (GCBS; Brotherton, French, & Pickering, 2013). Die Daten finden Sie öffentlich zugänglich auf der [Open Psychometrics Website](http://openpsychometrics.org/_rawdata/GCBS.zip). Der Fragebogen besteht aus insgesamt 15 Aussagen, die die Proband:innen jeweils von 1 ("definitely not true") bis 5 ("definitely true") hinsichtlich ihres Wahrheitsgehalts einschätzen sollen. Bei dieser Version des Datensatzes wurden die verschiedenen Items bereits zu Skalenwerten zusammengerechnet.

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/conspiracy.rda"))
```

### Größe
Der Datensatz besteht aus 2451 Beobachtungen auf 9 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Bedeutung | Kodierung
| --- | ---- | ---- |
| `edu` | höchster Bildungsabschluss | 1 = not highschool, 2 = highschool, 3 = college |
| `urban` | Typ des Wohnortes | 1 = rural, 2 = suburban, 3 = urban |
| `gender` | Geschlecht | 1 = male, 2 = female, 3 = other |
| `age` | Alter | *Freitext* |
| `GM` | *Government malfeasance* | *Skalenwert* |
| `MG` | *Malevolent global conspiracies* | *Skalenwert* |
| `ET` | *Extraterrestrial cover-up* | *Skalenwert* |
| `PW` | *Personal well-being* | *Skalenwert* |
| `CI` | *Control of information* | *Skalenwert* |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->


### Auftreten - VERALTETS
conspiracy wird in [Konfirmatorische Faktorenanalyse](/lehre/fue-ii/fue-cfa) [[Fue II](/category/fue-ii/)], [Einfaktorielle ANOVA](/lehre/statistik-ii/anova-i) [[Statistik II](/category/statistik-ii/)] und [Zweifaktorielle ANOVA](/lehre/statistik-ii/anova-ii) [[Statistik II](/category/statistik-ii/)] genutzt.


---

## Students in Classes (`StudentsInClasses`)
### Beschreibung
Bei dem Datensatz handelt es sich um ein fiktives Datenbeispiel mit Multilevel-Daten.

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/StudentsInClasses.rda"))
```

### Größe
Der Datensatz besteht aus 850 Beobachtungen auf 850, 1 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

Ebene 1 (within)
| Variable | Inhalt |
| --- | ---- |
| `MatheL` | Mathematikleistung als AV |
| `Motivation` | Motivation der Schüler*innen als Prädiktor |
| `KFT` | Intelligenz der Schüler*innen als Prädiktor (Kognitiver Fähigkeitstest) |

Ebene 2 (between-level)
| Variable | Inhalt |
| --- | ---- |
| `KlassenG` | Klassengröße als Prädiktor |
| `schulklasse` | Klassenzugehörigkeit als Gruppierungsvariable |

### Fehlende Werte
In dem Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->


### Auftreten
StudentsInClasses wird in [Hierarchische Regression](/lehre/fue-i/hierarchische-regression-schule) [[Fue I](/category/fue-i/)] und [Daten für die Übungen](/lehre/fue-i/msc1-daten) [[Fue I](/category/fue-i/)] genutzt.

---

## Therapieerfolg (`Therapy`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Beim Datensatz handelt es sich um ein fiktives Datenbeispiel mit simulierten Daten, in welchem der Therapieerfolg auf mehreren abhängigen Variablen untersucht werden sollen.

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/Therapy.rda"))
```

### Größe
Der Datensatz besteht aus 90 Beobachtungen auf 6 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt |
| --- | ---- |
| `Lebenszufriedenheit` | *Skalenwert* |
| `Arbeitsbeanspruchung` | *Skalenwert* |
| `Depressivität` | *Skalenwert* |
| `Arbeitszufriedenheit` | *Skalenwert* |
| `Intervention` | 1 = Kontrollgruppe, 2 = verhaltenstherapiebasiertes Coaching, 3 = verhaltenstherapiebasiertes Coaching inklusive Gruppenübung  |
| `Geschlecht` | 0 = männlich, 1 = weiblich |

### Fehlende Werte
In dem Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->


### Auftreten
Therapy wird in [Diskriminanzanalyse](/lehre/fue-i/diskriminanzanalyse) [[Fue I](/category/fue-i/)] und [Multivariate Varianzanalyse](/lehre/fue-i/manova) [[Fue I](/category/fue-i/)] genutzt.


---

## Titanic (`Titanic`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Bei dem Datensatz handelt es sich um ein reales Beispiel des Titanicunglücks, in welchem demografische Variablen der Personen erfasst wurden, die sich 1912 an Bord der Titanic befanden. Er ist öffentlich zugänglich auf [Open-Daten-Soft](https://public.opendatasoft.com) zu finden. Der vollständige Datensatz kann [hier](https://public.opendatasoft.com/explore/dataset/titanic-passengers) angesehen werden.

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/Titanic.rda"))
```

### Größe
Der Datensatz besteht aus 714 Beobachtungen auf 4 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Inhalt |
| --- | ---- |
| `survived` | gibt an, ob eine Person das Unglück überlebt hat |
| `pclass` | Klasse, in der die Person reiste (1. bis 3. Klasse) |
| `sex` | Geschlecht der Person (1 = weiblich, 2 = männlich) |
| `age` | Alter der Person |

### Fehlende Werte
In dem Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->


### Auftreten
Titanic wird in [Logistische Regression](/lehre/fue-i/logistische-regression-titanic) [[Fue I](/category/fue-i/)] genutzt.


---

## Traumatische Erlebnisse und psychische Störungen (`trauma`)

<!-- <details><summary>Datensatz</summary> -->
### Beschreibung
Die Daten stammen aus einer echten Untersuchung, deren Datensatz [hier](https://osf.io/a9vun/) im `Open Science Framework` abgelegt ist. In dem Datensatz wurde bspw. erhoben, was für potenziell traumatischen Erlebnissen eine Person ausgesetzt war und zu welchem Grad mittels der Live Event Checklist (LEC). Weiterhin wurden die Depressionswerte anhand des Becks-Depression-Inventar (BDI) und die Anxiety-Werte durch die Zung Self-Rating Anxiety Scale (SAS) erhoben. Für unsere Berechnungen brauchen wir nur einen Ausschnitt der Vielzahl an Variablen. Diesen extrahieren wir aus dem originalen Datensatz und erstellen damit einen neuen. Da das Processing in diesem Fall sehr komplex ist, haben wir das für Sie übernommen.

### Datensatz laden

```r
source(url("https://pandar.netlify.app/daten/Data_Processing_Quiz1.R"))
```

### Größe
Der Datensatz besteht aus 470 Beobachtungen auf 11 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Bedeutung | Kodierung |
| --- | ---- | ---- |
| `gender` | Geschlecht | w = weiblich, m = männlich |
| `bdi` | Depressions-Werte | kumulierte Werte aus BDI |
| `bdi_group` | Gruppierung der BDI-Scores | 1 = keine auffällige Symptomatik, 2 = milde bis moderate Symptome, 3 = moderate bis schwere Symptome, 4 = schwere Symptome |
| `sas` | Anxiety-Werte | kumulierte Werte aus SAS |
| `sas_group` |  Gruppierung der SAS-Scores | 1 = keine auffällige Symptomatik, 2 = milde bis moderate Symptome, 3 = moderate bis schwere Symptome, 4 = schwere Symptome | 
| `future` | Einstellung gegenüber der Zukunft | *Skalenwert*: 5-Punkt-Likert-Skala | 
| `past_neg` | Skala *Past Negative* des ZTPI | *Skalenwert*: 5-Punkt-Likert-Skala | 
| `dissociation` | Gesamtwert der *Dissociative Experiences Scale* | *Skalenwert*: 11-Punkt-Likert-Skala | 
| `sexual_assault` | Erfahrungen mit sexueller Gewalt | 0 = vorhanden, 1 = nicht vorhanden |
| `trauma_exp_kind` | Art des Traumaerlebnisses | 1 = keine Art eines Traumas erlebt, 2 = schwere Krankheiten, 3 = sexuelle Gewalt, 4 = schwere Unfälle, 5 = körperliche Gewalt, 6 = Krieg/Naturkatastrophen |
| `trauma_exp_form` | Form des Traumaerlebnisses | *direct experience* = als Opfer, *indirect experience* = als Zeug:in | 

### Fehlende Werte
In dem Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->


### Auftreten
trauma wird in [Daten für die Quiz](/lehre/klipps-legacy/quizdaten-klipps-legacy) [[Klipps Legacy](/category/klipps-legacy/)] genutzt.

---

## Trivia (`trivia`)

Die Daten stammen aus einer Erhebung von [Fazio et al. (2022)](https://doi.org/10.1037/xge0001211), in der über Teilnehmende einen zweiwöchigen Zeitraum wiederholt faktische Aussagen im Stil eines Quiz per Push-Benachrichtigung präsentiert wurden. Einige dieser Aussage waren wahr, einige waren falsch. Von den präsentierten Aussagen wurden zehn als Zielitems definiert und Teilnehmende wurden am Ende der zwei Wochen danach gefragt, ob diese Aussage wahr ist. Die Aussagen wurden Teilnehmenden unterschiedlich häufig präsentiert (1, 2, 4, 8 oder 16 mal). Ziel der Untersuchung war es, in einem Feldexperiment die aus Laborstudien bekannte Zusammenhangsform zwischen Wiederholungen und Einschätzung des Wahrheitsgehalts zu untersuchen. Die Daten wurden über das [OSF](https://osf.io/re6dh/) bereitgestellt. Dort finden sich auch weitere Informationen zur Studie.

### Datensatz laden

Der Datensatz wird in einem Skript reduziert und Variablen umbenannt. Dieses Skript kann mit folgendem Befehl ausgeführt werden:


```r
source("https://pandar.netlify.app/daten/Data_Processing_trivia.R")
```


Im Environment erscheint dadurch der Datensatz `trivia`. 

### Größe

Der Datensatz besteht aus 4312 Beobachtungen auf 5 Variablen. Der Datensatz liegt im long-Format vor, mit zehn Beobachtungen (eine pro Aussage) für jede Person.

### Variablen

In der folgenden Tabelle erfolgt eine Übersicht der ausgewählten Variablen und ihrer Bedeutungen. 

| Variable | Bedeutung | Kodierung |
| --- | --- | --- |
| `id` | Personen-Code | |
| `rating` | Einschätzung des Wahrheitsgehalts | 1 = mit Sicherheit nicht wahr, 6 = mit Sicherheit wahr |
| `repetition` | Anzahl der Wiederholungen der Präsentation |  |
| `truth` | Objektive Wahrheit der Aussage | 1 = `true`, 2 = `false` |
| `headline` | Eingeschätzte Aussage | 1 =  Clarabell is the clown on the "Howdy Doody" television show. |
| | | 2 = Bach is the composer who wrote the opera "Don Giovanni." |
| | | 3 = In the story of Pinocchio, the goldfish is named Cleo. |
| | | 4 = Beasley is Dagwood's boss in the comic strip "Blondie." |
| | | 5 = Williams is the last name of the playwright who wrote "A Streetcar Named Desire."  |
| | | 6 = Toronto is the capital of Canada. |
| | | 7 = Kingston is the capital of Jamaica. |
| | | 8 = Eloi are the villainous people who lived underground in H.G. Wells' book "The Time Machine." |
| | | 9 = Bullet was the name of Roy Roger's dog. |
| | | 10 = Lima is the capital of Chile. |



### Auftreten
trivia wird in [Nichtlineare Regression](/lehre/statistik-ii/nichtlineare-reg) [[Statistik II](/category/statistik-ii/)] genutzt.


---

## Vegan (`vegan`)

Im Datensatz ist ein Ausschnitt aus den Daten zu einer Validierungsstudie des "Vegetarian Eating Motives Inventory Plus (VEMI+)" von Hopwoods und Stahlmann (2024) enthalten. Die hier getroffene Auswahl beschränkt die Daten auf sechs Dimensionen der Skala, ein paar demografische Angaben und das selbst eingeschätzte Commitment zur veganen Ernährung (die Daten sind ausschließlich von Personen, die sich vegan ernähren). Mehr Informationen finden sich im dazugehörigen [OSF Repo](https://osf.io/ga5rt/).

### Datensatz laden

Der Datensatz wird in einem Skript reduziert und Variablen umbenannt. Dieses Skript kann mit folgendem Befehl ausgeführt werden:


```r
source("https://pandar.netlify.app/daten/Data_Processing_vegan.R")
```


Im Environment erscheint dadruch der Datensatz `vegan`.

### Größe

Der Datensatz besteht aus 987 Beobachtungen auf 10 Variablen.

### Variablen

In der folgenden Tabelle erfolgt eine Übersicht der ausgewählten Variablen und ihrer Bedeutungen. Die letzten sechs Skalen beziehen sich alle auf selbstberichtete Gründe für die vegane Ernährung (von 1 "nicht wichtig" bis 7 "sehr wichtig").

| Variable | Bedeutung | Kodierung |
| --- | --- | --- |
| `age` | Alter | |
| `gender` | Geschlecht | 1 = männlich, 2 = weiblich, 3 = divers |
| `race` | Selbst zugeschriebene Ethnie | _7 Stufen mit Label_ |
| `commitment` | Commitment zur veganen Ernährung | _Skalenwert_ |
| `health` | Gesundheit | _Skalenwert_ |
| `environment` | Umwelt | _Skalenwert_ |
| `animals` | Tierschutz / Tierrechte | _Skalenwert_ |
| `social` | Passung zur sozialen Norm | _Skalenwert_ |
| `workers` | Schutz von Mitarbeitenden in Tierhaltung | _Skalenwert_ |
| `disgust` | Ekel vor Fleischkonsum | _Skalenwert_ |


### Auftreten
vegan wird in [Nichtlineare Regression](/lehre/statistik-ii/nichtlineare-reg) [[Statistik II](/category/statistik-ii/)] und [Regressionsdiagnostik](/lehre/statistik-ii/regressionsdiagnostik) [[Statistik II](/category/statistik-ii/)] genutzt.


---

## Vergleich von Behandlungsformen (`Behandlungsform`)

<!-- <details><summary>Datensatz</summary> -->

### Beschreibung
Der Datensatz enthält Ausprägungen von Patient:innen auf verschiedenen psychotherapeutischen Variablen sowie demografische Informationen. Dabei gibt es zwei kategoriale Variablen: Auf Geschlecht gibt es hier die Ausprägungen männlich und weiblich, während die Therapieform zwischen Kontrollgruppe, KVT und einer Kombination auf KVT und Blended Care unterscheidet. Alle anderen Variablen können als intervallskaliert angenommen werden.

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/Behandlungsform.rda"))
```

### Größe
Der Datensatz besteht aus 100 Beobachtungen auf 6 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Kodierung |
| --- | ---- |
| `Depression` | *Skalenwert* |
| `Therapeutische_Allianz` | *Skalenwert* |
| `Gesundheitszustand` | *Skalenwert* |
| `Interpersonelle_Probleme` | *Skalenwert* |
| `Therapieform` | 1 = Kontrolle, 2 = KVT, 3 = blended Care KVT |
| `Geschlecht` | 1 = männlich, 2 = weiblich |

### Fehlende Werte
Im Datensatz liegen keine fehlenden Werte vor.

<!-- </details> -->

### Auftreten
Behandlungsform wird in [Daten für die Quiz](/lehre/klipps-legacy/quizdaten-klipps-legacy) [[Klipps Legacy](/category/klipps-legacy/)] und [Daten für die Quiz](/lehre/statistik-ii/quizdaten-bsc7) [[Statistik II](/category/statistik-ii/)] genutzt.


---

## Xmas (`Xmas`)

### Beschreibung
Bis zum 25.11.2020 konnten Studierende des Masterkurses MSc1 zu folgenden Weihnachtssongs einschätzen, wie gut diese Ihnen gefallen sowie Auskunft darüber geben, welche Aspekte der Weihnachtszeit ihnen besonders am Herzen liegen. 

### Datensatz laden

```r
load(url("https://pandar.netlify.app/daten/Xmas.rda"))
```

### Größe
Der Datensatz besteht aus 84 Beobachtungen auf 18 Variablen.

### Variablen
In der folgenden Tabelle erfolgt eine Übersicht der erhobenen Variablen und ihre Bedeutungen.

| Variable | Beschreibung | Frage |
| --- | --- | --- |
| `Song1`	| "Oh Tannenbaum"	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song2`	| "Jingle Bells"	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song3`	| "Santa Baby" von z.B. Eartha Kitt	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song4`	| "Feliz Navidad" von José Feliciano	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song5`	| "Holz - Weihnachtslied" von 257ers	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song6`	| "White Christmas" von Elvis Presley	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song7`	| "Let it Go" von Idina Menzel (Frozen Soundtrack)	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song8`	| "Rudolf the red nosed reindeer"	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song9`	| Last Christmas" von Wham!	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song10`	| "Oh Du Fröhliche"	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song11`	| "Schneeflöckchen, Weißröckchen"	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song12`	| "Christmas is all around" aus dem Film "Love Actually - Tatsächlich Liebe"	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song13`	| "Driving home for Christmas" von Chris Rea	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Song14`	| "Lass jetzt los (Let it Go)" von Helene Fischer (Die Eiskönigin – Völlig unverfroren Soundtrack)	|	Wie gut gefallen Ihnen folgende X-Mas Songs?
| `Y1`	| Weihnachtsfeiertage	|	Wie sehr mögen Sie Weihnachten bzw. die Weihnachtszeit mit allem was dazugehört?
| `Y2`	| gesamte Weihnachtszeit	|	Wie sehr mögen Sie Weihnachten bzw. die Weihnachtszeit mit allem was dazugehört?
| `Y3`	| Weihnachtsferien	|	Wie sehr mögen Sie Weihnachten bzw. die Weihnachtszeit mit allem was dazugehört?
| `Y4`	| Winterzeit	|	Wie sehr mögen Sie Weihnachten bzw. die Weihnachtszeit mit allem was dazugehört?

### Fehlende Werte
In dem Datensatz liegen keine fehlenden Werte vor.
<!-- </details> -->

### Auftreten
Xmas wird in [Daten für die Übungen](/lehre/fue-i/msc1-daten) [[Fue I](/category/fue-i/)] genutzt.
