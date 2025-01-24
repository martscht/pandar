---
title: "Replizierte Datenanalyse mit gleichem Prozess"
subtitle: "Reanalyse durch KI"
type: post
date: '2024-18-07'
lastmod: '2025-01-24'
slug: replication
categories: ["ChatGPT"]
tags: ["ChatGPT", "Data Analysis"]
summary: ''
authors: []
weight: 3
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
    url: /extras/chatgpt/replication

output:
  html_document:
    keep_md: true
---

## Einleitung

Anwendungen, die Künstliche Intelligenz verwenden, werden auch in der statistischen Datenanalyse immer mehr genutzt. Die Frage, die sich dabei stellt ist, wie zuverlässig solche automatisierten Auswertungsverfahren sind . Dieser Beitrag klärt über die **Replizierbarkeit der Analyse** mit ChatGPT auf und gibt somit Auskunft unter inwieweit die Anwendung zu konsistenten Ergebnissen kommt. Um dies zu testen, wurde eine Studie mit 20 simulierten Datensätzen durchgeführt. Diese unterscheiden sich zwar leicht in ihren deskriptivstatistischen Eigenschaften, basieren aber alle auf den gleichen Annahmen und Populationswerten, sodass die relevanten Zusammenhänge und Effekte in allen 20 Datensätzen kosistent sein sollten. Zwischen den verschiedenen Testungen wurden die einzelnen Chatverläufe jeweils wieder gelöscht, um bestmöglich zu gewährleisten, dass ChatGPT keinen Bezug zur vorherigen Analyse herstellen kann. Die Studie wurde mittels der [Version 4 von Chat-GPT Plus](/extras/chatgpt/prompts/) durchgeführt, da sowohl der Data Analyst von ChatGPT, als auch die Versionen 3.5 und 4o in dieser Testung keine Analyse durchführen konnten. Bereits hier ist festzustellen, dass die Entwicklung von Künstlicher Intelligenz ein sehr dynamischer Prozess ist und sich deshalb die Funktionen von ChatGPT und anderen Plattformen stetig ändern. Deswegen wird darauf hingewiesen, dass sich die Ergebnisse allein auf die verwendete Version zum aktuellen Zeitpunkt beziehen und bei jeder neuen Version eine erneute Überprüfung stattfinden sollte. Als Promptstrategie wurde die sogenannte [zero shot Strategie](/extras/chatgpt/prompts/) verwendet. Alle Beschreibungen des Datensatzes und auch die verschiedenen Prompts wurden auf deutsch in das Tool eingegeben und so waren alle Antworten von ChatGPT auch auf deutsch. Um eine Kontrolle der Herangehensweise von ChatGPT zu erhalten, wurde in den allgemeinen Einstellungen, unter *ChatGPT individuell konfigurieren*, die Anweisung vorgenommen, bei jeder Analyse den verwendeten R-Code auszugeben.

![](/extras/chatgpt/static/replication/ChatGPT1.png)

Dieses Vorgehen ist auch zu empfehlen, wenn der Umgang und die Interpretation von Python nicht vertraut ist. Allerdings ist anzumerken, dass der R-Code nur in elf Fällen zusätzlich zum Python-Code ausgegeben wurde und auch teilweise Fehler enthielt. Entscheidend für eine detaillierte Datenanalyse ist außerdem die Eingabe eines korrekt geführten Codebuches – Abweichungen von Variablennamen führen zu einer fehlerhaften oder nicht durchführbaren Analyse. Beispielsweise führte die Variable *sex* im Codebuch immer wieder zu Problemen während den Analysen.  Die Variable *sex* ist im Codebuch mit der Bedeutung *Geschlecht (weiblich, männlich, divers)* versehen. Scheinbar führte die Verwendung beider Sprachen bei ChatGPT zu Problemen und die Variable konnte somit häufig nicht gefunden bzw. korrekt gelesen werden. Es empfiehlt sich daher, entweder auf deutsch oder auf englisch zu analysieren. Auffällig war auch, dass keine **sav** Datei eingelesen werden konnten, sondern lediglich **xls** Dateien. 


<details>
<summary>Hintergrund zum Datensatz</summary>

Der Datensatz, der als Grundlage für die 20 Datensätze gedient hat, stammt aus einer früheren Bachelorarbeit von 2022. 
**Ziel der Bachelorarbeit war es, die Determinanten des Hilfeverhaltens wie Stimmung und Empathie hinsichtlich der Wahrnehmung einer Cybermobbingsituation sowie deren Einschätzung zu untersuchen**. Es handelte sich um ein quantitatives quasi-experimentelles Forschungsdesign. Die Stichprobe betrug N = 188 Probanden (nach der Imputation bei N = 90). Um die Wahrnehmung einer Cybermobbingsituation zu simulieren, wurden zwei Fallvignetten - Thomas und Anton - entwickelt, die hasserfüllte Sprache enthielten. Dabei war das Level von hasserfüllten Nachrichten in der Fallvignette Thomas größer (Mehr Beleidigungen und mehr Drohungen). Die Ergebnisse zeigten, dass es keinen Gruppenunterschied hinsichtlich der wahrgenommenen Schwere eines Cybermobbingvorfalls in Abhängigkeit der präsentierten Schwere der Fallvignetten gab. Die Befunde ergaben einen statistisch signifikanten Unterschied im Hinblick auf das Erleben der Stimmung vor und nach der Exposition des Cybermobbingvorfalls. Bei Fallvignette Thomas korrelierten die wahrgenommene Schwere und Empathie statistisch signifikant. Der Prädiktor Empathie sagte statistisch signifikant das Kriterium wahrgenommene Schwere bei Fallvignette Anton vorher. Es gab keinen statistisch signifikanten Unterschied zwischen Personen, die den Bystandereffekt kennen und Personen, die diesen nicht kennen, in Bezug auf die Intervention einer Notsituation bei Thomas und Anton. Empathie korrelierte jeweils statistisch signifikant mit Offenheit für Erfahrung, Extraversion, Neurotizismus, Gewissenhaftigkeit und Verträglichkeit. 

Im Rahmen der Studie wurde der Datensatz bereits in bereinigter Form zur Verfügung gestellt. Zusätzlich zum Datensatz wurde ein detailliertes Codebuch in ChatGPT hochgeladen.

<br>

</details>

<br>

In den nächsten Kapiteln werden die Grenzen der Replizierbarkeit in den einzelnen Schritten der Datenanalyse beschrieben:


# Einen Überblick über den Datensatz erhalten

Um einen Überblick über den Datensatzes zu erhalten wurde folgender Prompt eingegeben: *Der Zweck der Studie ist die Untersuchung von Einflussfaktoren auf die Wahrnehmung und Einschätzung einer Cypermobbingsituation. Kannst Du mir einen Überblick über meinen Datensatz geben?* In 15 Fällen gibt ChatGPT einige Beispielvariablen aus und berichtet grob über den Inhalt des Datensatzes.  Des Weiteren werden die Anzahl von Beobachtungen und Variablen ausgegeben. Grundsätzlich werden hier keine Skalenniveaus angegeben – hiernach sollte eine explizite Frage erfolgen. Allerdings unterscheidet sich die Auswahl der ausgegebenen Variablen in fast allen Fällen.


# Deskriptive Analyse

Um die deskriptive Analyse durchzuführen wurde folgender Prompt verwendet: *Kannst Du mir meinen Datensatz deskriptiv analysieren?* Hierbei wurden zunächst deskriptive Kennwerte zu einigen Beispielvariablen ausgegeben. Am häufigsten ist ChatGPT dabei auf die Variablen eingegangen, welche die Bewertung der Fallvignetten beschreiben (z.B. AntonThomasgemein).In den meisten Fällen wird der **Mittelwert**, die **Standardabweichung** und das **Minimum** und **Maximum** der Verteilung ausgegeben. Als Beispiele werden meist unterschiedliche Variablen benutzt und nur selten werden bereits Visualisierungen ausgegeben. Bei der expliziten Frage nach Visualisierungen werden in sechs Fällen **Histogramme**, in drei Fällen **Boxplots** und in drei weiteren Fällen beides ausgegeben. Diese wurden in R immer über den Befehl `ggplot` erstellt. Die Variablen unterscheiden sich auch hier meist und demografische Angaben wie das Alter oder das Geschlecht werden nur selten automatisch ausgegeben – hiernach sollte eine explizite Nachfrage stattfinden. Auffällig bei der Analyse des Geschlechts war, dass ChatGPT in zwölf Durchführungen Probleme hatte, mit dieser Variable deskriptive Analysen durchzuführen. Bei genauerer Betrachtung des R-Codes fällt auf, dass ChatGPT zur Analyse den Variablennamen *Geschlecht* nutzt, obwohl die Variable im Datensatz als *sex* betitelt ist und dies auch im Codebuch korrekt festgehalten wurde. Somit sollte der R-Code immer nochmal überprüft werden. Es sollte außerdem darauf geachtet werden, dass die Visualisierung der Daten auch sinnvoll ist (Histogramme bei kontinuierlichen Variablen und Balkendiagramme bei kategorialen). In sechs Fällen konnte ChatGPT keine Visualisierungen ausgeben, in einigen Fällen wurden leere Diagramme und in vier Fällen wurden Abbildungen unleserlich dargestellt, wie in folgendem Beispiel: 

![](/extras/chatgpt/static/replication/ChatGPT3.png)
<br>
Zum akuraten Vergleich hier nochmal zwei Positivbeispiele: 
<br>
![](/extras/chatgpt/static/replication/ChatGPT4.png)


# Vorbereitung Datensatz: Ausreißer und Auffälligkeiten, Ausschluss von Personen

Um den Datensatz auf die Analyse vorzubereiten, wurde ChatGPT zunächst gefragt, ob es Ausreißer oder Auffälligkeiten in diesem Datensatz gibt (Prompt: *Gibt es Auffälligkeiten oder Ausreißer in meinem Datensatz?*. Hierbei wurden in 14 Fällen **Boxplots** zur Veranschaulichung der Ausreißer erstellt. Teilweise wurde nur für eine einzelne Variable ein Boxplot erstellt, wobei hier das Alter am häufigsten von ChatGPT gewählt wurde. In den meisten Fällen jedoch wurden mehrere Variablen, zum Teil sogar alle Variablen gewählt, wobei hier die Abbildung sehr unleserlich wurde.
Die Auswahl der Variablen war auch hier sehr unterschiedlich und folgte augenscheinlich keinem besonderen Prinzip. In vier weiteren Durchgängen wurde der **z-Score** für ausgewählte Variablen berechnet und interpretiert, wobei in zwei der Fälle nur der **z-Score** des Alters ausgegeben wurde. In einem Fall konnte ChatGPT keine Analyse von Ausreißern durchführen, in allen anderen Durchführungen wurde der Schluss gezogen, dass in dem Datensatz Ausreißer vorhanden sind. Auf die Nachfrage, wie ChatGPT mit den Ausreißern umgehen würde, schlägt das Tool zunächst drei bis sieben Strategien vor, wie diese Ausreißer detaillierter untersucht werden könnten. Als Antwort auf die Frage, ob eine dieser Strategien durchgeführt werden kann, wurden in 16 Durchgängen die Ausreißer weitergehend analysiert, transformiert oder entfernt. So wurde in fünf Durchgängen eine **Logit-Transformation** durchgeführt - auch hier unterschied sich die Auswahl von Variablen, wobei die Transformation jeweils nur an einer Variable vorgenommen wurde. In einem Fall wurde eine **Sensitivitätsprüfung**, segmentiert nach Altersgruppen durchgeführt, anschließend ist ChatGPT hier allerdings zu dem Entschluss gekommen, keine Ausreißer zu entfernen. In acht weiteren Fällen wurden die Ausreißer der entsprechend fokussierten Variablen einfach entfernt und in zwei der Durchführungen beibehalten. 

Als nächstes wurde die Frage gestellt, ob es Personen im Datensatz gibt, die vor weiteren Analysen ausgeschlossen werden sollten (Prompt: *Würdest Du Personen aufgrund ihres Antwortverhaltens aus diesem Datensatz ausschließen?*. Um diese Frage zu beantworten, schlägt ChatGPT auch hier meist verschiedene Strategien vor und erklärt hierzu meist das spezifische Vorgehen. In einem Fall hat ChatGPT direkt fünf Personen aufgrund von inkonsistenten Antworten ausgeschlossen. In allen anderen Fällen wurde erfragt, ob es Personen mit fehlenden Antworten gibt. Diese Frage wurde in zwölf Durchführungen richtig mit nein beantwortet, in fünf Fällen wurden fälschlicherweise (in diesem Datensatz wurden bereits im Vorhinein alle fehlenden Werte extrahiert) Personen mit fehlenden Werten analysiert bzw. gleich entfernt. In zwei Fällen konnte diese Analyse gar nicht durchgeführt werden.

In 15 von 20 Fällen wird der Ausschluss von Ausreißern durchgeführt. Sowohl die Gründe hierfür variieren als auch die Anzahl an ausgeschlossenen Personen. Beispielsweise bleiben nach Ausschluss einmal 87 Teilnehmer übrig und in anderen Fällen 63, 49 und 52 Teilnehmer. Wie es zum tatsächlichen Ausschluss kommt, wird zudem auch unterschiedlich begründet: Einmal argumentiert ChatGPT der Ausschluss komme durch inkonsistente, fehlende Antworten und zu hohe Ausreißer zustande und in anderen Fällen begründet er den Ausschluss aufgrund extremer Werte in einer einzigen Variable (Wahrgenommene Schwere Thomas). In Fällen, in denen kein Ausschluss stattfand, begründete ChatGPT dies mit einer hohen Datenqualität, Fehlen von spezifischen Schwellenwerten oder fehlenden Zugriffs auf die Ausführung des Codes oder Analyse der Datei. 
Auch der R-Code der verwendet wurde, um Personen mit fehlenden Werten zu identifizieren zeigte keine Konsistenz auf - mal wurde der Code `treshold_missing <- 0.2 * ncol()` benutzt, mal wurde der Anteil fehlender Daten über den Code `daten$missing_rate <- rowMeans(is.na(daten))` berechnet. 

# Explorative Datenanalyse

Um die Auswahl der Analysen von ChatGPT und die Herangehensweise nicht zu beeinflussen, wurde der allgemeine Prompt gestellt: *Welche Analysen würdest Du in diesem Datensatz durchführen, um den Zweck der Studie zu erfüllen?*. Simultan war in fast allen Durchgängen, dass ChatGPT zunächst Vorschläge für spezifische Analysen vorgebracht hat. Am häufigsten wurde die Analyse von deskriptiven Statistiken, Korrelationen und Regressionen vorgeschlagen. Hinzu kamen jeweils Beschreibungungen zu den einzelnen Verfahren und wie diese wiederum den Zweck der Studie erfüllen können. Nur in zwei Fällen wurde automatisch eine Analyse durchgeführt. Auf Nachfrage wurde von ChatGPT in achtzehn Durchführungen eine Korrelationsanalyse und in siebzehn Fällen eine Regressionsanalyse ausgegeben. Auffällig war, dass in Fällen, in denen ursprünglich R-Codes mit ausgegeben wurden, ab dem Zeitpunkt der Analyse nur noch der Python Code ausgegeben wurde.

## Korrelationen

In den Fällen, in denen von ChatGPT eine Korrelationsanalyse berechnet wurde, wurde explizit mit folgender Aufforderung danach verlangt: *führe eine sinnvolle Korrelationsanalyse für mich durch*. In neun Durchführungen wurde daraufhin zunächst eine **Korrelationsmatrix** erstellt. Nach grober Überprüfung wurde diese auch mit richtigen Werten und leserlich dargestellt. In einem Fall hat ChatGPT anstatt einer Matrix eine Korrelationstabelle ausgegeben, wobei diese meist stark verschoben und damit nicht gut erkenntlich war. In zwei Durchführungen konnten keine Korrelationen berechnet werden. Die Variablen, die verwendet wurden, unterschieden sich von Anwendung zu Anwendung sowohl in ihrer Anzahl als auch in ihrem Sinn. Nur in zwei Durchführungen wurde eine Signifikanztestung der Korrelationen mittels eines **t-Tests** durchgeführt. In beiden Durchführungen waren die Ergebnisse richtig, konnten allerdings aufgrund der verschiednenen Variablen nicht miteinander verglichen werden. In den Fällen, in denen der R-Code für Korrelationen ausgegeben wurde, wurde der Befehl `cor()`bzw. `cor.test()` für die Signifikanztestung verwendet. In einigen Fällen wurden besonders interessante Korrelationen zwischen aus alten Analysen stammenden Hebelwerten und Variablen, die sich noch im Datensatz befanden, von Chat GPT besonders hervorgehoben. Grundsätzlich hat er dies in der Theorie richtig erkannt, allerdings führt dies zum einen zur Annahme, dass der eingespeiste Datensatz auf die wichtigsten Variablen reduziert sein sollte. Zum anderen muss festgehalten werden, dass dies inhaltlich keinen Sinn ergibt, da es sich beispielsweise zum Teil um Korrelationen zwischen denselben Variablen handelt.


## Multiple Regression

Auch Regressionen wurden nur auf Nachfrage berechnet und konnten schwer miteinander verglichen werden, da auch hier immer unterschiedliche Variablen sowohl als unabhängige Variablen, als auch Prädiktoren (abhängige Variablen) verwendet wurden. Inhaltlich hat die Zuweisung von UV und AV’s in einigen Fällen wenig Sinn ergeben. Als Ergebnis hat ChatGPT in allen siebzehn Fällen **R²** ausgegeben, in fünf den **F-Wert** der Regression und auch in fünf Durchführungen den **p-Wert**, wobei sie beiden Werte hier nicht immer gleichzeitig ausgegeben wurden. Elf Mal konnte ChatGPT keine Regressionsanalyse durchführen und in manchen Fällen wurden zusätzlich die Koeffizienten und das Intercept ausgegeben. Neun der aufgestellten Modelle waren nicht signifikant und lediglich drei zeigten Signifikanz. In drei der siebzehn Regressionsanalysen schlug ChatGPT vor weitere bzw. andere Variablen mit in das Modell aufzunehmen, doch durch diese Modellanpassung entstand in allen Fällen keine Veränderung der Signifikanz. In Einzelfällen hat ChatGPT **R² adjustiert** und damit auf die Stichprobengröße und die Anzahl der Prädiktoren angepasst und in zwei Durchführungen erbrachte ChatGPT Hinweise auf fehlende **Multikollinearität**, prüfte diese aber nicht nochmal genau. 


## Gruppenvergleiche

Auf die Frage hin, in welche Gruppen ChatGPT den Datensatz einteilen würde, um das Ziel der Studie zu erreichen, wurden ebenfalls sehr unterschiedliche Ergebnisse geliefert. Konsistenterweise schlug ChatGPT in allen Fällen vor, nach *demographischen Daten* und *Erfahrung in Bezug auf Mobbing bzw. Cybermobbing* zu gruppieren. Die Einteilung nach Erfahrungen wurde allerdings in unterschiedlicher Form von ChatGPT formuliert. So zum Beispiel in Form von Mobbing oder Cybermobbing und ob bereits Erfahrungen mit verletzenden Nachrichten gemacht wurden. In vier Fällen schlug ChatGPT explizit die Einteilung nach Empathie-Leveln vor, in anderen Fällen wurde z.B. die Einteilung nach *emotionalen Zuständen* oder die *Reaktion auf Stimuli* (in sechs Fällen) formuliert. Zehn mal sollte eine Gruppeneinteilung nach Persönlichkeitsmerkmalen, psychologischen Profilen/Zuständen durchgeführt werden. Es ist anzunehmen, dass ChatGPT in diesem Fall die Begriffe synonym verwendet. Einheitlich war, dass ChatGPT nur Vorschläge erbrachte um den Datensatz inhaltlich aufzuteilen, nie aber mathematisch (wie zum Beispiel durch einen Mediansplit). Auf explizite Nachfrage fand in 15 von 20 Fällen die Gruppenaufteilung nach der Bekanntheit des Zuschauereffekts statt. Um diese Gruppen auf Unterschiedlichkeit zu überprüfen, wurde in acht Durchführungen eine **ANOVA** und in zwei ein **t-Test** berechnet. Demnach konnte in fünf Fällen kein Gruppenvergleich durchgeführt werden. Diese Analysen wurden in zwei Fällen signifikant und in acht Fällen nicht. Allerdings lassen sich auch hier keine Ergebnisse miteinander vergleichen, weil sich die abhängigen Variablen von Analyse zu Analyse unterschieden haben. 


## Darstellung der Ergebnisse

Um eine Darstellung der Ergebnisse zu erhalten, wurde ChatGPT nach den wichtigsten Erkenntnissen der bisherigen Datenanalyse gefragt. In allen Fällen fasst ChatGPT die bisherigen Berechnungen stichpunktartig zusammen. Unterschieden wurden die Untersuchungen in der Tiefe der Ergebnisdarstellungen und im Inhalt der Zusammenfassung. So gab ChatGPT zum Beispiel in einem Beispiel nur aus ‘es gibt Einflüsse des Geschlechts’, definierte dabei aber nicht weiter, welche Einflüsse exakt vorlagen. In einem anderen Beispiel wiederum berichtete ChatGPT von *signifikanten Einflüssen des Geschlechts auf die Bewertung der Verletzbarkeit*. In einem Fall wurden nur hypothetische Ergebnisse angezeigt, da gar keine Analysen vorgenommen werden konnten. Des Weiteren wurden in 14 Durchgängen weitere Vorschläge für zukünftige Analysen der Studie durch ChatGPT ausgegeben. Diese variierten dabei von Fall zu Fall und gingen über die Aufforderung zur Hinzunahme weiterer Variablen in die aufgestellten Modelle bis hin zum Vorschlag von spezifischen weiteren Analysen. 


# Fazit und Empfehlungen

Die größte Erkenntnis unserer Analysen ist, dass sich keine zuverlässige Replikation durchführen lässt. Obwohl das Vorgehen während der Durchführungen konstant blieb, entstanden jeweils unterschiedliche Ergebnisse. 
Trotzdem lassen sich einige Implikationen abbilden, die im Folgenden kurz erläutert werden. 

In den Analysen war auffällig, dass sich ChatGPT in einigen Fällen in einer **Endlosschleife (Loop)** aufhängt und dort auch nach mehrmaliger Nachfrage nicht von allein wieder herausfindet. So war es zum Beispiel so, dass sich ChatGPT in manchen Durchführungen an einer Variable aufgehangen, und anschließend alle weiteren Analysen und Visualisierungen nur noch mit dieser Variable vorgenommen hat.
Wie aus dem Beispiel der Korrelationsanalyse hervorgeht, ist zu empfehlen sowohl das Codebuch als auch den Datensatz äußerst genau zu führen bzw. zu pflegen. Damit kann die Wahrscheinlichkeit reduziert werden, dass sich ChatGPT in einem Loop aufhängt.

Unabhängig vom Zweck dieser Studie lässt sich inhaltlich noch anmerken, dass sich das halbstrukturierte Interview im Aufbau und Abfolge an einer bereits durchgeführten Analyse mit dem Datensatz orientiert. Umso interessanter ist es, dass ChatGPT im Grunde genommen nicht auf die Hauptergebnisse dieser Analyse kam. Wenn man dem Tool allerdings die zu analysierenden Variablen mit Hypothese und präferierten statistischen Auswertungsverfahren als Prompt formuliert, kommt es auf dieselben Ergebnisse wie die ursprüngliche Analyse. 

Zum aktuellen Zeitpunkt und unter Berücksichtigung der verwendeten Version lässt sich festhalten, dass ChatGPT als Tool für eine replizierte Datenanalyse mit gleichem Prozess noch ungeeignet ist. ChatGPT ist geeignet, um einen Überblick über den Datensatz zu erhalten und Vorschläge für Berechnungen zu erlangen, die jedoch nur als grober Rahmen betrachtet werden und unbedingt überprüft werden sollten.

