---
title: "Loops und Funktionen"
type: post
date: '2021-03-30'
slug: loops-und-funktionen
categories: ["Statistik II"] 
tags: ["Regression", "Funktionen", "Loops"] 
subtitle: ''
summary: ''
authors: [irmer, schueller, wallot]
weight: 11
lastmod: '2024-02-05'
featured: no
banner:
  image: "/header/sprinkled_lollipops.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1457161)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-ii/loops-und-funktionen
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-ii/loops-und-funktionen.R
  - icon_pack: fas
    icon: pen-to-square
    name: Quizdaten
    url: /lehre/statistik-ii/
output:
  html_document:
    keep_md: true

---



In diesem Block werden wir verschiedene Arten von Loops (Schleifen) kennenlernen und lernen, vertieft mit Funktionen zu arbeiten. Dieses Wissen wollen wir dann nutzen, um nochmals Power- bzw. Simulationsanalysen durchzuführen, welche wir in der [Sitzung zu Simulationsstudien und Poweranalysen](../statistik-i/simulation-poweranalyse) bereits kennengelernt haben. Vorab beschäftigen wir uns noch mit einigen Grundlagen zum Thema logische Abfragen.

# Logische Abfragen und Bedingungen: `if` und `else`

Im Prozess der Datenaufbereitung und -auswertung kommt man häufig an den Punkt, an dem ein bestimmter Befehl nur unter bestimmten Bedingungen ausgeführt werden soll, oder in dem abhängig von einer Bedingung unterschiedliche Aktionen ausgeführt werden sollen. Dabei bezieht sich die Bedingung auf einen Wert in einer bestimmten Variable, der sich zwischen den Versuchspersonen unterscheidet. Dafür können wir sogenannte *Wenn-Dann-Bedingungen*, oder auch *if-Abfragen* nutzen, in denen wir definieren, unter welchen Bedingungen ein folgender Befehl ausgeführt werden soll.
>Beispiel: In einer neuen Variable *Med* wollen wir für alle Versuchspersonen eine 1 vergeben, die in der Variable "Dosis" einen gültigen Wert haben, und eine 0 vergeben für alle Personen, die in der Variable "Dosis" ein NA haben. 

Im letzten Semester hatten wir das über die Bedingungen in eckigen Klammern angewandt auf einen `data.frame` erreicht. `if` bietet eine Alternative hierzu.

## if-Abfragen 
### Einfache if-Abfrage

Wie in eigentlich allen Programmiersprachen werden *Wenn-Dann-Bedingungen* auch in `R` mit dem Befehl `if` erzeugt. Dabei folgt auf ein `if` in runden Klammern die Bedingung, die entweder wahr (`TRUE`) oder falsch (`FALSE`) sein kann. Auf die Bedingung folgt die Konsequenz. Ist die Konsequenz nur eine Zeile lang, kann sie direkt hinter der runden Klammer stehen. Geht sie über mehrere Zeilen, müssen geschwungene Klammern `{...}` genutzt werden, was die ganze Sache auch übersichtlicher macht!

Die Konsequenz wird nur ausgeführt, wenn die Bedingung das Ergebnis `TRUE` erbringt. Zum Beispiel könnten wir für eine Variable `a` testen, ob diese einen bestimmten Wert enthält und daraus eine Konsequenz ziehen. 


```r
a <- 3 #Zunächst definieren wir eine Variable
# mehrere Zeilen
if (a == 3) {
  print("Ja, die Variable a enthält den Wert 3")
}
```

```
## [1] "Ja, die Variable a enthält den Wert 3"
```

```r
# eine Zeile 
if (a == 3) print("Ja, die Variable a enthält den Wert 3")
```

```
## [1] "Ja, die Variable a enthält den Wert 3"
```

Für das Verständnis solcher Abfragen ist es hilfreich, die verschiedenen Schritte der Syntax einzeln zu betrachten. Das gilt auch für die restlichen Themen dieses Blocks. In `R`-Studio können Sie einzelne Abschnitte des Codes markieren und ausführen, um zu testen, was diese beinhalten. Füren Sie Ihren Code immer in kleinen Schnipseln aus, wenn Sie verstehen wollen, was passiert.
Hier wird im ersten Schritt die Bedingung evaluiert: 


```r
(a == 3)
```

```
## [1] TRUE
```

In diesem Fall stimmt die logische Abfrage (`a` enthält tatsächlich den Wert 3), und wir erhalten in der Konsole den Output `TRUE`. Deshalb wird der danach definierte `print`-Befehl ausgeführt.

Wenn jedoch `a` einen anderen Wert enthält, trifft die Bedingung nicht zu (`FALSE`) und der folgende Befehl wird deshalb nicht ausgeführt. 


```r
a <- 5
if (a == 3) {
  print("Ja, die Variable a enthält den Wert 3")
}
```

Wenn Sie diesen Code wieder Schritt für Schritt ausführen (z.b. lediglich die Abfrage in den runden Klammern), können Sie sich so die Zusammenhänge innerhalb der if-Abfrage verdeutlichen.  

### if-Abfrage mit mehreren Möglichkeiten

Oft haben wir aber mehrere Argumente, die untersucht werden können. Bspw. können wir testen, ob ein Wert sich in einer Liste wiederfindet. Wenn wir beispielsweise herausfinden wollen, ob die Person, die in der Variable `person` gespeichert ist, ein Hauptcharakter aus der Serie *Friends* ist, können wir dies mit dem folgenden Befehl tun:


```r
person = "Monica"
if (person %in%  c("Monica", "Rachel", "Chandler",  "Phoebe", "Ross", "Joey")) {
  print("Yes, this is a character from Friends.")
}
```

```
## [1] "Yes, this is a character from Friends."
```

Hier erhalten wir die Antwort, ja, Monica ist eine Figur aus der Serie. Der Ausdruck `%in%` steht sinngemäß für "ist ein Element aus der folgenden Auswahl".

Wenn wir die gleiche Abfrage auf eine andere Person anwenden, trifft die Bedingung nicht zu, und der Befehl wird nicht ausgeführt.  

```r
person = c("Marcus")
if (person %in%  c("Monica", "Rachel", "Chandler",  "Phoebe", "Ross", "Joey")) {
  print("Yes, this is a character from Friends.")
}
```

Genauso könnten wir aber auch eine Liste von Personen haben und uns entweder fragen, ob mindestens eine Person aus dieser Liste bei "Friends" mitgewirkt hat, oder ob alle Personen dort mitgewirkt haben. Dies geht mit `any` oder `all`:


```r
persons = c("Monica", "Marcus")
if (any(persons %in%  c("Monica", "Rachel", "Chandler",  "Phoebe", "Ross", "Joey"))) {
  print("Yes, at least one of them is a character from Friends.")
}
```

```
## [1] "Yes, at least one of them is a character from Friends."
```

```r
if (all(persons %in%  c("Monica", "Rachel", "Chandler",  "Phoebe", "Ross", "Joey"))) {
  print("Yes, at all of them are a character from Friends.")
}
```

An diesem Beispiel wird der Unterschied der beiden Befehle deutlich. Um das Ganze nochmals zu untermauern:


```r
# mindestens 1 ist TRUE
any(persons %in%  c("Monica", "Rachel", "Chandler",  "Phoebe", "Ross", "Joey")) 
```

```
## [1] TRUE
```

```r
# alle 1 sind TRUE
all(persons %in%  c("Monica", "Rachel", "Chandler",  "Phoebe", "Ross", "Joey"))
```

```
## [1] FALSE
```

Mit diesen beiden Befehlen können wir leicht prüfen, ob alle Elemente oder mindestens einer eine Eigenschaft erfüllt. 

### Abgleich mit einem Datum

Es sind beispielsweise auch logische Abfragen mit Zeitpunkten und Daten möglich. Zum Beispiel können wir mit dem Befehl `weekdays(Sys.Date())` ermitteln, welcher Wochentag gerade ist, und dann abgleichen, ob Freitag ist. Wenn Sie diesen Befehl selbst testen, achten Sie darauf, ob nach der Voreinstellung Ihres Rechners der aktuelle Wochentag auf Englisch oder Deutsch ausgegeben wird. Das finden Sie heraus, indem Sie nur den kleinen Codeabschnitt `weekdays(Sys.Date())` ausführen.



```r
if (weekdays(Sys.Date()) == "Friday") {
  print("Fast Wochenende!")
}
```


### Verknüpfung logischer Abfragen 
Wie im letzten Semester bereits besprochen, können logische Bedingungen mit `&` (logisches "und") und `|` (logisches "oder") verknüpft werden. Wenn die gesamte logische Abfrage als Ergebnis `TRUE` zurückgibt, wird die `R`-Syntax in den geschwungenen Klammern ausgeführt; wenn es `FALSE` ergibt, passiert nichts. Zum Beispiel könnten wir so testen, ob *entweder* Samstag *oder* Sonntag ist und herausfinden, ob wir uns freuen dürfen. 


```r
if (weekdays(Sys.Date()) == "Saturday" | weekdays(Sys.Date()) == "Sunday") {
  print("Hoch die Hände, Wochenende!")
}
```

Durch die logische Verknüpfung mit `|` (logisches "oder") wird die gesamte Abfrage wahr, wenn entweder der erste oder der zweite Teil zutrifft (in Worten "ist heute entweder Samstag **oder** Sonntag?"). Hätten wir an dieser Stelle stattdessen eine Verknüpfung mit `&` (logisches "und") gewählt, könnte die Bedingung "ist heute Samstag **und** Sonntag?" nicht zutreffen, würde also immer `FALSE` zurückgeben. An anderer Stelle ist das `&` aber notwendig, wenn mehrere Bedingungen erfüllt sein sollen. 

Bei der Verknüpfung dieser logischen Abfragen muss auf Klammersetzung geachtet werden, wenn die Verknüpfung komplizierter wird. Beispiel: "Ist heute (Samstag **oder** Sonntag) **und** scheint die Sonne?". Als Übung können Sie versuchen diese logische Abfrage mit fiktiven Variablen in Code auszudrücken.

## Abgleich mit mehreren Alternativen: if-else-Abfragen

Häufig wollen wir nicht nur konditional einen Befehl ausführen, oder nicht ausführen, sondern möchten einen anderen Befehl angeben, der ausgeführt wird, wenn die Bedingung nicht zutrifft. Um zwischen zwei alternativen Befehlen auszuwählen, ergänzen wir das `else`. Der Befehl nach dem `else` kommt zum Tragen, wenn die Bedingung *nicht* zutrifft. Dies lässt sich fast wörtlich lesen "If the condition is true, then do one thing. Otherwise (else), do the other thing."


```r
# mehrere Zeilen
if (weekdays(Sys.Date()) == "Saturday" | weekdays(Sys.Date()) == "Sunday") {
  print("Hoch die Hände, Wochenende!")
}else{
  print("Nur noch wenige Tage bis zum ersehnten Wochenende!")
}
```

```
## [1] "Nur noch wenige Tage bis zum ersehnten Wochenende!"
```

```r
# eine enorm lange Zeile
if (weekdays(Sys.Date()) == "Saturday" | weekdays(Sys.Date()) == "Sunday") print("Hoch die Hände, Wochenende!") else print("Nur noch wenige Tage bis zum ersehnten Wochenende!")
```

```
## [1] "Nur noch wenige Tage bis zum ersehnten Wochenende!"
```

Bei Code über mehrere Zeilen ist es wichtig, die geschweiften Klammern korrekt zu setzen. Nach der Bedingungsabfrage öffnen sich geschweifte Klammern, die den ersten konditionalen Befehl einschließen. Das `else` folgt darauf. Danach wird der alternative Befehl wieder in geschweiften Klammern eingefasst. Der `else`-Befehl muss in der gleichen Zeile stehen wie die geschlossene geschweifte Klammer. Der Beginn der geschweiften Klammern kann auch in die nächste Zeile verschoben werden:


```r
if (weekdays(Sys.Date()) == "Saturday" | weekdays(Sys.Date()) == "Sunday") 
{
  print("Hoch die Hände, Wochenende!")
}else
{
  print("Nur noch wenige Tage bis zum ersehnten Wochenende!")
}
```

```
## [1] "Nur noch wenige Tage bis zum ersehnten Wochenende!"
```

Das gilt sowohl für `if`, als auch für `else`. Die einzige Bedingung ist, dass `}else` eine Zeile ergibt, damit `R` weiß, auf welches `if` sich das `else` bezieht!

### `else if`-Bedingungen

Häufig werden mehrere Abfragen ineinander geschachtelt, sodass die Ausdrücke schnell sehr kompliziert werden können. Falls in mehreren Schritten verschiedene Bedingungen abgefragt werden, und verschiedene Konsequenzen folgen sollen, kann auch das `else if` verwendet werden. Hierbei werden verschiedene Möglichkeiten abgefragt, für die verschiedene Befehle ausgeführt werden sollen. Wenn die erste Bedingung nicht zutrifft, wird die zweite Bedingung (nach dem `else if`) geprüft, wenn diese auch nicht zutrifft, wird das nächste `else if` geprüft. Der Befehl nach dem `else` wird dann nur ausgeführt, wenn keine der vorherigen Bedingungen zutrifft. 

![](/lehre/statistik-ii//post/date.jpg){width=70%}

Hier sehen Sie ein Beispiel für eine if-else-Abfrage, die Sie jeden Morgen nutzen können, um herauszufinden, wie Sie sich heute fühlen sollten. 


```r
if (weekdays(Sys.Date()) %in% c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')) {
  if (weekdays(Sys.time()) == 'Monday') {
    print('Zurück ins Bett...')
    } else if (weekdays(Sys.time()) == 'Wednesday') { 
    print('Wuhu, es ist Mitte der Woche!')
      } else if (weekdays(Sys.time()) == 'Friday') { 
    print('Yeah, das Wochenende steht bevor!')
        } else {
    print('Es ist irgendein anderer Tag.')
        }
  } else {
  print("Hoch die Hände, Wochenende!")
}
```

```
## [1] "Hoch die Hände, Wochenende!"
```

Wir versuchen nachzuvollziehen, was in dieser verschachtelten `if-else-Abfrage` passiert. Zunächst wird geprüft, ob es sich heute um einen Wochentag handelt: 


```r
if (weekdays(Sys.Date()) %in% c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')) {
```

Wenn dem so ist, wird der nächste Block ausgeführt:


```r
if (weekdays(Sys.time()) == 'Monday') {
    print('Zurück ins Bett...')
    } else if (weekdays(Sys.time()) == 'Wednesday') { 
    print('Wuhu, es ist Mitte der Woche!')
      } else if (weekdays(Sys.time()) == 'Friday') { 
    print('Yeah, das Wochenende steht bevor!')
        } else {
    print('Es ist irgendein anderer Tag.')
        }
```

Dieser fragt ab, ob heute Montag ist (`if (weekdays(Sys.time()) == 'Monday') {`), falls dem nicht so ist, wird geprüft ob Mittwoch ist (` } else if (weekdays(Sys.time()) == 'Wednesday') { `), wenn dem wiederum nicht so ist, dann wird geprüft ob Freitag ist (` } else if (weekdays(Sys.time()) == 'Friday') { `) und falls dem auch nicht so ist, dann wird `else` ausgeführt.

Ist heute kein Wochentag, dann wird direkt die `else` Bedingung für die erste `if`-Abfrage ausgedruckt, nämlich 


```r
  } else {
  print("Hoch die Hände, Wochenende!")
}
```

Dieses Spiel der Verschachtelung lässt sich beliebig erweitern.

Natürlich sind Wenn-Dann-Abfragen eigentlich hauptsächlich dann nützlich, wenn der Code für verschiedene Daten, Objekte oder Funktionen mehrfach genutzt werden soll und man nicht in jedem Einzelfall schon vorher weiß, welche Inhalte die Objekte haben, mit denen man arbeitet. Ein einfaches Beispiel mit einer zufällig gezogenen Zahl könnte so aussehen:


```r
x <- sample(1:10, 1)
if (x > 5) {
  y <- 1
} else {
  y <- 0
}
x
```

```
## [1] 6
```

```r
y
```

```
## [1] 1
```

Wenn Sie diesen Code mehrfach ausführen, bekommen Sie immer wieder unterschiedliche Paare an `x` und `y`. Auch der erste Versuch muss nicht mit den hier auf `PandaR` zu findenden Ergebnissen übereinstimmen, da wir keinen Seed verwenden. Probieren Sie dies gerne aus!

### Funktion `ifelse`

Wenn nur eine Bedingung abgefragt werden soll, und je nach Ergebnis einer von zwei Befehlen folgen soll, kann der Code abgekürzt werden. Für einzelne Ereignisse kann in `R` die Notation mithilfe der `ifelse`-Funktion verwendet werden. Diese ist (anders als die `if-Abfragen`) eine klassische Funktion mit Argumenten. Die Funktion nimmt drei Argumente entgegen:

* `test`: die Bedingung
* `yes`: was getan werden soll, wenn die Bedingung zutrifft
* `no`: was getan werden soll, wenn die Bedingung nicht zutrifft
  

```r
ifelse(test = weekdays(Sys.Date()) == 'Friday', yes = 'Yeah, das Wochenende steht bevor!', no = 'Es ist irgendein anderer Tag...')
```

```
## [1] "Es ist irgendein anderer Tag..."
```

So wird die gleiche `if-else-Abfrage` verkürzt dargestellt. Gerade für komplexere Abfragen kann aber nicht immer diese verkürzte Form gewählt werden. Die längere Version ist immer dann von Vorteil, wenn der auszuführende `R`-Code mehrere Zeilen lang ist oder z.B. weitere Bedingungen enthält. Auch lässt er sich oft übersichtlicher gestalten.

## Loops (Schleifen)

Beim Programmieren kommt es häufig vor, dass der gleiche Befehl mehrfach angewandt werden muss. Loops (oder Schleifen) bieten die Möglichkeit, den gleichen `R`-Code mehrmals anzuwenden, ohne ihn wiederholt schreiben zu müssen. 

> Wichtiges Grundprinzip des Programmierens: DRY = Don't Repeat Yourself (Hunt & Thomas, "The Pragmatic Programmer")

Gerade in Kombination mit `if` und `else` kann man so sehr kurze, leserliche Skripte verfassen und potentielle Fehler, die sich in sehr lange Skripte gerne einschleichen, umgehen. In `R` werden drei Arten von Loops unterschieden: `for`-Loops, `while`-Loops und `repeat`-Loops.

### `for`-Loops

In `for`-Loops wird ein Abschnitt eines R-Codes für jedes Element in einem vorab festgelegten Objekt durchgeführt. Mit dem `for`-Loop wird ein Befehl für jedes Element dieses Objekts bzw. Vektors durchgeführt. Das funktoiniert über den Befehl `for (i in vekt) {}`. Das `i` ist hierbei ein willkürlicher Platzhalter für die Elemente im Vektor `vekt`, über die dann iteriert wird. `vekt` muss vorher definiert sein (somit ist der Name auch "willkürlich", wir müssen ihn jedoch vorher schon als Objekt hinterlegt haben) und kann anstelle eines Vektors auch eine Liste enthalten (dann würde über eine Liste iteriert werden). `i` nimmt nacheinander alle vorhandenen Werte in `vekt` an und durchläuft mit jedem dieser Elemente die Befehle in den geschweiften Klammern. 

Dies lässt sich anschaulich darstellen, wenn der Befehl, der für jedes Element im Vektor ausgeführt wird, die `print`-Funktion ist. `i` wird nacheinander als jedes der drei Elemente (hier Wörter/Sätze) des Vektors definiert, und dann durch `print(i)` in die Konsole geschrieben. 


```r
vekt <- c("Hallo!", "Viel Spaß im R Praktikum.", "Viel Erfolg für das weitere Semester.")
for (i in vekt) {
  print(i)
}
```

```
## [1] "Hallo!"
## [1] "Viel Spaß im R Praktikum."
## [1] "Viel Erfolg für das weitere Semester."
```

Es ist für den `for`-Loop nötig, vorher zu wissen, für welche Fälle ein Skript durchgeführt werden muss. In diesem Beispiel sind die Fälle die drei Elemente des Vektors `vekt`.

*Anwendungsbeispiel:* Loops sind zum Beispiel nützlich für das Rekodieren von Items. Der `mdbf` Datensatz enthält 98 Beobachtungen in 12 Variablen, allesamt Items des **M**ehr**d**imensionalen **B**efindlichkeits**f**ragebogens. In diesem Fragebogen werden Adjektive zur Beschreibung der aktuellen Stimmung genutzt um die drei Dimensionen der Stimmung - Gut vs. Schlecht, Wach vs. Müde und Ruhig vs. Unruhig - zu erheben. Dafür laden wir zunächst den mdbdf-Datensatz von der Pandar-Website, und schauen uns die ersten Zeilen an.


```r
load(url("https://pandar.netlify.app/post/mdbf.rda"))
head(mdbf)
```


Variable | Adjektiv | Richtung | Dimension 
-------- | -------- | -------- | --------- 
`stim1` | zufrieden | positiv | Gut vs. Schlecht
`stim2` | ausgeruht | positiv | Wach vs. Müde
`stim3` | ruhelos | negativ | Ruhig vs. Unruhig
`stim4` | schlecht | negativ | Gut vs. Schlecht
`stim5` | schlapp | negativ | Wach vs. Müde
`stim6` | gelassen | positiv | Ruhig vs. Unruhig
`stim7` | müde | negativ | Wach vs. Müde
`stim8` | gut | positiv | Gut vs. Schlecht
`stim9` | unruhig | negativ | Ruhig vs. Unruhig
`stim10` | munter | positiv | Wach vs. Müde
`stim11` | unwohl | negativ | Gut vs. Schlecht
`stim12` | entspannt | positiv | Ruhig vs. Unruhig

In der Spalte *Dimension* sehen wir, dass die Items 3 verschiedene Dimensionen abbilden: *Gut vs. Schlecht*, *Wach vs. Müde* und *Ruhig vs. Unruhig*. Die Items sind dabei unterschiedlich gepolt - die Adjektive "ausgeruht" und "schlapp" erfasst beide die Dimension *Wach vs. Müde*, jedoch in unterschiedlicher Ausrichtung. Um die drei Skalenwerte berechnen zu können müssen die jeweils "negativen" Adjektive ins Positive umgepolt werden. Hierzu gibt es zum Beispiel folgende zwei Möglichkeiten, die wir bereits aus dem vergangenen Semester kennen. Zum Einen können wir bei den entsprechenden Items die Skalenwerte ersetzen: 


```r
mdbf$stim4_r[mdbf$stim4 == 1] <- 4
mdbf$stim4_r[mdbf$stim4 == 2] <- 3
mdbf$stim4_r[mdbf$stim4 == 3] <- 2
mdbf$stim4_r[mdbf$stim4 == 4] <- 1
```

Oder wir können das Vorgehen verkürzen, indem wir die folgende Berechnungsweise anwenden:


```r
mdbf$stim4_r <- -1 * (mdbf$stim4 - 5)
```

Aber trotz der Verkürzung haben wir nun erst ein einziges Item umcodiert. Mit Hilfe von Loops können wir uns die Arbeit ersparen, diesen Abschnitt für jedes negative Adjektiv schreiben zu müssen. *Wir erinnern uns: Für den `for`-Loop müssen wir wissen, für welche Fälle ein Skript durchgeführt werden muss.* Für die Umcodierung der Items speichern wir also alle negativen Items in einem Vektor `neg` (Häufig werden auch die Spaltennummern verwendet):


```r
# Kopie des Datensatzes erstellen, um Datenverlust vorzubeugen
mdbf_r <- mdbf

# Vektor der negativen Items
neg <- c("stim3", "stim4", "stim5", "stim7", "stim9", "stim11")
```

In `neg` wird kodiert, welche Items negativ formuliert sind, und in die Umcodierung einbezogen werden sollen. Danach wenden wir die oben bereits gezeigte Formel erneut an, hier jedoch nacheinander auf jedes der Elemente, die in `neg` gespeichert sind. Dabei nimmt i nacheinander die Namen der Variablen an stim3, stim4, stim5, stim7,... an. Nun können wir mit `mdbf_r[, i]` (bzw. `mdbf[, i]`) die richtige Spalte im Datensatz anwählen (`mbdf_r[[i]]` geht entsprechend auch, da es sich bei `mdbf_r` um einen `data.frame` handelt), also im ersten Schritt mit `mdbf_r[, "stim3"]` (bzw. `mdbf[, "stim3"]`) die dritte Variable *stim3*, also das dritte Item. Der Platzhalter `i`iteriert also durch die Elemente von `neg`. Damit bei mehrmaligem durchführen des Skriptes nicht immer hin- und herkodiert wird, speichern wir die Berechnung mit Hilfe von `mdbf[, i]` in `mdbf_r[, i]` ab.


```r
for (i in neg) {
  mdbf_r[, i] <- -1 * (mdbf[, i] - 5)
}
```

Zur Prüfung des Erfolges berechnen wir die Korrelation des Items `stim3` im originalen Datensatz und im umcodierten Zustand.  


```r
cor(mdbf[, "stim3"], mdbf_r[, "stim3"])
```

```
## [1] -1
```

Um Ihr Verständnis zu überprüfen, versuchen Sie, in einer neuen Kopie des Datensatzes jetzt stattdessen alle positiven Items umzucodieren!

Zudem können `for`-Loops ineinander geschachtelt werden. Dabei wird für die zweite Iteration häufig `ii` als Platzhalter verwendet. Im Befehl kann dann auf `i` und `ii` Bezug genommen werden. Hier sehen Sie beispielsweie, wie Sie ineinander geschachtelt durch einen Vektor aus Buchstaben und einen Vektor aus Zahlen iterieren. Was passiert, wenn Sie den ersten `print`-Befehl außerhalb des inneren Loops platzieren? Versuchen Sie, den Unterschied nachzuvollziehen. 


```r
Buchstaben <- c("A", "B", "C")
Zahlen <- c(1,2)
for (i in Buchstaben) {
  for (ii in Zahlen) {
    print(i)
    print(ii) 
  }
}
```

```
## [1] "A"
## [1] 1
## [1] "A"
## [1] 2
## [1] "B"
## [1] 1
## [1] "B"
## [1] 2
## [1] "C"
## [1] 1
## [1] "C"
## [1] 2
```

Das `i` und `ii` sind hier willkürlich gewählte Platzhalter. Wir könnten auch jeden anderen Buchstaben (oder Zeichenkombination) wählen. Es bietet sich an, Namen zu vergeben, die sinnvoll für den Sachverhalt sind und es auch bei mehreren Schachtelungen möglich machen, zu erkennen, um was es sich gerade handelt. Für dieses Beispiel würde sich bspw. `for(buchstabe in Buchstaben)` [oder auch: `for(b in Buchstaben)`] und `for(zahl in Zahlen)` [oder auch: `for(z in Zahlen)`] anbieten.

### Weitere Loops

Weitere häufig verwendete Loops sind die `while` und die `repeat`-Loop: In `while`-Loops wird der Code so lange ausgeführt, bis eine vorab definierte Bedingung erfüllt ist. Im Gegensatz zu `for` und `while` wird bei `repeat` zunächst kein explizites Abbruchkriterium definiert. Stattdessen wird `repeat` häufig genutzt, wenn es verschiedene oder veränderliche Abbruchkriterien für den Loop gibt. Diese Kriterien werden bei `repeat` allerdings innerhalb des Loops definiert - in den meisten Fällen wird dazu über `if` mindestens eine Bedingung definiert, unter der die Ausführung abgebrochen werden soll. Eine Loop (auch `for` oder `while`) können mit dem `break`-Befehl beendet werden. Für mehre Informationen zu `while`, `repeat` und `break` siehe [Appendix A](#AppendixA).


*Anmerkung:* Generell sollten Loops in `R` nur genutzt werden, wenn keine vektorbasierte Alternative zur Verfügung steht. Zum Beispiel: um eine Variable zu zentrieren sollte nicht ein Loop genutzt werden, der von jedem Element des Vektors den Mittelwert abzieht (bei Interesse an einem Laufzeitvergleich siehe [Appendix B](#AppendixB). Stattdessen ist `R` in der Lage den Mittelwert direkt von jedem Element des Vektors abzuziehen (elementeweise Anwendung) - diese Umsetzung ist also direkt Vektor-basiert und in `R` (beinahe ausnahmslos) die schnellere und effizientere Variante.

## Funktionen {#function} 

Sie haben bereits gelernt, dass (fast) alle Aktionen, die in `R` ausgeführt werden, sich sogenannte Funktionen zunutze machen. Hier wollen wir noch einen Schritt weiter gehen, und lernen, wie Sie *selbst Funktionen schreiben* können. Funktionen, die in `R` angewendet werden können, sind ebenfalls Objekte. Dadurch können eigene Funktionen wie andere Objekte auch angelegt werden - dazu müssen sie lediglich mit der `function`-Funktion erstellt werden. Im Allgemeinen sieht das wie folgt aus:


```r
eigene_funktion <- function(argument1, argument2, ...) {
  # Durchgeführte Operationen
}
```

Der Name der erstellen Funktion steht hier ganz am Anfang. `function` ist die Funktion, die dafür zuständig ist, neue Funktionen zu definieren. In den runden Klammern dahinter müssen Sie angeben, welche *Argumente* Ihre Funktion annehmen soll. Auf diese Argumente können Sie in der Beschreibung der Operationen zugreifen. In geschweiften Klammern geben Sie als nächstes an, welche Operationen mit den genannten Argumenten durchgeführt werden sollen. Als Argumente können beliebig viele Einstellungen für die Funktion definiert werden, auf die dann in der Funktion Bezug genommen wird. Wichtig ist dabei, dass Funktionen keinen generellen Zugriff auf den Workspace haben, sondern alle Objekte, die sie benötigen, durch die Argumente an sie weitergegeben werden müssen. Auch innerhalb einer Funktion definierte Objekte können nicht außerhalb der Funktion genutzt werden!

### Beispiel Varianzfunktion
In `R` wird mit der `var`-Funktion die Schätzung für die Populationsvarianz $\widehat{\sigma}^2$ und nicht die empirische Varianz $s$ bestimmt. Wir könnten also eine eigene Funktion anlegen, die die empirische Varianz schätzt. Dafür können wir die Formel zur Varianzberechnung einfach in `R`-Code übersetzen:

$$s^2 = \frac{\sum_{i=1}^n(x_i - \bar{x})^2}{n}$$

Als `R`-Code würde wir also zunächst die einzelnen Elemente definieren, und dann nach dem Vorbild der Formel die Varianz berechnen.


```r
x <- mdbf[, 1]
n <- length(x)
s2 <- sum((x - mean(x))^2) / n
s2
```

```
## [1] 0.482299
```

Dieser Code funktioniert allerdings nur für eine einzige Variable mit dem Namen `x` und wir müssten den Code für jede einzelne Anwendung wiederholen. Um das abzukürzen, können wir eine eigene, *wiederverwendbare* Funktion anlegen. Dafür nutzen wir wie oben beschrieben die Funktion `function`. Unsere neue Funktion soll `empVar` heißen, und erhält nur ein einziges Argument `x`. In den geschweiften Klammern definieren wir, wie die Berechnung funktionieren soll.  


```r
empVar <- function(x) {
  n <- length(x)
  s2 <- sum((x - mean(x))^2)/n
}

empVar(mdbf[, 1])
```

Nun erhalten wir jedoch kein Ergebnis, wenn wir diese Funktion auf `empVar(mdbf[, 1])` anwenden. Dafür müssen wir zusätzlich mit `return` definieren, was der *Ausgabewert* der Funktion sein soll. In diesem Fall wird das Ergebnis der Berechnung ausgegeben. Wenn kein `return`-Wert definiert wird, gibt die Funktion bei der Anwendung kein Ergebnis in die Konsole aus. Wir haben auch keinen Zugriff auf das Objekt s2. Eine Funktion ohne `return` wird zwar ausgeführt, man hat aber keinen Zugriff auf das Ergebnis, weil alle innerhalb der Funktion angelegten Objekte entfernt werden, sobald die Durchführung der Funktion abgeschlossen ist. Funktionen sollten also prinzipiell mit `return` Ergebnisse nach außen geben:


```r
empVar <- function(x) {
  n <- length(x)
  s2 <- sum((x - mean(x))^2)/n
  return(s2)
}
```

Diese Funktion kann jetzt auf jede beliebige Variable angewendet werden:


```r
empVar(mdbf[, 1])
```

```
## [1] 0.482299
```

```r
empVar(mdbf[, 2])
```

```
## [1] 0.7213661
```

Das Einzige, was diese Funktion von in `R` implementierten Paketen unterscheidet ist, dass sie explizit im Workspace bzw. Environment angezeigt wird. Dies können Sie mit dem `ls()`-Befehl ausprobieren. Außerdem sehen Sie die Funktion in `R`-Studio oben rechts in dem Fenster, in dem auch die Daten etc. dargestellt werden unter **Functions**.

Weil beim Durchführen von Funktionen als erstes der Workspace nach definierten Funktionen durchsucht wird, sollten Funktionen möglichst einzigartig benannt werden, weil sonst nicht mehr (so leicht) auf die `R`-internen Funktionen zugegriffen werden kann.

Zusätzlich sollte beachtet werden, dass `return` nur ein einziges Argument entgegennimmt: Funktionen in `R` können also nur ein einziges Objekt als Ergebnis liefern. Wenn mehrere Ergebnisse ausgegeben werden sollen, müssen diese vorher innerhalb der Funktion zu einem Objekt (meistens einer Liste) zusammengefasst werden. Eine Liste kann benannt werden, indem zunächst die Namen geschrieben werden und diesen dann via `=` etwas zugeordnet wird:


```r
empVar <- function(x) {
  n <- length(x)
  s2 <- sum((x - mean(x))^2)/n
  out <- list("s2" = s2, "n" = n)
  return(out)
}
empVar(mdbf[, 2])
```

```
## $s2
## [1] 0.7213661
## 
## $n
## [1] 98
```

Funktionen können eine beliebige Anzahl von Argumenten entgegennehmen, aber nur ein einziges Objekt als Ergebnis liefern (wobei dieses Objekt natürlich mehrere Elemente haben kann, bspw. hat eine Vektor ja mehrere Einträge oder eine Liste kann auch aus mehreren Vektoren, Matrizen oder anderem bestehen). Um eine gemeinsame Funktion für beide Formen der Varianz zu haben, könnten wir die Anzahl der Argumente erweitern. 


```r
Vari <- function(x, empirical) {
  n <- length(x)
  if (empirical) {
    s2 <- sum((x - mean(x))^2)/n
  } else {
    s2 <- sum((x - mean(x))^2)/(n-1)
  }
  return(s2)
}
```

Das Argument namens `empirical` kann in dieser Funktion genutzt werden, um zu entscheiden, welche Varianz-Formel angewandt werden soll. In diesem Fall wird also eine Einstellung für `empirical` benötigt, die dann von `if` als `TRUE` oder `FALSE` bewertet werden kann:


```r
Vari(mdbf[, 2], TRUE)
```

```
## [1] 0.7213661
```

```r
Vari(mdbf[, 2], FALSE)
```

```
## [1] 0.7288029
```

Wenn wir die Einstellung vergessen, wird - wie bei allen anderen `R` Funktionen auch - ein Fehler produziert. Probieren Sie dies aus, und beachten Sie den Wortlaut der Fehlermeldung. Jetzt sollten Sie verstehen, was diese aussagt und wie der Fehler behoben werden kann!


```r
Vari(mdbf[, 2])
```


```
## Error in Vari(mdbf[, 2]) : 
##   argument "empirical" is missing, with no default
```

Die Fehlermeldung beinhaltet die Worte *with no default*. Dies impliziert, dass eine Voreinstellung für das Argument gesetzt werden könnte. Dann müssen Nutzer:innen das Argument nicht mehr zwingend angeben. Wenn Voreinstellungen für Argumente festgelegt werden sollen, erreichen wir das, indem in der runden Klammer direkt der default-Wert für ein Argument mit angegeben wird. 


```r
Vari <- function(x, empirical = TRUE) {
  n <- length(x)
  if (empirical) {
    s2 <- sum((x - mean(x))^2)/n
  } else {
    s2 <- sum((x - mean(x))^2)/(n-1)
  }
  return(s2)
}
```


```r
Vari(mdbf[, 2])
```

```
## [1] 0.7213661
```

Solange jetzt nicht explizit etwas bei der Anwendung der Funktion für `empirical` deklariert wird, wird von der Voreinstellung `TRUE` ausgegangen. 

Außerdem gibt es noch Funktionen wie `replicate`, `apply`, `lapply`, `sapply`, etc. die die Grenzen zwischen Schleifen und Funktionen etwas verwaschen. Siehe auch [Appendix A](#AppendixA).



## Anwendung: Simulationsstudien und Poweranalysen

In der Sitzung zu [Simulationsstudien und Poweranalysen](/post/simulation) aus dem vergangenen Semester hatten wir empirisch die Power und den $\alpha$-Fehler des $t$-Tests sowie des Korrelationstest untersucht. Dabei hatten wir `replicate` verwendet. Bspw. hatten wir mit folgendem Code den $p$-Wert des $t$-Tests unter der $H_0$ Hypothese untersucht:


```r
N <- 20
set.seed(1234)
replicate(n = 10, expr = {X <- rnorm(N)
                          Y <- rnorm(N)
                          ttestH0 <- t.test(X, Y, var.equal = TRUE)
                          ttestH0$p.value})
```

```
##  [1] 0.26352442 0.03081077
##  [3] 0.21285027 0.27429670
##  [5] 0.53201656 0.79232864
##  [7] 0.93976306 0.43862992
##  [9] 0.96766599 0.68865560
```

Wenn wir nun genauer hinschauen, dann sehen wir, dass der Block 


```r
{X <- rnorm(N)
 Y <- rnorm(N)
 ttestH0 <- t.test(X, Y, var.equal = TRUE)
 ttestH0$p.value}
```

im Grunde nichts weiter darstellt, als das Innere einer Funktion. `replicate` ist im Grunde nichts anderes als eine bestimmte `for`-Schleife, nämlich eine `for`-Schleife, in welcher das Argument nicht genutzt wird! Wir schreiben das Ganze mal mittels einer Funktion:


```r
mySim <- function(N)
{
  X <- rnorm(N)
  Y <- rnorm(N)
  ttestH0 <- t.test(X, Y, var.equal = TRUE)
  return(ttestH0$p.value)
}
set.seed(1234)
replicate(n = 10, expr = mySim(N = 20))
```

```
##  [1] 0.26352442 0.03081077
##  [3] 0.21285027 0.27429670
##  [5] 0.53201656 0.79232864
##  [7] 0.93976306 0.43862992
##  [9] 0.96766599 0.68865560
```

In der Sitzung zu [Simulationsstudien und Poweranalysen](../statistik-i/simulation-poweranalyse) hatten wir außerdem den empirischen $t$-Wert untersucht. Diesen können wir nun ganz leicht mit aufnehmen.


```r
mySim2 <- function(N)
{
  X <- rnorm(N)
  Y <- rnorm(N)
  ttestH0 <- t.test(X, Y, var.equal = TRUE)
  return(c("p" = ttestH0$p.value, "t" = ttestH0$statistic))
}
set.seed(1234)
replicate(n = 10, expr = mySim2(N = 20))
```

```
##          [,1]        [,2]
## p   0.2635244  0.03081077
## t.t 1.1349024 -2.24295556
##          [,3]       [,4]
## p   0.2128503  0.2742967
## t.t 1.2670437 -1.1092419
##          [,5]      [,6]
## p   0.5320166 0.7923286
## t.t 0.6306927 0.2651479
##          [,7]       [,8]
## p   0.9397631  0.4386299
## t.t 0.0760693 -0.7827414
##            [,9]     [,10]
## p    0.96766599 0.6886556
## t.t -0.04080374 0.4037557
```

Wir sehen, dass die `p`-Werte und die `t`-Werte nun gleichzeitig ausgegeben werden und zwar in zwei Zeilen untereinander, da wir den Output als Vektor gewählt haben! In diesem Semester hatten wir uns bisher mit der Regressionsanalyse beschäftigt. Aus diesem Grund wollen wir an dieser Stelle noch kurz anschneiden, wie eine Simulationsstudie für eine Regression durchgeführt werden könnte. Zunächst brauchen wir dazu Prädiktoren. Mit Hilfe der `rmvnorm` Funktion aus dem `mvtnorm`-Paket lassen sich leicht multivariat-normalverteilte Zufallsvariablen simulieren, deren Mittelwerte und Kovarianz bekannt ist:


```r
S <- matrix(c(1, .7, .7, 2), 2, 2) # Populationskovarianzmatrix
S
```

```
##      [,1] [,2]
## [1,]  1.0  0.7
## [2,]  0.7  2.0
```

```r
# install.packages("mvtnorm")
library(mvtnorm)
set.seed(1234)
X <- rmvnorm(n = 10^3, mean = c(2, 3), sigma = S)
colMeans(X)
```

```
## [1] 1.997926 2.980730
```

```r
cov(X)
```

```
##          [,1]     [,2]
## [1,] 1.046158 0.719314
## [2,] 0.719314 1.871493
```

Für größeres `n` landen wir näher bei den Populationswerten:

$$ \mathbb{E}[X] = \begin{pmatrix} 2 \\ 3 \end{pmatrix},\quad \mathbb{C}ov[X]=\begin{pmatrix} 1 & .7 \\ .7 & 2 \end{pmatrix}.$$

Für eine Regressionsanalyse brauchen wir jetzt nur noch ein Residuum, sowie die $\beta$-Gewichte, um die Variable $Y$ zu definieren. Angenommen wir wollen folgendes Populationsmodell untersuchen:

$$Y_i = 0.3 + 0.5\cdot X_{1i} + 0.3\cdot X_{2i} + \varepsilon_i$$

wobei $\varepsilon_i$ eine Residualstandardabweichung von 1.3 haben soll:


```r
eps <- rnorm(10^3, sd = 1.3)
X1 <- X[,1]
X2 <- X[,2]
Y <- 0.3 + 0.5*X1 + 0.3*X2 + eps
df <- data.frame("X1" = X1, "X2" = X2, "Y" = Y)
```

Dann können wir nun leicht eine Regressionsanalyse durchführen:


```r
reg <- lm(Y ~ 1 + X1 + X2, data = df)
coef(reg) # Koeffizienten abgreifen
```

```
## (Intercept)          X1 
##   0.4480455   0.5145347 
##          X2 
##   0.2532168
```

Wir sehen, dass die Koeffizienten recht nah an den "wahren" Werten liegen. Verpacken wir das Ganze in eine Funktion, so können wir den Bias der Schätzung untersuchen. Der Bias ist die durchschnittliche Abweichung der Schätzung vom wahren Wert. Ein Bias von 0 ist somit erstrebenswert!


```r
myRegSim <- function(N)
{
  S <- matrix(c(1, .7, .7, 2), 2, 2) # Populationskovarianzmatrix
  X <- rmvnorm(n = N, mean = c(2, 3), sigma = S)
  eps <- rnorm(N, sd = 1.3)
  X1 <- X[,1]
  X2 <- X[,2]
  Y <- 0.3 + 0.5*X1 + 0.3*X2 + eps
  df <- data.frame("X1" = X1, "X2" = X2, "Y" = Y)
  reg <- lm(Y ~ 1 + X1 + X2, data = df)
  coef(reg) # Koeffizienten abgreifen
  return(coef(reg))
}
set.seed(1234)
replicate(n = 10, expr = myRegSim(N = 10^3))
```

```
##                  [,1]
## (Intercept) 0.4480455
## X1          0.5145347
## X2          0.2532168
##                  [,2]
## (Intercept) 0.4645526
## X1          0.4229675
## X2          0.3155510
##                  [,3]
## (Intercept) 0.0959823
## X1          0.5794930
## X2          0.3264700
##                  [,4]
## (Intercept) 0.4036081
## X1          0.6167309
## X2          0.2033327
##                  [,5]
## (Intercept) 0.3621404
## X1          0.4935631
## X2          0.2789048
##                  [,6]
## (Intercept) 0.4454766
## X1          0.4068533
## X2          0.3184694
##                  [,7]
## (Intercept) 0.2000509
## X1          0.5341167
## X2          0.3038769
##                  [,8]
## (Intercept) 0.2704179
## X1          0.4260486
## X2          0.3344544
##                  [,9]
## (Intercept) 0.2343473
## X1          0.5119222
## X2          0.3198885
##                 [,10]
## (Intercept) 0.4723725
## X1          0.4416930
## X2          0.3067544
```

Speichern wir das Ganze ab, transponieren es und bilden `colMeans`, so erhalten wir eine Schätzung für die durchschnittliche Schätzung unseres Experiments (das wir insgesamt 10 Mal unter identischen Voraussetzungen durchführen konnten):


```r
set.seed(1234)
mySimErg <- t(replicate(n = 10, expr = myRegSim(N = 10^3)))
colMeans(mySimErg)
```

```
## (Intercept)          X1 
##   0.3396994   0.4947923 
##          X2 
##   0.2960919
```

Selbst bei nur 10 Wiederholungen und einer Stichprobengröße von 1000 ist der Bias schon sehr gering (zum Vergleich, die wahren Werte waren 0.3, 0.5, 0.3). Der Bias wird nun so bestimmt:

$$\hat{\theta} - \theta_0,$$

wobei $\hat{\theta}$ der durchschnittliche Koeffizient und $\theta_0$ der wahre Koeffizient ist. In den Übungen werden wir uns mit diesem Sachverhalt noch etwas genauer beschäftigen und die neuen Erkenntnisse der Regressionsanalyse mit einfachen Simulationen untermauern. Weitere interessante Größen einer Simulationsstudie sind die Power und der $\alpha$-Fehler, sowie der mittlere Standardfehler und der Vergleich zwischen mittlerem Standardfehler ($\bar{SE}(\hat{\theta})$ mittlerer geschätzter Streuung der Schätzungen anhand der Daten) und der tatsächlichen Streuung der Schätzungen ($SD(\hat{\theta})$). Diese Werte können wir untersuchen, indem wir die `summary` auf das Regressionsobjekt anwenden und anschließend wieder mit `coef` die Parameterschätzer `Estimate`, die Standardfehler `Std.Error`, sowie den $t$-Wert und den zugehörigen $p$-Wert bestimmen. Diese Werte sind entscheidend für Signifikanzentscheidungen und somit für Power und $\alpha$-Fehler.

Zum Abschluss noch ein Gedankenexperiment: Wenn wir immer wieder Daten simulieren, dann erhalten wir von Mal zu Mal unterschiedliche Parameterschätzer. Die `Estimates` streuen also. Diese Streuung beschreibt die Unsicherheit, die beim Schätzen in einem "endlichen" Sample entsteht. Sie nennt sich bezogen auf eine Monte-Carlo-Simulationsstudie (die wir gerade durchgeführt hatten) MCSD (für Monte-Carlo-Standardabweichung). Der Standardfehler, den wir mit jedem Mal Schätzen bekommen, soll nun eine Schätzung für diese wahre Streuung der Parameterschätzungen sein. Aus diesem Grund wird in Simulationsstudien häufig der durchschnittliche Standardfehler (MCSE) mit der MCSD verglichen. Eine gute Schätzung des SEs für MCSD ist also entscheidend dafür, dass der statistische Test vertrauenserweckende Ergebnisse liefert!

***

## Appendix A{#AppendixA}

<details><summary><b><code>while</code> und <code>repeat</code>-Loops & weitere Loop-Funktionen</b></summary>

### `while`-Loops

In `while`-Loops wird der Code so lange ausgeführt, bis eine vorab definierte Bedingung erfüllt ist. Ein einfaches Beispiel wäre, so lange einen Münzwurf zu simulieren, bis man 10 mal "Kopf" geworfen hat. Dafür müssen wir zum Einen die Münze als Objekt mit zwei Auswahlmöglichkeiten *Kopf* und *Zahl* anlegen, und ein leeres Objekt, in das wir die Ergebnisse der Münzwürfe speichern können.


```r
# Münze erstellen
coin <- c('Kopf', 'Zahl')

# Leeres Objekt für die Aufzeichnung erstellen
toss <- NULL
```

Als nächstes schreiben wir den eigentlichen Loop. Dieser enthält eine logische Abfrage, die abfragt, ob die Anzahl der Kopf-Würfe unter 10 ist. Führen Sie nacheinander die Codeabschnitte `toss == 'Kopf'`, `sum(toss == 'Kopf')` und `sum(toss == 'Kopf')<10` aus, um zu verstehen, wie sich die logische Abfrage zusammensetzt. (*Hinweis*: den logischen Werten `TRUE` und `FALSE` sind die Zahlen 1 und 0 zugeordet.) 


```r
# Loop
while (sum(toss == 'Kopf')<10) {
  toss <- c(toss, sample(coin, 1))
}

# Würfe ansehen
toss
```

```
##  [1] "Zahl" "Kopf" "Kopf"
##  [4] "Zahl" "Zahl" "Zahl"
##  [7] "Kopf" "Kopf" "Zahl"
## [10] "Kopf" "Kopf" "Kopf"
## [13] "Zahl" "Kopf" "Kopf"
## [16] "Kopf"
```

### `repeat`-Loops 

Im Gegensatz zu `for` und `while` wird bei `repeat` zunächst kein explizites Abbruchkriterium definiert. Stattdessen wird `repeat` häufig genutzt, wenn es verschiedene oder veränderliche Abbruchkriterien für den Loop gibt. Diese Kriterien werden bei `repeat` allerdings innerhalb des Loops definiert - in den meisten Fällen wird dazu über `if` mindestens eine Bedingung definiert, unter der die Ausführung abgebrochen werden soll.

Ein einfaches Beispiel hierfür ist es, eine Fibonacci-Sequenz zu bilden (eine Sequenz in der eine Zahl immer die Summe der vorherigen beiden Zahlen ist):

$$a_n := a_{n-1} + a_{n-2}$$
für $n>1$ und $a_1=a_0=1$.

Wir können nun `repeat` nutzen, um die Sequenz abzubrechen, wenn die letzte Zahl z.B. größer als 1000 ist. An dieser Stelle wissen wir nicht, welches Element das sein wird, bzw. nach wie vielen Schritten dies passiert, wodurch es geschickter ist, innerhalb des Loops das Kriterium zu evaluieren. Wir nutzen hier `n-1`, `n`, und `n+1` als Schritte, da es das 0-te Element in Vektoren in `R` nicht gibt.


```r
fibo <- c(1, 1)

repeat {
  n <- length(fibo)
  fibo[n+1] <- fibo[n] + fibo[n - 1]
  if (fibo[n+1] > 1000) break
}

fibo
```

```
##  [1]    1    1    2    3    5
##  [6]    8   13   21   34   55
## [11]   89  144  233  377  610
## [16]  987 1597
```

Loops können mit `break` unterbrochen werden - das gilt nicht nur für `repeat`, sondern auch für die anderen beiden Formen von Loops. Hier wurde eine `if`-Bedingung in den Loop geschachtelt. In jedem einzelnen Durchlauf des Loops wird geprüft, ob die Bedingung erfüllt ist, und die Durchführung wird beendet (`break`), sobald dies der Fall ist. 

Ergänzen Sie `print(fibo)` vor der `if`-Abfrage, und schauen Sie sich das Ergebnis an. Dies zeigt Ihnen gewissermaßen das "Innenleben" Ihres Loops. Sie sehen so genauer, was in jedem Schritt des Loops passiert, und können oftmals leichter nachvollziehen, wodurch beispielsweise Fehler entstehen. 

### `apply`-Funktionen

Auch `apply` und seine Varianten können genutzt werden, um bspw. einen `for`-Loop auszudrücken. Diese Funktion verkürzt die Schreibweise und kann manchmal auch die Laufzeit verkürzen, insbesondere wenn bspw. das `pbapply`-Paket verwendet wird, welches einfaches Parallelisieren erlaubt. 


```r
A <- data.frame("a" = c(2,3,4), "b" = c(1,1,1))
apply(A, 2, mean) # Mittelwert über Spalten/Variablen
```

```
## a b 
## 3 1
```

```r
colMeans(A)
```

```
## a b 
## 3 1
```

```r
apply(A, 1, mean) # Mittelwert über Zeilen/Personen/Beobachtungen
```

```
## [1] 1.5 2.0 2.5
```

```r
rowMeans(A)
```

```
## [1] 1.5 2.0 2.5
```

```r
apply(A, 2, sd) # Standardabweichung über Spalten/Variable
```

```
## a b 
## 1 0
```

</details>

## Appendix B{#AppendixB}

<details><summary><b>Loops vs. Vektorbasiert</b></summary>

An den folgenden Laufzeiten sehen wir, dass Loops tatsächlich deutlich langsamer sind, als die vektorwertige Alternative.


```r
# simuliere 1000 Beobachtungen und bestimme den Mittelwert 
X <- rnorm(10^3, mean = 1, sd = 2)
m <- mean(X)

t1 <- Sys.time() # speichere die Startzeit
X_c <- X
for(x in X)
{
  X_c[i] <- x - m
}
Sys.time() - t1 # bestimmte die Laufzeit durch aktuelle Zeit minus Startzeit
```

```
## Time difference of 0.01693606 secs
```

```r
t2 <- Sys.time() # speichere die Startzeit
X_c <- X - m
Sys.time() - t2 # bestimmte die Laufzeit durch aktuelle Zeit minus Startzeit
```

```
## Time difference of 0.001479149 secs
```

Loops sind in diesem Beispiel fast um den Faktor 10 langsamer (zumindest, wenn Sie den Code für `10^6` Beobachtungen durchführen, die Maske, die für diese Website genutzt wird, ist deutlich langsamer, weswegen hier auf `10^3` ausgewichen wurde...). Es gibt jedoch viele Anwendungsgebiete, wo Loops das Mittel der Wahl sind!

</details>

***

## R-Skript
Den gesamten `R`-Code, der in dieser Sitzung genutzt wird, können Sie [<i class="fas fa-download"></i> hier herunterladen](../loops-und-funktionen.R).
