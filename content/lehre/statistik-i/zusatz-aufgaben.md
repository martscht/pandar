---
title: "Freiwillige Übungsaufgaben (alle Abschnitte)" 
type: post
date: '2021-11-29' 
slug: zusatz-aufgaben
categories: [Statisik I Übungen"] 
tags: [] 
subtitle: ''
summary: 'In diesem Beitrag werden abhängige Stichproben beleuchtet. Dabei geht es um vor allem um die Durchführung des abhängigen t-Tests und des abhängigen Wilcoxon-Tests.' 
authors: [cezanne, mueller, nehler] 
weight: 13
lastmod: '2025-02-07'
featured: no 
banner:
  image: "/header/mechanical_number_display.png"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/753544)"
projects: []
_build:
  list: never
  
links:
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/zusatz-aufgaben
  - icon_pack: fas
    icon: star
    name: Lösungen
    url: /lehre/statistik-i/zusatz-loesungen
output:
  html_document:
    keep_md: true
---



Wie angekündigt finden Sie im Folgenden nun Aufgaben, um den Umgang mit `R` nochmal zu üben.

Zunächst wollen wir nochmal Übungen mit einem kleinen, ausgedachten Datensatz durchführen. Stellen Sie sich dafür vor, dass Sie im Rahmen Ihres Studiums eine Untersuchung mit 10 Studierenden durchgeführt haben. Dabei haben Sie das Alter (in ganzen Zahlen), das Geschlecht (weiblich, männlich, divers), die deutsche Lieblingsstadt (Berlin, Hamburg, München, Frankfurt, Dresden) sowie die generelle Lebenszufriedenheit, gemessen mit 5 Items, erhoben. 

## Aufgabe 1

Laden Sie die folgenden 3 Vektoren und den Datensatz in Ihr Environment.

* Welche Klasse haben die Vektoren? 
* Wie lauten die Dimensionen des Datensatzes? 


```r
#demographische Daten:
geschlecht <- c(1, 2, 2, 1, 1, 1, 3, 2, 1, 2)   
alter <- c(20, 21, 19, 19, 20, 23, 22, 21, 19, 25)
stadt <- c(2, 1, 1, 4, 3, 2, 5, 4, 1, 3) 

#Lebenszufriedenheit:
lz_items <- data.frame(lz1 = c(3, 4, 4, 2, 1, 4, 3, 5, 4, 3), lz2 = c(2, 2, 3, 2, 4, 1, 2, 3, 2, 2), lz3 = c(5, 3, 4, 4, 3, 5, 2, 4, 3, 4), lz4 = c(2, 1, 3, 2, 2, 3, 2, 4, 2, 1), lz5 = c(4, 4, 3, 3, 1, 4, 3, 4, 5, 3)) 
```

* Führen Sie die Vektoren und den Datensatz zusammen zu einem gemeinsamen Datensatz mit dem Namen `data`. Wie viele Variablen hat der neue Datensatz, wieviele Proband:innen liegen vor?

* Wandeln Sie die Variable `geschlecht` und die Variable `stadt` in Faktoren um. Dabei sind die Zahlen in der Reihenfolge im Beschreibungstext zugeordnet (Beispiel: `1` bei Geschlecht wäre `weiblich`). Überschreiben Sie die alten Variablen und überprüfen Sie die Umwandlung.


## Aufgabe 2

Nun wollen wir die Extraktion von bestimmten Datenpunkten nochmal üben. 

* Welche deutsche Lieblingsstadt hat Person 4 angegeben?
* Welches Geschlecht haben Person 7 und 8 angekreuzt? 
* Wie lauten die Lebenszufriedenheits-Werte von Person 2 und 3 auf allen Items?


## Aufgabe 3

Im Folgenden soll nicht nur extrahiert, sondern auch ersetzt werden.

* Ihnen fällt auf, dass die Angabe der 3. Person in Item `lz2` und `lz4` nicht korrekt sind. Die korrekten Werte betragen 2 (für `lz2`) und 1 (für `lz4`). Wandeln Sie die Angaben im Datensatz entsprechend um.

* Person 6 hat zudem ein falsches Alter angegeben (eigentlich 24). Welches Alter steht noch im Datensatz? Korrigieren Sie es entsprechend.


## Aufgabe 4

Bei Item `lz2` und `lz4` handelt es sich um invertierte Items. Wandeln Sie die Items entsprechend um, sodass einheitlich eine hohe Ausprägung für eine hohe Lebenszufriedenheit steht. Überschreiben Sie dabei die Ursprungsvariablen. Die Variablen hatten 5 mögliche Antwortkategorien.


## Aufgabe 5

Datenextraktion kann auch mit logischer Überprüfung kombiniert werden. Bearbeiten Sie dafür folgende Fragestellungen

* Haben Person 1 und Person 5 dasselbe Alter und Geschlecht? 
* Haben Person 2 und Person 10 dasselbe Geschlecht und dieselbe Lieblingsstadt angegeben? 


## Aufabe 6

Der Datensatz enthält noch nicht die vollständige Menge an erhobenen Informationen. Sie hatten zusätzlich die Lieblingsfarbe der Versuchspersonen erhoben:



```r
farbe <- c(1, 2, 1, 1, 3, 4, 2, 2, 1, 4)  #1 = blau, 2 = rot, 3 = grün, 4 = schwarz
```

* Diese Angaben fehlen jedoch in `data`. Fügen Sie diese neue Spalte mit den entsprechenden Labels dem Datensatz hinzu. 


## Aufgabe 7 

Nach einiger Zeit können Sie noch 3 weitere Proband:innen von der Teilnahme überzeugen. Fügen Sie diese zusätzlich an den Datensatz an. Die aufgeführten Zeilen wurden bereits invertiert. 



```r
c("weiblich", 21, "Frankfurt", 4, 4, 3, 4, 4, "blau")
c("männlich", 19, "Dresden", 2, 5, 2, 4, 3, "schwarz")
c("weiblich", 20, "Berlin", 1, 5, 1, 5, 1, "blau")
```


## Aufgabe 8 

Schauen Sie sich die Struktur Ihres Datensatzes an. Was fällt Ihnen auf? Passen Sie den Datensatz ggf. wieder an seine ursprüngliche Struktur an.  


## Aufgabe 9

Erstellen Sie eine neue Variable `lz_ges` im Datensatz `data`, die die Antworten auf den lz-Items bestmöglich zusammenfasst. 


## Aufgabe 10 

Speichern Sie den Datensatz als RDA-Datei unter dem Namen `Data_lz` lokal in Ihrem Praktikums-Ordner ab. Lassen Sie sich erst den Pfad des aktuellen Working Directory ausgeben und ändern Sie diesen gegebenenfalls.


## Aufgabe 11 

Nachdem nun der Datensatz auf dem finalen Niveau ist, sollen Sie erste deskriptivstatistische Werte bestimmen. 

* Wieviele Proband:innen haben die Farbe "schwarz" als Lieblingsfarbe ausgewählt? 
* Was ist der Modus der Variable `farbe`? Wie hoch ist die Häufigkeit?


## Aufgabe 12

Betrachten wir statt der Variable `farbe` nun die Variable `geschlecht`.

* Lassen Sie sich die absolute Häufigkeit in der für Menschen ungünstigeren grafischen Darstellungsform ausgeben.
* Wie hoch ist der relative Anteil der Versuchspersonen, die "männlich" angegeben haben?


## Aufgabe 13

Berechnen Sie den relativen Informationsgehalt für die Variable `stadt`. Was bedeutet das Ergebnis? 


## Aufgabe 14

Betrachten wir nun ein einzelnes Item (`lz3`) aus dem Fragebogen zur Lebenszufriedenheit.

* Berechnen Sie ein geeignetes Maß der zentralen Tendenz. 
* Geben Sie den Interquartilsbereich an. 
* Überprüfen Sie Ihre Angabe, indem Sie sich einen Boxplot ausgeben lassen. 
* Berechnen Sie zudem den Interquartilsabstand.


## Aufgabe 15

Anstatt nur einer Variable soll nun der gesamte Skalenwert `lz_ges` betrachtet werden.

* Berechnen Sie ein sinnvolles Maß der zentralen Tendenz.
* Bestimmen Sie ein passendes Streuungsmaß.


## Aufgabe 16

Legen wir die ausgedachten Werte nun beiseite. Die restlichen Zusatzaufgaben beschäftigen mit dem Datensatz des letzten Jahrgangs. Löschen Sie die Inhalte Ihres Environments und laden Sie sich den Datensatz `fb22` in das Environment. Dies können sie lokal von ihrem PC, aber auch mittels der URL von der PandaR-Website machen. Der Datensatz sollte 159 Versuchspersonen enthalten.


```r
rm(list = ls())
load(url('https://pandar.netlify.app/daten/fb22.rda'))
```

Wandeln Sie zum Start die Variable `lerntyp` in einen Faktor um. Die Labels lauten in dieser Reihenfolge: `c(alleine, Gruppe, Mischtyp)`. Erstellen Sie dafür keine neuen Spalten, sondern überschreiben Sie die bereits bestehenden. Überprüfen Sie im Nachhinein die Umwandlung.


## Aufgabe 17 

Erstellen Sie ein Balkendiagramm mit der Variable `lerntyp`. Geben Sie der Grafik einen Titel, eine Achsenbeschriftung, sowie ein fesches, hippes farbliches Design.


## Aufgabe 18

Betrachten Sie die Variablen `prok4` und `prok10`. Liegen NAs vor? Wenn ja, wieviele? Überprüfen Sie dies mit Ihnen bekannten Befehlen.


## Aufgabe 19

Die beiden Variablen sollen weiter betrachtet werden. Entfernen Sie bei Analysen (falls nötig) die fehlenden Werte. 

* Bestimmen Sie das Maß der zentralen Tendenz für die beiden Variablen. Ist es für `prok4` und `prok5` dieselbe Kategorie, die die Proband:innen-Angaben in zwei gleich große Hälften teilt? 
* In welchem Bereich liegen die mittleren 50% der Angaben in den beiden Variablen `prok4` und `prok10`?
* Lassen Sie sich dies zusätzlich grafisch ausgeben.


## Aufgabe 20

Nun betrachten wir den Skalenwert, der unter `gewis` abgelegt ist. Dieser steht für die Persönlichkeitseigenschaft Gewissenhaftigkeit.

* Was ist der niedrigste, was ist der höchste Wert der Variable? 
* Wie hoch ist die mittlere Ausprägung?


## Aufgabe 21 

Erzielt der Jahrgang 22 im Mittel, rein deskriptiv betrachtet, höhere Werte in Gewissenhaftigkeit (`gewis`) als in Extraversion (`extra`) oder liegt genau der umgekehrte Fall vor? In welcher der beiden Variablen variieren die Angaben stärker? Gehen Sie für die Beantwortung davon aus, dass die Skalen gleich genormt sind.


## Aufgabe 22

Verträglichkeit ist in `vertr` abgelegt. 

* Lassen Sie sich das Histogramm ausgeben. 
* Zentrieren Sie die Variable `vertr`. Legen Sie dafür eine neue Spalte in `fb22` mit dem Namen `vertr_z` an und lassen Sie sich erneut ein Histogramm ausgeben. Was hat sich verändert? 
* Standardisieren Sie die Variable `vertr` und speichern Sie diese ebenfalls unter einer neuen Spalte mit dem Namen `vertr_st` ab. Was ist nun anders beim Histogramm?


## Aufgabe 23 

Vergleichen Sie deskriptiv das Maß der zentralen Tendenz in der Variable `extra` zwischen den Teilnehmenden, die `alleine`, und denjenigen, die `Gruppen` in der bevorzugten Lernform angegeben haben. Welche der beiden Gruppen hat die höhere Ausprägung? Welche der beiden Gruppen ist im Mittel nerdier (`nerd`)? 


## Aufgabe 24

Etwa 75% Prozent der Psychologiestudierenden in Deutschland sind weiblich. Sie treffen zufällig auf 15 Psychologiestudierende.

* Wie wahrscheinlich ist es, dass genau 9 dieser Personen weiblich sind?
* Wie wahrscheinlich ist es, dass mindestens 11 der Personen weiblich sind?
* Stellen Sie die Verteilungsfunktion der kummulierten Wahrscheinlichkeit aller Werte in einem Plot dar.


## Aufgabe 25

In Deutschland liegt die Gewissenhaftigkeit (`gewis`) bei Frauen im Mittel bei *µ* = 3.73.

* Sind Frauen, die Psychologie studieren, im Mittel gewissenhafter als Frauen in der Allgemeinbevölkerung? Stellen Sie die Hypothesen ($H_0$ und $H_1$) auf und führen Sie einen geeigneten Test durch.
* Geben Sie zudem das {{<math>}}$99\%${{</math>}}-ige Konfidenzintervall und die Effektgröße an.


## Aufgabe 26

Unterscheiden sich Personen, die gerne alleine lernen, in ihrer Extraversion (`extra`) von Personen, die es bevorzugen in Gruppen zu lernen oder ein Mischtyp sind (`lerntyp`)? Schauen Sich sich die Daten graphisch an und führen sie nach Voraussetzungsprüfung einen geeigneten Test durch.


## Aufgabe 27

Haben Studierende, die bei ihren Eltern wohnen (`wohnen`), mit gleicher Wahrscheinlichkeit einen Nebenjob (`job`) wie Studierende, die nicht bei ihren Eltern wohnen?

* Prüfen Sie die Voraussetungen für einen Chi-Quadrat-Test.
* Berechnen Sie die erwarteten Häufigkeiten der Zellen und treffen Sie eine Signifikanzentscheidung.


## Aufgabe 28

Weichen Psychologiestudierende, die einen Nebenjob haben, in ihrem Intellekt (`intel`) von Psychologiestudierenden, die keinen Nebenjob haben, ab.

* Führen Sie nach Voraussetzungsprüfung einen geeigneten Test durch.


## Aufgabe 29

Unterscheiden sich  Nerdiness (`nerd`) und Intellekt (`intel`) von Psychologiestudierenden im Durchschnitt voneinander? Gehen Sie für die Beantwortung davon aus, dass die Skalen gleich genormt sind.

* Stellen sie die Hypothesen auf.
* Begründen Sie weshalb Sie welchen Test benutzen wollen.
* Führen Sie den Test durch und berechnen Sie gegebenfalls eine Effektgröße.


## Aufgabe 30

Hängt die Gewissenhaftigkeit (`gewis`) positiv mit der Anzahl an geschriebenen Wörtern zusammen, die als Begründung (`grund`) für die Wahl des Psychologiestudiums angegeben wurden? Überprüfen Sie die Voraussetzungen für das gewählte Zusammenhangsmaß.

**Tipp:** Mit folgendem Befehl lässt sich die Anzahl an Wörtern einer Eingabe berechnen:



```r
library(stringr) #falls noch nicht installiert: install.packages("stringr")
str_count("Wie viele Wörter hat dieser Satz?", "\\w+")
```

```
## [1] 6
```


## Aufgabe 31

Lässt sich Prokrastination durch Gewissenhaftigkeit (`gewis`) vorhersagen? 
(Falls noch nicht geschehen, berechnen sie den Skalenwert der Prokrastination.)


```r
fb22$prok2_r <- -1 * (fb22$prok2 - 5)
fb22$prok3_r <- -1 * (fb22$prok3 - 5)
fb22$prok5_r <- -1 * (fb22$prok5 - 5)
fb22$prok7_r <- -1 * (fb22$prok7 - 5)
fb22$prok8_r <- -1 * (fb22$prok8 - 5)

fb22$prok_ges <- fb22[, c('prok1', 'prok2_r', 'prok3_r',
                          'prok4', 'prok5_r', 'prok6',
                          'prok7_r', 'prok8_r', 'prok9', 
                          'prok10')] |> rowMeans()
```

* Stellen Sie die Regressionsgerade auf und prüfen sie die Voraussetzungen.
* Prüfen Sie nun mit einem {{<math>}}$99\%${{</math>}}-Konfidenzintervall die Signifikanz der Koeffizienten.
* Wie viel Prozent der Varianz von Prokrastination lassen sich durch die Gewissenhaftigkeit aufklären?
* Eine Person hat einen Gewissenhaftswert von 3.2. Welchen Prokrastinationswert sagt das Modell für diese Person voraus?


## Aufgabe 32

In Aufgabe 29 haben wir herausgefunden, dass sich die Werte von Nerdiness und Intellekt von Psychologiestudierenden unterscheiden. Die gefundene Effektgröße betrug $d=-0.56$. Wir wollen nun eine Poweranalyse durchführen, indem wir die Studie $10^4$ mal wiederholen.
Nutzen Sie den Seed 4321 (`set.seed(4321)`).

* Führen Sie eine Simulation durch, um die empirische Power des t-Tests zu bestimmen.
* Wie hoch ist die Wahrscheinlichkeit eines $\beta$-Fehlers?
* Angenommen wir wollen das $\alpha$-Niveau verändern. Wie würde sich das auf die Power des Tests auswirken? Simulieren sie diesmal den empirischen t-Wert und erstellen Sie einen Powerplot, in dem $\alpha$ = 0.001, $\alpha$ = 0.01, $\alpha$ = 0.025, $\alpha$ = 0.05, $\alpha$ = 0.1 abgetragen sind. 



