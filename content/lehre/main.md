---
type: landing
title: "Material aus der Lehre"
summary: "Hier findest du die vollständige Übersicht über alles, was wir auf dieser Seite an Lehrmaterial erstellt haben."

weight: 10
header.on_scroll: fixed
show_date: false

sections:
  - block: markdown
    id: header
    content:
      title: Material aus der Lehre
      subtitle:
      text: '<br><br><br><br>'
    design:
      background:
        image:
          filename: header/chalkboard_goethe.jpg
        text_color_light: true
      columns: 2
  - block: markdown
    id: statistik-i
    content:
      title: Statistik I
      subtitle: PsyBSc 2
      text: 
        In Statistik I geht es um die erste Einführung in die Statistik im Psychologiestudium. Dafür betrachten wir die Grundstruktur von R, Datenimport, einfache Grafiken, Deskriptivstatistiken, Verteilungsfunktionen und einige Tests.
        
        
        {{< category_list "statistik-i" 12>}}

        Die Umfrage aus der ersten Woche gibt es [hier](https://psybsc2.formr.org/). Die Daten, die dabei in der ersten Sitzung entstanden sind, können Sie [{{< icon name="download" pack="fas" >}}   hier im RDA Format](/daten/fb23.rda) und [{{< icon name="download" pack="fas" >}} hier im CSV Format](/daten/fb23.csv) herunterladen. Was welche Variablen in diesem Datensatz bedeutet, wird in der [{{< icon name="download" pack="fas" >}} Variablenübersicht](/lehre/statistik-i/variablen.pdf) erläutert.

    design:
      columns: 2
  - block: markdown
    id: statistik-ii
    content:
      title: Statistik II
      subtitle: PsyBSc 7
      text: 
        In Statistik II werden naheliegenderweise die Inhalte aus Statistik I vertieft. Behandelt werden u.a. Matrixalgebra, multiple Regression und Varianzanalysen. Außerdem gucken wir uns ein paar R-spezifische Dinge wie `ggplot2` oder das Schreiben eigener Funktionen an.
        
        
        {{< category_list "statistik-ii" 12 "">}}
    design:
      columns: 2

  - block: markdown
    id: multivariat
    content:
      title: Forschungsmethoden und Evaluation I & II
      subtitle: PsyMSc 1
      text: 
        Das Modul PsyMSc1 ist in zwei Teile untergliedert, Forschungsmethoden und Evaluation I und II. In F&E I geht es um multivariate Vorhersagemodelle, die als (multivariate) Erweiterung des Allgemeinen Linearen Modells angesehen werden können. Beispielsweise wird die Regressionsanalyse erweitert, um auch bestimmte Abhängigkeiten in den Daten modellieren zu können, sowie um auch dichotome abhängige Variablen vorhersagen zu können. Neben der multivariaten Erweiterung der Varianzanalyse (ANOVA) werden auch Datenvorbereitungsmaßnahmen vorgestellt, welche den/die Anwender/in beim Verstehen der Struktur in den Daten unterstützen sollen. Die inhaltlichen Sitzungen werden hierbei durch die Umsetzung in `R` unterstützt


        {{< category_list "fue-i" 4 "">}}

        Die zweite Hälfte des Moduls, F&E II, befasst sich vor allem mit Ansätzen zur Modellierung latenter Variablen und deren Beziehungen zueinander. Darunter fallen z.B. explorative und konfirmatorische Faktorenanalysen, die die Beziehung zwischen manifesten Variablen und den ihnen zugrundeliegenden latenten Variablen modellieren. Aber auch die Modellierung der Beziehung zwischen latenten psychologischen Konstrukten (Strukturgleichungsmodelle) und die Vergleiche von Modellen zwischen verschiedenen Gruppen, z.B. für interkulturelle Studien, ist Bestandteil dieses Semesters.


        {{< category_list "fue-ii" 5 "">}}
        **Zusatz**-Abschnitte sollen als Ergänzung für Interessierte dienen und einige angesprochene Aspekte vertiefen. Hier werden keine neuen R-Inhalte vermittelt.
    design:
      columns: 2

  - block: markdown
    id: klipps
    content:
      title: Vertiefung der Forschungs- methodik für Psychotherapeut*innen
      subtitle: KliPPsMSc5a
      text: 
        Das Modul KliPPsMSc5 ist in zwei Teile untergliedert. Im ersten Semester besuchen Sie ein Seminar, im zweiten Semester eine Vorlesung. Die hier bereitgestellten Inhalte beziehen sich auf die Seminare im ersten Semester - also den Teil 5a des Moduls. Dabei geht es in allen Seminaren um multivariate Vorhersagemodelle, die als (multivariate) Erweiterung des Allgemeinen Linearen Modells angesehen werden können. Beispielsweise wird die Regressionsanalyse erweitert, um auch bestimmte Abhängigkeiten in den Daten modellieren zu können. Weiterhin werden in jedem Seminar zwei von drei Ergänzungsmodulen behandelt - diese werden von Dozierenden zu Beginn des Semesters vorgestellt. Die inhaltlichen Teile in den Seminaren werden durch die Umsetzung in R unterstützt, die hier jeweils in einem Tutorial vorgestellt wird.
        
        
        {{< category_list "klipps" 12 "I,I,II,II,II,III,IV,IV,Va,Va,Vb,Vb">}}
    design:
      columns: 2
      
      
  - block: markdown
    id: add-ons
    content:
      title: Weitere Lehrinhalte
      subtitle: 
      text:
        <h3>Diagnostik – Praktikum</h3>
        
        In dem Modul Grundlagen der Diagnostik (PsyBSc8) lernt ihr im Praktikum ein psychologisches Testverfahren zu erstellen und empirisch zu überprüfen. In diesem Zusammenhang wird eine Itemanalyse und eine Exploratorische Faktorenanalyse durchgeführt. Hier könnt ihr erneut nachlesen, was im Praktikum vorgeführt wird.


        {{< category_list "diagnostik" 2 >}}
        <br>
        <h3>Meta-Analyse im A&O-Kontext</h3>
        
        Die hier präsentierten Unterlagen sind während des Forschungsmoduls A&O (SoSe 2020 und WiSe 2020/21) entstanden. Eine ergänzende Ressource zu Meta-Analysen im nicht-klinischen Bereich.


        {{< category_list "meta-auo" 1 >}}
        <br>
        <h3>Independence in R</h3>
        
        This is a guide, specifically designed for students, to help with your handling of R - especially when working with your own data. Here you will find detailed examples for working with R, data aggregation, descriptive and inferential statistics and much more.
        <br>
        <br>
        <a href="../independence/independence-r">A student’s guide to independence in R</a>
  
    design:
      columns: 2
---


