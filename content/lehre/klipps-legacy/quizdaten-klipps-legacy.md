---
title: Daten für die Quiz
type: post
date: '2021-10-15'
slug: quizdaten-klipps-legacy
categories: [""]
tags: ["Daten"]
subtitle: ''
summary: 'Auf dieser Seite finden sich alle Datensätze für die Studienleistungen in KliPPsMSc5a. Die Quizze finden sich auf der Lernplattform moodle und sind nur für die Teilnehmenden des Moduls zugänglich.'
authors: [nehler, irmer, hartig]
lastmod: '2025-02-07'
featured: no 
banner:
  image: "/header/dog_with_glasses.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/734854)"
projects: []

reading_time: false 
share: false

links:
  # - icon_pack: fas
  #   icon: book
  #   name: Inhalte
  #   url: /lehre/klipps/regression-ausreisser
  # - icon_pack: fas
  #   icon: terminal
  #   name: Code
  #   url: /lehre/klipps/regression-ausreisser.R
  # - icon_pack: fas
  #   icon: pen-to-square
  #   name: Quizdaten
  #   url: /lehre/klipps/regression-ausreisser-quizdaten

output:
  html_document:
    keep_md: true
---






## Block 1: Wiederholung und Multiple Regression {#Block1}

Wie verwenden den Datensatz `Behandlungsform.rda`. Sie können den [{{<icon name = "download" pack = "fas">}} Datensatz "Behandlungsform.rda" hier herunterladen](/daten/Behandlungsform.rda). Liegt der Datensatz bspw. auf dem Desktop, so müssen wir den Dateipfad dorthin legen und können dann den Datensatz laden (wir gehen hier davon aus, dass Ihr PC "Musterfrau" heißt)


```r
load("C:/Users/Musterfrau/Desktop/Behandlungsform.rda")
```

Genauso sind Sie in der Lage, den Datensatz direkt aus dem Internet zu laden. Hierzu brauchen Sie nur die URL und müssen `R` sagen, dass es sich bei dieser um eine URL handelt, indem Sie die Funktion `url` auf den Link anwenden. Der funktionierende Befehl sieht so aus (wobei die URL in Anführungszeichen geschrieben werden muss):


```r
load(url("https://pandar.netlify.app/daten/Behandlungsform.rda"))
```

In dem Datensatz sind die Ausprägungen von 100 Personen auf 6 Variablen abgetragen. Dabei gibt es zwei kategoriale Variable: Auf Geschlecht gibt es hier die Ausprägungen männlich und weiblich, während die Therapieform zwischen Kontrollgruppe, KVT und einer Kombination aus KVT und Blended Care unterscheidet. Alle anderen Variablen können als intervallskaliert angenommen werden.


## Block 2: Generalisiertes lineares Modell {#Block2}

Das Quiz zu diesem Block beruht auf einer echten Untersuchung, deren Datensatz [hier](https://osf.io/a9vun/) im Open Science Framework abgelegt ist. In dem Datensatz wurde bspw. erhoben, was für potenziell traumatischen Erlebnissen eine Person ausgesetzt war und mittels der Live Event Checklist (LEC) zu welchem Grad. Weiterhin wurden die Depressionswerte anhand des Becks-Depression-Inventar (BDI) und die Anxiety-Werte durch die Zung Self-Rating Anxiety Scale (SAS) erhoben. Für unsere Berechnung brauchen wir nur einen Ausschnitt der Vielzahl an Variablen. Diesen extrahieren wir aus dem originalen Datensatz und erstellen damit einen Neuen für unsere Aufgaben. Da das Processing in diesem Fall sehr komplex ist, haben wir das für Sie übernommen. Mit folgendem Befehl laden Sie sich die modifizierte Version des Datensatzes in ihr Working Directory ein.


```r
source(url("https://pandar.netlify.app/lehre/klipps-legacy/preprocessing/Data_Processing_Quiz1.R"))
```

Falls Sie Interesse am Processing haben, können Sie den kommentierten File [{{<icon name = "download" pack = "fas">}} hier herunterladen](/lehre/klipps-legacy/preprocessing/Data_Processing_Quiz1.R).

Nun wollen wir noch die Inhalte des modifizierten Datensatzes beschreiben. In diesem ist die Variable Geschlecht (`gender`) in `m` und `w` unterteilt, wobei `m` Männer und `w` Frauen beschreibt. Die Variable mit den Anxiety Werten (`sas`) erfasst die kumulierten Werte aller Fragen aus der SAS, die eine 4-Punkt Likert-Skala benutzt. Die Variable mit den Depressionswerten (`bdi`) erfasst die kumulierten Werte aller Fragen aus dem BDI, das Antwortmöglichkeiten von 0 bis 3 anhand der Schwere der Symptomatik bewertet. Sowohl die Anxiety Werte als auch die Depressionswerte wurden ihrer Intensität nach gruppiert von 1 bis 4, wobei `1` keine auffällige Symptomatik beschreibt, `2` milde bis moderate Symptome, `3` moderate bis schwere Symptome und `4` schwere Symptome. Diese Werte sind in den Variablen `bdi_group` und `sas_group` zu finden. In der Variable `sexual_assault` wurde allen Personen, die sexuelle Gewalt direkt erfahren haben, eine `1` zugeteilt, während allen anderen Fällen eine `0` zugewiesen wurde. Die Variable `trauma_exp_form` beschreibt die Form des Trauma-Erlebnisses, ob dieses direkt erlebt wurde (markiert durch `direct experience`), also der Person selbst passiert ist oder indirekt (`indirect experience`), so dass sie es gesehen / mitbekommen hat. Die Variable `trauma_exp_kind` beschreibt dagegen, welcher Art das Trauma-Erlebnis war. Dabei wurden die verschiedenen LEC Fragen fünf verschiedenen Gruppen zugeteilt. Im Datensatz liegt diese Variable als Faktor mit 6 Abstufungen vor. Mit diesen 6 Abstufungen können die 5 verschiedene Arten von Traumata aus dem LEC und "kein Trauma" kodiert werden: Stufe `1` steht für Personen, die keine Art eines Traumas erlebt haben. Stufe `2` steht für schwere Krankheiten, `3` für sexuelle Gewalt, `4` für schwere Unfälle, `5` für körperliche Gewalt und `6` für Krieg oder Naturkatastrophen. In der Variable `future` wird anhand des Zimbardo Time Perspective Inventory (ZTPI) die Einstellung gegenüber der Zukunft erfasst, also ob es für diese klare Vorstellungen, Pläne und Ziele gibt oder nicht. Die Skala Past Negative des ZTPI wird in der Variable `past_neg` festgehalten und beschreibt wie oft eine Person negativ über die Vergangenheit denkt. Beide Skalen wurden durch 5-Punkt Likert-Skalen bewertet, deren Durchschnitt festgehalten wurde. Zuletzt wurde noch der Gesamtwert der Dissociative Experiences Scale in der Variable `dissociation` festgehalten. Diese Skala erhebt das Dissoziationserleben einer Person mit 28 Items in einer 11 Punkt Likert-Skala.

**Zum Abschluss noch ein Disclaimer zum Processing:** Bei der Erstellung der Variable `trauma_exp_art` wurde das Erleben mehrerer potentiell traumatischer Live Events ignoriert und die Personen dem jeweils ersten abgefragten traumatischen Erlebnis zugeteilt. Der Effekt mehrerer traumatischer Erlebnisse ist hiermit also nicht mehr erfassbar und kann dadurch die Ergebnisse verzerren. Ebenso wurden die Gruppen nur auf Basis von Item-Ähnlichkeit gebildet und nicht basierend auf empirischen Erkenntnissen. Das ist keine Grundlage für empirisch valide Forschung, sondern gilt einzig der Vereinfachung für die Übungsrechnung.

## Block 3: Hierarchische Regression {#Block3}

Im `R`-Teil des Quiz arbeiten Sie mit denselben Daten, die auch in der [PandaR-Einheit zur Hierarchischen Regression](/lehre/klipps-legacy/hierarchische-regression-klinisch-legacy) verwendet wurden.

Rufen Sie zunächst die folgenden Pakete auf (und installieren Sie diese mit `install.packages` falls nötig).


```r
library(dplyr)
library(ICC)
library(lme4)
library(interactions)
```

Führen Sie die folgende Syntax zur Fallauswahl, Variablenauswahl und Standardisierung der Variablen durch. Durch dieses Einladen und Aufbereiten sind Sie auf dem Stand, den Sie zum Start des Quiz brauchen.


```r
# Daten einlesen und vorbereiten 
lockdown <- read.csv(url("https://osf.io/dc6me/download"))

# Entfernen der Personen, für die weniger als zwei Messpunkte vorhanden sind
# (Auschluss von Fällen, deren ID nur einmal vorkommt)
lockdown <- lockdown[-which(lockdown$ID %in% names(which(table(lockdown$ID)==1))),] 

# Daten aufbereiten, Variablen auswählen extrahieren und in Nummern umwandeln
# Entfernen von Minderjährigen & unbestimmtes Gender mit den Funktionen filter() und select () aus dplyr.
lockdown <- lockdown %>%
  filter((Age >= 18) & (Gender == 1 | Gender == 2)) %>%
  select(c("ID", "Wave", "Age", "Gender", "Income", "EWB","PWB","SWB",
           "IWB","E.threat","H.threat", "Optimism",
           "Self.efficacy","Hope","P.Wisdom","ST.Wisdom","Grat.being",
           "Grat.world","PD","Acc","Time","EWB.baseline","PWB.baseline",
           "SWB.baseline","IWB.baseline"))

# Standardisieren der AVs
lockdown[,c("EWB", "PWB", "SWB", "IWB")] <- scale(lockdown[,c("EWB", "PWB", "SWB", "IWB")])
# Standardisieren möglicher Prädiktoren
lockdown[,c("E.threat", "H.threat", "Optimism", "Self.efficacy", "Hope", "P.Wisdom", 
            "ST.Wisdom", "Grat.being", "Grat.world")] <-
  scale(lockdown[,c("E.threat", "H.threat", "Optimism", "Self.efficacy", "Hope", "P.Wisdom", 
            "ST.Wisdom", "Grat.being", "Grat.world")])

# ID in Faktor Umwandeln
lockdown$ID <- as.factor(lockdown$ID)
```

Im Rahmen des Quiz sollen außerdem Fragen zu einer Studie, die das statistische Modell in der klinischen Forschung einsetzt, beantwortet werden. Eine groß angelegte Studie von Goldberg et al. (2016) untersuchte, ob Psychotherapeut*innen mit zunehmender Berufserfahrung bessere Therapieergebnisse erzielen. 

Goldberg, S. B., Rousmaniere, T., Miller, S. D., Whipple, J., Nielsen, S. L., Hoyt, W. T., & Wampold, B. E. (2016). Do psychotherapists improve with time and experience? A longitudinal analysis of outcomes in a clinical setting. *Journal of counseling psychology, 63*, 1-11.


## Block 4: Metaanalysen {#Block4}

Im `R`-Teil des Quizzes führen Sie Analysen am Datensatz der [2. PandaR-Sitzung zur Meta-Analyse](/lehre/klipps-legacy/metaanalysen-cor-legacy) durch.  Den Datensatz von Molloy et al. (2014) erhalten Sie mit dem Laden des `metafor`-Pakets:


```r
library(metafor)
```

Hier ist außerdem die Literaturangabe zum zugehörigen Paper:

[Molloy, G. J., O'Carroll, R. E., & Ferguson, E. (2014)](https://ubffm.hds.hebis.de/EBSCO/Record?id=RN347807174|edsbl). Conscientiousness and medication adherence: A meta-analysis. Annals of Behavioral Medicine, 47(1), 92–101. [https://doi.org/10.1007/s12160-013-9524-4](https://doi.org/10.1007/s12160-013-9524-4)

Zunächst soll eine herkömmliche Meta-Analyse durchgeführt werden, wie Sie auch in der [2. Sitzung](/lehre/klipps-legacy/metaanalysen-cor-legacy) bereits vorgeführt wurde. Allerdings geht es im Quiz um die Erweiterung durch Hinzunahme von Moderatoren.

Im nächsten Schritt soll anstelle der herkömmlichen eine psychometrische Metaanalyse durchgeführt werden. Zur Berechnung der korrigierten Korrelationen muss der ursprüngliche Datensatz `dat.molloy2014` um die Reliabilitäten erweitert werden. Wir haben dazu schon eine Vorarbeit gemacht und einige Reliabilitäten in einem Datensatz zusammengefasst. Sie können diesen Datensatz mit folgendem Befehl herunterladen:


```r
load(url('https://pandar.netlify.app/lehre/klipps-legacy/preprocessing/reliabilites.molloy2014.rda'))
```

Im nächsten Schritt soll der Datensatz mit den Reliabilitäten und der ursprüngliche Datensatz zusammengefasst werden. Dafür gibt es einige Möglichkeiten. Hier ist ein Beispiel aufgeführt: 


```r
data_combined <- dat.molloy2014
data_combined$rel1 <- reliabilites.molloy2014$RelGewissenhaftigkeit
data_combined$rel2 <- reliabilites.molloy2014$RelCondition
head(data_combined)
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> authors </th>
   <th style="text-align:right;"> year </th>
   <th style="text-align:right;"> ni </th>
   <th style="text-align:right;"> ri </th>
   <th style="text-align:left;"> controls </th>
   <th style="text-align:left;"> design </th>
   <th style="text-align:left;"> a_measure </th>
   <th style="text-align:left;"> c_measure </th>
   <th style="text-align:right;"> meanage </th>
   <th style="text-align:right;"> quality </th>
   <th style="text-align:right;"> rel1 </th>
   <th style="text-align:right;"> rel2 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Axelsson et al. </td>
   <td style="text-align:right;"> 2009 </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:right;"> 0.187 </td>
   <td style="text-align:left;"> none </td>
   <td style="text-align:left;"> cross-sectional </td>
   <td style="text-align:left;"> self-report </td>
   <td style="text-align:left;"> other </td>
   <td style="text-align:right;"> 22.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Axelsson et al. </td>
   <td style="text-align:right;"> 2011 </td>
   <td style="text-align:right;"> 749 </td>
   <td style="text-align:right;"> 0.162 </td>
   <td style="text-align:left;"> none </td>
   <td style="text-align:left;"> cross-sectional </td>
   <td style="text-align:left;"> self-report </td>
   <td style="text-align:left;"> NEO </td>
   <td style="text-align:right;"> 53.59 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.79 </td>
   <td style="text-align:right;"> 0.805 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bruce et al. </td>
   <td style="text-align:right;"> 2010 </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 0.340 </td>
   <td style="text-align:left;"> none </td>
   <td style="text-align:left;"> prospective </td>
   <td style="text-align:left;"> other </td>
   <td style="text-align:left;"> NEO </td>
   <td style="text-align:right;"> 43.36 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0.86 </td>
   <td style="text-align:right;"> 1.000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Christensen et al. </td>
   <td style="text-align:right;"> 1999 </td>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:right;"> 0.320 </td>
   <td style="text-align:left;"> none </td>
   <td style="text-align:left;"> cross-sectional </td>
   <td style="text-align:left;"> self-report </td>
   <td style="text-align:left;"> other </td>
   <td style="text-align:right;"> 41.70 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Christensen &amp; Smith </td>
   <td style="text-align:right;"> 1995 </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> 0.270 </td>
   <td style="text-align:left;"> none </td>
   <td style="text-align:left;"> prospective </td>
   <td style="text-align:left;"> other </td>
   <td style="text-align:left;"> NEO </td>
   <td style="text-align:right;"> 46.39 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0.85 </td>
   <td style="text-align:right;"> 1.000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Cohen et al. </td>
   <td style="text-align:right;"> 2004 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:left;"> none </td>
   <td style="text-align:left;"> prospective </td>
   <td style="text-align:left;"> other </td>
   <td style="text-align:left;"> NEO </td>
   <td style="text-align:right;"> 41.20 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 1.000 </td>
  </tr>
</tbody>
</table>

Um noch ein besseres Gefühl für Metaanalysen zu bekommen und um eine Studie zu betrachten, die nicht auch bereits im `metafor`-Paket integriert ist, sollen Sie sich für den inhaltichen Part des Quiz mit dem folgenden Artikel auseinandersetzen:

[Vahedi, Z., & Zannella, L. (2021).](https://ubffm.hds.hebis.de/EBSCO/Record?id=edsbas.FE6E6149|edsbas) The association between self-reported depressive symptoms and the use of social networking sites (SNS): A meta-analysis. Current Psychology: A Journal for Diverse Perspectives on Diverse Psychological Issues, 40(5), 2174–2189. [https://doi.org/10.1007/s12144-019-0150-6](https://doi.org/10.1007/s12144-019-0150-6)

Laden Sie sich dieses Paper zur Metaanalyse herunter, um die Fragen zu beantworten. Die sozialen Netzwerke wurden mit SNS abgekürzt, was für Social Networking Sites steht.



## Block 5a: Kausaleffekte {#Block5a}

In diesem Quiz widmen wir uns einem großen Datensatz zu den gesellschaftlichen und psychologischen Folgen der COVID-19-Pandemie. Die Datenerhebung zur „COVID-19 Psychological Research Consortium“-Studie (https://osf.io/v2zur/), kurz C19PRC, begann im März 2020 in mehreren Ländern primär in Großbritannien und wurde mittlerweile in insgesamt sechs Wellen fortgeführt. In diesem Quiz verwenden wir Daten zur Baseline aus den ersten beiden Erhebungswellen sowie aus der aktuellen Welle 6, welche im August und September 2021 in Großbritannien mittels Onlinebefragungen durchgeführt wurde. Der Datensatz hält eine Fülle von Variablen bereit, wobei wir uns für eine konkrete Frage interessieren: Welchen Einfluss hat eine (selbstberichtete) COVID-19 Infektion auf psychologische Variablen wie Depressionssymptome, Ängstlichkeit, posttraumatische Belastungssymptome oder allgemeines Wohlbefinden? Analog zu den vergangenen Sitzungen zu Kausaleffekten konnte auch hier die „Behandlung“, in diesem Fall eine Infektion mit COVID-19, nicht randomisiert zugeordnet werden, weswegen womöglich Drittvariablen den Einfluss der Infektion auf die psychologischen Variablen verzerren. Im
von uns vorbereiteten Datensatz zählen Personen zur infizierten Gruppe, die zur Baseline noch nicht infiziert waren, aber zur Welle 6 schon. 

Laden Sie den Datensatz folgendermaßen ein:


```r
load(url("https://pandar.netlify.app/daten/C19PRC.RData"))
```




## Block 5b: Netzwerkanalyse {#Block5b}

In diesem Quiz wird es um die besprochenen Formen der Netzwerkanalyse gehen. Dafür brauchen wir einen Datensatz für die querschnittliche und einen für die längsschnittliche Untersuchung. Weiterhin wird es auch Fragen zu einem Paper in der Anwendung geben. Stellen Sie zu Beginn sicher, dass Sie die beiden wichtigen Pakete geladen haben.


```r
library(qgraph)
library(bootnet)
```

Für die querschnittliche Netzwerkanalyse wollen wir mit einem Datensatz arbeiten, der sich mit Parental Burnout befasst. Dieser kann ganz leicht über das OSF in das Environment eingeladen werden.


```r
burnout <- read.csv(file = url("https://osf.io/qev5n/download"))
```

Vor der Bestimmung von Netzwerkstrukturen ist es wichtig, noch die erste Variable aus dem Datensatz zu entfernen, da diese nur eine ID ist und keine Aussagekraft hat.


```r
burnout <- burnout[2:8]
```

Die Daten wurden im Rahmen dieses Papers erhoben:

Blanchard, M. A., Roskam, I., Mikolajczak, M., & Heeren, A. (2021). A network approach to parental burnout. _Child Abuse & Neglect, 111_, 104826. [https://doi.org/10.1016/j.chiabu.2020.104826](https://doi.org/10.1016/j.chiabu.2020.104826)

Im zweiten Teil soll ein längsschnittlicher Datensatz betrachtet und damit eine idiografische Netzwerkanalyse durchgeführt werden. Die Datensatzaufbereitung (Fallreduktion, Detrending, Variablenauswahl, etc.) haben wir bereits für Sie erledigt. Die Daten wurden ursprünglich im Rahmen dieses Papers erhoben:

Fried, E. I., Papanikolaou, F., & Epskamp, S. (2021). Mental Health and Social Contact During the COVID-19 Pandemic: An Ecological Momentary Assessment Study. _Clinical Psychological Science_. [https://doi.org/10.1177/21677026211017839](https://doi.org/10.1177/21677026211017839)

Sie können die Daten mit folgendem Befehl direkt in Ihr Environment einladen.


```r
source(url("https://pandar.netlify.app/lehre/klipps-legacy/preprocessing/Data_Processing_Quiz4b.R"))
```

Sie erhalten einmal den Datensatz `data` und mit `rel_vars` eine Aufzählung aller Variablen, die Knoten im Netzwerk sein sollen. In dem Netzwerk wird der Zusammenhang von verschiedenen Angaben über die psychische Gesundheit in Zusammenhang mit der COVID-19 Pandemie untersucht.

Im Rahmen des Quiz wollen wir uns mit dem bereits im Tutorial genannten Paper von Frumkin et al. (2021) zur praktischen Anwendung der idiografischen Netzwerkanalyse beschäftigen.

Frumkin, M.R., Piccirillo, M.L., Beck, E.D., Grossman, J.T., & Rodebaugh, T.L. (2021). Feasibility and utility of idiographic models in the clinic: A pilot study. _Psychotherapy Research, 31_(4), 520-534. [https://doi.org/10.1080/10503307.2020.1805133](https://doi.org/10.1080/10503307.2020.1805133)

Beachten Sie, dass für den Vollzugriff eine Suche über Google Scholar oder ähnliche Suchmaschinen nötig ist.
