---
title: ANCOVA
date: '2024-09-26'
slug: ancova-klinische
categories: ["KliPPs"]
tags: ["Regression", "ANCOVA", "Effektschätzer"]
subtitle: ''
summary: ''
authors: [schultze, nehler, irmer]
weight: 3
lastmod: '2024-11-11'
featured: no
banner:
  image: "/header/canceled.jpg"
  caption: "[Courtesy of pexels](https://www.pexels.com/photo/concrete-building-under-blue-sky-4004291/)"
projects: []

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/klipps/ancova-klinische
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/klipps/ancova-klinische.R
  - icon_pack: fas
    icon: newspaper
    name: Artikel
    url: https://doi.org/10.1038/s41562-021-01235-0
  - icon_pack: fas
    icon: folder-open
    name: OSF
    url: https://osf.io/8mk6x/
    
output:
  html_document:
    keep_md: true
---



{{< toc >}}

## Einleitung

Die **AN**alysis of **COVA**riance hatten wir bereits im [2. Semester der Bachelorstudiengangs behandelt](lehre/statistik-ii/ancova-regression/#ancova) und dabei schon vorausahnen lassen, dass wir uns das Ganze im Rahmen des KliPPs-Masters noch einmal detaillierter angucken werden. Dieser Spannungsbogen soll nun hier abgeschlossen werden. 

Im Allgemeinenen wird die ANCOVA in der Psychotherapieforschung immer dann genutzt, wenn wir Interventionsgruppen betrachten werden, die sich zum ersten Zeitpunkt hinsichtlich des Outcomes oder beliebiger Kovariaten unterscheiden *können*. Hierbei ist besonders wichtig zu unterscheiden, ob es sich um randomisierte Studien (üblicherweise "Randomized Controlled Trial", kurz RCT, genannt) handelt oder nicht. Üblicherweise sollten sich die Gruppen im ersten Fall nicht systematisch unterscheiden, aber wir werden im Abschnitt zum [Dropout](#dropout) noch genauer darauf eingehen, wie so etwas trotzdem entstehen kann. Darüber hinaus werden wir einige kritische Entscheidungen und Abgrenzungen besprechen, z.B. in welchen Fällen statt der hier vorgestellten ANCOVA eher die klassische [ANOVA mit Messwiederholung](/lehre/statistik-ii/anova-iii/) empfohlen wird.

### Interventionsstudie zur Depression während der COVID Pandemie

Auch wenn dieser Beitrag etwas theorielastiger wird, als die vergangenen Abschnitte, werden wir uns auch dieses mal hauptsächlich an einer spezifische klinischen Studie orientieren. Die Basis für unsere Auswertungen liefert eine Studie von [Schleider et al. (2022)](https://doi.org/10.1038/s41562-021-01235-0). Anders als bei den bisherigen Beiträgen muss ich allerdings von vornherein zugeben, dass wir die Ergebnisse nicht exakt reproduzieren werden - und das hier auch nicht direkt anpeilen werden - weil in der Studie mitunter etwas aufwändigere Datenauf- und -vorbereitungsschritte durchgeführt wurden, die uns hier etwas zu weit vom eigentlichen Thema ablenken würden.

Wie immer können Sie die Originaldaten direkt aus dem [OSF Repo](https://osf.io/8mk6x/) beziehen. Die relevante Auswahl aus dem sehr großen Datensatz habe ich schon einmal vorbereitet und hier hinterlegt:


``` r
source('https://pandar.netlify.app/daten/Data_Processing_cope.R')
```


Im Datensatz sind insgesamt 51 Variablen enthalten, von denen zwar nicht alle zentral für die ANCOVA sind, aber zumindest in den Tabellen der Studie aufbereitet werden. Im Artikel werden die Ergebnisse einer großen Interventionsstudie vorgestellt, in der die Effektivität von zwei selbst-administrierten single-session interventions (SSI) mit Hinblick auf die Reduktion von depressiven Symptomen bei Jugendlichen während der COVID-19 Pandemie untersucht wurde. Die Studie ist im Journal [Nature Human Behavior](https://www.nature.com/nathumbehav), erschienen und gehört mit seinen [126 Zitationen](https://www.webofscience.com/wos/woscc/full-record/WOS:000728447200001) zum 1% der am häufigst zitierten psychologischen Publikationen des Jahres 2022. 

<details><summary><b>Variablenübersicht</b></summary>

Variable | Beschreibung | Ausprägungen
--- | ------ | ----- 
`condition` | Experimentalbedingung | `Placebo Control`, `Project Personality`, `Project ABC`
`race_...` | Verschiedene Angaben zur Ethnizität | `0` = identifiziert sich nicht als, `1` = identifiziert sich als
`gender_...` | Verschiedene Angaben zum Geschlecht | `0` = identifiziert sich nicht als, `1` = identifiziert sich als
`sex` | Geburtsgeschlecht | `Female`, `Male`, `Other`, `Prefer not to say`
`orientation` | Sexuelle Orientierung | `Asexual`, `Bisexual`, `Gay/Lesbian/Homosexual`, `Heterosexual/Straight`, `I do not use a label`, `I do not want to respond`, `Other/Not listed (please specify)`, `Pansexual`, `Queer`, `Unsure/Questioning`
`age` | Alter | Alter in Jahren
`CDI1` | Children's Depression Inventory, Baseline | _Skalenmittelwert_, 0-2
`CDI3` | Children's Depression Inventory, Follow-up | _Skalenmittelwert_, 0-2
`CTS1` | COVID Trauma Symptoms, Baseline | _Skalenmittelwert_, 1-4
`CTS3` | COVID Trauma Symptoms, Follow-up | _Skalenmittelwert_, 1-4
`GAD1` | Generalized Anxiety Disorder, Baseline | _Skalenmittelwert_, 1-4
`GAD3` | Generalized Anxiety Disorder, Follow-up | _Skalenmittelwert_, 1-4
`SHS1` | State Hope Scale, Perceived Agency Subscale, Baseline | _Skalenmittelwert_, 1-8
`SHS2` | State Hope Scale, Perceived Agency Subscale, Post-Intervention | _Skalenmittelwert_, 1-8
`SHS3` | State Hope Scale, Perceived Agency Subscale, Follow-up | _Skalenmittelwert_, 1-8
`BHS1` | Beck Hopelessness Scale, Baseline | _Skalenmittelwert_, 0-3
`BHS2` | Beck Hopelessness Scale, Post-Intervention | _Skalenmittelwert_, 0-3
`BHS3` | Beck Hopelessness Scale, Follow-up | _Skalenmittelwert_, 0-3
`DRS1` | Dietary Restriction Screener, Baseline | _Skalenmittelwert_, 0-1
`DRS3` | Dietary Restriction Screener, Follow-up | _Skalenmittelwert_, 0-1
`pfs_1` | Program Feedback Scale, "Enjoyed" | 1-5
`pfs_2` | Program Feedback Scale, "Understood" | 1-5
`pfs_3` | Program Feedback Scale, "Easy to Use" | 1-5
`pfs_4` | Program Feedback Scale, "Tried My Hardest" | 1-5
`pfs_5` | Program Feedback Scale, "Helpful to Other Kids" | 1-5
`pfs_6` | Program Feedback Scale, "Would Recommend to a Friend" | 1-5
`pfs_7` | Program Feedback Scale, "Agree with Message" | 1-5
`dropout1` | Abbruch der Teilnahme, Post-Intervention | `0` = nicht abgebrochen, `1` = abgebrochen
`dropout2` | Abbruch der Teilnahme, Follow-Up | `0` = nicht abgebrochen, `1` = abgebrochen


</details>

### Deskriptivstatistik

Wie schon in den anderen Beiträgen, können wir zunächst checken, ob unsere Daten mit denen aus dem Artikel übereinstimmen, indem wir die deskriptivstatistischen Tabellen nachvollziehen. Tabelle 1 (S. 260) gibt dabei eine sehr detaillierte Übersicht über die die Verteilung der demografischen Variablen Ethnizität, Geschlecht und sexueller Orientierung. Diese Ergebnisse sind mit dem bereitgestellten Datensatz soweit reproduzierbar - allerdings aufgrund der fehlenden Exklusivität der Kategorien nicht so einfach zu erstellen, wie in den vergangenen beiden Beiträgen:


``` r
# Ethnizität
ethnicity <- aggregate(cope[, grep('race_', names(cope))], by = list(cope$condition), FUN = sum)
names(ethnicity) <- c('condition', 'Native', 'Asian', 'Hispanic', 'Pacific Islander', 'White', 'Black', 'Other', 'Prefer not to say')
ethnicity
```

```
##             condition Native Asian Hispanic Pacific Islander White Black Other
## 1     Placebo Control     36   101      159               14   546    85    19
## 2 Project Personality     29   100      148               14   550    88    11
## 3         Project ABC     27   109      164               11   536    84    17
##   Prefer not to say
## 1                 9
## 2                10
## 3                 5
```

``` r
# Geschlecht
gender <- aggregate(cope[, grep('gender_', names(cope))], by = list(cope$condition), FUN = sum)
names(gender) <- c('condition', 'agender', 'not sure', 'other', 'androgynous', 'nonbinary', 'two spirited', 'Trangender female to male', 'trans female', 'trans male', 'Gender expansive', 'Third gender', 'Genderqueer', 'Transgender male to female', 'Man', 'Woman')
gender
```

```
##             condition agender not sure other androgynous nonbinary two spirited
## 1     Placebo Control      19       71    32          50       128            5
## 2 Project Personality      23       65    28          55       129            6
## 3         Project ABC      12       60    27          52       127            5
##   Trangender female to male trans female trans male Gender expansive
## 1                        59            7         67                7
## 2                        62            9         64                9
## 3                        59            9         65               11
##   Third gender Genderqueer Transgender male to female Man Woman  NA
## 1            2          46                          6 122    70 514
## 2            3          49                          6 126    58 516
## 3            1          45                          3 115    58 514
```

Für das biologische Geschlecht und die sexuelle Orientierung können wir die Ergebnisse mittels einfacher Häufigkeitstabeller erzeugen:

``` r
# Biologisches Geschlecht
table(cope$sex, cope$condition)
```

```
##                    
##                     Placebo Control Project Personality Project ABC
##   Female                        723                 719         718
##   Male                           87                  78          86
##   Other                           2                   7          12
##   Prefer not to say               6                   9           5
```

``` r
# Sexuelle Orientierung
table(cope$orientation, cope$condition)
```

```
##                                    
##                                     Placebo Control Project Personality
##   Asexual                                        39                  38
##   Bisexual                                      228                 220
##   Gay/Lesbian/Homosexual                         86                  91
##   Heterosexual/Straight                         172                 165
##   I do not use a label                           52                  47
##   I do not want to respond                        3                   2
##   Other/Not listed (please specify)              32                  38
##   Pansexual                                      87                  79
##   Queer                                          49                  51
##   Unsure/Questioning                             70                  82
##                                    
##                                     Project ABC
##   Asexual                                    46
##   Bisexual                                  230
##   Gay/Lesbian/Homosexual                     76
##   Heterosexual/Straight                     161
##   I do not use a label                       41
##   I do not want to respond                    5
##   Other/Not listed (please specify)          23
##   Pansexual                                  98
##   Queer                                      47
##   Unsure/Questioning                         94
```

Und zu guter Letzt noch die mittlere Ausprägung des Primäroutcomes (Depressive Symptomatik) getrennt nach Interventionsgruppe zur Baseline. Dabei ist zu bedenken, dass die Variable im Datensatz als Mittelwert vorliegt (und auch in späteren Berechnungen so verwendet wird), in dieser Tabelle allerdings als Summenscore angegeben wird. Daher müssen wir den Mittelwert wieder mit der Anzahl der Items (12) multipliuieren:


``` r
# Baseline CDI
psych::describeBy(cope$CDI1*12, cope$condition)
```

```
## 
##  Descriptive statistics by group 
## group: Placebo Control
##    vars   n  mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 818 14.31 4.12   14.5   14.42 5.19   1  24    23 -0.25    -0.46 0.14
## ------------------------------------------------------------ 
## group: Project Personality
##    vars   n  mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 813 14.22 4.13     14   14.35 4.45   3  24    21 -0.28    -0.28 0.15
## ------------------------------------------------------------ 
## group: Project ABC
##    vars   n  mean   sd median trimmed  mad min max range  skew kurtosis   se
## X1    1 821 14.15 4.06     14   14.25 4.45   0  24    24 -0.25    -0.27 0.14
```

Im Artikel präsentieren [Schleider et al. (2022)](https://doi.org/10.1038/s41562-021-01235-0) in Tabelle 2 außerdem die Akzeptanz bzw. Zufriedenheit mit der jeweiligen Intervention, die wir ebenfalls sehr leicht rekonstruieren können: 


``` r
# Akzeptanz
pfs <- subset(cope, select = c('condition', grep('pfs_', names(cope), value = TRUE))) |> na.omit()
describeBy(pfs, pfs$condition)
```

```
## 
##  Descriptive statistics by group 
## group: Placebo Control
##           vars   n mean   sd median trimmed  mad min max range  skew kurtosis
## condition    1 630 1.00 0.00      1    1.00 0.00   1   1     0   NaN      NaN
## pfs_1        2 630 3.80 0.79      4    3.83 0.00   1   5     4 -0.57     0.71
## pfs_2        3 630 4.54 0.56      5    4.59 0.00   2   5     3 -0.86     0.66
## pfs_3        4 630 4.46 0.64      5    4.53 0.00   2   5     3 -0.97     0.87
## pfs_4        5 630 4.45 0.65      5    4.53 0.00   1   5     4 -0.97     0.91
## pfs_5        6 630 4.24 0.81      4    4.34 1.48   1   5     4 -0.96     0.83
## pfs_6        7 630 3.97 0.95      4    4.07 1.48   1   5     4 -0.67    -0.18
## pfs_7        8 630 4.50 0.62      5    4.58 0.00   2   5     3 -0.98     0.49
##             se
## condition 0.00
## pfs_1     0.03
## pfs_2     0.02
## pfs_3     0.03
## pfs_4     0.03
## pfs_5     0.03
## pfs_6     0.04
## pfs_7     0.02
## ------------------------------------------------------------ 
## group: Project Personality
##           vars   n mean   sd median trimmed  mad min max range  skew kurtosis
## condition    1 653 2.00 0.00      2    2.00 0.00   2   2     0   NaN      NaN
## pfs_1        2 653 3.83 0.77      4    3.84 0.00   1   5     4 -0.41     0.36
## pfs_2        3 653 4.48 0.64      5    4.55 0.00   1   5     4 -1.18     2.02
## pfs_3        4 653 4.39 0.68      4    4.49 1.48   2   5     3 -0.94     0.73
## pfs_4        5 653 4.45 0.67      5    4.55 0.00   1   5     4 -1.20     1.83
## pfs_5        6 653 4.20 0.83      4    4.31 1.48   1   5     4 -1.09     1.50
## pfs_6        7 653 3.93 1.00      4    4.05 1.48   1   5     4 -0.72    -0.07
## pfs_7        8 653 4.47 0.70      5    4.59 0.00   1   5     4 -1.40     2.37
##             se
## condition 0.00
## pfs_1     0.03
## pfs_2     0.02
## pfs_3     0.03
## pfs_4     0.03
## pfs_5     0.03
## pfs_6     0.04
## pfs_7     0.03
## ------------------------------------------------------------ 
## group: Project ABC
##           vars   n mean   sd median trimmed  mad min max range  skew kurtosis
## condition    1 729 3.00 0.00      3    3.00 0.00   3   3     0   NaN      NaN
## pfs_1        2 729 3.93 0.73      4    3.95 0.00   1   5     4 -0.35     0.07
## pfs_2        3 729 4.46 0.59      5    4.50 0.00   2   5     3 -0.64    -0.11
## pfs_3        4 729 4.42 0.64      4    4.50 1.48   2   5     3 -0.81     0.32
## pfs_4        5 729 4.42 0.69      5    4.52 0.00   1   5     4 -1.01     0.85
## pfs_5        6 729 4.30 0.76      4    4.41 1.48   1   5     4 -0.92     0.52
## pfs_6        7 729 4.12 0.89      4    4.22 1.48   1   5     4 -0.84     0.26
## pfs_7        8 729 4.54 0.57      5    4.59 0.00   3   5     2 -0.76    -0.43
##             se
## condition 0.00
## pfs_1     0.03
## pfs_2     0.02
## pfs_3     0.02
## pfs_4     0.03
## pfs_5     0.03
## pfs_6     0.03
## pfs_7     0.02
```


## Dropout

Schwieriger als im letzten Abschnitt wird es, wenn wir versuchen die Werte in Tabelle 3 des Artikels zu reproduzieren. Das liegt an folgendem Vorgehen, das auf S. 266 von [Schleider et al. (2022)](https://doi.org/10.1038/s41562-021-01235-0) beschrieben wird:

> We imputed participant-level missing data using the expectation-maximization and bootstrapping algorithm implemented with Amelia II in R, allowing more conservative intent-to-treat analyses than other approaches

Was hier beschrieben wird, ist der Umgang mit einem zentralen Problem in jeder Form längsschnittlicher Datenerhebung, das aber in der Psychotherapieforschung besonders relevant ist: dem Studienabbruch von Teilnehemden. Generell können wir niemals davon ausgehen, dass alle Personen, die zum ersten Zeitpunkt an einer Studie teilnehmen, dieser auch langfristig erhalten bleiben. Insbesondere, wenn die Studienteilnahme mit Anstrengungen oder Zeitaufwand verbunden ist (was quasi unumgänglich ist) oder wir z.B. Personen mit psychischen Störungen untersuchen, ist die Rate an Studienabbrüchen oft sehr hoch. [Cooper und Conklin (2015)](https://doi.org/10.1016/j.cpr.2015.05.001) zeigen in einer Meta-Analyse eine Drop-Out Rate von 17,5% bis 20% (wobei einzelne Studien von 0% bis 50% reichen) in klinischen RCT Studien. Generell ist es natürlich "schade" wenn Personen zu späteren Zeitpunkten nicht mehr an der Studie teilnehmen, weil wir so für Veränderungshypothesen weniger Power haben, aber das eigentliche Problem stellt sogenannter _differentieller Dropout_ dar. Damit ist gemeint, dass Personen aus unterschiedlichen Experimentalgruppen in unterschiedlichem Umfang und aus unterschiedlichen Gründen die Teilnahme an der Studie abbrechen. Das kann dazu führen, dass die Gruppen sich in ihrer Zusammensetzung verändern und damit die schönen Gruppeneigenschaften, für die wir uns extra ein Randomisierungsschema ausgedacht haben, wieder verloren gehen. So kann es passieren, dass Gruppen, die zwar zur Baseline noch direkt vergleichbar waren, im Verlauf der Zeit immer unterschiedlicher werden.

Der erste logische Schritt mit diesem Problem umzugehen ist es, festzustellen in welchem Ausmaß der Dropout über die Gruppen hinweg unterschiedlich ist. Im Artikel von [Schleider et al. (2022)](https://doi.org/10.1038/s41562-021-01235-0) wird auf S. 259 genau das getan. Um Häufigkeitsverteilung zwischen mehreren Gruppen zu vergleichen, wird üblicherweise der $\chi^2$ herangezogen:


``` r
dropouts <- table(cope$condition, cope$dropout1)
dropouts
```

```
##                      
##                       remain dropout
##   Placebo Control        631     187
##   Project Personality    653     160
##   Project ABC            730      91
```

``` r
prop.table(dropouts, margin = 1)
```

```
##                      
##                          remain   dropout
##   Placebo Control     0.7713936 0.2286064
##   Project Personality 0.8031980 0.1968020
##   Project ABC         0.8891596 0.1108404
```

``` r
chisq.test(dropouts)
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  dropouts
## X-squared = 41.469, df = 2, p-value = 9.888e-10
```
Wir sehen hier die Ergebnisse, die auch von  [Schleider et al. (2022)](https://doi.org/10.1038/s41562-021-01235-0) berichtet werden: es gibt einen statistisch bedeutsamen Unterschied in den Häufigkeiten des Teilnahmeabbruchs über die Gruppen hinweg ($\chi^2 = 41.47$, $df = 2$, $p < .001$) und zwar in der Form, dass im Project ABC deutlich seltener abgebrochen wird, als in den anderen beiden Gruppen. Diese unterschiedliche Quote des Abbruchs kann kausale Schlüsse hinsichtlich der Interventionen gefährden. Nähere Informationen dazu, wie wir bessere kausale Effektschätzer ermitteln können und was wir dabei bedenken müssen, finden Sie unter anderem in den beiden Beiträgen zur Kausaleffektschätzung mit [EffectLite](/lehre/klipps-legacy/kausaleffekte1-legacy/) bzw. [Propensity-Scores](/lehre/klipps-legacy/kausaleffekte2-legacy/).

Bevor wir untersuchen, ob die Tendenz zum Dropout auch mit anderen relevanten Variablen zusammenhängt, an dieser Stelle ein extrem kurzer Überblick über die drei Kategorien, anhand derer fehlende Werte statistisch unterschieden werden:

Typ | Abkürzung | Implikation
--- | -- | -------
Missing Completely at Random | MCAR | Fehlende Werte sind unabhängig von den beobachteten und nicht beobachteten Werten
Missing at Random | MAR | Fehlende Werte sind abhängig von den beobachteten Werten, aber nicht von den nicht beobachteten Werten
Missing Not at Random | MNAR | Fehlende Werte sind abhängig von den nicht beobachteten Werten

Was mit der Abhängigkeit von beobachteten bzw. nicht-beobachteten Werten gemeint ist, wir am besten mit ein paar Beispielen deutlich. MCAR sind üblicherweise fehlende Werte, die durch den Versuchsaufbau gezielt herbei geführt werden. Wenn wir zum Beispiel an extrem vielen Konstrukten interessiert sind, aber unsere Studienteilnehmenden nicht alle durch eine 4-stündige Erhebung quälen wollen, können wir die Personen randomisiert in Gruppen zuweisen, die jeweils unterschiedliche Kombinationen von Fragebögen in der Erhebung durchlaufen müssen. In diesem Fall hängt das Fehlen der Werte ausschließlich von dieser zufälligen Einteilung ab. Wenn wir zum Beispiel eine Erhebung mit Kindern in einer Schulstunde durchführen und die Befragung ziemlich genau auf die 45 Minuten angelegt ist, kann es vorkommen, dass einige Kinder aufgrund einer Dyslexie die Fragebögen sehr viel langsamer bearbeiten und so deren Werte auf den letzten Skalen fehlen. In diesem Fall liegt das Fehlen der Werte an der Dyslexie, also einer anderen Variablen, die wir (idealerweise) bereits zuvor irgendwo erfasst haben. Solche Fälle bezeichnet man als MAR (missing at random), weil sie nach der Kontrolle auf diese Störvariablen zufällig fehlen. Missing not at random (MNAR) sind Werte dann, wenn sie fehlen, weil Personen auf der spezifische Variable eine besondere Ausprägung haben. So kann es sein, dass Personen sich weigern Fragen zu ihrem Alkoholkonsum zu beantworten, wenn sie diesen selbst bereits als problematisch wahrnehmen und daher versuchen, ihn zu verbergen. Da in diesen Fällen das Fehlen von Werten von den Werten abhängt, die wir _nicht_ beobachten konnten, ist es hier sehr viel schwieriger das Problem fehlender Werte nach der Erhebung mit statistischen Modellen zu lösen. Gerade in der Psychotherapieforschung ist es aber nicht unwahrscheinlich, dass Personen die Studienteilnahme abbrechen, weil sie die Intervention nicht als wirksam erleben oder z.B. eine so schwere Episode erleiden, dass sie stationär behandelt werden müssen und somit nicht mehr an der Erhebung in der Ambulanz teilnehmen können.

### Prädiktoren des Dropouts

Wie Sie aus diesem (etwas zu lang geratenen) Absatz vermutlich ableiten können, sollten Entscheidungen zur Behandlung fehlender Werte vor allem auf inhaltlichen Überlegungen fußen. Statistisch können wir zumindest prüfen, ob die Variablen, die wir zum 1. Messzeitpunkt erhoben haben, prädiktiv für einen Teilnahmeabbruch sind und demzufolge die inhaltlichen und kausalen Schlussfolgerungen hinsichtlich der Interventionseffektivität gefährden würden. Dazu können wir im einfachsten Fall die logistische Regression, die wir im [letzten Beitrag](/lehre/klipps/logistische-regression-klinische) erarbeiteten hatten, nutzen, um das Fehlen von Werten vorherzusagen.

Für den Dropout während der Intervention gibt es die Variable `dropout1` als Indikator. Auf dieser Variable ist kodiert, ob Teilnehmende die 1. Frage des Fragebogen direkt nach Abschluss der Intervention ausgefüllt haben. In logistischer Regression können wir diese also relativ einfach durch die Baselinevariablen vorhersagen, um zu sehen, ob es spezifische Prädiktoren für den Abbruch gibt. Damit ich die Namen der Prädiktoren nicht alle einzeln hinschreiben muss, erzeuge ich mir erst einen Datensatz, der nur die relevanten Variablen enthält und nutze dann alle darin enthaltenen Variablen als Prädiktoren.


``` r
# Datenauswahl zur Dropout-Vorhersage
drop_dat <- cope[, c('dropout1', grep('^gender', names(cope), value = TRUE),
    grep('^race', names(cope), value = TRUE),
    'age', 'CDI1', 'CTS1', 'GAD1', 'SHS1', 'BHS1', 'DRS1')]

# Vorhersage von Dropout mit logistischer Regression
drop_mod <- glm(dropout1 ~ ., drop_dat, family = 'binomial')
```

<details><summary><b>Die etwas lange Ergebnistablle</b></summary>

``` r
summary(drop_mod)
```

```
## 
## Call:
## glm(formula = dropout1 ~ ., family = "binomial", data = drop_dat)
## 
## Coefficients:
##                                                             Estimate Std. Error
## (Intercept)                                               -1.1265595  0.9556823
## gender_agender                                             0.3519673  0.3396431
## gender_not_sure                                            0.3402405  0.1911349
## gender_other_please_specify                               -0.2544671  0.3329464
## gender_androgynous                                         0.1737942  0.2319843
## gender_nonbinary                                          -0.0975538  0.1828862
## gender_two_spirited                                       -0.2538865  0.6957078
## gender_female_to_male_transgender_ftm                     -0.1902710  0.3378816
## gender_trans_female_trans_feminine                        -0.3975158  0.6297381
## gender_trans_male_trans_masculine                          0.0045856  0.3441799
## gender_gender_expansive                                   -0.4966064  0.5822746
## gender_third_gender                                        0.5610380  0.9150772
## gender_genderqueer                                         0.1308056  0.2427265
## gender_male_to_female_transgender_mtf                      0.5355085  0.6830419
## gender_man_boy                                            -0.0676839  0.2185922
## gender_transgender                                         0.1316265  0.3060697
## gender_woman_girl                                         -0.0771633  0.1724972
## race_american_indian_or_alaska_native                      0.5570829  0.2467266
## race_asian_including_asian_desi                            0.1100817  0.1935428
## race_hispanic_latinx                                       0.1191387  0.1677376
## race_native_hawaiian_or_other_pacific_islander            -0.3416961  0.4929787
## race_white_caucasian_non_hispanic_includes_middle_eastern  0.2468457  0.1657302
## race_black_african_american                               -0.0415952  0.2034652
## race_other_specify                                         0.3813399  0.3768827
## race_prefer_not_to_answer                                 -0.6705623  0.7603591
## age                                                       -0.0476536  0.0567854
## CDI1                                                      -0.1423414  0.2471832
## CTS1                                                       0.0017235  0.0985556
## GAD1                                                      -0.0507514  0.0924135
## SHS1                                                       0.0174072  0.0499594
## BHS1                                                       0.2132303  0.1010266
## DRS1                                                       0.0002739  0.1357147
##                                                           z value Pr(>|z|)  
## (Intercept)                                                -1.179   0.2385  
## gender_agender                                              1.036   0.3001  
## gender_not_sure                                             1.780   0.0751 .
## gender_other_please_specify                                -0.764   0.4447  
## gender_androgynous                                          0.749   0.4538  
## gender_nonbinary                                           -0.533   0.5937  
## gender_two_spirited                                        -0.365   0.7152  
## gender_female_to_male_transgender_ftm                      -0.563   0.5733  
## gender_trans_female_trans_feminine                         -0.631   0.5279  
## gender_trans_male_trans_masculine                           0.013   0.9894  
## gender_gender_expansive                                    -0.853   0.3937  
## gender_third_gender                                         0.613   0.5398  
## gender_genderqueer                                          0.539   0.5900  
## gender_male_to_female_transgender_mtf                       0.784   0.4330  
## gender_man_boy                                             -0.310   0.7568  
## gender_transgender                                          0.430   0.6672  
## gender_woman_girl                                          -0.447   0.6546  
## race_american_indian_or_alaska_native                       2.258   0.0240 *
## race_asian_including_asian_desi                             0.569   0.5695  
## race_hispanic_latinx                                        0.710   0.4775  
## race_native_hawaiian_or_other_pacific_islander             -0.693   0.4882  
## race_white_caucasian_non_hispanic_includes_middle_eastern   1.489   0.1364  
## race_black_african_american                                -0.204   0.8380  
## race_other_specify                                          1.012   0.3116  
## race_prefer_not_to_answer                                  -0.882   0.3778  
## age                                                        -0.839   0.4014  
## CDI1                                                       -0.576   0.5647  
## CTS1                                                        0.017   0.9860  
## GAD1                                                       -0.549   0.5829  
## SHS1                                                        0.348   0.7275  
## BHS1                                                        2.111   0.0348 *
## DRS1                                                        0.002   0.9984  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 2290.4  on 2446  degrees of freedom
## Residual deviance: 2262.4  on 2415  degrees of freedom
##   (5 observations deleted due to missingness)
## AIC: 2326.4
## 
## Number of Fisher Scoring iterations: 4
```
</details>




Von den 32 Tests der Regressionsgewichte sind insgesamt 2 statistisch bedeutsam, was zunächst nicht vielsagend wirkt (wenn man die 5% Irrtumswahrscheinlichkeit bedenkt). Oder etwas wissenschaftlicher ausgedrückt: nach Bonferroni-Holm Adjustierung liegt der niedrigste $p$-Wert der Regressionsgewichte bei 0.766. Auch die Confusion-Matrix, die wir [im letzten Beitrag](/lehre/klipps/logistische-regression-klinische#klassifikationsgute) genutzt hatten, um die Güte des Modells genauer zu beurteilen, deutet darauf hin, dass wir nicht besonders gut in der Lage sind, den Dropout anhand der Baselinevariablen vorherzusagen (weil wir für beinahe alle Personen vorhersagen, dass sie zum 2. Zeitpunkt teilnehmen):


``` r
# Vorgesagte Werte
cope$dropout_pred <- predict(drop_mod, cope, type = 'response') > .5
cope$dropout_pred <- factor(cope$dropout_pred, labels = c('remain', 'dropout'))

# Confusion Matrix
caret::confusionMatrix(cope$dropout_pred, cope$dropout1)
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction remain dropout
##    remain    2012     434
##    dropout      0       1
##                                           
##                Accuracy : 0.8226          
##                  95% CI : (0.8069, 0.8376)
##     No Information Rate : 0.8222          
##     P-Value [Acc > NIR] : 0.4917          
##                                           
##                   Kappa : 0.0038          
##                                           
##  Mcnemar's Test P-Value : <2e-16          
##                                           
##             Sensitivity : 1.000000        
##             Specificity : 0.002299        
##          Pos Pred Value : 0.822567        
##          Neg Pred Value : 1.000000        
##              Prevalence : 0.822231        
##          Detection Rate : 0.822231        
##    Detection Prevalence : 0.999591        
##       Balanced Accuracy : 0.501149        
##                                           
##        'Positive' Class : remain          
## 
```
### Umgang mit Dropouts 

Dass sich Abbrecher*innen hinsichtlich ihrer Baselineeigenschaften kaum von Personen unterscheiden, die zum 2. Zeitpunkt teilgenommen haben, bietet jedoch keine Sicherheit, dass die Dropouts tatsächlich MCAR sind. Genausogut könnten die fehlenden Werte davon abhängen, dass die Personen die Intervention nicht gut fanden (und dementsprechend andere Effekte der Interventionen für sie gelten) oder durch andere Baseline-Kovariaten gesteuert sein, die einfach nicht erhoben wurden (z.B. Gewissenhaftigkeit). Üblicherweise werden daher in der Psychotherapieforschung mehrere Schätzer der Effekte bestimmt, welche eine Einengung des tatsächlichen Effekts erlauben sollen. Als "Obergrenze" wird dabei die Schätzung angesehen, die aus der Analyse der vollständigen Beobachtungen (sogenannte _Complete Case Analysis_, CCA) hervorgeht. Die Annahme ist dabei, dass Personen deren Outcomes besonders gut sind, dem Treatment treu bleiben. Dem gegenüber kann als "Untergrenze" die Analyse aller Personen angesehen werden, die mit dem Treatment begonnen haben (sogennantes _Intent-to-Treat_, ITT). Dabei stellt sich natürlich die Frage, welche Werte genutzt werden sollen, um die fehlenden Werte zu ersetzen. Eine der klassischen Methoden ist es, die zuletzt gemachte Beobachtung zu kopieren und somit für die Personen, die abgebrochen haben, anzunehmen, dass sie sich nicht verändert hätten. In der Psychotherapieforschung wird diese Methode oft als _Last Observation Carried Forward_ (LOCF) bezeichnet. Neben diesen eher klassischen Methoden gibt es außerdem eine Vielzahl von modernen statistischen Verfahren, welche verwendet werden können, um bessere Schätzungen dieser fehlenden Werte zu erhalten. Im Artikel von [Schleider et al. (2022)](https://doi.org/10.1038/s41562-021-01235-0) wird die multiple Imputation verwendet, die in R zum Beispiel im Paket `Amelia` oder `mice` implementiert ist. Andere Methoden sind zum Beispiel die Nutzung von Propensity scores (wie sie im [dazugehörigen Beitrag](/lehre/klipps-legacy/kausaleffekte2-legacy/) vorgestellt werden) oder generalized estimating equations.

Hier werden wir uns erst einmal auf die klassischen Methoden beschränken und CCA und LOCF nutzen, um eine grobe Vorstellung von den Interventionseffekten zu bekommen. Die Umsetzung mit Amelia, die im Artikel von [Schleider et al. (2022)](https://doi.org/10.1038/s41562-021-01235-0) durchgeführt wurde ist aber im entsprechenden [Skript im OSF-Repo](https://osf.io/uhzdx) zu finden. Um LOCF auch umsetzen zu können, müssen wir einen Datensatz erstellen, in dem alle fehlenden Werte durch den vorangegangenen Wert ersetzt sind:


``` r
locf <- cope

# LOCF, post-intervention
locf$SHS2 <- ifelse(is.na(locf$SHS2), locf$SHS1, locf$SHS2)
locf$BHS2 <- ifelse(is.na(locf$BHS2), locf$BHS1, locf$BHS2)

# LOCF, follow-up
locf$CDI3 <- ifelse(is.na(locf$CDI3), locf$CDI1, locf$CDI3)
locf$CTS3 <- ifelse(is.na(locf$CTS3), locf$CTS1, locf$CTS3)
locf$GAD3 <- ifelse(is.na(locf$GAD3), locf$GAD1, locf$GAD3)
locf$SHS3 <- ifelse(is.na(locf$SHS3), locf$SHS2, locf$SHS3)
locf$BHS3 <- ifelse(is.na(locf$BHS3), locf$BHS2, locf$BHS3)
locf$DRS3 <- ifelse(is.na(locf$DRS3), locf$DRS1, locf$DRS3)
```

Hier nutzen wir `ifelse`, um zu prüfen, ob auf einer Variable ein fehlender Wert vorliegt. Wenn dem so ist (zweites Argument) wird der Wert durch den Wert der vorherigen Messung ersetzt, ansonsten durch den beobachteten Werte (drittes Argument).

## ANCOVA

Nachdem wir uns nun ausführlich mit dem Problem des Dropouts beschäftigt haben, kommen wir zum eigentlich Punkt dieses Beitrags zurück. Mit der ANCOVA können wir Gruppenunterschiede testen, während wir gleichzeitig auf Kovariaten kontrollieren. Häufig ist dabei der Wert des Outcomes zur Baseline die zentrale Kovariate, aber letztlich ist jede Kovariate dabei denkbar. Im Artikel von [Schleider et al. (2022)](https://doi.org/10.1038/s41562-021-01235-0) werden anhand verschiedener ANCOVAs die Effekt der Intervention auf dem Primär- und allen Sekundäroutcomes überprüft. Die Ergebnisse werden allerdings nicht im Artikel selbst, sondern in der [Supplementary Information](https://static-content.springer.com/esm/art%3A10.1038%2Fs41562-021-01235-0/MediaObjects/41562_2021_1235_MOESM1_ESM.docx) berichtet.

Wir können uns hier zunächst auf das Primäroutcome konzentrieren und werden dabei auch ein wenig vom Vorgehen von Schleider et al. (2022) abweichen. Zum Einen haben wir nicht mit der Multiple Imputation gearbeitet, zum Anderen werden wir auch noch die _generalisierte_ ANCOVA nutzen, um zu untersuchen, ob die unterschiedlichen Interventionen differentielle Effekte aufweisen. Zunächst aber die klassische ANCOVA.

Im Artikel wird die ANCOVA genutzt, um sicherzustellen, dass die Unterschiede zwischen den Gruppen _bedingt auf_ die Werte zum ersten Zeitpunkt interpretiert werden können. Gucken wir uns am besten genauer an, was ich damit meine:


``` r
# ANOVA model
mod1a <- lm(CDI3 ~ condition, cope)

# Einfache ANCOVA, Primäres Outcome
mod1b <- lm(CDI3 ~ CDI1 + condition, cope)

# Ergebniszusammenfassung
summary(mod1a)$coef
```

```
##                                 Estimate Std. Error   t value    Pr(>|t|)
## (Intercept)                   1.02153189 0.01858446 54.966995 0.000000000
## conditionProject Personality -0.06423590 0.02662101 -2.412977 0.015942071
## conditionProject ABC         -0.08573422 0.02619276 -3.273203 0.001087564
```

``` r
summary(mod1b)$coef
```

```
##                                 Estimate Std. Error   t value      Pr(>|t|)
## (Intercept)                   0.28877000 0.03473185  8.314271  2.045693e-16
## CDI1                          0.63253736 0.02667575 23.712071 8.236480e-106
## conditionProject Personality -0.07184018 0.02271155 -3.163156  1.591992e-03
## conditionProject ABC         -0.08560924 0.02234397 -3.831425  1.326652e-04
```
Wie immer in der 
