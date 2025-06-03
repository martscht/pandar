# Daten einlesen und vorbereiten ----
lockdown <- read.csv(url("https://osf.io/dc6me/download"))

# Entfernen der Personen, für die weniger als zwei Messpunkte vorhanden sind
# (Auschluss von Fällen, deren ID nur einmal vorkommt)
lockdown <- lockdown[-which(lockdown$ID %in% names(which(table(lockdown$ID)==1))),] 

# Eine Beobachtung pro Person zufällig auswählen
lockdown_tmp <- lockdown[FALSE, ]

set.seed(12345)
for (looping_identifier in unique(lockdown$ID)) {
  tmp_individual <- lockdown[lockdown$ID == looping_identifier, ]
  if (nrow(tmp_individual) > 1) {
    tmp_individual <- tmp_individual[sample(nrow(tmp_individual), 1), ]
  }
  lockdown_tmp <- rbind(lockdown_tmp, tmp_individual)
}

# Relevante variablen auswählen
lockdown <- lockdown_tmp
rm(lockdown_tmp, tmp_individual, looping_identifier)

# Daten aufbereiten, Variablen auswählen extrahieren und in Nummern umwandeln
# Entfernen von Minderjährigen & unbestimmtes Gender mit den Funktionen filter() und select () aus dplyr.
lockdown <- lockdown |>
  subset(((Age >= 18) & (Gender == 1 | Gender == 2)), 
  select=c("Time", "Age", "Gender", "EWB", "PWB", "SWB",
    "IWB","E.threat","H.threat", "Optimism",
    "Self.efficacy","Hope","P.Wisdom","ST.Wisdom","Grat.being",
    "Grat.world","PD","Acc"))