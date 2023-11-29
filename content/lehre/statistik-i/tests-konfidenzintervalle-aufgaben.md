---
title: "Tests und Konfidenzintervalle - Aufgaben" 
type: post
date: '2019-10-18' 
slug: tests-konfidenzintervalle-aufgaben 
categories: [] 
tags: ["Statistik I Übungen"] 
subtitle: ''
summary: '' 
authors: [nehler, vogler, scheppa-lahyani, pommeranz] 
weight: 
lastmod: '2023-11-28'
featured: no
banner:
  image: "/header/angel_of_the_north.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/1240882)"
projects: []
reading_time: false
share: false

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
    keep_md: true
---




## Vorbereitung 



> Laden Sie zunächst den Datensatz `fb23` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb23.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/tests-und-konfidenzintervalle/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb23)
```

```
## [1] 179  48
```

```r
str(fb23)
```

```
## 'data.frame':	179 obs. of  48 variables:
##  $ mdbf1_pre   : int  4 2 4 NA 3 3 2 3 3 2 ...
##  $ mdbf2_pre   : int  2 2 3 3 3 2 3 2 2 1 ...
##  $ mdbf3_pre   : int  3 4 2 2 2 3 3 1 2 2 ...
##  $ mdbf4_pre   : int  2 2 1 2 1 1 3 2 3 3 ...
##  $ mdbf5_pre   : int  3 2 3 2 2 1 3 3 2 4 ...
##  $ mdbf6_pre   : int  2 1 2 2 2 2 2 3 2 2 ...
##  $ mdbf7_pre   : int  4 3 3 1 1 2 2 3 3 3 ...
##  $ mdbf8_pre   : int  3 2 3 2 3 3 2 3 3 2 ...
##  $ mdbf9_pre   : int  2 4 1 2 3 3 4 2 2 3 ...
##  $ mdbf10_pre  : int  3 2 3 3 2 4 2 2 2 2 ...
##  $ mdbf11_pre  : int  3 2 1 2 2 1 3 1 2 4 ...
##  $ mdbf12_pre  : int  1 1 2 3 2 2 2 3 3 2 ...
##  $ lz          : num  5.4 3.4 4.4 4.4 6.4 5.6 5.4 5 4.8 6 ...
##  $ extra       : num  3.5 3 4 3 4 4.5 3.5 3.5 2.5 3 ...
##  $ vertr       : num  1.5 3 3.5 4 4 4.5 4 4 3 3.5 ...
##  $ gewis       : num  4.5 4 5 3.5 3.5 4 4.5 2.5 3.5 4 ...
##  $ neuro       : num  5 5 2 4 3.5 4.5 3 2.5 4.5 4 ...
##  $ offen       : num  5 5 4.5 3.5 4 4 5 4.5 4 3 ...
##  $ prok        : num  1.8 3.1 1.5 1.6 2.7 3.3 2.2 3.4 2.4 3.1 ...
##  $ nerd        : num  4.17 3 2.33 2.83 3.83 ...
##  $ grund       : chr  "Berufsziel" "Interesse am Menschen" "Interesse und Berufsaussichten" "Wissenschaftliche Ergänzung zu meinen bisherigen Tätigkeiten (Arbeit in der psychiatrischen Akutpflege, Gestalt"| __truncated__ ...
##  $ fach        : Factor w/ 5 levels "Allgemeine","Biologische",..: 4 4 4 4 4 4 NA 4 4 NA ...
##  $ ziel        : Factor w/ 4 levels "Wirtschaft","Therapie",..: 2 2 2 2 2 2 NA 4 2 2 ...
##  $ wissen      : int  5 4 5 4 2 3 NA 4 3 3 ...
##  $ therap      : int  5 5 5 5 4 5 NA 3 5 5 ...
##  $ lerntyp     : num  3 3 1 3 3 1 NA 1 3 3 ...
##  $ hand        : int  2 2 2 2 2 2 NA 2 1 2 ...
##  $ job         : int  1 1 1 1 2 2 NA 2 1 2 ...
##  $ ort         : int  2 1 1 1 1 2 NA 1 1 2 ...
##  $ ort12       : int  2 1 2 2 2 1 NA 2 2 1 ...
##  $ wohnen      : Factor w/ 4 levels "WG","bei Eltern",..: 4 1 1 1 1 2 NA 3 3 2 ...
##  $ uni1        : num  0 1 0 1 0 0 0 0 0 0 ...
##  $ uni2        : num  1 1 1 1 1 1 0 1 1 1 ...
##  $ uni3        : num  0 1 0 0 1 0 0 1 1 0 ...
##  $ uni4        : num  0 1 0 1 0 0 0 0 0 0 ...
##  $ attent_pre  : int  6 6 6 6 6 6 NA 4 5 5 ...
##  $ gs_post     : num  3 2.75 4 2.5 3.75 NA 4 2.75 3.75 2.5 ...
##  $ wm_post     : num  2 1 3.75 2.75 3 NA 3.25 2 3.25 2 ...
##  $ ru_post     : num  2.25 1.5 3.75 3.5 3 NA 3.5 2.75 2.75 2.75 ...
##  $ attent_post : int  6 5 6 6 6 NA 6 4 5 3 ...
##  $ hand_factor : Factor w/ 2 levels "links","rechts": 2 2 2 2 2 2 NA 2 1 2 ...
##  $ mdbf4_pre_r : num  3 3 4 3 4 4 2 3 2 2 ...
##  $ mdbf11_pre_r: num  2 3 4 3 3 4 2 4 3 1 ...
##  $ mdbf3_pre_r : num  2 1 3 3 3 2 2 4 3 3 ...
##  $ mdbf9_pre_r : num  3 1 4 3 2 2 1 3 3 2 ...
##  $ gs_pre      : num  3 2.5 3.75 NA 3.25 3.5 2 3.25 2.75 1.75 ...
##  $ ru_pre      : num  2 1 2.75 2.75 2.25 2 1.75 3.25 2.75 2.25 ...
##  $ ru_pre_zstd : num [1:179, 1] -0.9749 -2.3095 0.0261 0.0261 -0.6412 ...
##   ..- attr(*, "scaled:center")= num 2.73
##   ..- attr(*, "scaled:scale")= num 0.749
```

Der Datensatz besteht aus 179 Zeilen (Beobachtungen) und 48 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.


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

**3.3** Überprüfen Sie Ihre Entscheidung aus **4.2** erneut, indem sie händisch ihren empirischen t-Wert ermittlen und mit dem entsprechenden kritischen t-Wert vergleichen.

**3.4** Zeigen die Psychologie-Studierenden (1. Semester) höhere Werte auf der Verträglichkeits-Skala (`vertr`) als die Grundgesamtheit ($\mu$ = 3.3)? Bestimmen Sie das Konfidenzintervall sowie die Effektgröße und ordnen sie diese ein.


## Aufgabe 4

Folgende Aufgaben haben ein erhöhtes Schwierigkeitsniveau.
Nehmen Sie für die weiteren Aufgaben den Datensatz `fb23` als Grundgesamtheit (Population) an.

**4.1** Sie haben eine Stichprobe mit $n$ = 42 aus dem Datensatz gezogen. Der mittlere Gewissenhaftigkeits-Wert dieser Stichprobe beträgt $\bar{x}$ = 3.6. Unterscheiden sich die Psychologie-Studierenden (1. Semester) der Stichprobe in ihrem Wert (`gewis`) von der Grundgesamtheit?
Berechnen Sie den angemessenen Test und bestimmen Sie das 95%ige Konfidenzintervall.

**4.2** Ziehen Sie nun selbst eine Stichprobe mit $n$ = 31 aus dem Datensatz. Nutzen Sie hierfür die `set.seed(1234)`-Funktion. Versuchen Sie zunächst selbst mit Hilfe der `sample()`-Funktion eine Stichprobe ($n$ = 31) zu ziehen. Falls Sie hier von alleine nicht weiterkommen, ist das kein Problem. Nutzen Sie dann für die weitere Aufgabenstellung folgenden Code:

<details><summary>Code</summary>


```r
set.seed(1234) #erlaubt Reproduzierbarkeit
fb23_sample <- fb23[sample(nrow(fb23), size = 31), ] #zieht eine Stichprobe mit n = 31

anyNA(fb23$gewis) #keine NA's vorhanden
```

```
## [1] FALSE
```

```r
mean_gewis_pop <- mean(fb23$gewis) #Mittelwert der Population

sd_gewis_pop <- sd(fb23$gewis) * sqrt((nrow(fb23) - 1) / nrow(fb23)) #empirische Standardabweichung der Population

se_gewis <- sd_gewis_pop / sqrt(nrow(fb23)) #Standardfehler

mean_gewis_smpl2 <- mean(fb23_sample$gewis) #Mittelwert der Stichprobe

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
## [1] 0.02563394
```

</details>

Untersuchen Sie erneut, ob sich die Stichprobe von der Grundgesamtheit (Population) in ihren Gewissenhaftigkeits-Werten unterscheidet. Berechnen Sie den angemessenen Test.
