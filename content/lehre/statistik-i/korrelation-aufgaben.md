---
title: "Korrelation - Aufgaben" 
type: post
date: '2019-10-18' 
slug: korrelation-aufgaben
categories: [] 
tags: ["Statistik I Übungen"] 
subtitle: ''
summary: '' 
authors: [nehler, winkler, vogler, schroeder]
weight:
lastmod: '2024-01-16'
featured: no
banner:
  image: "/header/storch_with_baby.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1217289)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/korrelation
  - icon_pack: fas
    icon: star
    name: Lösungen
    url: /lehre/statistik-i/korrelation-loesungen
output:
  html_document:
    keep_md: true
---


## Vorbereitung



> Laden Sie zunächst den Datensatz `fb23` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb23.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/korrelation/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

Prüfen Sie zur Sicherheit, ob alles funktioniert hat: 


```r
dim(fb23)
```

```
## [1] 179  53
```

```r
names(fb23)
```

```
##  [1] "mdbf1_pre"    "mdbf2_pre"    "mdbf3_pre"   
##  [4] "mdbf4_pre"    "mdbf5_pre"    "mdbf6_pre"   
##  [7] "mdbf7_pre"    "mdbf8_pre"    "mdbf9_pre"   
## [10] "mdbf10_pre"   "mdbf11_pre"   "mdbf12_pre"  
## [13] "lz"           "extra"        "vertr"       
## [16] "gewis"        "neuro"        "offen"       
## [19] "prok"         "nerd"         "grund"       
## [22] "fach"         "ziel"         "wissen"      
## [25] "therap"       "lerntyp"      "hand"        
## [28] "job"          "ort"          "ort12"       
## [31] "wohnen"       "uni1"         "uni2"        
## [34] "uni3"         "uni4"         "attent_pre"  
## [37] "gs_post"      "wm_post"      "ru_post"     
## [40] "attent_post"  "hand_factor"  "fach_klin"   
## [43] "unipartys"    "mdbf4_pre_r"  "mdbf11_pre_r"
## [46] "mdbf3_pre_r"  "mdbf9_pre_r"  "mdbf5_pre_r" 
## [49] "mdbf7_pre_r"  "wm_pre"       "gs_pre"      
## [52] "ru_pre"       "ru_pre_zstd"
```

Der Datensatz besteht aus 179 Zeilen (Beobachtungen) und 53 Spalten (Variablen). Falls Sie bereits eigene Variablen erstellt haben, kann die Spaltenzahl natürlich abweichen.


***

## Aufgabe 1

Das Paket `psych` enthält vielerlei Funktionen, die für die Analyse von Datensätzen aus psychologischer Forschung praktisch sind. Eine von ihnen (`describe()`) erlaubt es, gleichzeitig verschiedene Deskriptivstatistiken für Variablen zu erstellen.

  * Installieren (falls noch nicht geschehen) und laden Sie das Paket `psych`.
  * Nutzen Sie den neugewonnen Befehl `describe()`, um sich gleichzeitig die verschiedenen Deskriptivstatistiken für Lebenszufriedenheit (`lz`) ausgeben zu lassen.
  * Die Funktion `describeBy()` ermöglicht außerdem Deskriptivstatistiken in Abhängigkeit einer gruppierenden Variable auszugeben. Machen Sie sich diesen Befehl zunutze, um sich die Lebenszufriedenheit (`lz`) abhängig von der derzeitigen Wohnsituation (`wohnen`) anzeigen zu lassen.
  * `describe()` kann auch genutzt werden, um gleichzeitig Deskriptivstatistiken für verschiedene Variablen zu berechnen. Nutzen Sie diese Funktionalität, um sich gleichzeitg die univariaten Deskriptivstatistiken für die fünf Persönlichkeitsdimensionen ausgeben zu lassen.


## Aufgabe 2

In der Befragung am Anfang des Semesters wurde gefragt, ob Sie neben der Uni einen Nebenjob (`job`) ausüben und mit welcher Hand sie primär schreiben (`hand`). Erstellen Sie für diese beiden Variablen eine Kreuztabelle mit Randsummen.

  * Stellen Sie zunächst sicher, dass die Variablen als Faktoren vorliegen und die Kategorien beider Variablen korrekt bezeichnet sind. 
  * Wie viele Personen sind Linkshänder und haben keinen Nebenjob? 
  * Was ist der relative Anteil aller Teilnehmenden, die einem Nebenjob nachgehen?

  * Berechnen Sie nun mit Hilfe des `psych`-Pakets die Korrelationskoeffizienten Phi ($\phi$) und Yules Q für das oben genannte Beispiel.


## Aufgabe 3

Welche der fünf Persönlichkeitsdimensionen Extraversion (`extra`), Verträglichkeit (`vertr`), Gewissenhaftigkeit (`gewis`), Neurotizismus (`neuro`) und Offenheit für neue Erfahrungen (`offen`) ist am stärksten mit der Lebenszufriedenheit korreliert (`lz`)?

  * Überprüfen Sie die Voraussetzungen für die Pearson-Korrelation.
  * Erstellen Sie für diese Frage eine Korrelationsmatrix, die alle Korrelationen enthält. Verwenden Sie die Funktion `round()` (unter Betrachtung der Hilfe), um die Werte auf zwei Nachkommastellen zu runden und die Tabelle dadurch übersichtlicher darzustellen.
  * Wie würden Sie das Ausmaß der betragsmäßig größten Korrelation mit der Lebenszufriedenheit nach den Richtlinien von Cohen (1988) einschätzen?
  * Ist der Korrelationskoeffizient von Neurotizismus und Lebenszufriedenheit statistisch bedeutsam?

## Aufgabe 4

Untersuchen Sie die Korrelation zwischen Nerdiness (`nerd`) und Prokrastinationstendenz (`prok`). Berechnen Sie dafür ein geeignetes Korrelationsmaß und testen Sie dieses auf Signifikanz.


## Aufgabe 5 Bonus

Im vorherigen Kapitel haben wir die Poweranalyse behandelt. Solche Analysen kann man auch für Korrelationen verwirklichen. Frischen Sie gerne Ihren Wissensstand [hier](/lehre/statistik-i/simulation-poweranalyse/) noch einmal auf.
Daher, führen sie mit Hilfe des Pakets `WebPower` eine Sensitivitätsanalyse für den Datensatz `fb23` unter folgenden Parametern durch:

  * Fehler 1. Art ($\alpha = 5\%$)
  * Fehler 2. Art ($\beta = 20\%$)
  * Alternativhypothese ($H_1$: $\rho_1 \neq 0$)




***
