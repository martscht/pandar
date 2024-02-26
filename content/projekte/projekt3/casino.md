---
title: Casino
type: post
date: '2019-12-14T23:00:00'
slug: casino
categories: []
tags: ["Projekt3"]
subtitle: ''
summary: 'In diesem Projekt versuchen wir, uns den Weg ins Casino zu ersparen, indem wir selbst ein vollständiges Roulette in R programmieren. Das heißt, dass wir uns mit Zufallsziehungen, Schleifen und Funktionen auseinandersetzen müssen. Aber Vorsicht, Glücksspiel kann süchtig machen!'
authors: [mehler, rouchi]
weight: 1
lastmod: '2024-02-19'
featured: no
banner:
  image: "/header/roulette.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1071839)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /projekte/projekt3/casino
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /projekte/projekt3/casino.R 
output:
  html_document:
    keep_md: true
---



Dieses Projekt befasst sich mit dem Thema Glücksspiel. Es existieren zahlreiche Glücksspiele, beispielsweise Glücksspielautomaten (z.B. der "Einarmige Bandit"), Roulette, Kartenspiele (z.B. Blackjack und Poker), Würfelspiele, Sportwetten, Lotto, Rubbellose und Bingo sowie im weiteren Sinne auch die Börsenspekulation. In diesem Projekt möchten wir uns auf das Roulette konzentrieren. Roulette ist ein weltweit verbreitetes, traditionelles Glücksspiel, bei dem es darum geht, auf bestimmte Zahlen oder Eigenschaften von Zahlen zu setzen, die durch den zufälligen Lauf einer Kugel in einem Kessel bestimmt werden. ([Klicke hier für weitere Informationen](https://de.wikipedia.org/wiki/Roulette).) Ziel ist in diesem Projekt, dass du dir am Ende den Weg ins Casino sparen kannst, weil du dir in `R` ein Roulette nachgebaut hast!

## Zielsetzung

In diesem Projekt soll es um den Umgang mit Funktionen in `R`, den Umgang mit Wenn-Dann-Bedingungen (`if` und `else`) und um das Erzeugen von Schleifen mit `for`, `while` oder `repeat` gehen. In diesem Projekt soll mithilfe dieser Funktionen ein Roulette-Spiel rekonstruiert und mithilfe dessen verschieden Situationen nachgestellt werden.  Hierdurch sollst du dich mit dem Gebrauch dieser Funktionen vertraut machen und verschiedene, kombinierte Verwendungsmöglichkeiten kennenlernen.      

## Vorbereitung

Für die Bearbeitung dieses Projektes solltest du dich zunächst mit Funktionen in `R` beschäftigen. Dazu kannst du dich entweder selbst im Internet informieren oder du nutzt diesen [R-Blog](https://r-coding.de/blog/if-else/) zu `if` und `else` - Bedingungen in `R`. In der statistischen Lehre an der Goethe Universität werden diese Arten von Funktionen in dem Tutorial [Loops und Funktionen](/post/loops-und-funktionen) für PsyBSc7 näher behandelt. 

Desweiteren solltest du dich ein wenig mit dem Spiel Roulette auseinandersetzen. Auf [SpielBank.com.de](https://www.spielbank.com.de/online-casinos/roulette/regeln/) kannst du dir die Regeln und den Ablauf des französischen Roulettes durchlesen, um mögliche Wetten und die dazugehörigen Wettquoten kennenzulernen. Kurz zusammengefasst wird eine Roulettekugel in den Roulettekessel geworfen, welcher mit 37 Fächern (für die Zahlen 0-36) in abwechselnd roter und schwarzer Farbe - oder grün im Falle der 0 - bestückt ist. **Ziel des Spieles ist es, die Zahl oder die Farbe vorherzusagen, auf welcher die Kugel in der folgenden Spielrunde liegenbleiben wird.**

In der folgenden Tabelle sind die möglichen Einsatzvarianten samt ihrer dazugehörigen Gewinnquoten abgebildet. Je höher die Gewinnquote - also je statistisch unwahrscheinlicher - , desto größer die Auszahlung!
(Anmerkung: Bei der Berechnung der Gewinnquote wird die 0 nicht berücksichtigt.) 

| Einsatzvariante | Ereignis | Gewinnquote |
| --- | --- | --- |
| Die Einfache Chance | "Rot" oder "Schwarz", "Ungerade" oder "Gerade", "Niedrig" oder "Hoch" | 1:1 |
| Douzaines (Dutzend) | 12 aufeinanderfolgende Zahlen (1-12 / 13-24 / 25-36) | 2:1 |
| Colonnes (Kolonne) | Kolonne 34, Kolonne 35, Kolonne 36 | 2:1 |
| Transversale Simple (Große Straße) | 6 Zahlen in zwei Querreihen untereinander | 5:1 |
| Transversale Pleine (Straße) | 3 Zahlen in einer Querreihe | 11:1 |
| Les Trois Premiers | Die ersten 3 Zahlen (0-2) | 11:1 |
| Les Quatre Premiers | Die ersten 4 Zahlen (0-3) | 8:1 |
| Carré | Schnittpunkt zwischen vier Zahlen (z.B. 2-3-4-5) | 8:1 |
| Cheval | Wette auf zwei angrenzende Zahlen | 17:1 |
| Plain | Wette auf eine einzelne Zahl | 35:1 |
 
Anhand der Gewinnquote lässt sich berechnen, wie hoch die Auszahlung ist, sollte die Kugel auf dem gemachten Einsatz landen. Wenn jemand beispielsweise 10 Euro auf die 2 gesetzt hat und die Kugel tatsächlich auf der 2 liegenbleibt, werden 350 Euro plus der Einsatz von 10 Euro ausgezahlt.  

Der Wetttisch beim französischen Roulette sieht folgendermaßen aus:

![](/projekte/projekt3/Roulette_table.png)

## Beispiel zur Verwendung von Funktionen {#Beispiel}

Im Folgenden bekommst du ein kleines Beispiel zur Verwendung von den Funktionen `if`, `else`, `for` und `while`. Stell dir vor, du spielst mit ein paar Freund:innen Monopoly und sitzt im Gefängnis fest. Um aus dem Gefängnis zu kommen, ist es notwendig, einen Pasch zu würfeln (die gleiche Augenzahl bei den beiden Würfeln). Zunächst möchten wir schauen, bei wie vielen von 50 Würfen ein günstiges Ergebnis - also ein Pasch - herauskommt.


```r
Ergebnis1 <- NULL
Ergebnis2 <- NULL
Bedeutung <- NULL
Konsequenz <- NULL
```

Zuerst erstellt man dazu die Objekte, in denen man im Folgenden die Werte aus der Schleife speichern möchte. `Ergebnis1` sehen wir dafür vor, jeweils die Augenzahl des ersten Würfels zu speichern; `Ergebnis2` soll das gleiche für den zweiten Würfel tun. Die beiden Objekte `Bedeutung` und `Konsequenz` sollen jeweils die beiden Augenzahlen kombinieren und zum einen die Bedeutung ( "Pasch" oder "kein Pasch") und zum anderen die daraus folgende Implikation für das Spiel "Du bist frei!" oder "Bleib im Gefängnis!" ausgeben. Die Funktion, die das umsetzt, sieht folgendermaßen aus: 


```r
for (i in 1:50) {         # Wie lang soll die Schleife sein? - 50 Wiederholungen
  wuerfel1 <- sample(1:6, 1)  # Zufallsziehung von Würfel 1
  Ergebnis1[i] <- wuerfel1    # Das Ergebnis von Würfel 1 wird jeweils in einem neuen Eintrag (Eintrag "i" für die i-te Runde/den i-ten Durchlauf) im Objekt "Ergebnis1" gespeichert.
  wuerfel2 <- sample(1:6, 1)  # Zufallsziehung von Würfel 2
  Ergebnis2[i] <- wuerfel2    # Abspeicherung des Ergebnisses von Würfel 2
  if (wuerfel1 == wuerfel2) {     # Wenn die beiden Würfel die gleiche Augenzahl haben, dann soll in dem Objekt "Bedeutung" abgespeichert werden, dass ein Pasch gewürfelt wurde. Ebenso soll in dem Objekt "Konsequenz" die Anweisung "Du bist frei!" ausgegeben werden.
    Bedeutung[i] <- "Pasch"
    Konsequenz[i] <- "Du bist frei!"
  } else {                # Ansonsten soll im Objekt "Bedeutung" abgespeichert werden, dass kein Pasch gewürfelt wurde und im Objekt "Konsequenz" die Anweisung "Bleib im Gefängnis!"
    Bedeutung[i] <- "kein Pasch"
    Konsequenz[i] <- "Bleib im Gefängnis!"
  }
}
Monopoly_Gefaengnis <- data.frame(Ergebnis1, Ergebnis2, Bedeutung, Konsequenz) # Datensatz aus den drei Objekten erstellen
```


```r
View(Monopoly_Gefaengnis)     # Datensatz anschauen
```

Mit dieser Funktion "würfelt" man also 50 Mal, speichert die Augenzahlen jeweils ab und fügt `Bedeutung` und die daraus folgende `Konsequenz` für das Spiel hinzu. Am Ende liegen in allen 4 Variablen (`Ergebnis1`, `Ergebnis2`, `Bedeutung` und `Konsequenz`) 50 zusammengehörige Ausprägungen vor. Diese kann man dann in einen Datensatz zusammenfügen und erhält folgende Tabelle:


<table>
 <thead>
  <tr>
   <th style="text-align:right;"> Ergebnis1 </th>
   <th style="text-align:right;"> Ergebnis2 </th>
   <th style="text-align:left;"> Bedeutung </th>
   <th style="text-align:left;"> Konsequenz </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> kein Pasch </td>
   <td style="text-align:left;"> Bleib im Gefängnis! </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> kein Pasch </td>
   <td style="text-align:left;"> Bleib im Gefängnis! </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> kein Pasch </td>
   <td style="text-align:left;"> Bleib im Gefängnis! </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Pasch </td>
   <td style="text-align:left;"> Du bist frei! </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> kein Pasch </td>
   <td style="text-align:left;"> Bleib im Gefängnis! </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> kein Pasch </td>
   <td style="text-align:left;"> Bleib im Gefängnis! </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> kein Pasch </td>
   <td style="text-align:left;"> Bleib im Gefängnis! </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> kein Pasch </td>
   <td style="text-align:left;"> Bleib im Gefängnis! </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> kein Pasch </td>
   <td style="text-align:left;"> Bleib im Gefängnis! </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> kein Pasch </td>
   <td style="text-align:left;"> Bleib im Gefängnis! </td>
  </tr>
</tbody>
</table>

Desweiteren kann man überprüfen, wie lange es dauert, bis man einen Pasch würfelt. Dazu benutzt man folgenden Code:


```r
wuerfel1 <- 0    # Würfel 1
wuerfel2 <- 1    # Würfel 2
m <- 0       # Anzahl Würfe
```

Zunächst muss man wiederum 3 Objekte erstellen, die man im Folgenden benutzen möchte. `wuerfel1` und `wuerfel2` sollen jeweils die Augenzahl eines Würfels abspeichern. Das wichtige dabei ist, dass man diesen beiden Objekten am Anfang ungleiche Zahlen zuordnet, denn ansonsten ist die Bedingung der Funktion direkt erfüllt.

`m` soll dann die Anzahl der Durchgänge zählen, die man bis zum Erfolg ("Pasch") benötigt. Diese Variable sollte (logischerweise) bei Null beginnen. Warum das so ist, wird in der folgenden Funktion deutlich: 


```r
while (wuerfel1 != wuerfel2) {      # Bedingung
  m <- m + 1                # zählt die Durchgänge - pro Durchlauf +1
  wuerfel1 <- sample(1:6, 1)    # Würfel 1
  wuerfel2 <- sample(1:6, 1)    # Würfel 2
  print(c(wuerfel1, wuerfel2))      # Die beiden Augenzahlen werden pro Wurf ausgegeben, um die Ergebnisse nachvollziehen zu können.
}
```

```
## [1] 4 2
## [1] 3 6
## [1] 6 3
## [1] 3 2
## [1] 3 1
## [1] 1 4
## [1] 1 1
```

Jetzt kann man an der Variable `m` ablesen, wie viele Versuche man bis zu einem Pasch gebraucht hat. Denn angefangen bei 0 wurde `m` in jedem Durchlauf um 1 erhöht. In diesem Fall hat es erst im siebten Versuch geklappt.


```r
m
```

```
## [1] 7
```

Das war es erst einmal mit der Einführung. Viel Spaß bei diesem Projekt!
      

## Aufgabe 1: Grundprinzip Roulette

Erstelle in `R` die Zufallsziehung, die bei einem einzelnen Roulette-Spiel stattfindet. Simuliere dann 50 Roulette-Spiele, am besten unter Verwendung einer Schleife. Versuche nun (mithilfe eines bestimmten Befehls, den du im **Tipp zur Gewinnberechnung** findest) zu ermitteln, wie viel du bei diesen 50 Spielen gewonnen hättest, wenn du jedes Mal 5 Euro auf die 9 gesetzt hättest.

## Tipps zu Aufgabe 1: Grundprinzip Roulette
 
<details><summary> Tipp zur Zufallsziehung </summary>

Für eine einfache Simulation der Zufallsziehung beim Roulette in `R` benutzt man den `sample`-Befehl. Für weitere Informationen zu dieser Funktion und den Argumenten schau dir die interne Hilfe an. Roulette ist nicht sehr kompliziert, du brauchst also nur die Basics.

Wenn du 50 Ziehungen durchführen und in einem Objekt speichern willst, gibt es zwei Möglichkeiten:

- Entweder du bleibst bei der `sample`-Funktion und benutzt passende Argumente dafür 
- oder du benutzt eine `for`-Schleife, um 50 Mal den gleichen Befehl auszuführen und das Ergebnis jeweils einem Objekt hinzuzufügen. 

</details>

<details><summary> Tipp zur Gewinnberechnung </summary>

Im vorherigen Teil hast du einen Vektor mit 50 Ziehungen angelegt. Wie berechnet man jetzt daraus den Gewinn für eine Wette auf die 9?

Dafür benötigst du eine Art der `if`-Funktion und zwar die `ifelse`-Funktion. Diese Funktion ist auf Vektoren anwendbar und überführt die einzelnen Zufallsziehungen entweder in ein *Ergebnis A* (falls die Bedingung "Zahl = 9" erfüllt ist) oder in ein *Ergebnis B* (falls die Bedingung "Zahl = 9" nicht erfüllt ist). Die *Ergebnisse A & B* musst du hier festlegen als den einem Einsatz von 5 Euro ensprechenden *Gewinn*, den man macht, wenn die Kugel auf der 9 landet bzw. wenn sie es nicht tut. (Der *Gewinn* kann natürlich auch negativ sein, falls man die Wette und somit seinen Einsatz verliert.) Es entsteht dadurch also ein neuer Vektor, der nicht mehr die Zufallsziehungen jeder Runde, sondern nur noch den *Gewinn* jeder Runde enthält. Aus diesem Vektor lässt sich dann durch einfache Addition der Gesamtgewinn berechnen.
Sieh dir die interne Hilfe an, um nachzuschauen, wie genau die Funktion funktioniert und welche Argumente sie besitzt. 

</details>

## Lösung zu Aufgabe 1: Grundprinzip Roulette

<details><summary>Lösung anzeigen</summary>
<p>

Das europäische Roulette verwendet eine Scheibe mit den Zahlen von 0 bis 36, also hat sie 37 verschiedene Fächer. Demnach entspricht das einer einfachen Zufallsziehung aus den Zahlen 0 bis 36, bei der jede Zahl mit gleicher Wahrscheinlichkeit auftritt, da die Fächer alle die gleiche Fläche einnehmen.

Mit `sample` kannst du - ohne Zurücklegen - alle Nummern ziehen. Es wird als eine zufällige Reihenfolge der Zahlen generiert: 


```r
sample(0:36)
```

```
##  [1]  0 27  8 24 22 23 19 15  2 17 33  1 36  7 20  5  4 18 21 34 29  3 11  9 16 28 13 32 30 14 31 35 12 25  6
## [36] 26 10
```
 
Was hier nun passiert, ist eine Urnenziehung "ohne Zurücklegen" bis alle Nummern gezogen wurden. Das entspricht jedoch nicht der Zufallsziehung beim Roulette. Dort wird jeweils "mit Zurücklegen" gespielt. Das kann man nun auf zwei Wegen erreichen: 

Man könnte jeweils nur eine Ziehung durchführen. Dafür beschränkt man den Befehl auf eine Ziehung aus allen Zahlen. Möchte man nun mehrere Durchgänge simulieren, führt man diesen Befehl einfach mehrfach aus.


```r
sample(0:36, 1)
```

```
## [1] 35
```

Man könnte auch mit dem Argument `replace = T` festlegen, dass die gezogenen Zahlen immer wieder zurückgelegt werden. Jetzt kann man mit dem zweiten Argument festlegen, wie oft man die Zufallsziehung durchführen möchte und man erhält eine mathematische Simulation der Zufallsziehung beim Roulette.


```r
sample(0:36, 5, replace = T)
```

```
## [1]  9  9 24  5 27
```

Jetzt lassen wir die Roulettekugel 50 Mal rollen und speichern die Ergebnisse in der Variable "Ziehungen".

Das kann entweder, wie bereits beschrieben, über das `replace`-Argument im `sample`-Befehl gemacht werden. (Das Ergebnis ist ein numerischer Vektor, den wir hier dem Objekt `Ziehungen` zuweisen.)


```r
Ziehungen <- sample(0:36, 50, replace = T)
Ziehungen
```

```
##  [1] 31 35  5  5  3  9 17 16 28 31  5 35 14  3 13  1 29 24 12 32 17 34 18 18  0 19 12 15 34  6  9 16  8 25 34
## [36] 22 12 17 34 16  8  7 25 20 36 31  9 17 27 23
```

Oder man geht einen etwas schwierigeren Weg über eine `for`-Schleife. Dafür erstellt man zuerst ein leeres Objekt, in dem man dann im Folgenden die einzelnen Ziehungen speichern kann, und führt dann die Schleife aus.


```r
Ziehungen <- NULL
for (i in 1:50) {
  Ziehungen[i] <- sample(0:36, 1)
}
Ziehungen
```

```
##  [1] 10 33  9 21 14 36 32 10 21 24 29  6 27 29 33 14 30  7 26 21 26 33 36 15 20 10  6 25 35  6  2  9 21 28 30
## [36]  4 20 22  6 35 35 35 21  2  5 25  2  2 13 17
```

Die erste Variante ist zwar wesentlich einfacher zu schreiben (und für `R` auch wesentlich einfacher und schneller auszuführen), aber die zweite erlaubt es uns, nach dem Rollen jeder einzelnen Kugel noch andere Dinge zu tun.

Nun können wir die Zufallsziehung im Roulette simulieren und auch mehrfach ablaufen lassen. Was jetzt noch fehlt, sind die Wetten und die Berechnung des Gewinns.

Dazu wenden wir uns erst einmal der Frage zu: Wie hoch wäre mein Gewinn, wenn ich in jeder Runde 5 Euro auf die 9 gesetzt hätte?

Bei der Wette auf die 9 handelt es sich um eine einfache Wette auf eine Zahl. Die Wahrscheinlichkeit liegt bei 1:37 bei einer Gewinnausschüttung mit dem Faktor 36. (Die Gewinnausschüttung berechnet sich, wie bereits erwähnt, immer ohne Einbezug der Null - aus diesem Grund geht das Casino auf Dauer als Sieger in diesem Spiel hervor.) Setzt man nun 5 Euro auf eine einzelne Zahl und liegt damit richtig, so erhält man seinen ursprünglichen Einsatz von 5 Euro zurück und bekommt zusätzlich das 36-fache davon, also 180 Euro ausgezahlt. Liegt man nicht richtig, verliert man seinen Einsatz, hat also einen Verlust von 5 Euro.

Nun können wir eine Funktion auf das Objekt `Ziehungen` (Vektor) anwenden, die einen weiteren Vektor mit den Gewinnen zu den Ziehungen erstellt. Diesen weisen wir dem Objekt `Gewinne` zu.


```r
Gewinne <- ifelse(Ziehungen == 9, 180, -5)
```

Die `ifelse`-Funktion ist folgendermaßen aufgebaut:

1. Man gibt die Bedingung an.
2. Man gibt die Ausgabe für den Fall an, dass die Bedingung zutrifft.
3. Man gibt die Ausgabe für den Fall an, dass die Bedingung nicht zutrifft.

Wenn also eine 9 herausgekommen ist, soll ein Gewinn von `180` eingesetzt werden; ansonsten der Gewinn von `-5` (= Verlust). Der dadurch bestimmte Vektor sieht dann folgendermaßen aus:


```
##  [1]  -5  -5 180  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5
## [27]  -5  -5  -5  -5  -5 180  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5  -5
```

Jetzt kann man zu jeder Runde den Gewinn ablesen. Insgesamt ergibt das eine Ausbeute von:


```r
Gesamtgewinn <- sum(Gewinne)
Gesamtgewinn
```

```
## [1] 120
```

Wie man sehen kann, hatten wir in diesem Fall sehr viel Glück. Die 9 wurde in 5 Durchläufen gezogen. Dadurch ergab sich ein phänomenaler Gewinn von 120 Euro.

</details>

## Aufgabe 2: Implementierung verschiedener Wettmöglichkeiten

Die Funktion aus Aufgabe 1 ist aktuell nur auf die Überprüfung einer Zahl bei einem bestimmten Einsatz spezialisiert. Für jede andere Wette und/ oder jeden anderen Einsatz müsste eine neue Funktion geschrieben werden. 

Schreibe also eine Funktion, mit der sich der Gewinn ermitteln lässt und zwar so, dass alle einzelnen Zahlen in dieser Funktion erfasst werden. Implementiere dabei auch die Wetten `RED`, `BLACK`, `ODD`, `EVEN` sowie das erste, zweite und letzte Drittel. Wähle dabei entweder einen Einsatz von 10 Euro oder (noch besser) verwende den Platzhalter `y` und speichere zur Überprüfung deiner Funktion beispielsweise den Wert 10 auf dem Objekt `y` ab. 

Erstelle dann wieder eine Schleife mit 50 Spielen, die unter Verwendung der gerade erstellten Funktion jeweils die Zufallsziehung und den Gewinn abspeichert und teste dein "`R`-Roulette", indem du auf `ODD` tippst.

Nicht vergessen: Die Zahlengruppen, wie z.B. `RED` und `BLACK`, müssen zuvor erstellt werden. Fange am besten damit an. Dafür erstellt man Objekte, die die jeweiligen Zahlen enthalten.
    
## Tipps zu Aufgabe 2: Implementierung verschiedener Wettmöglichkeiten
     
<details> <summary> Tipp zu Bedingungsüberprüfungen </summary>

Mehrere Dinge müssen verändert werden, um weitere Wettmöglichkeiten in die Gewinnberechnung zu implementieren.

So muss unter anderem die Bedingung verändert werden. `==` eignet sich nicht dafür, zu überprüfen, ob eine Zahl Element einer Zahlengruppe ist. Aus diesem Grund sollte man hierfür nun `is.element()` benutzen. Sofern dir nicht klar ist, was diese Funktion macht und wie sie aufgebaut ist, schau dir die Funktion in der Hilfefunktion von `R` an.

Auch um zu überprüfen, ob zwei Vektoren identisch sind, eignet sich `==` nicht. Zu diesem Zweck kann man z.B. die `identical`-Abfrage verwenden. 
                           
</details>


<details> <summary> Tipp zur Überarbeitung der Gewinnberechnung </summary>

Bei dieser Aufgabe muss man beachten, dass es nun unterschiedliche Quoten für die verschiedenen Wetten gibt. Aus diesem Grund kann man eine weitere `if`-Funktion mit mehreren `elseif`-Fortsätzen einfügen, die für jede Wettmöglichkeit die Gewinnausschüttung angibt [z.B. `if (identical(z, RED){y} else if (identical(z, firstThird){2y}` mit `x` = Wette und `y` = Einsatz]. Für das Beispiel heißt das: Wenn auf `RED` gewettet wurde, so liegt der Gewinn bei Eintreffen der Wette bei `y`, man erhält den eigenen Einsatz also doppelt zurück. 

Viele verschiedene Wettmöglichkeiten führen zu einer identischen Gewinnberechnung (z.B. `RED` und `BLACK`). Dadurch wiederholen sich in der Funktion möglicherweise einige Befehle. Versuche das durch die Verwendung des mathematischen "oder", was in `R` durch `|` ("Alt Gr" + "<") dargestellt wird, zu vermeiden.

</details>

<details> <summary> Tipp zur Erstellung der neuen Schleife </summary>

Im letzten Schritt benutzt man eine `for`-Schleife. In diese setzt du die Zufallsziehung und die Gewinnberechnung ein, sodass in jedem Durchlauf direkt auch der Gewinn ausgegeben werden kann. Wichtig: Beide Variablen (`Ziehungen` und `Gewinne`) müssen in einem Objekt abgespeichert werden! Falls du nicht weißt, wie man das bei einer Schleife macht, schau dir noch einmal das [**Beispiel zur Verwendung von Funktionen**](#Beispiel) an.

Falls du die Objektnamen aus Aufgabe 1 übernimmst, vergiss nicht, diese zunächst von allen Daten zu befreien.

</details>

## Lösung zu Aufgabe 2: Implementierung verschiedener Wettmöglichkeiten

<details><summary>Lösung anzeigen</summary>

Beim Roulette kann man auf beinahe jede vorstellbare Kombination von Zahlen wetten. In dieser Aufgabe bauen wir aber nur die in der Aufgabe verlangten 7 Möglichkeiten ein: rote Zahlen (`RED`), schwarze Zahlen (`BLACK`), gerade (`EVEN`) und ungerade (`ODD`) Zahlen, sowie die drei *Douzaines* - Dutzende - in die sich die Zahlen 1 bis 36 einteilen lassen. Wir müssen diese Möglichkeiten zunächst als Objekte mit den dazugehörigen Zahlen füllen. Außer `RED` und `BLACK` können wir dabei alle Vektoren abkürzen: 


```r
RED <- c(1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36)
BLACK <- c(2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35)
EVEN <- seq(2, 36, by = 2)
ODD <- seq(1, 35, by = 2)
firstThird <- 1:12
secondThird <- 13:24
lastThird <- 25:36
```

Grundsätzlich gibt es beim Roulette drei Variablen: den Einsatz, die Wette und die Zufallsziehung. Alle drei gehen in die Berechnung des Gewinns mit ein. Der Einsatz ist die Basis zur Berechnung des Gewinns. Dazu kommt die Wette im Abgleich mit der Zufallsziehung: je nachdem, wie man tippt und ob man richtig tippt oder nicht, ergibt sich eine andere Gewinnberechnung.


```r
# x = Ergebnis Roulette
x <- sample(0:36, 1)
# y = Einsatz (beispielhaft 10 Euro)
y <- 10
# z = Zahl/Gruppe von Zahlen, auf die gesetzt wurde (beispielhaft ungerade Zahlen)
z <- ODD
```
 
Zur Gewinnberechnung haben wir in Aufgabe 1 die `ifelse`-Funktionen verwendet. Allerdings lässt sich diese Funktion nicht so gut auf kompliziertere Fälle anwenden als den aus Aufgabe 1, wo es nur eine Bedingung gab (und zwar dass eine einzelne Zahl gedreht wurde) und auch nur einen potenziell möglichen Gewinn.

Aus diesem Grund wurde die Aufgabe so gestellt, dass die Gewinnberechnung "einen Schritt früher stattfindet" und in die Schleife mit den 50 Spielen integriert wird, statt erst danach stattzufinden. Damit wie schon bei Aufgabe 1 auch die gedrehten Zahlen mitausgegeben werden, müssen diese weiterhin innerhalb der Schleife in einem eigenen Objekt abgespeichert und später mitausgegeben werden. 

Bei der Gewinnberechnung nutzt man die "normale" `if`-Funktion. Die Bedingung wie in Aufgabe 1 nach dem Prinzip "Wenn die Zufallsziehung x der Wette z entspricht, dann gewinnt man" zu schreiben, funktioniert nach wie vor, wenn die Wette eine einzelne Zahl ist. Allerdings geht das bei den neu hinzugefügten Wetten (wie zum Beispiel auf die ungeraden Zahlen) nicht. Also formulieren wir die Bedingung mit dem `is.element`-Argument. Wenn `x` (die Zufallsziehung) ein Element von `z` (der Wette) ist, hat man gewonnen.    

Zusätzlich zu der Bedingung, die prüft, ob man richtig getippt hat, baut man nun bei Zutreffen der Bedingung eine weitere `if`-Funktion ein, die die unterschiedlichen Berechnungen des Gewinns für die unterschiedlichen Wetten beinhaltet. In diesem Rahmen muss abgefragt werden, welcher der verschiedenen möglichen Wetten die getätigte Wette `z` entspricht. 

Hierfür können wir nicht die logische Abfrage `==` verwenden, weil diese nur einzelne Zahlen miteinander vergleichen kann und nicht ganze Vektoren. Stattdessen bietet sich der `identical`-Befehl an. Dieser Befehl überprüft, ob zwei Elemente identisch sind, unabhängig von der Struktur bzw. Größe dieser beiden Elemente.    

Abhängig von Zufallsziehung, Einsatz und Wette könnte man den Gewinn also folgendermaßen ermitteln:
   

```r
if (is.element(x, z)) {
  if (identical(z, RED)) {
    y
  } else if (identical(z, BLACK)) {
    y
  } else if (identical(z, ODD)) {
    y
  } else if (identical(z, EVEN)) {
    y
  } else if (identical(z, firstThird)) {
    y * 2
  } else if (identical(z, secondThird)) {
    y * 2
  } else if (identical(z, lastThird)) {
    y * 2
  } else {
    y * 35
  }
} else {
  -y
}
```

```
## [1] -10
```

Wie man sehen kann, berechnet diese Funktion den korrekten Gewinn für unser Beispiel.

Ein kleiner Kritikpunkt dieser Funktion ist die mehrfache Wiederholung fast identischer Befehle. Das kann man durch die Verwendung logischer Verknüpfungen; und zwar dem `|` (das "oder" in `R`) verhindern. Im Folgenden kann man die optimierte Version des Befehls sehen:


```r
if (is.element(x, z)) {
  if (identical(z, RED) | identical(z, BLACK) | 
      identical(z, ODD) | identical(z, EVEN)) {
    y
  } else if (identical(z, firstThird) | 
      identical(z, secondThird) | 
      identical(z, lastThird)) {
    y * 2
  } else {
    y * 35
  }
} else {
  -y
}
```

```
## [1] -10
```

Da die Funktion nun okönomisch und ohne Fehler läuft, können wir das Ganze nun in die Schleife einsetzen, die wir bereits in Aufgabe 1 benutzt haben. Damit enthält diese Schleife die Verbesserung, dass in jedem Durchlauf auch der Gewinn ermittelt wird.

Um das jetzt auch einmal auszuprobieren, müssen wir die beiden Variablen `Ziehungen` und `Gewinne` von den Daten aus der ersten Aufgabe befreien und die Wette beispielhaft auf `ODD` festlegen:


```r
Gewinne <- NULL
Ziehungen <- NULL
z <- ODD
```

Die Schleife sieht nun folgendermaßen aus:


```r
for (i in 1:50) {
  x <- sample(0:36, 1)
  Ziehungen[i] <- x
  Gewinne[i] <- if (is.element(x, z)) {
    if (identical(z, RED) | identical(z, BLACK) | 
        identical(z, ODD) | identical(z, EVEN)) {
      y
    } else if (identical(z, firstThird) | 
        identical(z, secondThird) |
        identical(z, lastThird)) {
      y * 2
    } else {
      y * 35
    }
  } else {
  -y
  }
}
```

Die Ergebnisse können wir uns nun entweder einzeln anschauen oder wir verbinden beide Objekte zu einem Datensatz.


```r
Ziehungen
```

```
##  [1] 15 13 15 10 34 30 33  7 23 18 23 16 25 22 34  8 24  6 22  2  9 30  1 24 35 17 16 35 30  6 30  2 27 17 22
## [36]  9 13 20 36 12 25 35 12 17 10 20 21  2  8  0
```

```r
Gewinne
```

```
##  [1]  10  10  10 -10 -10 -10  10  10  10 -10  10 -10  10 -10 -10 -10 -10 -10 -10 -10  10 -10  10 -10  10  10
## [27] -10  10 -10 -10 -10 -10  10  10 -10  10  10 -10 -10 -10  10  10 -10  10 -10 -10  10 -10 -10 -10
```


```r
Spiel_Odd_50 <- data.frame(Ziehungen, Gewinne)
head(Spiel_Odd_50)
```

```
##   Ziehungen Gewinne
## 1        15      10
## 2        13      10
## 3        15      10
## 4        10     -10
## 5        34     -10
## 6        30     -10
```

Den Gesamtgewinn kann man sich dann auch noch für jede Runde mithilfe der `cumsum`-Funktion anzeigen lassen oder man benutzt die `sum`-Funktion, um nur das Endergebnis zu erhalten.


```r
cumsum(Gewinne)
```

```
##  [1]  10  20  30  20  10   0  10  20  30  20  30  20  30  20  10   0 -10 -20 -30 -40 -30 -40 -30 -40 -30 -20
## [27] -30 -20 -30 -40 -50 -60 -50 -40 -50 -40 -30 -40 -50 -60 -50 -40 -50 -40 -50 -60 -50 -60 -70 -80
```

```r
sum(Gewinne)
```

```
## [1] -80
```

</details>

## Aufgabe 3: Spiele, bis du X Euro gewonnen hast.

Hast du dich schon mal gefragt, wie lang es dauert, bis du einen bestimmten Betrag beim Roulette gewonnen hast? Lege dich beispielsweise darauf fest, dass du jede Runde 10 Euro auf "ROT" setzt und am Ende einen Gewinn von 50 Euro haben möchtest. 
Schreibe nun eine Funktion, die so lange läuft, bis du das gewünschte Geld gewonnen hast.
Achtung: Die Funktion zählt die Durchläufe nicht von selbst mit. Sorge dafür, dass eine Variable deiner Schleife die Durchläufe zählt. Wie lang hat es bis zu deinem gewünschten Gewinn gedauert?

Tipp: Mit etwas Glück hält die Schleife irgendwann an und du gewinnst tatsächlich 50 Euro, unter Umständen wird der Fall aber nie eintreten. Besonders wenn du "zu viel" gewinnen möchtest, könnte es passieren, dass die Schleife immer weiter läuft. Stoppe die Schleife dann in deiner Konsole manuell und probier es noch einmal mit einer anderen Wette oder baue eine weitere Bedingung ein, die die Durchläufe begrenzt. So könntest du für das obige Beispiel festlegen, dass die Schleife nach 500 Durchgängen anhält, sofern du bis dahin keine 50 Euro gewonnen hast. 


## Tipps zu Aufgabe 3: Spiele, bis du X Euro gewonnen hast.

Hier erhältst du zwei verschiedene Möglichkeiten, um dasselbe Problem zu lösen. Die erste Möglichkeit wird dich etwas mehr fordern. Probiere es also zuerst damit. Falls du es damit nicht schaffst, die Aufgabe zu lösen, schau dir die zweite Möglichkeit an. Diese gibt dir Hinweise zu den einzelnen Schritten, bis du zur Lösung des Problems kommst.

<details> <summary> Möglichkeit 1: Übertragen von Modell </summary>

Falls du noch nicht darauf gekommen bist, schau dir noch einmal das [**Beispiel zur Verwendung von Funktionen**](#Beispiel) an. Dort findest du eine Funktion nach dem gleichen Schema, wie es auch hier gefordert ist. Falls dir das nicht ausreicht, kannst du zusätzlich dazu auch noch Möglichkeit 2 nutzen.

</details>

<details> <summary> Möglichkeit 2: Schrittweise Anleitung </summary>

Zunächst schau dir einmal an, was du aus den vorherigen Abschnitten übernehmen kannst. Ändert sich etwas an der Zufallsziehung und der Gewinnberechnung? Was kommt neu hinzu?

Kurz gesagt: Zufallsziehung und Gewinnberechnung bleiben gleich, können also 1:1 übernommen werden. Neu sind die Bedingung mit dem Gesamtgewinn, das Updaten des Gesamtgewinns und das Zählen der Durchgänge.

Beginnen wir bei der Bedingung: Die Bedingung lässt sich umsetzen durch den Befehl, dass die Schleife so lange wiederholt wird, bis der tatsächliche Gesamtgewinn nicht mehr kleiner als der gewünschte Gesamtgewinn ist. Zu diesem Zweck wird eine `while`-Schleife benötigt. Eventuell ist es hilfreich, sich das [**Beispiel zur Verwendung von Funktionen**](#Beispiel) noch einmal anzuschauen, weil hier eine `while`-Schleife zum Einsatz kommt. Außerdem kannst du [hier unter dem Reiter "Programmierung"](https://www.uni-muenster.de/Stochastik/lehre/SS14/PrakStat/R-Befehle.pdf) nachlesen, wann eine `while`-Schleife angewandt wird. 

Die Berechnung des Gesamtgewinns erfordert eine neue "Technik", da dieser jeden Durchgang aktualisiert werden muss. Dazu muss vor der Durchführung der Funktion ein `Gesamtgewinn`-Objekt mit dem Wert 0 erstellt werden. Jede Runde soll dieser Gesamtgewinn dann erneuert werden, indem man den alten Gesamtgewinn und den Gewinn der aktuellen Runde addiert.

Achtung: Diese Berechnung muss nach der Berechnung des aktuellen Gewinns geschehen, ansonsten rechnet man mit dem Gewinn aus der vorherigen Runde.

Der letzte Schritt sollte sein, die Durchgänge zu zählen. Das beruht auf der gleichen Methode, wie die Berechnung des Gesamtgewinns.

Möglicherweise erreicht man den erwünschten Gewinn nie und in Folge dessen würde die Schleife unendlich weiterlaufen. (Sofern du die Schleife bereits gestartet hast, aber die Funktion nicht zum Ende kommt, nutze den "STOP"-Button in der oberen rechten Ecke der Konsole, um die Funktion manuell zu stoppen!) Wenn wir ein Abbrechen der Schleife bei einer bestimmten Anzahl an Durchgängen in die Funktion integrieren wollen, bietet sich der `break`-Befehl an. Du kannst [hier unter dem Reiter "Programmierung"](https://www.uni-muenster.de/Stochastik/lehre/SS14/PrakStat/R-Befehle.pdf) nachlesen, wie er anzuwenden ist. 

Natürlich kannst du auch eine weitere Bedingung zum Abschluss der Funktion mit einem logischen "oder" hinzufügen. Das sollte dann so aussehen: `while (cond1 | cond2) {...}`, wobei `cond1` die Bedingung beschreibt, dass der Gesamtgewinn noch nicht erreicht wurde und `cond2` entspricht der Bedingung, dass noch nicht mehr als 500 Durchgänge durchlaufen wurden. 

</details>

## Lösung zu Aufgabe 3: Spiele, bis du X Euro gewonnen hast

<details><summary>Lösung anzeigen</summary>

Wir spielen nun beispielhaft mit einem Einsatz von 10 Euro auf `RED`. Dafür erstellen wir außerdem ein Objekt, das den Gewinn in der jeweiligen Runde kurzzeitig abspeichert, damit wir damit arbeiten können. 


```r
y <- 10
z <- RED
Gewinn <- NULL
```

Nun fehlen noch genau zwei Dinge: 

1. Wie ermitteln wir jeden Durchgang erneut den Gesamtgewinn, sodass dieser immer wieder mit der Bedingung abgeglichen werden kann?
2. Wie zählen wir die Durchgänge?

Zu 1. - Für die Bedingung entscheiden wir uns für 50 Euro. Das heißt, dass wir so lange spielen wollen, bis wir 50 Euro gewonnen haben. Dafür brauchen wir ein weiteres Objekt für den Gesamtgewinn. Dieses Objekt soll in jedem Durchgang geupdatet werden. Starten soll es (logischerweise) bei Null. Also erstellen wir dafür das Objekt `Gesamtgewinn` mit dem Wert 0.


```r
Gesamtgewinn <- 0
```

Dieses Objekt soll dann in jedem Durchgang mit dem Gewinn addiert werden; also schreibt man in die Funktion: `Gesamtgewinn <- Gesamtgewinn + Gewinn`. So wird der Gesamtgewinn in jedem Durchgang geupdatet und mit der Bedingung `Gesamtgewinn < 50` verglichen. Damit wäre das erste Problem gelöst.

Zu 2. - Für das Zählen der Durchgänge wendet man eine identische Technik an. Dafür erstellt man wiederum ein Objekt (`Durchgaenge`) mit dem Wert 0.


```r
Durchgaenge <- 0
```

Dieses Objekt updatet man auch in jedem Durchgang, indem man jedes Mal 1 addiert: `Durchgaenge <- Durchgaenge + 1`. Somit zählt man automatisch die Durchgänge mit.

Damit wären die beiden Probleme gelöst und wir kommen zu einem vorläufigen Ergebnis der Schleife.

Wenn man möchte, kann man sich auch in jedem Durchgang noch den Zwischenstand (`Gesamtgewinn`) oder den Gewinn der Runde (`Gewinn`) mithilfe der `print`-Funktion ausgeben lassen. Das Endergebnis sieht dann folgendermaßen aus:


```r
while (Gesamtgewinn < 50) {
  x <- sample(0:36, 1)
  Gewinn <- if (is.element(x, z)) {
    if (identical(z, RED) | identical(z, BLACK) |
        identical(z, ODD) | identical(z, EVEN)) {
      y
    } else if (identical(z, firstThird) |
        identical(z, secondThird) |
        identical(z, lastThird)) {
      y * 2
    } else {
      y * 35
    }
  } else {
  -y
  }
  Gesamtgewinn <- Gesamtgewinn + Gewinn
  print (Gesamtgewinn)
  Durchgaenge <- Durchgaenge + 1
}
```

Die Funktion wird nun so lange alle Schritte wiederholen, bis die Bedingung `Gesamtgewinn < 50` nicht mehr zutrifft. Bis dahin werden auch die Durchgänge gezählt. Das heißt, dass man, sofern die Funktion irgendwann stoppt, an dem Objekt `Durchgaenge` ablesen kann, wie lange man für einen Gewinn von 50 Euro hätte spielen müssen. 

Wie man vielleicht merkt, hat das Ganze einen Haken. Wenn man Pech hat, dann kommt diese Funktion nie zum Ende, weil man nie oft genug in Folge gewinnt, um auf einen Gesamtgewinn von 50 Euro zu kommen. Keep in mind: Das Casino gewinnt letztlich immer; und das ist ein Fakt! Die Gewinnausschüttung beim Roulette berechnet sich nämlich derart, dass eine Person, je öfter sie spielt, umso wahrscheinlicher mit leeren Händen nach Hause gehen wird.

Aus diesem Grund sollten wir eine weitere Bedingung einbauen, die die Schleife nach einer bestimmten Zeit unterbricht. Eine Möglichkeit ist es, eine maximale Anzahl an Durchgängen festzulegen, bei der die Schleife beendet wird. Dafür kann man den `break`-Befehl benutzen. Diesen kann man in eine Schleife integrieren und bei Eintreten der dazugehörigen Bedingung (`if`) wird die Schleife unterbrochen. Im folgenden Beispiel brechen wir die Schleife nach 500 Durchgängen ab.


```r
Gesamtgewinn <- 0
Durchgaenge <- 0
while (Gesamtgewinn < 50) {
  x <- sample(0:36, 1)
  Gewinn <- if (is.element(x, z)) {
    if (identical(z, RED) | identical(z, BLACK) |
        identical(z, ODD) | identical(z, EVEN)) {
      y
    } else if (identical(z, firstThird) |
        identical(z, secondThird) |
        identical(z, lastThird)) {
      y * 2
    } else {
      y * 35
    }
  } else {
  -y
  }
  Gesamtgewinn <- Gesamtgewinn + Gewinn
  Durchgaenge <- Durchgaenge + 1
  if (Durchgaenge == 500) break
}
Gesamtgewinn
```

```
## [1] -320
```

Das heißt, dass man nun so lange spielt, bis man entweder 50 Euro gewonnen oder 500 Runden gespielt hat.

</details>

## Aufgabe 4: Funktionen

In `R` gibt es die Möglichkeit, eigene Funktionen mit dem Befehl `function` zu erstellen. Nutze dies nun dafür, eine Roulette-Funktion zu erstellen. Diese Funktion sollte es dir dann ganz einfach ermöglichen, nur durch Angabe von Einsatz und Wette deinen Gewinn in einer Runde zu ermitteln.

Die Funktion sollte in `R` folgendermaßen aussehen:


```r
Roulette(Einsatz, Wette)
```

Ihr Output sollte zunächst die Zufallsziehung und der Gewinn sein.
Wenn du das geschafft hast, verschönere die Ausgabe mit ein paar Nachrichten und Pausen, um das Spiel etwas authentischer zu gestalten. Nutze dafür den `message`-Befehl und den `Sys.sleep`-Befehl.

Die Nachrichten sollten mindestens folgende Informationen vermitteln:

- Verkünde, dass die Kugel startet.
- Verkünde nach bestimmter Zeit, dass keine Wetten mehr möglich sind.
- Welche Zahl kam heraus?
- Welche Bedeutung hat das für meine Wette?
- Je nach Ausgang unterschiedliche Nachrichten, bspw. bei Gewinn Glückwünsche oder Höhe des Gewinns und bei Verlust aufmunternde Worte.

Wenn du das geschafft hast, probiere dich an einer Funktion, bei der man zusätzlich dazu angeben kann, wie viele Runden man mit gleichbleibender Wette und gleichem Einsatz spielen möchte. Passe das Spiel dementsprechend mit abgeänderten Nachrichten und Pausen an.

Die Funktion sollte letztlich so funktionieren:


```r
Roulette_2(Einsatz, Wette, Runden)
```

Die Nachrichten im Output sollten hierbei folgende Fragen beantworten:

- Welche Runde wird gerade gespielt?
- Verkünde, dass die Kugel startet.
- Verkünde nach bestimmter Zeit, dass keine Wetten mehr möglich sind.
- Welche Zahl kam heraus?
- Welche Bedeutung hat das für meine Wette in dieser Runde?
- Wie groß ist mein Gewinn in dieser Runde?
- Wie sieht mein Gesamtergebnis zu diesem Zeitpunkt aus?
- Je nach Ergebnis unterschiedliche Nachrichten, bspw. bei Gewinn Glückwünsche oder Höhe des Gewinns und bei Verlust aufmunternde Worte und wenn man weder einen Gewinn noch einen Verlust erzielt hat, irgendeine Nachricht.
- Zum Schluss: Eine abschließende Nachricht, die das gesamte Spiel für beendet erklärt und es noch einmal zusammenfasst, sowie das Gesamtergebnis beinhaltet. 

## Tipps zu Aufgabe 4: Funktionen

In diesem Abschnitt beschäftigen wir uns mit dem Erstellen von eigenen Funktionen, um eine authentische Roulette-bezogene Ausgabe in `R` zu erhalten. Da die Problemstellung in zwei Teile geteilt ist und man zwei Funktionen erstellen soll, teilen wir auch die Tipps in zwei Teile.

<details> <summary> Teil 1 </summary>    

Als allererstes solltest du dir diesen [PandaR Beitrag](/post/loops-und-funktionen/#function) oder diesen [Wikipedia Artikel](https://de.wikibooks.org/wiki/GNU_R:_Eigene_Funktionen_programmieren) zu der `function`-Funktion in `R` durchlesen, falls du dich damit noch nicht auskennst. Hierin wird erklärt, wie diese Funktion in `R` funktioniert. Sobald du das verstanden hast, kannst du mit dem Erstellen der Funktion beginnen.

Ein wichtiger Bestandteil der Funktion sind die Parameter in der normalen Klammer. Hier stellt sich die Frage: Wie viele "Unbekannte" wird meine Funktion haben? Welche Information braucht meine Funktion? - In unserem Fall handelt es sich nur um zwei Unbekannte, die man als Spieler im vorhinein angeben muss:

- 1. Der Einsatz: Wie viel will ich setzen?
- 2. Die Wette: Auf was will ich setzen?

Diese zwei Variablen müssen also in der normalen Klammer benannt werden. (Dafür kannst du jegliche sich unterscheidende Buchstaben verwenden.)

Jetzt kannst du mit dem Schreiben der Funktion beginnen. Einige Operationen aus den vorherigen Aufgaben können dabei übernommen werden. Beachte dabei nur, die Variablen aus der normalen Klammer bei den Operationen an der richtigen Stelle einzusetzen.

Das Grundgerüst für Roulette sollte nun stehen, nur gibt die Funktion noch keinen Output aus. Dafür können wir den `message`-Befehl benutzen. Dieser ermöglicht es uns, auch Variablen in den Text einzufügen. Hier ein Beispiel:


```r
Wuerfeln1 <- function (){
  message ("Bitte jetzt würfeln!")
  Augenzahl <- sample (1:6, 1)
  message ("Du hast eine ", Augenzahl, " geworfen!")}
Wuerfeln1 ()
```

```
## Bitte jetzt würfeln!
```

```
## Du hast eine 1 geworfen!
```

Nutze das für deine Nachricht(en) aus!

Um das Ganze noch authentischer zu gestalten, kannst du jetzt Pausen für die Ausgabe einbauen. Dafür benutzt man den `Sys.sleep`-Befehl, der in Klammern die Pausenzeit in Sekunden enthält. So kann beim Würfeln zum Beispiel die Zeit zum Fallen des Würfels simuliert werden:


```r
Wuerfeln2 <- function (){
  message ("Bitte jetzt würfeln!")
  Augenzahl <- sample (1:6, 1)
  Sys.sleep (3.0)
  message ("Du hast eine ", Augenzahl, " geworfen!")}
Wuerfeln2 ()
```

```
## Bitte jetzt würfeln!
```

```
## Du hast eine 1 geworfen!
```

</details> 
 
<details> <summary> Teil 2 </summary>

Diese Funktion gestaltet sich etwas komplexer als die vorherige Funktion. Hier werden wir mit dem `repeat`-Befehl und `if (condition) break` arbeiten. Schau dir die Funktionsweise davon im Internet oder im [Appendix A dieses PandaR Beitrag](/post/loops-und-funktionen/#AppendixA) an. An sich funktioniert dieser Befehl genauso wie eine `for`- oder `while`-Schleife, nur dass wir die Schleife hier erst dann stoppen wollen, wenn ein explizites Ereignis eintritt.

Wie bereits in allen anderen Aufgaben solltest du auch hier auf den bereits vorhandenen Operationen aufbauen. Für diese Funktion eignet sich logischerweise die Funktion aus Teil 1 dieses Abschnitts. Es kommt nur eine weitere Variable - neben Einsatz und Wette - hinzu und zwar die Rundenzahl. Das ist die erste Ergänzung, die du vornehmen kannst: Erstelle eine neue Variable für die Rundenzahl in der normalen Klammer. (Außerdem solltest du dieser Funktion einen neuen Namen geben, um die erste Funktion nicht zu überschreiben.)

Hier soll es nun darum gehen, wie wir diese Rundenvariable (die durch den/die Spieler:in angegeben wird) mit der gerade gespielten Runde abgleichen können, sodass die Schleife entsprechend endet. Dafür muss nach bereits angewendetem Prinzip eine weitere Variable erstellt werden, die die aktuelle Runde zählt (also jede Runde 1 addiert wird). Diese muss dann ganz am Ende der `repeat`-Schleife mit der durch den/die Spieler:in angegebenen Rundenzahl abgeglichen werden. Wenn beide Variablen den gleichen Wert haben, soll die Schleife abgebrochen werden.

Das Rundenproblem sollte damit gelöst sein. Hinzu kommt jedoch noch der Gesamtgewinn. Dieser wird bis jetzt nicht ermittelt (, vielmehr wird immer wieder der Gewinn der gerade laufenden Runde ermittelt und dann in der nächsten Runde überschrieben). Natürlich kann der Gewinn jeder Runde in einer Nachricht ausgegeben werden, dadurch erhält man jedoch keinen Gesamtgewinn. Dieser sollte auch nach bereits bekanntem und angewendetem Schema ermittelt werden: eine Variable mit dem Wert "0" **vor** der `repeat`-Schleife erstellen; dann jede Runde updaten.

Der letzte Schritt sind Nachrichten und Pausen. Hier kann man kreativ werden; auf jeden Fall kann man die Nachrichten aus der Funktion in Teil 1 übernehmen. Diese werden in jeder Runde ausgegeben. Außerdem sollte man (auch in jeder Runde) den Gesamtgewinn angeben. Neben diesen Nachrichten sollten auch bei Beenden der Schleife Nachrichten folgen, die das Spiel zusammenfassen. Hierbei kann man auch, je nach Gesamtgewinn, verschiedene "Pfade" erstellen.

Zu bedenken ist dabei, in welcher Reihenfolge die Funktion die Informationen für die Nachrichten berechnet, sodass jede Runde die aktuellen Daten ausgegeben werden und nicht die Daten der vorherigen Runde. Schreibe daher die Nachrichten, die man nach jeder Runde erhält, an das Ende der `repeat`-Funktion (direkt über `if (cond) break`). Die anderen Nachrichten, die sich auf das gesamte Spiel beziehen, schreibst du an das Ende der gesamten Funktion. So gehst du in jedem Fall auf Nummer sicher.

</details>

## Lösung zu Aufgabe 4: Funktionen

<details><summary>Abschnitt 1 anzeigen</summary>

Für das Erstellen einer Funktion kann man den `function`-Befehl benutzen. Dieser Befehl ist folgendermaßen aufgebaut: `function(Variable1, Variable2, ...){Funktion}`. Man gibt in den normalen Klammern an, welche Variablen in der Funktion verwendet und zur Durchführung benötigt werden. In den geschwungenen Klammern gibt man dann die Operationen der Funktion an, die unter Verwendung der Variablen durchgeführt werden. Dem Ganzen kann man mithilfe der Zuweisung mit dem Pfeil einen Namen geben.

Für das Roulette ergeben sich zwei Variablen: der Einsatz `y` und die Wette `z`. Die Funktion kann man aus den vorherigen Aufgaben kopieren. Das ist zum einen die Zufallsziehung und zum anderen die Funktion zur Ermittlung des Gewinns in Abhängigkeit von Einsatz `y` und Wette `z`.

Das Problem ist nun, dass die Funktion noch keine Ergebnisse ausgibt. Dafür können wir zunächst ganz einfach den `print`-Befehl nutzen. Wichtig: der `print`-Befehl kann nur ein Objekt ausgeben, deshalb muss man Zufallsziehung und Gewinn in einen Vektor packen. Das sieht dann folgendermaßen aus:


```r
Roulette <- function (y, z) {
  x <- sample (0:36, 1)
  Gewinn <- if (is.element(x, z)) {
    if (identical(z, RED) | identical(z, BLACK) |
        identical(z, ODD) | identical(z, EVEN)) {
      y
    } else if (identical(z, firstThird) |
        identical(z, secondThird) |
        identical(z, lastThird)) {
      y * 2
    } else {
      y * 35
    }
  } else {
  -y
  }
  print(c(x, Gewinn))
}
Roulette(10,7)
```

```
## [1]  23 -10
```

Nun kann man ganz einfach Roulette spielen, indem man Einsatz und Wette angibt und dann Zufallsziehung und Gewinn erhält. Wie man in diesem Beispiel sieht, wurden 10 Euro auf die Zahl 7 gesetzt. Ausgegeben wird, welche Zahl bei der Ziehung herauskam sowie der Gewinn.

Das Ganze ist aber noch nicht so schön. Deshalb versuchen wir, das Roulettespiel mit Pausen und Nachrichten etwas authentischer zu gestalten. Das Praktische dabei ist, dass man auch Variablen in diese Nachrichten schreiben kann, sodass man zum Beispiel eine Nachricht, die das Ergebnis enthält, allgemein formulieren kann: `message("Es wurde eine ", x, " gedreht!")`. Des Weiteren kann man, je nach Resultat (Sieg oder Niederlage) unterschiedliche Nachrichten mithilfe einer `if`-Funktion ausgeben lassen. Das könnte dann folgendermaßen aussehen:


```r
Roulette <- function (y, z) {
  x <- sample (0:36, 1)
  Gewinn <- if (is.element(x, z)) {
    if (identical(z, RED) | identical(z, BLACK) |
        identical(z, ODD) | identical(z, EVEN)) {
      y
    } else if (identical(z, firstThird) |
        identical(z, secondThird) |
        identical(z, lastThird)) {
      y * 2
    } else {
      y * 35
    }
  } else {
  -y
  }
  message ("Roulettekugel startet")
  Sys.sleep (2.0)
  message ("Rien ne va plus!")
  Sys.sleep (2.0)
  message ("Es ist eine ", x, ".")
  Sys.sleep (2.0)
  if (is.element (x, z)) {
    message ("Du hast gewonnen!")
    Sys.sleep (2.0)
    message ("Dein Gewinn beträgt ", Gewinn, " Euro." )
  } else {
    message ("Du hast verloren!")
    Sys.sleep (2.0)
    message ("Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.")
  }
}
```

Das testen wir jetzt, indem wir die Funktion einmal benutzen. In diesem Beispiel setzen wir 10 Euro auf `RED`.


```r
Roulette(10,RED)
```

```
## Roulettekugel startet
```

```
## Rien ne va plus!
```

```
## Es ist eine 33.
```

```
## Du hast verloren!
```

```
## Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.
```

Die Ausgabe in diesem Beispiel ist schon deutlich schöner/authentischer und beinhaltet alle nötigen Informationen.

In dieser Funktion kann man jedoch nur einmal spielen und muss die Funktion dann erneut starten. Dafür können wir eine neue Funktion schreiben, die die alte Funktion dahingehend erweitert, als dass man mehrere Runden auf einmal spielen kann. Das wird im zweiten Abschnitt erläutert.

</details>

<details><summary> Abschnitt 2 anzeigen </summary>

Für das Umsetzen einer Roulette-Funktion mit variabler Rundenzahl müssen wir einige Anpassungen und Erweiterungen an der Funktion in Abschnitt 1 vornehmen. Übernehmen können wir wiederum die Zufallsziehung und die Gewinnberechnung aus den vorherigen Aufgaben. Wir wissen auch schon, dass wir drei Variablen haben werden: `y` = Einsatz, `z` = Wette und `o` = Anzahl der Runden. Die Funktion nennen wir `Roulette_Schleife`. Das sieht dann vorerst folgendermaßen aus:


```r
Roulette_Schleife <- function(y, z, o) {
  x <- sample(0:36, 1)
  Gewinn <- if (is.element(x, z)) {
    if (identical(z, RED) | identical(z, BLACK) |
        identical(z, ODD) | identical(z, EVEN)) {
      y
    } else if (identical(z, firstThird) |
        identical(z, secondThird) |
        identical(z, lastThird)) {
      y * 2
    } else {
      y * 35
    }
  } else {
  -y
  }
}
```

Jetzt müssen wir uns überlegen, wie wir Zufallsziehung und Gewinnberechnung wiederholt durchführen können bis eine bestimmte Anzahl an Runden gespielt wurde. Wir wissen, dass die Variable `o` angibt, wie viele Runden gespielt werden sollen. Wir erstellen also eine weitere Variable `Durchgaenge`, die die gespielten Runden zählen soll. Das Vorgehen dabei sollte bereits aus den vorherigen Aufgaben bekannt sein. Mithilfe dieser beiden Variablen `o` und `Durchgaenge` können wir nun eine Bedingung erstellen, sodass gespielt wird bis `o == Durchgaenge` gilt. 

Dafür verwenden wir eine neue Funktion: die `repeat`-Funktion. Diese Funktion führt alle ihre Operationen durch, bis die Bedingung (in unserem Fall `o == Durchgaenge`) erfüllt ist. Anders als bei bereits bekannten Funktionen schreibt man die Bedingung hier an das Ende der Funktion. Und zwar ist die `repeat`-Funktion folgendermaßen aufgebaut: `repeat {Operation 1 ENTER Operation 2 ENTER etc. ENTER if (o == Durchgaenge) break}`. Das sieht dann bei uns folgendermaßen aus:


```r
Roulette_Schleife <- function (y, z, o) {
  Durchgaenge <- 0
  repeat {
    Durchgaenge <- Durchgaenge + 1
    x <- sample (0:36, 1)
    Gewinn <- if (is.element(x, z)) {
      if (identical(z, RED) | identical(z, BLACK) |
          identical(z, ODD) | identical(z, EVEN)) {
        y
      } else if (identical(z, firstThird) |
          identical(z, secondThird) |
          identical(z, lastThird)) {
        y * 2
      } else {
        y * 35
      }
    } else {
      -y
    }
  if(Durchgaenge == o) break
  }
}
```

Ebenso wie bei der Funktion im ersten Abschnitt fehlt nun eine Ausgabe mit den wichtigen Informationen/Ergebnissen. Dazu können wir unsere Funktion nun um die Pausen und Nachrichten aus dem ersten Abschnitt erweitern.


```r
Roulette_Schleife <- function (y, z, o) {
  Durchgaenge <- 0
  repeat {
    Durchgaenge <- Durchgaenge + 1
    x <- sample (0:36, 1)
    Gewinn <- if (is.element(x, z)) {
      if (identical(z, RED) | identical(z, BLACK) |
          identical(z, ODD) | identical(z, EVEN)) {
        y
      } else if (identical(z, firstThird) |
          identical(z, secondThird) |
          identical(z, lastThird)) {
        y * 2
      } else {
        y * 35
      }
    } else {
      -y
    }
    message ("Roulettekugel startet")
    Sys.sleep (2.0)
    message ("Rien ne va plus!")
    Sys.sleep (2.0)
    message ("Es ist eine ", x, ".")
    Sys.sleep (2.0)
    if (is.element (x, z)) {
      message ("Du hast gewonnen!")
      Sys.sleep (2.0)
      message ("Dein Gewinn beträgt ", Gewinn, " Euro." )
      Sys.sleep (1.0)
    } else {
      message ("Du hast verloren!")
      Sys.sleep (2.0)
      message ("Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.")
      Sys.sleep (1.0)
    }
  if(Durchgaenge == o) break
  }
}
```

Jetzt ist die Ausgabe schon um einiges schöner, doch einige relevante Informationen fehlen noch. In dieser Funktion besteht nämlich die Möglichkeit, mehrere Runden auf einmal zu spielen. Damit kann man noch zusätzlich Information zur aktuellen Runde und zum aktuellen Gesamtgewinn ausgeben.

Die Ausgabe des Gesamtgewinns gestaltet sich jedoch nicht so leicht wie die Rundenzahl, denn den Gesamtgewinn muss man jede Runde aufs Neue updaten. Das Prinzip für solche Operationen wurde bereits in einer vorherigen Aufgabe beschrieben. Bevor die Schleife beginnt erstellt man ein Objekt `Gesamtgewinn` beginnend mit der Null. In der Schleife nutzt man dann dieses Objekt und überschreibt diesen Wert jede Runde aufs Neue, indem man immer wieder den `Gewinn` aus der gerade laufenden Runde addiert. [Achtung: Die Nachricht zum Gesamtgewinn muss nach dieser erneuten Gesamtgewinn-Berechnung erfolgen, ansonsten gibt man jeweils den Gesamtgewinn nach der vorherigen Runde an.]

Nachdem man diese beiden Dinge impliziert hat, sieht die Funktion folgendermaßen aus:


```r
Roulette_Schleife <- function (y, z, o) {
  Durchgaenge <- 0
  Gesamtgewinn <- 0
  repeat {
    Durchgaenge <- Durchgaenge + 1
    message ("Runde ", Durchgaenge, "!")
    x <- sample (0:36, 1)
    Gewinn <- if (is.element(x, z)) {
      if (identical(z, RED) | identical(z, BLACK) |
          identical(z, ODD) | identical(z, EVEN)) {
        y
      } else if (identical(z, firstThird) |
          identical(z, secondThird) |
          identical(z, lastThird)) {
        y * 2
      } else {
        y * 35
      }
    } else {
      -y
    }
    Gesamtgewinn <- Gesamtgewinn + Gewinn
    message ("Roulettekugel startet")
    Sys.sleep (2.0)
    message ("Rien ne va plus!")
    Sys.sleep (2.0)
    message ("Es ist eine ", x, ".")
    Sys.sleep (2.0)
    if (is.element (x, z)) {
      message ("Du hast gewonnen!")
      Sys.sleep (2.0)
      message ("Dein Gewinn beträgt ", Gewinn, " Euro." )
      Sys.sleep (1.0)
      message ("Damit liegt dein Gesamtgewinn bisher bei ", Gesamtgewinn, " Euro.")
      Sys.sleep (1.0)
    } else {
      message ("Du hast verloren!")
      Sys.sleep (2.0)
      message ("Damit liegt dein Gesamtgewinn bisher bei ", Gesamtgewinn, " Euro.")
      Sys.sleep (1.0)
      message ("Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.")
      Sys.sleep (1.0)
    }
  if(Durchgaenge == o) break
  }
}
```

Insgesamt funktioniert die Funktion, jedoch endet das Spiel nun ganz abrupt ohne irgendeine abschließende Nachricht. Aus diesem Grund fügen wir nun noch mehrere Nachrichten ein:

- Eine Nachricht, dass die `o` Runden nun gespielt sind.
- Eine Nachricht, die Einsatz, Wette und Rundenzahl noch einmal zusammenfasst und den daraus folgenden Gesamtgewinn beinhaltet.
- Eine Nachricht, die vom Gesamtgewinn abhängt. (Ob Geld gewonnen oder verloren wurde oder ob am Ende bei Null rauskam, soll durch verschiedene Nachrichten angezeigt werden.)

Das kann dann folgendermaßen aussehen:


```r
Roulette_Schleife <- function (y, z, o) {
  Durchgaenge <- 0
  Gesamtgewinn <- 0
  repeat {
    Durchgaenge <- Durchgaenge + 1
    message ("Runde ", Durchgaenge, "!")
    x <- sample (0:36, 1)
    Gewinn <- if (is.element(x, z)) {
      if (identical(z, RED) | identical(z, BLACK) |
          identical(z, ODD) | identical(z, EVEN)) {
        y
      } else if (identical(z, firstThird) |
          identical(z, secondThird) |
          identical(z, lastThird)) {
        y * 2
      } else {
        y * 35
      }
    } else {
      -y
    }
    Gesamtgewinn <- Gesamtgewinn + Gewinn
    message ("Roulettekugel startet")
    Sys.sleep (2.0)
    message ("Rien ne va plus!")
    Sys.sleep (2.0)
    message ("Es ist eine ", x, ".")
    Sys.sleep (2.0)
    if (is.element (x, z)) {
      message ("Du hast gewonnen!")
      Sys.sleep (2.0)
      message ("Dein Gewinn beträgt ", Gewinn, " Euro." )
      Sys.sleep (1.0)
      message ("Damit liegt dein Gesamtgewinn bisher bei ", Gesamtgewinn, " Euro.")
      Sys.sleep (1.0)
    } else {
      message ("Du hast verloren!")
      Sys.sleep (2.0)
      message ("Damit liegt dein Gesamtgewinn bisher bei ", Gesamtgewinn, " Euro.")
      Sys.sleep (1.0)
      message ("Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.")
      Sys.sleep (1.0)
    }
  if(Durchgaenge == o) break
  }
  message ("Deine ", Durchgaenge, " Runden sind durch.")
  Sys.sleep (3.0)
  message ("Du hast heute in ", Durchgaenge, " Spielrunden jeweils mit einem Einsatz von ", y, " Euro auf ", z, " einen Gesamtgewinn von ", Gesamtgewinn, " Euro erzielt!")
  Sys.sleep (3.0)
  if (Gesamtgewinn > 0) {
    message("Herzlichen Glueckwunsch!")
  } else if (Gesamtgewinn == 0) {
    message("Sie haben heute nichts gewonnen. Wollen Sie wirklich schon gehen?")
  } else {
    message("Schade. Aber seien Sie nicht traurig. Das nächste Mal steht das Glueck wieder auf Ihrer Seite!")
  }
}
```

Hier seht ihr jetzt zwei Beispiele:

- Ein Mal wurden in 3 Runden jeweils 5 Euro auf BLACK gesetzt.
- Ein Mal wurden in 4 Runden jeweils 100 Euro auf ODD gesetzt.


```r
Roulette_Schleife(5, BLACK, 3)
```

```
## Runde 1!
```

```
## Roulettekugel startet
```

```
## Rien ne va plus!
```

```
## Es ist eine 23.
```

```
## Du hast verloren!
```

```
## Damit liegt dein Gesamtgewinn bisher bei -5 Euro.
```

```
## Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.
```

```
## Runde 2!
```

```
## Roulettekugel startet
```

```
## Rien ne va plus!
```

```
## Es ist eine 5.
```

```
## Du hast verloren!
```

```
## Damit liegt dein Gesamtgewinn bisher bei -10 Euro.
```

```
## Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.
```

```
## Runde 3!
```

```
## Roulettekugel startet
```

```
## Rien ne va plus!
```

```
## Es ist eine 26.
```

```
## Du hast gewonnen!
```

```
## Dein Gewinn beträgt 5 Euro.
```

```
## Damit liegt dein Gesamtgewinn bisher bei -5 Euro.
```

```
## Deine 3 Runden sind durch.
```

```
## Du hast heute in 3 Spielrunden jeweils mit einem Einsatz von 5 Euro auf 24681011131517202224262829313335 einen Gesamtgewinn von -5 Euro erzielt!
```

```
## Schade. Aber seien Sie nicht traurig. Das nächste Mal steht das Glueck wieder auf Ihrer Seite!
```

```r
Roulette_Schleife(100, ODD, 4)
```

```
## Runde 1!
```

```
## Roulettekugel startet
```

```
## Rien ne va plus!
```

```
## Es ist eine 2.
```

```
## Du hast verloren!
```

```
## Damit liegt dein Gesamtgewinn bisher bei -100 Euro.
```

```
## Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.
```

```
## Runde 2!
```

```
## Roulettekugel startet
```

```
## Rien ne va plus!
```

```
## Es ist eine 23.
```

```
## Du hast gewonnen!
```

```
## Dein Gewinn beträgt 100 Euro.
```

```
## Damit liegt dein Gesamtgewinn bisher bei 0 Euro.
```

```
## Runde 3!
```

```
## Roulettekugel startet
```

```
## Rien ne va plus!
```

```
## Es ist eine 26.
```

```
## Du hast verloren!
```

```
## Damit liegt dein Gesamtgewinn bisher bei -100 Euro.
```

```
## Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.
```

```
## Runde 4!
```

```
## Roulettekugel startet
```

```
## Rien ne va plus!
```

```
## Es ist eine 7.
```

```
## Du hast gewonnen!
```

```
## Dein Gewinn beträgt 100 Euro.
```

```
## Damit liegt dein Gesamtgewinn bisher bei 0 Euro.
```

```
## Deine 4 Runden sind durch.
```

```
## Du hast heute in 4 Spielrunden jeweils mit einem Einsatz von 100 Euro auf 1357911131517192123252729313335 einen Gesamtgewinn von 0 Euro erzielt!
```

```
## Sie haben heute nichts gewonnen. Wollen Sie wirklich schon gehen?
```

</details>

