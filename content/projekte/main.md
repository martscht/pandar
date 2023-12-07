---
type: landing
title: "Projekte"
summary: "Auf dieser Überblicksseite findest du alle Projekte, die wir bisher erstellt haben. Jedes Projekt ist in vier Abschnitte gegliedert: Übersicht, Problemstellung, Tipps und Lösungen. Die ersten beiden stellen das jeweilige Projekt inhaltlich vor und schildern die Probleme, die in der Bewältigung auftreten könnten. Bei den Tipps gibt es kleine Hilfestellungen, wenn du an irgendeiner Stelle nicht weiterkommen solltest. Die Lösungen zeigen dann letztlich, wie wir dieses Projekt bearbeitet haben.

Wenn du dir die Projekte anschaust, dann ist es nicht zwingend notwendig, sie in der präsentierten Reihenfolge durchzugehen. Generell werden die Projekte zwar nach unten hin etwas schwieriger, aber keines erfordert explizit die Bearbeitung eines vorhergehenden Projekts, weshalb alle weitestgehend unabhängig voneinander bearbeitet werden können. Falls du erst noch einen Blick in die Auffrischung werfen willst, findest du [hier](https://pandar.netlify.app/categories/zusatz) ein paar zusätzliche Inhalte."
weight: 10

show_date: false

sections:
  - block: markdown
    id: header
    content:
      title: Überblick
      subtitle: 
      text: "Auf dieser Überblicksseite findest du alle Projekte, die wir bisher erstellt haben. Jedes Projekt ist in vier Abschnitte gegliedert: Übersicht, Problemstellung, Tipps und Lösungen. Die ersten beiden stellen das jeweilige Projekt inhaltlich vor und schildern die Probleme, die in der Bewältigung auftreten könnten. Bei den Tipps gibt es kleine Hilfestellungen, wenn du an irgendeiner Stelle nicht weiterkommen solltest. Die Lösungen zeigen dann letztlich, wie wir dieses Projekt bearbeitet haben.

Wenn du dir die Projekte anschaust, dann ist es nicht zwingend notwendig, sie in der präsentierten Reihenfolge durchzugehen. Generell werden die Projekte zwar nach unten hin etwas schwieriger, aber keines erfordert explizit die Bearbeitung eines vorhergehenden Projekts, weshalb alle weitestgehend unabhängig voneinander bearbeitet werden können. Falls du erst noch einen Blick in die Auffrischung werfen willst, findest du [hier](https://pandar.netlify.app/categories/zusatz) ein paar zusätzliche Inhalte."
    design:
      background:
        color: "#01628f"
        text_color_light: true
      columns: 2
      
  - block: collection
    id: projekt-1
    content:
      title: 'Verbentrainer'
      subtitle: 'Projekt 1'
      text: ''
      # Choose how many pages you would like to display (0 = all pages)
      count: 1
      # Filter on criteria
      filters:
        folders:
          - projekte
        author: ""
        tag: "projekt1"
      # Choose how many pages you would like to offset by
      offset: 0
      # Page order: descending (desc) or ascending (asc) date.
      order: asc
    design:
      view: compact-titleless
      columns: '2'
      
  - block: collection
    id: projekt-2
    content:
      title: 'Google Trends'
      subtitle: 'Projekt 2'
      text: ''
      # Choose how many pages you would like to display (0 = all pages)
      count: 1
      # Filter on criteria
      filters:
        folders:
          - projekte
        author: ""
        tag: "projekt2"
      # Choose how many pages you would like to offset by
      offset: 0
      # Page order: descending (desc) or ascending (asc) date.
      order: asc
    design:
      view: compact-titleless
      columns: '2'
      
  - block: collection
    id: projekt-3
    content:
      title: 'Casino'
      subtitle: 'Projekt 3'
      text: ''
      # Choose how many pages you would like to display (0 = all pages)
      count: 1
      # Filter on criteria
      filters:
        folders:
          - projekte
        author: ""
        tag: "projekt3"
      # Choose how many pages you would like to offset by
      offset: 0
      # Page order: descending (desc) or ascending (asc) date.
      order: asc
    design:
      view: compact-titleless
      columns: '2'

  - block: collection
    id: projekt-4
    content:
      title: 'Whatsapp Chats'
      subtitle: 'Projekt 4'
      text: ''
      # Choose how many pages you would like to display (0 = all pages)
      count: 1
      # Filter on criteria
      filters:
        folders:
          - projekte
        author: ""
        tag: "projekt4"
      # Choose how many pages you would like to offset by
      offset: 0
      # Page order: descending (desc) or ascending (asc) date.
      order: asc
    design:
      view: compact-titleless
      columns: '2'


      
  # - block: markdown
  #   id: projekt-5
  #   content:
  #     title: Projekt 5
  #     subtitle:  OpenStreetMap
  #     text: 
  #       In diesem Projekt arbeiten wir mit externen Online-Datenbanken zur Kartendarstellung. Dieses Projekt lässt dir viele Freiheiten, weshalb du es individuell an deine Vorstellungen anpassen kannst. Zum Beispiel kannst du deine Heimatstadt darstellen und dort alle Pommesbuden finden. Hier wird deiner Fantasie keine Grenzen gesetzt.
  #       {{< category_list "projekt-4" 1 >}}
  #       
  #   design:
  #     columns: 2
  #           
  #     
  #     
  # - block: markdown
  #   id: projekt-6
  #   content:
  #     title: Projekt 6
  #     subtitle:  Sudoku
  #     text: 
  #       In diesem Projekt zeigen wir dir, wie du dir dein eigenes Sudoku erstellen kannst. Was steckt hinter diesem Rätsel? Wie löst man sie am schnellsten? Mit verschiedenen Schwierigkeitsgraden kannst du hier deine Rätselfähigkeiten steigern und alles anwenden, was du bisher schon gelernt hast.
  #       {{< category_list "projekt-5" 1 >}}
  #       
  #   design:
  #     columns: 2
  #           
  #     
  #     
  # - block: markdown
  #   id: projekt-7
  #   content:
  #     title: Projekt 7
  #     subtitle:  FormR
  #     text: 
  #       In diesem Projekt werden wir dir die Seite FormR näher bringen. Dies ist eine Website, die vor allem die Organisation für Langzeitstudien einfach machen soll. Wir werden weniger R intern arbeiten sondern mit Google Sheets und eine kleine Umfrage zu den Big Five generieren.
  #       {{< category_list "projekt-6" 1 >}}
  #       
  #   design:
  #     columns: 2
  #           
  #     
  #     
  # - block: markdown
  #   id: projekt-8
  #   content:
  #     title: Projekt 8
  #     subtitle:  ShinyR
  #     text: 
  #       In diesem Projekt zeigen wir dir den Umgang mit ShinyR. ShinyR ermöglicht es, interaktive Webinhalte mithilfe von R zu erstellen. Die dabei entstehenden Websites lassen R im Hintergrund und können somit von jeder Person ohne Programmiererfahrung genutzt werden.
  #       {{< category_list "projekt-7" 1 >}}
  #       
  #   design:
  #     columns: 2
  #           
  #     
  #     
  # - block: markdown
  #   id: projekt-9
  #   content:
  #     title: Projekt 9
  #     subtitle:  API
  #     text: 
  #       In diesem letzten Projekt werden wir dir zeigen, was eine API ist und wie du über diese, Daten in dein R Studio laden kann. Dies nennt sich auch Web-Scraping. In dem Projekt werden wir Daten von der WHO herunterladen, die Indexe zu jeglichen gesundheitszogenen Themen sammelt. Im Anschluss werden wir die Daten grafisch und interaktiv aufbereiten.
  #       {{< category_list "projekt-8" 1 >}}
  #       
  #   design:
  #     columns: 2
---
