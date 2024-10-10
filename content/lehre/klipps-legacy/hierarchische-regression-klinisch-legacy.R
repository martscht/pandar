# Benötigte Pakete --> Installieren, falls nicht schon vorhanden
library(lme4)         # Für die Mehrebenen-Regression
library(dplyr)        # Komfort-Funktionen für die Datentransformationen
library(ICC)          # Für die einfache Berechung von ICCs
library(ggplot2)      # Für Grafiken
library(interactions) # Zur Veranschaulichung von Moderator-Effekten

# Daten einlesen und vorbereiten 
lockdown <- read.csv(url("https://osf.io/dc6me/download"))

# Entfernen der Personen, für die weniger als zwei Messpunkte vorhanden sind
# (Auschluss von Fällen, deren ID nur einmal vorkommt)
lockdown <- lockdown[-which(lockdown$ID %in% names(which(table(lockdown$ID)==1))),] 

# Daten aufbereiten, Variablen auswählen extrahieren und in Nummern umwandeln
# Entfernen von Minderjährigen & unbestimmtes Gender mit den Funktionen filter() und select () aus dplyr.
lockdown <- lockdown %>%
  filter((Age >= 18) & (Gender == 1 | Gender == 2)) %>%
  dplyr::select(c("ID", "Wave", "Age", "Gender", "Income", "EWB","PWB","SWB",
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

# ID in Faktor Umwandeln
lockdown$ID <- as.factor(lockdown$ID)

# ICCs auf Basis der Varianzkomponenten mit der Funktion ICCbare
ICCbare(ID, EWB, data = lockdown)
ICCbare(ID, PWB, data = lockdown)
ICCbare(ID, SWB, data = lockdown)
ICCbare(ID, IWB, data = lockdown)


# Individuelle Verläufe für Psychological Well Being
ggplot(lockdown, aes(x=Wave, y=PWB, color=ID)) +
  theme_bw() + guides(color="none") +
  geom_line()


IDs.subset <- c("03858ebe", "ddf85cd4", "fab6bb4d", "c7b6e168", "c0661f6a", "f005ee8d", "f037053f", "166a701e",
                "3ff1ffae", "486d63a8", "4b6a0366", "ba2ccd92", "cdbfa68a", "f43569d8", "c0c3cb43")
# Grafik mit dem Subset
ggplot(lockdown[lockdown$ID %in% IDs.subset,], aes(x=Wave, y=PWB, color=ID)) +
  theme_bw() + guides(color="none") +
  geom_line()


# Ursprüngliche Syntax zur zufälligen Auswahl der Fälle
# Alle IDs mit 6 Zeitpunkten
# IDs.subset <- names(which(table(lockdown$ID)==6))
# Zufallsstichprobe aus diesen IDs
# IDs.subset <- sample(IDs.subset, 15)

# Grafik mit dem Subset, Zeit als UV
ggplot(lockdown[lockdown$ID %in% IDs.subset,], aes(x=Time, y=PWB, color=ID)) +
  theme_bw() + guides(color="none") +
  geom_line()

m0 <- lmer(PWB ~ 1 + (1 | ID), data = lockdown)
sig2_b <- VarCorr(m0)$ID[1]
sig2_w <- summary(m0)$sigma^2



# Nulllmodell für PWB
m0 <- lmer(PWB ~ 1 + (1 | ID), data = lockdown)
summary(m0)


PWB.time.fixed <- lmer(PWB ~ 1 + Time + (1 | ID), data = lockdown)
summary(PWB.time.fixed)

# Vorhergesagte Werte im Datensatz speichern
lockdown$pred <- predict(PWB.time.fixed)
# Grafik mit dem Subset
ggplot(lockdown[lockdown$ID %in% IDs.subset,], aes(x=Time, y=pred, color=ID)) +
  theme_bw() + guides(color="none") +
  geom_line()

PWB.time.random <- lmer(PWB ~ 1 + Time + (1 + Time | ID), data = lockdown)
summary(PWB.time.random)



PWB.time.random <- lmer(PWB ~ 1 + Time + (1 + Time | ID), data = lockdown,
                        control = lmerControl(optimizer ="Nelder_Mead"))
summary(PWB.time.random)

diff <- anova(PWB.time.fixed, PWB.time.random, refit=FALSE)

anova(PWB.time.fixed, PWB.time.random, refit=FALSE)

# Vorhergesagte Werte im Datensatz speichern
lockdown$pred <- predict(PWB.time.random)
# Grafik mit dem Subset
ggplot(lockdown[lockdown$ID %in% IDs.subset,], aes(x=Time, y=pred, color=ID)) +
  theme_bw() + guides(color="none") +
  geom_line()


# Histogramm der individuellen Slopes als Summe aus festem Effekt und Residuen
hist(fixef(PWB.time.random)["Time"] + ranef(PWB.time.random)$ID$Time, 
     main="Histogramm des Zeiteffekts", xlab = expression(beta[1]), 
     breaks = seq(-0.2,0.2,0.025))
abline(v=fixef(PWB.time.random)["Time"], col="blue") # Lage des festen Effektes kennzeichnen



mean(lockdown$Age)
lockdown$Age <- scale(lockdown$Age, scale = FALSE)
PWB.Age <- lmer(PWB ~ 1 + Age + (1 | ID), data = lockdown)

PWB.Age <- lmer(PWB ~ 1 + Age + (1 | ID), data = lockdown)
summary(PWB.Age)

mean(lockdown$Time)
lockdown$Time <- scale(lockdown$Time, scale = FALSE)
PWB.Age.Time <- lmer(PWB ~ 1 + Age + Time + Age:Time + (1 + Time | ID), data = lockdown)
summary(PWB.Age.Time)


PWB.Age.Time <- lmer(PWB ~ 1 + Age + Time + Age:Time + (1 + Time | ID), data = lockdown,
                        control = lmerControl(optimizer ="Nelder_Mead"))
summary(PWB.Age.Time)

interact_plot(model = PWB.Age.Time, pred = Time, modx = Age)
