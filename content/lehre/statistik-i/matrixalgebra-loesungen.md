---
title: "Matrixalgebra - Lösungen" 
type: post
date: '2024-01-15' 
slug: matrixalgebra-loesungen
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [zacharias]
weight:
lastmod: '2025-04-07'
featured: no
banner:
  image: "/header/windmills_but_fancy.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1178076)"
projects: []
expiryDate: ''
publishDate: ''
_build:
  list: never
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/matrixalgebra
  - icon_pack: fas
    icon: pen-to-square
    name: Übungen
    url: /lehre/statistik-i/matrixalgebra-uebungen
output:
  html_document:
    keep_md: true

---



## Aufgabe 1
### Vektoren
Wir wollen uns zunächst noch mal Vektoren widmen und einige Operationen durchführen.

* Erstellen Sie in R die drei folgenden Vektoren:
Lassen Sie sich anschließend das 3. Element des `y`-Vektors und das 1. Element des `z`-Vektors ausgeben.

{{< math >}}
$$x=\begin{pmatrix}4\\2\ \end{pmatrix}, \qquad y=\begin{pmatrix}7\\14\\93\\56 \end{pmatrix}, \qquad z=\begin{pmatrix}48\\13\\107 \end{pmatrix}$$
{{</ math >}}

<details><summary>Lösung</summary>

``` r
# Erstellen der Vektoren
x <- c(4, 2)
y <- c(7, 14, 93, 56)
z <- c(48, 13, 107)

y[3] # 3. Element des y-Vektors
```

```
## [1] 93
```

``` r
z[1] # 1. Element des z-Vektors
```

```
## [1] 48
```
</details>


* Addieren Sie `x` und `y`. Was erwarten Sie? Gleichen Sie Ihre Erwartungen mit dem tatsächlichen Ergebnis ab.

<details><summary>Lösung</summary>

``` r
x + y
```

```
## [1] 11 16 97 58
```
Wir wissen bereits, dass die Addition von Vektoren elementeweise funktioniert. Eigentlich können wir nur Vektoren des gleichen Formats addieren, dennoch bekommen wir hier keine Fehlernachricht. Stattdessen benutzt R unseren kürzeren Vektor (`x`) zwei mal, um die Addition zu ermöglichen. 

</details>

* Addieren Sie nun `x` und `z`. Was wird jetzt passieren? Gleichen Sie wieder Ihre Erwartungen mit dem tatsächlichen Ergebnis ab.

<details><summary>Lösung</summary>

``` r
x + z
```

```
## Warning in x + z: longer object length is not a multiple of shorter object length
```

```
## [1]  52  15 111
```

In der vorherigen Aufgabe hatten wir zwei Vektoren vorliegen, die ein Vielfaches einander darstellten. Dies ist in dieser Aufgabe nicht der Fall, deshalb bekommen wir hier eine Warnung: `"longer object length is not a multiple of shorter object length".` R warnt uns also, dass der längere Vektor in diesem Beispiel kein Vielfaches des kürzeren Vektors darstellt (und somit nicht einfach der kürzere Vektor vervielfacht genutzt werden kann). Stattdessen verwendet R nur das erste Element unseres `z`-Vektors zweifach. 

</details>

* Multiplizieren Sie nun den `y`-Vektor mit dem Skalar `m = 3`.

<details><summary>Lösung</summary>

``` r
m <- 3
y * m
```

```
## [1]  21  42 279 168
```

Wie wir sehen, wird jedes Element unseres Vektors mit 3 multipliziert. Die Multiplikation mit Skalaren funktioniert also ebenso elementenweise.

</details>

* Nehmen wir an, der Vektor `x` beinhaltet die Anzahl an Geschwistern von Sarah und Lea. 
Ordnen Sie den beiden Elementen die Namen zu.

<details><summary>Lösung</summary>

``` r
names(x) <- c("Sarah", "Lea")
x
```

```
## Sarah   Lea 
##     4     2
```

</details>


## Aufgabe 2
### Matrizen


* Erstellen Sie eine $4 \times 3$ Matrix (`A`) aus den folgenden Spaltenvektoren:

{{< math >}}
$$a=\begin{pmatrix}1\\2\\3\\4\\ \end{pmatrix}, \qquad b=\begin{pmatrix}5\\6\\7\\8 \end{pmatrix}, \qquad c=\begin{pmatrix}9\\10\\11\\12 \end{pmatrix}$$
{{</ math >}}

<details><summary>Lösung</summary>

``` r
# Vektoren erstellen
a <- c(1, 2, 3, 4)
b <- c(5, 6, 7, 8)
c <- c(9, 10, 11, 12)

# Matrix A erstellen und anzeigen lassen
A <- cbind(a, b, c)
A
```

```
##      a b  c
## [1,] 1 5  9
## [2,] 2 6 10
## [3,] 3 7 11
## [4,] 4 8 12
```
</details>


* Erstellen Sie nun aus den gleichen Vektoren eine $3 \times 4$  Matrix (`B`), indem sie die Vektoren als Zeilenvektoren zu einer Matrix verbinden:

{{< math >}}

$$\qquad a=\begin{pmatrix}1, 2, 3, 4 \end{pmatrix},   \qquad b=\begin{pmatrix}5, 6, 7, 8 \end{pmatrix}, \qquad c=\begin{pmatrix}9, 10, 11, 12 \end{pmatrix}$$

{{</ math >}}

<details><summary>Lösung</summary>

``` r
# Matrix B erstellen und anzeigen lassen
B <- rbind(a, b, c)
B
```

```
##   [,1] [,2] [,3] [,4]
## a    1    2    3    4
## b    5    6    7    8
## c    9   10   11   12
```
</details>


* Lassen Sie sich die Elemente $a_{32}$ und $b_{23}$ ausgeben. Was fällt Ihnen auf?

<details><summary>Lösung</summary>

``` r
A[3, 2]
```

```
## b 
## 7
```

``` r
B[2, 3]
```

```
## b 
## 7
```
Wie wir sehen, sind die Elemente $a_{32}$ und $b_{23}$ identisch. Das liegt daran, dass die Matrix `A` die Transponierte der Matrix `B` ist.

</details>


* Bilden Sie die Transponierte von `B`.

<details><summary>Lösung</summary>

``` r
t(B)
```

```
##      a b  c
## [1,] 1 5  9
## [2,] 2 6 10
## [3,] 3 7 11
## [4,] 4 8 12
```

Wir sehen, dass die Transponierte von `B` tatsächlich identisch mit `A` ist. Wir können die Elemente auch einzeln abgleichen:


``` r
t(B) == A
```

```
##         a    b    c
## [1,] TRUE TRUE TRUE
## [2,] TRUE TRUE TRUE
## [3,] TRUE TRUE TRUE
## [4,] TRUE TRUE TRUE
```
</details>

* Bilden Sie die beiden Matrizen `X` und `Y` (mit dem `matrix`-Befehl) und addieren Sie diese. Multiplizieren Sie das Ergebnis (`Z`) anschließend mit 4. 

{{< math >}}
$$X=\begin{pmatrix}-4 & -13\\ 8 & -32\\ 49 & 2\end{pmatrix}, Y=\begin{pmatrix}12 & 25\\ 7 & 106\\ 4 & -20\end{pmatrix} $$
{{</ math >}}

<details><summary>Lösung</summary>

``` r
# Matrizen erstellen
X <- matrix(c(-4, -13, 
              8, -32,
              49, 2), nrow = 3, ncol = 2,
            byrow = TRUE)
Y <- matrix(c(12, 25,
              7, 106,
              4, -20), nrow = 3, ncol = 2,
            byrow = TRUE)
```


``` r
# Matrizen addieren
Z <- X + Y
Z
```

```
##      [,1] [,2]
## [1,]    8   12
## [2,]   15   74
## [3,]   53  -18
```

``` r
# mit 4 addieren (skalare Multiplikation)
Z*4
```

```
##      [,1] [,2]
## [1,]   32   48
## [2,]   60  296
## [3,]  212  -72
```
</details>

* Multiplizieren Sie die Matrizen `A` und `Z`. Machen Sie sich vorher Gedanken über die Voraussetzungen der Matrixmultiplikation und welches Matrixformat Sie erwarten. 

<details><summary>Lösung</summary>

``` r
# Matrixmultiplikation
A %*% Z
```

```
##      [,1] [,2]
## [1,]  560  220
## [2,]  636  288
## [3,]  712  356
## [4,]  788  424
```

Die Multiplikation der beiden Matrizen funktioniert unproblematisch, da die beiden Matrizen kompatibel sind, d.h. die Anzahl an Spalten der Matrix `A` entspricht der Anzahl an Zeilen der Matrix `Z`. Das Ergebnis ist entstanden, indem die Zeilen der Matrix `A` mit den Spalten der Matrix `Z` elementenweise multipliziert und diese Elemente anschließend addiert wurden. Wir erhalten eine $4 \times 2$ Matrix.

</details>

## Aufgabe 3
### Spezielle Matrizen

* Erstellen Sie eine $4 \times 4$ Einheitsmatrix $I$.

<details><summary>Lösung</summary>

``` r
# Einheitsmatrix
I <- diag(4)
I
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    0    0    0
## [2,]    0    1    0    0
## [3,]    0    0    1    0
## [4,]    0    0    0    1
```
Die Einheitsmatrix $I$ zeichnet sich dadurch aus, dass Sie auf der Diagonale nur Einsen und sonst nur Nullen als Elemente hat.

</details>

* Erstellen Sie eine quadratische Matrix `S` mit den Elementen `14, 7, 28` auf der Diagonalen.

<details><summary>Lösung</summary>

``` r
# quadratische Matrix
S <- diag(c(14, 7, 28))
S
```

```
##      [,1] [,2] [,3]
## [1,]   14    0    0
## [2,]    0    7    0
## [3,]    0    0   28
```

</details>


* Bilden Sie die Inverse der Matrix `Z` aus Aufgabe 2. Was erwarten Sie?

<details><summary>Lösung</summary>

``` r
# Inverse
# solve(Z)
```
Es lässt sich keine Inverse der Matrix `Z` bilden, da diese nicht quadratisch ist. Das erfahren wir auch in der Fehlernachricht von R: `'a' (3 x 2) must be square`.

</details>


* Bilden Sie nun die Inverse `P` der Matrix `S`. Überprüfen Sie im Vorhinein, ob lineare Abhängigkeit vorliegt!

<details><summary>Lösung</summary>

``` r
# Determinante bestimmen
det(S)
```

```
## [1] 2744
```
Die Determinante ist nicht Null, es liegt also keine lineare Abhängigkeit vor.


``` r
# Inverse
P <- solve(S)
P
```

```
##            [,1]      [,2]       [,3]
## [1,] 0.07142857 0.0000000 0.00000000
## [2,] 0.00000000 0.1428571 0.00000000
## [3,] 0.00000000 0.0000000 0.03571429
```
Nun erhalten wir ein Ergebnis, da es sich bei `S` um eine quadratische Matrix handelt, die zudem regulär und somit invertierbar ist. Unser Ergebnis ist die Matrix, mit welcher wir `S` (matrix-)multiplizieren müssen, um die Einheitsmatrix zu erhalten. Das können wir auch kurz gegenchecken:


``` r
# Inverse
P %*% S
```

```
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]    0    1    0
## [3,]    0    0    1
```
Tatsächlich: Wir erhalten die Einheitmatrix $I$.

</details>

## Bonusaufgabe: To come
### Regressionskoeffizienten berechnen mit Hilfe von Matrixalgebra
