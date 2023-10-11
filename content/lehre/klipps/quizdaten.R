knitr::opts_chunk$set(echo = TRUE, fig.align = "center")

## load("C:/Users/Musterfrau/Desktop/Behandlungsform.rda")

## load(url("https://pandar.netlify.app/daten/Behandlungsform.rda"))

## source(url("https://pandar.netlify.app/lehre/klipps/preprocessing/Data_Processing_Quiz1.R"))

## library(dplyr)
## library(ICC)
## library(lme4)
## library(interactions)

## # Daten einlesen und vorbereiten
## lockdown <- read.csv(url("https://osf.io/dc6me/download"))
## 
## # Entfernen der Personen, für die weniger als zwei Messpunkte vorhanden sind
## # (Auschluss von Fällen, deren ID nur einmal vorkommt)
## lockdown <- lockdown[-which(lockdown$ID %in% names(which(table(lockdown$ID)==1))),]
## 
## # Daten aufbereiten, Variablen auswählen extrahieren und in Nummern umwandeln
## # Entfernen von Minderjährigen & unbestimmtes Gender mit den Funktionen filter() und select () aus dplyr.
## lockdown <- lockdown %>%
##   filter((Age >= 18) & (Gender == 1 | Gender == 2)) %>%
##   select(c("ID", "Wave", "Age", "Gender", "Income", "EWB","PWB","SWB",
##            "IWB","E.threat","H.threat", "Optimism",
##            "Self.efficacy","Hope","P.Wisdom","ST.Wisdom","Grat.being",
##            "Grat.world","PD","Acc","Time","EWB.baseline","PWB.baseline",
##            "SWB.baseline","IWB.baseline"))
## 
## # Standardisieren der AVs
## lockdown[,c("EWB", "PWB", "SWB", "IWB")] <- scale(lockdown[,c("EWB", "PWB", "SWB", "IWB")])
## # Standardisieren möglicher Prädiktoren
## lockdown[,c("E.threat", "H.threat", "Optimism", "Self.efficacy", "Hope", "P.Wisdom",
##             "ST.Wisdom", "Grat.being", "Grat.world")] <-
##   scale(lockdown[,c("E.threat", "H.threat", "Optimism", "Self.efficacy", "Hope", "P.Wisdom",
##             "ST.Wisdom", "Grat.being", "Grat.world")])
## 
## # ID in Faktor Umwandeln
## lockdown$ID <- as.factor(lockdown$ID)

library(metafor)

load(url('https://pandar.netlify.app/lehre/klipps/preprocessing/reliabilites.molloy2014.rda'))

data_combined <- dat.molloy2014
data_combined$rel1 <- reliabilites.molloy2014$RelGewissenhaftigkeit
data_combined$rel2 <- reliabilites.molloy2014$RelCondition
head(data_combined)

knitr::kable(head(data_combined))

## load(url("https://pandar.netlify.app/post/Preprocessing/C19PRC.RData"))

## library(qgraph)
## library(bootnet)

## burnout <- read.csv(file = url("https://osf.io/qev5n/download"))

## burnout <- burnout[2:8]

## source(url("https://pandar.netlify.app/lehre/klipps/preprocessing/Data_Processing_Quiz4b.R"))
