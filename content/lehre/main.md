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
          filename: teaching2.jpg
        text_color_light: true
      columns: 2
  - block: markdown
    id: statistik-i
    content:
      title: Statistik I
      subtitle: PsyBSc 2
      text: |-
        In Statistik I geht es um die erste Einführung in die Statistik im Psychologiestudium. Dafür betrachten wir die Grundstruktur von R, Datenimport, einfache Grafiken, Deskriptivstatistiken, Verteilungsfunktionen und einige Tests.
        {{< category_list "statistik-i" 10 "I,II">}}

        Die Umfrage aus der ersten Woche gibt es [hier](https://psybsc2.formr.org/). Die Daten, die dabei in der ersten Sitzung entstanden sind, können Sie [{{< icon name="download" pack="fas" >}}   hier im RDA Format](/post/fb22.rda) und [{{< icon name="download" pack="fas" >}} hier im CSV Format](/post/fb22.csv) herunterladen. Was welche Variablen in diesem Datensatz bedeutet, wird in der [{{< icon name="download" pack="fas" >}} Variablenübersicht erläutert](/post/variablen.pdf). 

    design:
      columns: 2
  - block: markdown
    id: statistik-ii
    content:
      title: Statistik II
      subtitle: PsyBSc 7
      text: |-
        In Statistik II werden naheliegenderweise die Inhalte aus Statistik I vertieft. Behandelt werden u.a. Matrixalgebra, multiple Regression und Varianzanalysen. Außerdem gucken wir uns ein paar R-spezifische Dinge wie `ggplot2` oder das Schreiben eigener Funktionen an.
        {{< category_list "statistik-i" 10 "">}}
    design:
      columns: 2
 #  - block: collection
 #    id: statistik-iii
 #    content:
 #      title: Statistik I
 #      subtitle: PsyBSc 2
 #      text: 'In Statistik I geht es um die erste Einführung in die Statistik im Psychologiestudium. Dafür betrachten wir die Grundstruktur von R, Datenimport, einfache Grafiken, Deskriptivstatistiken, Verteilungsfunktionen und einige Tests.<br><br>'
       # Choose how many pages you would like to display (0 = all pages)
 #      count: 4
 #      # Filter on criteria
 #      filters:
 #        folders:
 #          - lehre
 #        author: ""
 #        tag: ""
 #        category: 'Statistik I'
 #        exclude_featured: false
 #        featured_only: false
 #        exclude_future: false
 #        exclude_past: false
 #        publication_type: ""
 #      # Choose how many pages you would like to offset by
 #      offset: 0
 #      # Page order: descending (desc) or ascending (asc) date.
 #      order: asc
 #    design:
 #      # Choose a layout view
 #      view: compact
 #      columns: '2'
       
  - block: collection
    id: statistik-iii
    content:
      title: Statistik I
      subtitle: 'PsyBSc 2'
      text: 'In Statistik I geht es um die erste Einführung in die Statistik im Psychologiestudium. Dafür betrachten wir die Grundstruktur von R, Datenimport, einfache Grafiken, Deskriptivstatistiken, Verteilungsfunktionen und einige Tests.<br><br>'
      # Choose how many pages you would like to display (0 = all pages)
      count: 5
      # Filter on criteria
      filters:
        # The folders to display content from
        folders:
          - lehre
        author: ""
        category: "Statistik I"
        tag: ""
        publication_type: ""
        featured_only: false
        exclude_featured: false
        exclude_future: false
        exclude_past: false
      # Choose how many pages you would like to offset by
      # Useful if you wish to show the first item in the Featured widget
      offset: 0
      # Field to sort by, such as Date or Title
      sort_by: 'Date'
      sort_ascending: true
    design:
      # Choose a listing view
      view: 1 # Klassische List-View
      # Choose single or dual column layout
      columns: '2'
---


