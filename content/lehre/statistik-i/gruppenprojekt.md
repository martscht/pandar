---
title: "Gruppenprojekt" 
type: post
date: '2019-10-18' 
slug: gruppenprojekt 
categories: ["Statistik I"] 
tags: ["Zusatz", "Gruppenprojekt", "Grundlagen"] 
subtitle: ''
summary: '' 
authors: [schueller, schultze, winkler, beitner, nehler]
weight: 12
lastmod: '2023-10-06'
featured: no
banner:
  image: "/header/group_post.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1220573)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/gruppenprojekt
  - icon_pack: fas
    icon: pen-to-square
    name: Ergebnisbericht
    url: /lehre/statistik-i/Ergebisbericht.R
  - icon_pack: fas
    icon: pen-to-square
    name: formr
    url: /lehre/statistik-i/formr
output:
  html_document:
    keep_md: true
---






Wie wir bereits im Praktikum besprochen haben, sollen Sie im Rahmen dieses empirischen Projekts eine erste eigene Befragung (Fragebogenstudie) konzipieren, diese durchführen und auswerten. Hier sollen die Grundlagen für die Generierung von Hypothesen sowie die Operationalisierung der Hypothesen (unter Beachtung der Skalenniveaus der erhobenen Daten) besprochen werden.
Wir haben alle wichtigen Informationen nochmals für Sie zusammengefasst. 
Sollten in der Zusammenarbeit in Ihrer Kleingruppe noch Fragen auftreten, wenden Sie sich bitte an Ihre/n Dozent:in.


{{< spoiler text = "Kernfragen der Lehreinheit" >}}
- Wie können geeignete [**Hypothesen generiert**](#Hypothesengenerierung) werden?
- Wie können diese [**Hypothesen operationalisiert**](#Operationalisierung) werden?
- Was ist [**Präregistrierung**](#Präregistrierung) und wie können Sie Ihr Projekt präregistrieren?
- Wie kann das in einem [**Online-Fragebogen**](#Online-Fragebogen) umgesetzt werden?
{{< /spoiler >}}

***

# Hypothesengenerierung {#Hypothesengenerierung}
Zunächst müssen Sie sich für ein Thema entscheiden und *theoriegeleitet* Hypothesen entwickeln, die Sie im Rahmen ihrer Befragung untersuchen möchten.

Eine Hypothese bezeichnet eine Aussage bzw. Annahme über einen Sachverhalt, die überprüft werden soll. Eine Hypothese muss deshalb testbar sein; es muss also möglich sein, mit einer geeigneten Methodik den Wahrheitsgehalt der Aussage zu überprüfen.

> **Exkurs:** Nach der Wissenschaftstheorie von Popper (1972) kann eine Hypothese niemals bewiesen, jedoch gegebenenfalls widerlegt (falsifiziert) werden (Induktionsproblem). Popper fordert deshalb, dass Aussagen falsifizierbar sein müssen, um als wissenschaftliche Hypothesen zu gelten.
> Die Hypothese "Alle Schwäne sind weiß." kann durch eine Beobachtung im Stadtpark nicht verifiziert werden. Nur weil wir dort keinen schwarzen Schwan beobachten, können wir nicht schlussfolgern, dass es einen solchen nicht anderswo gibt. Wir können jedoch - sollten wir einen schwarzen Schwan im Park beobachten - die Hypothese "Alle Schwäne sind weiß." widerlegen, also falsifizieren.
> Die Hypothese "Es gibt schwarze Schwäne." hingegen, ist nicht falsifizierbar, da es praktisch unmöglich zu beweisen ist, dass es nicht einen einzigen schwarzen Schwan auf der Welt gibt. Mehr zu Wissenschaftstheorie und zu Poppers kritischem Rationalismus erfahren Sie in PsyBSc 1.

In der Psychologie beziehen sich Hypothesen meist auf Merkmale der  Versuchspersonen, wie beispielsweise Persönlichkeitseigenschaften, Einstellungen, Leistungen, etc. (Wie wir diese Konstrukte quantifizieren - also messen - besprechen wir im [Abschnitt Operationalisierung](#Operationalisierung).)

> **Beispiel:** Sie könnten zum Beispiel die Konstrukte Prokrastination und Lebenszufriedenheit bei Studierenden im ersten Semester untersuchen.

Um eine Hypothese über den Zusammenhang der Konstrukte zu entwickeln, sollten Sie zunächst recherchieren, ob es bereits Studienergebnisse zu diesem Zusammenhang in der Literatur gibt.

> **Beispiel:** Sie finden dazu beispielsweise eine Studie von Yildiz & Müller (2018), die zeigt, dass Studierende, die zur Prokrastination neigen, eine geringere Lebenszufriedenheit aufweisen.

Daraus leiten Sie dann eine Erwartung bezüglich der Ergebnisse in Ihrer Studie ab. Dies ist Ihre Hypothese.

> **Beispiel:** Sie erwarten, dass Sie das Ergebnis von Yildiz & Müller (2018) replizieren, also dass Sie den selben Zusammenhang finden. Ihre Hypothese lautet dann beispielsweise: "Bei Psychologiestudierenden besteht ein negativer Zusammenhang zwischen der selbstberichteten Prokrastination und der Lebenszufriedenheit."

Im Rahmen des Berichtes im ersten Semesters gibt es eine Besonderheit: Sie können auch Fragestellungen untersuchen, zu denen Sie keine vorherigen Studien finden. Ihre Untersuchung wäre demnach explorativ - sie dürfen aber die Hypothesen aus Ihren Erwartungen aus dem Alltag ableiten.

Um Hypothesen prüfen zu können, sollten Sie darauf achten, mit welchem Skalenniveau Sie Ihre Variablen erhoben haben.

## Skalenniveaus

Im Rahmen dieses Praktikums müssen Sie mindestens zwei Fragestellungen untersuchen, die auch im Bericht behandelt werden und verschiedene Fragebogenniveaus abdecken.  In der Vorlesung haben Sie bereits folgende Übersicht über die verschiedenen Skalenniveaus und ein paar entsprechende deskriptivstatistische Maße kennengelernt:

Skala | Aussage | Transformation | Zentrale Lage | Dispersion
--- | --- | --- | --- | ---
Nominal | Äquivalenz | eineindeutig | Modus | relativer Informationsgehalt
Ordinal | Ordnung | monoton | Median | Interquartilsbereich
Intervall | Verhältnis von Differenzen | positiv linear | arith. Mittel | Varianz / SD
Verhältnis | Verhältnisse | Ähnlichkeit | ... | ...
Absolut | absoluter Wert | Identität | ... | ...

Kombinationen von Variablen führen - je nach Skalenniveau - häufig zu unterschiedlichen Arten von Hypothesen. Wie Sie in PsyBSc 1 noch sehen werden, können Hypothesen hinsichtlich der *Art der Aussage* in drei grobe Kategorien eingeteilt werden: Unterschiedshypothesen, Zusammenhangshypothesen und Veränderungshypothesen. Hinsichtlich der Kombination der beteiligten Variablen lassen sich die Hypothesen sehr grob kategorisieren. 

**Unterschiedshypothesen**

  * Nominal und Ordinal
  * Nominal und Intervall
  * Nominal und Verhältnis

**Zusammenhangshypothesen**

  * Ordinal und Intervall
  * Ordinal und Verhältnis
  * Intervall und Intervall
  * Intervall und Verhältnis


Diese beiden Kategorien von Hypothesen beschäftigen sich einfach gesagt entweder mit dem *Zusammenhang* zwischen zwei  Konstrukten (bspw. Persönlichkeitseigenschaften), oder aber mit dem *Unterschied* von verschiedenen Gruppen hinsichtlich dieser Konstrukte. Eine *Zusammenhangshypothese* bezieht sich auf mehrere verhältnis-, intervall- oder ordinalskalierte Variablen. Eine Unterschiedshypothese bezieht sich auf den Unterschied in der Ausprägung einer verhältnis-, intervall- oder ordinalskalierten Variablen in verschiedenen Gruppen, wobei die Gruppierungsvariable nominalskaliert ist. Zusammenhangs- und Unterschiedshypothesen unterscheiden sich nicht grundlegend im konzeptuellen Grundgedanken, sondern vor allem in der Wahl der Auswertungsmethode.

Für Ihren Bericht stellen Sie sowohl eine Zusammenhangs- als auch eine Unterschiedshypothese auf.

Veränderungshypothesen werden kein Teil Ihrer Untersuchung sein - trotzdem als Info: Sie grenzen sich von den beiden anderen Arten dahingehend ab, dass die unabhängige Variable immer die Zeit ist. Diese kann aber - je nachdem welche Genauigkeit vonnöten ist - anhand verschiedener Skalenniveaus angegeben werden. Unterscheiden wir nur zwischen zwei Messzeitpunkten (Nominal) oder ist die Anzahl von z.B. Tagen relevant (Intervall)?

Im Rahmen Ihres Gruppenprojekts sollen Sie zwei verschiedene Kombinationen der Skalenniveaus abdecken und dabei eine Unterschieds- und eine Zusammenhangshypothese darstellen. Achten Sie deshalb bei der Planung Ihrer Untersuchung darauf, dass Sie Daten erheben, welche die bestimmten (für Ihre Fragestellung nötigen) Skalenniveaus aufweisen. Dabei darf nur eine Paarung das Nominalskalenniveau enthalten.

> **Beispiel:** Bezogen auf die Datenerhebung am Anfang des Kurses könnten wir z.B. die beiden folgenden Hypothesen untersuchen:
>
> 1. Es besteht ein negativer Zusammenhang zwischen der Stärke der Prokrastination und der selbstberichteten Lebenszufriedenheit von Studierenden im ersten Semester.  (Zusammenhangshypothese, Intervall und Intervall)
> 2. Weibliche und männliche Studierende unterscheiden sich im Durchschnitt in ihren Prokrastinationstendenzen? (Unterschiedshypothese, Nominal und Intervall)

In der Umsetzung ihrer Befragung kommen die unterschiedlichen Skalenniveaus dadurch zustande, wie Sie die Fragen an Ihre Versuchspersonen formulieren. Deshalb müssen Sie bei der Gestaltung des Fragebogens darauf achten, welche Skalenniveaus in Konsequenz aus der Fragenformulierung resultieren wird.


| Beispielfrage | Antwortformat | Skalenniveau |
  |---|---|---|
  | "Wie alt sind Sie?" | Offenes Antwortformat | Intervallskaliert |
  | "Wie alt sind Sie?" | Auswahl aus Kategorien in 10-er Schritten (unter 20, 20 bis 29, 30 bis 39, ...)  | Ordinalskaliert |
  | "Bitte geben Sie Ihr Geschlecht an." | Auswahl aus weiblich, männlich und divers | Nominalskaliert |
  | "Ich bin begeisterungsfähig." | 6-stufige Antwortskala "Trifft absolut nicht zu" bis "Trifft genau zu"  | Ordinalskaliert (ggf. Intervallskaliert)  |
  | "Ich bin begeisterungsfähig." | Auswahl aus "Ja" oder "Nein" | Nominalskaliert (Sonderfall Dichotom)  |

Bitte stimmen Sie sich im Laufe der Hypothesengenerierung mit dem/der Dozent:in Ihres Kurses ab.


**Beispiele aus vergangengen Semestern:**

* Auswirkungen eines Nebenjobs auf das subjektive Stressempfinden im Psychologiestudium
  * Hypothese: Psychologiestudierende, die einem Nebenjob nachgehen, weisen im Durchschnitt ein höheres subjektives Stressempfinden auf als Psychologiestudierende, die keinem Nebenjob nachgehen.
* Unterschiede im Neurotizismus bei Raucher:innen und Nichtraucher:innen
  * Hypothese: Versuchspersonen, die rauchen, zeigen höhere durchschnittliche Neurotizismuswerte als Nichtraucher:innen.
* Soziale Angst bei Geschwister - und Einzelkindern
  * Hypothese: Versuchspersonen, die mindestens ein Geschwisterkind haben, zeigen im Durchschnitt geringere soziale Angst als Einzelkinder.
* Zusammenhang von Aggressivität und Fahrsicherheit
  * Hypothese: Es besteht ein negativer Zusammenhang zwischen der Aggressivität und der selbstberichteten Fahrsicherheit.
* Unterschiede im Studienerleben (hinsichtlich Stressempfinden) zwischen Personen mit allgemeiner Hochschulreife und denen mit anderen Zugangsberechtigungen.
  * Hypothese: Psychologiestudierende mit allgemeiner Hochschulreife weisen ein geringeres Stressempfinden im ersten Semester auf als Psychologiestudierende mit einem anderen Bildungsabschluss.


# Operationalisierung {#Operationalisierung}

> **Operationalisierung:** Eine relevante Fragestellung so präzisieren, dass sie in der verfügbaren Zeit anhand von Tatsachen, d. h. mit vorhandenen oder zu erhebenden Daten, untersucht und beantwortet werden kann.

Im nächsten Schritt müssen Sie ihre Hypothesen *operationalisieren*, das heißt die Konstrukte (wie beispielsweise Persönlichkeitseigenschaften) *messbar machen*. Viele psychologische Konstrukte sind nicht direkt messbar, so wie beispielsweise die Körpergröße eines Menschen, sondern können nur indirekt erfasst werden. Beispielsweise versucht man, latente Persönlichkeitseigenschaften durch Fragen innerhalb eines Fragebogens zu erheben.

* Fragebögen sind Instrumente der Datenerhebung, die eingesetzt werden, um psychologische Eigenschaften, Einstellungen, Interessen und Meinungen zu erfassen.
* Unter einem Fragebogen wird die Sammlung von Fragen, die für eine systematische Befragung von Personen konzipiert sind, verstanden. Anstelle von Fragen können Fragebögen auch Aussagen oder lediglich einzelne Begriffe beinhalten, die von den Befragten einzuschätzen sind. Auch muss die Verwendung eines Fragebogens als Erhebungsverfahren für die Befragten nicht ersichtlich sein, wie zum Beispiel im Interview.

Hier finden Sie einige Beispiele für Persönlichkeitskonstrukte und Fragebögen, mit denen diese erhoben werden können.

| Konstrukt | Instrument |
|---|---|
| Persönlichkeit/Big 5 | 10 Item Big Five Inventory (BFI-10; Rammstedt et al., 2013) |
| Burn Out | Maslach-Burnout Inventory (MBI; Maslach & Jackson, 1981) |
| Positiver und Negativer Affekt | Positive and Negative Affect Schedule (PANAS; Breyer & Bluemke, 2016) |
| Ärger| State-Trait-Ärgerausdrucks-Inventar-2 (STAXI-2; Rohrmann, 2013)|
| Emotionsarbeit | Frankfurter Skalen zur Emotionsarbeit (FEWS; Zapf et al., 2000)|
| Stressoren und Ressourcen am Arbeitsplatz| Instrument zur stressbezogenen Tätigkeitsanalyse (ISTA 6.0; Semmer et al., 1999)|
| Selbstwirksamkeit| General Self-Efficacy Scale (GSE)(Schwarzer & Jerusalem, 1995) |
| Soziale Angst| Fragebogen zu sozialer Angst und sozialen Kompetenzdefiziten – Version für Jugendliche (SASKO-J; Fernandez Castelao et al., 2017) |
| Aggressivität| Kurzfragebogen zur Erfassung von Aggressivitätsfaktoren (K-FAF; Heubrock & Petermann, 2008) |
| Soziale Unterstützung| Fragebogen zur sozialen Unterstützung (FsozU; Fydrich et al., 2007)|
| Narzissmus | Das Narzissmusinventar (NI; Deneke & Hilgenstock, 1989) |
| Psychosomatische Beschwerden | Psychosomatische Beschwerden im nichtklinischen Kontext (Mohr & Müller, 2004) |
| Altruismus | Facets of Altruistic Behaviors (FAB; Windmann et al., 2021)


Für Ihre Erhebung können Sie entweder solche bereits entwickelten Fragebögen nutzen oder Ihre eigenen Fragen formulieren. Wenn möglich, nutzen Sie vorzugsweise etablierte Fragebögen. Die Entwicklung ist nämlich komplex - dazu werden Sie im Laufe des Studiums in der Diagnostik mehr erfahren. Frei verfügbare Fragebögen finden Sie online unter anderem unter:

* [GESIS Testsammlung](https://zis.gesis.org): Open Access Fragebögen zu vielen verschiedenen Themen (z.B. Persönlichkeit, politische Einstellungen, Religiosität, Umweltverhalten, ...)
* [Open Psychometrics](https://openpsychometrics.org): z.B. Big Five Personality Test,  Nerdy Personality Attributes Scale, Rosenberg Self-esteem Scale, Generic Conspiracist Beliefs Scale,... (müssen ggf. übersetzt werden, keine Qualitätskontrolle der Fragebögen)
* [Testammlung des Fachbereichs](https://www.ub.uni-frankfurt.de/bsp/testsammlung.html): Sie können auch vor Ort einige validierte und publizierte Fragebögen ausleihen und diese für Ihre Studie nutzen.

# Präregistrierung {#Präregistrierung}

Vor Beginn der Datenerhebung müssen Sie Ihr Forschungsvorhaben auf [AsPredicted](https://aspredicted.org/) präregistrieren. Die Präregistrierung dient dazu, vor dem Beginn der Datenerhebung die bestehenden Hypothesen sowie das Datenerhebung- und Datenanalysevorhaben niederzulegen.
Der Sinn der Präregistrierung ist es, die Transparenz bei der Planung von Forschungsvorhaben zu gewährleisten. Durch die Kommunikation der Hypothesen sowie des geplanten Vorgehens sollen fragwürdige oder unethische Forschungspraktiken, wie beispielsweise das nachträgliche Anpassen der Hypothesen an die gefundenen Forschungsergebnisse, vermieden werden.

Eine Präregistrierung hat zudem den positiven Nebeneffekt, dass Sie als Forscher:innen frühzeitig eine klare und strukturierte Vorstellung von Ihrem Projekt entwickeln müssen. Dafür müssen Sie das Projekt bis zum Ende durchdenken, können mögliche Fallstricke erkennen und im Idealfall Probleme/Fehler vor ihrem Auftreten verhindern.

Wenn Sie die [Website von AsPredicted](https://aspredicted.org/) besuchen, sollte sie folgende Startseite begrüßen:

{{<inline_image"/lehre/statistik-i/aspredicted1.png">}}

Eine generelle Beschreibung von AsPredicted finden Sie in den blauen Kästen. In der Mitte ist die Prozedur der Präregistrierung auf AsPredicted kurz beschrieben und wir werden auch hier - in aller Kürze - die 7 Punkte besprechen. Um eine solche Präregistrierung mal selbst auszuprobieren, klicken Sie einfach das Feld "Just trying it out; make this pre-registration self-destroy in 24 hours. <i class="fas fa-bomb"></i> " und drücken Sie auf **Create**. Dann können Sie die Schritte, die hier besprochen werden auch direkt alle nachvollziehen. Für das Projekt sollte die Registrierung dann natürlich länger als 24 Stunden bestehen.

Um eine erhöhte Lesbarkeit für Forscher:innen auf der ganzen Welt sicherzustellen, verlangt AsPredicted das Ausfüllen der Punkte auf Englisch. Sollten Sie sich bei Fachwörtern in der Übersetzung nicht sicher sein, sprechen Sie gerne ihre:n Dozent:in an.

## Registrierung bei AsPredicted

Sie werden als Erstes um eine Registrierung mit Ihrer Instituts-Email-Adresse gebeten. Nutzen Sie hierfür bitte Ihre ...@stud.uni-frankfurt.de Adresse. Sie sollten ziemlich zügig eine Email mit dem Zugangslink zu Ihrer Präregistrierung erhalten. Wenn Sie - wie oben beschrieben - die "Ich probiere nur was aus"-Variante gewählt haben, haben Sie jetzt nur 24 Stunden Zeit, um sich mit dem Prozedere auseinanderzusetzen.

Wenn Sie dem Link folgen werden Sie gebeten alle Autor:innen der Präregistrierung zu nennen. Tragen Sie sich hier selbst ein. Für Ihr Gruppenprojekt in diesem Semester ist es wichtig, dass Sie **auch den/die Dozent:in Ihres Praktikums** hier angeben. Sinn dabei ist, dass wir so die Möglichkeit erhalten, Ihre Präregistrierung zu prüfen und Ihnen das finale "Okay" geben können, bevor Sie mit Ihrer Erhebung loslegen. Alle hier gelisteten Autor:innen bekommen nämlich eine Email zugesandt und können der Präregistrierung entweder zustimmen oder sie ablehnen. Beachten Sie das mit der Bestätigung durch Ihre/n Dozent:in der Prozess abgeschlossen ist. Bitte **sehen Sie davon ab**, anschließend die Option *make public* zu drücken.

## AsPredicted Questions

Im nächsten Abschnitt finden Sie 11 Fragen, die Ihnen zu Ihrem Projekt gestellt werden. Einen Überblick über die Fragen (zu einem Zeitpunkt, als es nur 9 Fragen waren) und ein Beispiel finden Sie z.B. auf der Seite [direkt verlinkten Blogpost](http://datacolada.org/64). Wir gehen im Folgenden aber auch alle 11 Bereiche durch. 

### 1) Data Collection

Hier wird danach gefragt, ob Sie für diese Untersuchung bereits Daten erhoben haben. Wenn dem so sein sollte, handelt es sich um eine *Sekundäranalyse* bereits bestehender Daten (mehr dazu in PsyBSc 1). Solche Studien sind zwar vollkommen legitime Möglichkeiten des Forschens, aber nicht für diese spezifische Präregistrierungsvorlage geeignet. Darüber hinaus geht es in diesem Modul darum, dass Sie erste Erfahrungen mit einer empirischen *Primäranalyse* sammeln. Letztlich ist es also nur legitim, Daten zu nutzen, die zum Zeitpunkt der Präregistrierung noch nicht gesammelt wurden und bei diesem Punkt wahrheitsgemäß "Nein" zu wählen.

Anmerkung: AsPredicted hat in einer neueren Version auch die Möglichkeit der Angabe, dass es kompliziert ist (bspw. wenn ein Teil der Daten schon erhoben ist). Da dies bei uns nicht der Fall ist, ergibt sich keine Änderung in unserem Vorgehen.

### 2) Hypothesis {#hypo}

Hier geht es darum, dass Sie die Forschungsfragen und Hypothesen klar und eindeutig ausformulieren. Dazu können Sie z.B. nochmal in den [Abschnitt zur Hypothesengenerierung](#Hypothesengenerierung) rein gucken. Darüber hinaus sollten Sie diese Hypothesen aber unbedingt vor der Präregistrierung schon mit Ihrem/Ihrer DOzent:in besprochen haben. Für das Projekt in diesem Semester sollten Sie hier mindestens zwei Hypothesen aufstellen, die sich auf Variablen unterschiedlicher Skalenniveaus beziehen.

### 3) Dependent Variable

Die abhängigen Variablen in Ihrer Untersuchung. In den meisten Fällen psychologischer Forschung handelt es sich hier um psychische Konstrukte oder Eigenschaften von Personen, sodass es auch relevant ist hier klar zu machen, wie diese gemessen werden sollen. Eine Aufstellung möglicher Skalen und ein paar Details zu diesem Schritt finden Sie im [Abschnitt Operationalisierung](#Operationalisierung).

### 4) Conditions

Hier geht es darum, *experimentelle Bedingungen* zu beschreiben - also die unabhängigen Variablen, die Sie als Versuchsleitung manipulieren. Wenn Sie z.B. untersuchen wollen, ob sich Personen in Ihrer Stimmung unterscheiden, nachdem sie verschiedene Songs gehört haben, können Sie die Probanden zufällig einem Song zuordnen und so eine *experimentelle Bedingung* schaffen. Wenn Sie aber z.B. Geschlechtsunterschiede in der Stimmung untersuchen wollen, handelt es sich nicht um eine experimentelle Bedingung, weil Sie als Versuchsleitung keinen Einfluss auf das Geschlecht haben. Mehr zu dieser Unterscheidung zwischen *experimentellen*, *quasi-experimentellen* und *nicht-experimentellen* Studien erfahren Sie in PsyBSc 1.

Für unsere Studie tragen Sie hier in jedem Fall die Variable ein, die auf Nominalskalenniveau vorliegt. Machen Sie dabei aber auch kenntlich, wenn diese von Ihnen nicht manipuliert wurde (wie z.B. das Geschlecht).

### 5) Analyses

An dieser Stelle geht es darum, klar darzulegen welche Analysen durchgeführt werden um die unter [Punkt 2](#hypo) dargelegten Hypothesen zu prüfen. Das heißt Ihnen sollte schon vor der Studie klar sein, welche Hypothese Sie mit welchem Verfahren prüfen können. Weil sich hier wahrscheinlich Tests und Verfahren eignen, die wir weder in der Vorlesung noch im Praktikum besprochen haben, wenn Sie die Präregistrierung abschließen, macht es hier sehr viel Sinn, Rücksprache mit Ihrem/Ihrer Dozent:in zu halten.

### 6) Outliers and Exclusions

Einer der Schritte im Auswertungsprozess an dem es am häufigsten zu "Irregularitäten" kommt, ist der Ausschluss von Daten. Dieser Schritt soll dazu dienen, Daten von Personen auszuschließen die aus verschiedenen Gründe die wissenschaftliche Integrität der Untersuchung gefährden, z.B. durch:

* Abbruch der Befragung
* Absichtliches Fehlverhalten der Befragten, mit dem Ziel die Untersuchung zu stören
* "Musterkreuzen", um die Befragung schnellstmöglich abzuschließen
* Missverständnis der Aufgabenstellung

Solche Fälle sollen identifiziert und möglichst ausgeschlossen werden. Aber auch Personen, die nicht zur *Zielpopulation* gehören, sollen idealerweise nicht in die Auswertung aufgenommen werden. Wenn Sie z.B. die aktuelle Stimmung von Studierenden untersuchen möchten, sollten Personen ausgeschlossen werden, die keine Studierenden sind. Wenn Sie sich darüber hinaus auf die gesunde Grundgesamtheit Psychologiestudierender beziehen wollen, sollten Sie diejenigen Personen ausschließen können, die an einer diagnostizierten affektiven Störung (z.B. einer Depression) leiden. All diese möglichen Gründe, Personen auszuschließen, sollten vorab bedacht werden und es sollten klar Regeln dazu aufgestellt werden, wann Daten aus der Analyse ausgeschlossen werden. Durch Willkür in diesem Punkt können sich Ergebnisse sehr leicht manipulieren lassen, wodurch die Vertrauenswürdigkeit der Studie verloren geht.

### 7) Sample Size

Wie viele Personen möchten Sie erheben? In den meisten Fällen kann vorab mittels einer sog. *Poweranalyse* bestimmt werden, wie viele Personen Sie erheben müssen, um mit adäquater Irrtumswahrscheinlichkeit Ihre Hypothesen prüfen zu können. Wichtig ist hier, dass Sie sich durch die hier angegeben Zahl verpflichten, die Erhebung dieser Anzahl von Personen mit allen Ihnen zur Verfügung stehenden Mitteln zu versuchen.

Die Poweranalyse lernen wir erst im Laufe des Semesters kennen und können Sie deshalb jetzt noch nicht durchführen. Die Zielgröße für unsere Studien legen wir deshalb pauschal auf 40 Versuchspersonen fest.

### 8) Other

In diesem Feld geht es vor allem darum, zusätzliche Untersuchungsschritte festzuhalten, die nicht an klare Hypothesen gebunden sind. Das betrifft vor allem *explorative Analysen*, also Analysen, die sich auf Forschungsfragen beziehen, zu denen Sie noch keine konkreten Annahmen generieren konnten. Ziel solcher Exploration ist es, eine empirische Grundlage für die Theoriebildung für zukünftige Studien zu entwickeln.

### 9) Name

Hier können Sie Ihrem Projekt noch einen aussagekräftigen Namen geben. Dieser kann auch englisch sein.

### 10) Type of Study

Hier müssen Sie angeben, um was für eine Art von Studie es sich bei Ihrem Projekt handelt. Im Fall des Praktikums wählen Sie hier bitte "Class project or assignment".

{{<inline_image"/lehre/statistik-i/aspredicted2.png">}}

### 11) Data source

Als letzter Punkt wird die Quelle der Daten abgefragt. Hier geben wir an, dass wir eine online Umfrage machen, die wir mit Hilfe von formr erstellt haben.

{{<inline_image"/lehre/statistik-i/aspredicted_datasource.PNG">}}

# Erstellung des Fragebogens
Fragebögen können in Papierform oder auch online durchgeführt werden. In diesem Praktikum wird die Datenerhebung über einen Online-Fragebogen durchgeführt.

## Online-Fragebogen {#Online-Fragebogen}
Im Internet gibt es einige Anbieter, die z.B. unter Begrenzung der Laufzeit oder des Umfangs kleine Umfragen kostenlos ermöglichen.

* formr: https://formr.org
* SoSciSurvey: https://www.soscisurvey.de
* GrafStat - http://www.grafstat.de
* UNIPARK - http://www.unipark.com/de/umfragesoftware-bestellen
* q-set - http://www.q-set.de
* SurveyMonkey - https://de.surveymonkey.com
* Umfrageonline- https://www.umfrageonline.com/students
* maq-online - http://www.maq-online.de
* LimeSurvey/LimeService - https://www.limeservice.com/de

Für dieses Praktikum wird vorgegeben, formr zu benutzen. Für eine ausführliche Einführung in formr können Sie sich entweder unser [formr-Tutorial](/lehre/statistik-i/formr-faq) auf dieser Seite ansehen oder direkt einen Blick auf die [Dokumentation von formr](https://formr.org/documentation) werfen.

In Kürze: Für die Erstellung des Fragebogens wird in formr eine Tabelle (z.B. als Google-Doc) angelegt, in der jedes Item in einer Zeile steht. In den verschiedenen Spalten werden die abgebildete Frage, der Fragentyp, die Antwortoptionen und verschiedene weitere Optionen definiert. Als etwas komplizierteres Beispiel können Sie [<i class="fas fa-download"></i>  hier](/lehre/statistik-i/fb21_questions.ods) die Tabelle der Umfrage aus der ersten Sitzung herunterladen. Die vollständige formr-basierte Umfrage finden Sie [hier](https://psybsc2.formr.org/).

Wählen Sie in Ihrer Gruppe eine Person aus, die die online Anmeldung übernimmt. Im Laufe der Besprechung der Gruppenarbeiten wird Ihnen auch noch ein Referral Token mitgeteilt, über das Sie den Anmeldeprozess beschleunigen können. Dadurch müssen Sie nicht nochmal eine Mail an die Betriebsstelle von formr senden, sondern können nach der Bestätigung Ihrer E-Mail Adresse direkt mit der Erstellung einer Umfrage beginnen. Auch im OLAT-Kurs wird dieser Token zur Verfügung gestellt.

## Instruktion und Einverständnis

Vor Beginn der Studie sollten die Teilnehmenden in der sogenannten **Instruktion** über die Studie und besonders über datenschutzrechtliche Fragen informiert werden. Am Ende der Instruktion müssen die Teilnehmenden ihr **Einverständnis** abgeben.

In der Instruktion werden die Teilnehmenden darüber aufgeklärt, dass die Daten anonymisiert werden, wie lange sie gespeichert werden und wozu sie verwendet werden. Damit Dozierende die Daten einsehen dürfen, muss in der Aufklärung der Versuchspersonen erwähnt werden, dass auch die Lehrpersonen Zugriff auf die erhobenen Daten haben werden. Um die Daten im Anschluss auch auf öffentlichen Plattformen anderen zur Verfügung stellen zu können, muss hier besonders Achtung bei der Aufklärung gegeben werden. Denn sobald die Daten online sind, verlieren Teilnehmende die Option ihre Daten zurückzuziehen. Wird hierfür kein explizites Einverständnis geholt, dürfen die Daten nicht öffentlich geteilt werden. Zudem wird in der Instruktion darüber informiert, wie lange das Ausfüllen des Fragebogens dauert und dass die Teilnahme jederzeit abgebrochen werden kann, ohne dass dadurch Nachteile entstehen. Es sollte zusätzlich erwähnt werden, dass es keine richtigen und falschen Antworten gibt, sondern die Antwort gewählt werden soll, die am ehesten die eigene Meinung widerspiegelt.

Am Ende der Instruktion wird durch ein Item bestätigt, dass die Teilnehmenden die Informationen gelesen und verstanden haben, und sich mit der beschriebenen Verarbeitung der Daten einverstanden erklären. Hierbei wird die Möglichkeit zur Zustimmung, jedoch auch zur Ablehnung gegeben. Im Falle einer Zustimmung wird die Datenerhebung begonnen, im Falle einer Ablehnung werden die Proband:innen auf die letzte Seite des Fragebogens weitergeleitet, ohne dass weitere Daten erhoben werden.

>**Beispiel für die Einverständniserklärung:** Ich habe die Information für Proband:innen der genannten Studie gelesen und verstanden. Ich erkläre mich damit einverstanden, an dieser Studie teilzunehmen. Meine Teilnahme erfolgt freiwillig. Ich weiß, dass ich die Möglichkeit habe, meine Teilnahme an dieser Studie jederzeit und ohne Angabe von Gründen abzubrechen, ohne dass mir daraus Nachteile entstehen. *Datenschutzklausel:* Ich erkläre, dass ich mit der im Rahmen der Studie erfolgenden Aufzeichnung von Studiendaten und ihrer Verwendung in pseudo- bzw. anonymisierter Form einverstanden bin. Ich bin darüber aufgeklärt worden, dass die hier erhobenen Daten anonymisiert gegebenenfalls in einem Datenarchiv Dritten zur Verfügung gestellt werden. Daten und Forschungsergebnisse, die bereits auf öffentliche Datenbanken geladen und mit anderen Forschern geteilt wurden, können nicht wieder vollständig gelöscht oder zurückgezogen werden.


# Bitte beachten Sie zusammenfassend:

* Im Bericht sollen mindestens zwei Fragestellungen behandelt werden, die in Unterschieds- und Zusammenhangshypothese unterschieden werden können.
* Weiterführende Informationen zum Bericht finden Sie [hier](/lehre/statistik-i/hinweise-zum-ergebnisbericht).
* Neben den primär interessierenden Merkmalen/Variablen sollen auch mögliche Störvariablen (z.B. Geschlecht, Alter) erhoben werden.
* Bitte stimmen Sie die entwickelten Hypothesen mit dem/der Dozent:in Ihres Kurses ab.
* Vor Beginn der Datenerhebung muss die Studie präregistriert werden (**Stichtag 19.12.2022**).
* Der Stichprobenumfang sollte mind. 40 Proband:innen umfassen (bzw. 10 Personen pro Mitglied in Ihrer Gruppe).

### Literatur

Breyer, B., & Bluemke, M. (2016). Deutsche Version der Positive and Negative Affect Schedule PANAS (GESIS Panel). Zusammenstellung sozialwissenschaftlicher Items und Skalen (ZIS). https://doi.org/10.6102/ZIS242

Deneke, F.-W., & Hilgenstock, B. (1989). NI Das Narzißmusinventar. Hans Huber.

Fernandez Castelao, C., Kolbeck, S., & Ruhl, U. (2017). SASKO-J. Fragebogen zu sozialer Angst und sozialen Kompetenzdefiziten—Version für Jugendliche. Hogrefe.

Fydrich, T., Sommer, G., & Brähler, E. (2007). F-SozU Fragebogen zur Sozialen Unterstützung. Hogrefe.

Heubrock, D., & Petermann, F. (2008). K-FAF Kurzfragebogen zur Erfassung von Aggressivitätsfaktoren. Manual. Hogrefe.

Mohr, G., & Müller, A. (2004). Psychosomatische Beschwerden im nichtklinischen Kontext. Zusammenstellung sozialwissenschaftlicher Items und Skalen (ZIS). https://doi.org/10.6102/ZIS78

Popper, K. (1972). The logic of scientific discovery. Hutchinson & Co.

Rammstedt, B., Kemper, C. J., Klein, M. C., Beierlein, C., & Kovaleva, A. (2017). A Short Scale for Assessing the Big Five Dimensions of Personality: 10 Item Big Five Inventory (BFI-10). Methods, data, 17 Pages. https://doi.org/10.12758/MDA.2013.013

Rohrmann, S., Hodapp, V., Schnell, K., Tibubos, A. N., Schwenkmezger, P., & Spielberger, C. C. (2013). Das State-Trait-Ärgerausdrucks-Inventar-2: STAXI-2; dt. Adaption des State-Trait Anger Expression Inventory-2 v. Charles D. Spielberger. Hans Huber.

Schwarzer, R., & Jerusalem, M. (1995). Generalized Self-Efficacy scale. In Measures in health psychology: A user’s portfolio. Causal and control beliefs (S. 35–37). NFER-NELSON.

Semmer, N. K., Zapf, D., & Dunckel, H. (1999). Instrument zur streßbezogenen Tätigkeitsanalyse ISTA. In H. Dunckel (Hrsg.), Handbuch psychologischer Arbeitsanalyseverfahren (S. 179–204). VdF Hochschulverlag.

Windmann, S., Binder, L., & Schultze, M. (2021). Constructing the Facets of Altruistic Behaviors (FAB) Scale. Social Psychology. https://psyarxiv.com/5ue3p/

Zapf, D., Mertini, H., Seifert, C., Vogt, C., Isic, A., & Fischbach, A. (2000). FEWS (Frankfurt Emotion Work Scales, Frankfurter Skalen zur Emotionsarbeit). Version 4.0. Report, Johann Wolfgang Goethe-Universität.
