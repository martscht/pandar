---
title: "LIFOS Templates" 
type: post
date: '2023-05-17' 
slug: template-auswahl-en
categories: ["LIFOS"] 
tags: ["Grundlagen", "Hilfe"] 
subtitle: 'Here you can find the perfect template for your project'
summary: '' 
authors: [beitner,pommeranz] 
weight: 2
lastmod: '2023-10-09'
featured: no
banner:
  #image: "/header/road_start.jpg"
  #caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1217289)"
projects: []
reading_time: false
share: false

links:
  - name: EN
    url: /lifos/grundlagen/template-auswahl-en
  - name: DE
    url: /lifos/grundlagen/template-auswahl

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
  Do you collect new data for your study or do you use preexisting data?
  
  <input type="radio" name="Wahl1" value="value1" onClick="Hide('divOldData', this); Hide('divHoppla',this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Reveal('divNewData', this); Hide('divDeskriptiveStudien', this)" /> New data  
  <input type="radio" name="Wahl1" value="value2" onClick="Hide('divNewData', this); Hide('divHoppla',this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Reveal('divOldData', this); Hide('divDeskriptiveStudien', this)" /> Preexisting data    
  <input type="radio" name="Wahl1" value="value3" onClick="Hide('divNewData', this); Hide('divOldData',this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Reveal('divHoppla', this); Hide('divDeskriptiveStudien', this)" /> Neither
  
  <hr>
  </div>
  
  <!-- Zweite Ebene -->
  <!-- Neue Daten -->
  <div id="divNewData" style="display: none">
  Is your study a replication study, meaning a repetition of an already existing study?
  
  <input type="radio" name="Wahl2a" value="value4" onClick=" Hide('divKeineReplikation', this); Hide('divHoppla', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Reveal('divReplikation', this); Hide('divDeskriptiveStudien', this)" /> Yes<br>
  <input type="radio" name="Wahl2a" value="value5" onClick=" Hide('divReplikation', this); Hide('divHoppla', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Reveal('divKeineReplikation', this); Hide('divDeskriptiveStudien', this)" /> No<br>
  <input type="radio" name="Wahl2a" value="value6" onClick=" Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Reveal('divHoppla', this); Hide('divDeskriptiveStudien', this)" /> Neither<br>
  
  <hr>
  </div>
  
  <!-- Vorhandene Daten -->
  <div id="divOldData" style="display: none">
  Are you planning to summarize the results of multiple studies to make a general statement, or do you want to use preexisting datasets to answer new research questions?
  
  <input type="radio" name="Wahl2b" value="value7" onClick="Hide('divHoppla', this); Hide('divSekundaeranalyse', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Reveal('divMetaanalyse', this)" /> Multiple studies<br>
  <input type="radio" name="Wahl2b" value="value8" onClick="Hide('divHoppla', this); Hide('divMetaanalyse', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Reveal('divSekundaeranalyse', this)" /> Preexisting dataset<br>
  <input type="radio" name="Wahl2b" value="value9" onClick="Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Reveal('divHoppla', this)" /> Neither<br>
  
  <hr>
  </div>
  
  <!-- Dritte Ebene - Neue Daten -->
  <!-- Replikationsstudie -->
  <div id="divReplikation" style="display: none">
Your responses indicate that your study is a replication study. The following template is available for this type:
  
  - Replication Studies
  
In the recommended template you can find the Replication Recipe Preregistration Template by <a href="https://doi.org/10.1016/j.jesp.2013.10.005">Brandt et al. (2013)</a>, which is optimally suited to replications.
  
Did an error occur?<input type ="reset" value="Click here" onClick="Hide('divOldData', this); Hide('divNewData', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Hide('divHoppla', this)"/>to reset!
  </div>
  
  <!-- Keine Replikationsstudie -->
  <div id="divKeineReplikation" style="display: none">
Does your study make purposeful changes or manipulations to one or more independent variables to examine their effects on a dependent variable, or does your study only describe correlations between variables?
  
  <input type="radio" name="Wahl3" value="value10" onClick="Hide('divHoppla', this); Hide('divDeskriptiveStudien', this); Reveal('divExperiment', this)" /> Manipulations<br>
  <input type="radio" name="Wahl3" value="value11" onClick="Hide('divHoppla', this); Hide('divExperiment', this); Reveal('divDeskriptiveStudien', this)" /> Correlations<br>
  <input type="radio" name="Wahl3" value="value12" onClick="Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Reveal('divHoppla', this)" /> Neither<br>
  
  <hr>
  </div>
  
  <!-- Dritte Ebene - Alte Daten -->
  <!-- Meta-Analysen -->
  <div id="divMetaanalyse" style="display: none">
Your responses indicate that your study is a meta-analysis or systematic review. The following template is available for this type:
  
  - Meta-Analyses and Systematic Reviews
  
Within the template you can find a format for preregistration by <a href="https://www.crd.york.ac.uk/prospero/">PROSPERO</a> and the <a href="http://prisma-statement.org">PRISMA-Guidelines</a>. 
  
Did an error occur?<input type ="reset" value="Click here" onClick="Hide('divOldData', this); Hide('divNewData', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Hide('divHoppla', this)"/>to reset!
  </div>
  
  <!-- Sekundäranalyse -->
  <div id="divSekundaeranalyse" style="display: none">
Your responses indicate that your study is a secondary data analysis. The following template is available for this type:
  
  - Secondary Data Analaysis
  
In the recommended template you can find a specific template for preregistration with a focus on secondary data analysis. Moreover, no folder for the data will be created and there are specific pointers in the ReadMe for what to keep in mind during a secondary data analysis.
  
Did an error occur?<input type ="reset" value="Click here" onClick="Hide('divOldData', this); Hide('divNewData', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Hide('divHoppla', this)"/>to reset!
  </div>
  
  <!-- Vierte Ebene - Keine Replikation -->
  <!-- Experiment -->
  <div id="divExperiment" style="display: none">
Within your study you collect data with the help of a behavioral experiment. The following two templates are available for this case:
  
  - Behavioral Experiments BSc
  - Behavioral Experiments MSc
  
Both templates are optimally suited for use in a study with a behavioral experiment and are different from each other in regards to their preregistration templates. The BSc template only includes the AsPredicted preregistration template, whereas the MSc template includes three different preregistration templates: AsPredicted, OSF Standard Preregistration Template, and the PRP-QUANT template - with the latter two being more detailed. For students, no matter if BSc or MSc, who chose together with their instructor to use the OSF Preregistration template it is recommended to use the Behavioral Experiments MSc template.
  
Did an error occur?<input type ="reset" value="Click here" onClick="Hide('divOldData', this); Hide('divNewData', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Hide('divHoppla', this)"/>to reset!
  </div>
  
  <!-- Deskriptive Studien -->
  <div id="divDeskriptiveStudien" style="display: none">
Within your study you research existing correlations without the use of an active experimental manipulation. The following two templates are available for this case:
  
  - Correlative and Descriptive Studies - BSc
  - Correlative and Descriptive Studies - MSc

Both templates are optimally suited for use in a study with a behavioral experiment and are different from each other in regards to their preregistration templates. The BSc template only includes the AsPredicted preregistration template, whereas the MSc template includes three different preregistration templates: AsPredicted, OSF Standard Preregistration Template, and the PRP-QUANT template - with the latter two being more detailed. For students, no matter if BSc or MSC, who chose together with their instructor to use the OSF Preregistration template it is recommended to use the Correlative and Descriptive Studies MSc template.
  
Did an error occur?<input type ="reset" value="Click here" onClick="Hide('divOldData', this); Hide('divNewData', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Hide('divHoppla', this)"/>to reset!
  </div>
  
  <!-- Der Joker - Der Hoppla-Text -->
  <div id="divHoppla" style="display: none">
  <b>Whoops</b>, it seems that something went wrong! In case of a misunderstanding, please redo the template picker again. But if your type of study is not covered by our template help and therefore not in our collection of templates then we are sorry. Feel free to contact us under <a href="mailto:lifos@uni-frankfurt.de">LIFOS@uni-frankfurt.de</a> and we will help you personally to find the right template for you. And who knows, maybe you can help us create a new template for your type of study! :)
  
Did an error occur?<input type ="reset" value="Click here" onClick="Hide('divOldData', this); Hide('divNewData', this); Hide('divReplikation', this); Hide('divKeineReplikation', this); Hide('divMetaanalyse', this); Hide('divSekundaeranalyse', this); Hide('divExperiment', this); Hide('divDeskriptiveStudien', this); Hide('divHoppla', this)"/>to reset!
  </div>
</form>
