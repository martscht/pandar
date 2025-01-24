---
title: '(Re-)Analyse eines Datensatzes mit den KI Tools ChatGPT und Julius.AI'
subtitle: 'Moderne Forschungsmethoden'
type: post
date: '2024-14-07'
lastmod: '2025-01-24'
slug: ki-tools
categories: ["ChatGPT"]
tags: ["ChatGPT", "Data Analysis"]
summary: ''
authors: [] #Sarah
weight: 2
featured: no
banner: 
  image: "/header/under_construction.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/724752)"
projects: []

reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /extras/chatgpt/ki-tools

output:
  html_document:
    keep_md: true
---

## **Inhaltsverzeichnis**
1. [Einführung](#einführung)
2. [ChatGPT-4](#chatgpt-4)
3. [Julius.AI](#juliusai)
4. [Beschreibung der Studie und des Datensatzes](#beschreibung-der-studie-und-des-datensatzes)
5. [Was war die ursprüngliche Idee?](#was-war-die-ursprüngliche-idee)
6. [Analyse der Daten („How To“)](#analyse-der-daten-how-to)
7. [Empfehlung](#empfehlung)
8. [Literaturverzeichnis](#literaturverzeichnis)

## **Einführung**
Moderne Forschungsmethoden sind ein unverzichtbares Werkzeug, um komplexe psychologische Fragen zu beantworten und effizient wissenschaftliche Erkenntnisse zu gewinnen. Dabei ist die kontinuierliche Entwicklung neuer Methoden und die Sicherstellung, dass aktuelle Methoden effektiv angewendet werden, wichtiger Bestandteil psychologischer Forschung. Die Methodenabteilung der Goethe-Universität Frankfurt untersucht im Rahmen eines Forschungsmoduls die Entwicklung und Weiterentwicklung neuer KI-basierter Methoden in der praktischen Anwendung zur Datenauswertung.

Künstliche Intelligenz hat das Potenzial, die Art und Weise, wie wir Daten analysieren und interpretieren, revolutionär zu verändern, indem wir Daten effizienter verarbeiten – und das vielleicht sogar ohne umfangreiches Vorwissen?

In diesem Tutorial widmen wir uns dieser Frage und werden die Replizierbarkeit der automatisierten Auswertung von psychologischen Studien und deren Datenanalyse anhand zweier KI-Tools untersuchen und aktuelle Grenzen aufzeigen. 

Das Ziel ist es, zu untersuchen, wie und ob die Tools es schaffen, mit möglichst wenig Anweisung komplexe Datenanalysen zu replizieren.

Dieses Tutorial richtet sich an Forschende und Studierende und soll als Leitfaden und Inspiration für den Einsatz von KI-Assistenten in der eigenen Forschung dienen.

## **ChatGPT-4**
Eine Beschreibung des KI-Tools ChatGPT-4 befindet sich [hier](/extras/chatgpt/prompts). Das für dieses Tutorial verwendete ChatGPT-4o ist das aktuell jüngste GPT-Modell von Open-AI. Der GPT-4o bietet wesentliche Verbesserungen gegenüber seinen Vorgängern durch die Einführung multimodaler Fähigkeiten, größere Kontextfenster, schnellere Verarbeitungsgeschwindigkeiten etc., die die modernste Leistung bei der Generierung und dem Verstehen von Text, Audio, Video und Bild hervorrufen (Islam & Moushi, 2024). 

## **ChatGPT Data Analyst**
ChatGPT Data Analyst, auch bekannt als Advanced Data Analysis oder früher als Code Interpreter, ist eine leistungsstarke Funktion von ChatGPT, die es Benutzern ermöglicht, komplexe Datenanalysen durchzuführen (Irvine, Halloran & Brunner, 2023). Diese Funktion ist Teil des ChatGPT Plus-Abonnements und basiert auf dem GPT-4-Model. 

## **Julius.AI**
Julius AI ist ein fortschrittliches, KI-gesteuertes Datenanalysetool, das es Nutzern ermöglicht, komplexe Datensätze auf intuitive Weise zu analysieren und zu visualisieren. Es funktioniert als interaktiver KI-Assistent, mit dem Benutzer in natürlicher Sprache über ihre Daten "chatten" können. Julius AI kann Daten aus verschiedenen Quellen wie Excel-Tabellen und Online-Datenbanken verarbeiten und bietet leistungsstarke Funktionen wie automatisierte Datenvisualisierung, Trendanalysen und Prognosemodelle. Das Tool ist darauf ausgelegt, den Datenanalyseprozess zu vereinfachen und zu beschleunigen, wodurch es sowohl für Datenexperten als auch für Nutzer ohne tiefgreifende technische Kenntnisse zugänglich ist („Julius AI | Your AI Data Analyst“, 2024). Im Folgenden gehen wir auf wichtige Aspekte ein, die Nutzer beachten sollten:

- *Kostenlose Version und Prompt-Limit*
In der kostenlosen Version von Julius.AI sind lediglich 15 Prompts pro Monat enthalten. Dies ist eine recht begrenzte Anzahl, insbesondere für Nutzer, die das Tool intensiv nutzen möchten.

- *Nachfragen bei Berechnungen*
Aufgrund des begrenzten Prompt-Kontingents fragt Julius.AI häufig nach, ob mit einer Berechnung fortgefahren werden soll. Dies könnte als Strategie interpretiert werden, Nutzer zum Upgrade auf eine kostenpflichtige Version zu bewegen, die mehr Freiheiten bietet.

- *Sprache der Prompts*
Für optimale Ergebnisse empfiehlt es sich, die Prompts in englischer Sprache einzugeben. Julius.AI scheint mit englischen Anweisungen besser umgehen zu können und liefert präzisere Resultate.

- *Programmiersprachen-Auswahl*
Julius.AI bietet die Möglichkeit, zwischen verschiedenen Programmiersprachen zu wählen. Standardmäßig ist Python voreingestellt, aber Nutzer können auch auf R umschalten.
Aus subjektiver Sicht haben wir festgestellt, dass Julius.AI mit R flüssiger und mit weniger Fehlermeldungen arbeitet. Dies könnte für Nutzer, die mit R vertraut sind oder komplexere statistische Analysen durchführen möchten, von Vorteil sein.

- *Fazit*
Julius.AI ist ein vielseitiges Tool für Datenanalyse, das jedoch in der kostenlosen Version einige Einschränkungen aufweist. Für intensivere Nutzung könnte ein Upgrade auf eine kostenpflichtige Version in Betracht gezogen werden, um das volle Potenzial von Julius.AI auszuschöpfen. Studentinnen und Studenten, sowie anderen Hochschulangehörigen, bietet Julius.AI einen Rabatt von 50%. 

## **Beschreibung der Studie und des Datensatzes**
Für den Versuch, Datenauswertungen mittels KI zu replizieren, haben wir den Datensatz aus der Studie "Exploring the effects of team identification and perceived social support on collective self-efficacy and emotional exhaustion." (Junker et al., 2019) verwendet. Der Artikel umfasst zwei Einzelstudien, wobei wir uns in unserem Beitrag auf die zweite Untersuchung konzentrieren. In dieser Studie wurde die Wirkung der sozialen Identität auf wahrgenommene soziale Unterstützung und kollektive Selbstwirksamkeit sowie deren Einfluss auf emotionale Erschöpfung experimentell untersucht. Die Erhebung erfolgte durch eine experimentelle Manipulation der sozialen Identität, die folglich als dichotome Variable vorlag (hohe vs. niedrige soziale Identität) und die anschließende Messung der Konstrukte mittels validierter Fragebögen. Durch eine zweistufige serielle Mediationsanalyse wurden die indirekten Effekte der Manipulation auf emotionale Erschöpfung über wahrgenommene soziale Unterstützung und kollektive Selbstwirksamkeit untersucht. Die folgende Darstellung der Beziehungen und Effekte ist der Originalquelle der Studie entnommen (Junker et al., 2019, S. 1001).

## Grafik Pfadmodell 
![](/extras/chatgpt/static/ki-tools/Pfadmodell.jpg) 

## **Was war die ursprüngliche Idee?**
Die Idee war es, nur den Datensatz mit entsprechenden Informationen zur Forschungsfrage und der Definition der darin enthaltenen Konstrukte zur Verfügung zu stellen und ohne inhaltlichen Input und mit möglichst wenigen konkreten Anweisungen zur statistischen Analyse die Auswertung und die Ergebnisse der Studie zu replizieren. Damit sollte getestet werden, ob auch ohne umfangreiches statistisches Vorwissen und entsprechende Methodenkenntnisse eine korrekte Datensatzauswertung durchgeführt werden kann. 
Damit die KI-Tools die Daten lesen können, sollten diese nach Anweisung der KI selbst im csv-Format vorliegen und müssen dementsprechend gegebenenfalls noch mit R umgewandelt werden. Der Datensatz wird nun dem entsprechenden KI-Assistenten zur Verfügung gestellt. Wir definieren die von uns untersuchte Forschungsfrage, legen die Variablen fest und ordnen die einzelnen Items des Datensatzes den entsprechenden Konstrukten zu. 
Anschließend gehen wir entsprechend der einzelnen Tools spezifisch vor. 

## **Analyse der Daten („How To“)**

### **ChatGPT**
ChatGPT wurde der Datensatz zusammen mit den relevanten Informationen (Variablenlabel) bereitgestellt. Die initiale Aufforderung war *„Analysiere den Datensatz. UV ist Soziale Identifikation. AV ist Emotionale Erschöpfung. Welche Zusammenhänge bestehen?“* Dabei analysierte ChatGPT vor allem den Zusammenhang zwischen der AV „Emotionale Erschöpfung“ (BO_g, Emotional exhaustion) und der UV „Soziale Identifikation Intervention“ (ManipT, Social identification intervention). 

Der Zusammenhang wurde von dem KI-Tool mit Hilfe eines Scatterplots dargestellt und die Korrelation berechnet. Allerdings entstanden bei mehreren Versuchen mit dem gleichen Prompt verschiedene Outputs. 

Um zu prüfen, ob das KI-Tool mit den korrekten Daten rechnet, wurden Mittelwerte und Standardabweichungen, getrennt nach Randomisierungsgruppen (ManipT), für UV, AV und die beiden Mediatorvariablen abgefragt und mit den Resultaten aus der Studie verglichen. Weitergehend wurden die Korrelationen der relevanten Konstrukte angefordert und mit denen aus der Studie, sowie mit selbst aus R berechneten Werten verglichen. Diese Ergebnisse hat ChatGPT über den gesamten Verlauf unserer Untersuchung korrekt wiedergegeben. 

Auf unspezifische Fragen wie *„Bestehen Mediationseffekte?“* oder *„Rechne mir eine serielle Mediation“* kamen keine konsistenten Ergebnisse, bzw. die Fragestellung der Studie wurde nicht beantwortet. Bei gleichen Prompts, ist hierbei also mit inkonsistenten Outputs zu rechnen. Hierbei ist kein Muster erkennbar, wie die verschiedenen Lösungsansätze von ChatGPT zu Stande kommen.

Deshalb haben wir im nächsten Schritt spezifisch gefragt *„Rechne die serielle Mediation mit den Mediatoren Soziale Unterstützung und Kollektive Selbstwirksamkeit von ManipT auf Emotionale Erschöpfung. Gib mir die Effektstärken an“*. Hierbei gab ChatGPT einen korrekten direkten Effekt aus, allerdings stimmten die indirekten Effekte nicht mit den Ergebnissen der Studie überein. 

Daher haben wir es mit einer weiteren Formulierung versucht: *„Rechne eine Mediationsanalyse von ManipT auf Emotionale Erschöpfung. Verwende als serielle Mediatoren Soziale Unterstützung und Kollektive Selbstwirksamkeit. Gib mir die Effektstärken an“*. In diesem Fall hat diese feine Unterscheidung im Prompt dafür gesorgt, dass ChatGPT auf die korrekten Ergebnisse der seriellen Mediationsanalyse kam. 

Um die Ergebnisse visualisieren zu lassen, haben wir erfragt, ob die Ergebnisse in einer Abbildung dargestellt werden können. Hierbei ist keine korrekte Abbildung entstanden. 

## Grafik Pfadmodell 
![](/extras/chatgpt/static/ki-tools/Ergebnis_Pfadmodell_ChatGPT.jpg)


Wichtig ist zu ChatGPT auch anzumerken, dass nach einmaliger Frage nach dem R Code im gleichen Chat keine Ergebnisse mehr ausgegeben wurden. Egal wie spezifisch wir nach Ergebnissen gefragt haben, es wurde nur noch R Code geliefert. Erst als wir einen neuen Chat eröffneten und von vorne begonnen haben, wurden wieder konkrete Ergebnisse ausgegeben. Hinweis: Wer also nicht selbst rechnen will, sollte gar nicht oder erst ganz am Schluss nach dem R Code fragen. ;)

Positiv ist aufgefallen, dass ChatGPT zuverlässig Anweisungen zum Layout der Ergebnisse umgesetzt hat. Das umfasste z. B. Anweisungen zu Rundungen, Spezifikationen zu Zeilen und Spalten oder zur Verwendung von Subgruppen. 

Weitergehend ist anzumerken, dass ChatGPT in seinen Outputs häufig zwischen Deutsch und Englisch wechselte. Wer Antworten in einheitlicher Sprache wünscht, sollte dies zu Beginn spezifizieren.

### **ChatGPT Data Analyst**
Auch dem spezialisierten ChatGPT Data Analyst wurde zunächst der Datensatz mit allen relevanten Informationen gegeben, mit dem gleichen Einstiegs-Prompt wie bei ChatGPT. 
Der Data Analyst beschrieb Schritt für Schritt sein Vorgehen. Das Tool rechnete eine Regressionsanalyse, um den Zusammenhang zwischen sozialer Identifikation und emotionaler Erschöpfung zu verdeutlichen. 

Da auch hier nicht die Analyse durchgeführt wurde, auf die wir hinauswollten, wurden wie bei ChatGPT zunächst die Mittelwerte und Standardabweichungen der relevanten Konstrukte erfragt (getrennt für die beiden Gruppen gemäß ManipT), genauso wie die relevanten Korrelationen. Hierbei brachte das Tool korrekte Ergebnisse. Zudem gab der Data Analyst eine Interpretation der Korrelationen aus. 

Im nächsten Schritt haben wir direkt nach der seriellen Mediation gefragt. Zunächst mit dem Prompt, welcher bei ChatGPT keine richtigen Ergebnisse erbrachte *(„Rechne die serielle Mediation mit den Mediatoren Soziale Unterstützung und Selbstwirksamkeit von ManipT auf Emotionale Erschöpfung. Gib mir die Effektstärken an“)* und dann mit dem, welcher bei ChatGPT die richtigen Effektstärken hergab *(„Rechne eine Mediationsanalyse von ManipT auf Emotionale Erschöpfung. Verwende als serielle Mediatoren Soziale Unterstützung und Kollektive Selbstwirksamkeit. Gib mir die Effektstärken an.“)*. 

Auch hier wurde vom Tool jeweils zunächst das Vorgehen beschrieben. Anders als ChatGPT kam der Data Analyst mit beiden Prompts auf die identischen, aber falschen, Ergebnisse. Lediglich der direkte Effekt wurde korrekt berechnet. 
Da in beiden Fällen keine korrekten Ergebnisse erzielt werden konnten, haben wir es mit einer konkreteren Beschreibung versucht: *„Rechne eine Mediationsanalyse von ManipT auf Emotionale Erschöpfung. Verwende als serielle Mediatoren Soziale Unterstützung und Kollektive Selbstwirksamkeit. Heißt, der Effekt geht erst über Soziale Unterstützung und dann über Kollektive Selbstwirksamkeit. Gib mir die Effektstärken an“*. 

Die korrekten Effektstärken konnten mit dem Data Analyst von ChatGPT allerdings erst erzielt werden, nachdem konkret beschrieben wurde, wie der Gesamteffekt zu berechnen ist *(„Rechne in den Gesamteffekt zusätzlich jeweils die indirekten Pfade über soziale Unterstützung und über kollektive Selbstwirksamkeit ein.“)*. Daraufhin haben wir konkrete Werte zu jedem Pfad inklusive Beschreibung erhalten. Der Totale Indirekte Effekt wurde allerdings nur nach erneuter Nachfrage ausgegeben. Trotz mehrfacher Nachfrage, dass ein Pfadmodell oder eine andere Art der Visualisierung der Effekte ausgegeben werden soll, erhielten wir vom Data Analyst nur Python Code und eine Beschreibung, wie wir das Modell mit Hilfe von Python selbst erstellen könnten.

*Fazit*: ChatGPT und ChatGPT Data Analyst waren nicht in der Lage selbstständig auf das gewünschte Ergebnis zu kommen. Es waren viele weitere Spezifikationsschritte notwendig, um zum Ergebnis zu gelangen. Zudem war eine kontinuierliche Überprüfung der Ergebnisse, welche über das Berechnen von Korrelationen hinausgehen, notwendig. Folglich ist das Wissen um die richtigen Ergebnisse Voraussetzung, um das KI-Tool ChatGPT sicher nutzen zu können. 

### **Julius AI**
Zu Beginn wurde Julius.AI der Datensatz zusammen mit den relevanten Informationen (Variablenlabeln) bereitgestellt. Gleichermaßen zu dem Vorgehen bei ChatGPT erhielt Julius.AI als initiale Information folgende: *„Analysiere den Datensatz. UV ist Soziale Identifikation. AV ist Emotionale Erschöpfung. Welche Zusammenhänge bestehen?“*. Diese erste Information wurde der KI in der deutschen Sprache gegeben. Die nachfolgenden Prompts sind in der englischen Sprache durchgeführt worden.

Julius.AI errechnete die Korrelation der UV und der AV. Selbstständig schlug das KI-Tool vor, den Zusammenhang graphisch darzustellen. Nach Aufforderung erstellte Julius.AI einen Scatter Plot.
Im nächsten Schritt wurde analog zu der Vorgehensweise bei ChatGPT, Mittelwerte und Standardabweichungen, getrennt nach Randomisierungsgruppen (ManipT), für UV, AV und die beiden Mediatorvariablen angefragt, sowie die Korrelationen zwischen UV, AV und den beiden Mediatorvariablen. Diese Ergebnisse gab Julius.AI korrekt wieder. Auch hier visualisierte das KI-Tool die Ergebnisse in Form eines Barplots und einer Korrelationsmatrix.

## Grafik Barplot 

![](/extras/chatgpt/static/ki-tools/Barplot_Julius.AI.jpg)


## Grafik Korrelationsmatrix 

![](/extras/chatgpt/static/ki-tools/Korrelationsmatrix_Julius.AI.png)


Daraufhin schlug Julius.AI weiterführende Analysen vor, darunter auch der Vorschlag einer Pfadanalyse oder eines Strukturgleichungsmodells.
Auf die Anfrage hin, eine Pfadanalyse zu verwenden, um die direkten und indirekten Beziehungen zwischen den Variablen zu untersuchen, gab Julius.AI konkrete Ergebnisse an. Das KI-Tool schaffte es jedoch nicht, das Pfadmodell zu visualisieren.
Um weiterführend auf das Ziel-Modell im Paper zu kommen, wurde Julius.AI die konkrete Frage gestellt, eine serielle Mediationsanalyse von Manipt auf Emotionale Erschöpfung zu berechnen. Dabei sollten Soziale Unterstützung und Kollektive Selbstwirksamkeit als serielle Mediatoren verwendet werden. Julius.AI sollte hierzu Effektgrößen angeben. Hierbei kam es wiederholt zu Fehlermeldungen bei dem KI-Tool.
Auf die Aufforderung hin, eine andere Berechnungsmethode zu versuchen, um die Analyse der seriellen Mediation zu berechnen, generierte die KI wieder profunde Ergebnisse. In diesen zeigten sich Unterschiede zum Paper im totalen Effekt, sowie in den indirekten Effekten auf.

Die korrekten Ergebnisse wurden generiert, als neben der Aufforderung eine serielle Mediationsanalyse unter Nennung der UV und AV, sowie der Mediatoren, auch die detaillierte Darstellung der Effekte an das KI-Tool übergeben wurde *(„Calculate a serial mediation analysis of Manipt on Emotional Exhaustion. Use social support and self-efficacy as mediators. Please calculate the effect in the following way: Indirect Effect 1 (Manipt -> SozU_g -> CSE_g -> BO_g) Indirect Effect 2 (Manipt -> SozU_g -> BO_g) Indirect Effect 3 (Manipt -> CSE_g -> BO_g) Direct Effect (Manipt -> BO_g), and calculate the Total Indirect Effect and the Total Effect. Give me the effect sizes.“)*. Die Erstellung eines Pfaddiagrammes konnte Julius.AI durch die genauen Angaben der individuellen Effektgrößen und unter erneuter Nennung der Variablen generieren.

*Fazit*: Identisch zu ChatGPT und ChatGPT Data Analyst konnte Julius.AI nicht selbstständig auf das gewünschte Ergebnis kommen. Auch hier waren viele weitere Spezifikationsschritte und eine kontinuierliche Überprüfung der Ergebnisse, welche über das Berechnen von Korrelationen hinausgehen, notwendig. Das Wissen um die richtigen Ergebnisse ist Voraussetzung, um das KI-Tool sicher nutzen zu können. 

## **Empfehlung**
Ohne explizite Anweisungen zum Vorgehen liefert keine der getesteten Tools richtige Ergebnisse zu komplexeren Methoden. Verlässliche Ergebnisse erzielten wir in unserer Analyse lediglich bei einfacher Deskriptivstatistik wie Mittelwerten, Standardabweichungen und Korrelationen. Komplexere Analysemethoden wie eine serielle Mediation können die von uns getesteten KI-Tools zum aktuellen Zeitpunkt noch nicht ohne nähere Anweisungen umsetzen. 

Es sollte vorab feststehen, welche statistische Methode angewandt werden soll. Auch die Ergebnisse sollten bestenfalls im Vorhinein vorliegen, um mögliche Fehler und Abweichungen zu erkennen. Derzeit sind noch ein umfangreiches Vorwissen, genaue Angaben und die richtigen Prompting-Strategien *(hier lohnt sich der [vorherige Leitfaden zum Thema KI-Prompting](/extras/chatgpt/prompts))* nötig, um korrekte und reliable Ergebnisse zu erhalten. Die KI benötigt sehr konkrete Anweisungen, um exakte Ergebnisse und Lösungsansätze zu erzeugen. Darüber hinaus produzieren die Tools teilweise trotz identischer Promptings unterschiedliche Outcomes. 

Damit stellen die von uns getesteten Tools zum aktuellen Zeitpunkt (Stand Juni 2024) keine effizienten Analysemethoden dar – eine selbst gerechnete serielle Mediation mittels R ist aktuell noch die bessere Variante. 

## **Literaturverzeichnis** 
Irvine, D. J., Halloran, L. J. S. & Brunner, P. (2023). Opportunities and limitations of the ChatGPT Advanced Data 
Analysis plugin for hydrological analyses. Hydrological Processes, 37(10), e15015. https://doi.org/10.1002/hyp.15015

Islam, R. & Moushi, O. M. (2024, Juli 1). GPT-4o: The Cutting-Edge Advancement in Multimodal LLM. https://doi.org/10.36227/techrxiv.171986596.65533294/v1

Julius AI | Your AI Data Analyst. (2024). . Zugriff am 18.7.2024. Verfügbar unter: https://julius.ai

Junker, N. M., van Dick, R., Avanzi, L., Häusser, J. A. & Mojzisch, A. (2019). Exploring the mechanisms underlying the social identity-ill-health link: Longitudinal and experimental evidence. The British Journal of Social Psychology, 58(4), 991–1007. https://doi.org/10.1111/bjso.12308
