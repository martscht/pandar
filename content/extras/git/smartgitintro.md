---
title: SmartGit
type: post
date: '2021-08-01'
slug: smartgitintro
categories: ["Git"]
tags: []
subtitle: ''
summary: ''
authors: [nehler, schloter, rouchi]
weight: 3
lastmod: '2025-02-17'
featured: no
banner:
  image: "/header/vintage_car_headlight.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/282666)"
projects: []
reading_time: false
share: false
links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /extras/git/smartgitintro
output:
  html_document:
    keep_md: true
---

# Warum <span style="color: darkred;">**SmartGit**</span>?

Da das Terminal nicht die beste optische Repräsentation aller Möglichkeiten von <span style="color: darkred;">**Git**</span> bietet, wollen wir uns in diesem Tutorial mit <span style="color: darkred;">**SmartGit**</span> beschäftigen. Dieses bietet uns eine benutzerfreundlichere, anschaulichere  Oberfläche, mit der wir problemlos <span style="color: darkred;">**Git**</span>-Befehle ausführen können. Wir wollen uns hierbei zunächst anschauen, wie unsere bereits gelernten Befehle in <span style="color: darkred;">**SmartGit**</span> funktionieren. Anschließend werden wir noch weitere Möglichkeiten und Befehle kennen lernen.

## Einführung

<span style="color: darkred;">**SmartGit**</span> ist wie bereits geschildert eine grafische Oberfläche für die Verwendung von <span style="color: darkred;">**Git**</span> auf dem lokalen Rechner - aber auch in Verbindung mit **remote repositories** (also bspw. gehostet auf <span style="color: darkred;">**Github**</span>) . Das Programm existiert bereits seit 2009 und wurde stets weiterentwickelt, wodurch eine reibungslose Funktionsweise sichergestellt ist. Durch Ausführen von <span style="color: darkred;">**Git**</span>-Befehlen via Klick wird die Arbeit beschleunigt. Andere Befehle werden sogar automatisiert durchgeführt. Ein großer Vorteil von <span style="color: darkred;">**SmartGit**</span> ist dabei, dass es auch mit anderen Providern für **remote repositories** wie <span style="color: darkred;">**Bitbucket**</span> oder <span style="color: darkred;">**GitLab**</span> integrativ arbeiten kann, wobei wir uns im Tutorial weiterhin nur mit <span style="color: darkred;">**GitHub**</span> beschäftigen werden.

# Setup

Damit ihr <span style="color: darkred;">**SmartGit**</span> auf euren Rechnern verwenden könnt, müsst ihr zunächst das Programm herunterladen. Dies könnt ihr [hier](https://www.syntevo.com/smartgit/) für verschiedene Betriebssysteme machen. Auf der Website gibt es auch **Installation Instructions** für die verschiedenen Betriebssysteme. 


Bei den Einstellungen für <span style="color: darkred;">**SmartGit**</span> müsst ihr den Nutzungsbedingungen zustimmen und unter *License type* außerdem auswählen, dass ihr das Programm für "Non-commercial use only", also wissenschaftliche Zwecke verwendet, sodass ihr nicht für die Nutzung zahlen müsst. 

![](/git/images/smartgit_license.png)

Dies muss in einem zweiten Fenster noch einmal bestätigt werden. Als nächstes müsst ihr euch unter *User Information* einen Nutzernamen geben sowie eine E-Mail-Adresse angeben, über die ihr euer <span style="color: darkred;">**SmartGit**</span> konfiguriert. <span style="color: darkred;">**SmartGit**</span> sollte die Informationen aus eurer eigenen Konfiguration auf dem lokalen PC ziehen können und daher bereits anzeigen, welche E-Mail und welcher Name hinterlegt sind. Ansonsten gebt ihr am besten selbst Nutzernamen und die E-Mail-Adresse an, mit denen ihr <span style="color: darkred;">**Git**</span> auf dem Rechner konfiguriert habt! 

![](/git/images/smartgit_information.png)


Jetzt müsst ihr noch die Option *Use SmartGit as SSH client* auswählen. Dies ist für den Start der Arbeit mit <span style="color: darkred;">**SmartGit**</span> empfohlen. 

![](/git/images/smartgit_sshclient.png)

Anschließend werden wir nach dem bevorzugten Style der Oberfläche von <span style="color: darkred;">**SmartGit**</span> gefragt. Hier gibt es natürlich kein Richtig oder Falsch und es gibt auch nicht direkt eine Empfehlung für Anfänger:innen. Die Ansicht des **Working Tree** wird von uns allerdings als intuitiver eingeschätzt und deshalb verwendet. Wie im Fenster beschrieben, kann diese Einstellung später auch unter *Präferenz* geändert werden (und wir zeigen auch den Weg zur Änderung). 

![](/git/images/smartgit_style.png)

Unter **Privacy** kann man bestimmen, in welchen Fällen Daten an die Ersteller:innen gesendet werden, die diese zur Verbesserung des Programmes nutzen wollen. Hier möchten wir keine Empfehlung aussprechen - man kann nach persönlicher Präferenz auswählen. Außerdem sucht <span style="color: darkred;">**SmartGit**</span> auf dem Rechner nach initialisierten Repositories und gibt in diesem Fenster die Anzahl an.

![](/git/images/smartgit_privacy.png)

Sobald ihr <span style="color: darkred;">**SmartGit**</span> installiert habt und das Programm öffnet, werdet ihr gefragt, ob ihr ein lokales Repository öffnen oder neu erstellen wollt, oder aber ob ihr ein bereits bestehendes `clonen` möchtet. Wenn bereits Repositories auf dem Rechner bestehen, werden diese hier unter *Reopen previously used repository* angezeigt. Diesen Punkt wählen wir daher auch aus. Dabei wollen wir natürlich an unserem Ordner Praktikum arbeiten.


![](/git/images/smartgit_welcome.png)


Jetzt ist die Installation abgeschlossen.


# Basics

Nach der erfolgreichen Installation von <span style="color: darkred;">**SmartGit**</span> und dem Erkennen unseres Praktikums-Ordner als Repository, stellt sich die Frage, wie wir auf <span style="color: darkred;">**SmartGit**</span> verschiedene Funktionalitäten nutzen können. Hierzu betrachten wir zunächst, wo wir unsere bereits erlernten <span style="color: darkred;">**Git**</span>-Befehle umsetzen können.

### Benutzeroberfläche

Zur Orientierung schauen wir uns natürlich die Oberfläche von <span style="color: darkred;">**SmartGit**</span> genauer an. Diese haben wir durch die Auswahl eines bestimmten Styles hergestellt.

![](/git/images/smartgit_style_workingtree.png)

In der oberen Zeile befinden sich zunächst Symbole mit bekannten Begriffen wie `pull` und `commit`. Diese Werkzeuge werden wir gleich brauchen. Auf der linken Seite sehen wir unsere Repositories - theoretisch können wir hier alle reinladen, an denen wir uns beteiligen. Wenn ihr dem Tutorial Stück für Stück bis hierhin gefolgt seid, sollte einmal das "dummy"- und das "praktikum"-Repository hier erscheinen. Darunter sehen wir die verschiedenen **Branches** eines Projekts - mit diesen beschäftigen wir uns erst im nächsten Teil des Tutorials. 

In der Mitte des Bildschirms sehen wir die Kachel **Files**. Hierin werden alle Dateien angezeigt, die entweder noch nicht getracked werden, verändert, gelöscht oder umbenannt wurden. Für Praktikum ist hier die <span style="color: darkred;">**R**</span>-History zu sehen, die <span style="color: darkred;">**R**</span> automatisch erstellt, aber für uns keinen Wert hat. Diese ist im normalen Explorer und Terminal versteckt, wird aber hier angezeigt.

In der Kachel **Changes** werden die Veränderungen an einer Datei angezeigt, wenn Sie unter **Files** ausgewählt ist. Das demonstrieren wir gleich noch einmal mit einem Screenshot. In der Kachel **Journal** sind alle `commits` der Historie aufgeführt. 

Um die Arbeit mit <span style="color: darkred;">**SmartGit**</span> zu simulieren, müssen wir natürlich wieder Änderungen an den Dateien vornehmen. Dafür öffnen wir das Datenauswertungsskript aus unserem Ordner und ergänzen darin beispielsweise eine Häufigkeitstabelle für den Gesamtscore. Wichtig ist, dass die Änderung auch gespeichert werden muss.

![](/git/images/Dummy_gitAuswertung_fifth.png)

Durch die Änderung der Datei erscheint diese nun in <span style="color: darkred;">**SmartGit**</span> in der Kachel **Files**. Dabei wird sie in rot angezeigt und es steht daneben, dass sie modifiziert wurde. Wenn wir nun einmal auf sie mit Linksklick draufgehen, sehen wir auch nochmal besser, wofür die **Changes**-Kachel da ist. Durch die grüne Markierung der Zeilen 19 und 20 im Code sehen wir, dass diese neu hinzugefügt wurden.

![](/git/images/smartgit_files_changes.png)

### `Commit`

Nun, da wir eine Datei verändert haben, wollen wir diese Änderung natürlich auch committen. Im Terminal mussten wir dafür erst mit *git add* etwas zum **staging environment** hinzufügen. Das ist über <span style="color: darkred;">**SmartGit**</span> nicht mehr notwendig, bzw. wird durch Klick auf die interessierenden Dateien ersetzt. In der **Files**-Kachel wählen wir mit einem Linksklick alle Dateien aus, die im nächsten `commit` enthalten sein sollen (bei der Auswahl mehrere Dateien wie üblich *strg* gedrückt halten). Anschließend wählen wir in der Werkzeuge-Leiste `commit` aus. Es öffnet sich das `commit`-Fenster, in dem nochmal angezeigt wird, welche Dateien wir ausgewählt haben. Wir möchten nur die Änderung in der Datenauswertung in unserem `commit` haben. Weiterhin müssen wir, wie auch bei der Ausführung im Terminal, eine passende Message zu unserem `commit` hinzufügen.

![](/git/images/smartgit_commit.png)


Wenn die Nachricht verfasst ist, reicht ein Klick auf *Commit* und die Änderungen wurden angenommen. Lokal sind sie also getracked. Alternativ könnte man hier auch auf *Commit & Push* klicken, dann wird unser lokaler Ordner direkt auf <span style="color: darkred;">**GitHub**</span> gepushed. Dies kann man machen, wenn man sich seiner Änderungen sicher ist. Nur `commit` ist dabei empfehlenswert, wenn man sich unsicher ist und nochmal weiter an den Änderungen arbeiten will - oder für den Fall, dass wir noch weitere Änderungen an anderen Dateien unseres Projekts vornehmen wollen. Aus Demonstrationszwecken drücken wir auf *Commit*. Wenn ihr auf <span style="color: darkred;">**SmartGit**</span> die Kachel **Journal** betrachtet, ist dieser `commit` zwar im **master** enthalten, aber nicht im **origin**. Dies spricht dafür, dass die Änderung im **remote repository** noch angestoßen werden muss. Dies können wir mit einem `push` machen. 


### `Push` & `Pull`

Anstatt eine ganze Zeile in das Terminal eingeben zu müssen, um den Ordner auf <span style="color: darkred;">**GitHub**</span> auf den Stand des lokalen Ordners zu aktualisieren, reicht bei <span style="color: darkred;">**SmartGit**</span> ein einfacher Klick auf *Push*. Zunächst öffnet sich ein Fenster, in dem wir diese Aktion nochmals bestätigen. 

![](/git/images/smartgit_push.png)

Da wir <span style="color: darkred;">**SmartGit**</span> nun zum ersten Mal mit einem Server interagieren lassen, werden wir nach einem **Master Password** gefragt. Man kann dieses zwar auch überspringen, aber es ist wichtig für den Schutz von Passwörtern in der Interaktion mit Servern, weshalb wir eine Festlegung dringend empfehlen. Am besten verwendet ihr hier auch nicht das gleiche Passwort, welches ihr bei <span style="color: darkred;">**GitHub**</span> verwendet habt. 

![](/git/images/smartgit_master_password.png)

Einmal muss die Rechtmäßigkeit des Zugriffs auf den Server nun aber mit euren <span style="color: darkred;">**GitHub**</span>-Informationen bestätigt werden. Hier gibt es nun zwei Möglichkeiten.
Entweder ihr generiert einen Personal Access Token (PAT), wie man das machen kann, haben wir euch schon im Tutorial zu [GitHub](/extras/git/github/#personalaccesstoken) gezeigt. Das ist vor allem praktisch, wenn ihr die Verbindung zu <span style="color: darkred;">**GitHub**</span> an unterschiedlichen Geräten benutzt. Oder ihr generiert einen Application Programming Interface (API) Token, der mehr Sinn macht, wenn ihr mehrere Provider habt wie <span style="color: darkred;">**GitHub**</span>, von denen ihr aus <span style="color: darkred;">**SmartGit**</span> aus zugreifen wollt.  

<details><summary>Application Programming Interface</summary>

Damit wir nicht jedes Mal unseren PAT eingeben müssen, aktivieren wir den Zugang über das **Master Password**. Dafür wählen wir in der obersten Zeile *Edit* aus und wählen darin *Preferences* aus.

![](/git/images/smartgit_preferences.png)

Hier gehen wir in der Auswahl auf *Hosting Providers* und drücken dann rechts auf *Add*.

![](/git/images/smartgit_preferences_hosting.png) 

<span style="color: darkred;">**GitHub**</span> ist hier bereits auswählt. Wir wollen nun einen **Token** erstellen. Dafür müssen wir den Button *Generate* drücken. Der Browser sollte sich automatisch öffnen und einen Login zu <span style="color: darkred;">**GitHub**</span> erfordern. Sobald wir diese Informationen eingegeben haben, wird ein Token generiert. Diesen kopieren wir dann in das entsprechende Fenster in <span style="color: darkred;">**SmartGit**</span> und klicken auf *Authenticate*.

![](/git/images/smartgit_preferences_API.png)

Wir gelangen zurück in das Fenster, wo wir den Token erstellt haben, und klicken auf *Add*. Damit erscheint nun im Fenster der Hosting Providers unser <span style="color: darkred;">**GitHub**</span>-Account und wir können auf *OK* klicken. 

![](/git/images/smartgit_preferences_hosting_two.png)

</details>

Wir gehen hier davon aus, dass ihr direkt mit dem PAT als Passwort weitermacht. Danach fragt euch <span style="color: darkred;">**SmartGit**</span> nochmal nach eurem **Master Password**, das ihr etwas weiter oben festgelegt habt. 

![](/git/images/smartgit_MasterPassword.png)

Nach dessen Eingabe wird der `push` durchgeführt. Um einen optischen Indikator dafür zu haben, könnt ihr euer Repository auf der <span style="color: darkred;">**GitHub**</span>-Website öffnen. Weiterhin sind man auch in der Kachel **Journal**, dass **_origin_** und **_main_** nun wieder auf derselben Höhe des neuen `commits` sind.

Beachtet, dass der Vorgang von `push` wirklich simpel über den Klick funktioniert hat. Die Umstellungen für das "Passwort" mussten wir jetzt nur einmal vornehmen. Ähnlich einfach ist der Vorgang, um unsere lokale Kopie des Repositories auf die Version auf <span style="color: darkred;">**GitHub**</span> zu aktualisieren. Auch hier können wir den Button in der Werkzeug-Leiste nutzen. Nach dem Klick auf *Pull* geht ein Fenster auf, indem man zwischen `Rebase` und `Merge` wählen kann - diese Begriffe sind beide noch unbekannt und wir bleiben bei der Standardeinstellung. Anschließend erscheint das Fenster *Pull*. Hierin wird die URL vom <span style="color: darkred;">**GitHub**</span>- Repository angezeigt - diese müsste stimmen, könnt ihr aber gerne kontrollieren. Anschließend klicken wir auf den uns bekannten Befehl `pull`.

![](/git/images/smartgit_pull.png)

Es erscheint für eine kurze Zeit ein grüner Kasten, in dem steht, dass der `pull` erfolgreich war. Natürlich wurden gerade aber keine Änderungen an Dateien oder Ähnliches vorgenommen, da der Stand lokal und remote identisch war. Wir simulieren die Änderung einer anderen Person an einer Datei - wie im letzten Tutorial auch - durch eine Veränderung in der <span style="color: darkred;">**GitHub**</span> Version. Dafür öffnen wir das Repository auf <span style="color: darkred;">**GitHub**</span> und klicken auf den Stift, der rechts in der Zeile von **README.md** angezeigt wird. 

Wir wollen eine schnelle Änderung an diesem vornehmen und fügen daher noch eine Zeile ein, in der wir präzisieren, um welche Gruppe es sich bei uns imaginär handelt. In der `commit`-Nachricht beschreiben wir kurz die durchgeführte Änderung und lassen die anderen Optionen auf ihren Standardeinstellungen. Anschließend klicken wir *Commit Changes* und wechseln zurück auf unsere <span style="color: darkred;">**SmartGit**</span>- Anwendung. 

![](/git/images/smartgit_github_change.png)

In dieser wählen wir jetzt wieder *Pull* in unserem Repository "Praktikum" aus. Zunächst scheint nicht viel anderes zu passieren als bei dem vorherigen `pull`. Wenn man allerdings genau hinschaut, sieht man, dass der letzte `commit` nun am unteren Bildschirmrand im **Journal** angezeigt wird. Wenn man die Datei **README.md** lokal auf dem eigenen Rechner anschaut, werden die neuen Inhalte nun auch angezeigt. 

![](/git/images/smartgit_pull_change.png)

Bisher haben wir nur mit dem Repository gearbeitet, das automatisch von <span style="color: darkred;">**SmartGit**</span> gefunden wurde. Nun wollen wir noch Fälle betrachten, in dem das Repository nur online besteht oder in dem es noch komplett neu erstellt werden muss.

#### Bereits bestehendes <span style="color: darkred;">**GitHub**</span>-repository mit <span style="color: darkred;">**SmartGit**</span> `clonen`

Wie in den <span style="color: darkred;">**Git**</span>-Funktionen gelernt, kann man ein Repository, das online existiert, auch mit <span style="color: darkred;">**SmartGit**</span> lokal intialisieren. Um euren auf <span style="color: darkred;">**GitHub**</span> geladenen Praktikums-Ordner mit <span style="color: darkred;">**SmartGit**</span> zu verknüpfen, müsst ihr zunächst in der Menüleiste auf *Repository* klicken und dann auf *Clone*. In dem Fenster, was sich daraufhin öffnet, könnt ihr einfach die URL eures Repositories (die ihr über <span style="color: darkred;">**GitHub**</span> anfordern könnt) in das entsprechende Feld kopieren. Die hier angegebene URL und das Repository "test12" sind nur ein Platzhalter, um euch die nächsten Felder zeigen zu können. Wir haben momentan kein Repository, das nur online und nicht lokal angelegt ist. Die Eingabe muss natürlich noch bestätigt werden. 


![](/git/images/smartgit_clone_url.png)

Beachtet an dieser Stelle, dass es auch möglich ist, ein lokales Repository nochmal lokal zu `clonen`. Ihr hättet dieses dann zwei Mal. Hierfür müsste man *local repository* auswählen und den Pfad dahin angeben. Dieses Vorgehen hat jedoch nicht viele Anwendungen und wird daher nicht genauer betrachtet. 

Zurück zur Verbindung mit einem Repository auf <span style="color: darkred;">**GitHub**</span>: Nach der Eingabe der URL erscheint ein Dialogfenster, in dem Details über den `clone` abgefragt werden. Diese sind vor allem interessant, wenn mehrere `Branches` in einem Repository existieren, womit wir uns noch nicht beschäftigt haben. Außerdem können größere Daten ausgeschlossen werden, um Speicherplatz zu sparen. Dies trifft uns auch eher selten.

![](/git/images/smartgit_clone_selection.png)

Nach der Bestätigung der Details könnt ihr einen Ordner auswählen, in den eure Daten von <span style="color: darkred;">**GitHub**</span> geladen werden sollen. Ihr könnt die Standardeinstellung verwenden oder über die Ordneransicht einen Ordner auf eurem Rechner erstellen. 

![](/git/images/smartgit_clone_place.png)

Nachdem das Cloning abgeschlossen ist, solltet ihr auf der linken Seite eurer <span style="color: darkred;">**SmartGit**</span>-Ansicht den Ordner unter **Repositories** sehen können. Jetzt könntet ihr über <span style="color: darkred;">**SmartGit**</span> mit <span style="color: darkred;">**GitHub**</span> kommunizieren und  Änderungen an den Dateien tracken. Da wir diese Funktionen jetzt nur mal betrachtet und nicht ausgeführt haben, ändert sich in unserer Ansicht natürlich nichts. 

#### Neues `repository` erstellen

Ein neues Repository mit <span style="color: darkred;">**SmartGit**</span> zu erstellen, ist sehr einfach! Dazu müsst ihr in der Menüleiste zunächst auf *Repository* klicken und dann auf *Add or create...*. In dem Fenster, was sich jetzt öffnet, könnt ihr entweder einen Ordner auswählen, den ihr bereits erstellt habt - beispielsweise unseren bekannten Praktikums-Ordner - oder über *Neuer Ordner* einen neuen erstellen. Das Einladen eines bereits existierenden Repositorys kann nötig sein, falls die automatische Erkennung fehlgeschlagen ist oder ihr das Hinzufügen zunächst abgelehnt habt. Dafür würdet ihr einfach den Pfad des Repositorys hier einstellen, was wir jetzt aber nicht betrachten werden. 

![](/git/images/smartgit_create_rep.png)

In diesem Beispiel erstellen wir in unserem Statistik-Ordner den neuen Ordner "dummy2" und initialisieren diesen als neues Repository. Hierfür wird nochmal eine Bestätigung in einem seperaten Dialogfenster benötigt.

![](/git/images/smartgit_create_init.png)

Kleine Anmerkung: Diese Initialiserung würde natürlich nicht erscheinen, wenn ihr der Ordner bereits ein <span style="color: darkred;">**Git**</span>-Ordner wäre und nur zur Anzeige in <span style="color: darkred;">**SmartGit**</span> eingeladen werden sollte. 

Nach einem Klick auf *OK* ist euer Repository erstellt und ihr könnt mit nun Dateien erstellen, hinzufügen und mit euren Veränderungen loslegen! Es wird nun auf der linken Seite in der Liste angezeigt. Das Tracking der Dateien wäre momentan natürlich nur lokal. Um eine Verbindung mit <span style="color: darkred;">**GitHub**</span> zu erstellen, muss zunächst äquivalent zu der Beschreibung im Tutorial zu <span style="color: darkred;">**GitHub**</span> ein Repository erstellt werden. Dort wurde bereits empfohlen, dass das neu erstellte Repository zunächst leer ist und denselben Namen wie die lokale Version trägt. Es wird dabei eine URL kreiert, unter der das `repository` zu finden ist. In diesem Fall würde diese so aussehen:

![](/git/images/smartgit_github_url.png)

Diese solltet ihr nun kopieren und wieder zurück auf <span style="color: darkred;">**SmartGit**</span> wechseln. Dort wählt ihr in der Übersichtsleiste zunächst *Remote* und dann *Add...*. Es erscheint eine Eingabe für die URL, die ihr eben kopiert habt.  

![](/git/images/smartgit_add_remote.png)

Um die Einrichtung abzuschließen, müsst ihr nun noch einen `push` durchführen. Nachdem dieser abgeschlossen ist, sollte das Repository auch auf <span style="color: darkred;">**GitHub**</span> den **initial commit** anzeigen. Ab diesem Moment werden alle euren lokalen Änderungen durch einen `Push` auf <span style="color: darkred;">**GitHub**</span> abgelegt. 

![](/git/images/smartgit_github_pushing.png)


#### Änderung des Styles der Oberfläche

Bei der Einrichtung von <span style="color: darkred;">**SmartGit**</span> haben wir uns für einen Style in der Anzeige unserer Repositories entschieden. Zum Abschluss der Basics des Tutorials wollen wir nun noch kurz betrachten, wie wir diese anfängliche Entscheidung ändern können. Dafür wählt ihr in der obersten Zeile zunächst *Edit* und dann *Preferences*. Es öffnet sich ein Fenster, indem wir zunächst *User Interface* in der Übersicht links anklicken. Im rechten Fenster gibt es die Auswahl *Prefer*, bei der momentan **Working Tree** angewählt sein sollte. Stattdessen klicken wir nun auf *Log Graph* und bestätigen die Auswahl (es können natürlich noch weitere Änderungen an der Oberfläche hier durchgeführt werden, aber diese werden wir nicht näher betrachten).

![](/git/images/smartgit_preferences_loggraph.png)

Beim Erstellen des Tutorials musste <span style="color: darkred;">**SmartGit**</span> nun einmal geschlossen und wieder geöffnet werden, damit die Änderungen sichtbar werden. Es ist eine neue Aufteilung in der Oberfläche zu sehen, wobei die Anzeige der *Repositories* und *Branches* auf der linken Seite bestehen bleibt. 

![](/git/images/smartgit_loggraph.png)

Im zentralen Fenster **Graph** wird der Workflow - also alle `commits`, die jemals an unserem Projekt durchgeführt wurden - angezeigt. Dabei stehen jeweils die Initialien der Person, die den `commit` durchgeführt hat sowie das Änderungsdatum. So können wir auf einen Blick nachvollziehen, wer wann was an unserem Projekt verändert hat. Beachtet auch, dass nun ganz oben der aktuelle Stand eures Repositorys als **Working Tree** angezeigt wird. In diesem wird eine Änderung angezeigt, da die Datei ".Rhistory" weiterhin im Repository existiert, aber noch nicht in einen `commit` einbezogen wurde.

Auf der rechten Seite des Bildschirms sehen wir mittig eine Übersicht über alle unsere Dateien, die wir seit dem letzten `commit` lokal verändert haben - in diesem Falle die `.Rhistory`. Oben rechts werden Informationen über den Account angegeben, der einen `commit` durchgeführt hat. Am unteren Bildschirmrand ist wieder die Übersicht über Änderungen in Dateien von einem `commit` zu einem anderen. Wem diese Übersicht nun besser gefällt, kann die Einstellung so lassen. Für das weitere Tutorial ändern wir die Einstellung wieder in den **Preferences** und starten <span style="color: darkred;">**SmartGit**</span> wieder neu. 

# Fazit und Ausblick

<span style="color: darkred;">**SmartGit**</span> erleichtert die Arbeit mit <span style="color: darkred;">**Git**</span> enorm und bietet eine gut ausgearbeitete Benutzeroberfläche. Wir haben einige weitere Befehle kennengelernt, mit denen wir einen guten Arbeitsablauf an gemeinsamen Projekten ermöglichen können. Jedoch bietet <span style="color: darkred;">**Git**</span> noch viele weitere Optionen, die in weiteren Tutorials besprochen werden.





