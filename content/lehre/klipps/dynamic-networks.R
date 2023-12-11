# Vorbereitungen
knitr::opts_chunk$set(echo = TRUE, fig.align = "center")

data <- read.csv(url("https://osf.io/g6ya4/download"))

names(data)

data$time

data$time <- as.POSIXct(data$time, tz = "Europe/Amsterdam")
data$time[1:8]

library(qgraph)
library(bootnet)
rel_vars <- c("relaxed","sad","nervous","concentration","tired","rumination","bodily.discomfort")
data$date <- as.Date(data$time, tz = "Europe/Amsterdam")
res <- bootnet::estimateNetwork(data = data,
                                default = "graphicalVAR",   # verwendetes Package
                                vars = rel_vars,            # Variablennamen
                                dayvar = "date",             # Tagesvariable
                                tuning = 0,                 # EBIC Tuningparameter
                                nLambda  = 25)              # Anzahl getesteter LASSO Tuningparameter (hier niedrig um Zeit zu sparen, default ist 100)

net_temp <- graphicalVAR:::computePDC(res$results$allResults[[400]]$beta, res$results$allResults[[400]]$kappa)

qgraph::qgraph(net_temp)

net_cont <- qgraph::wi2net(res$results$allResults[[19]]$kappa)

qgraph::qgraph(net_cont)

lm_tired <- lm(tired ~ time, data = data)

summary(lm_tired)

data[!is.na(data["tired"]),"tired"] <- residuals(lm_tired) 

rel_vars <- c("relaxed","sad","nervous","concentration","tired","rumination","bodily.discomfort")


for (v in 1:length(rel_vars)){
  # Respektive Variable auf die Zeit regressieren
  lm_form <- as.formula(paste0(rel_vars[v], "~ time"))
  # lineares Modell rechnen
  lm_res <- summary(lm(lm_form, data = data))
  # wenn der Zeittrend signifikant ist, detrenden wir mit den Residuen
  # [,4] greift auf die Spalte der p-Werte zu
  # [2] auf den p-Wert des Regressionsgewichts des Datums
  if(lm_res$coefficients[,4][2] < 0.05){
    print(paste0("Detrende Variable: ", rel_vars[v]))
    data[!is.na(data[rel_vars[v]]),rel_vars[v]] <- residuals(lm_res)
  }
}

data$date <- as.Date(data$time, tz = "Europe/Amsterdam")

data$beep <- rep(1:5, 14)

# Starte Loop für einzigartige Daten
for (i in unique(data$date)){
  
  # Schreibe alle Messungen eines Tages einen getrennten Datensatz
  set <- data[data$date == i,]
  
  # Schaue in diesem Datensatz die Ordnung der Zeit-Variable an
  # Schreib die zugehörige Zahl in der Reihenfolge in den Original-Datensatz
  data$beep[data$date==i] <- order(set$time)
}

## install.packages("graphicalVAR")

library(qgraph)
library(bootnet)

res <- estimateNetwork(data = data,
                                default = "graphicalVAR",   # verwendetes Package
                                vars = rel_vars,            # Variablennamen
                                dayvar = "date",            # Tagesvariable
                                beepvar = "beep",           # Notifikation
                                tuning = 0,                 # EBIC Tuningparameter
                                nLambda  = 25)              # Anzahl getesteter LASSO Tuningparameter 

res$graph

Layout <- averageLayout(res$graph$temporal, 
                        res$graph$contemporaneous)

plot(res, graph = "temporal", layout = Layout, 
     title = "Temporal")
plot(res, graph = "contemporaneous", layout = Layout, 
     title = "Contemporaneous")
