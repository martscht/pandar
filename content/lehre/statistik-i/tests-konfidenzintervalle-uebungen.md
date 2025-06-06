---
title: Tests und Konfidenzintervalle - Übungen
type: post
date: '2019-10-18'
slug: tests-konfidenzintervalle-uebungen
categories: Statistik I Übungen
tags: []
subtitle: ''
summary: ''
authors:
- nehler
- vogler
- scheppa-lahyani
- pommeranz
weight: ~
lastmod: '2025-05-13'
featured: no
banner:
  image: /header/angel_of_the_north.jpg
  caption: '[Courtesy of pxhere](https://pxhere.com/de/photo/1240882)'
projects: []
reading_time: no
share: no
links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-i/tests-konfidenzintervalle
- icon_pack: fas
  icon: star
  name: Lösungen
  url: /lehre/statistik-i/tests-konfidenzintervalle-loesungen
output:
  html_document:
    keep_md: yes
private: 'true'
---




## Vorbereitung 



> Laden Sie zunächst den Datensatz `fb24` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb24.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/tests-konfidenzintervalle/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb24)
```

```
## [1] 192  50
```

Der Datensatz besteht aus 192 Zeilen (Beobachtungen) und mindestens (unter Einbeziehung der Ergänzungen) 50 Spalten (Variablen). Falls Sie bereits weitere eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.


## Aufgabe 1

Im Laufe der Aufgaben sollen Sie auch Funktionen aus Paketen nutzen, die nicht standardmäßig aktiviert und auch eventuell noch nicht installiert sind. Sorgen Sie in dieser Aufgabe zunächst dafür, dass Funktionen aus den Paketen `psych` und `car` nutzbar sind. Denken Sie an die beiden dargestellten Schritte aus dem Tutorial und auch daran, dass eine Installation nur einmalig notwendig ist. 

## Aufgabe 2

Die mittlere Lebenszufriedenheit (`lz`) in Deutschland liegt bei $\mu$ = 4.4.

**2.1** Was ist der Mittelwert der Stichprobe ($\bar{x}$) und die geschätzte Populations-Standardabweichung ($\hat\sigma$) der Lebenszufriedenheit in der Gruppe der Psychologie-Studierenden? Schätzen Sie außerdem ausgehend von unseren erhobenen Daten den Standardfehler des Mittelwerts ($\hat{\sigma_{\bar{x}}}$) der Lebenszufriedenheit?

**2.2** Sind die Lebenszufriedenheitswerte normalverteilt? Veranschaulichen Sie dies mit einer geeigneten optischen Prüfung. Benutzen Sie außerdem die `qqPlot`-Funktion aus dem `car`-Paket. Wann kann man in diesem Fall von einer Normalverteilung ausgehen?

**2.3** Unterscheidet sich die Lebenszufriedenheit der Psychologie-Studierenden von der Lebenszufriedenheit der Gesamtbevölkerung (wie bereits geschrieben $\mu$ = 4.4)? Bestimmen Sie das 99%ige Konfidenzintervall.


## Aufgabe 3

**3.1** Unterscheidet sich der Mittelwert der Extraversionswerte (`extra`) der Studierenden der Psychologie (1. Semester) von dem der Gesamtbevölkerung ($\mu$ = 3.5, $\sigma$ = 1.2)? Bestimmen Sie den p-Wert und treffen Sie basiered auf Ihrem Ergebnis eine Signifikanzentscheidung.

**3.2** Sind die Offenheits-Werte (`offen`) der Psychologie-Studierenden (1. Semester) größer als die Offenheits-Werte der Gesamtbevölkerung ($\mu$ = 3.6)? Bestimmen Sie den p-Wert und treffen Sie basierend auf Ihrem Ergebnis eine Signifikanzentscheidung.

**3.3** Überprüfen Sie Ihre Entscheidung aus **3.2** erneut, indem sie händisch ihren empirischen t-Wert ermittlen und mit dem entsprechenden kritischen t-Wert vergleichen.

**3.4** Zeigen die Psychologie-Studierenden (1. Semester) höhere Werte auf der Verträglichkeits-Skala (`vertr`) als die Grundgesamtheit ($\mu$ = 3.3)? Bestimmen Sie das 99%-Konfidenzintervall sowie die Effektgröße und ordnen sie diese ein.


## Aufgabe 4

Folgende Aufgaben haben ein erhöhtes Schwierigkeitsniveau.
Nehmen Sie für die weiteren Aufgaben den Datensatz `fb24` als Grundgesamtheit (Population) an.

**4.1** Sie haben eine Stichprobe mit $n$ = 42 aus dem Datensatz gezogen. Der mittlere Gewissenhaftigkeits-Wert dieser Stichprobe beträgt $\bar{x}$ = 3.6. Unterscheiden sich die Psychologie-Studierenden (1. Semester) der Stichprobe in ihrem Wert (`gewis`) von der Grundgesamtheit?
Berechnen Sie den angemessenen Test und bestimmen Sie das 95%ige Konfidenzintervall.

**4.2** Ziehen Sie nun selbst eine Stichprobe mit $n$ = 31 aus dem Datensatz. Nutzen Sie hierfür die `set.seed(1234)`-Funktion. Versuchen Sie zunächst selbst mit Hilfe der `sample()`-Funktion eine Stichprobe ($n$ = 31) zu ziehen. Falls Sie hier von alleine nicht weiterkommen, ist das kein Problem. Nutzen Sie dann für die weitere Aufgabenstellung folgenden Code:

<details><summary>Code</summary>


```r
anyNA(fb24$gewis) #NA's vorhanden
```

```
## [1] TRUE
```

```r
set.seed(1234) #erlaubt Reproduzierbarkeit
fb24_sample <- fb24[sample(nrow(fb24), size = 31), ] #zieht eine Stichprobe mit n = 31


mean_gewis_pop <- mean(fb24$gewis, na.rm = TRUE) #Mittelwert der Population

sd_gewis_pop <- sd(fb24$gewis, na.rm = TRUE) * sqrt((length(na.omit(fb24$gewis)) - 1) / length(na.omit(fb24$gewis))) #empirische Standardabweichung der Population

se_gewis <- sd_gewis_pop / sqrt(length(na.omit(fb24$gewis))) #Standardfehler

mean_gewis_smpl2 <- mean(fb24_sample$gewis, na.rm = TRUE) #Mittelwert der Stichprobe

z_gewis2 <- (mean_gewis_smpl2 - mean_gewis_pop) / se_gewis #empirischer z-Wert

z_krit <- qnorm(1 - 0.05/2) #kritischer z-Wert, zweiseitig

abs(z_gewis2) > z_krit #signifikant
```

```
## [1] TRUE
```

```r
2 * pnorm(z_gewis2) #p < .05, signifikant
```

```
## [1] 0.03659774
```

</details>

Untersuchen Sie erneut, ob sich die Stichprobe von der Grundgesamtheit (Population) in ihren Gewissenhaftigkeits-Werten unterscheidet. Berechnen Sie den angemessenen Test.
