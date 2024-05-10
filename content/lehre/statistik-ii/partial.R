load(url("https://pandar.netlify.app/daten/Depression.rda"))
str(Depression)

dat <- subset(Depression, select = -c(Intervention, Geschlecht))

rm(Depression) # das nicht benötigte Objekt wird wieder gelöscht

# Neurotizismus invertieren
dat$Neurotizismus <- 11 - (dat$Neurotizismus)

library(ggplot2) # notwendiges Paket für Grafiken laden

ggplot(dat, aes(x = Lebenszufriedenheit, y = Depressivitaet)) + 
  geom_point() +
  theme_minimal() +
  geom_smooth(method = "lm", se = FALSE)

cor.test(dat$Depressivitaet, dat$Lebenszufriedenheit)

# Korrelation der Drittvariablen mit den beiden ursprünglichen Variablen
cor.test(dat$Neurotizismus, dat$Lebenszufriedenheit)
cor.test(dat$Neurotizismus, dat$Depressivitaet)


# Regression 
reg_depr_neuro <- lm(Depressivitaet ~ Neurotizismus, data = dat)
reg_lz_neuro <- lm(Lebenszufriedenheit ~ Neurotizismus, data = dat)

# Residuen in Objekt ablegen (Anteil von Depr., der nicht durch Neuro. erklärt wird)
res_depr_neuro <- residuals(reg_depr_neuro)

# Residuen in Objekt ablegen (Anteil von LZ, der nicht durch Neuro. erklärt wird)
res_lz_neuro <- residuals(reg_lz_neuro)

cor(res_depr_neuro, res_lz_neuro)

## # Paket für Partial- und Semipartialkorrelation
## install.packages("ppcor")

library(ppcor)

# Partialkorrelation mit Funktion
pcor.test(x = dat$Depressivitaet,      # Das Outcome
          y = dat$Lebenszufriedenheit, # Die Prädiktorvariable
          z = dat$Neurotizismus)       # wird aus X und Y auspartialisiert

# Einfache lineare Regression von Depressivität auf Neurotizismus
mod1 <- lm(Depressivitaet ~ Lebenszufriedenheit, data = dat)
summary(mod1)$coefficients |> round(3)

# Erweiterte Regression, die Episodenanzahl einschließt
mod2 <- lm(Depressivitaet ~ Lebenszufriedenheit + Neurotizismus, data = dat)
summary(mod2)$coefficients |> round(3)

# Semipartialkorrelation als Korrelation zwischen Depressivität (X) und 
# Lebenszufriedenheit (Y), bereinigt um den Einfluss von Neurotizismus (Z) auf 
# Lebenszufriedenheit (Y)
cor(dat$Depressivitaet, res_lz_neuro)


# Semipartialkorrelation mit Funktion
spcor.test(x = dat$Depressivitaet,        # Outcome
           y = dat$Lebenszufriedenheit,   # Prädiktor
           z = dat$Neurotizismus)         # wird aus Y, aber nicht X auspartialisiert


# Paket für standardisierte Beta-Koeffizienten
library(lm.beta)

# Einfache lineare Regression von Depressivität auf Neurotizismus
mod1 <- lm(Depressivitaet ~ Neurotizismus, data = dat)
lm.beta(mod1)$standardized.coefficients

# Korrelation entspricht dem Beta-Koeffizienten
cor(dat$Depressivitaet, dat$Neurotizismus)

# Ein Modell mit zwei Prädiktoren
mod2 <- lm(Depressivitaet ~ Neurotizismus + Episodenanzahl, 
          data = dat)

lm.beta(mod2) |> summary() # fügt std. Betas zum Output hinzu

R2_mod2 <- summary(mod2)$r.squared

r_yx1      <- cor(dat$Depressivitaet, dat$Neurotizismus)
r_yx2.x1   <- spcor.test(x = dat$Depressivitaet, # Outcome 
                      y = dat$Episodenanzahl,    # hier rauspartialisieren
                      z = dat$Neurotizismus)$estimate

corrs <- data.frame(r_yx1, r_yx2.x1)
corrs

sum(corrs^2) # Das entspricht dem Determinationskoeffizienten R^2
R2_mod2

# Tabelle der Partialkorrelationen
pcor_table <- pcor(dat)
pcor_table$estimate |> round(3)

library(qgraph)
# Partialkorrelationsnetzwerk grafisch darstellen:
Q <- qgraph(input = pcor_table$estimate, 
     layout = "spring",                    # grafische Anordnung der Variablen
     edge.labels = TRUE,                   # Partialkorrelationen anzeigen
     labels = substr(colnames(dat), 1, 5)) # die ersten 5 Zeichen der colnames

# Plot wird automatisch erzeugt, ohne dass wir Q ausführen müssen
