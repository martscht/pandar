---
title: Basisfunktionen zur Grafikerstellung und lineare Modelle - Lösungen
type: post
date: '2025-02-28' 
slug: fdz-plots-lm-loesungen 
categories: [] 
tags: [] 
subtitle: ''
summary: '' 
authors: [nehler] 
lastmod: '2025-03-12'
featured: no
banner:
  image: "/header/rice-field.jpg"
  caption: "[Courtesy of pxhere](https://pxhere.com/en/photo/1217289)"
projects: []

expiryDate: ''
publishDate: ''
reading_time: false
share: false

links:
  - icon_pack: fas
    icon: book
    name: Inhalte
    url: /workshops/fdz/fdz-plots-lm
  - icon_pack: fas
    icon: pen-to-square
    name: Aufgaben
    url: /workshops/fdz/fdz-plots-lm-aufgaben
_build:
  list: never
output:
  html_document:
    keep_md: true
---





Denken Sie bei allen Aufgaben daran, den Code im R-Skript sinnvoll zu gliedern und zu kommentieren.


## Vorbereitung

Zunächst müssen wir das `readxl`, `forcats` und das `dplyr` Paket wieder aktivieren und einen Teil des Code aus dem letzten Tutorial und den letzten Aufgaben wieder durchführen.


``` r
# Paket einladen
library(readxl)
library(dplyr)
library(forcats)
# Pfad setzen
rstudioapi::getActiveDocumentContext()$path |>
  dirname() |>
  setwd()
# Daten einladen
data <- read_excel("Pennington_2021.xlsx", sheet = "Study_Data")
# Faktoren erstellen
data$Gender <- factor(data$Gender, 
                         levels = c(1, 2),
                         labels = c("weiblich", "männlich"))
data$Year <- as.factor(data$Year)
# Faktoren Rekodieren
data$Year <- fct_recode(data$Year, 
                        "7. Schuljahr" = "Year7",
                        "8. Schuljahr" = "Year8")
data$Ethnicity <- as.factor(data$Ethnicity)
# NA-Werte ersetzen
data <- data %>%
  mutate(across(where(is.numeric), ~ na_if(.x, -9)))
# Skalenwerte erstellen
data <- data %>%
  mutate(Total_Competence = rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")]))
data$Total_SelfConcept <- rowMeans(data[, c("Total_SelfConcept_Maths", "Total_SelfConcept_Science", "Total_SelfConcept_English")]) 
# Gruppierungsvariablen erstellen
data <- data %>%
  mutate(Achiever = case_when(
    Total_Competence_Maths >= 4 & 
    Total_Competence_English >= 4 & 
    Total_Competence_Science >= 4 ~ "High Achiever",
    
    Total_Competence_Maths == 1 & 
    Total_Competence_English == 1 & 
    Total_Competence_Science == 1 ~ "Low Achiever",
    
    TRUE ~ "Medium Achiever"  # Alle anderen Fälle
  ))
data <- data %>%
  mutate(Career_Recommendation = case_when(
    Maths_AttainmentData > 10 |
    Science_AttainmentData > 10 |
    Eng_AttainmentData > 10 |
    Computing_AttainmentData > 10 ~ "Empfohlen",
    
    TRUE ~ "Nicht empfohlen"
  ))  # Erstellen der neuen Variable
```
Falls Sie nicht am Workshop teilnehmen und daher keine lokale Version des Datensatzes haben, verwenden Sie diesen Code.


``` r
# Paket einladen
library(readxl)
library(dplyr)
library(forcats)
# Daten einladen
source("https://pandar.netlify.app/workshops/fdz/fdz_data_prep.R")
# Faktoren erstellen
data$Gender <- factor(data$Gender, 
                         levels = c(1, 2),
                         labels = c("weiblich", "männlich"))
data$Year <- as.factor(data$Year)
# Faktoren Rekodieren
data$Year <- fct_recode(data$Year, 
                        "7. Schuljahr" = "Year7",
                        "8. Schuljahr" = "Year8")
data$Ethnicity <- as.factor(data$Ethnicity)
# NA-Werte ersetzen
data <- data %>%
  mutate(across(where(is.numeric), ~ na_if(.x, -9)))
# Skalenwerte erstellen
data <- data %>%
  mutate(Total_Competence = rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")]))
data$Total_SelfConcept <- rowMeans(data[, c("Total_SelfConcept_Maths", "Total_SelfConcept_Science", "Total_SelfConcept_English")])
# Gruppierungsvariablen erstellen
data <- data %>%
  mutate(Achiever = case_when(
    Total_Competence_Maths >= 4 & 
    Total_Competence_English >= 4 & 
    Total_Competence_Science >= 4 ~ "High Achiever",
    
    Total_Competence_Maths == 1 & 
    Total_Competence_English == 1 & 
    Total_Competence_Science == 1 ~ "Low Achiever",
    
    TRUE ~ "Medium Achiever"  # Alle anderen Fälle
  ))
data <- data %>%
  mutate(Career_Recommendation = case_when(
    Maths_AttainmentData > 10 |
    Science_AttainmentData > 10 |
    Eng_AttainmentData > 10 |
    Computing_AttainmentData > 10 ~ "Empfohlen",
    
    TRUE ~ "Nicht empfohlen"
  ))  # Erstellen der neuen Variable
```



## Teil 1 - Grafikerstellung


1. Zeichnen Sie ein Histogramm für die Variable `Total_Mindset` und passen Sie die Grenzen der x-Achse an. Die Farbe der Umrandung der einzelnen Balekn soll Türkis sein. Finden Sie heraus, wie Sie sich alle voreingestellten Farben (wie `red` und `blue`) anzeigen lassen können und wählen Sie ein Türkis, das Ihnen gefällt.

<details><summary>Lösung</summary>

Um die Grenzen der x-Achse anzupassen, sollte zunächst der Bereich der Variable untersucht werden - bspw. mit der Funktion `summary()`.


``` r
#### Aufgaben des Tutorials zu Basisfunktionen zur Grafikerstellung und linearen Modellen ----
##### Teil 1 -----
###### Aufgabe 1 ------
summary(data$Total_Mindset) # Überblick über die Variable
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    19.0    29.0    32.0    31.6    35.0    42.0       7
```
Darin sehen wir den Bereich, den wir abdecken sollten zwischen Minimum und Maximum. Die Funktion `hist()` wird genutzt, um ein Histogramm zu erstellen. Mit `xlim()` können die Grenzen der x-Achse angepasst werden.


``` r
# Histogramm mit angepasster Skalierung der x-Achse
hist(data$Total_Mindset, 
     main = "Histogramm der Variable Total Mindset",
     xlab = "Total Mindset",
     ylab = "Häufigkeit",
     xlim = c(15, 45)) 
```

![](/fdz-plots-lm-loesungen_files/unnamed-chunk-4-1.png)<!-- -->

Die Farbe der Balken wird mit `col` und die Farbe der Umrandung mit `border` festgelegt. Um sich alle Basisfarben anzeigen zu lassen, kann die Funktion `colors()` genutzt werden. 


``` r
colors()   # Anzeigen aller Basisfarben
```

```
##   [1] "white"                "aliceblue"            "antiquewhite"         "antiquewhite1"       
##   [5] "antiquewhite2"        "antiquewhite3"        "antiquewhite4"        "aquamarine"          
##   [9] "aquamarine1"          "aquamarine2"          "aquamarine3"          "aquamarine4"         
##  [13] "azure"                "azure1"               "azure2"               "azure3"              
##  [17] "azure4"               "beige"                "bisque"               "bisque1"             
##  [21] "bisque2"              "bisque3"              "bisque4"              "black"               
##  [25] "blanchedalmond"       "blue"                 "blue1"                "blue2"               
##  [29] "blue3"                "blue4"                "blueviolet"           "brown"               
##  [33] "brown1"               "brown2"               "brown3"               "brown4"              
##  [37] "burlywood"            "burlywood1"           "burlywood2"           "burlywood3"          
##  [41] "burlywood4"           "cadetblue"            "cadetblue1"           "cadetblue2"          
##  [45] "cadetblue3"           "cadetblue4"           "chartreuse"           "chartreuse1"         
##  [49] "chartreuse2"          "chartreuse3"          "chartreuse4"          "chocolate"           
##  [53] "chocolate1"           "chocolate2"           "chocolate3"           "chocolate4"          
##  [57] "coral"                "coral1"               "coral2"               "coral3"              
##  [61] "coral4"               "cornflowerblue"       "cornsilk"             "cornsilk1"           
##  [65] "cornsilk2"            "cornsilk3"            "cornsilk4"            "cyan"                
##  [69] "cyan1"                "cyan2"                "cyan3"                "cyan4"               
##  [73] "darkblue"             "darkcyan"             "darkgoldenrod"        "darkgoldenrod1"      
##  [77] "darkgoldenrod2"       "darkgoldenrod3"       "darkgoldenrod4"       "darkgray"            
##  [81] "darkgreen"            "darkgrey"             "darkkhaki"            "darkmagenta"         
##  [85] "darkolivegreen"       "darkolivegreen1"      "darkolivegreen2"      "darkolivegreen3"     
##  [89] "darkolivegreen4"      "darkorange"           "darkorange1"          "darkorange2"         
##  [93] "darkorange3"          "darkorange4"          "darkorchid"           "darkorchid1"         
##  [97] "darkorchid2"          "darkorchid3"          "darkorchid4"          "darkred"             
## [101] "darksalmon"           "darkseagreen"         "darkseagreen1"        "darkseagreen2"       
## [105] "darkseagreen3"        "darkseagreen4"        "darkslateblue"        "darkslategray"       
## [109] "darkslategray1"       "darkslategray2"       "darkslategray3"       "darkslategray4"      
## [113] "darkslategrey"        "darkturquoise"        "darkviolet"           "deeppink"            
## [117] "deeppink1"            "deeppink2"            "deeppink3"            "deeppink4"           
## [121] "deepskyblue"          "deepskyblue1"         "deepskyblue2"         "deepskyblue3"        
## [125] "deepskyblue4"         "dimgray"              "dimgrey"              "dodgerblue"          
## [129] "dodgerblue1"          "dodgerblue2"          "dodgerblue3"          "dodgerblue4"         
## [133] "firebrick"            "firebrick1"           "firebrick2"           "firebrick3"          
## [137] "firebrick4"           "floralwhite"          "forestgreen"          "gainsboro"           
## [141] "ghostwhite"           "gold"                 "gold1"                "gold2"               
## [145] "gold3"                "gold4"                "goldenrod"            "goldenrod1"          
## [149] "goldenrod2"           "goldenrod3"           "goldenrod4"           "gray"                
## [153] "gray0"                "gray1"                "gray2"                "gray3"               
## [157] "gray4"                "gray5"                "gray6"                "gray7"               
## [161] "gray8"                "gray9"                "gray10"               "gray11"              
## [165] "gray12"               "gray13"               "gray14"               "gray15"              
## [169] "gray16"               "gray17"               "gray18"               "gray19"              
## [173] "gray20"               "gray21"               "gray22"               "gray23"              
## [177] "gray24"               "gray25"               "gray26"               "gray27"              
## [181] "gray28"               "gray29"               "gray30"               "gray31"              
## [185] "gray32"               "gray33"               "gray34"               "gray35"              
## [189] "gray36"               "gray37"               "gray38"               "gray39"              
## [193] "gray40"               "gray41"               "gray42"               "gray43"              
## [197] "gray44"               "gray45"               "gray46"               "gray47"              
## [201] "gray48"               "gray49"               "gray50"               "gray51"              
## [205] "gray52"               "gray53"               "gray54"               "gray55"              
## [209] "gray56"               "gray57"               "gray58"               "gray59"              
## [213] "gray60"               "gray61"               "gray62"               "gray63"              
## [217] "gray64"               "gray65"               "gray66"               "gray67"              
## [221] "gray68"               "gray69"               "gray70"               "gray71"              
## [225] "gray72"               "gray73"               "gray74"               "gray75"              
## [229] "gray76"               "gray77"               "gray78"               "gray79"              
## [233] "gray80"               "gray81"               "gray82"               "gray83"              
## [237] "gray84"               "gray85"               "gray86"               "gray87"              
## [241] "gray88"               "gray89"               "gray90"               "gray91"              
## [245] "gray92"               "gray93"               "gray94"               "gray95"              
## [249] "gray96"               "gray97"               "gray98"               "gray99"              
## [253] "gray100"              "green"                "green1"               "green2"              
## [257] "green3"               "green4"               "greenyellow"          "grey"                
## [261] "grey0"                "grey1"                "grey2"                "grey3"               
## [265] "grey4"                "grey5"                "grey6"                "grey7"               
## [269] "grey8"                "grey9"                "grey10"               "grey11"              
## [273] "grey12"               "grey13"               "grey14"               "grey15"              
## [277] "grey16"               "grey17"               "grey18"               "grey19"              
## [281] "grey20"               "grey21"               "grey22"               "grey23"              
## [285] "grey24"               "grey25"               "grey26"               "grey27"              
## [289] "grey28"               "grey29"               "grey30"               "grey31"              
## [293] "grey32"               "grey33"               "grey34"               "grey35"              
## [297] "grey36"               "grey37"               "grey38"               "grey39"              
## [301] "grey40"               "grey41"               "grey42"               "grey43"              
## [305] "grey44"               "grey45"               "grey46"               "grey47"              
## [309] "grey48"               "grey49"               "grey50"               "grey51"              
## [313] "grey52"               "grey53"               "grey54"               "grey55"              
## [317] "grey56"               "grey57"               "grey58"               "grey59"              
## [321] "grey60"               "grey61"               "grey62"               "grey63"              
## [325] "grey64"               "grey65"               "grey66"               "grey67"              
## [329] "grey68"               "grey69"               "grey70"               "grey71"              
## [333] "grey72"               "grey73"               "grey74"               "grey75"              
## [337] "grey76"               "grey77"               "grey78"               "grey79"              
## [341] "grey80"               "grey81"               "grey82"               "grey83"              
## [345] "grey84"               "grey85"               "grey86"               "grey87"              
## [349] "grey88"               "grey89"               "grey90"               "grey91"              
## [353] "grey92"               "grey93"               "grey94"               "grey95"              
## [357] "grey96"               "grey97"               "grey98"               "grey99"              
## [361] "grey100"              "honeydew"             "honeydew1"            "honeydew2"           
## [365] "honeydew3"            "honeydew4"            "hotpink"              "hotpink1"            
## [369] "hotpink2"             "hotpink3"             "hotpink4"             "indianred"           
## [373] "indianred1"           "indianred2"           "indianred3"           "indianred4"          
## [377] "ivory"                "ivory1"               "ivory2"               "ivory3"              
## [381] "ivory4"               "khaki"                "khaki1"               "khaki2"              
## [385] "khaki3"               "khaki4"               "lavender"             "lavenderblush"       
## [389] "lavenderblush1"       "lavenderblush2"       "lavenderblush3"       "lavenderblush4"      
## [393] "lawngreen"            "lemonchiffon"         "lemonchiffon1"        "lemonchiffon2"       
## [397] "lemonchiffon3"        "lemonchiffon4"        "lightblue"            "lightblue1"          
## [401] "lightblue2"           "lightblue3"           "lightblue4"           "lightcoral"          
## [405] "lightcyan"            "lightcyan1"           "lightcyan2"           "lightcyan3"          
## [409] "lightcyan4"           "lightgoldenrod"       "lightgoldenrod1"      "lightgoldenrod2"     
## [413] "lightgoldenrod3"      "lightgoldenrod4"      "lightgoldenrodyellow" "lightgray"           
## [417] "lightgreen"           "lightgrey"            "lightpink"            "lightpink1"          
## [421] "lightpink2"           "lightpink3"           "lightpink4"           "lightsalmon"         
## [425] "lightsalmon1"         "lightsalmon2"         "lightsalmon3"         "lightsalmon4"        
## [429] "lightseagreen"        "lightskyblue"         "lightskyblue1"        "lightskyblue2"       
## [433] "lightskyblue3"        "lightskyblue4"        "lightslateblue"       "lightslategray"      
## [437] "lightslategrey"       "lightsteelblue"       "lightsteelblue1"      "lightsteelblue2"     
## [441] "lightsteelblue3"      "lightsteelblue4"      "lightyellow"          "lightyellow1"        
## [445] "lightyellow2"         "lightyellow3"         "lightyellow4"         "limegreen"           
## [449] "linen"                "magenta"              "magenta1"             "magenta2"            
## [453] "magenta3"             "magenta4"             "maroon"               "maroon1"             
## [457] "maroon2"              "maroon3"              "maroon4"              "mediumaquamarine"    
## [461] "mediumblue"           "mediumorchid"         "mediumorchid1"        "mediumorchid2"       
## [465] "mediumorchid3"        "mediumorchid4"        "mediumpurple"         "mediumpurple1"       
## [469] "mediumpurple2"        "mediumpurple3"        "mediumpurple4"        "mediumseagreen"      
## [473] "mediumslateblue"      "mediumspringgreen"    "mediumturquoise"      "mediumvioletred"     
## [477] "midnightblue"         "mintcream"            "mistyrose"            "mistyrose1"          
## [481] "mistyrose2"           "mistyrose3"           "mistyrose4"           "moccasin"            
## [485] "navajowhite"          "navajowhite1"         "navajowhite2"         "navajowhite3"        
## [489] "navajowhite4"         "navy"                 "navyblue"             "oldlace"             
## [493] "olivedrab"            "olivedrab1"           "olivedrab2"           "olivedrab3"          
## [497] "olivedrab4"           "orange"               "orange1"              "orange2"             
## [501] "orange3"              "orange4"              "orangered"            "orangered1"          
## [505] "orangered2"           "orangered3"           "orangered4"           "orchid"              
## [509] "orchid1"              "orchid2"              "orchid3"              "orchid4"             
## [513] "palegoldenrod"        "palegreen"            "palegreen1"           "palegreen2"          
## [517] "palegreen3"           "palegreen4"           "paleturquoise"        "paleturquoise1"      
## [521] "paleturquoise2"       "paleturquoise3"       "paleturquoise4"       "palevioletred"       
## [525] "palevioletred1"       "palevioletred2"       "palevioletred3"       "palevioletred4"      
## [529] "papayawhip"           "peachpuff"            "peachpuff1"           "peachpuff2"          
## [533] "peachpuff3"           "peachpuff4"           "peru"                 "pink"                
## [537] "pink1"                "pink2"                "pink3"                "pink4"               
## [541] "plum"                 "plum1"                "plum2"                "plum3"               
## [545] "plum4"                "powderblue"           "purple"               "purple1"             
## [549] "purple2"              "purple3"              "purple4"              "red"                 
## [553] "red1"                 "red2"                 "red3"                 "red4"                
## [557] "rosybrown"            "rosybrown1"           "rosybrown2"           "rosybrown3"          
## [561] "rosybrown4"           "royalblue"            "royalblue1"           "royalblue2"          
## [565] "royalblue3"           "royalblue4"           "saddlebrown"          "salmon"              
## [569] "salmon1"              "salmon2"              "salmon3"              "salmon4"             
## [573] "sandybrown"           "seagreen"             "seagreen1"            "seagreen2"           
## [577] "seagreen3"            "seagreen4"            "seashell"             "seashell1"           
## [581] "seashell2"            "seashell3"            "seashell4"            "sienna"              
## [585] "sienna1"              "sienna2"              "sienna3"              "sienna4"             
## [589] "skyblue"              "skyblue1"             "skyblue2"             "skyblue3"            
## [593] "skyblue4"             "slateblue"            "slateblue1"           "slateblue2"          
## [597] "slateblue3"           "slateblue4"           "slategray"            "slategray1"          
## [601] "slategray2"           "slategray3"           "slategray4"           "slategrey"           
## [605] "snow"                 "snow1"                "snow2"                "snow3"               
## [609] "snow4"                "springgreen"          "springgreen1"         "springgreen2"        
## [613] "springgreen3"         "springgreen4"         "steelblue"            "steelblue1"          
## [617] "steelblue2"           "steelblue3"           "steelblue4"           "tan"                 
## [621] "tan1"                 "tan2"                 "tan3"                 "tan4"                
## [625] "thistle"              "thistle1"             "thistle2"             "thistle3"            
## [629] "thistle4"             "tomato"               "tomato1"              "tomato2"             
## [633] "tomato3"              "tomato4"              "turquoise"            "turquoise1"          
## [637] "turquoise2"           "turquoise3"           "turquoise4"           "violet"              
## [641] "violetred"            "violetred1"           "violetred2"           "violetred3"          
## [645] "violetred4"           "wheat"                "wheat1"               "wheat2"              
## [649] "wheat3"               "wheat4"               "whitesmoke"           "yellow"              
## [653] "yellow1"              "yellow2"              "yellow3"              "yellow4"             
## [657] "yellowgreen"
```

Es gibt verschiedene Versionen von Türkis. Ich entscheide mich hier an dieser Stelle für `turquoise3`. 


``` r
# Histogramm mit angepasster Skalierung der x-Achse und Farbe der Umrandung
hist(data$Total_Mindset, 
     main = "Histogramm der Variable Total Mindset",
     xlab = "Total Mindset",
     ylab = "Häufigkeit",
     xlim = c(15, 45),
     border = "turquoise3") 
```

![](/fdz-plots-lm-loesungen_files/unnamed-chunk-6-1.png)<!-- -->

</details>



2. Zeichnen Sie ein Balkendiagramm für die Variable `Achiever`. Färben Sie dabei jeden Balken in einer der Regenbogenpalette `rainbow()`.

<details><summary>Lösung</summary>

Zunächst einmal sollten wir uns anschauen, wie viele Kategorien die Variable `Achiever` hat. Dies kann mit der Funktion `table()` erreicht werden. Wenn man nicht selbst zählen möchte, kann man auch die Funktion `length()` nutzen, um die Anzahl der Kategorien zu erhalten.


``` r
###### Aufgabe 2 ------
table(data$Achiever) # Überblick über die Kategorien
```

```
## 
##   High Achiever    Low Achiever Medium Achiever 
##              90               2             208
```

``` r
length(table(data$Achiever)) # Anzahl der Kategorien
```

```
## [1] 3
```

Die Funktion `barplot()` wird genutzt, um ein Balkendiagramm zu erstellen. Die Farben der Balken werden mit `col` festgelegt. In der Funktion `rainbow()` wird die Anzahl der Farben angegeben, die genutzt werden sollen. 


``` r
# Balkendiagramm mit Regenbogenfarben
barplot(table(data$Achiever), 
        main = "Balkendiagramm der Variable Achiever",
        xlab = "Achiever",
        ylab = "Häufigkeit",
        col = rainbow(3)) 
```

![](/fdz-plots-lm-loesungen_files/unnamed-chunk-8-1.png)<!-- -->

</details>

3. In der Funktion `boxplot()` kann die Ausrichtung des Boxplots (vertikal, horizontal) und auch die Darstellung der Ausreißer verändert werden. Zeichnen Sie einen horizontalen Boxplot für die Variable `Total_Competence_Maths` und unterdrücken Sie die Darstellung der Ausreißer.

<details><summary>Lösung</summary>

Die passenden Argumente zur Aufgabe heißen `horizontal` und `outline` und können beide entweder auf `TRUE` oder `FALSE` gesetzt werden.


``` r
###### Aufgabe 3 ------
# Keine Darstellung der Ausreißer und horizontaler Boxplot
boxplot(data$Total_Competence_Maths, 
        main = "Boxplot der Variable Total Mindset",
        horizontal = T,
        outline = F)     
```

![](/fdz-plots-lm-loesungen_files/unnamed-chunk-9-1.png)<!-- -->

Wie wir sehen, geht der Boxplot jetzt nur von 2 bis 5 - die Zeichnung der Ausreißer mit dem Wert von 1 wurde unterdrückt.

</details>

4. Zeichnen Sie einen Scatterplot für den Zusammenhang der Variablen `Total_Mindset` und `Total_SelfConcept`. Passen Sie die Form (Dreiecke) und Farbe der (Grün) der Punkte an.


<details><summary>Lösung</summary>

Die nötigen Argumente im `plot()` Befehl sind `pch` für die Form der Punkte und `col` für die Farbe der Punkte. Für Dreiecke muss das Argument `pch` auf 2 gesetzt werden. Grün ist eine der Basisfarben und kann direkt als Zeichenkette `green` übergeben werden.


``` r
###### Aufgabe 4 ------
# Scatterplot mit angepasster Form und Farbe der Punkte
plot(data$Total_Mindset, 
     data$Total_SelfConcept, 
     main = "Scatterplot der Variablen Total Mindset und Total SelfConcept",
     xlab = "Total Mindset",
     ylab = "Total SelfConcept",
     pch = 2, # Form der Punkte
     col = "green") # Farbe der Punkte
```

![](/fdz-plots-lm-loesungen_files/unnamed-chunk-10-1.png)<!-- -->


</details>



## Teil 2 - Lineare Modelle

1. In Teil 1 haben wir gelernt, dass die Funktion `boxplot()` genutzt werden kann, um Boxplots zu erstellen. Erstellen Sie im Zusammenspiel mit der Syntax, die Sie in Teil 2 gelernt haben einen gruppierten Boxplot, der die Verteilung von `Total_Competence_Maths` in den Gruppen von `Gender` zeigt.

<details><summary>Lösung</summary>

Die Funktion `boxplot()` kann auch genutzt werden, um gruppierte Boxplots zu erstellen. Dazu wird die Variable, die gruppiert werden soll, als erstes Argument übergeben. Die Gruppierungsvariable wird als zweites Argument übergeben. Getrennt werden diese durch die auch in der Regression verwendeten `~`.


``` r
##### Teil 2 -----
###### Aufgabe 1 ------
# Gruppierte Boxplots
boxplot(data$Total_Competence_Maths ~ data$Gender, 
        main = "Gruppierte Boxplots der Variable Total Competence Maths",
        xlab = "Gender",
        ylab = "Total Competence Maths") 
```

![](/fdz-plots-lm-loesungen_files/unnamed-chunk-11-1.png)<!-- -->

</details>

2. Erstellen Sie eine multiple Regression mit `Science_AttainmentData` als abhängiger Variable. Prädiktoren sollen `Total_Competence` und `Total_Mindset` sein. Wie ist das Regressionsgewicht von `Total_Competence` in diesem Fall und welcher p-Wert wird ihm zugeschrieben?  

<details><summary>Lösung</summary>

Die Funktion `lm()` wird genutzt, um ein Regressionsmodell zu erstellen. Die abhängige Variable wird als erstes Argument übergeben, die Prädiktoren als zweites Argument. Getrennt werden diese durch `~`.



``` r
###### Aufgabe 2 ------
# Regressionsmodell aufstellen
mod <- lm(Total_Competence_Science ~ Total_Competence + Total_Mindset, data = data)
```

Um die weiteren Informationen zu erhalten, wird die Funktion `summary()` genutzt.


``` r
summary(mod)    # Zusammenfassung des Modells
```

```
## 
## Call:
## lm(formula = Total_Competence_Science ~ Total_Competence + Total_Mindset, 
##     data = data)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -2.05869 -0.44840 -0.05825  0.46769  1.94088 
## 
## Coefficients:
##                   Estimate Std. Error t value Pr(>|t|)    
## (Intercept)      -0.842347   0.301379  -2.795  0.00554 ** 
## Total_Competence  1.166508   0.061782  18.881  < 2e-16 ***
## Total_Mindset     0.000437   0.009357   0.047  0.96278    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6541 on 288 degrees of freedom
##   (9 observations deleted due to missingness)
## Multiple R-squared:  0.589,	Adjusted R-squared:  0.5862 
## F-statistic: 206.4 on 2 and 288 DF,  p-value: < 2.2e-16
```

</details>

3. Finden Sie mit Hilfe des Internets heraus, wie standardisierte Regressionsparameter mit Hilfe einer Funktion aus einem noch nicht verwendeten Paket ausgegeben werden können.

<details><summary>Lösung</summary>

Die Funktion `lm.beta()` aus dem Paket `lm.beta` kann genutzt werden, um standardisierte Regressionsparameter zu erhalten. Zuerst muss das Paket installiert werden.


``` r
###### Aufgabe 3 ------
install.packages("lm.beta") # Paket installieren
```

Anschließend kann das Paket aktiviert werden.


``` r
library(lm.beta) # Paket laden
```

Mit der Funktion `lm.beta()` kann das Modell analysiert werden. Am besten sollte noch die Funktion `summary()` genutzt werden, um die Ergebnisse übersichtlich darzustellen.


``` r
mod |> lm.beta() |> summary()   # Standardisierte Regressionsparameter
```

```
## 
## Call:
## lm(formula = Total_Competence_Science ~ Total_Competence + Total_Mindset, 
##     data = data)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -2.05869 -0.44840 -0.05825  0.46769  1.94088 
## 
## Coefficients:
##                   Estimate Standardized Std. Error t value Pr(>|t|)    
## (Intercept)      -0.842347           NA   0.301379  -2.795  0.00554 ** 
## Total_Competence  1.166508     0.766795   0.061782  18.881  < 2e-16 ***
## Total_Mindset     0.000437     0.001897   0.009357   0.047  0.96278    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6541 on 288 degrees of freedom
##   (9 observations deleted due to missingness)
## Multiple R-squared:  0.589,	Adjusted R-squared:  0.5862 
## F-statistic: 206.4 on 2 and 288 DF,  p-value: < 2.2e-16
```

Der Output aus der Funktion `summary()` hat sich bei den Koeffizienten um eine Zeile erweitert.

</details>

4. Diese Aufgabe ist nur zur Veranschaulichung der Syntax - keine Empfehlung für solch ein Modell: Als zuästzlicher Prädiktor soll `Total_SelfConcept` hinzugefügt werden. Außerdem soll die Dreifachinteraktion der Prädiktoren aufgenommen werden, aber keine Interaktionen zwischen zwei Prädiktoren.

<details><summary>Lösung</summary>

Hier lohnt es sich zunächst, zentrierte Versionen der Prädiktoren zu erstellen.


``` r
###### Aufgabe 4 ------
# Zentrierte Prädiktoren erstellen
data$Total_Competence_center <- scale(data$Total_Competence, center = T, scale = F)
data$Total_Mindset_center <- scale(data$Total_Mindset, center = T, scale = F)
data$Total_SelfConcept_center <- scale(data$Total_SelfConcept, center = T, scale = F)
```

Die Funktion `lm()` wird genutzt, um das Modell zu erstellen. Wenn wir die `*`-Notation nutzen, werden alle Interaktionen bis zur dritten Ordnung aufgenommen. 



``` r
# Modell mit Interaktionen bis zur dritten Ordnung
mod_falsch <- lm(Total_Competence_Science ~ Total_Competence_center * Total_Mindset_center * Total_SelfConcept_center, data = data)
```

In der Aufgabenstellung ist explizit nur die Interaktion der dritten Ordnung gewünscht. Daher sollte die `:`-Notation genutzt werden.


``` r
# Modell mit den spezifisch gewünschten Interaktionen
mod_korrekt <- lm(Total_Competence_Science ~ Total_Competence_center + Total_Mindset_center + Total_SelfConcept_center + Total_Competence_center:Total_Mindset_center:Total_SelfConcept_center, data = data)
```

Anmerkung: Es ist empfehlenswert, keine Modelle zu bestimmen, in denen Interaktionen niedrigerer Ordnung nicht drin sind. Wie gesagt war das Beispiel nur zur Veranschaulichung der Syntax.

</details>
