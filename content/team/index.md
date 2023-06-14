---
type: landing
cms_exclude: true

sections:
  - block: markdown
    id: team
    content:
      title: Unser Team 
      subtitle:
      text: Auf dieser Seite findest du alle Mitglieder unseres Teams. Eine volle Auflistung aller Autor:innen findest du [hier](/authors).
    design:
      background:
        color: '#00618f'
        text_color_light: true
      columns: 2
  - block: about.biography
    id: author_schultze
    content:
      username: schultze
  - block: about.biography
    id: author_nehler
    content:
      username: nehler
  - block: about.biography
    id: author_pommeranz
    content:
      username: pommeranz

# To publish author profile pages, remove all of the `_build` and `cascade` settings below.
# _build:
#   render: never
# cascade:
#   _build:
#     render: never
#     list: always
---
