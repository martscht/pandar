# Daten einlesen und vorbereiten ----
lockdown <- read.csv(url("https://osf.io/dc6me/download"))

# Entfernen der Personen, für die weniger als zwei Messpunkte vorhanden sind
# (Auschluss von Fällen, deren ID nur einmal vorkommt)
lockdown <- lockdown[-which(lockdown$ID %in% names(which(table(lockdown$ID)==1))),] 

# Daten aufbereiten, Variablen auswählen extrahieren und in Nummern umwandeln
# Entfernen von Minderjährigen & unbestimmtes Gender mit den Funktionen filter() und select () aus dplyr.
lockdown <- lockdown |>
  subset(((Age >= 18) & (Gender == 1 | Gender == 2)), 
  select=c("ID", "Wave", "Age", "Gender", "Income", "EWB","PWB","SWB",
    "IWB","E.threat","H.threat", "Optimism",
    "Self.efficacy","Hope","P.Wisdom","ST.Wisdom","Grat.being",
    "Grat.world","PD","Acc","Time","EWB.baseline","PWB.baseline",
    "SWB.baseline","IWB.baseline"))

# Standardisieren der AVs
lockdown[,c("EWB", "PWB", "SWB", "IWB")] <- scale(lockdown[,c("EWB", "PWB", "SWB", "IWB")])
# Standardisieren möglicher Prädiktoren
lockdown[,c("E.threat", "H.threat", "Optimism", "Self.efficacy", "Hope", "P.Wisdom", 
  "ST.Wisdom", "Grat.being", "Grat.world")] <-
  scale(lockdown[,c("E.threat", "H.threat", "Optimism", "Self.efficacy", "Hope", "P.Wisdom", 
    "ST.Wisdom", "Grat.being", "Grat.world")])

#ID in Faktor umwandeln
lockdown$ID <- as.factor(lockdown$ID)
