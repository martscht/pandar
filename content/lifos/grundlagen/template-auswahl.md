---
title: "LIFOS Templates" 
type: post
date: '2023-05-17' 
slug: template-auswahl
categories: ["LIFOS Grundlagen", "LIFOS"] 
tags: ["Grundlagen", "Hilfsmittel"] 
subtitle: 'Hier findet ihr die perfekte Vorlage für euer Projekt'
summary: 'In diesem kurzen Beitrag könnt ihr für euch per Multiple-Choice Fragen herausfinden, welche LIFOS-Vorlage am ehesten geeignet ist für eure Projekte und Arbeiten.' 
authors: [beitner,pommeranz] 
weight: 2
lastmod: '2025-02-07'
featured: no
banner:
  #image: "/header/road_start.jpg"
  #caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1217289)"
projects: []
reading_time: false
share: false

links:
  - name: DE
    url: /lifos/grundlagen/template-auswahl
  - name: EN
    url: /lifos/grundlagen/template-auswahl-en

output:
  html_document:
    keep_md: true
---

<!-- Multiple Choice & Skript für Hide / Reveal & CSS für den Button-->
<script type="text/javascript">
  function Reveal(it, box) {<!--from www.java2s.com-->
    var vis = (box.checked) ? "block" : "none";
    document.getElementById(it).style.display = vis;
  }

  function Hide(it, box) {
    var vis = (box.checked) ? "none" : "none";
    document.getElementById(it).style.display = vis;
  }
</script>
<style>
input[type = reset] {
    background-color: transparent;
    background-repeat: no-repeat;
    border: none;
    cursor: pointer;
    overflow: hidden;
    outline: none;
      color: #00618f;
}
</style>

<!-- Erste Ebene -->
<form>
  <div id="divStart" style="display: block">
  Erhebst du für deine Studie neue Daten oder greifst du auf bisher vorhandene Daten zurück?
  
  <input type="radio" name="Wahl1" value="value1" onClick="Hide('divOldData', this); Hide('divHoppla',this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Reveal('divNewData', this); Hide('divDeskriptiveStudien', this)" /> Neue Daten  
  <input type="radio" name="Wahl1" value="value2" onClick="Hide('divNewData', this); Hide('divHoppla',this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Reveal('divOldData', this); Hide('divDeskriptiveStudien', this)" /> Vorhandene Daten    
  <input type="radio" name="Wahl1" value="value3" onClick="Hide('divNewData', this); Hide('divOldData',this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Reveal('divHoppla', this); Hide('divDeskriptiveStudien', this)" /> Weder noch
  
  <hr>
  </div>
  
  <!-- Zweite Ebene -->
  <!-- Neue Daten -->
  <div id="divNewData" style="display: none">
  Ist deine Studie eine Replikationsstudie, das heißt, eine Wiederholung einer bereits existierenden Studie?
  
  <input type="radio" name="Wahl2a" value="value4" onClick=" Hide('divKeineReplikation', this); Hide('divHoppla', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Reveal('divReplikation', this); Hide('divDeskriptiveStudien', this)" /> Ja<br>
  <input type="radio" name="Wahl2a" value="value5" onClick=" Hide('divReplikation', this); Hide('divHoppla', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Reveal('divKeineReplikation', this); Hide('divDeskriptiveStudien', this)" /> Nein<br>
  <input type="radio" name="Wahl2a" value="value6" onClick=" Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Reveal('divHoppla', this); Hide('divDeskriptiveStudien', this)" /> Weder noch<br>
  
  <hr>
  </div>
  
  <!-- Vorhandene Daten -->
  <div id="divOldData" style="display: none">
  Planst du, die Ergebnisse mehrerer Studien zusammenzufassen, um eine allgemeine Aussage zu treffen, oder möchtest du auf bestehende Datensets zurückgreifen, um neue Forschungsfragen zu beantworten?
  
  <input type="radio" name="Wahl2b" value="value7" onClick="Hide('divHoppla', this); Hide('divSekundaeranalyse', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Reveal('divMetaanalyse', this)" /> Mehrere Studien<br>
  <input type="radio" name="Wahl2b" value="value8" onClick="Hide('divHoppla', this); Hide('divMetaanalyse', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Reveal('divSekundaeranalyse', this)" /> Bestehendes Datenset<br>
  <input type="radio" name="Wahl2b" value="value9" onClick="Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Reveal('divHoppla', this)" /> Weder noch<br>
  
  <hr>
  </div>
  
  <!-- Dritte Ebene - Neue Daten -->
  <!-- Replikationsstudie -->
  <div id="divReplikation" style="display: none">
Deine Antworten geben Hinweise darauf, dass deine Studie eine Replikationsstudie ist. Dafür steht folgendes Template zur Verfügung: 
  
  - Replication Studies
  
In dem vorgeschlagenen Template findest du die Replication Recipe Preregistration Vorlage von <a href="https://doi.org/10.1016/j.jesp.2013.10.005">Brandt et al. (2013)</a>, die optimal für Replikationen geeignet ist.
  
Ist ein Fehler unterlaufen?<input type ="reset" value="Hier klicken" onClick="Hide('divOldData', this); Hide('divNewData', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Hide('divHoppla', this)"/>um zum Anfang zurückzusetzen!
  </div>
  
  <!-- Keine Replikationsstudie -->
  <div id="divKeineReplikation" style="display: none">
Werden in Deiner Studie gezielt Veränderungen und Manipulationen an einer oder mehreren unabhängigen Variablen vorgenommen, um ihre Auswirkungen auf eine abhängige Variable zu untersuchen oder sollen lediglich Zusammenhänge zwischen Variablen beschrieben werden? 
  
  <input type="radio" name="Wahl3" value="value10" onClick="Hide('divHoppla', this); Hide('divDeskriptiveStudien', this); Reveal('divExperiment', this)" /> Manipulationen<br>
  <input type="radio" name="Wahl3" value="value11" onClick="Hide('divHoppla', this); Hide('divExperiment', this); Reveal('divDeskriptiveStudien', this)" /> Zusammenhänge<br>
  <input type="radio" name="Wahl3" value="value12" onClick="Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Reveal('divHoppla', this)" /> Weder noch<br>
  
  <hr>
  </div>
  
  <!-- Dritte Ebene - Alte Daten -->
  <!-- Meta-Analysen -->
  <div id="divMetaanalyse" style="display: none">
Deine Antworten geben Hinweise darauf, dass deine Studie  eine Meta-Analyse oder ein systematisches Review ist. Dafür steht folgendes Template zur Verfügung:
  
  - Meta-Analyses and Systematic Reviews
  
Im vorgeschlagenen Template befinden sich das Präregistrierungsformat von <a href="https://www.crd.york.ac.uk/prospero/">PROSPERO</a> sowie die <a href="http://prisma-statement.org">PRISMA-Leitlinien</a>. 
  
Ist ein Fehler unterlaufen?<input type ="reset" value="Hier klicken" onClick="Hide('divOldData', this); Hide('divNewData', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Hide('divHoppla', this)"/>um zum Anfang zurückzusetzen!
  </div>
  
  <!-- Sekundäranalyse -->
  <div id="divSekundaeranalyse" style="display: none">
Deine Antworten geben Hinweise darauf, dass du in deiner Studie eine Sekundärdatenanalyse anhand eines oder mehrerer bestehenden Datensets durchführst. Dafür steht folgendes Template zur Verfügung:
  
  - Secondary Data Analaysis
  
In dem vorgeschlagenen Template findest du eine spezifische Präregistrierungsvorlage mit Fokus auf sekundäre Datenanalysen. Darüber hinaus wird kein Ordner für Daten angelegt und es werden spezifsiche Hinweise im ReadMe gegeben, was bei einer Sekundärdatenanalyse zu beachten ist.
  
Ist ein Fehler unterlaufen?<input type ="reset" value="Hier klicken" onClick="Hide('divOldData', this); Hide('divNewData', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Hide('divHoppla', this)"/>um zum Anfang zurückzusetzen!
  </div>
  
  <!-- Vierte Ebene Ebene - Keine Replikation -->
  <!-- Experiment -->
  <div id="divExperiment" style="display: none">
In deiner Studie erhebst du Daten mit Hilfe eines behavioralen Experimentes. Dafür stehen die folgenden beiden Templates zur Verfügung:
  
  - Behavioral Experiments BSc
  - Behavioral Experiments MSc
  
Beide Templates sind für Verhaltensexperimente optimal geeignet und unterscheiden sich hinsichtlich der bereit gestellen Präreregistrierungsvorlagen. Im BSc Template findet sich nur die AsPredicted Preregistration Vorlage, wohingegen im MSc Template drei Preregistration Vorlagen zu finden sind: AsPredicted, OSF Standard Preregistration Template, und die PRP-QUANT Vorlage – die zwei letzteren sind ausführlicher. Für Studierende, unabhängig ob BSc und MSc, die mit ihren Betreuer*innen besprochen haben, die OSF Preregistration Vorlage zu verwenden, wird das Behavioral Experiments MSc Template empfohlen. 
  
Ist ein Fehler unterlaufen?<input type ="reset" value="Hier klicken" onClick="Hide('divOldData', this); Hide('divNewData', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Hide('divHoppla', this)"/>um zum Anfang zurückzusetzen!
  </div>
  
  <!-- Deskriptive Studien -->
  <div id="divDeskriptiveStudien" style="display: none">
In deiner Studie untersuchst du bestehende Zusammenhänge ohne eine aktive experimente Manipulation. Dafür stehen die folgenden beiden Templates zur Verfügung: 
  
  - Correlative and Descriptive Studies - BSc
  - Correlative and Descriptive Studies - MSc

Beide Templates sind für diese Art von Studie optimal geeignet und unterscheiden sich hinsichtlich der bereit gestellen Präreregistrierungsvorlagen. Im BSc Template findet sich nur die AsPredicted Preregistration Vorlage, wohingegen im MSc Template drei Preregistration Vorlagen zu finden sind: AsPredicted, OSF Standard Preregistration Template, und die PRP-QUANT Vorlage – die zwei letzteren sind ausführlicher. Für Studierende, unabhängig ob BSc und MSc, die mit ihren Betreuer*innen besprochen haben, die OSF Preregistration Vorlage zu verwenden, wird das Behavioral Experiments MSc Template empfohlen. 
  
Ist ein Fehler unterlaufen?<input type ="reset" value="Hier klicken" onClick="Hide('divOldData', this); Hide('divNewData', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Hide('divHoppla', this)"/>um zum Anfang zurückzusetzen!
  </div>
  
  <!-- Der Joker - Der Hoppla-Text -->
  <div id="divHoppla" style="display: none">
  <b>Hoppla</b>, da ging wohl etwas schief! Im Falle eines Missverständnisses bitten wir dich, die Entscheidungsshilfe nochmal durchzuführen. Aber sollte deine Art von Studie in unserer Entscheidungshilfe und somit auch unseren Templates nicht vorhanden sein, bitten wir um Entschuldigung. Kontaktiere uns doch unter <a href="mailto:lifos@uni-frankfurt.de">LIFOS@uni-frankfurt.de</a> und wir helfen dir persönlich dabei, das passende Template für dich zu finden. Und wer weiß, vielleicht kannst du uns ja dabei helfen, ein neues Template für deine Art von Studie zu erstellen! :) 
  
  Ist ein Fehler unterlaufen?<input type ="reset" value="Hier klicken" onClick="Hide('divOldData', this); Hide('divNewData', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Hide('divHoppla', this)"/>um zum Anfang zurückzusetzen!
  </div>
</form>
