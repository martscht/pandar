---
title: Matrixalgebra - Übungen
type: post
date: '2024-01-15'
slug: matrixalgebra-uebungen
categories: Statistik I Übungen
tags: []
subtitle: ''
summary: ''
authors: zacharias
weight: ~
lastmod: '2025-05-13'
featured: no
banner:
  image: /header/windmills_but_fancy.jpg
  caption: '[Courtesy of pxhere](https://pxhere.com/en/photo/1178076)'
projects: []
reading_time: no
share: no
links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-i/matrixalgebra
- icon_pack: fas
  icon: star
  name: Lösungen
  url: /lehre/statistik-i/matrixalgebra-loesungen
output:
  html_document:
    keep_md: yes
private: 'true'
---



## Aufgabe 1
### Vektoren
Wir wollen uns zunächst noch mal Vektoren widmen und einige Operationen durchführen.

* Erstellen Sie in R die drei folgenden Vektoren:
Lassen Sie sich anschließend das 3. Element des `y`-Vektors und das 1. Element des `z`-Vektors ausgeben.

{{< math >}}
$$x=\begin{pmatrix}4\\2\ \end{pmatrix}, \qquad y=\begin{pmatrix}7\\14\\93\\56 \end{pmatrix}, \qquad z=\begin{pmatrix}48\\13\\107 \end{pmatrix}$$
{{</ math >}}

* Addieren Sie `x` und `y`. Was erwarten Sie? Gleichen Sie Ihre Erwartungen mit dem tatsächlichen Ergebnis ab.

* Addieren Sie nun `x` und `z`. Was wird jetzt passieren? Gleichen Sie wieder Ihre Erwartungen mit dem tatsächlichen Ergebnis ab.

* Multiplizieren Sie nun den `y`-Vektor mit dem Skalar `m = 3`.

* Nehmen wir an, der Vektor `x` beinhaltet die Anzahl an Geschwistern von Sarah und Lea. 
Ordnen Sie den beiden Elementen die Namen zu.


## Aufgabe 2
### Matrizen


* Erstellen Sie eine $4 \times 3$ Matrix (`A`) aus den folgenden Spaltenvektoren:

{{< math >}}
$$a=\begin{pmatrix}1\\2\\3\\4\\ \end{pmatrix}, \qquad b=\begin{pmatrix}5\\6\\7\\8 \end{pmatrix}, \qquad c=\begin{pmatrix}9\\10\\11\\12 \end{pmatrix}$$
{{</ math >}}

* Erstellen Sie nun aus den gleichen Vektoren eine $3 \times 4$  Matrix (`B`), indem sie die Vektoren als Zeilenvektoren zu einer Matrix verbinden:

{{< math >}}

$$\qquad a=\begin{pmatrix}1, 2, 3, 4 \end{pmatrix},   \qquad b=\begin{pmatrix}5, 6, 7, 8 \end{pmatrix}, \qquad c=\begin{pmatrix}9, 10, 11, 12 \end{pmatrix}$$

{{</ math >}}

* Lassen Sie sich die Elemente $a_{32}$ und $b_{23}$ ausgeben. Was fällt Ihnen auf?

* Bilden Sie die Transponierte von `B`.

* Bilden Sie die beiden Matrizen `X` und `Y` (mit dem `matrix`-Befehl) und addieren Sie diese. Multiplizieren Sie das Ergebnis (`Z`) anschließend mit 4. 

{{< math >}}
$$X=\begin{pmatrix}-4 & -13\\ 8 & -32\\ 49 & 2\end{pmatrix}, Y=\begin{pmatrix}12 & 25\\ 7 & 106\\ 4 & -20\end{pmatrix} $$
{{</ math >}}

* Multiplizieren Sie die Matrizen `A` und `Z`. Machen Sie sich vorher Gedanken über die Voraussetzungen der Matrixmultiplikation und welches Matrixformat Sie erwarten. 

## Aufgabe 3
### Spezielle Matrizen

* Erstellen Sie eine $4 \times 4$ Einheitsmatrix $I$.

* Erstellen Sie eine quadratische Matrix `S` mit den Elementen `14, 7, 28` auf der Diagonalen.

* Bilden Sie die Inverse der Matrix `Z` aus Aufgabe 2. Was erwarten Sie?

* Bilden Sie nun die Inverse `P` der Matrix `S`. Überprüfen Sie im Vorhinein, ob lineare Abhängigkeit vorliegt!

## Bonusaufgabe: To come
### Regressionskoeffizienten berechnen mit Hilfe von Matrixalgebra
