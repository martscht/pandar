---
title: "Tests für unabhängige Stichproben - Aufgaben" 
type: post
date: '2019-10-18' 
slug: gruppenvergleiche-unabhaengig-aufgaben
categories: ["Statistik I Übungen"] 
tags: [] 
subtitle: ''
summary: '' 
authors: [koehler, buchholz, goldhammer, walter, nehler]
weight: 1
lastmod: '2024-03-27'
featured: no
banner:
  image: "/header/writing_math.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/662606)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/statistik-i/gruppenvergleiche-unabhaengig
  - icon_pack: fas
    icon: star
    name: Lösungen
    url: /lehre/statistik-i/gruppenvergleiche-unabhaengig-loesungen
output:
  html_document:
    keep_md: true
---



## Vorbereitung

> Laden Sie zunächst den Datensatz `fb23` von der pandar-Website. Alternativ können Sie die fertige R-Daten-Datei [<i class="fas fa-download"></i> hier herunterladen](/daten/fb23.rda). Beachten Sie in jedem Fall, dass die [Ergänzungen im Datensatz](/lehre/statistik-i/gruppenvergleiche-unabhaengig/#prep) vorausgesetzt werden. Die Bedeutung der einzelnen Variablen und ihre Antwortkategorien können Sie dem Dokument [Variablenübersicht](/lehre/statistik-i/variablen.pdf) entnehmen.

***

## Aufgabe 1
Wir wollen untersuchen, ob sich Studierende, die sich für Allgemeine Psychologie (Variable `fach`) interessieren, im Persönlichkeitsmerkmal Offenheit für neue Erfahrungen (auch Intellekt, `offen`) von Studierenden, die sich für Klinische Psychologie interessieren, unterscheiden? Gehen Sie in der Beantwortung der Fragen davon aus, dass wir einen $t$-Test durchführen werden. Die Testung der Voraussetzungen werden wir im Laufe der Aufgabe durchführen.

* Untersuchen Sie die Fragestellung zunächst rein deskriptiv. Bestimmen Sie dafür die Mittelwerte und empirischen Standardabweichungen der beiden Gruppen. 
* Formulieren Sie die Hypothesen basierend auf der Aufgabenstellung inhaltlich und statistisch.
* Welche Voraussetzung gibt es für die Durchführung des $t$-Tests. Bewerten Sie, ob diese gegeben sind und prüfen Sie diese gegebenenfalls.
* Führen Sie abschließend den t-Test und berichten Sie die Ergebnisse formal. $\alpha$ soll den Wert 0.05 haben.


## Aufgabe 2

In dieser Aufgabe soll untersucht werden, ob sich Studierende mit Wohnort in Frankfut, sich selbst zu Beginn der Praktikumsstizung als wacher eingestuft haben als Studierende, die nicht in Frankfurt wohnen. Für die Untersuchung soll der Mittelwert der beiden Gruppen betrachtet werden.

* Zunächst geht es an die Datenvorbereitung. Verwandeln Sie die Variable Ort in einen Faktor, bei dem eine `1` für `FFM` und eine `2` für `anderer` steht. **ACHTUNG**: Wenn Sie den Appendix des Tutorials durchgearbeitet haben, ist dieser Schritt nicht nötig.
* Außerdem muss der Skalenwert (`wm_pre`) noch erstellt werden. Dieser setzt sich aus den Mittelwerten der Fragen 2, 5, 7 und 10 des MDBF zusammen. Beachten Sie dabei, dass es 4 Antwortkategorien gab und die Items 5 und 7 vor der Skalenbildung invertiert werden müssen.
* Leiten Sie aus der Fragestellung die Hypothesen inhaltlich und statistisch ab.
* Nehmen Sie alle Voraussetzungen als gegeben an und führen Sie direkt den t-Test durch. Nutzen Sie als Signifikanzniveau $\alpha = 0.01$ und treffen Sie eine Entscheidung hinsichtlich der Hypothesen.



## Aufgabe 3

In dieser Aufgabe wollen wir die Frage beantworten, ob Studierende die auf Unipartys gehen (`uni3`), sich in Ihrer Lebenszufriedenheit von denen unterscheiden (`lz`), die dies nicht tun. Im Tutorial haben Sie bereits gelernt, dass Lebenszufriedenheit als schiefverteilt angenommen werden kann. Wählen Sie also einen Test, der diese Schiefe berücksichtigt.

* Welcher Test wäre an dieser Stelle geeignet. Leiten Sie aus der Fragestellung die passenden Hypothesen für diesen Test ab.
* Erstellen Sie eine neue Variable `unipartys` in unserem Datensatz `fb23`. Diese soll als Faktor vorliegen und aus `uni3` erstellt werden, wobei `0` für `nein` und `1` für `ja` steht.
* Betrachten Sie die deskriptivstatistischen Kennwerte und ordnen Sie diese hinsichtlich unserer Hypothese ein.
* Welche Voraussetzungen hat der von Ihnen ausgewählte Test? Beurteilen Sie die Voraussetzungen und testen Sie diese gegebenenfalls.
* Führen Sie abschließend die inferenzstatistische Prüfung durch und berichten Sie die Ergebnisse formal. $\alpha$ soll den Wert 0.05 haben.





## Appendix

Hier finden Sie noch eine Aufgabe, die den im Appendix des Tutorials behandelten Test abfragt.

<details><summary> Aufgabe zum Appendix </summary>

Ist die Wahrscheinlichkeit dafür, neben dem Studium einen Job (`job`) zu haben, die gleiche für Erstsemesterstudierende der Psychologie die in einer Wohngemeinschaft wohnen wie für Studierenden die bei ihren Eltern wohnen (`wohnen`)? Führen Sie die Testung mit $\alpha = 0.05$ durch.


</details>
