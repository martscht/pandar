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

# Personen-Mittelwerte berechnen (Aggregatvariablen)
w <- aggregate(esm[, c("reappraisal", "solving", "sharing", "affection", "invalidation", "blaming")], by = list(esm$id), mean, na.rm = TRUE)

# Spaltennamen anpassen
names(w) <- c("id", "mean_reappraisal", "mean_solving", "mean_sharing", "mean_affection", "mean_invalidation", "mean_blaming")

# Daten zusammenführen
esm <- merge(esm, w, by = "id")

# Random Intercept Modell mit Kontext-Effekten
mod3 <- lmer(problem ~ 1 + reappraisal + solving + sharing + affection + invalidation + blaming +
    mean_reappraisal + mean_solving + mean_sharing + mean_affection + mean_invalidation + mean_blaming + 
    (1 | id), data = esm)

# Ergebniszusammenfassung
summary(mod3)

# CWC Werte berechnen
esm$cwc_reappraisal <- esm$reappraisal - esm$mean_reappraisal
esm$cwc_solving <- esm$solving - esm$mean_solving
esm$cwc_sharing <- esm$sharing - esm$mean_sharing
esm$cwc_affection <- esm$affection - esm$mean_affection
esm$cwc_invalidation <- esm$invalidation - esm$mean_invalidation
esm$cwc_blaming <- esm$blaming - esm$mean_blaming

# Random Intercept Modell mit zentrierten Prädiktoren
mod4 <- lmer(problem ~ 1 + cwc_reappraisal + cwc_solving + cwc_sharing + cwc_affection + cwc_invalidation + cwc_blaming +
    mean_reappraisal + mean_solving + mean_sharing + mean_affection + mean_invalidation + mean_blaming + 
    (1 | id), data = esm)

# Modelle zusammenfassen
fixed <- data.frame(
  intercept = c(fixef(mod1)[1], fixef(mod3)[1], fixef(mod4)[1]),
  L1_reappraisal = c(fixef(mod1)[2], fixef(mod3)[2], fixef(mod4)[2]),
  L1_solving = c(fixef(mod1)[3], fixef(mod3)[3], fixef(mod4)[3]),
  L1_sharing = c(fixef(mod1)[4], fixef(mod3)[4], fixef(mod4)[4]),
  L1_affection = c(fixef(mod1)[5], fixef(mod3)[5], fixef(mod4)[5]),
  L1_invalidation = c(fixef(mod1)[6], fixef(mod3)[6], fixef(mod4)[6]),
  L1_blaming = c(fixef(mod1)[7], fixef(mod3)[7], fixef(mod4)[7]),
  L2_reappraisal = c(NA, fixef(mod3)[8], fixef(mod4)[8]),
  L2_solving = c(NA, fixef(mod3)[9], fixef(mod4)[9]),
  L2_sharing = c(NA, fixef(mod3)[10], fixef(mod4)[10]),
  L2_affection = c(NA, fixef(mod3)[11], fixef(mod4)[11]),
  L2_invalidation = c(NA, fixef(mod3)[12], fixef(mod4)[12]),
  L2_blaming = c(NA, fixef(mod3)[13], fixef(mod4)[13]))

# Modellnamen hinzufügen
rownames(fixed) <- c("UN Modell", "UN(M) Modell", "CWC(M) Modell")

# Als Tabelle formatieren
t(fixed) |> round(3) |> knitr::kable()





mod5 <- lmer(problem ~ 1 + reappraisal + solving + sharing + affection + invalidation + blaming +
    mean_reappraisal + mean_solving + mean_sharing + mean_affection + mean_invalidation + mean_blaming + 
    (1 + reappraisal + solving + sharing + affection + invalidation + blaming | id), data = esm)

# Letzte Schätzung extrahieren
vals <- getME(mod5, c("theta"))

# Werte als Startwerte einsetzen
mod5b <- update(mod5, start = vals)

## allFit(mod5)



# Modell mit herabgesetztem Konvergenzkriterium
mod5c <- update(mod5, control = lmerControl(optCtrl = list(ftol_abs = 1e3)))

# Korrelationsmatrix der Zufallseffekte
VarCorr(mod5)

# Partialkorrelationen
attr(VarCorr(mod5)$id, 'correlation') |> corpcor::cor2pcor() |> round(3)

# Modell mit unkorrelierten Zufallseffekten
mod6 <- lmer(problem ~ 1 + reappraisal + solving + sharing + affection + invalidation + blaming +
    mean_reappraisal + mean_solving + mean_sharing + mean_affection + mean_invalidation + mean_blaming + 
    (1 + reappraisal + solving + sharing + affection + invalidation + blaming || id), data = esm)

# bobyqa als Schätzer nutzen
mod6b <- update(mod6, control = lmerControl(optimizer = "bobyqa"))

# Korrelationsmatrix der Zufallseffekte
VarCorr(mod6b)

# Modellschätzung
mod7  <- lmer(problem ~ 1 + reappraisal + solving + sharing + affection + invalidation + blaming +
    mean_reappraisal + mean_solving + mean_sharing + mean_affection + mean_invalidation + mean_blaming + 
    (1 + reappraisal + solving + sharing + invalidation || id), data = esm)

# Ergebniszusammenfassung
summary(mod7)

# Ausgabe der individuellen Zufallseffekte
# wegen head() nur die top 6 Zeilen
ranef(mod7)$id |> head()

# Daten für die beiden Personen
new <- esm[esm$id %in% c(2001, 2009) & esm$index1 == 3, ]
new <- rbind(new, new)
rownames(new) <- c('2001:solving', '2009:solving', '2001:none', '2009:none')

# Künstliche Situationen erzeugen
new$reappraisal <- c(0, 0, 0, 0)
new$solving <- c(1, 1, 0, 0)
new$sharing <- c(0, 0, 0, 0)
new$affection <- c(0, 0, 0, 0)
new$invalidation <- c(0, 0, 0, 0)
new$blaming <- c(0, 0, 0, 0)

# Vorhersagen für die beiden Personen
predict(mod7, new) |> round(3)



# Modell mit allen Cross-Level Interaktionen
mod8 <- lmer(problem ~ 1 + reappraisal + solving + sharing + affection + invalidation + blaming +
    mean_reappraisal + mean_solving + mean_sharing + mean_affection + mean_invalidation + mean_blaming +
    group + 
    reappraisal:group + solving:group + sharing:group + affection:group + invalidation:group + blaming:group +
    (1 + reappraisal + solving + sharing + invalidation || id), data = esm)

# Modell mit allen Interaktionen
mod9 <- lmer(problem ~ 1 + reappraisal + solving + sharing + affection + invalidation + blaming +
    mean_reappraisal + mean_solving + mean_sharing + mean_affection + mean_invalidation + mean_blaming +
    reappraisal:group + solving:group + sharing:group + affection:group + invalidation:group + blaming:group +
    group +
    mean_reappraisal:group + mean_solving:group + mean_sharing:group + mean_affection:group + mean_invalidation:group + mean_blaming:group +
    (1 + reappraisal + solving + sharing + invalidation || id), data = esm)

# Modellvergleiche
anova(mod7, mod8, mod9)

performance::r2(mod7)
performance::r2(mod8)
performance::r2(mod9)
