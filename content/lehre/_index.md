---
# Leave the homepage title empty to use the site title
title: 'Material aus der Lehre'
design:
  image: "/header/teaching2.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/913893)"
  text_color_light: true

date: 2022-10-24
type: landing

sections:
  - block: collection
    id: posts
    content:
      title: 'R in der Psychologie'
      subtitle: 'Der Einstieg zur Methodenlehre im Bachelor und Master'
      text: 'Alle Lehrinhalte sind im Abschnitt [Lehre](/lehre) zu finden!'
      # Choose how many pages you would like to display (0 = all pages)
      count: 3
      # Filter on criteria
      filters:
        folders:
          - post
        author: ""
        category:
          - Statistik I
          - Statistik II
          - Multivariate Methoden
          - Klinische Methoden
        tag: ""
        exclude_featured: false
        featured_only: true
        exclude_future: false
        exclude_past: false
        publication_type: ""
      # Choose how many pages you would like to offset by
      offset: 0
      # Page order: descending (desc) or ascending (asc) date.
      order: desc
    design:
      # Choose a layout view
      view: compact
      columns: '2'
  - block: contact
    id: kontakt
    content:
      title: Kontakt
      subtitle: Nachfragen, Anmerkungen oder Wünsche?
      text: ''
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
