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
      text: 'Auf dieser Seite stellen wir Material aus der R-bezogenen Lehre im Psychologie-Studium zur Verfügung! Außerdem haben wir einige Projekte erstellt, in denen du deine R-Kenntnisse auch ganz unabhängig von den Inhalten im Studium ausprobieren, vertiefen und erweitern kannst!
      
      
      Im Moment ziehen wir um, sodass noch nicht alle Abschnitte der Seite schon wieder aktiv sind. Alles was die aktuelle Lehre betrifft ist zugänglich - nur mit den Extras und den Projekten bitten wir noch um etwas Geduld!'
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
  - block: collection
    id: lehre-features
    content:
      title: 'R in der Psychologie'
      subtitle: 'Der Einstieg zur Methodenlehre im Bachelor und Master'
      text: 'Hier eine Auswahl der Beiträge für die Lehre in der Psychologie, die sich gut für einen Einstieg in verschiedene Themen eignen. Den Überblick über alle Lehrinhalte findest du [hier](/lehre/main)! <br><br>'
      # Choose how many pages you would like to display (0 = all pages)
      count: 4
      # Filter on criteria
      filters:
        folders:
          - lehre
        author: ""
        tag: ""
        exclude_featured: false
        featured_only: true
        exclude_future: false
        exclude_past: false
        publication_type: ""
      # Choose how many pages you would like to offset by
      offset: 0
      # Page order: descending (desc) or ascending (asc) date.
      order: asc
    design:
      # Choose a layout view
      view: compact
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
      autolink: true
      # Email form provider
      form:
        provider: netlify
        formspree:
          id:
        netlify:
          # Enable CAPTCHA challenge to reduce spam?
          captcha: false
    design:
      columns: '2'
---
