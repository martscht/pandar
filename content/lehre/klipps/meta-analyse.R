## source('https://pandar.netlify.app/daten/Data_Processing_game.R')
source('../../daten/Data_Processing_game.R')

# Anzahl der Studien im Datensatz
unique(game$cite) |> length()

# Effektstärke für Wölfling et al. (2019)
wolf <- data.frame(
  occasion = c(1, 2),
  tr_mean = c(5.7, 4.6),
  ct_mean = c(11.4, 10.5),
  tr_sd = c(3.99, 3.46),
  ct_sd = c(4.70, 4.33),
  tr_n = c(72, 72),
  ct_n = c(71, 71)
)

wolf

# Paket laden
library(esc)

# Effektstärke berechnen
with(wolf[1, ],          # Datensatz, 1. MZP auswählen
  esc_mean_sd(
    grp1m = tr_mean,     # Mittelwert der Interventionsgruppe
    grp1sd = tr_sd,      # Standardabweichung der Interventionsgruppe
    grp1n = tr_n,        # Stichprobengröße der Interventionsgruppe
    grp2m = ct_mean,     # Mittelwert der Kontrollgruppe
    grp2sd = ct_sd,      # Standardabweichung der Kontrollgruppe
    grp2n = ct_n,        # Stichprobengröße der Kontrollgruppe
  )
)

# Hedges g berechnen
with(wolf[1, ],          # Datensatz, 1. MZP auswählen
  esc_mean_sd(
    grp1m = tr_mean,     # Mittelwert der Interventionsgruppe
    grp1sd = tr_sd,      # Standardabweichung der Interventionsgruppe
    grp1n = tr_n,        # Stichprobengröße der Interventionsgruppe
    grp2m = ct_mean,     # Mittelwert der Kontrollgruppe
    grp2sd = ct_sd,      # Standardabweichung der Kontrollgruppe
    grp2n = ct_n,        # Stichprobengröße der Kontrollgruppe
    es.type = 'g'        # Effektstärke Hedge's g
  )
)

# Effektstärke für Wölfling et al. (2019) im Datensatz
game[game$cite == 'Woelfling et al. (2019)', ]

# Post-Messungen
post <- subset(game, game$follow == 0)

# Mittelwert der Effekte
mean(post$es)
