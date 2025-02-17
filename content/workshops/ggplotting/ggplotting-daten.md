---
title: "Datenaufbereitung für ggplotting" 
type: post
date: '2019-10-18' 
slug: ggplotting-daten
categories: ["ggplotting"]
tags: ["ggplotting", "Datenaufbereitung", "Datenmanagement"] 
subtitle: ''
summary: '' 
authors: [schultze] 
weight: 7
lastmod: '2025-02-07'
featured: no
banner:
  image: "/header/disc_reader.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/669159)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /workshops/ggplotting/ggplotting-daten
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /workshops/ggplotting/ggplotting-daten.R
output:
  html_document:
    keep_md: true
---




An dieser Stelle beschreiben wir kurz, wie die Daten für die ggplotting-Inhalte zustande gekommen sind. Den [{{< icon name="download" pack="fas" >}} fertigen Datesatz zum Download](/daten/edu_exp.rda) stellen wir auch direkt bereit, aber mit den hier dargestellten Befehlen kann dieser komplett ohne irgendwelche Schritte außerhalb R erzeugt werden. 

## Daten von Gapminder

[Gapminder](https://www.gapminder.org/) stellt online ein Dashboard zur Interaktion mit diversen Daten auf nationaler Ebene zur Verfügung. Neben der interaktiven Oberfläche stellen Gapminder aber auch noch statisch alle Datensaätze über ihr [GitHub-Repository](https://github.com/open-numbers/ddf--gapminder--systema_globalis) zur Verfügung. Das ist für unseren Gebrauch perfekt, weil die Daten im .csv-Format vorliegen und somit direkt aus R abrufbar sind. 

Um mir die Arbeit mit den Daten ein wenig zu erleichtern, nutze ich an dieser Stelle `dplyr` - ein weit verbreitetes Paket für das Datenmanagement in R. Das Paket ist wie `ggplot2` auch Teil des [tidyverse](https://www.tidyverse.org/). Es ist nicht zwingend erforderlich das Paket zu nutzen, aber es enthält ein paar Funktionen, die besonders das zusammenführen verschiedener Datensätze erheblich vereinfachen.


```r
library(dplyr)
library(tidyr)
```

Die Datensätze, die wir benutzen werden können größtenteils über das [github-Repository von Gapminder](https://github.com/open-numbers/ddf--gapminder--systema_globalis) bezogen werden. Die Dateinamen sind dabei zwar gut strukturiert, aber nicht unbedingt kurz, wodurch die folgenden paar Zeilen R code etwas unübersichtlich wirken können. 


```r
# Geografische Informationen
raw_geo <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/ddf--entities--geo--country.csv')

# Populationsdaten
pop <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--fasttrack/master/countries_etc_datapoints/ddf--datapoints--pop--by--country--time.csv')

# Lebenserwartung
expect <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/countries-etc-datapoints/ddf--datapoints--life_expectancy_at_birth_data_from_ihme--by--geo--time.csv')

# Einkommen (GDP / Person)
income <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/countries-etc-datapoints/ddf--datapoints--gdppercapita_us_inflation_adjusted--by--geo--time.csv')

# Investition in Bildung (nach Bildungsstufe getrennt)
primary <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/countries-etc-datapoints/ddf--datapoints--expenditure_per_student_primary_percent_of_gdp_per_person--by--geo--time.csv')
secondary <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/countries-etc-datapoints/ddf--datapoints--expenditure_per_student_secondary_percent_of_gdp_per_person--by--geo--time.csv')
tertiary <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/countries-etc-datapoints/ddf--datapoints--expenditure_per_student_tertiary_percent_of_gdp_per_person--by--geo--time.csv')
```

Zuerst benötigen wir ein paar Informationen über die Länder, die wir später vielleicht noch gebrauchen können. Dazu benutzen wir hier mal ein paar grundlegende geografische Informationen (`raw_geo`), die Bevölkerungsgröße (`pop`), die Lebenserwartung (`expect`) und das skalierte Bruttoinlandsprodukt (GDP / Person, `income`). Als Bildungsindikatoren haben wir außerdem die Investitionen ins Bildungssystem durch die jeweiligen Nationen in Prozent der jährlichen Wirtschaftsleistung einer Person (GDP / Person). Diese werden bei der Weltbank in drei Sektoren unterteilt: primary (in Deutschland z.B. die Grundschule), secondary (in Deutschland z.B. Sekundarschulen, Gymnasien und Berufsschulen) und tertiary (in Deutschland z.B. Universitäten und Berufsakademien). 

Ein letzter Datensatz stammt vom [United Nations Development Programme](http://www.undp.org/), welches in den Human Development Reports unter anderem Indizes zum Entwicklungsstand von Ländern berichtet. Der bekannteste ist wahrscheinlich der [Human Development Index](https://hdr.undp.org/data-center/human-development-index#/indicies/HDI), welcher sich aus den drei Komponenten Lebenserwartung, Bildung und Einkommen zusammensetzt. Hier benutzen wir den Education Index, den wir zunächst noch händisch berechnen müssen. Erst einmal muss der Datensatz geladen und die Ländercodes angeglichen werden, damit wir die Datensätze später zusammenführen können:


```r
hdr <- read.csv('https://hdr.undp.org/sites/default/files/2023-24_HDR/HDR23-24_Composite_indices_complete_time_series.csv')
names(hdr)[1] <- 'geo'
hdr$geo <- tolower(hdr$geo)
```

Dieser (relativ umfangreiche) Datensatz enthält pro Land eine Zeile, in der verschiedene globale Indizes gelistet sind (z.B. ist `le_1994` die _Life Expectancy_ im Jahr 1994). Für uns sind die _Expected Years of Schooling_ (`eys`) und die _Mean Years of Schooling_ (`mys`) von Bedeutung. Diese ziehen wir im nächsten Schritten (einzeln) aus dem Gesamtdatensatz und wandeln den Datensatz dann vom breiten ins lange Format um:


```r
eys <- select(hdr, geo, starts_with('eys_')) |> 
  pivot_longer(cols = -geo, names_to = 'year', values_to = 'eys',
    names_prefix = 'eys_') |> 
  mutate(year = as.integer(year))
```

```
## Warning: There was 1 warning in `mutate()`.
## ℹ In argument: `year = as.integer(year)`.
## Caused by warning:
## ! NAs durch Umwandlung erzeugt
```

```r
mys <- select(hdr, geo, starts_with('mys_')) |> 
  pivot_longer(cols = -geo, names_to = 'year', values_to = 'mys',
    names_prefix = 'mys_') |> 
  mutate(year = as.integer(year))
```

```
## Warning: There was 1 warning in `mutate()`.
## ℹ In argument: `year = as.integer(year)`.
## Caused by warning:
## ! NAs durch Umwandlung erzeugt
```

Zu guter Letzt werden diese beiden Informationen zusammen geführt und der Education Index (`index`) berechnet:


```r
edx <- merge(eys, mys, by = c('geo', 'year')) |> 
  mutate(index = round((mys/15 + eys/18)/2,2)) |>
  select(-eys, -mys) |> rename(time = year)
```

## Verschiedene Informationen zusammenführen

Diese Quellen an Information müssen wir in einen Datensatz zusammenführen, bevor wir sie in einer gemeinsamen Grafik darstellen können. Dazu möchte ich zunächst die geografischen Daten auf den Umfang notwendiger Informationen herunter reduzieren:


```r
geo <- transmute(raw_geo, geo = country, Country = name, Wealth = income_groups, Region = world_4region)
```

Hier kommt die `transmute`-Funktion aus dem `dplyr`-Paket zum Einsatz, die einen Datensatz (`raw_geo`) entgegennimmt und einen neuen Datensatz mit erstellten Variablen ausgibt. Hier benutze ich den Datensatz nur dazu, Variablen umzubenennen und gleichzeitig alle anderen Variablen wegzuwerfen. Im neuen Datensatz sind also nur noch vier Variablen übrig:


```r
names(geo)
```

```
## [1] "geo"     "Country" "Wealth"  "Region"
```


Diese geschrumpften Informationen müssen jetzt zunächst mit den Informationen zum den Ländern zusammengeführt werden. Dafür müssen wir wieder sicherstellen, dass die Variable, die das Land kodiert, in alle Datensätzen den gleichen Namen hat:


```r
names(pop)
```

```
## [1] "country" "time"    "pop"
```

```r
names(pop)[1] <- 'geo' 
```



```r
geo <- right_join(geo, pop, by = 'geo') |>
  full_join(expect, by = c('geo', 'time')) |>
  full_join(income, by = c('geo', 'time')) 
```

Hier kommen `dplyr` Funktionen zum Einsatz, die auf `_join` enden, um zwei Datensätze zusammenzuführen. In der ersten Zeile wird also der Datensatz mit den geografischen Informationen mit dem Datensatz zu den Bevölkerungszahlen zusammengeführt. `right_join` heißt dabei, dass alle Zeilen des rechten Datensatzes erhalten bleiben sollen. Zeilen im linken Datensatz, für die es keinen Partner auf der Matchingvariable `geo` gibt, werden verworfen. Anders als die geografischen Informationen in `geo` enthalten die anderen Datensätze Informationen, die sich mit der Zeit ändern. Daher enthalten diese Datensätze pro Land mehrere Datenpunkte zu unterschiedlichen Jahren, weswegen alle Zeilen des rechten Datensatzes beibehalten werden sollen. Die Länder im linken Datensatz, für die diese Informationen nicht vorliegen werden aber nicht in den gemeinsamen Datensatz übernommen, weil wir für diese keine weitere Verwendung haben.

Dieser Datensatz aus geografischen Daten und Bevölkerungszahlen wird dann mit den lang-ersehnten und in R Version 4.0.0 endlich eingetroffenen nativen Pipe-Operator `|>` in die nächste Zusammenführung mit der Lebenserwartung weitergrereicht. Dabei wird das Ergebnis einer Funktion von Links nach Rechts an eine neue Funktion als erstes Argument weitergegeben. Dazu wird `full_join` genutzt, weil beide Seiten jetzt Informationen über die Jahre hinweg enthalten, die von beiden Seiten jeweils beibehalten werden sollen. Damit die richtigen Jahre einander zugeordnet werden, benutzen wir außerdem als Matchingvariable jetzt nicht nur den Ländercode `geo` sondern auch die Jahreszahl `time`.

Die globalen Informationen über Länder sollen jetzt noch mit den spezifischen Bildungsinvestitionen zusammengeführt werden. Dazu kombinieren wir erst alle Bildungsinformationen in einen Datensatz:


```r
edu <- full_join(primary, secondary, by = c('geo', 'time')) |>
  full_join(tertiary, by = c('geo', 'time')) |>
  full_join(edx, by = c('geo', 'time'))
```

Hier benutzen wir `full_join` weil alle Datenpunkte aus beiden Datensätzen einbezogen werden sollen. Wenn die Ausgaben für Primär- und Sekundärbildung zusammengeführt sind, werden sie mit der Pipe `|>` an `full_join` weitergegeben und dort mit der Tertiärbildung zusammengeführt. Zu guter Letzt verbinden wir die geografischen und die bildungsbezogenen Informationen noch:


```r
edu_exp <- full_join(geo, edu, by = c('geo', 'time'))
```

Weil die uns hauptsächlich interessierenden Daten zu den Bildungsausgaben erst ab 1997 zuverlässig erhoben wurden, Lebenserwartung und Bevölkerungszahlen aber von 1800 bis 2100 geschätzt bzw. aufgezeichnet wurden, schränken wir den Datensatz noch auf die Spanne von 1997 bis 2017 ein und entfernen die Datenpunkte, die nicht eindeutig einem Land zugewiesen werden konnten:


```r
edu_exp <- filter(edu_exp, time <= 2018 & time > 1996) |>
  filter(!is.na(Country))
```


Die Namen der Variablen im Datensatz sind jetzt immmernoch alles andere als schön:


```r
names(edu_exp)
```

```
##  [1] "geo"                                                        
##  [2] "Country"                                                    
##  [3] "Wealth"                                                     
##  [4] "Region"                                                     
##  [5] "time"                                                       
##  [6] "pop"                                                        
##  [7] "life_expectancy_at_birth_data_from_ihme"                    
##  [8] "gdppercapita_us_inflation_adjusted"                         
##  [9] "expenditure_per_student_primary_percent_of_gdp_per_person"  
## [10] "expenditure_per_student_secondary_percent_of_gdp_per_person"
## [11] "expenditure_per_student_tertiary_percent_of_gdp_per_person" 
## [12] "index"
```

Weil wir die Variablen immer und immer wieder im Code ansprechen müssen, machen sich besonders prägnante, kurze Variablennamen gut. Die aktuellen Namen sind leider keins von beidem, daher müssen neue her:


```r
names(edu_exp)[-c(1:4)] <- c('Year', 'Population', 'Expectancy', 'Income', 'Primary', 'Secondary', 'Tertiary', 'Index')
```

## Überblick über die finalen Daten

Der Datensatz mit dem wir weiter arbeiten sieht also so aus:


```r
head(edu_exp)
```

```
##   geo     Country     Wealth Region Year Population Expectancy   Income Primary Secondary Tertiary
## 1 afg Afghanistan low_income   asia 1997   18452091       50.7       NA      NA        NA       NA
## 2 afg Afghanistan low_income   asia 1998   19159996       50.0       NA      NA        NA       NA
## 3 afg Afghanistan low_income   asia 1999   19887785       50.8       NA      NA        NA       NA
## 4 afg Afghanistan low_income   asia 2000   20130327       51.0 317.5845      NA        NA       NA
## 5 afg Afghanistan low_income   asia 2001   20284307       51.1 285.5022      NA        NA       NA
## 6 afg Afghanistan low_income   asia 2002   21378117       51.6 344.2242      NA        NA       NA
##   Index
## 1  0.18
## 2  0.19
## 3  0.20
## 4  0.20
## 5  0.21
## 6  0.22
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
  - `Primary`: Staatliche Ausgaben pro Schüler*in in der primären Bildung als Prozent des `income` (GDP pro Person)
  - `Secondary`: Staatliche Ausgaben pro Schüler*in in der sekundären Bildung als Prozent des `income` (GDP pro Person)
  - `Tertiary`: Staatliche Ausgaben pro Schüler\*in oder Student\*in in der tertiären Bildung als Prozent des `income` (GDP pro Person)
  - `Index`: Education Index des United Nations Development Programme
  
Eine Ausprägung von 100 auf der Variable `Primary` in Deutschland hieße also zum Beispiel, dass pro Schüler*in in der Grundschule das Äquivalent der Wirtschaftsleistung einer bzw. eines Deutschen ausgegeben würde. 50 hieße entsprechend, dass es die Hälfte dieser Wirtschaftsleistung in diese spezifische Schulausbildung investiert wird.
