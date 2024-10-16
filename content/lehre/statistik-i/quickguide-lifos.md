---
title: "LIFOS im PsyBSc2-Praktikum " 
type: post
date: '2023-10-09' 
slug: quickguide-lifos
categories: ["Studienleistung", "LIFOS"] 
tags: ["Zusatz", "Gruppenprojekt", "Open Science"] 
subtitle: ''
summary: 'In diesem Beitrag wird Ihnen eine kurze Einführung in LIFOS (Lokale Infrastruktur für Open Science) gegeben. Hierbei handelt es sich um eine universitätsinterne Übungsplattform für Psychologie-Studierende der Goethe Universität, die es Ihnen ermöglichen soll, Open Science Praktikem in einem geschützten Raum zu üben. In diesem Quickguide wird Ihnen erklärt, wie Sie sich bei LIFOS anmelden und Ihr Projekt am richtigen Ort anlegen. Außerdem wird erläutert, welche Schritte Sie im Rahmen Ihres Praktikums auf LIFOS durchführen sollen.' 
authors: [beitner, nehler]
weight: 12
lastmod: '2024-04-02'
featured: no
banner:
  image: "/header/frog_collective.jpg"
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
    name: Gruppenprojekt
    url: /lehre/statistik-i/gruppenprojekt
  - icon_pack: fas
    icon: pen-to-square
    name: Ergebnisbericht
    url: /lehre/statistik-i/ergebnisbericht
output:
  html_document:
    keep_md: true
---





Wie wir bereits besprochen haben, sollen Sie im Rahmen des Praktikums eine erste eigene Studie konzipieren. Hierfür wird Ihnen von Ihren Dozent:innen ein Datensatz zur Verfügung gestellt, an dem Sie Ihre Hypothesen inferenzstatistisch testen können. Dabei sollen Sie direkt die Praktiken guter, transparenter Wissenschaft mit Hilfe unserer Plattform [LIFOS](https://lifos.uni-frankfurt.de) kennen lernen und anwenden. Wir haben alle wichtigen Informationen hier in diesem Beitrag nochmals für Sie zusammengefasst. Sollten in der Zusammenarbeit in Ihrer Kleingruppe noch Fragen auftreten, wenden Sie sich bitte an Ihre/n Dozent:in.


<details><summary><b>Kernfragen dieser Lehreinheit</b></summary>

- Was müssen Sie auf [**LIFOS**](#firststeps) tun, um loslegen zu können?
- Wie legt man auf LIFOS ein [**Projekt**](#projektstart) an?
- Wie [**bearbeitet**](#bearbeitung) man ein Projekt auf LIFOS?
- Was ist eine [**Präregistrierung**](#praeregistrierung) und wie können Sie Ihr Projekt präregistrieren?
- Worauf müssen Sie achten, wenn Sie Ihre [**Analysen**](#analysen) teilen? 
- Wie schließen Sie ein Projekt auf LIFOS ab?
- Wie kann man einen Commit [**korrigieren**](#Hilfe), den man auf dem falschen Branch ausgeführt hat?

</details>

***

# Erste Schritte auf LIFOS {#firststeps}

[LIFOS](https://lifos.uni-frankfurt.de) steht für **L**okale **I**nfrastruktur **f**ür **O**pen **S**cience und ist unsere universitätsinterne Übungsplattform für Studierende der Psychologie-Studiengänge der Goethe-Universität Frankfurt. Die Plattform basiert auf GitLab und ist der Struktur des [Open Science Frameworks](https://osf.io) nachempfunden. Die Idee ist, Open Science Praktiken im Rahmen des Studiums in einem geschützten Rahmen üben und durchführen zu können. Um mit Ihrem Projekt auf LIFOS loszulegen, müssen Sie zuerst folgende Schritte absolvieren:

<ol><li><p><b>Loggen Sie sich auf LIFOS ein</b></p> 
Hierfür benötigen Sie lediglich die Zugangsdaten Ihres HRZ-Kontos.</li> 

<li><p><b>Finden Sie Ihre Praktikums-Gruppe und beantragen Sie Zugang</b></p>
Projekte auf LIFOS müssen in den jeweiligen Abteilungen/Kursen angelegt werden, um auch diesen zugeordnet werden zu können. Das heißt, Sie müssen erst Mitglied Ihrer PsyBSc2 Praktikumsgruppe auf LIFOS werden, um dann in ebenjener Gruppe ein Projekt anzulegen. Um die Gruppe auf LIFOS zu finden, klicken Sie oben links auf die drei Striche, dann auf *Groups*, dann auf *View all groups*. </li></ol>

![](/lehre/statistik-i/quickguide-lifos01.png)

Danach müssen Sie noch oben auf *Explore public groups* klicken. Nun können Sie alle öffentlichen Gruppen auf LIFOS sehen. Schauen Sie nach der Gruppe **PsyBSc2 Statistik I Praktikum WS 23-24**. Nach einem Klick ins freie Feld werden Ihnen alle neun Praktikumsgruppen angezeigt. 

![](/lehre/statistik-i/quickguide-lifos02.png)

Klicken Sie auf Ihre Gruppe. Oben steht nun blau hinterlegt *Request access*. Klicken Sie drauf und bestätigen Sie. Gratulation! Sie haben so eben einen wichtigen Schritt gemeistert und Zugriff zu Ihrer Praktikumsgruppe beantragt. Sobald Ihr Dozent/Ihre Dozentin Ihre Anfrage bestätigt hat, können Sie und Ihre Gruppe loslegen.


# Auf LIFOS ein Projekt anlegen {#projektstart}

Nachdem Sie und Ihre Gruppenkolleg:innen Mitglied in Ihrer Praktikumsgruppe wurden, können Sie Ihr Projekt in der Gruppe anlegen. Hierfür ist es wichtig, dass Sie bereits Ihre Fragestellung kennen, um einen inhaltlichen Titel für Ihr Projekt angeben zu können. Begeben Sie sich auf LIFOS zu Ihrer Praktikumsgruppe. **Wichtig**: Es reicht aus, wenn *eine* Person aus Ihrer Gruppe das Projekt anlegt. Sie können im Anschluss alle darauf zugreifen. Klicken Sie auf den blauen Knopf *New Project*, dann auf *Create from template*, dann auf *Instance*, und dann bei **PsyBSc2 Statistik I Praktikum Template** auf *Use template*. Hier können Sie nun Ihren Projekttitel eingeben und in der *Project description* geben Sie alle Namen Ihrer Projektgruppe, den Kurs, und das aktuelle Semester an und zwar im Stil: *Eure Namen – Kurs – Semester*. Zum Beispiel: Ameise Alex, Bär Berti, Chamäleon Chiara - Statistik I Praktikum - WiSe 2023/24.
Dadurch können andere später leichter nachvollziehen, wer an dem Projekt mitgearbeitet hat. Obwohl die folgenden Dinge bereits richtig eingestellt sein sollten, achten Sie vor der Erstellung noch darauf, 
- dass bei Template das PsyBSc2 Template steht,
- dass bei Project URL Ihre Gruppe steht und
- dass das Visibility Level auf Internal gesetzt ist.

![](/lehre/statistik-i/quickguide-lifos03.png)

Alright, klicken Sie den *Create project* Knopf und schon steht Ihr Projekt!
Dadurch, dass Sie das Projekt basierend auf dem PsyBSc2 Template initialisiert haben, werden Ihnen bereits wichtige Strukturen vorgegeben (die sich aber auch bei Bedarf ändern und anpassen lassen). Alle weiteren Schritte werden von nun auch im README eures Projekts angezeigt, der Vollständigkeit halber aber auch nochmal hier. Für tiefergehende Informationen über LIFOS können wir euch unsere [generellen Tutorials auf pandaR](https://pandar.netlify.app/lifos/main/) ans Herz legen.


# Bearbeitung von Projekten auf LIFOS {#bearbeitung}

Auf LIFOS kann man Projekte bearbeiten, indem man Dateien und Ordner hinzufügt, umbenennt oder wieder entfernt. Außerdem kann man die README-Datei, auf die hier [gleich](#projektabschluss) noch eingegangen wird, bearbeiten. Um das Projekt zu bearbeiten, ist es am einfachsten, ins Web IDE zu gehen. Hier öffnet sich ein User Interface, in dem man ganz einfach agieren kann. Zum Beispiel lassen sich mehrere Dateien gleichzeitig hochladen, löschen, etc. Wenn Sie mit Ihren Änderungen fertig sind, klicken Sie links unten auf *Create commit*. Das ist ein Git-Befehl, auf den wir hier nicht näher eingehen werden. Jetzt können Sie *commit* erstmal als so etwas wie *Speichern* verstehen. Nach dem Klicken öffnet sich ein kleines Textfeld. Hier können Sie vermerken, welche Änderungen Sie vorgenommen haben. Achten Sie nun **unbedingt** darauf, dass Sie *commit to main branch* auswählen. Wenn Sie das alles befolgen, sind im Anschluss Ihre Änderungen im Projekt sichtbar. Sollten Sie die Änderungen doch nicht speichern wollen, können Sie oben rechts auch auf den rot umrandeten Knopf *Discard changes* klicken. 

![](/lehre/statistik-i/quickguide-lifos04.png)


# Präregistrierung auf LIFOS {#praeregistrierung}

Eine Präregistrierung ist ein Dokument mit einem Zeitstempel, dass Informationen über die Studie beinhaltet, die bereits vor der Datenerhebung festliegen und so transparent festgehalten werden. Dazu zählen insbesondere Informationen über die Hypothesen und die statistische Auswertung, wie zum Beispiel welche Konstrukte erhoben werden, welche Fragebögen dafür verwendet werden, und welche Methoden man verwendet, um die Hypothese zu testen. Außerdem hilft eine Präregistrierung dabei, das Projekt schon vor Durchführung ausführlich zu durchdenken und so Fehler oder Probleme noch vor dem Auftreten entdecken und beheben zu können. 

In Ihrem Projekt auf LIFOS finden Sie im Ordner *1_Präregistrierung* ein Word-Dokument namens *PsyBsc2_preregistration.docx*. Laden Sie dieses herunter und füllen Sie es aus. Auch hier reicht es aus, wenn Sie gemeinsam als Gruppe *eins* ausfüllen. Schicken Sie es dann Ihrem Dozenten/Ihrer Dozentin, um Feedback zu erhalten. Nachdem Sie das Feedback eingearbeitet haben und Ihre Präregistrierung abgesegnet wurde, können Sie Ihre Präregistrierung als PDF-Dokument wieder hochladen. Die Zeit, zu der das Dokument hochgeladen wird, wird als Zeitstempel für die Präregistrierung verwendet. Die Word-Datei können Sie dann aus Ihrem Projekt entfernen.


# Analysecode {#analysen}

Wenn Sie die Datenanalyse abgeschlossen haben, können Sie Ihr R-Skript im Ordner *3_Skripte* hochladen. Achten Sie darauf, dass die Ergebnisse auch auf anderen Rechnern reproduzierbar sind, sprich, dass Ihr Skript durchläuft und dieselben Ergebnisse ausgibt, egal von welchem Computer es ausgeführt wird. Darüber hinaus sollte Ihr Skript auch für unbeteiligte Personen verständlich sein. Achten Sie dafür auf eine sinnvolle Struktur, nutzen Sie sinnvolle Variablennamen und kommentieren Sie Ihr Skript ausführlich. All diese Dinge werden Sie auch im Statistik I Praktikum lernen.

# Weitere Schritte

Da es gute wissenschaftliche Praxis ist, auch die Materialien zu teilen, die zur Studie verwendet werden, gibt es diesen Ordner auch auf LIFOS. In *2_Materialien* können Sie alle Materialien hochladen, die in Ihrer Studie verwendet wurden. In diesem Fall ist dies der Fragebogen, den Ihre Dozent:innen mit Ihnen teilen.

Dies gilt ebenso für das Datenset, welches in *4_Daten* hochgeladen werden soll.

# Projektabschluss {#projektabschluss}

Wenn Sie mit Ihrem Gruppenbericht fertig sind, laden Sie die finale PDF-Version Ihres Berichts im Ordner *5_Bericht* hoch.
Zu guter Letzt, gibt es dann noch das *README.md*-Dokument. Das README ist eine Markdown-Textdatei, die Informationen über Ihr Projekt enthalten soll, einschließlich Zweck, Inhalt und weitere Details. Sie befindet sich normalerweise im Stammverzeichnis. Die README-Datei dient als Schnellreferenz für jeden, der versucht, euer Projekt zu verstehen oder zu verwenden, und ist eine wichtige Ressource für jeden, der auf sie stößt. Die Datei ist mit der Sprache Markdown formatiert. Wie man Markdown verwendet, können Sie [hier](https://pandar.netlify.app/lifos/grundlagen/eigenesprojekt/), [hier](https://pandar.netlify.app/lifos/extras/basic-markdown-uebung/) und [hier](https://www.markdownguide.org/basic-syntax/) erfahren. Wenn Sie die README-Datei angepasst haben und alle Dateien wie beschrieben hochgeladen haben, sind Sie mit Ihrem Projekt auf LIFOS fertig :)

## Hilfestellung{#Hilfe}

<details>
<summary>Was kann ich tun, wenn ich aus Versehen auf einen anderen Branch als <b>main</b> commited habe?</summary>

In diesem Fall könnt ihr eure Änderungen von dem falschen Branch auf Main pushen und den falschen Branch, sofern er aus Versehen erstellt wurde, auch löschen.

Zuerst solltet ihr auf euer Projekt gehen und auf der linken Seite das `Merge requests` Symbol anklicken

Hier solltet ihr eure Änderungen auf dem anderen Branch als *Merge Request* sehen.

![](/lehre/statistik-i/../../lifos/grundlagen/Gitlab_Project_Merge_Requests.png)

Klickt ihr dabei nun auf *create merge request* öffnet sich ein neues Fenster.

![](/lehre/statistik-i/../../lifos/grundlagen/Gitlab_Project_New_Merge.png)

Hier könnt ihr nun einen Titel und eine Beschreibung für euren Merge hinzufügen, der den Grund und Inhalt eures ursprünglichen Commits erklärt, und vielleicht auch auf den falschen Commit hinweist.


Wählt danach, sofern ihr den anderen Branch löschen wollt da ihr ihn unabsichtlich erstellt habt, `Delete source branch when merge request is accepted` aus. Danach könnt ihr `Create merge request` anklicken.

Ihr solltet nun auf einer neuen Seite landen

![](/lehre/statistik-i/../../lifos/grundlagen/Gitlab_Project_New_Merge_Confirm.png)

Hier müsst ihr euren Merge und das löschen des source branch von welchem aus der Fehler ausging erneut bestätigen und den `Merge`-button betätigen

Nach einem kurzen Moment solltet ihr nun sehen, dass der Merge erfolgreich war!

![](/lehre/statistik-i/../../lifos/grundlagen/Gitlab_Project_New_Merge_Sucess.png)

*Sollte dies nicht der Fall sein, oder solltet ihr irgendwo vorher bereits Probleme haben, könnt ihr auch LIFOS@uni-frankfurt.de kontaktieren.*
</details>
