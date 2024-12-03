source('https://pandar.netlify.app/daten/Data_Processing_esm.R')



## # Pakete installieren
## install.packages("lme4")
## install.packages("lmerTest")

# Pakete laden
library(lme4)
library(lmerTest)

# Nullmodell in lme4
mod0 <- lmer(problem ~ 1 + (1 | id), data = esm)

# Modellzusammenfassung
summary(mod0)

# Paket laden
library(performance)

# ICC berechnen
icc(mod0)



# Random Intercept Modell
mod1 <- lmer(problem ~ 1 + reappraisal + solving + sharing + affection + invalidation + blaming + (1 | id), data = esm)

# Ergebniszusammenfassung
summary(mod1)



# Modelle auf vollständige Beobachtungen anwenden
mod0b <- update(mod0, data = mod1@frame)
mod1b <- update(mod1, data = mod1@frame)

# Modellvergleich
anova(mod0b, mod1b)

# Bestimmung des Pseudo-R^2
r2(mod1b)

# Random Intercept Modell mit Level 2 Prädiktor
mod2 <- lmer(problem ~ 1 + reappraisal + solving + sharing + affection + invalidation + blaming +
    group + (1 | id), data = esm)

# Ergebniszusammenfassung
summary(mod2)

# Modelle aktualisieren (gleicher Datensatz)
mod1b <- update(mod1, data = mod2@frame)
mod2b <- update(mod2, data = mod2@frame)

# Modellvergleich
anova(mod1b, mod2b)

# Bestimmung des Pseudo-R^2
r2(mod2b)
