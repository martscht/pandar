---
title: "Matrixalgebra" 
type: post
date: '2023-10-31' 
slug: matrixalgebra
categories: ["Statistik I"] 
tags: ["Grundlagen", "Matrix"] 
subtitle: ''
summary: '' 
authors: [irmer] 
weight: 10.5
lastmod: '2024-04-02'
featured: no
banner:
  image: "/header/windmills_but_fancy.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1178076)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/matrixalgebra
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/statistik-i/matrixalgebra.R
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /lehre/statistik-i/matrixalgebra-aufgaben
output:
  html_document:
    keep_md: true
---



<details><summary><b>Kernfragen dieser Lehreinheit</b></summary>

* Wie definiere ich [**Vektoren**](#Vektoren) und wie kann ich mit ihnen [**Rechenoperationen**](#VekRechOp) durchführen?  
* Wie definiere ich [**Matrizen**](#Matrizen) und wie kann ich mit ihnen [**Rechenoperationen**](#MatRechOp) mit ihnen durchführen?
* Wie bestimme ich [**Determinante und Inverse**](#DetInv) einer Matrix?
* Wie nutze ich Matrixoperationen um [**Deskriptivstatistiken**](#Deskriptiv) zu bestimmen?

</details>

***

Bisher haben wir gelernt, dass viele statistische Größen durch Summen, Mittelwerte, Quadrate, Abweichungen und weitere recht einfache Rechenoperationen bestimmt werden können. Diese lassen sich oft noch einfacher durch Matrizen und Vektoren ausdrücken. Vielleicht kennen Sie Matrizen aus der Schule. Falls nicht, ist das gar kein Problem, denn dieser Post wird sich mit Vektoren und Matrizen ausführlicher beschäftigen. Matrixalgebra wird bspw. auch in Eid, et al. (2017) im _Anhang B: Matrixalgebra_ ab Seite 1051 behandelt.

Vektoren kennen wir bereits aus den ersten Datensätzen, die wir kennengelernt haben. Bspw. enthält ein Variablenvektor einer Person einfach nur die Einträge der Variablen aus dem Datensatz dieser spezifischen Person. Matrizen haben wir im Grunde auch schon kennengelernt. Ein Datensatz ist sehr stark verwandt mit einer Matrix. Genauso wie ein Datensatz, besteht auch eine Matrix aus Zeilen und Spalten. Der Hauptunterschied ist, dass bei einer Matrix nur numerische Inhalte, also Zahlen, erlaubt sind. Wenn wir Daten in `R` verarbeiten wollen, wird der Datensatz oft in Matrizen umtransformiert (falls er vorher nicht-numerische Inhalte enthielt) und dann mit geeigneten Operationen, sogenannten Matrixoperationen, verarbeitet.

`R` ist eine vektorbasierte Programmiersprache, was bedeutet, dass möglichst viel mit Vektor- oder Matrixoperationen durchgeführt werden soll, da diese besonders optimiert (und damit besonders schnell) sind. Um davon Gebrauch zu machen, müssen wir uns mit diesen Operationen vertraut machen: 

##### Vektoren {#Vektoren}
Vektoren werden häufig (aber nicht immer, Ausnahmen bestätigen die Regel) in Kleinbuchstaben dargestellt. 
Seien `x` und `y` zwei Vektoren, die wir mit dem Zuordnungspfeil `<-` und mit der Vektorfunktion `c()` erstellen:


```r
x <- c(1, 2, 3)
y <- c(10, 8, 6)
```

Meistens werden Vektoren als sogenannte Spaltenvektoren (dazu später mehr) dargestellt. `x` und `y` sehen also so aus

{{< math >}}
$$x=\begin{pmatrix}1\\2\\3 \end{pmatrix}, \qquad y=\begin{pmatrix}10\\8\\6 \end{pmatrix}.$$
{{</ math >}}

Die Elemente werden werden dann mit der jeweiligen Stelle im Vektor durchgezählt. Das Element $x_1$ ist also das 1. Element von $x$, also die 1. Dies kann auch so dargestellt werden:

{{< math >}}
$$x=\begin{pmatrix}x_1\\x_2\\x_3 \end{pmatrix}=\begin{pmatrix}1\\2\\3 \end{pmatrix}, \qquad y=\begin{pmatrix}y_1\\y_2\\y_3 \end{pmatrix}=\begin{pmatrix}10\\8\\6 \end{pmatrix}.$$
{{</ math >}}

Wir erkennen, dass den Elementen $x_1, x_2, x_3$ die Zahlen 1, 2, und 3 und den Elementen $y_1, y_2, y_3$ die Zahlen 10, 8, und 6 zugeordnet werden.

Wir können auf Elemente eines Vektor mit eckigen Klammern zugreifen. Bspw. erhalten wir das 2. Element von Y (also quasi $y_2$) mit


```r
y[2]
```

```
## [1] 8
```

Auch mehrere Elemente lassen sich auf diese Weise ausgeben. Sind wir bspw. am 2. bis 3. Element interessiert, können wir 


```r
y[2:3]
```

```
## [1] 8 6
```

schreiben. Interessiert uns hingegen das 1. und 3. Element, brauchen wir erneut einen Vektor, der die Position auswählt:


```r
y[c(1,3)]
```

```
## [1] 10  6
```

{{<intext_anchor VekRechOp>}}
Die Addition von Vektoren funktioniert elementenweise. Das bedeutet, dass das 1. Element des 1. Vektors und das 1. Element des 2. Vektors miteinander addiert werden und das 2. Element des 1. Vektors mit dem 2. Element des 2. Vektors miteinander addiert werden, etc. 

{{< math >}}
\begin{equation}
\small
x+y=\begin{pmatrix}x_1\\x_2\\x_3 \end{pmatrix}+\begin{pmatrix}y_1\\y_2\\y_3 \end{pmatrix}=\begin{pmatrix}x_1+y_1\\x_2+y_2\\x_3+y_3 \end{pmatrix}=\begin{pmatrix}1\\2\\3 \end{pmatrix}+\begin{pmatrix}10\\8\\6 \end{pmatrix}=\begin{pmatrix}1+10\\2+8\\3+6 \end{pmatrix}=\begin{pmatrix}11\\10\\9 \end{pmatrix}.
\end{equation}
{{</ math >}}


Elementeweise Additionen funktionieren super simpel, indem wir `x` und `y` einfach mit `+` verknüpfen. 


```r
x + y  # Addition
```

```
## [1] 11 10  9
```

Wenn `x` und `y` nicht die selbe Länge haben, ist es in `R` oft so, dass die Vektoren künstlich verlängert werden, um verrechnet zu werden. Dies sollten wir immer im Hinterkopf behalten.


```r
z <- c(1:6) # Zahlen 1 bis 6
z + y
```

```
## [1] 11 10  9 14 13 12
```

`z` ist hier doppelt so lang wie `y`, sodass in der Addition `y` einfach zweimal hintereinander geschrieben wird, damit die Addition möglich ist, denn eine Addition bei Vektoren (und auch Matrizen) funktioniert nur, wenn die beiden Elemente das gleiche Format haben! Das ist eine Besonderheit von `R`, was hin und wieder zu Problemen oder Fehlern führen kann.

Wenn wir einen Vektor mit einer Zahl, also einem Skalar, multiplizieren, so bewirkt dies eine elementenweise Multiplikation mit dieser Zahl. Wenn wir beispielsweise $k$ mit $x$ multiplizieren wollen, so erhalten wir:

{{< math >}}
$$kx=k\begin{pmatrix}x_1\\x_2\\x_3 \end{pmatrix}=\begin{pmatrix}kx_1\\kx_2\\kx_3 \end{pmatrix}.$$
{{</ math >}}

Für $k=3$ erhalten wir bspw.

{{< math >}}
$$kx=3\begin{pmatrix}1\\2\\3 \end{pmatrix}=\begin{pmatrix}3\cdot1\\3\cdot2\\3\cdot3 \end{pmatrix}=\begin{pmatrix}3\\6\\9 \end{pmatrix}.$$
{{</ math >}}

In `R` sieht das so aus


```r
3*x
```

```
## [1] 3 6 9
```

Genauso können wir auch jedes Element durch 2 Teilen, indem wir mit $\frac{1}{2}$ also 0.5 multiplizieren.


```r
1/2*x
```

```
## [1] 0.5 1.0 1.5
```

Wenn wir mit $-1$ multiplizieren erhalten wir


```r
-1*x
```

```
## [1] -1 -2 -3
```

Jedes Element wird also mit $-1$ multipliziert. Davon können wir direkt die Subtraktion von Vektoren ablesen. Wollen wir $y-x$ rechnen, so ergibt sich mit Hilfe der Skalarmultiplikation $y+(-1)x$. Damit können wir elementenweise $y$ mit $-1x$ addieren:

{{< math >}}
$$y-x=\begin{pmatrix} y_1\\ y_2\\ y_3 \end{pmatrix} + \begin{pmatrix}-x_1\\ -x_2\\ -x_3 \end{pmatrix}=\begin{pmatrix}y_1-x_1\\ y_2-x_2\\ y_3-x_3 \end{pmatrix} =\begin{pmatrix}10-1\\ 8-2\\ 6-3 \end{pmatrix}=\begin{pmatrix}9\\ 6\\ 3 \end{pmatrix}.$$
{{</ math >}}


Zwei Vektoren der gleichen Länge können in `R` auch miteinander multipliziert werden. Achtung, dies ist eine spezielle Art der Multiplikation, die in `R` durchgeführt wird, nämlich wieder die elementenweise Multiplikation.



```r
x*y 
```

```
## [1] 10 16 18
```

In `R` können den Elementen von Vektoren auch Namen vergeben werden. Bspw. könnten `x` und `y` die Anzahl von Obst auf der Einkaufsliste von Xavian und Yvonne repräsentieren. In `R` geht das so


```r
names(x) <- c("Orangen", "Äpfel", "Bananen")
names(y) <- c("Orangen", "Äpfel", "Bananen")
x
```

```
## Orangen   Äpfel Bananen 
##       1       2       3
```

```r
y
```

```
## Orangen   Äpfel Bananen 
##      10       8       6
```

Die Länge eines Vektors und damit die maximale Anzahl an Elementen erhalten wir mit 


```r
length(x)
```

```
## [1] 3
```

#### Matrizen {#Matrizen}

Ein Vektor ist eine eindimensionale Auflistung von Zahlen. Die Elemente werden einfach durchnummeriert. Eine Matrix ist ein zweidimensionales Objekt, welches aus einer Vielzahl von Vektoren gleicher Länge besteht, welche aneinander "geklebt" werden. Matrizen werden oft in Großbuchstaben beschrieben. Elemente von Matrizen hingegen in Kleinbuchstaben. Auch hier ist das nicht wirklich einheitlich geregelt. 

Eine Matrix $A$, welche 3 Zeilen und 2 Spalten enthält, besteht somit aus 3 Zeilenvektoren der Länge 2 oder aus 2 Spaltenvektoren der Länge 3. 

{{< math >}}
$$A=\begin{pmatrix}a_{11} & a_{12}\\ a_{21} & a_{22}\\a_{31} & a_{32} \end{pmatrix}.$$
{{</ math >}}

Die 3 Zeilenvektoren sind $a_{1\cdot}=(a_{11}, a_{12})$, $a_{2\cdot}=(a_{21}, a_{22})$ und $a_{3\cdot}=(a_{31}, a_{32})$. Die entsprechenden Spaltenvektoren sind 
{{< math >}}$$a_{\cdot1}=\begin{pmatrix}a_{11}\\ a_{21}\\ a_{31}\end{pmatrix} \quad \text{ und } \quad a_{\cdot2}=\begin{pmatrix}a_{12}\\ a_{22}\\ a_{32}\end{pmatrix}.$$

{{</ math >}}

Wir bemerken, dass die Indizes der Elemente uns die Position in der Matrix angeben. Bspw. ist $a_{32}$ das Element in $A$ in der 3. Zeile (1. Index) in der 2. Spalte (2. Index). 

Die gerade behandelten Vektoren  können wir ganz leicht zu einer Matrix machen, indem wir den Befehl `as.matrix` bspw. auf `x` anwenden. Dieser Befehl erzeugt  eine 3x1 Matrix - also aus mathematischer Sicht eigentlich einen Spaltenvektor.


```r
as.matrix(x)
```

```
##         [,1]
## Orangen    1
## Äpfel      2
## Bananen    3
```

Wir können die beiden Vektoren auch zu einer Matrix kombinieren, indem wir sie bspw. als zwei Zeilenvektoren mit dem Befehl `cbind` (was für column binding steht) zusammenfügen - genauso geht dies auch mit `rbind` (was für row binding steht):


```r
A <- cbind(x, y)
A
```

```
##         x  y
## Orangen 1 10
## Äpfel   2  8
## Bananen 3  6
```

```r
B <- rbind(x, y)
B
```

```
##   Orangen Äpfel Bananen
## x       1     2       3
## y      10     8       6
```

Die Matrix $B$ ist nun im Grunde eine Datenmatrix. In den Zeilen stehen die Personen (Xavian und Yvonne) und in den Spalten die Variablen (Obstart, welches gekauft werden soll). 

Wir können nun bspw. den Eintrag $B_{12}$ herauslesen via `[1, 2]`, wobei der 1. Eintrag immer für die Zeile und der 2. für die Spalte steht:


```r
B[1, 2] 
```

```
## [1] 2
```

Dies entspricht der Anzahl an Äpfel von Xavian.

Eine ganze Zeile oder Spalte erhalten wir, indem wir eines der Elemente in der Indizierung frei lassen:


```r
B[1, ] # 1. Zeile
```

```
## Orangen   Äpfel Bananen 
##       1       2       3
```

```r
B[, 2] # 2. Spalte
```

```
## x y 
## 2 8
```

`B[1,]` ist die Anzahl an Obst von Xavian und `B[,2]` ist die Anzahl an Äpfel von Xavian und Yvonne.

So wie `A` und `B` erzeugt wurden, ist ersichtlich, dass die Spalten von `A` die Zeilen von `B` sind. Wir können Zeilen und Spalten auch vertauschen, indem wir die Matrix transponieren, indem wir den Befehl `t()` auf die Matrix anwenden:


```r
A
```

```
##         x  y
## Orangen 1 10
## Äpfel   2  8
## Bananen 3  6
```

```r
t(A)
```

```
##   Orangen Äpfel Bananen
## x       1     2       3
## y      10     8       6
```

```r
B
```

```
##   Orangen Äpfel Bananen
## x       1     2       3
## y      10     8       6
```

Wir erkennen, dass die Matrix `B` gerade die Transponierte von `A` ist! Die Matrixaddition funktioniert genauso wie die von Vektoren, sie wird elementenweise durchgeführt. Allerdings müssen dafür die Matrizen vom selben Format, also der gleichen Dimension, sein, also gleich viele Zeilen und Spalten haben. Das Format wird üblicherweise $z \times s$ angegeben, wobei $z$ die Anzahl an Zeilen und $s$ die Anzahl an Spalten ist.

{{<intext_anchor MatRechOp>}}
Die beiden Matrizen `A` und `B` lassen sich nicht addieren, da sie nicht das richtige Format haben:


```r
A + B
```


```
## Error in A + B : non-conformable arrays
```

Eine $3\times 2$ Matrix lässt sich nicht mit einer $2\times 3$ Matrix addieren. Wird eine Matrix transponiert, so ändert sich damit auch die Dimension. Die Zeilen werden zu Spalten und umgekehrt. Die Transponierte von $A$ ist also eine $2\times 3$ Matrix und lässt sich damit mit $B$ addieren:


```r
t(A) + B
```

```
##   Orangen Äpfel Bananen
## x       2     4       6
## y      20    16      12
```

Dies kommt zum selben Ergebnis, wie als hätten wir jeden Eintrag von $B$ mit 2 multipliziert, also die skalare Multiplikation, die wir bereits von Vektoren kennen, durchgeführt. 


```r
B * 2 # skalare Multiplikation
```

```
##   Orangen Äpfel Bananen
## x       2     4       6
## y      20    16      12
```

Matrizen lassen sich in `R` auch elementenweise multiplizieren. Dafür müssen sie, wie bei der Addition auch, das gleiche  Format haben. 


```r
t(A) * B
```

```
##   Orangen Äpfel Bananen
## x       1     4       9
## y     100    64      36
```

ergibt das selbe, wie als wenn wir jeden Eintrag von $B$ quadriert hätten. Dies kann auch so geschrieben werden:


```r
B^2
```

```
##   Orangen Äpfel Bananen
## x       1     4       9
## y     100    64      36
```

$A'*B$ hat in der Mathematik allerdings keine wirklich Bedeutung. Es gibt jedoch auch die Matrixmultiplikation. Hier werden die Zeilen der ersten Matrix $A$ mit den Spalten der zweiten Matrix $B$ elementenweise multipliziert und diese Elemente werden anschließend addiert. Dies funktioniert nur genau dann, wenn die Anzahl an Spalten der ersten Matrix der Anzahl an Zeilen der zweiten Matrix entspricht.
$p \times q$ ist kompatibel mit $q \times r$.
Die resultierende Matrix hat dann so viele Zeilen wie die erste Matrix und so viele Spalten wie die zweite. Das resultierende Format ist also $p\times r$.

{{< math >}}
\begin{align*}
AB &= \begin{pmatrix}a_{11} & a_{12}\\ a_{21} & a_{22}\\a_{31} & a_{32}\\ \end{pmatrix} \begin{pmatrix}b_{11} & b_{12} & b_{13}\\ b_{21} & b_{22} & b_{23} \end{pmatrix}\\
&= \begin{pmatrix} 
a_{11}b_{11}+a_{12}b_{21} &  
a_{11}b_{12}+a_{12}b_{22}&  
a_{11}b_{13}+a_{12}b_{23}\\ 
a_{21}b_{11}+a_{22}b_{21} & 
a_{21}b_{12}+a_{22}b_{22} & 
a_{21}b_{13}+a_{22}b_{23}\\
a_{31}b_{11}+a_{32}b_{21} & 
a_{31}b_{12}+a_{32}b_{22}& 
a_{31}b_{13}+a_{32}b_{23}\end{pmatrix}.
\end{align*}
{{</ math >}}

Es entsteht eine neue Matrix der Dimension $3\times 3$.

Drehen wir das Ganze um, erhalten wir

{{< math >}}
\begin{align*}
BA &=  \begin{pmatrix}b_{11} & b_{12} & b_{13}\\ b_{21} & b_{22} & b_{23} \end{pmatrix} \begin{pmatrix}a_{11} & a_{12}\\ a_{21} & a_{22}\\a_{31} & a_{32}\\ \end{pmatrix}\\
&= \begin{pmatrix} 
b_{11}a_{11}+b_{12}a_{21} + b_{13}a_{31} &  
b_{11}a_{12}+b_{12}a_{22} + b_{13}a_{32} \\ 
b_{21}a_{11}+b_{22}a_{21} + b_{23}a_{31} &  
b_{21}a_{12}+b_{22}a_{22} + b_{23}a_{32}  \end{pmatrix}.
\end{align*}
{{</ math >}}

Hier entsteht eine Matrix vom Format $2\times 2$. Wir sehen deutlich, dass Matrixmultiplikation im Allgemeinen nicht kommutativ ist, also $AB \neq BA$.

Der Operator in `R` hierfür heißt `%*%` (verwenden wir stattdessen `*`, so wird eine elementenweise Multiplikation durchgeführt, was etwas komplett anderes ist!):


```r
A %*% B # Matrixprodukt A*B
```

```
##         Orangen Äpfel Bananen
## Orangen     101    82      63
## Äpfel        82    68      54
## Bananen      63    54      45
```

```r
B %*% A # Matrixprodukt B*A
```

```
##    x   y
## x 14  44
## y 44 200
```

An den Ergebnissen erkennen wir auch, dass Matrixprodukte nicht kommutativ sind, also die Reihenfolge wichtig ist in der (matrix-)multipliziert wird. 

So wirklich eine Bedeutung können wir diesen Matrixprodukten nicht zuordnen. Erstellen wir jedoch eine zweite Matrix $P$, in welcher wir die Preise für Orangen, Äpfel und Banenen ablegen, dann können wir mit Hilfe der Matrixmultiplikation bestimmen, wie viel Geld Xavian und Yvonne mitbringen müssen, um ihr Obst zu kaufen. Wir wollen das Matrixprodukt wie folgt bestimmen: $BP$. Damit muss $P$ die Dimension $3\times 1$ haben, damit die beiden Matrizen verrechnet werden können. $P$ ist also ein Spaltenvektor. Angenommen eine Orange kostet 0.50€, ein Apfel 0.30€ und eine Banane 0.20€. Wir bennen die Zeilen entsprechend und nennen die Spalte den Preis.


```r
P <- matrix(c(.5, .3, .2))
rownames(P) <- c("Orange", "Äpfel", "Banane")
colnames(P) <- "Preis"
P
```

```
##        Preis
## Orange   0.5
## Äpfel    0.3
## Banane   0.2
```

Nun führen wir Matrixmultiplikation durch:


```r
B %*% P
```

```
##   Preis
## x   1.7
## y   8.6
```

Wir erkennen, dass Xavian 1.7€ und Yvonne 8.6€ ausgeben muss. Angenommen es gäbe einen Konkurrenzladen, der andere Preise für das Obst angibt. Wir können dies in unsere Matrix $P$ aufnehmen und so bestimmen, wie viel die beiden in den jeweiligen Läden ausgeben müssten. Wir verwenden diesmal den `matrix`-Befehl, um direkt eine Matrix zu erzeugen. Dieser Befehl nimmt zunächst einen Vektor mit den Elementen entgegen. Hier empfiehlt es sich durch Zeilenumbrüche Ordnung hereinzubringen. Anschließend sagen wir noch wie viele Zeilen (`nrow`) und Spalten (`ncol`) wir benötigen. Mit `byrow = TRUE` geben wir an, dass die Matrix zeilenweise befüllt werden soll. In *Laden A* kosten Orangen 0.50€, Äpfel 0.30€ und Bananen 0.20€. In *Laden B* sind Bananen super teuer und kosten 1.00€. Hingegen sind Orangen und Äpfel extrem billig und kosten nur 0.05€. Wenn wir die Zeilen und Spalten der Preismatrix $P$ entsprechend bennen, sagt uns das Matrixprodukt nun, wie viel Xavian und Yvonne in den Beiden Läden bezahlen müssen.


```r
P <- matrix(c(.5, .05,
              .3, .05,
              .2, 1), nrow = 3, ncol = 2,
            byrow = TRUE)
rownames(P) <- c("Orangen", "Äpfel", "Bananen")
colnames(P) <- c("Laden A", "Laden B")
B %*% P
```

```
##   Laden A Laden B
## x     1.7    3.15
## y     8.6    6.90
```
Obwohl die Bananen so teuer sind, macht es für Yvonne mehr Sinn in Laden B einzukaufen, während Xavian besser beraten ist bei Laden A zu bleiben (unter der etwas seltsamen Annahme, dass man alles in einem Laden kaufen muss).

#### Spezielle Matrizen
Eine quadratische Matrix hat genauso viele Zeilen wie Spalten. Eine wichtige quadratische Matrix ist die Einheitsmatrix $I$, welche nur 1en auf der Diagonalen und sonst 0en hat. Diese ist gerade das Element, mit welchem wir getrost multiplizieren können (falls die Dimensionen stimmen), weil dann nichts passiert (wie Multiplikation mit 1 bei Zahlen). Wir erhalten sie mit `diag`, was eigentlich eine (quadratische) Diagonalmatrix erzeugt mit beliebigen Elementen auf der Diagonalen:


```r
diag(3) # Einheitsmatrix 3x3
```

```
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]    0    1    0
## [3,]    0    0    1
```

```r
diag(1:3) # Diagonalmatrix mit Elementen 1,2,3 auf der Diagonalen
```

```
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]    0    2    0
## [3,]    0    0    3
```

Wir können eine Matrix mit dem `matrix` Befehl auch mit Hand füllen. Diesem übergeben wir einen Vektor und die Dimensionen der Matrix (`data` werden die Daten, die wir in die Matrix schreiben wollen übergeben, `nrow` und `ncol` bestimmen die Anzahl der Zeilen und Spalten und mit `byrow = T` zeigen wir an, dass wir die Matrix zeilenweise gefüllt bekommen möchten):


```r
C <- matrix(data = c(1:9), nrow = 3, ncol = 3, byrow = T)
C
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
## [3,]    7    8    9
```

Wir können mit `diag` auch wieder die Diagonalelemente einer Matrix erfahren:


```r
diag(C)
```

```
## [1] 1 5 9
```


##### Determinanten und Invertierung {#DetInv}
Die Inverse, also jenes Element, mit welchem wir (matrix-)multiplizieren müssen, um die Einheitsmatrix zu erhalten, lässt sich in `R` mit dem `solve` Befehl erhalten (dies geht nur bei quadratischen Matrizen):


```r
solve(C)
```


```
## Error in solve.default(C) : 
##   system is computationally singular: reciprocal condition number = 2.59052e-18
```

Die Matrix `C` lässt sich nicht invertieren, da sie singulär ist und damit nicht invertierbar. Dies bedeutet, dass es lineare Abhängigkeiten der Zeilen bzw. Spalten gibt. Wir können dies explizit prüfen, indem wir die Determinante bestimmen mit `det`:


```r
det(C)
```

```
## [1] 6.661338e-16
```

```r
round(det(C), 14)
```

```
## [1] 0
```
Mit `round` runden wir das Ergebnis auf die 14. Nachkommastelle. Eine Matrix ist genau dann invertierbar (also regulär im Vergleich zu singulär), wenn die Determinante dieser (quadratischen) Matrix **nicht** Null ist. Lineare Abhängigkeit bedeutet, dass die Zeilen oder Spalten durch Addition, Subtraktion und skalare Multiplikationen auseinander hervorgehen. Wir erkennen die lineare Abhängigkeit zwischen den Spalten, indem wir von der 2. Spalte die 1. Spalte abziehen und anschließend dies auf die 2. Spalte addieren - also de facto $2*2.Spalte - 1. Spalte$  rechnen:


```r
2*C[, 2] - C[, 1]     # 2*2.Spalte - 1. Spalte rechnen ist gleich
```

```
## [1] 3 6 9
```

```r
C[, 3]               # 3. Spalte
```

```
## [1] 3 6 9
```

Hätten wir `C^-1` gerechnet, so hätten wir eine elementeweise Invertierung durchgeführt:


```r
C^-1
```

```
##           [,1]  [,2]      [,3]
## [1,] 1.0000000 0.500 0.3333333
## [2,] 0.2500000 0.200 0.1666667
## [3,] 0.1428571 0.125 0.1111111
```

```r
C^-1 %*% C # ist nicht die Einheitsmatrix
```

```
##          [,1]     [,2]     [,3]
## [1,] 5.333333 7.166667 9.000000
## [2,] 2.216667 2.833333 3.450000
## [3,] 1.420635 1.799603 2.178571
```

```r
C^-1 * C   # elementeweise ergibt überall 1 - ist immer noch nicht die Einheitsmatrix!
```

```
##      [,1] [,2] [,3]
## [1,]    1    1    1
## [2,]    1    1    1
## [3,]    1    1    1
```

Dies bedeutet, dass `C^-1` in `R` nicht die Invertierung betitelt sondern `solve`!

Betrachten wir nun eine invertierbare Matrix `D`:


```r
D <- matrix(c(1, 0, 0,
              1, 1, 1,
              2, 4, 5), 3, 3, byrow = T)
det(D)
```

```
## [1] 1
```

Die Determinante von `D` ist 1. Somit können wir `D` invertieren. Das Produkt aus `D` mit seiner Inversen ergibt gerade die 3x3 Einheitsmatrix:


```r
solve(D)
```

```
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]   -3    5   -1
## [3,]    2   -4    1
```

```r
D %*% solve(D)
```

```
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]    0    1    0
## [3,]    0    0    1
```

```r
solve(D) %*% D
```

```
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]    0    1    0
## [3,]    0    0    1
```

Das Produkt zwischen $D$ und $D^{-1}$ ist (ausnahmsweise) kommutativ: $DD^{-1}=D^{-1}D=I$. Die Inverse einer Matrix ist im Allgemeinen recht schwer zu bestimmen. Zum Glück gibt es Computer! Die einzige Ausnahme ist die $2\times 2$ Matrix. Eine $2\times 2$ Matrix 
$$M=\begin{pmatrix}a&b\\ c&d \end{pmatrix}$$ 
lässt sich invertieren, genau dann wenn die Determinante nicht 0 ist, also wenn keine lineare Abhängigkeit innerhalb der Zeilen oder der Spalten besteht. Die Determinante von $M$ bestimmen wir als 
$$\text{det}[M] = ad-bc.$$
Ist diese nicht 0, so erhalten wir die Inverse von $M$ durch
{{< math >}}$$M^{-1}=\frac{1}{\text{det}[M]}\begin{pmatrix}d&-b\\ -c&a\end{pmatrix}=\frac{1}{ad-bc}\begin{pmatrix}d&-b\\ -c&a\end{pmatrix}.$${{</ math >}}
Wir müssen also die Diagonalelemente von $M$ vertauschen und die Nebendiagonalelemente mit einem Minus versehen. Anschließend müssen wir jeden Eintrag durch die Determinante teilen (oder wir nehmen einfach `solve`).


```r
M <- matrix(c(2, 2, 3, 4), ncol = 2, nrow = 2, byrow = TRUE)
M
```

```
##      [,1] [,2]
## [1,]    2    2
## [2,]    3    4
```

```r
det(M)
```

```
## [1] 2
```

```r
M[1,1]*M[2,2] - M[1,2]*M[2,1] # Determinante mit Hand
```

```
## [1] 2
```

```r
K <- matrix(c(M[2,2], -M[1,2], M[2,1], M[1,1]), byrow = TRUE, ncol = 2, nrow = 2)
K # Kofaktorenmatrix
```

```
##      [,1] [,2]
## [1,]    4   -2
## [2,]    3    2
```

```r
1/(M[1,1]*M[2,2] - M[1,2]*M[2,1])*K # Inverse von M
```

```
##      [,1] [,2]
## [1,]  2.0   -1
## [2,]  1.5    1
```

```r
solve(M) # Inverse von M
```

```
##      [,1] [,2]
## [1,]  2.0   -1
## [2,] -1.5    1
```

Wozu können wir die Matrixinvertierung benutzen? Sei $P$ wieder eine Preismatrix. Wir vertauschen diesmal Zeilen und Spalten


```r
P <- matrix(c(.5, .1, 2,
              .3, .05, 2.5,
              .2, 1, 3), nrow = 3, ncol = 3,
            byrow = TRUE)
colnames(P) <- c("Orangen", "Äpfel", "Bananen")
rownames(P) <- c("Laden A", "Laden B", "Laden C")
P
```

```
##         Orangen Äpfel Bananen
## Laden A     0.5  0.10     2.0
## Laden B     0.3  0.05     2.5
## Laden C     0.2  1.00     3.0
```

Bananen sind nun überall teuer. In Laden A kostet das Obst bspw.:


```r
P[1,]
```

```
## Orangen   Äpfel Bananen 
##     0.5     0.1     2.0
```

Angenommen Sie wüssten nun, dass Xavian in Laden A 15.40€, in Laden B 18.30€ und in Laden C (dem Premiumladen) 25.40€ bezahlen muss. Wie viel Obst will  er kaufen in den Läden?

Es entsteht ein Gleichungssystem $Px = b$, wobei $x$ die Anzahl an Obst enthält und $b$ die Gesamtpreise pro Laden. 


```r
b <- as.matrix(c(15.4, 18.3, 25.4))
rownames(b) <- c("Laden A", "Laden B", "Laden C")
b
```

```
##         [,1]
## Laden A 15.4
## Laden B 18.3
## Laden C 25.4
```

Wenn wir nun $P$ invertieren und von Links auf beiden Seiten "dranmultiplizieren", erhalten wir:

{{< math >}}$$P^{-1}Px = P^{-1}b$${{</ math >}}
Da $P^{-1}P=I$, die Einheitsmatrix ergibt, muss also $x=P^{-1}b$ sein. Wir prüfen dies:


```r
x <- solve(P) %*% b
x
```

```
##         [,1]
## Orangen    2
## Äpfel      4
## Bananen    7
```

Xavian hat 2 Orangen, 4 Äpfel und 7 Bananen in den Läden gekauft. Hier die Probe:


```r
P %*% x
```

```
##         [,1]
## Laden A 15.4
## Laden B 18.3
## Laden C 25.4
```

```r
b
```

```
##         [,1]
## Laden A 15.4
## Laden B 18.3
## Laden C 25.4
```

Wir sehen also, dass die Inverse einer Matrix essentiell ist, um Gleichungssysteme zu lösen. Ist die Matrix invertierbar, so ist das Gleichungssystem eindeutig lösbar.

Nun aber genug von Obst, wir sind hier um Statistik zu betreiben. Im letzten Abschnitt schauen wir uns an, wie man einfache Statistiken mit Hilfe von Matrixoperationen bestimmt.

##### Statistiken mit Matrixoperationen bestimmen {#Deskriptiv}


```r
# Daten laden
load(url('https://pandar.netlify.app/daten/fb22.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb22$geschl_faktor <- factor(fb22$geschl,
                             levels = 1:3,
                             labels = c("weiblich", "männlich", "anderes"))
fb22$fach <- factor(fb22$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb22$ziel <- factor(fb22$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))

fb22$wohnen <- factor(fb22$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

fb22$ort <- factor(fb22$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb22$job <- factor(fb22$job, levels=c(1,2), labels=c("nein", "ja"))
# Skalenbildung

fb22$prok2_r <- -1 * (fb22$prok2 - 5)
fb22$prok3_r <- -1 * (fb22$prok3 - 5)
fb22$prok5_r <- -1 * (fb22$prok5 - 5)
fb22$prok7_r <- -1 * (fb22$prok7 - 5)
fb22$prok8_r <- -1 * (fb22$prok8 - 5)

# Prokrastination
fb22$prok_ges <- fb22[, c('prok1', 'prok2_r', 'prok3_r',
                          'prok4', 'prok5_r', 'prok6',
                          'prok7_r', 'prok8_r', 'prok9', 
                          'prok10')] |> rowMeans()
# Naturverbundenheit
fb22$nr_ges <-  fb22[, c('nr1', 'nr2', 'nr3', 'nr4', 'nr5',  'nr6')] |> rowMeans()
fb22$nr_ges_z <- scale(fb22$nr_ges) # Standardisiert

# Weitere Standardisierungen
fb22$nerd_std <- scale(fb22$nerd)
fb22$neuro_std <- scale(fb22$neuro)
```

Summen lassen sich sehr leicht auch durch ein Matrixprodukt darstellen. Nehmen wir beispielsweise die ersten 3 Spalten des `fb23` Datensatzes her und nennen diese `X`. Wenn wir einen Zeilenvektor der Dimension $1\times n$ wobei $n$ die Anzahl an Zeilen von `X` ist, dann können wir die Summe der Elemente pro Spalte von `X` durch ein Matrixprodukt ausdrücken:


```r
X <- as.matrix(fb22[, 1:3])
n <- nrow(X)
z <- t(rep(1, n)) # 1en-Zeilenvektor der Länge n
z %*% X
```

```
##      prok1 prok2 prok3
## [1,]   424   411   357
```

```r
colSums(X)
```

```
## prok1 prok2 prok3 
##   424   411   357
```

Die Kovarianz zweier Variablen $X$ und $Y$ ist definiert durch 

{{< math >}}
$$\mathbb{C}\text{ov}[X,Y]=\mathbb{E}[(X-\mathbb{E}[X])(Y-\mathbb{E}[Y])] = \mathbb{E}[XY]-\mathbb{E}[X]\mathbb{E}[Y]$$
{{</ math >}}
Den zweiten Teil der Gleichung erhalten wir durch den sogenannten Verschiebungssatz. Um die Kovarianz empirisch zu bestimmen, berechnen wir in der Regel den ersten Teil der Gleichung - wir nähern die Mittelwerte an und schätzen $\mathbb{E}[X]$ durch $\bar{x}=\sum_{i=1}^n x_i$, wobei $x_i$ die Werte der Personen auf der Variable $X$ sind (für $i=1,\dots,n$ Personen). Genauso machen wir das für $\mathbb{E}[Y]$ durch $\bar{y}=\sum_{i=1}^n y_i$. Anschließend bestimmen wir die Summe der Produkte der Abweichungen vom Mittelwert via (und teilen durch $n-1$, um einen Populationsschätzer für die Kovarianz zu erhalten)

{{< math >}}
$$\frac{1}{n-1}\sum_{i=1}^n(x_i-\bar{x})(y_i-\bar{y}).$$
{{</ math >}}
Genauso können wir auch den Verschiebungssatz benutzen. Dann ist die empirische Formel für die Kovarianz

{{< math >}}
$$\frac{1}{n-1}\left(\sum_{i=1}^n (x_iy_i - \bar{x}\bar{y}) \right).$$
{{</ math >}}

Da hier $n$ mal $\bar{x}\bar{y}$ abgezogen wird, kann man auch schreiben 
{{< math >}}
$$\frac{1}{n-1}\sum_{i=1}^n x_iy_i - \frac{n}{n-1}\bar{x}\bar{y}.$$
{{</ math >}}
Nehmen wir nun die Vektoren $x$ und $y$ unserer Probandinen und Probanden her, so können wir die Summen leicht durch Matrixverrechnungen darstellen. Dazu nennen wir `prok1` $x$ und `prok2` $y$:


```r
x <- X[,1]
y <- X[,2]
sum(x*y)
```

```
## [1] 1067
```

```r
t(x) %*% y
```

```
##      [,1]
## [1,] 1067
```

```r
mean(x)
```

```
## [1] 2.666667
```

```r
1/n * (z %*% x)
```

```
##          [,1]
## [1,] 2.666667
```

```r
mean(x)*mean(y)
```

```
## [1] 6.893082
```

```r
1/n * (z %*% x) %*% 1/n* (z %*% y)
```

```
##          [,1]
## [1,] 6.893082
```

```r
cov(x,y)
```

```
## [1] -0.1835443
```

```r
1/(n-1) * (t(x) %*% y - (z %*% x) %*% 1/n* (z %*% y))
```

```
##            [,1]
## [1,] -0.1835443
```

Das wirkt auf den ersten Blick kompliziert, das Schöne ist nun, dass diese Formel auch für Matrizen gilt.
Wollen wir nun die Kovarianzmatrix von `X` bestimmen, so ginge dies bspw. durch:


```r
1/(n-1)*(t(X) %*% X - 1/n*t(z %*% X)  %*% (z %*% X))
```

```
##            prok1      prok2      prok3
## prok1  0.6666667 -0.1835443 -0.4177215
## prok2 -0.1835443  0.8139479  0.1530929
## prok3 -0.4177215  0.1530929  0.7305947
```

```r
cov(X)
```

```
##            prok1      prok2      prok3
## prok1  0.6666667 -0.1835443 -0.4177215
## prok2 -0.1835443  0.8139479  0.1530929
## prok3 -0.4177215  0.1530929  0.7305947
```

Eine alternative Schreibweise wäre:

```r
1/(n-1)*(t(X) %*% X - n*colMeans(X)  %*% t(colMeans(X)))
```

```
##            prok1      prok2      prok3
## prok1  0.6666667 -0.1835443 -0.4177215
## prok2 -0.1835443  0.8139479  0.1530929
## prok3 -0.4177215  0.1530929  0.7305947
```

In Büchern steht dann 

{{< math >}}
$$\frac{1}{n-1}\left(X'X - n*\bar{X}\bar{X}'\right),$$
{{</ math >}}
wobei $\bar{X}$ der Vektor ist, der die Mittelwerte von $X$ enthält (also quasi `colMeans(X)`).
