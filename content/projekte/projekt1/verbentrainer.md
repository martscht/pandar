---
title: Verbentrainer
type: post
date: '2022-07-24T23:00:00'
slug: verbentrainer
categories: ["Projekte"]
tags: ["Projekt1"]
subtitle: ''
summary: 'In diesem Projekt lernen wir, wie man einen Verbentrainer erstellen kann. Wir erstellen dafür einerseits eine Liste unkonjugierter Verben, sowie die Konjugationsformen, und kombinieren diese zufällig. So kann das konjugieren durch das Aufrufen zufälliger Listeneinträge geübt werden. Dies wird an einem spanischen Beispiel illustriert.'
authors: [rouchi]
weight: 1
lastmod: '2024-05-15'
featured: no
banner:
  image: "/header/architecture_valencia.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/de/photo/674624)"
projects: []
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /projekte/projekt1/verbentrainer
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /projekte/projekt1/verbentrainer.R 
output:
  html_document:
    keep_md: true
---



# Übersicht

Wer bereits versucht hat, eine Fremdsprache zu lernen, weiß, dass neben dem Vokabular und der generellen Grammatik vor allem die Verben eine große Rolle spielen. In vielen Sprachen werden Verben je nach Verwendung an eine bestimmte Person angeglichen und es gibt sie ebenfalls in den verschiedensten Zeitformen der Vergangenheit, Gegenwart und Zukunft. Es kann also eine Herausforderung darstellen, ein bestimmtes Verb in jedem möglichen Tempus für jede Person auswendig zu lernen. Glücklicherweise werden die Verben in vielen Sprachen nach gewissen Regeln konjugiert, sodass man meistens nur die Verbendungen für die jeweilige Person und das Tempus kennen muss, was das ganze schon überschaubarer macht.

Da das Auswendiglernen der Vielzahl von Verbformen sehr umständlich und eher ungewöhnlich ist, können mithilfe des Wortstammes und der relevanten Endungen die korrekten Formen gebildet werden. Um das zu trainieren, müsste jedes Verb in jedem Tempus für jede Person konjugiert werden, damit die Regeln Anwendung finden und somit verinnerlicht werden können. Doch wäre es nicht viel praktischer, eine Art Verbentrainer zu haben, mithilfe dessen man nicht mühsam alle Verben Stück für Stück durchgehen müsste, sondern ein Programm hat, dass zufällige Verben ausgibt, welche in einem bestimmten Tempus konjugiert werden müssten?

In diesem Projekt soll es darum gehen, solch ein Programm zu entwerfen, dass das Konjugieren trainieren und somit erleichtern soll.

Wir wollen uns hierbei auf die Sprache [Spanisch](https://de.wikipedia.org/wiki/Spanische_Sprache) fokussieren. Spanisch ist eine iberoromanische Sprache und nimmt den vierten Platz der meistgesprochenen Sprachen auf der Welt ein - nach Englisch, Mandarin und Hindi. Im Spanischen werden [Verben](https://de.wikipedia.org/wiki/Spanische_Grammatik#Verb) nach Person, Numerus, Aspekt, Aktionsart, Tempus und Modus konjugiert - ganz schön viel zu beachten also. In der Regel weisen sie eine der folgenden Verbendungen auf: *-ar*, *-ir* und *-er*. Es gibt auch reflexive Verben, die ein *-se* an ihrem Infinitiv angehängt haben, welches die Reflexivität des Verben aufzeigen soll (Beispiel: llevar*se* (mitnehmen)).

Die weiteren Einzelheiten werden wir im Laufe des Projekts nach und nach kennenlernen. Ziel soll es sein, bei einem ganz grundlegenden Verbentrainer in `R` zu beginnen und diesen dann Stück für Stück zu erweitern und anhand dessen verschiedene grundlegende Funktionen von `R` kennenzulernen. Die folgenden Abschnitte gehen die verschiedenen Stufen des Trainers der Reihe nach durch. Jeder Abschnitt ist unterteilt in eine **Aufgabenstellung**, ein paar **Tipps**, die weiterhelfen sollen, wenn dir die Ideen ausgehen, und eine mögliche **Lösung** für die Umsetzung der Aufgabenstellung. Super wäre es natürlich, wenn du so viel wie möglich alleine schaffst. Falls du jedoch nicht weiterkommen solltest, kannst du jederzeit im Internet nachschauen, dort gibt es die besten Hilfestellungen (beispielsweise auf Seiten wie [stackoverflow.com](https://stackoverflow.com/)). Auch wir müssen oftmals im Internet nach dem richtigen Code suchen. Falls du noch nichts oder nur sehr wenig mit `R` zu tun haben solltest (oder wenn du dich unsicher fühlst), kannst du jederzeit auf den pandaR-Seiten zur [Lehre](/lehre/main) vorbeischauen. Dort gibt es neben vielen statistischen Themen auch ein übersichtliches [R-Intro](/lehre/statistik-i/crash-kurs/), welches dich in die Welt von `R` einführt.

Viel Spaß beim Programmieren!

# Aufgaben

## Aufgabe 1: Grundgerüst des Verbentrainers

Im ersten Teil des Projekts wollen wir mit dem ganz grundlegenden Gerüst des Verbentrainers beginnen. Dazu brauchen wir noch ein paar Informationen zur Konjugation von Verben. Im Spanischen gibt es vom Prinzip her die gleichen Personen wie im Deutschen:

| Person              | Deutsch     | Spanisch              |
|---------------------|-------------|-----------------------|
| 1\. Person Singular | ich         | yo                    |
| 2\. Person Singular | du          | tú                    |
| 3\. Person Singular | er, sie, es | él, ella, usted       |
| 1\. Person Plural   | wir         | nosotros, nosotras    |
| 2\. Person Plural   | ihr         | vosotros, vosotras    |
| 3\. Person Plural   | sie         | ellos, ellas, ustedes |

Hierbei stellen *usted* und *ustedes* die jeweilige Höflichkeitsform in Singular und Plural dar. Für *wir*, *ihr* und *sie* wird je nach Geschlecht zwischen *nosotros*/*vosotros* (sobald mindestens eine männlich gelesene Person gemeint ist) und *nosotras*/*vosotras* (ausschließlich weiblich gelesene Personen) unterschieden. Ähnlich wie im Deutschen kann auch hier gegendert werden, weshalb wir zur Vereinfachung und der Übersichtlichkeit halber im folgenden *nosotres*, *vosotres* und *elles* verwenden werden (Typischerweise würde man statt dem *e* ein `@`-Symbol verwenden, doch das ist für `R` etwas irreführend). Die Höflichkeitsformen *usted* und *ustedes* lassen wir ebenfalls außenvor, wenn ihr diese aber mit dabei haben möchtet, könnt ihr dies in eurer persönlichen Version des Trainers natürlich berücksichtigen.

Jetzt müssen wir uns Gedanken über die Verben machen, die wir verwenden möchten. Im Internet kann man viele Übersichten finden, in denen die meistverwendetsten spanischen Verben aufgeführt sind. Ein offizielles Ranking gibt es zwar nicht, doch ähneln sich diese Verben meist auf den verschiedenen Seiten. Für unsere Zwecke verwenden wir [diese Seite](https://www.idiomax.com/es/spanish-verb-list.aspx), um eine überschaubare Anzahl der wichtigsten Verben zu haben. Hierbei sind sowohl regelmäßige als auch unregelmäßige Verben vorhanden.

Im ersten Teil des Projekts fokussieren wir uns zunächst ausschließlich auf das Präsens, um genauer zu sein auf das *Presente Indicativo* im Spanischen.

**Aufgabenstellung**: Erstelle ein Grundgerüst für den Verbentrainer. Bedenke dabei, dass wir jedem Verb *zufällig* eine Person zuordnen wollen, für die wir das Verb anschließend konjugieren wollen.

Falls du von alleine nicht weiterkommen solltest, kannst du dir die folgenden **Tipps** anschauen:


<details><summary>Struktur in <code>R</code></summary>

Zunächst sollten wir über die Struktur des Trainers in `R` nachdenken. (Meines Wissens nach) gibt es keine konkrete Funktion, die wir dafür verwenden können, sondern wir müssen uns eine Struktur überlegen, auf die wir bereits vorhandene Befehle anwenden können. Eine Form, die sich hierfür besonders anbietet, ist die allseits beliebte **Tabelle**. Es gibt sie in den verschiedensten Layouts, sie ist leicht zu erstellen und man kann viel an ihr rumarbeiten. Probiere also, dir eine Tabelle zu überlegen, in der man Personen zu Verben zuordnen kann.

</details>


<details><summary>Verbliste</summary>

Vielleicht hast du ja schon erkannt, dass du zwei Vektoren anlegen musst, um deine Tabelle zu erstellen; eine für die Personen und eine für die Verben. Da es viel Arbeit ist, die Verben von der [Internetseite](https://www.idiomax.com/es/spanish-verb-list.aspx) Stück für Stück zu kopieren, habe ich diese Arbeit übernommen, sodass du einfach den folgenden Code kopieren kannst:


```r
verben <- c("abrir", "acabar", "acercar", "aconsejar", "acordar", "amar", "andar", "apoyar", "aprender", "armar", "asesinar", "atacar", "ayudar", "bailar", "bajar", "bastar", "bañar", "beber", "buscar", "caer", "callar", "calmar", "cambiar", "caminar", "campar", "cantar", "cazar", "cenar", "centrar", "cercar", "cerrar", "citar", "cocinar", "coger", "comenzar", "comer", "comparar", "comprar", "conducir", "conocer", "conseguir", "contar", "continuar", "correr", "cortar", "coser", "costar", "crear", "creer", "cuidar", "culpar", "dar", "dañar", "deber", "decidir", "decir", "dejar", "descansar", "describir", "desear", "destruir", "disculpar", "divertir", "doler", "dormir", "durar", "elegir", "empezar", "empujar", "encantar", "encontrar", "enseñar", "entender", "entrar", "equipar", "esconder", "escribir", "escuchar", "esperar", "esposar", "estar", "estudiar", "existir", "explicar", "extrañar", "faltar", "forzar", "funcionar", "ganar", "gritar", "gustar", "haber", "hablar", "hacer", "importar", "intentar", "ir", "jugar", "jurar", "lamentar", "lanzar", "largar", "lavar", "leer", "limpiar", "llamar", "llegar", "llenar", "llevar", "llorar", "luchar", "mandar", "matar", "mejor", "mejorar", "mentir", "mirar", "morir", "mostrar", "mover", "necesitar", "negociar", "nombrar", "ocurrir", "odiar", "ofrecer", "olvidar", "orar", "oír", "pagar", "parar", "parecer", "partir", "pasar", "pelar", "pelear", "peligrar", "penar", "pensar", "perder", "perdonar", "permitir", "pisar", "poder", "poner", "preferir", "preguntar", "preocupar", "preparar", "probar", "prometer", "pulsar", "quedar", "quemar", "querer", "recibir", "reconocer", "recordar", "regalar", "regresar", "repetir", "responder", "reír", "saber", "sacar", "salir", "saltar", "salvar", "seguir", "sentar", "sentir", "ser", "significar", "sonar", "sonreír", "soñar", "suceder", "suponer", "tardar", "temer", "tener", "terminar", "tirar", "tocar", "tomar", "trabajar", "traer", "tratar", "usar", "valer", "vender", "venir", "ver", "viajar", "visitar", "vivir", "volver")
```

</details>


<details><summary>Erstellen der Tabelle</summary>

Falls du Probleme damit haben solltest, wie genau du eine Tabelle erstellen kannst, sollte dir dieser Tipp weiterhelfen. Eine Tabelle ist aufgebaut in verschiede Spalten, die jeweils verschiedene Werte beinhalten. Das ist genauso bei Wörtern möglich. Die Verbliste, die du idealerweise schon als Vektor in deinem Environment in `R` geladen haben solltest, bildet die Grundlage dieser Tabelle. Überlege dir nun, welche weitere(n) Spalte(n) du für diese Aufgabenstellung benötigst.

Die Schwierigkeit besteht hierbei darin, dass sich die Werte der anderen Spalte von der Anzahl her an die Verbliste anpassen müssen. Wir möchten eine **zufällige** Zuordnung der Werte haben. Dazu könntest du dir über die Hilfefunktion von `R` den `sample`-Befehl genauer anschauen.

</details>

Wenn du die Aufgabenstellung des ersten Teils bereits abgeschlossen haben solltest - mit und ohne Tipps -, kannst du nun dein Ergebnis mit der Lösung vergleichen. Natürlich gibt es in `R` in den meisten Fällen viele verschiedene Möglichkeiten, das gleiche Ergebnis zu erhalten. In diesem Fall ist der Weg jedoch nicht unbedingt das Ziel, denn uns geht es hauptsächlich darum, unsere Aufgabenstellung zu lösen - egal, wie wir das erreichen.

<details><summary>Lösung</summary>

Das Grundgerüst für unseren Trainer zu bauen, dürfte gar nicht mal so schwer gewesen sein. Im Prinzip solltest du erkannt haben, dass wir eine Tabelle erstellen möchten, in der wir in einer Spalte unsere Verben haben und in der anderen die Person, die dem Verb zugeordnet wird. Hierfür soll die Person **zufällig** dem Verb zugeordnet werden. Wir möchten also in jeder Zeile ein Verb und eine zufällig gewählte Person stehen haben.

Um die Tabelle zu erstellen, müssen wir zunächst die einzelnen Spalten als Vektoren erstellen und diese dann zu einer Tabelle zusammenfügen.

Die Verbliste stellt einen Vektor dar, der aus den Verben der Internetseite besteht:


```r
verben <- c("abrir", "acabar", "acercar", "aconsejar", "acordar", "amar", "andar", "apoyar", "aprender", "armar", "asesinar", "atacar", "ayudar", "bailar", "bajar", "bastar", "bañar", "beber", "buscar", "caer", "callar", "calmar", "cambiar", "caminar", "campar", "cantar", "cazar", "cenar", "centrar", "cercar", "cerrar", "citar", "cocinar", "coger", "comenzar", "comer", "comparar", "comprar", "conducir", "conocer", "conseguir", "contar", "continuar", "correr", "cortar", "coser", "costar", "crear", "creer", "cuidar", "culpar", "dar", "dañar", "deber", "decidir", "decir", "dejar", "descansar", "describir", "desear", "destruir", "disculpar", "divertir", "doler", "dormir", "durar", "elegir", "empezar", "empujar", "encantar", "encontrar", "enseñar", "entender", "entrar", "equipar", "esconder", "escribir", "escuchar", "esperar", "esposar", "estar", "estudiar", "existir", "explicar", "extrañar", "faltar", "forzar", "funcionar", "ganar", "gritar", "gustar", "haber", "hablar", "hacer", "importar", "intentar", "ir", "jugar", "jurar", "lamentar", "lanzar", "largar", "lavar", "leer", "limpiar", "llamar", "llegar", "llenar", "llevar", "llorar", "luchar", "mandar", "matar", "mejor", "mejorar", "mentir", "mirar", "morir", "mostrar", "mover", "necesitar", "negociar", "nombrar", "ocurrir", "odiar", "ofrecer", "olvidar", "orar", "oír", "pagar", "parar", "parecer", "partir", "pasar", "pelar", "pelear", "peligrar", "penar", "pensar", "perder", "perdonar", "permitir", "pisar", "poder", "poner", "preferir", "preguntar", "preocupar", "preparar", "probar", "prometer", "pulsar", "quedar", "quemar", "querer", "recibir", "reconocer", "recordar", "regalar", "regresar", "repetir", "responder", "reír", "saber", "sacar", "salir", "saltar", "salvar", "seguir", "sentar", "sentir", "ser", "significar", "sonar", "sonreír", "soñar", "suceder", "suponer", "tardar", "temer", "tener", "terminar", "tirar", "tocar", "tomar", "trabajar", "traer", "tratar", "usar", "valer", "vender", "venir", "ver", "viajar", "visitar", "vivir", "volver")
```

Für die Spalte der Personen müssen wir einen weiteren Vektor anlegen:


```r
person <- c("yo", "tú", "él/ella", "nosotres", "vosotres", "elles")
```

Wenn wir jetzt die Tabelle mit dem `data.frame`-Befehl aus den beiden Vektoren zusammenbauen wöllten, stoßen wir auf folgende Fehlermeldung:


```r
Tabelle <- data.frame(verben, person)
```


```
## Error in data.frame(verben, person): arguments imply differing number of rows: 197, 6
```

Zum einen haben wir 197 Verben in unserer Liste, doch nur 6 Personen. Dies würde keine anständige Tabelle ergeben. Außerdem wollen wir eine zufällige Zuordnung der Personen zu den Verben, wobei sich diese wiederholen sollen. Wir müssen also eine andere Funktion verwenden, welche diese beiden Aspekte berücksichtigt:


```r
Tabelle <- data.frame(verben)
```


```r
Tabelle$person <- print(sample(person, 197, replace = T))
```



Wir verwenden den `sample`-Befehl, in dem wir unseren Vektor "person" spezifizieren, dann angeben, wie oft aus unserem Vektor ein zufälliger Wert gezogen soll - in diesem Fall so oft wie wir Verben in der Liste stehen haben - und zuletzt legen wir fest, dass wir "mit Zurücklegen" ziehen, denn bei nur 6 Personen auf 197 Verben müssen sich einige einige Male wiederholen.

Somit haben wir eine Tabelle erstellt, in der wir in der ersten Spalte unsere Verben haben und in der zweiten unsere zufällig zugeordneten Personen. Ein Beispiel dafür könnte wie folgt aussehen:


```r
head(Tabelle)
```

```
##      verben   person
## 1     abrir       tú
## 2    acabar vosotres
## 3   acercar  él/ella
## 4 aconsejar vosotres
## 5   acordar vosotres
## 6      amar nosotres
```

</details>

Jetzt wo wir unsere Tabelle erstellt haben, die das Grundgerüst unseres Verbentrainers darstellt, könnten wir loslegen und die 197 Verben für die ihnen zufällig zugeordnete Person im *Presente Indicativo* durchkonjugieren.

## Aufgabe 2: Erweiterung um die weiteren Zeitformen

Im ersten Teil dieses Projekts haben wir das Grundgerüst für unseren Verbentrainer geschaffen. Wir haben nun eine Tabelle, in der die Personen "auf Knopfdruck" per Zufall den verschiedenen Verben zugeordnet werden können. Es wäre schön, wenn unsere Arbeit somit getan wäre und wir recht schnell die spanischen Verben beherrschen würden. Nun gibt es im Spanischen jedoch mehr Zeitformen als nur das *Presente Indicativo*...genauer genommen gibt es sogar drei Modi, die jeweils ihre eigenen Zeitformen haben. Grob gesagt könnte man sie beschreiben als einen reellen Modus (*Indicativo*), einen irreellen Modus (*Subjuntivo*) und den Befehlsmodus (*Imperativo*). Eine Übersicht über die drei Modi und ihre jeweiligen (wichtigsten) Zeitformen liefern [diese Internetseite](https://espanol.lingolia.com/de/grammatik) und folgende Tabelle:

| Modus      | Zeitform                   | Beispiel                |
|------------|----------------------------|-------------------------|
| Indicativo | Presente                   | Yo hablo.               |
| Indicativo | Pretérito perfecto         | Yo he hablado.          |
| Indicativo | Pretérito indefinido       | Yo hablé.               |
| Indicativo | Pretérito imperfecto       | Yo hablaba.             |
| Indicativo | Pretérito pluscuamperfecto | Yo había hablado.       |
| Indicativo | Preterito anterior         | Yo hube hablado.        |
| Indicativo | Futuro simple              | Yo hablaré.             |
| Indicativo | Futuro compuesto           | Yo habré hablado.       |
| Indicativo | Condicional simple         | Yo hablaría.            |
| Indicativo | Condicional compuesto      | Yo habría hablado.      |
| ---        | ---                        | ---                     |
| Subjuntivo | Presente subjuntivo        | Que yo hable.           |
| Subjuntivo | Pretérito imperfecto       | Que yo hablara.         |
| Subjuntivo | Pretérito perfecto         | Que yo haya hablado.    |
| Subjuntivo | Pretérito pluscuamperfecto | Que yo hubiera hablado. |
| ---        | ---                        | ---                     |
| Imperativo | *nur eine Form*            | ¡Habla!                 |

Nun wird das Ganze doch etwas komplizierter. Um es wenigstens etwas zu vereinfachen, beschränken wir uns auf die folgenden Zeitformen:

-   Presente (I)
-   Pretérito indefinido (I)
-   Pretérito imperfecto (I)
-   Futuro simple
-   Condicional simple
-   Presente (S)
-   Pretérito imperfecto (S)
-   Imperativo

Das (I) und (S) stehen hierbei entweder für *Indicativo* oder *Subjuntivo*. Die restlichen Zeitformen bestehen jeweils aus dem Hilfsverb *haber* und dem Partizip des Verbes. Sobald man *haber* in allen Zeitformen konjugieren kann, sind sie einfach zu kombinieren, sodass sie nicht explizit trainiert werden müssen.


**Aufgabenstellung**: Ergänze den Verbentrainer um die weiteren acht Zeitformen.

Falls du von alleine nicht weiterkommen solltest, kannst du dir die folgenden **Tipps** anschauen:

<details><summary>Inhaltliche Überlegung</summary>

Im Prinzip ist diese Aufgabe recht einfach, wenn du den ersten Teil bereits geschafft hast. Überlege dir genau, um was du deine Tabelle erweitern musst, um ebenfalls die Zeitformen zufällig den Verben zuzuordnen.

</details>


<details><summary><code>R</code>-Code</summary>

Der Code ähnelt sehr stark dem ersten Teil des Projekts. Schau dir genau die einzelnen Schritte der ersten Aufgabe an und überleg dir, wie du die Tabelle am Besten erweitern kannst.

</details>


Wenn du fertig mit der Bearbeitung der Aufgabenstellung sein solltest, kannst du dein Ergebnis jetzt mit der Lösung vergleichen. Wie auch beim ersten Teil (und eigentlich immer bei `R`) gilt, dass es mehrere Wege zum gleichen Ziel geben kann:


<details><summary>Lösung</summary>

Unsere Tabelle von Teil 1 müssen wir lediglich um eine weitere Spalte erweitern. Zunächst legen wir hierfür wieder einen Vektor mit unseren Werten - in diesem Fall den verschiedenen Zeitformen - an:


```r
tempus <- c("Presente (I)", "Pretérito indefinido (I)", "Pretérito imperfecto (I)", "Futuro simple", "Condicional simple", "Presente (S)", "Pretérito imperfecto (S)", "Imperativo")
```


Jetzt können wir unsere Tabelle ganz einfach (zumindest ist es ganz einfach, wenn man die Lösung von Teil 1 kennt) um diesen Vektor erweitern:


```r
Tabelle$tempus <- print(sample(tempus, 197, replace = T))
```



Wieder legen wir hiermit fest, dass aus unserem Vektor "tempus" 197 mal ein zufälliger Wert ausgewählt werden soll - wieder mit Zurücklegen, denn so viele Zeitformen gibt es im Spanischen dann doch auch wieder nicht.

Am Besten kombinieren wir die Befehle für die Zufallsziehung der Tabelle an dieser Stelle, damit wir sie immer zusammenstehen haben und wir beide gleichzeitig ausführen können, damit bei jedem neuen Run sowohl die Personen, als auch die Zeitformen durchgemischt werden:




```r
Tabelle$person <- print(sample(person, 197, replace = T))
Tabelle$tempus <- print(sample(zeit, 197, replace = T))
```

Wenn wir uns jetzt wieder unsere Tabelle ausgeben lassen, sehen wir, dass sie um die Spalte "Tempus" ergänzt wurde und die Personen erneut durchgemischt wurden:


```r
head(Tabelle)
```

```
##      verben   person                   tempus
## 1     abrir  él/ella Pretérito imperfecto (S)
## 2    acabar vosotres Pretérito imperfecto (I)
## 3   acercar       tú Pretérito indefinido (I)
## 4 aconsejar nosotres Pretérito indefinido (I)
## 5   acordar    elles             Presente (I)
## 6      amar       tú Pretérito indefinido (I)
```

Jetzt kann der Reihe nach jedes Verb für eine bestimmte Person in einer bestimmten Zeitform konjugiert werden.

</details>

<!-- ## Aufgabe 3: Erstellen eines HTMLs (mit Zufallsknopf) -->

<!-- -> kurze Einführung in RMarkdown, damit Tabelle als HTML abgespeichert werden kann -->

<!-- -> mit plotly einen Plot der Tabelle erstellen, damit es anschaulicher ist -->







***

Wie die verschiedenen Verben in den verschiedenen Zeitformen für die verschiedenen Personen nun konjugiert werden, ist nicht Teil dieses Projekts. Wer sich dafür interessiert, kann natürlich die eigenen Spanischfähigkeiten anhand dieses Trainers überprüfen, doch in erster Linie ging es uns darum, das Programm zu schreiben. Ihr könnt euch also entspannen, `R` ist die einzige Sprache, die wir hier lernen wollen. Falls ihr aber mal einen Sprachkurs belegen solltet oder eine Sprache lernen wollt, freut ihr euch bestimmt, diesen überaus praktischen Trainer zur Hand zu haben! Natürlich kann man unser Projekt auf jede andere Sprache übertragen, hierfür müssen lediglich die Verben und die Zeitformen angepasst werden.
