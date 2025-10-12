---
title: "Regressionsdiagnostik - Lösungen" 
type: post
date: '2025-08-21'
slug: regressionsdiagnostik-loesungen
categories: Statistik II Übungen
tags: ["Regression", "Zusammenhangsanalyse", "Erklärte Varianz", "Voraussetzungsprüfung"]
subtitle: ''
summary: ''
authors: [vonwissel]
weight: 1
lastmod: '2025-08-22'
featured: no
banner:
  image: "/header/vegan_produce.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/687666)"
projects: []
reading_time: false
share: false
private: 'true'

links:
- icon_pack: fas
  icon: book
  name: Inhalte
  url: /lehre/statistik-ii/regressionsdiagnostik
- icon_pack: fas
  icon: pen-to-square
  name: Übungen
  url: /lehre/statistik-ii/regressionsdiagnostik-uebungen
output:
  html_document:
    keep_md: yes
---



## Vorbereitung

Laden Sie zunächst die benötigten Pakete und das Datenset **Prestige** aus dem Paket **carData**. Sollten Sie einzelne Pakete noch nicht installiert haben, installieren Sie diese über `install.packages()`.


``` r
# Pakete laden
library(car)
library(carData)
library(lm.beta) # Für standardisierte Regressionskoeffizienten
library(lmtest) # für die Testung der Regressionsgewichte
library(sandwich) # für die Berechnung der HC3 Standardfehler

# Daten laden
data("Prestige", package = "carData")
```

## Aufgabe 1: Modellaufstellung und erste Diagnose

1. Schätzen Sie ein multiples Regressionsmodell mit *prestige* als Kriterium und *education*, *income*, *women* als Prädiktoren.
   - Welche der vier Prädiktoren sind statistisch Signifikant?
2. Ermitteln Sie zusätzlich die standardisierte Regressionskoeffizienten.
   - Was sagen die die stand. Gewichte aus?
3. Erstellen Sie die vier Standarddiagnoseplots.
   - Welcher der Plots kann zur Diagnostik welcher Vorrausetzung herangezogen wrden?

<details>
<summary>Lösung</summary>

- Die Prädiktoren *education* und *income* sind statistisch Signifikant (p < .05).
- Die **standardisierten Regressionsgewichte** für die Prädiktoren, geben an, um wie viele Standardabweichungen sich die Vorhersage von y unterscheidet, wenn sich zwei Personen in x um eine Standardabweichung unterscheiden (bei gleicher Ausprägung aller anderen Prädiktoren).
- Der **Residuals vs Fitted Plot** kann zur Prüfung der Linearität- & Homoskedastizitätsannahme, der **Normal Q-Q Plot** zur Prüfung der Normalverteilung der Residuen, der **Scale-Location Plot** zur Diagnostik der Homoskedastizität und der **Residuals vs Leverage** zur Identifikation von einflussreichen Beobachtungen herangezogen werden. 


``` r
# Modell schätzen
mod_base <- lm(prestige ~ education + income + women, data = Prestige)

# Ergebnisse betrachten
summary(mod_base)

# Ausgabe mit den standardisierte Regressionskoeffizienten
summary(lm.beta(mod_base))

# Standarddiagnoseplots
par(mfrow = c(2,2))
plot(mod_base)
par(mfrow = c(1,1))
```
</details>

## Aufgabe 2: Homoskedastizität prüfen

##### Diagnostik

1. Prüfen Sie grafisch die Homoskedastizität der Residuen.
2. Führen Sie zusätzlich einen geeigneten Test durch, um zu Prüfen, ob die Varianz der Residuen *signifikant linear* mit den vorhergesagten Werten zusammenhängt.

##### Umgang mit Heteroskedastizität

3. Im Falle von Heteroskedastizität können robuste, korrigierte Standardfehler als **eine** Möglichkeit herangezogen werden, um dem "Problem" entgegenzuwirken. Bestimmten Sie bitte die korrigerte Standardfehler (`HC3`). Auch falls die Homoskedastizitätannahme nicht verletzt sein sollte (Zu Übungszwecken).

<details>
<summary>Lösung</summary>


``` r
# Scale-Location-Plot
plot(mod_base, 3)

# Residuenplot
plot(mod_base, 1)

# Test For Non-Constant Error Variance
ncvTest(mod_base)

# HC3 Standardfehler
vcovHC(mod_base) |> diag() |> sqrt()

# Inferenzstatistik der Regressionsgewichte
coeftest(mod_base, vcov = vcovHC(mod_base))
```
</details>

## Aufgabe 3: Normalverteilung der Residuen prüfen

##### Diagnostik

1. Erstellen Sie ein **Histogramm** und einen **Q–Q-Plot** der Residuen.
2. Führen Sie zusätzlich den **Shapiro–Wilk-Test** durch

##### Umgang mit Abweichungen der Normalverteilung

3. Unabhänghig davon ob die Normalverteilungsannahme in dieser Übung verletzt sein sollte, führen Sie bitte eine geeignete Transformation der AV durch. Wie im zugehörigen PandaR Beitrag beschrieben, stellt dies *eine* der Möglichkeiten zum Umgang bei Vorrausetzungsverletzung dar.

<details>
<summary>Lösung</summary>


``` r
# Residuen des Modells in eigener Variable speichern

resid_base <- residuals(mod_base)

# QQ-Plot der Residuen
qqPlot(mod_base)

# Histogramm der Residuen
hist(resid_base, breaks = 15) # Mit breaks = 15 wird die Anzahl der Intervalle festgelegt, wodurch die Form der Residuenverteilung klarer und leichter im Hinblick auf Abweichungen von der Normalverteilung erkennbar wird.

# Shapiro-Wilk-Test
shapiro.test(resid_base)

# ACHTUNG: Die Normalverteilungsannahme sollte in dieser Übung nicht verletzt sein, da die Residuen des Modells normalverteilt sind. 
# Zu Übungszwecken möchten wir im folgenden dennoch eine Möglichkeit zum Umgang mit einer Vorraussetzungsverletzung durchführen.

# Box-Cox-Analyse zur Ermittlung des optimalen Lambdas 
# Siehe PandaR Beitrag zur Regressionsdiagnostik zur weiteren Erläuterung (https://pandar.netlify.app/lehre/statistik-ii/regressionsdiagnostik/)
library("MASS")
bc <- boxcox(mod_base, lambda = seq(-5, 5, .1))

# Optimales Lambda extrahieren
lam <- bc$x[which.max(bc$y)]
lam

# Transformation der AV
Prestige$prestige_bc <- (Prestige$prestige^lam - 1) / lam

# Neues Modell mit transformierter AV aufstellen
mod_bc <- lm(prestige_bc ~ education + income + women, data = Prestige)

# Residuen des neuen Modells in eigener Variable speichern
resid_bc <- residuals(mod_bc)

# Erneuter Shapiro-Wilk-Test
shapiro.test(resid_bc)
```
</details>

## Aufgabe 4: Multikollinearität prüfen

1. Erstellen Sie eine **Korrelationsmatrix** der Prädiktoren, um festzustellen, ob zwei oder mehrere Prädiktoren hoch miteinander korrelieren (Multikollinearität).
2. Berechnen Sie die **Varianzinflationsfaktoren** (`VIF`) sowie die **Toleranzwerte**.

<details>
<summary>Lösung</summary>


``` r
# Korrelationsmatrix
round(cor(Prestige[, c("education", "income", "women")]), 3)

# Varianzinflationsfaktor
v <- vif(mod_base)
v

# Toleranzwerte als Kehrwerte
1/v

# Interpretation: Die Prädiktoren sind allesamt noch vollkommen im Rahmen und von den als Daumenregeln propagierten Grenzwerte weit entfernt.
```
</details>

## Aufgabe 5: Einflussreiche Beobachtungen identifizieren

1. Erstellen Sie mit der Funktion `influencePlot()` ein “Blasendiagramm” zur simultanen grafischen Darstellung von Hebelwerten, studentisierten Residuen und Cooks Distanz. 
2. Ermitteln Sie mögliche Ausreiser bzw. auffälligen Fälle.
3. Überlegen Sie anhand des zugehörigen PandaR Beitrages wie Sie mit diesen Fällen umgehen möchten. 

<details>
<summary>Lösung</summary>


``` r
# Erstellen eines Infleunce Plots zur grafischen Identifkation von auffälligen Fällen
InfPlot <- influencePlot(mod_base)
InfPlot

# Zwischenspeichern der identifizierten Fälle
IDs <- rownames(InfPlot)

# Rohdaten der identifizierten Fälle ausgeben
Prestige[IDs, c('prestige', 'education', 'income', 'women')]

# Standardisierte Skalenwerte ausgeben
std <- Prestige[IDs, c('prestige', 'education', 'income', 'women')] |>
  scale()
round(std[IDs, ], 3)
```
</details>
