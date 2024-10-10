# Einlesen des Datensatzes aus WiSe 22
load(url('https://pandar.netlify.app/daten/fb22.rda'))

# Nur die interessierenden Variablen reinnehmen
fb22 <- subset(fb22, select = c(geschl, job, extra, intel))
fb22 <- na.omit(fb22) # Entfernen der Beobachtungen mit NAs

# Geschlecht als Faktor
fb22$geschl <- factor(fb22$geschl, levels = c(1, 2,3 ), 
                      labels = c("weiblich", "männlich", "anderes"))

# Job als Faktor
fb22$job <- factor(fb22$job, levels = c(1, 2),
                   labels = c("nein", "ja"))

# Häufigkeitstabelle Merkmal
gender_sample <- table(fb22$geschl) |> prop.table()
gender_sample

job_sample <- table(fb22$job) |> prop.table()
job_sample

# Population der Studierenden in Deutschland 2022
studierende_total <- (1475633) + (1466282)
studierende_frauen <- 1475633

p_w <- (studierende_frauen / studierende_total) # 50.16 %
p_m <- 1 - p_w                                  # 49.84 %

# Geschlecht = "anderes" aus Datensatz inkl. Faktorlabels entfernen
fb22 <- fb22[fb22$geschl != "anderes", ]
fb22$geschl <- droplevels(fb22$geschl)

# OLS-Regression 
mod <- lm(extra ~ intel, fb22)
summary(mod)

# Berechnung der Gewichte
weight_w <- p_w / gender_sample["weiblich"]
weight_m <- p_m / gender_sample["männlich"]

weight_w
weight_m

# Gewichtung nach Geschlecht
fb22$weight_gender <- ifelse(fb22$geschl == "weiblich", weight_w, weight_m)

head(fb22)

# WLS-Regression
mod_gender <- lm(extra ~ intel, fb22, weights = weight_gender)
summary(mod_gender)

summary(mod)$r.squared        # R²
summary(mod_gender)$r.squared # gewichtetes R²

coef(mod)[2]
coef(mod_gender)[2]

# Scatter-Plot mit ggplot2
library(ggplot2)
p <- ggplot(fb22, aes(x = intel, y = extra, color = geschl)) +
  geom_point() +  
  
  # Regressionslinie und SE-Band für mod (ungewichtetes Modell)
  geom_smooth(method = "lm", se = TRUE, aes(color = "ungewichtet"), 
              lty = "dotdash", alpha = 0.2) + # Linientyp und Transparenz für SE
  
  # Regressionslinie und SE-Band für mod_gender (gewichtetes Modell)
  geom_smooth(method = "lm", se = TRUE, 
              aes(weight = weight_gender, color = "gewichtet"), 
              alpha = 0.2) + # Transparenz für SE
  
  labs(x = "Intelligenz", y = "Extraversion", color = "Modell") +  
  theme_minimal() + 
  scale_color_manual(values = c("gewichtet" = "#ad3b76",    # Farben für Legende
                                "ungewichtet" = "#00618F"))

# Plot anzeigen
print(p)

# Scatter-Plot mit ggplot2
library(ggplot2)

# Filter für männliche Beobachtungen
fb22_male <- fb22[fb22$geschl == "männlich", ]

set.seed(36) # Für Reproduzierbarkeit

# "Jitter", um Punkte leicht zu verschieben, damit sie besser sichtbar sind
jitter_width <- 0.1
jitter_height <- 0.1
fb22_male$jittered_intel <- fb22_male$intel + runif(nrow(fb22_male), -jitter_width, jitter_width)
fb22_male$jittered_extra <- fb22_male$extra + runif(nrow(fb22_male), -jitter_height, jitter_height)

# Berechnung der vorhergesagten Werte für die jittered `intel`-Werte
fb22_male$predicted_weighted_jittered <- predict(mod_gender, newdata = data.frame(intel = fb22_male$jittered_intel))

# Extrahieren der Koeffizienten für die Modelle
coef_unweighted <- coef(mod)
coef_weighted <- coef(mod_gender)

# Neuer Plot mit Jitter
p2 <- ggplot(fb22, aes(x = intel, y = extra, color = geschl)) +
  geom_point(position = position_jitter(width = jitter_width, height = jitter_height), 
             alpha = 0.6) + # Transparenz
  
  # Regressionslinie und SE-Band für mod (ungewichtetes Modell)
  geom_smooth(method = "lm", se = F, aes(color = "ungewichtet"), 
              lty = "dotdash", alpha = 0.2) + 
  
  # Regressionslinie und SE-Band für mod_gender (gewichtetes Modell)
  geom_smooth(method = "lm", se = F, 
              aes(weight = weight_gender, color = "gewichtet"), 
              size = 1, alpha = 0.2) + 
  
  # Punkte für männliche Beobachtungen in der Farbe des gewichteten Modells
  geom_point(data = fb22_male, aes(x = jittered_intel, y = jittered_extra), 
             color = "#ad3b76", alpha = 0.6) +
  
  # Residuen für männliche Beobachtungen in der Farbe des gewichteten Modells
  geom_segment(data = fb22_male, 
               aes(x = jittered_intel, xend = jittered_intel, # Beginn und Ende der Linie
                   y = jittered_extra, yend = predicted_weighted_jittered), 
               color = "#ad3b76", linetype = "solid") +
  
  # Hinzufügen erweiterter Reg.linien, die bis zum Rand der Grafik gehen, 
  # für besser Sichtbarkeit
  geom_abline(intercept = coef_unweighted[1], slope = coef_unweighted[2],
              linetype = "dotdash", size = 1, color = "#00618F") +
  geom_abline(intercept = coef_weighted[1], slope = coef_weighted[2],
              size = 1, color = "#ad3b76") + # Dicke und Farbe
  
  labs(x = "Intelligenz", y = "Extraversion", color = "Modell") +  
  theme_minimal() + 
  scale_color_manual(values = c("gewichtet" = "#ad3b76",
                                "ungewichtet" = "#00618F"))

# Plot anzeigen
print(p2)

table(fb22$geschl, fb22$job) |> prop.table() |> round(2)

# Scatter-Plot mit ggplot2

# Filter für männliche Beobachtungen
fb22_male <- fb22[fb22$geschl == "männlich", ]

set.seed(36) # Für Reproduzierbarkeit

# "Jitter", um Punkte leicht zu verschieben, damit sie besser sichtbar sind
jitter_width <- 0.1
jitter_height <- 0.1
fb22_male$jittered_intel <- fb22_male$intel + runif(nrow(fb22_male), -jitter_width, jitter_width)
fb22_male$jittered_extra <- fb22_male$extra + runif(nrow(fb22_male), -jitter_height, jitter_height)

# Berechnung der vorhergesagten Werte für die jittered intel-Werte
fb22_male$predicted_weighted_jittered <- predict(mod_gender, newdata = data.frame(intel = fb22_male$jittered_intel))

# Extrahieren der Koeffizienten für die Modelle
coef_unweighted <- coef(mod)
coef_weighted <- coef(mod_gender)

# Neuer Plot mit Jitter und eingezeichneten Residuen für Männer
p2 <- ggplot(fb22, aes(x = intel, y = extra, color = geschl)) +
  geom_point(position = position_jitter(width = jitter_width, height = jitter_height), 
             alpha = 0.6) + # Transparenz
  
  # Regressionslinie und SE-Band für mod (ungewichtetes Modell)
  # Behalten wir für eine leichtere Darstellung der Legende
  geom_smooth(method = "lm", se = F, aes(color = "ungewichtet"), 
              lty = "dotdash", alpha = 0.2) + # Linientyp und Transparenz des SE-Bandes
  
  # Regressionslinie und SE-Band für mod_gender (gewichtetes Modell)
  geom_smooth(method = "lm", se = F, 
              aes(weight = weight_gender, color = "gewichtet"), 
              size = 1, alpha = 0.2) + 
  
  # Punkte für männliche Beobachtungen in der Farbe des gewichteten Modells
  geom_point(data = fb22_male, aes(x = jittered_intel, y = jittered_extra), 
             color = "#ad3b76", alpha = 0.6) +
  
  # Residuen für männliche Beobachtungen in der Farbe des gewichteten Modells
  geom_segment(data = fb22_male, 
               aes(x = jittered_intel, xend = jittered_intel, # Beginn und Ende der Linie
                   y = jittered_extra, yend = predicted_weighted_jittered), 
               color = "#ad3b76", linetype = "solid") +
  
  # Hinzufügen erweiterter Reg.linien, die bis zum Rand der Grafik gehen, 
  # für bessere Sichtbarkeit
  geom_abline(intercept = coef_unweighted[1], slope = coef_unweighted[2],
              linetype = "dotdash", size = 1, color = "#00618F") +
  geom_abline(intercept = coef_weighted[1], slope = coef_weighted[2],
              size = 1, color = "#ad3b76") + # Dicke und Farbe
  
  labs(x = "Intelligenz", y = "Extraversion", color = "Modell") +  
  theme_minimal() + 
  scale_color_manual(values = c("gewichtet" = "#ad3b76", # Farben in der Legende
                                "ungewichtet" = "#00618F"))

# Plot anzeigen
print(p2)
