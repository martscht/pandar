---
title: "Tag 01" 
type: post
date: '2024-10-09' 
slug: refresher-day1
categories: ["refresheR"] 
tags: ["refresheR"] 
subtitle: ''
summary: '' 
authors: [stephan, gruetzner, vogler] 
weight: 1
lastmod: '2025-02-07'
featured: no
banner:
  image: "/header/syntax.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1172040)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /workshops/refresher/refresher-day1
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /workshops/refresher/refresher-day1.R
  - icon_pack: fas
    icon: pen-to-square
    name: Übungen
    url: /workshops/refresher/refresher-uebungen
output:
  html_document:
    keep_md: true
    
---




  

<details><summary><b>Themen (CLICK ME)</b></summary>

* [Warum R?](#WarumR) Und nicht SPSS, Excel und co. - Vor- und Nachteile
* [R-(Studio)](#installieren) installieren und kennenlernen
* [Datenhandling](#Datenhandling) - Wie gehe ich mit erhobenen Daten um?
* [Einfache Deskriptivstatistik](#Deskriptivstatistik) - Mittelwert, Standardabweichung und co.

</details>

***

## Einleitende Worte

Dieser Beitrag ist im Rahmen des R Workshops für angehende KliPPs Masterstudierende entstanden. Die hier aufgeführten Inhalte sind alles andere als originell und sollten als Zusammenfassung der [Statistik I](/lehre/main/#statistik-i) und [Statistik II](/lehre/main/#statistik-ii) Beiträge verstanden werden. Der Verdienst gehört den Autoren der Beiträge. Wir empfehlen für eine auführlichere Behandlung der Themen in den entsprechenden Beiträgen nachzulesen.

***

## Warum R? {#WarumR}


***

## R(-Studio) installieren und kennenlernen {#installieren}

### Installation

Obwohl die "Basis" R-Software schon zur Nutzung der gleichnamigen Programmiersprache befähigt, verwenden wir aufgrund der höheren Nutzerfreundlichkeit die integrierte Entwicklungsumgebung RStudio. Beide sind kostenlos erhältlich, beispielsweise bei [Posit](https://posit.co/download/rstudio-desktop/) wo Sie eine übersichtliche Anleitung sowie die Downloadlinks erwarten.

**[Hier klicken, um zu Posit zu gelangen](https://posit.co/download/rstudio-desktop/)**

### Aufbau von RStudio

RStudio besteht aus vier Panels. Oben links befindet sich nach Öffnen einer neuen Skriptdatei (Strg+Shift+n (Mac OS: Cmd+Shift+n) oder über den **New File** Button) das Skript. In R dient dieses nur zur Strukturierung der Syntax, in RStudio kann man diese dort mit Strg+Return (Mac OS: cmd+Return) oder dem **Run** Button ausführen.
Das Resultat erscheint dann in der Konsole unten links.
Oben Rechts finden Sie das Environment. Dies sollte zu Beginn dieses Workshops noch leer sein und sich im Laufe des Tages mit Datensätzen und Objekten füllen.
Zuguterletzt befindet sich unten rechts ein Panel mit mehreren Tabs. Unter Files können Sie durch Ordner Datein aufindig machen. Grafische Darstellungen erfolgen im Plots Tab. Unter Packages erhalten Sie eine Übersicht der installierten Erweiterungen für R. Der wohl wichtigste Tab ist der Help Tab. In diesem erhalten Sie Hilfe zu R-Funktionen und Packages. 

### Die Help Page
Der größte Vorteil gegenüber dem Basis R hat Rstudio wahrscheinlich mit der soeben angepriesenen Help-Funktion.

Diese ist zu erreichen durch:

1. `?`funktionsname()

2. `help`(Funktionsname)

3. über die Suchfunktion des Help-Tabs

4. F1 Drücken während der Cursor sich über der Funktion befindet


<button type="button" class="btn btn-info" data-toggle="collapse" data-target="#tabelle">Bestandteile der Help Funktion</button>
<div id="tabelle" class="collapse">
<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Abschnitt </th>
   <th style="text-align:left;"> Inhalt </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Description </td>
   <td style="text-align:left;"> Beschreibung der Funktion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Usage </td>
   <td style="text-align:left;"> Zeigt die Arguente an, die die Funktion entgegennimmt. Argumente auf die ein = folgt haben Standardeinstellungen und müssen nicht jedes mal aufs Neue definiert werden, Argumente ohne = jedoch schon. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Arguments </td>
   <td style="text-align:left;"> Liste der Argumente mit Beschreibung </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Details </td>
   <td style="text-align:left;"> Zusatzinformationen zur Funktion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Values </td>
   <td style="text-align:left;"> Übersicht über die möglichen Ergebnisinhalte der Funktion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> See also </td>
   <td style="text-align:left;"> Ähnliche Funktionen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Examples </td>
   <td style="text-align:left;"> Praxisbeispiel, Funktion wird angewendet </td>
  </tr>
</tbody>
</table>
</div>

### R-Studio Settings und Vorteile gegenüber R

#### Settings

Auch wenn man nun schon sofort mit den eigenen Projekten anfangen könnte, kann es hilfreich sein, die Personalisierungsoptionen, die R bietet, auch zu nutzen.
Hier ein kurzer Überblick nützlicher Einstellungen und wo man diese ändert:

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Einstellung </th>
   <th style="text-align:left;"> Änderung </th>
   <th style="text-align:left;"> Beschreibung </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Font Size </td>
   <td style="text-align:left;"> Tools&gt;Global Options&gt;Appearance&gt;Font Size </td>
   <td style="text-align:left;"> Anpassen der Schriftgröße </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Theme </td>
   <td style="text-align:left;"> Tools&gt;Global Options&gt;Appearance&gt;Theme </td>
   <td style="text-align:left;"> Themes beeinflussen Hintergrund- und Schriftfarbe.Idealerweise sollte ein Theme gewählt werden, welches hilft, den Syntax besser zu überblicken. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Rainbow Parentheses </td>
   <td style="text-align:left;"> Tools&gt;Global Options&gt;Code&gt;Display&gt;Syntax&gt;Use Rainbow Parentheses </td>
   <td style="text-align:left;"> Zusammengehörige Klammern erhalten dieselbe Farbe. Hilft bei der Übersichtlichkeit. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Indentation Guidelines </td>
   <td style="text-align:left;"> Tools&gt;Global Options&gt;Code&gt;Display&gt;General&gt;Indentation Guidelines </td>
   <td style="text-align:left;"> Die eingerückte Fläche wird farbig markiert. Hilft beim Überblick. </td>
  </tr>
</tbody>
</table>

Selbstverständlich gibt es noch etliche weitere Personalisierungsoptionen. Diese sind jedoch zu diesem Zeitpunkt  nicht relevant.

### Objekte, Funktionen, arithmetische und logische Operatoren

#### Vektoren

Vektoren sind eindimensionale Datenstrukturen, in denen Elemente des gleichen Typs zusammengeführt werden. Unterschieden wird zwischen folgenden vier Typen:

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Typ </th>
   <th style="text-align:left;"> Kurzform </th>
   <th style="text-align:left;"> Inhalt </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> logical </td>
   <td style="text-align:left;"> logi </td>
   <td style="text-align:left;"> wahr (TRUE) oder falsch (FALSE) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> num </td>
   <td style="text-align:left;"> Beliebige Zahlen </td>
  </tr>
  <tr>
   <td style="text-align:left;"> character </td>
   <td style="text-align:left;"> char </td>
   <td style="text-align:left;"> Kombinationen aus Zahlen und Buchstaben </td>
  </tr>
  <tr>
   <td style="text-align:left;"> integer </td>
   <td style="text-align:left;"> int </td>
   <td style="text-align:left;"> ganze Zahlen </td>
  </tr>
</tbody>
</table>

##### Beispiel: Flanker Test (Eriksen & Eriksen, 1974) 

Die Nutzung von Vektoren wird im Folgenden am Flanker Test verdeutlicht. Dieser Test prüft die selektive Aufmerksamkeit indem Probanden auf einen Zielreiz in der Mitte einer Reizreihe reagieren, während sie irrelevante, ablenkende Reize (die sogenannten "Flanker") ignorieren.



![](/refresher-day1_files/target-flanker-test-plot-1.png)<!-- -->





##### Ablauf des Flanker Tests:

1. In der Mitte erscheint ein Pfeil (oder Buchstabe) als Zielreiz.

2. Links und rechts davon stehen ablenkende Pfeile, die entweder in dieselbe Richtung (kompatibel) oder in die entgegengesetzte Richtung (inkompatibel) zeigen.

3. Die Aufgabe ist, so schnell wie möglich die Richtung des Zielpfeils anzugeben, ohne sich von den Flanker-Reizen ablenken zu lassen.

4. Ziel: Messung der Reaktionszeit und Genauigkeit

5. Frage: unterscheidet sich die Reaktionsgeschwindigkeit zwischen den Versuchsbedingungen signifikant?




Wir nehmen nun im Folgenden an,
eine Datenreihe gemessen zu haben und diese interpretieren zu wollen.

Zunächst legen wir die Reaktionszeit als numerischen Vektor ab. Hierfür nehmen wir die c()-Funktion:


```r
# Reaktionszeiten als numerischen Vektor
reaction <- c(600, 520, 540, 680, 560, 590, 620, 630) 
```

Wenn wir nun überprüfen wollen, ob der reaction Vektor auch wirklich als numerical Vektor vorliegt, nutzen wir die class() Funktion:

```r
# Vektor Klasse anzeigen
class(reaction) 
```

```
## [1] "numeric"
```

Mit der str()-Funktion können wir uns die Elemente des Vektors ausgeben lassen.

```r
str(reaction) 
```

```
##  num [1:8] 600 520 540 680 560 590 620 630
```

Nun legen wir die Richtung der flankierenden Zeichen fest.

```r
flankers <- c("<","<",">","<",">",">",">","<")
```

Nun testen wir, ob es sich um einen character Vektor handelt:

```r
is.character(flankers) 
```

```
## [1] TRUE
```

Vektoren lassen sich in manchen Fällen auch in andere Arten umwandeln:

```r
reaction_as_char <- as.character(reaction)
reaction_as_char
```

```
## [1] "600" "520" "540" "680" "560" "590" "620" "630"
```


Diese Umwandlung funktioniert. Wir hätten die Reaktionszeiten auch direkt als character Vektor hinterlegen können, indem wir die Werte in Anführungsreichen setzen ("200").

Die Umwandlung vom Character Vektor zu einem Numerical Vektor funktioniert jedoch nicht:

```r
flankers_as_numeric <- as.numeric(flankers) 
```

```
## Warning: NAs durch Umwandlung erzeugt
```


Da der Flanker Test untersucht ob die Aufmerksamkeit beeinflusst wird wenn die zielzeichen von inkongruenten Zeichen umgeben werden, müssen wir nun überprüfen in welcher Bedingung Kongruentz und in welcher Inkongruenz vorherrscht:


```r
#  Zielzeichen erstellen
target <- c(">", ">", ">", "<", "<", "<", ">", ">")
# Vergleich von Vektoren (Kongruenz)

cong <- flankers == target 

cong #logischer Vektor
```

```
## [1] FALSE FALSE  TRUE  TRUE FALSE FALSE  TRUE FALSE
```

Dieser logische Vektor zeigt uns, dass es sich nur in Bedingungen 3,4 und 7 um Kongruente Reize handelt. Auch logical Vektoren lassen sich überprüfen:

```r
is.logical(cong) 
```

```
## [1] TRUE
```

Nun erstellen wir aus dem Flanker Vektor einen Faktor:

```r
flankers_factorial <- as.factor(flankers) 
#  Ausgabe des Factors
str(flankers_factorial) 
```

```
##  Factor w/ 2 levels "<",">": 1 1 2 1 2 2 2 1
```

Nun lassen wir uns noch die Levels ausgeben:

```r
levels(flankers_factorial) 
```

```
## [1] "<" ">"
```

Wenn wir nun möchten, dass ">" den Wert 1 erhält, nutzen wir relevel():

```r
releveled_flankers_factorial <- relevel(flankers_factorial, '>') 
releveled_flankers_factorial 
```

```
## [1] < < > < > > > <
## Levels: > <
```

Im folgenden machen wir aus unserem Faktor einen numerical Vektor. Dies war zuvor mit dem Flankers-Vektor im Character Format nicht mögöich.


```r
numeric_from_flankers <- as.numeric(flankers_factorial) 
numeric_from_flankers 
```

```
## [1] 1 1 2 1 2 2 2 1
```

Nun steht 1 für "<" und 2 für ">".


```r
char_from_flankers <- as.character(flankers_factorial) 
char_from_flankers 
```

```
## [1] "<" "<" ">" "<" ">" ">" ">" "<"
```


Wir können den Faktor jedoch auch wieder in einen Character-Vektor umwandeln.

Zu beachten ist, dass beide Umwandlungen Konsequenzen für weiterführende Operatoren haben.


#### Funktionen

In R gibt man einer Funktion einen Input und erhält einen bestimmten Output zurück. Jede Funktion erledigt hierbei eine bestimmte Aufgabe. Dies hat die Vorteile der Wiederverwendbarkeit, Organisation und Effizienz. Natürlich könnte man den Mittelwert einer Datenmenge manuell berechnen, mit der darauf ausgerichteten Funktion geht es jedoch schneller.


```r
(34+47+23+90+23+45+89+98)/8
```

```
## [1] 56.125
```

```r
mean(c(34,47,23,90,23,45,89,98))
```

```
## [1] 56.125
```

In R wird zunächst die Funktion genannt und darauffolgend die Argumente. An diesem Beispiel lässt sich bereits die generelle Struktur von Funktionen in R erkennen:


```r
# funktion(argument1, argument2, argument3, ...)
```

#### Zusammenfassung Umgang mit Funktionen

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Beschreibung </th>
   <th style="text-align:left;"> Code.Stil </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Funktionen schachteln </td>
   <td style="text-align:left;"> funktion1(funktion2(argument)) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Objekt im Environment anlegen </td>
   <td style="text-align:left;"> objekt &lt;- funktion1(argument) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ergebnis-Pipe </td>
   <td style="text-align:left;"> funktion1(argument) |&gt; funktion2() </td>
  </tr>
</tbody>
</table>

#### Objekte

In R können Ergebnisse in Objekte angelegt werden und diese wiederum in Funktionen als Argument eingesetzt werden.
Der Zuweisungspfeil (Windows: Alt + -) (Mac OS: Option + -) weist dem Objekt ein Ergebnis zu.


```r
Mittelwert <- mean(c(34,47,23,90,23,45,89,98))
Mittelwert # oder auch: print(Mittelwert)
```

```
## [1] 56.125
```

Hierbei gibt die Konsole das Objekt erst aus, wenn ich dieses noch einmal benenne oder es als Argument in die `print()`-Funktion einsetze. Bei der Bennenung des Objektes gilt es zu beachten, dass das erste Zeichen keine Zahl sein darf und gleichnamige Objekte überschrieben werden.



Objekte glänzen erst wirklich sobald sie in anderen Funktionen eingesetzt werden:


```r
x <- c(100, 20, 24, 89, 40)
mean(x) == Mittelwert  # prüft, ob der Mittelwert von x gleich dem Objekte "Mittelwert" ist
```

Eine Alternative ist die **Pipe**. Hierbei wird das Ergebnis nicht als Objekt abgelegt, sondern direkt an eine Funktion weitergegeben.:


```r
# Beispiel mit Verschachtelung
var(c(89,48,38,29,39,49,54))

# Beispiel Pipe
c(89,48,38,29,39,49,54) |> var()
```

Der Vorteil hiebei ist, dass wir das ganze wieder von links nach rechts lesen können. Auch hier gibt es Möglichkeiten zur Verschachtelung:


```r
# Berechnung der Standardabweichung aus Varianz heraus
c(89, 48, 38, 29, 39, 49, 54) |> var() |> sqrt()
```

#### Environment

Im Environment finden sich Objekte wieder. Diese lassen sich jedoch auch mit ls() ausgeben:


```r
ls()
```

```
##  [1] "char_from_flankers"          
##  [2] "cong"                        
##  [3] "data"                        
##  [4] "data2"                       
##  [5] "data3"                       
##  [6] "data4"                       
##  [7] "figure_path"                 
##  [8] "flankers"                    
##  [9] "flankers_as_numeric"         
## [10] "flankers_factorial"          
## [11] "Mittelwert"                  
## [12] "numeric_from_flankers"       
## [13] "plot1"                       
## [14] "plot2"                       
## [15] "plot3"                       
## [16] "reaction"                    
## [17] "reaction_as_char"            
## [18] "releveled_flankers_factorial"
## [19] "stimulus1"                   
## [20] "stimulus2"                   
## [21] "stimulus3"                   
## [22] "target"                      
## [23] "x"
```

Entfernen können wir Objekte mit rm(). Dies geschieht jedoch ohne Warnung und ist final.


```r
rm(Mittelwert)
ls()             # Environment ohne Mittelwert erscheint.
```

```
##  [1] "char_from_flankers"          
##  [2] "cong"                        
##  [3] "data"                        
##  [4] "data2"                       
##  [5] "data3"                       
##  [6] "data4"                       
##  [7] "figure_path"                 
##  [8] "flankers"                    
##  [9] "flankers_as_numeric"         
## [10] "flankers_factorial"          
## [11] "numeric_from_flankers"       
## [12] "plot1"                       
## [13] "plot2"                       
## [14] "plot3"                       
## [15] "reaction"                    
## [16] "reaction_as_char"            
## [17] "releveled_flankers_factorial"
## [18] "stimulus1"                   
## [19] "stimulus2"                   
## [20] "stimulus3"                   
## [21] "target"                      
## [22] "x"
```

```r
rm(list = ls())  # Enviroment vollständig leeren
ls()
```

```
## character(0)
```


Vor dem Schließen der Software fragt R-Studio häufig, ob man das Environment speichern will.


Dagegen spricht:

1. Übersichtlichkeit: es ist angenehmer mit einer leeren Umgebung zu beginnen.

2. Man prüft direkt ob die Ergebnisse auch für andere reproduzierbar sind. Alles Nötige sollte im Skript passieren.


#### Arithmetische und Logische Operatoren

Die Operatoren, die Sie bereits aus der Mathematik kennen, funktionieren so auch in RStudio als Arithmetische Operatoren:


```r
# Addition
1 + 2
```

```
## [1] 3
```

```r
# Subtraktion
1 - 2
```

```
## [1] -1
```

```r
# Multiplikation
1 * 2
```

```
## [1] 2
```

```r
# Division
(1 + 4) / (2 + 8)
```

```
## [1] 0.5
```

```r
# Potenz
2 ^ 3
```

```
## [1] 8
```

Bis hierhin waren das alles Beispiele die auch jeder gewöhliche Taschenrechner ausführen könnte. RStudio beherrscht jedoch auch logische Abfragen, deren Ergebnisse **boolesch** - also entweder wahr(TRUE) oder falsch(FALSE)- sind. Wie in vielen anderen Programmiersprachen nutzt man das ! zum negieren.


```r
# Logische Abfragen
1 == 2 # Ist gleich
```

```
## [1] FALSE
```

```r
1 != 2 # Ist ungleich
```

```
## [1] TRUE
```

```r
1 < 2 # Ist kleiner als
```

```
## [1] TRUE
```

```r
1 > 2 # Ist größer als
```

```
## [1] FALSE
```

```r
1 <= 2 # Ist kleiner/gleich
```

```
## [1] TRUE
```

```r
1 >= 2 # Ist größer/gleich
```

```
## [1] FALSE
```

```r
!(1 == 2) # Ist Klammerinhalt NICHT gleich?
```

```
## [1] TRUE
```

Das ist jetzt zugegebenermaßen noch nicht sonderlich beeindruckend. Etwas später werden wir jedoch lernen, das dies auch auf Daten und nicht nur einzelne Elemente angewendet werden kann.


#### Warnings- vs. Error-Messages 

RStudio gibt drei Arten von Rückmeldungen: Messages, Warnings und Errors


1.**Messages**: Messages dienen grundsätzlich zur Kommunikation und liefern bspw. Informationen bezüglich des Zustandes einer Funktion.

2.**Warning**:Sie erhalten zwar ein Ergebnis, es könnte jedoch etwas schiefgelaufen sein.

Beispiel:

```r
log(-1)
```

```
## Warning in log(-1): NaNs wurden erzeugt
```

```
## [1] NaN
```
Hier erhalten wir die Warnung, dass NaN (Not a Number) als Ergebnis produziert, da der Logarithmus von -1 nicht im Bereich der reellen Zahlen liegt.

3.**Errors**: Errors entstehen, wenn kein Ergebnis produziert wird. Dies geschieht meist wenn wir der Funktion nicht die richtigen Argumente geben.

Beispiel:

```r
x <- numeric(0)  # Ein leerer Vektor für x
y <- numeric(0)  # Ein leerer Vektor für y

lm(y ~ x)  # Versucht eine lineare Regression durchzuführen
```

```
## Error in lm.fit(x, y, offset = offset, singular.ok = singular.ok, ...): alle Fälle NA
```

Der Fehler "alle Fälle NA" bedeutet, dass R keine gültigen Daten hat – unsere Vektoren sind leer, also kann keine Regression durchgeführt werden.

#### Datentypen  

Nun haben wir bereits einen Datentypen, den Vektor, kennengelernt. Diese lassen sich auch zusammenführen, je nach Relation zueinander.

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Typ </th>
   <th style="text-align:left;"> Dimensionen </th>
   <th style="text-align:left;"> Zusammensetzung </th>
   <th style="text-align:left;"> Anmerkungen </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Matrix </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> Vektoren des gleichen Typs </td>
   <td style="text-align:left;"> Bietet sich v.a. für große Datensätze an. Ist eine Sonderform des Arrays. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Array </td>
   <td style="text-align:left;"> n </td>
   <td style="text-align:left;"> Vektoren des gleichen Typs </td>
   <td style="text-align:left;"> - </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Data.Frame </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> Vektoren der gleichen Länge </td>
   <td style="text-align:left;"> Häufigst genutzte Variante in der Psychologie. Ist eine Sonderform der List </td>
  </tr>
  <tr>
   <td style="text-align:left;"> List </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> Beliebige Objekte </td>
   <td style="text-align:left;"> - </td>
  </tr>
</tbody>
</table>

##### Erstellen einer Matrix


```r
# Erstellen von 2 Vektoren des gleichen Typs
age1 <- c(30,71,33,28,19)
age2 <- c(98,4,67,43,21)
matrix1 <- cbind(age1, age2)
matrix2 <- rbind(age1, age2)
matrix3 <- matrix(data= c(age1, age2), ncol=2, byrow=TRUE)

matrix1 # die Vektoren werden als columns angeordnet
```

```
##      age1 age2
## [1,]   30   98
## [2,]   71    4
## [3,]   33   67
## [4,]   28   43
## [5,]   19   21
```

```r
matrix2 # die Vektoren werden als rows angeordnet
```

```
##      [,1] [,2] [,3] [,4] [,5]
## age1   30   71   33   28   19
## age2   98    4   67   43   21
```

```r
matrix3 # design wird durch Argumente ncol, nrow und byrow im Matrix-Befehl bestimmt
```

```
##      [,1] [,2]
## [1,]   30   71
## [2,]   33   28
## [3,]   19   98
## [4,]    4   67
## [5,]   43   21
```
Da für eine Matrix alle Vektoren den gleichen Typ haben müssen, gleicht cbind sie in den allgemeinsten Fall an.



```r
job <- c("Pfegefachkraft", "Elektroniker","Grundschullehrer","Rettungssanitäter","Redakteur")
burnout <- c(TRUE,FALSE,FALSE,FALSE,TRUE)

matrix4 <- cbind(age1,job,burnout)

# Alle 3 Vektoren nun char, also keine mathematischen Berechnungen nun mehr möglich
matrix4
```

```
##      age1 job                 burnout
## [1,] "30" "Pfegefachkraft"    "TRUE" 
## [2,] "71" "Elektroniker"      "FALSE"
## [3,] "33" "Grundschullehrer"  "FALSE"
## [4,] "28" "Rettungssanitäter" "FALSE"
## [5,] "19" "Redakteur"         "TRUE"
```


Da wir nun die Möglichkeit verloren haben num1 als numerischen Vektor zu nutzen, erstellen wir nun aus den selben Vektoren einen `data.frame`. In diesen bleiben die Vektoren Typen erhalten.

```r
df1 <- data.frame(age1,job,burnout)
df1
```

```
##   age1               job burnout
## 1   30    Pfegefachkraft    TRUE
## 2   71      Elektroniker   FALSE
## 3   33  Grundschullehrer   FALSE
## 4   28 Rettungssanitäter   FALSE
## 5   19         Redakteur    TRUE
```

```r
##Listet Variablen und Typ auf
str(df1)
```

```
## 'data.frame':	5 obs. of  3 variables:
##  $ age1   : num  30 71 33 28 19
##  $ job    : chr  "Pfegefachkraft" "Elektroniker" "Grundschullehrer" "Rettungssanitäter" ...
##  $ burnout: logi  TRUE FALSE FALSE FALSE TRUE
```


#### Indizieren

Indizieren bedeutet, dass wir zwar auf bestimmte Elemente eines Objekts zugreifen, ohne diese aus dem Objekt zu entfernen. Das Objekt bleibt weiterhin so bestehen, jedoch kann es manipuliert werden z.B. indem wir Werte ersetzen, Zeilen/Spalten ansprechen oder nach Bedingungen filtern.
Hierfür nutzen wir eckige Klammern (Windows: Str+Alt+8) (Mac OS: Option+5). Dies geschieht nach dem Muster: daten[rows,columns]



```r
# Zugriff auf den 4. Eintrag der Spalte age1
df1[4, 'age1'] 
```

```
## [1] 28
```

```r
# Der vierte Eintrag der Spalte 'age1' auf 20 setzen (verändert Ursprungsdateb)
df1[4, 'age1'] <- 20 

# Ganze Spalte 'age1' anzeigen, um die Änderung zu sehen
df1[,'age1'] 
```

```
## [1] 30 71 33 20 19
```

```r
# Erstellen einer neuen Spalte 'no_burnout', die das Gegenteil der Spalte 'burnout' darstellt - über die Sinnhaftigkeit machen wir uns hier mal lieber keine Gedanken
df1$no_burnout <- !df1$burnout


# Hinzufügen einer sechsten Zeile (Änderung am Datensatz)
df1[6,] <- data.frame(
  age1 = 42, 
  job = "Friseur", 
  burnout = TRUE, 
  no_burnout = TRUE)

# Entfernen dieser eben geschaffenen sechsten Zeile
df1 <- df1[-6,]
# Zugriff auf die 5. Zeile und die 4. Spalte (ohne Extraktion)
df1[5, 4]
```

```
## [1] FALSE
```

```r
# Zugriff auf die gesamte 1. Zeile
df1[1, ]
```

```
##   age1            job burnout no_burnout
## 1   30 Pfegefachkraft    TRUE      FALSE
```

```r
# Zugriff auf die 1. Spalte
df1[, 1]
```

```
## [1] 30 71 33 20 19
```

```r
# Zugriff auf die 2. und 3. Zeile, 3. Spalte
df1[c(2, 3), 3]
```

```
## [1] FALSE FALSE
```

```r
# Zugriff auf alle Zeilen, in denen 'burnout' TRUE ist
df1[df1$burnout, ]
```

```
##   age1            job burnout no_burnout
## 1   30 Pfegefachkraft    TRUE      FALSE
## 5   19      Redakteur    TRUE      FALSE
```

#### Datenextraktion 

In Anderen Fällen extrahiert (entnimmt) man die Daten aus dem Objekt, um sie in einem seperaten Objekt zu speichern. Dies ist hilfreich, wenn wir die entnommenen Daten analysieren wollen, ohne das Ursprungsobjekt zu verändern.

Dies exerzieren wir nun erstmal an der zuvor erstellten Variable age1 durch.


```r
# age1 ausgeben lassen
str(age1)
```

```
##  num [1:5] 30 71 33 28 19
```

Wir wissen nun, dass age1 ein numerischer Vektor mit 5 Elementen ist. Wir lassen uns nun das 5. Element ausgeben.

```r
# das 5.Element von age1 ausgeben lassen- jedoch nicht verändern
age1[5]
```

```
## [1] 19
```

Wir können uns die Variable jedoch auch ohne das 5. Element ausgeben lassen:

```r
# age1 ohne Element 5 ausgeben lassen
age1[-5]
```

```
## [1] 30 71 33 28
```



Wir können uns auch eine Auswahl an Elementen ausgeben lassen. Dies gelingt indem wir einem Objekt einen numerischen Vektor zuweisen und dieses Objekt dann in den eckigen Klammern nutzen.


```r
# sich eine Auswahl ausgeben lassen
auswahl <- c(1, 3, 5)
age1[auswahl]
```

```
## [1] 30 33 19
```

```r
# Auswahl in neuem Objekt abspeichern
age_select<-age1[auswahl]
```



Das funktioniert natürlich auch geschachtelt.


```r
# verschachtelt eine Auswahl ausgeben lassen
age1[c(1, 3, 5)]
```

```
## [1] 30 33 19
```



Wir können auch abrufen, welche Elemente eines character vektors TRUE oder FALSE sind.


```r
!(df1$burnout)
```

```
## [1] FALSE  TRUE  TRUE  TRUE FALSE
```

```r
# Abrufen der Job-Bezeichnungen für die Personen, die einen Burnout haben (TRUE)
df1$job[df1$burnout]
```

```
## [1] "Pfegefachkraft" "Redakteur"
```

```r
# Abrufen der Job-Bezeichnungen für Personen ohne Burnout (FALSE)
df1$job[!df1$burnout]
```

```
## [1] "Elektroniker"      "Grundschullehrer" 
## [3] "Rettungssanitäter"
```

```r
# Auch dies kann wieder in Objekte abgelegt werden
job_nburn <- df1$job[!df1$burnout]
```



```r
# 5. Zeile, 4. Spalte ausgeben lassen
df1[5, 4]
```

```
## [1] FALSE
```


```r
df1[1, ]          # 1. Zeile, alle Spalten
```

```
##   age1            job burnout no_burnout
## 1   30 Pfegefachkraft    TRUE      FALSE
```

```r
df1[, 1]          # Alle Zeilen, 1. Spalte
```

```
## [1] 30 71 33 20 19
```

```r
df1[c(2, 3), 3]   # 2. und 3. Zeile, 3. Spalte
```

```
## [1] FALSE FALSE
```

```r
df1[burnout, ]    # Alle kongruenten Zeilen, alle Spalten
```

```
##   age1            job burnout no_burnout
## 1   30 Pfegefachkraft    TRUE      FALSE
## 5   19      Redakteur    TRUE      FALSE
```


```r
nrow(df1)    # Anzahl der Zeilen
```

```
## [1] 5
```

```r
ncol(df1)    # Anzahl der Spalten
```

```
## [1] 4
```

```r
dim(df1)     # Alle Dimensionen
```

```
## [1] 5 4
```


```r
names(df1)   # Namen der Variablen
```

```
## [1] "age1"       "job"        "burnout"    "no_burnout"
```


```r
df1[, 'age1']                # Einzelne Variable auswählen
```

```
## [1] 30 71 33 20 19
```

```r
df1[, c('age1', 'burnout')]  # Mehrere Variable auswählen
```

```
##   age1 burnout
## 1   30    TRUE
## 2   71   FALSE
## 3   33   FALSE
## 4   20   FALSE
## 5   19    TRUE
```

```r
df1$age1                     # eine Variable indizieren
```

```
## [1] 30 71 33 20 19
```


#### Daten Import und Export 

Ähnlich wie wenn man ein word Dokument speichert und in seinem eigenen Dateispeicher einen geeigneten Ort zum speichern suchen muss, benötigt auch R eine Angabe dazu, wo Daten und Syntax hinterlegt werden soll. Dieser Ort kann R als working Directory mitgeteilt werden. Um das aktuelle Working Directory zu erhalten, kann man die Funktion `getwd()` nutzen.



```r
getwd()
```

```
## [1] "C:/Users/kevpo/OneDrive/Desktop/Pandar/NewPanda/content/workshops/refresher"
```

Der hat wahrscheinlich das Format C:/Users/Name/Documents. Um manuell einen anderen Ordner zu nutzen, kann dieser mit `setwd()` festgelegt werden:


```r
# setwd('Pfad/Zum/Ordner')
```

Der Inhalt eines Ordners lässt sich mit `dir()` ausgeben.


```r
dir()
```

R hat zwei eigene Datenformate mit denen Dateien abgespeichert werden können: RDA und RDS.

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Dateiformat </th>
   <th style="text-align:left;"> Dateiendung </th>
   <th style="text-align:left;"> Speichern </th>
   <th style="text-align:left;"> Laden </th>
   <th style="text-align:left;"> Einsatzort </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> RDA </td>
   <td style="text-align:left;"> .rda </td>
   <td style="text-align:left;"> save() </td>
   <td style="text-align:left;"> load() </td>
   <td style="text-align:left;"> gemeinsames Speichern mehrerer Objekte </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RDS </td>
   <td style="text-align:left;"> .rds </td>
   <td style="text-align:left;"> saveRDS() </td>
   <td style="text-align:left;"> readRDS() </td>
   <td style="text-align:left;"> Speichern einzelner Objekte (z.B. Datensätze) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Klartextformate </td>
   <td style="text-align:left;"> .txt oder .dat </td>
   <td style="text-align:left;"> write.table() </td>
   <td style="text-align:left;"> read.table() </td>
   <td style="text-align:left;"> Textbasierte Speicherung und Laden </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CSV </td>
   <td style="text-align:left;"> .csv </td>
   <td style="text-align:left;"> write.csv() </td>
   <td style="text-align:left;"> read.csv() </td>
   <td style="text-align:left;"> Tabellendaten im CSV-Format </td>
  </tr>
</tbody>
</table>


Dies probieren wir nun mit unserem df1 Datensatz:


```r
save(df1, file = 'df1.rda')
```

Um zu testen, ob wir ihn auch wieder abrufen können, leeren wir nun erstmal das Environment:


```r
rm(list = ls())
ls()
```

```
## character(0)
```

Wenn wir jetzt den Datensatz laden, wird er mit seiner Originalbenennung (df1) wiederhergestellt:


```r
load('df1.rda')
ls()
```

```
## [1] "df1"
```

Jetzt durchlaufen wir die gleichen Schritte noch einmal mit dem RDS Format:


```r
saveRDS(df1, 'df1.rds')
rm(list = ls())
ls()
```

```
## character(0)
```

Beim Laden des Datensatzes können wir diesen jetzt einem beliebigen Objekt zuweisen:


```r
work <- readRDS('df1.rds')
work
```

```
##   age1               job burnout no_burnout
## 1   30    Pfegefachkraft    TRUE      FALSE
## 2   71      Elektroniker   FALSE       TRUE
## 3   33  Grundschullehrer   FALSE       TRUE
## 4   20 Rettungssanitäter   FALSE       TRUE
## 5   19         Redakteur    TRUE      FALSE
```

Für eine erste Dateninspektion eignen sich die folgenden Funktionen:


```r
nrow(work)    # Anzahl der Zeilen
```

```
## [1] 5
```

```r
ncol(work)    # Anzahl der Spalten
```

```
## [1] 4
```

```r
dim(work)     # Alle Dimensionen
```

```
## [1] 5 4
```

```r
names(work)   # Namen der Variablen
```

```
## [1] "age1"       "job"        "burnout"    "no_burnout"
```

##### CSV Datensatz einlesen


```r
osf <- read.csv(file = url("https://osf.io/zc8ut/download"))

# riesiger Datensatz, wir wollen nur 6 Variablen
osf <- osf[, c("ID", "group", "stratum", "bsi_post", "swls_post", "pas_post")]
```

***

## Datenhandling {#Datenhandling}

### Faktoren erstellen 

In einem früheren Abschnitt erstellten wir aus einem Vektor einen Factor. Dies funktioniert auch mit Variablen aus Datensätzen.

Für unser Beispiel laden wir den Datensatz "Bildungsinvestitionen auf der Welt (edu_exp)". Dieser beinhaltet öffentlich zugängliche Daten, die von [Gapminder](hhttps://www.gapminder.org) zusammengetragen wurden.




```r
# Datensatz laden
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

Betrachten wir die Variable `Year`.


```r
str(edu_exp$Year)
```

```
##  int [1:4316] 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 ...
```

Wir sehen, dass die Variable noch als integer (wie numerical aber ganzzahlig) hinterlegt ist. Wenn wir uns aber die Jahrzehnte kategorial und nicht stetig wie die Jahreszahlen betrachten wollen, müssen wir einen Faktor erstellen. Das Erstellen von Faktoren ist eine Vorraussetzung für einige statistische Analysen, aber auch eine sinnvolle Visualisierung.


```r
# Verwende cut() um die Jahre in Kategorien einzuteilen
edu_exp$Decade <- cut(edu_exp$Year, 
                      breaks = c(1990, 2000, 2010, 2020), 
                      labels = c("90s", "2000s", "2010s"),
                      right = FALSE)

str(edu_exp$Decade)
```

```
##  Factor w/ 3 levels "90s","2000s",..: 1 1 1 2 2 2 2 2 2 2 ...
```

Allerdings kommt es eher selten vor, dass kontinuierliche Variablen willkürlich in Kategorien unterteilt werden müssen. Deswegen folgt nun ein Beispiel, in dem schon Kategorien vorliegen.


```r
data$variable <- factor(data$variable, 
                        levels = c("Level1", "Level2", "Level3"), 
                        labels = c("Label1", "Label2", "Label3"))
```

### NAs rausschmeißen 

#### Weswegen treten NA'S auf?
- Fragen überlesen / nicht gesehen
- Antwort verweigert
- Unzulässige Angaben gemacht (im Papierformat)
- Unleserliche Schrift (im Papierformat)

#### Weshalb sind sie problematisch?

Für statistische Analysen sind fehlende Werte ein Problem, weil sie außerhalb der zulässigen Antworten liegen.

```r
# gibt NA zurück
mean(edu_exp$Primary)
```

```
## [1] NA
```

Dies ist verständlicherweise nicht zielführend für unsere Analysen. In R kann man NA's auf zwei Ebenen angehen:

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Ebene </th>
   <th style="text-align:left;"> Funktion </th>
   <th style="text-align:left;"> Beschreibung </th>
   <th style="text-align:left;"> Beispiel </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> global(Datensatz) </td>
   <td style="text-align:left;"> na.omit </td>
   <td style="text-align:left;"> Entfernt jede Beobachtung, die mind. ein NA enthält. </td>
   <td style="text-align:left;"> Jeder Proband, der mind. eine Frage nicht beantwortet, wird ausgeschlossen. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lokal(Variable) </td>
   <td style="text-align:left;"> na.rm = TRUE </td>
   <td style="text-align:left;"> Das Argument na.rm ist in vielen Funktionen für univariate Statistiken enthalten. Per Voreinstellung wird NA als Ergebnis produziert, wenn fehlende Werte vorliegen. Fehlende Werte werden nur für diese eine Analyse ausgeschlossen, wenn sie auf der darin untersuchten Variable keinen Wert haben - Datensatz bleibt erhalten. </td>
   <td style="text-align:left;"> Beispiel: Ein Proband hat zwar sein Alter nicht angegeben, wird aber dennoch bei der Korrelation zwischen Region und Expectancy mit einbezogen. </td>
  </tr>
</tbody>
</table>

Bevor wir uns für eine Methode entscheiden, müssen wir aber erstmal versuchen, ob unser Datensatz NA's hat und wenn ja, auf welchen Variablen:


```r
# Unterschiedliche Möglichkeiten NA's abzufragen
is.na(edu_exp)          # gibt TRUE/FALSE für jede einzelne Zelle aus
anyNA(edu_exp)          # gibt es mindestens ein NA?
sum(is.na(edu_exp))     # wieviele NA's gibt es insgesamt im Datensatz?
complete.cases(edu_exp) # Welche Zeilen sind vollständig?
```


```r
# Zeigt die Anzahl fehlender Werte pro Spalte an
colSums(is.na(edu_exp))
```

```
##        geo    Country     Wealth     Region       Year 
##          0          0          0          0          0 
## Population Expectancy     Income    Primary  Secondary 
##          0       1120        174       2753       2907 
##   Tertiary      Index     Decade 
##       2905        288          0
```

Wir erfahren, dass die Variablen `Expectancy`, `Income`, `Primary`, `Secondary`, `Tertiary` und `Index` NA's enthalten. Wenn wir dem Global Approach folgen wollen, dann können wir mit `na.omit()` ein neues Objekt mit dem bereinigten Datensatz erschaffen.


```r
# Entfernt alle Zeilen, die NAs enthalten
edu_exp_clean1 <- na.omit(edu_exp)
dim(edu_exp_clean1)
```

```
## [1] 811  13
```

Wir können aber auch nur die Einträge löschen, die auf einer bestimmten Variable (nämlich die, die wir untersuchen wollen) löscht.


```r
# Nur Zeilen mit fehlenden Werten in einer bestimmten Spalte entfernen:
edu_exp_clean2 <- edu_exp[!is.na(edu_exp$Expectancy), ]
str(edu_exp_clean2) # behält mehr observations bei
```

```
## 'data.frame':	3196 obs. of  13 variables:
##  $ geo       : chr  "afg" "afg" "afg" "afg" ...
##  $ Country   : chr  "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
##  $ Wealth    : chr  "low_income" "low_income" "low_income" "low_income" ...
##  $ Region    : chr  "asia" "asia" "asia" "asia" ...
##  $ Year      : int  1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 ...
##  $ Population: int  17788819 18493132 19262847 19542982 19688632 21000256 22645130 23553551 24411191 25442944 ...
##  $ Expectancy: num  50.7 50 50.8 51 51.1 51.6 52.1 52.5 52.9 53.2 ...
##  $ Income    : num  NA NA NA NA NA ...
##  $ Primary   : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ Secondary : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ Tertiary  : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ Index     : num  0.18 0.19 0.2 0.2 0.21 0.22 0.23 0.26 0.27 0.28 ...
##  $ Decade    : Factor w/ 3 levels "90s","2000s",..: 1 1 1 2 2 2 2 2 2 2 ...
```


### Subsets erstellen

Anstatt den ganzen Datensatz zu betrachten, ist es oft sinnig Subsets zu erstellen, die mit logischen oder artithmetischen Operatoren eine Teilstichprobe abspalten.


```r
# Subset von Pbn aus Ländern mit mehr als 10 Mio einwohnern
edu_exp_subset <- edu_exp[edu_exp$Population > 10000000, ]

# Ergebnis anzeigen
edu_exp_subset

# mehr als 10 mio UND EUROPA
edu_exp_subset2 <- edu_exp[edu_exp$Population > 10000000 & edu_exp$Region == "europe", ]
edu_exp_subset2
```

### Pakete

Packages sind Sammlungen von Funktionrn, Datensätzen und Dokumentationen, die man zusätzlich zu denen in der System Library herunterladen kann. Jedes Paket wurde hierbei für bestimmte Aufgaben entwickelt. Das hat zum Einen den Vorteil, dass man nur die packages herunterladen muss, die man auch wirklich benötigt, und zum Anderen, muss nicht immer das gesamte R geändert werden sobald sich ein package aktualisiert.

Der tab mit den packages befindet sich in dem Panel unten rechts zwischen "plots" und "help". Hier wird ersichtlich, dass es neben der System Library mit den vorinstallierten Paketen noch die User Library mit den manuell hinzugefügten packages gibt.

Zwar finden wir im Tab oben links den "Install"-Button, der ein weiteres Fenster zum Installieren der packages öffnet, jedoch ist es ratsam, die Installation der packages im Skript durchzuführen. Somit bleibt das Skript für jeden der es erhält ausführbar, unabhängig von der eigenen User Library.

Für das Herunterladen und Abrufen der Packages nutzen wir install.packages() und library().


```r
install.packages("psych")
library(psych)
```
Das hier zu demonstrationszwecken verwendete psych-package wurde speziell für psychologische Analysen entwickelt. Im Verlaufe des Seminars werden Sie jedoch noch weitere packages kennenlernen.


***

## Einfache Deskriptivstatistik {#Deskriptivstatistik}

### Übersicht

Skala | Aussage | Transformation | Zentrale Lage | Dispersion |
--- | ------------ | -------- | ---------- | ----------------- |
Nominal | Äquivalenz | eineindeutig | [Modus](#Modus) | Relativer Informationsgehalt |
Ordinal | Ordnung | monoton | [Median](#Median) | [Interquartilsbereich](#IQB) |
Intervall | Verhältnis von Differenzen | positiv linear | [Mittelwert](#Mean) | [Varianz](#Var), Standardabweichung |
Verhältnis | Verhältnisse | Ähnlichkeit | ... | ... |
Absolut | absoluter Wert | Identität | ... | ... |


### Nominal- und Ordinalskalierte Daten

#### Häufigkeitstabellen

Eine deskriptivstatistische Möglichkeit zur Darstellung diskreter (zählbarer) nominalskalierter Variablen sind Häufigkeitstabellen. Diese können in `R` mit der Funktion `table()` angefordert werden.

**Absolute Häufigkeiten**

```r
table(edu_exp$Wealth)
```

```
## 
##                             high_income          low_income 
##                   4                1320                 682 
## lower_middle_income upper_middle_income 
##                1034                1276
```

**Relative Häufigkeiten**

Relative Häufigkeiten können aus absoluten Häufigkeiten abgeleitet werden:

$h_j = \frac{n_j}{n}$

In R können wir das mit Hilfe der `prop.table()`-Funktion bewerkstelligen:


```r
table(edu_exp$Wealth) |> prop.table()
```

```
## 
##                             high_income          low_income 
##        0.0009267841        0.3058387396        0.1580166821 
## lower_middle_income upper_middle_income 
##        0.2395736793        0.2956441149
```

#### Modus {#Modus}

Den Modus, also die Ausprägung einer Variable die am häufigsten vorkommt können wir dann direkt aus einer solchen Häufigkeitstabelle ablesen


```r
table(edu_exp$Wealth)
```

```
## 
##                             high_income          low_income 
##                   4                1320                 682 
## lower_middle_income upper_middle_income 
##                1034                1276
```

oder mit Hilfe einer weiteren Funktion direkt ausgeben lassen


```r
table(edu_exp$Wealth) |> which.max()
```

```
## high_income 
##           2
```

Der Modus der Variable `Wealth` lautet high_income, die Ausprägung trat 1320-mal auf.

#### Relativer Informationsgehalt

Da es keine einfache Funktion in R für die Berechnung des relativen Informationsgehalts gibt verweisen wir sie auf das [entsprechende Kapitel](/lehre/statistik-i/deskriptiv-nominal-ordinal/) auf pandaR. Dort wird die manuelle Berechnung anhand der Formel mit `R` als Taschenrechner gezeigt.

#### Median {#Median}

Der Median lässt sich mit Hilfe der gleichnamigen Funktion (`median()`) in R ganz einfach berechnen. Zunächst reduzieren wir unseren Datensatz auf ein bestimmtes Jahr.


```r
edu_2003 <- subset(edu_exp, subset = Year == 2003)

median(edu_2003$Population)
```

```
## [1] 6766669
```

Die median Population aller im Datensatz erfassten Länder betrug im Jahr 2003 6.766.669.

#### Interquartilsbereich {#IQB}

Bei ordinalskalierten Daten wird häufig der Interquartilsbereich (IQB) als Dispersionsmaß gewählt. IQB ist der Bereich zwischen dem 1. und 3. Quartil.

Um die Quartile oder jedes beliebige andere Quantil einer Verteilung zu erhalten, kann die Funktion `quantile()` verwendet werden. Beispielsweise können wir die Grenzen des IQB und den Median mit folgender Eingabe gleichzeitig abfragen.


```r
quantile(edu_2003$Population,
         c(0.25, 0.5, 0.75))
```

```
##      25%      50%      75% 
##  1519292  6766669 21367466
```

Der IQB liegt also zwischen 1.519.292 und 21.367.466.

Aufmerksamen Lesern könnte schon aufgefallen sein das es sich bei der Variable `Population` nicht um eine ordinalskalierte Variable handelt sondern um eine mindestens intervallskalierte, ja gar absolutskaliert Variable. Für die Berechnugn des Medians und IQBs stellt dies jedoch kein Problem dar, da Maße der zentralen Tendenz und Dispersionsmaße von niedrigeren Skalenniveaus auch bei höheren angwendet werden können. Es werden dann halt nicht alle Informationen vollends genutzt.


### Intervallskalierte Daten

#### Mittelwert {#Mean}

Auch die Berechnung des Mittelwerts ist in R mit Hilfe einer Funktion möglich. Diese heißt wie man vielleicht erwarten könnte `mean()`.


```r
mean(edu_2003$Population)
```

```
## [1] 32569642
```

#### Varianz {#Var}

Auch für die Varianz und Standardabweichung haben wir zwei intuitive Funktionen, `var()`und `sd()`.


```r
var(edu_2003$Population)
```

```
## [1] 1.578144e+16
```

```r
sd(edu_2003$Population)
```

```
## [1] 125624202
```

An dieser Stelle sollte erwähnt werden R berechnet die geschätzte Varianz/Standardabweichung, mehr dazu können sie im entsprechenden Statistik I [Beitrag](/lehre/statistik-i/deskriptiv-intervall/) nachlesen.

***
