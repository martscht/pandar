---
title: "Markdown Übung" 
type: post
date: '2022-11-14' 
slug: basic-markdown-uebung
categories: ["LIFOS Extras", "LIFOS"] 
tags: ["Extras","Setup","Git"] 
subtitle: ''
summary: 'In diesem Beitrag wird euch erklärt, wie ihr in LIFOS ein eigenes Markdown-Projekt erstellt und innerhalb des Projekts Übung mit Markdown erlangt. Die eigentlichen Übungsaufgaben sind dabei nur innerhalb des Projektes.' 
authors: [schloter, nehler, pommeranz] 
weight: 3
lastmod: '2025-02-12'
featured: no
banner:
  image: "/header/code_weave.jpg"
  caption: "[Courtesy of Pixabay](https://pixabay.com/images/id-108881/)"
projects: []
reading_time: false
share: false
publishDate: '2022-11-24'

links:
  - name: DE
    url: /lifos/extras/basic-markdown-uebung
  - name: EN
    url: /lifos/extras/basic-markdown-uebung-en

output:
  html_document:
    keep_md: true
---

# Einführung   
  
Wie Ihr in den Grundlagen für LIFOS bereits gesehen habt, ist zumindest ein Bestandteil eures Projekts in Markdown Code geschrieben - das README. [Hier](/post/eigenesprojekt/#Markdown) haben wir bereits die wichtigsten Informationen über Markdown aufgeführt, damit Ihr euer eigenes README angemessen gestalten könnt. Wir wollen euch aber nochmal zusätzlich eine Übungsmöglichkeit für Markdown bieten, indem Ihr in einem Projekt auf LIFOS ein Dokument nachbauen sollt. Im Folgenden werden dafür alle wichtigen Schritte beschrieben, in denen Ihr ein eigenes Projekt erstellt um die Markdownübungen durchzuführen und wie Ihr dieses im Nachhinein löscht. 

### Erstellen eines persönlichen Projects 

Um unsere Markdown Übung auf LIFOS durchzuführen, müsst Ihr erstmal ein eigenes Project mit dem entsprechenden Template erstellen. Dafür geht Ihr auf der LIFOS-Startseite auf *New Project*. Hier ist es sehr wichtig, dass Ihr das nicht über die Abteilungsgruppe erstellt, sonst wird die Gruppe mit etlichen Markdown-Tutorials zugespamt.

![](/lifos/gitlaborientierung_newproject.png)

Ihr müsst hier nur auf den **New Project**-Button gehen und habt ein neues eigenes Projekt erstellt. 

Anschließend öffnet sich eine Seite auf der Ihr 4 Möglichkeiten vorfindet: 

![](/lifos/gitlaborientierung_newprojectoptions.png) 

Hier klickt Ihr auf *Create from template*, da ein eigenes Template für diese Markdown-Übung existiert. Das macht es euch ein bisschen einfacher. Um auf das Übungs-Template zuzugreifen, müsst Ihr in folgender Spalte auf "Instance". Die "Built-in" Templates sind globale Templates, die jedem:r <span style="color: darkred;">**GitLab**</span>-User:in zur Verfügung stehen. Diese könnt Ihr euch ein anderes Mal gerne anschauen oder mit einem Testprojekt erkunden. 

![](/lifos/gitlaborientierung_newprojectinstance.png) 

Nachdem Ihr auf "Instance" geklickt habt, sucht Ihr das Template mit dem Namen **_Markdown_Übung_Template_**. 
 
![](/lifos/gitlaborientierung_markdownInstanceTemplate.png) 

Das Visibility Level für dieses Projekt könnt Ihr auf *Private* stellen. Damit ist es nur für euch sichtbar, aber da es hier nur um die Übung geht, ist das kein Problem. Visibility Level haben wir [hier](/lif/lifos/eigenesprojekt#visibility-levels) schonmal erklärt.

## Struktur des Templates

In dem Template findet Ihr neben dem README noch drei weitere Dateien. 

![](/lifos/gitlaborientierung_uebungtemplate.png) 
Die Datei, an der Ihr üben könnt, heißt "Übungsdokument.md". Wie genau Ihr diese verändern könnt, wird euch im nächsten Abschnitt gezeigt. Wenn Ihr auf die Datei mit dem Namen "OpenScience.pdf" klickt, seht Ihr wie das Enddokument aussehen soll. Die Datei "Lösung.md" enthält die Markdown-Lösung zu dem Dokumemt. Diese solltet Ihr natürlich nur anschauen, wenn Ihr euer fertiges Dokument abgleichen wollt oder wirklich nicht mehr weiter wisst. 

<!-- Warum hast du die Lösung nicht auch in einem Markdown Dokument? hab ich versucht, allerdings "übersetzt" GitLab das direkt, wenn man es nur auf dem Server anschaut, was zu Verwirrungen kommen könnte, wenn man die Lösung in einem Klick anschauen will. (Ich wäre davon genervt, glaube ich) -->

## Dokument bearbeiten

Um das "Übungsdokument.md" zu bearbeiten, klickt Ihr auf dieses drauf. Anschließend geht Ihr auf *Open in Web IDE*. 

![](/lifos/gitlaborientierung_openuebunginwebide.png) 

Dort könnt Ihr unter *Edit* das Dokument mit eurem Markdown-Code füllen und unter *Preview Markdown* direkt schauen, wie es "übersetzt" aussehen wird. 

![](/lifos/gitlaborientierung_webidetemplate.png)

Ihr könnt auch auf das Dokument selbst klicken, um es vorzuschauen.

![](/lifos/gitlaborientierung_preview.png)

Per <> - Knopf könnt Ihr auch zur Code-Ansicht zurückwechseln.

![](/lifos/gitlaborientierung_code.png)

Falls Ihr nun Änderungen in eurem README getätigt habt, die Ihr behalten wollt, könnt Ihr das auf zwei unterschiedichen Wegen tun. 

Der eine geht über die *Web IDE*, die wir gerade schon geöffnet haben. Wir vollziehen nun eine Änderung an unserem Dokument.

![](/lifos/gitlabMarkdown_ÄnderungReadMe.png)

Ihr könnt euch diese Veränderung, wie Ihr wisst auch im "übersetzten" Zustand anschauen, wenn Ihr auf *Preview Markdown* klickt. Wenn Ihr zufrieden mit der Änderung seid, geht Ihr link unten auf *Create commit...*.

![](/lifos/gitlabMarkdown_CreateCommitWebIDE.png)

Ihr gebt eine *Commit Message* ein. Diese ist wichtig, um Änderungen später nachzuvollziehen. Das Markdown-Übungs-Projekt ist zwar nur für euch persönlich, aber auch man selbst sucht später nochmal nach den Gründen für einzelne Änderungen, die man im Laufe der Zeit gemacht hat.

![](/lifos/gitlabMarkdown_CommitTest.png)

Wie Ihr sehen könnt, könnt Ihr bei einem Commit entweder den **main** Branch auswählen oder einen neuen Branch erstellen. Hier wählt Ihr standardmäßig den **main** Branch aus. Falls Ihr mehr über Branches wissen wollt, schaut euch dieses [Tutorial](https://pandar.netlify.app/post/branches/) an. Eure Änderungen sind jetzt im README enthalten. 

<!-- Link muss aktualisiert werden -->
<!-- Branches waren jetzt im eigene Projekte Teil gar kein Thema mehr - sollte vlt an einer Stelle auch angeschnitten werden. - evtl. im vertiefende Einführung? Hier muss man halt nur den main-Branch auswählen, weil die default Option ist einen neuen zu erstellen (bei jedem Commit) und das wollen wir ja nicht.-->

Eine weitere Möglichkeit wäre, dass README herunterzuladen auf euren Rechner, dort die Änderungen zu tätigen und anschließend das README mit Update wieder hochzuladen. Achtet auch hier darauf, beim Hochladen auf dem **main** Branch zu bleiben! 

Wenn Ihr denkt, euer Dokument entspricht der Vorlage, könnt Ihr es mit der "Lösung.txt" Datei vergleichen und schauen, ob Ihr alles richtig gemacht habt. 
 

### Löschen eures Projektes

Wie beschrieben, ist das Löschen von Projekten, die einer Gruppe zugehörig sind, für Studierende nicht möglich. Da das Markdown-Übungs-Projekt aber eine persönliche Zuordnung zu euch hat, habt Ihr die Berechtigigung, es zu löschen. Deshalb bekommt Ihr an dieser Stelle die Beschreibung, wie Ihr ein Projekt löschen könnt.

Zuerst geht Ihr auf das Projekt, das Ihr löschen wollt (zum Beispiel das abgeschlossene Markdown Tutorial). Anschließend klickt Ihr in der Seitenleiste auf *Settings* und dort auf *General*: 

![](/lifos/gitlabMarkdown_DeleteProject.png)

Hier müsst Ihr dann runterscrollen, bis Ihr *Advanced* dort stehen seht.

![](/lifos/gitlabMarkdown_AdvancedPrjectSet.png)

Nachdem Ihr das expandiert habt, scrollt Ihr wieder ganz ans Ende der Seite. Hier findet Ihr den Button mit dem Ihr euer Projekt löschen könnt. 

![](/lifos/gitlabMarkdown_DeleteProjectButton.png)
Wie es auch schon unter dem Button geschrieben steht, müsst Ihr euch 100% sicher sein, ob Ihr das Projekt löschen wollt oder nicht. 

Nachdem Ihr die Sicherheitsabfrage bearbeitet habt, könnt Ihr euer Projekt dann löschen. 

![](/lifos/gitlabMarkdown_DeleteProjectCheck.png)

Da es sich um ein persönliches Projekt handelt, wird es direkt gelöscht. Das unterscheidet den Vorgang vom Löschen von Projekten, die Gruppen zugehörig sind - also dem Prozess, den eure Betreuenden dort durchführen können.

## Fazit
Ihr seht, dass euch Markdown vielfältige Möglichkeiten eröffnet euer README ansprechend zu gestalten. Wir haben in dieser Übung erstmal nur die Verwendung grundlegender Funktionalitäten von Markdown eingefordert. Wer Interesse hat, kann sich natürlich mit weiteren Möglichkeiten der Nutzung beschäftigen, wofür wir im Folgenden noch Ressourcen verlinken. Beispielsweise kann die offizielle [Markdown Dokumentation](https://www.markdownguide.org/extended-syntax/) empfohlen werden. 

<!--## Subgruppen

Das zweite große Thema dieses Tutorials ist nur für einen Teil von euch relevant. Hier wird man hinverlinkt, wenn man in den Visibility-Einstellungen keine passende Option für das eigene Projekt gefunden hat. 

Die Lösung kann durch sogenannte Subgruppen erreicht werden. Dabei wird aus der übergeordneten Elterngruppe der Abteilung eine Subgruppe gebildet, in der nur spezifische Personen der übergeordneten Gruppe eingeladen sein können. In jeder Elterngruppe können beliebig viele Subgruppen existieren. Benutzt dieses Tool aber bitte wirklich nur, wenn es die Lage des Datenschutzes nicht anders zulässt.

Außerdem kann man Subgruppen für folgendes benutzen: 

1. gut zum organisieren größerer Projekte
2. man kann jedem User eine andere Rolle geben (z.B. was er alles bearbeiten kann und was nicht)

### Subgruppen erstellen 

Um eine Subgruppe zu erstellen, müsst Ihr unter *Menu* und *Groups* auf **Your Groups** gehen. 

![](/post/gitlabMarkdown_createSubgroups.png)

Anschließend wählt Ihr die Gruppe aus in der Ihr für euer Projekt eine Subgruppe erstellen wollt. In der Gruppe geht Ihr oben rechts auf **New Subgroup**. 

![](/post/gitlabMarkdown_createSubgroups2.png)

Danach öffnet sich noch ein Fenster bei dem Ihr auf **Create Groups** klickt. Danach öffnet sich eine Seite in der Ihr alle möglichen Einstellungen für euer Projekt festlegen könnt. 

Zum einen könnt Ihr festlegen,  ob nur Ihr diese Gruppe benutzt oder ob Ihr auch Projektpartner*innen habt. Diese könnt Ihr darunter direkt einladen über Ihre Mailadressen. 

Eure erstellte Subgruppe findet Ihr dann auf der Startseite der übergeordneten Gruppe.

![](/post/gitlabMarkdown_seeSubgroups.png)

### Projekt in einer Subgruppe erstellen

Nachdem Ihr die Subgruppe erstellt habt, könnt Ihr hier ganz normal ein Projekt erstellen, wie Ihr es von normalen Gruppen gewöhnt seid. Falls Ihr das nochmal auffrischen wollt, hier ist der [Link](https://pandar.netlify.app/post/lifos-orientierung#projekt-erstellen).

Nachdem Ihr dieses Projekt erstellt habt, könnt Ihr euch unter **Settings** und *General* die Visibility-Features anschauen. 

![](/post/gitlabMarkdown_subgroupVisibility.png)

Wie Ihr unter **Repository** sehen könnt, sind nur Projektmitglieder dazu in der Lage Dateien in diesem Projekt anzuschauen oder zu bearbeiten. 

## Fazit
Subgruppen bieten eine weitere Organisationsstruktur innerhalb einer Gruppe. Hier sollten sie allerdings nur benutzt werden, wenn aus Datenschutz-Technischen Gründen keine andere Option übrig bleiben sollte.  -->
