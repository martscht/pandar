---
title: "Tests für unabhängige Stichproben - Lösungen" 
type: post
date: '2022-12-09' 
slug: gruppenvergleiche-unabhaengig-loesungen 
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [koehler, buchholz, goldhammer] 
lastmod: '2023-10-24'
featured: no
banner:
  image: "/header/BSc2_test_unabh_stpr.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/662606)"
projects: []
expiryDate:
publishDate: '2023-10-17'
_build:
  list: never
reading_time: false
share: false
output:
  html_document:
    keep_md: true
---




**Daten einlesen**


```
## Warning in readChar(con, 5L, useBytes = TRUE): cannot open compressed file
## 'fb22.rda', probable reason 'No such file or directory'
```

```
## Error in readChar(con, 5L, useBytes = TRUE): cannot open the connection
```


```r
setwd("...")  
load("fb22.rda")
```

**Daten aufbereiten**

Prüfe zunächst, ob die Variablen Faktoren sind.


```r
is.factor(fb22$fach)
```

```
## Error in is.factor(fb22$fach): object 'fb22' not found
```

```r
is.factor(fb22$ort)
```

```
## Error in is.factor(fb22$ort): object 'fb22' not found
```

```r
is.factor(fb22$geschl)
```

```
## Error in is.factor(fb22$geschl): object 'fb22' not found
```

Falls nicht:


```r
# Lieblingsfach als Faktor - falls es noch keiner war
fb22$fach <- factor(fb22$fach, 
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung',
                               'Klinische', 'Diag./Meth.'))
```

```
## Error in factor(fb22$fach, levels = 1:5, labels = c("Allgemeine", "Biologische", : object 'fb22' not found
```

```r
# Wohnort als Faktor - falls es noch keiner war
fb22$ort <- factor(fb22$ort, 
                   levels = c(1, 2),
                   labels = c('Frankfurt', 'anderer'))
```

```
## Error in factor(fb22$ort, levels = c(1, 2), labels = c("Frankfurt", "anderer")): object 'fb22' not found
```

```r
# Geschlecht als Faktor - falls es noch keiner war
fb22$geschl <- factor(fb22$geschl, 
                      levels=c(1,2,3), 
                      labels=c('weiblich', 'maennlich', 'anderes'))
```

```
## Error in factor(fb22$geschl, levels = c(1, 2, 3), labels = c("weiblich", : object 'fb22' not found
```

***

## Aufgabe 1
Unterscheiden sich Studierende, die sich für Allgemeine Psychologie (Variable "fach") interessieren, im Persönlichkeitsmerkmal Intellekt (auch: Offenheit für neue Erfahrungen, "intel") von Studierenden, die sich für Klinische Psychologie interessieren? Normalverteilung des Merkmals in der Population darf angenommen werden. 

<details><summary>Lösung</summary>
**Deskriptivstatistische Beantwortung der Fragestellung: grafisch**

```r
data1 <- fb22[ (which(fb22$fach=="Allgemeine"|fb22$fach=="Klinische")), ]
```

```
## Error in eval(expr, envir, enclos): object 'fb22' not found
```

```r
data1$fach <- droplevels(data1$fach)
```

```
## Error in droplevels(data1$fach): object 'data1' not found
```

```r
boxplot(data1$intel ~ data1$fach,
        xlab="Interessenfach", ylab="Intellekt", 
        las=1, cex.lab=1.5, 
        main="Interessenfach und Intellekt")
```

```
## Error in eval(predvars, data, env): object 'data1' not found
```

**Deskriptivstatistische Beantwortung der Fragestellung: statistisch**


```r
# Überblick

library(psych)
describeBy(data1$intel, data1$fach)
```

```
## Error in describeBy(data1$intel, data1$fach): object 'data1' not found
```

```r
# Berechnung der empirischen Standardabweichung

intel.A <- data1$intel[(data1$fach=="Allgemeine")]
```

```
## Error in eval(expr, envir, enclos): object 'data1' not found
```

```r
sigma.A <- sd(intel.A)
```

```
## Error in is.data.frame(x): object 'intel.A' not found
```

```r
n.A <- length(intel.A[!is.na(intel.A)])
```

```
## Error in eval(expr, envir, enclos): object 'intel.A' not found
```

```r
sd.A <- sigma.A * sqrt((n.A-1) / n.A)
```

```
## Error in eval(expr, envir, enclos): object 'sigma.A' not found
```

```r
sd.A 
```

```
## Error in eval(expr, envir, enclos): object 'sd.A' not found
```

```r
intel.B <- data1$intel[(data1$fach=="Klinische")]
```

```
## Error in eval(expr, envir, enclos): object 'data1' not found
```

```r
sigma.B <- sd(intel.B)
```

```
## Error in is.data.frame(x): object 'intel.B' not found
```

```r
n.B <- length(intel.B[!is.na(intel.B)])
```

```
## Error in eval(expr, envir, enclos): object 'intel.B' not found
```

```r
sd.B <- sigma.B * sqrt((n.B-1) / n.B)
```

```
## Error in eval(expr, envir, enclos): object 'sigma.B' not found
```

```r
sd.B
```

```
## Error in eval(expr, envir, enclos): object 'sd.B' not found
```






























