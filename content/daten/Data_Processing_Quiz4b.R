######### Datenaufbereitungsskript von Kai Nehler

# Laden der Daten
load(url("https://osf.io/5a2ub/download"))

# Daten muessen fuer weitere Bearbeitung reduziert werden auf eine Person
data <- Data2[Data2$id==10,]

# Undeutliche Variablennamen werden ueberschrieben
names(data)[2:19] <- c("Relax","Irritable","Worry","Nervous","Future","Anhedonia",
                        "Tired","Hungry","Alone","Angry","Social_offline","Social_online","Music",
                        "Procrastinate","Outdoors","C19_occupied","C19_worry","Home")

# Ausschluss von Spalten auf Grundlage des Originalpapers
data <- data[,! names(data) %in% c("Hungry", "Angry", "Music", "Procrastinate")]

# Vorbereitung Namensvektor der wichtigen Variablen fürs Netzwerk
rel_vars <- c("Relax","Irritable","Worry","Nervous","Future","Anhedonia",
              "Tired","Alone","Social_offline","Social_online",
              "Outdoors","C19_occupied","C19_worry","Home")

# Detrending mit for loop
for (v in seq_along(rel_vars)){

  # Regression auf Variable conc, die am ehesten die Zeit symbolisiert
  # genauer wäre natürlich eine Zeitvariable, aber die liegt in diesem Satz nicht vor
  lm_form <- as.formula(paste0(rel_vars[[v]], "~ conc"))

  # lineares Modell rechnen für jede einzelne Variable
  lm_res <- summary(lm(lm_form, data = data))

  # wenn der Zeittrend signifikant ist, detrenden wir mit den Residuen
  # [,4] greift auf die Spalte der p-Werte zu
  # [2] auf den p-Wert des Regressionsgewichts des Datums
  # wenn dieser also kleiner als 0.05 ist, wird Befehl danach ausgeführt
  if(lm_res$coefficients[,4][2] < 0.05){
    # in Konsole wird gezeigt, wenn eine Variable detrended wird
    print(paste0("Detrende Variable: ", rel_vars[v]))
    # Variable wird mit dem Residuum aus der Regression auf die Zeit überschrieben
    # also bleibt nur der Teil, der nicht durch die Zeit erklärt werden kann
    # demnach der Stationäre Anteil der jeweiligen Variable
    data[!is.na(data[rel_vars[v]]),rel_vars[v]] <- residuals(lm_res)
  }
}

# Unaufbereiteten Datensatz entfernen
rm(Data2)
# Unnötige Reste des Detrendings entfernen
rm(v, lm_res, lm_form)
