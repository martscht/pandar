---
# Leave the homepage title empty to use the site title
title:
date: 2022-10-24
type: landing

sections:
  - block: markdown
    id: welcome
    content:
      title: 'Willkommen bei pandaR!'
      text: 'Auf dieser Seite stellen wir Material aus der R-bezogenen Lehre im Psychologie-Studium zur Verfügung! Außerdem haben wir einige Projekte erstellt, in denen du deine R-Kenntnisse auch ganz unabhängig von den Inhalten im Studium ausprobieren, vertiefen und erweitern kannst.'
    design:
      background:
        color: '#00618f' 
        text_color_light: true
  - block: markdown
    id: panda
    content:
      title: 
      subtitle:
      text: '<br><br><br><br><br><br><br><br>'
    design:
      background:
        image:
          filename: panda.jpg
#   - block: markdown
#     id: pandar-overview
#     content:
#       
#       title: 'Über pandaR'
#       subtitle: ''
#       text: 'Wir entwickeln pandaR seit 2019, als die Seite dafür geschaffen wurde ganz unterschiedliche Seiten von R und Programmieren vorzustellen, die im normalen Curriculum des Studiums normalerweise keinen Raum finden. Dafür haben wir als erstes [acht verschiedene Projekte](/under-construction) erschaffen, die die Möglichkeit bieten, sich in ein spezifisches Beispiel zu vertiefen und R Fähigkeiten daran auszuprobieren. Dabei können sich eigenständig Kompetenzen angeeignet werden, die für das zukünftige Arbeiten mit R in einem immer stärker datengeleiteten Arbeitsalltag sehr wichtig sein können. Die umfangreichen Projekte decken dabei eine weite Bandbreite an möglichen Themen ab (von der Darstellung von Suchanfragen zu politischen Parteien bis zum Programmieren eines eigenen Sudoku-Generators).
# 
# Als zweiten großen Punkt stellen wir seit 2020 auch [Lehrmaterialien](/lehre/main) zum Einsatz von R in der Analyse psychologischer Fragestellungen zur Verfügung. Im Sinne der Idee der Open Educational Ressources hat sich eine breite Menge an Themen angesammelt, die in Tutorials aber auch Aufgaben und zugehörigen Lösungen untergliedert sind. Insgesamt sind bereits Materialien aus 6 Modulen der Studiengänge des Instuts für Psychologie der Goethe-Universität integriert.
# 
# Inzwischen wächst pandaR immer weiter und umfasst auch eine Einführung in unsere [lokale Open Science Infrastruktur](/lifos/main) an der Goethe Uni und eine ganze [Sammlung von Material](/under-construction) aus Workshops und weiterführenden Informationen.
# 
# Wenn du Rückmeldungen zu den Projekten oder der Seite als Ganzem hast, melde dich einfach über das Kontakformular bei uns!'
#     design:
#       columns: 2
  - block: collection
    id: lehre-features
    content:
      title: 'R in der Psychologie'
      subtitle: 'Die neuesten Beiträge für die Methodenlehre im Bachelor und Master'
      text: 'Hier findest du ein paar Beiträge aus der Lehre - falls es nicht per Zufall das sein sollte, was du suchst, gibt es [hier eine Seite](/lehre/main) auf der alle Lehrinhalte findest! <br><br>'
      # Choose how many pages you would like to display (0 = all pages)
      count: 3
      # Filter on criteria
      filters:
        folders:
          - lehre
        author: ""
        tag: ""
        exclude_featured: false
        featured_only: false
        exclude_future: false
        exclude_past: false
        publication_type: ""
      # Choose how many pages you would like to offset by
      offset: 0
      # Page order: descending (desc) or ascending (asc) date.
      order: desc
      # Sort pages by: date, title, or weight
      sort_by: 'Params.lastmod'
      archive:
        enable: true
        text: 'Alles aus der Lehre'
        link: /lehre/main
    design:
      # Choose a layout view
      view: card
      columns: '2'
  # - block: portfolio
  #   id: projekte-features
  #   content:
  #     title: 'Projekte'
  #     subtitle: 'Eigenständige Projekte, um R-Fähigkeiten auszutesten und zu vertiefen - ganz unabhängig von der Lehre'
  #     text: 'Hier ein kleiner Einblick, in die Projekte, die wir erstellt haben. Den gesamten Überblick findest du [hier](/projekte/main)!<br><br>'
  #     # Choose how many pages you would like to display (0 = all pages)
  #     count: 4
  #     # Filter on criteria
  #     filters:
  #       folders:
  #         - projekte
  #       author: ""
  #       tag: ""
  #       exclude_featured: false
  #       featured_only: true
  #       exclude_future: false
  #       exclude_past: false
  #       publication_type: ""
  #     sort_by: 'Date'
  #     sort_ascending: false
  #     default_button_index: 0
  #     buttons:
  #       - name: Datenmanagement
  #         tag: Datenmanagement
  #       - name: Funktionen
  #         tag: Funktionen
  #       - name: Text-Analyse
  #         tag: Text-Analyse
  #   design:
  #     # Choose a layout view
  #     view: showcase
  #     columns: '2'
  - block: markdown
    id: team
    content:
      title: 'Unser Team'
      text: 'An pandaR arbeitet ein Team aus Mitarbeitenden und Studierenden des Instituts für Psychologie an der Goethe Universität Frankfurt. Außerdem haben inzwischen über 20 Personen von verschiedenen Bildungseinrichtungen und aus unterschiedlichen Disziplinen Beiträge gestaltet und Inhalte verfasst.
      <br><br>
      {{< cta cta_alt_text="Das Team kennenlernen" cta_alt_link="/team" cta_alt_new_tab="false" >}}'
    design:
      background:
        color: '#00618f' 
        text_color_light: true
      columns: 2
  - block: contact
    id: kontakt
    content:
      title: Kontakt
      subtitle: Nachfragen, Anmerkungen oder Wünsche?
      # Contact (add or remove contact options as necessary)
      email: pandar@psych.uni-frankfurt.de
      # phone: 0049 69 798 35355
      address:
        name: Goethe Universität Frankfurt
        street: Theodor-W.-Adorno-Platz 6
        city: Frankfurt am Main
        region: Hessen
        postcode: '60629'
        country: Deutschland
        country_code: DE
      # Automatically link email and phone or display as text?
      autolink: false
      # Email form provider
      # form:
      #   provider: netlify
      #   formspree:
      #     id:
      #   netlify:
      #     # Enable CAPTCHA challenge to reduce spam?
      #     captcha: false
    design:
      columns: '2'
---
