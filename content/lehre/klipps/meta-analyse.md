---
title: Meta-Analyse von Interventionsstudien
date: '2024-09-26'
slug: meta-analyse
categories: ["KliPPs"]
tags: []
subtitle: 'Grundlagen des Vorgehens in der Meta-Analyse'
summary: ''
authors: [schultze, irmer]
weight: 8
lastmod: '2025-01-28'
featured: no
banner:
  image: "/header/gaming.jpg"
  caption: "[Courtesy of RDNE Stock Project](https://www.pexels.com/photo/a-woman-playing-league-of-legends-7915357/)"
projects: []

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/klipps/meta-analyse
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/klipps/meta-analyse.R
  - icon_pack: fas
    icon: newspaper
    name: Artikel
    url: https://doi.org/10.1016/j.addbeh.2023.107887
  - icon_pack: fas
    icon: folder-open
    name: OSF
    url: https://osf.io/kb7f6/


output:
  html_document:
    keep_md: true
---



{{< toc >}}

## Einleitung

Metaanalysen sind Zusammenfassungen von verschiedener Studienergebnissen - meistens sogar ganzer Forschungsbereicher - mit dem Ziel die breite, manchmal widersprüchliche Befundlage zu einem konkreten Thema statistisch aufzubereiten und zusammenzufassen. Somit kommt ihnen insbesondere in der Wissenschaftskommunikation eine wichtige Rolle zu, da sie erlauben über die Limitationen und Schwankungen einzelner Studien hinaus, eine aktuelle wissenschaftliche Befundlage zu präsentieren. 

Bei der Untersuchung von psychotherapeutischen Interventionen haben Meta-Analysen in verschiedenen Abschnitten des "Lebenszyklus" von therapeutischen Problemstellungen unterschiedliche Funktionen. In Gebieten mit jahrzentelanger Forschungstradition können spezifische Teileffekte und die Entwicklung von Interventionseffektivität vor dem Hintergrund gesellschaftlichen Wandels betrachtet werden. Bei der Untersuchung neuerer Störungsbilder, können sie dazu dienen, Gemeinsamkeiten besonders effektiver Interventionen zu identifizieren und Richtungen zukünftiger Entwicklungen anzustoßen.

### Meta-Analyse therapeutischer Ansätze für Gaming Disorder

Auch wenn die Gaming Disorder schon 2013 in das DSM V aufgenommen wurde, stellt die Interventionsforschung zum Thema ein noch relativ junges und breit gefächertes Gebiet dar. Mit der Aufnahme des Störungsbildes in die ICD-11 haben sich auch in Europa neue Rahmenbedingungen für die Entwicklung von Interventionsansätzen gebildet. In diesem Beitrag befassen wir uns mit der Meta-Analyse von [Danielsen et al. (2024)](https://doi.org/10.1016/j.addbeh.2023.107887), in der therapeutische Ansätze für die Gaming Disorder unter drei zentralen Fragen untersucht wurden (S. 2):

> Do therapeutic interventions decrease symptoms in patients with gaming disorder?

> Does effectiveness of different therapeutic interventions vary in patients with gaming disorder?

> Does the effect size vary by how the outcome is measured?

Wie in allen Beiträgen aus diesem Kurs, handelt es sich auch bei dieser Studie um einen Fall, in dem die relevanten Daten und Analyseskripte in einem OSF-Repo öffentlich zur Verfügung gestellt wurden: [osf.io/kb7f6](https://osf.io/kb7f6/). Weil die Daten - ebenfalls wie bei den anderen Beiträgen aus diesem Semester - in der Rohfassung "ein wenig" unübersichtlich sind, können Sie mit diesem Befehl eine Aufbereitung der Daten durchführen, die das Ganze auf die wesentlichen Variablen einschränkt und schon etwas bereinigt:


``` r
source('https://pandar.netlify.app/daten/Data_Processing_game.R')
```


An diesem Datensatz (`game`) sehen wir das zentrale Konzept der Meta-Analyse: hier ist ein Studienergebnis die empirische Untersuchungseinheit. Jede Zeile des Datensatzes stellt ein Ergebnis dar, wobei natürlich die allermeisten Studien mehr als einen Effekt berichten, sodass diese dann (ganz im Sinne der kürzlich besprochenen [gemischten Modelle](/lehre/klipps/lmm-klinische)) Cluster für mehrere Beobachtungen darstellen. Die abhängige Variable stellt die Effektstärke `es` dar, welche zunächst generell untersucht werden soll (um zu sehen, ob die Interventionen insgesamt etwas bringen). Eine detailliertere Aufbereitung der 12 Variablen aus dem Datensatz finden Sie hier verborgen:

<details><summary><b>Variablenübersicht</b></summary>

Variable | Beschreibung | Ausprägungen
--- | ------ | ----- 
`cite` | Kurze Zitation des Artikels | 
`study` | ID der Studie | 
`effect` | ID des Effekts innerhalb der Studie | 
`tr_type` | Art der Intervention | `behavioral`, `prevention`, `psychotherapy`, `other` 
`ct_trye` | Art der Kontrollbedingung | _character_ (10 Ausprägungen)
`dv_type` | Erhebungsinstrument | `IAT`, `YIAS`, `DSM-5`, `Other`
`es` | Effektstärke | _Standardisierte Mittelwertsdifferenz_
`v` | Effektvariabilität | 
`tr_n_ob` | $N$ in der Interventionsgruppe |
`ct_n_ob` | $N$ in der Kontrollgruppe |
`follow` | Abstand der Messung vom Ende der Intervention |
`male` | Anteil der männlichen Teilnehmer in der Studie |

</details>

### Extraktion der Effekte

Die Suche und Identifikation von Studien, die in einer Meta-Analyse eingeschlossen werden sollen, sind komplexe und vielschichtige Arbeitschritte. Dabei ist es, wie bei einzelnen empirischen Studien, inzwischen üblich das Vorgehen mittels Präregistrierung vorab festzuhalten. Für Meta-Analysen mit klinischem Fokus gibt es dabei die zentrale Datenbank [PROSPERO](https://www.crd.york.ac.uk/prospero/), welche neben den Vorgaben für die Präregistrierung auch einen (Versuchen eines) vollständigen Überblick über aktuelle laufende und bereits abgeschlossene Meta-Analysen und Reviews aus dem medizinischen, human-biologischen, pharmakologischen und psychologischen Bereich bietet. Dort findet sich auch die Präregistrierung der hier vorgestellten Meta-Analyse: [CRD42022338931](https://www.crd.york.ac.uk/prospero/display_record.php?ID=CRD42022338931).

Insgesamt wurden nach dem Vorgehen, das im Artikel in Abbildung 1 (S. 5) dargestellt ist, 39 Studien in die Meta-Analyse aufgenommen (von ursprünglich 2861 gesichteten Einträgen). Das deckt sich soweit mit den Inhalten des Datensatzes:


``` r
# Anzahl der Studien im Datensatz
unique(game$cite) |> length()
```

```
## [1] 39
```

Die zentralen Variablen für Meta-Analysen sind die Effektstärken - als AV sollen sie eine Einschätzung über den gefundenen Effekt in jeder Studie zusammenfassen und deren Analyse erlauben. Leider hat sich in den wenigsten Teildisziplinen ein Konsens entwickelt, wie genau die Ergebnisse einer Interventionsstudie berichtet werden sollten, sodass es mitunter sehr viele Schritte erfordert, um die Ergebnisse aller Studien vergleichbar zu machen. Für einen Fall wie diesen, in dem wir daran interessiert sind, Interventions- und Kontrollgruppen hinsichtlich eines relativ einfachen Interventionseffekts zu vergleichen kommt einem zunächst der übliche Verdächtige - [Cohen's $d$](/lehre/statistik-i/gruppenvergleiche-unabhaengig#Effektstärke) - in den Sinn. Cohen's $d$ ist allerdings anfällig für Verzerrung bei kleinen Stichproben, sodass eine Korrektur (Hedge's $g$) insbesondere in Meta-Analysen gängig ist. Darüber hinaus bieten z.B. Varianzanalysen das Effektstärkemaße $\eta^2$, welches eng verwandt ist mit einem anderen Effektstärkemaß, dem $R^2$ aus der Regression. Zum Glück gibt es diverse Wege, um Effektstärken ineinander zu überführen, sodass (solange ein Artikel ein paar wesentliche Informationen über die Studie bereitstellt) die meisten Effekte in eine Analyse eingehen können. 

Es haben sich diverse Webseiten ergeben, die Online-Effektstärke-Umwandler anbieten. Auch wenn die Nutzung dieser gängig ist (und z.B. auch von [Danielsen et al. (2024)](https://doi.org/10.1016/j.addbeh.2023.107887) [eine solche Seite](https://www.campbellcollaboration.org/calculator/d-means-sds) verwendet wird), ist es empfehlenswert eine syntaxbasierte Variante zu nutzen, weil diese meist weniger fehleranfällig sind, als das Übertragen von Output einer Website in den eigenen Datensatz und  von anderen schnell und direkt reproduziert werden kann. Empfehlenswert ist für die Berechnung und Umwandlung von Effektstärken in R das Paket `esc` (für **e**ffect **s**ize **c**alculation).

Gucken wir uns am Beispielt der Studie von [Wölfling et al. (2019)](https://doi.org/10.1001/jamapsychiatry.2019.1676) an, wie eine einzelnen Studie in dieser Meta-Analyse berücksichtigt wird. Laut [Danielsen et al. (2024, S. 3)](https://doi.org/10.1016/j.addbeh.2023.107887) wurde hier Folgendes getan:

> Effect size calculations were based on unadjusted means and standard deviations from post-tests, even if the design included baseline measures. If means and standard deviations were not provided, effect sizes were computed from other statistics, if given (e.g., test statistics from mean comparisons), or requested from authors.

Zum Glück finden wir bei [Wölfling et al. (2019, S. 1023)](https://doi.org/10.1001/jamapsychiatry.2019.1676) die rohen Mittelwerte und Standardabweichungen, um daraus eine Effektstärke zu berechnen. Genauer sind dort in Tabelle 2 drei Messzeitpunkte für die Interventionsgruppe und Kontrollgruppe abgetragen. Um Mittelwerte und Standardabweichungen in R zu übertragen, können wir einen `data.frame` erstellen.


``` r
# Effektstärke für Wölfling et al. (2019)
wolf <- data.frame(
  occasion = c(1, 2),
  tr_mean = c(5.7, 4.6),
  ct_mean = c(11.4, 10.5),
  tr_sd = c(3.99, 3.46),
  ct_sd = c(4.70, 4.33),
  tr_n = c(72, 72),
  ct_n = c(71, 71)
)

wolf
```

```
##   occasion tr_mean ct_mean tr_sd ct_sd tr_n ct_n
## 1        1     5.7    11.4  3.99  4.70   72   71
## 2        2     4.6    10.5  3.46  4.33   72   71
```

Der Datensatz enthält jetzt für beide Zeitpunkte (während der Intervention, nach der Intervention) die Mittelwerte und Standardabweichungen der Interventions- und Kontrollgruppe. Wie bereits erwähnt, ist das Paket `esc` für die Berechnung für Effektstärken empfehlenswert:


``` r
# Paket laden
library(esc)

# Effektstärke berechnen
with(wolf[1, ],          # Datensatz, 1. MZP auswählen
  esc_mean_sd(
    grp1m = tr_mean,     # Mittelwert der Interventionsgruppe
    grp1sd = tr_sd,      # Standardabweichung der Interventionsgruppe
    grp1n = tr_n,        # Stichprobengröße der Interventionsgruppe
    grp2m = ct_mean,     # Mittelwert der Kontrollgruppe
    grp2sd = ct_sd,      # Standardabweichung der Kontrollgruppe
    grp2n = ct_n,        # Stichprobengröße der Kontrollgruppe
  )
)
```

```
## 
## Effect Size Calculation for Meta Analysis
## 
##      Conversion: mean and sd to effect size d
##     Effect Size:  -1.3082
##  Standard Error:   0.1843
##        Variance:   0.0340
##        Lower CI:  -1.6694
##        Upper CI:  -0.9471
##          Weight:  29.4484
```

Neben dem Cohen's $d$ wird hier außerdem auch der Standardfehler und dessen Quadrat (`Variance`) berechnet. Dieses Ausmaß an Unsicherheit in der Schätzung der Koeffizienten ist für Meta-Analysen besonders zentral, da sie kennzeichnet, wie zuverlässig die Information aus einer Studie ist und wie sie demzufolge gegenüber Informationen aus anderen Studien gewichtet werden muss.

In der Präregistrierung von [Danielsen et al. (2024)](https://www.crd.york.ac.uk/prospero/display_record.php?ID=CRD42022338931) ist allerdings nicht von Cohen's $d$, sondern von Hedge's $g$ (eine Korrektur für kleine Stichproben) die Rede:

> Effect sizes will be presented as standardized mean difference (Hedges´ g) with confidence intervals. 

Das können wir mit dem Argument `es.type = 'g'` anfordern:


``` r
# Hedges g berechnen
with(wolf[1, ],          # Datensatz, 1. MZP auswählen
  esc_mean_sd(
    grp1m = tr_mean,     # Mittelwert der Interventionsgruppe
    grp1sd = tr_sd,      # Standardabweichung der Interventionsgruppe
    grp1n = tr_n,        # Stichprobengröße der Interventionsgruppe
    grp2m = ct_mean,     # Mittelwert der Kontrollgruppe
    grp2sd = ct_sd,      # Standardabweichung der Kontrollgruppe
    grp2n = ct_n,        # Stichprobengröße der Kontrollgruppe
    es.type = 'g'        # Effektstärke Hedge's g
  )
)
```

```
## 
## Effect Size Calculation for Meta Analysis
## 
##      Conversion: mean and sd to effect size Hedges' g
##     Effect Size:  -1.3013
##  Standard Error:   0.1843
##        Variance:   0.0340
##        Lower CI:  -1.6625
##        Upper CI:  -0.9401
##          Weight:  29.4484
```

Gucken wir, ob diese Effektstärke sich auch im Datensatz von [Danielsen et al. (2024)](https://doi.org/10.1016/j.addbeh.2023.107887) wiederfindet:


``` r
# Effektstärke für Wölfling et al. (2019) im Datensatz
game[game$cite == 'Woelfling et al. (2019)', ]
```

```
##                       cite study effect       tr_type      ct_type dv_type     es      v tr_n_ob
## 73 Woelfling et al. (2019)    41      1 psychotherapy waiting list   Other 1.3082 0.0340      72
## 74 Woelfling et al. (2019)    41      2 psychotherapy waiting list   Other 1.5066 0.0359      72
##    ct_n_ob follow male
## 73      71     -7  100
## 74      71      0  100
```
Es fallen zwei Dinge auf: 1. die Effektstärke hat das entgegengesetzte Vorzeichen (damit positive Zahlen für einen positiven Interventionseffekt sprechen) und 2. es wurde letztlich (entgegen der Präregistrierung) doch mit Cohen's $d$ gearbeitet. Warum - oder auch _dass_ - dem so ist, wird in der Publikation leider nicht weiter erwähnt.

## Fixed Effects Model

Das für die Studie von [Wölfling et al. (2019)](https://doi.org/10.1001/jamapsychiatry.2019.1676) beschriebene Vorgehen wurde für jede der 38 Studien durchgeführt, sodass wir für jede von ihnen mindestens eine Effektstärke im Datensatz finden. Manche Studien fließen mehrfach ein, weil sie z.B. mehrere Zeitpunkte in ihrer Untersuchung betrachtet haben (wie die Studie von [Wölfling et al., 2019)](https://doi.org/10.1001/jamapsychiatry.2019.1676)) oder aber gleichzeitig mehrere Interventionsansätze mit einer Kontrollgruppe vergleichen (wie z.B. die Studie von [Maden et al., 2020](https://doi.org/10.1016/j.mhpa.2022.100465)). Ersteres stellt uns vor ein Problem, weil wir zunächst verhindern wollen, dass die wiederholte Untersuchung des gleichen Effekts mehrfach in unsere Meta-Analyse eingeht. Betrachten wir also zunächst nur die Effekte, die sich auf Messungen direkt nach der Intervention beziehen:


``` r
# Post-Messungen
post <- subset(game, game$follow == 0)
```

So bleiben 33 Effekte übrig, die wir direkt zusammen untersuchen können. Rufen wir uns die erste Forschungsfrage von [Danielsen et al. (2024)](https://doi.org/10.1016/j.addbeh.2023.107887) kurz in Erinnerung:

> Do therapeutic interventions decrease symptoms in patients with gaming disorder?

Letztlich ist hier also eine Einschätzung des mittleren Effekts der entwickelten Interventionsansätze gefragt. In der Notation der Meta-Analyse wird der _globale_, wahre Effekt mit $\theta$ bezeichnet. In jeder Studie wird versucht diesen Effekt möglichst gut zu schätzen, was aber z.B. Aufgrund des _sampling errors_ nur bedingt gelingt. So wird jeder Effekt $\hat{\theta}_k$ als eine Kombination aus dem wahren Effekt und einem Fehler verstanden:

$$
  \hat{\theta}_k = \theta + \epsilon_k
$$
Weil Fehler sich traditionelleweise ausmitteln sollten (so unsere große Hoffnung in den meisten Formen der Analyse, die wir in der Psychologie so betreiben), könnten also einfach den Mittelwert über alle Effektschätzer bestimmen:


``` r
# Mittelwert der Effekte
mean(post$es)
```

```
## [1] 0.8320515
```

Mit einem einfachen [Einstichproben-$t$-Test](/lehre/statisti-i/tests-konfidenzintervalle#t_test) könnten wir auch direkt noch prüfen, ob dieser Effekt von 0 verschieden ist, was ich uns angesichts der eklatanten Effektgröße an dieser Stelle aber erspare.

In diese Mittelung ist gerade jeder Effekt $\hat{\theta}_k$ gleichmäßig eingegangen -  der auf $n = 15$ basierende Effekte von [Maden et al. (2020)](https://doi.org/10.1016/j.mhpa.2022.100465) war hier also genauso wichtig wie der auf $n=800$ basierende Effekt von [Krossbakken et al. (2018)](https://doi.org/10.1016/j.mhpa.2022.100465). Das scheint etwas unglücklich, weil wir eigentlich annehmen würden, dass größere Stichproben mit einem geringeren Fehler in der Effektschätzung einhergeht. Dieses Prinzizp halten wir in einzelnen Studien im Standardfehler fest: größeres $n$ und geringere Schwankung des Outcomes gehen mit weniger Unsicherheit einher, weswegen uns die inferenzstatistische Absicherung leichter fällt. Da wir im Standardfehler also ein gägngiges Maß für die Unsicherheit in der Effektschätzung vorliegen haben, können wir dieses aus direkt wieder benutzten, wenn wir die Effekte zusammentragen. Dabei wollen wir die Effekte, die besonders sicher geschätzt sind stärker in unsere Schätzung eingehen lassen, als die, die mit höherer Unsicherheit versehen sind. Dieses _Gewicht_ wird traditionellerweise wir als Inverse des quadrierten Standardfehlers berechnet:

$$
  w_k = \frac{1}{SE(\hat{\theta}_k)^2}
$$
Als wir vorhin mit dem `esc`-Paket [die Effektgröße einer einzelnen Studie](#extraktion-der-effekte) bestimmt hatten
***

## Literatur

Danielsen, P. A., Mentzoni, R. A. & Lag, T. (2024). Treatment Effects of Therapeutic Interventions for Gaming Disorder: A Systematic Review and Meta-Analysis. _Addictive Behaviors 149_, 107887. https://doi.org/10.1016/j.addbeh.2023.107887.

Wölfling, K., Müller, K. W., Dreier, M., Ruckes, C., Deuster, O., Batra, A., Mann, K. et al. (2019). Efficacy of Short-Term Treatment of Internet and Computer Game Addiction: A Randomized Clinical Trial. _JAMA Psychiatry 76_(10), 1018 -- 1025. https://doi.org/10.1001/jamapsychiatry.2019.1676.
