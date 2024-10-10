---
title: Multiple Regression
date: '2024-09-26'
slug: multiple-regression-klinische
categories: ["KliPPs"]
tags: ["Regression", "Voraussetzungen", "Grundlagen"]
subtitle: 'Grundlagen, Annahmen und ein paar Erweiterungen'
summary: ''
authors: [schultze, nehler, irmer]
weight: 1
lastmod: '2024-10-10'
featured: no
banner:
  image: "/header/whip.jpg"
  caption: "[Courtesy of pexels](https://www.pexels.com/photo/whip-on-red-background-5187496/)"
projects: []

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /lehre/klipps/multiple-regression-klinische
  - icon_pack: fas
    icon: terminal
    name: Code
    url: /lehre/klipps/multiple-regression-klinische.R
  - icon_pack: fas
    icon: newspaper
    name: Artikel
    url: https://doi.org/10.1177/10790632231205799
    
output:
  html_document:
    keep_md: true
---



## Einleitung

Im ersten Beitrag zur Methodenlehre im Master "Klinische Psychologie und Psychotherapie" (ab sofort einfach immer auf KliPPs abgekürzt) geht es darum, an einem konkreten Beispiel aus der aktuellen klinischen Forschung noch einmal die Grundideen der multiplen Regression zu wiederholen und für den Fall einer moderierten Regression zu nutzen. Beides in einem Beitrag kann etwas kurz geraten, deswegen möchte ich an dieser Stelle noch auf die etwas umfangreicheren Einzelbeiträge aus dem Bachelorstudiengang zur [multiplen Regression](/lehre/statistik-i/multiple-reg), der [Prüfung der Voraussetzungen in der multiplen Regression](/lehre/statistik-ii/regressionsdiagnostik), zur [Inferenz und Modellauswahl](/lehre/statistik-ii/multreg-inf-mod) und zur [moderierten Regression](/lehre/statistik-ii/moderierte-reg) verweisen. Wie Sie sehen: das sind einige Beiträge, also können wir hier wirklich nur einen Versuch der Auffrischung unternehmen und uns angucken, wie eine Anwendung dieser Methoden in der Praxis aussieht.

### Neigung zur sexuellen Nötigung

Eine Anwendung der moderierten Regression finden wir im Artikel von [Thatcher, Wallace & Fido (2023)](https://doi.org/10.1177/10790632231205799). In dieser Studie geht es darum, die Neigung zur sexuellen Nötigung (sexual coercion proclivity, SCP) mit psychopathischen Persönlichkeitseigenschaften in Verbindung zu bringen und dabei insbesondere zu untersuchen, inwiefern diese den Einfluss atypischer Sexualpräferenzen (z.B. Sadismus und Masochismus) moderiert. Alle Daten stammen dabei aus einer Online-Erhebung aus der Britischen Allgemeinbevölkerung. 


***

## Literatur

[Thatcher, A. S., Wallace, L., & Fido, D. (2023)](https://doi.org/10.1177/10790632231205799). Psychopathic Personality as a Moderator of the Relationship Between Atypical Sexuality and Sexual Coercion Proclivity in the General Population. _Sexual Abuse, 0_(0). https://doi.org/10.1177/10790632231205799
