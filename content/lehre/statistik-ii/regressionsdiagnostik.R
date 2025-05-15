library(ggplot2)
source('./pandar_theme.R')
theme_set(theme_pandar())

#### Vorbereitung ----
# Datensatz laden
source("https://pandar.netlify.app/daten/Data_Processing_vegan.R")

#### Modell aufstellen ----
# Volles Regressionsmodell
mod <- lm(commitment ~ health + environment + animals + social + workers + disgust, data = vegan)

# Ergebnisse betrachten
summary(mod)



# Berechnung standardisierter Koeffizienten
library(lm.beta)
summary(lm.beta(mod))

#### Homoskedastizität ----

# Scale-Location-Plot
plot(mod, 3)

# Varianz der Residuen im 1. und 4. Viertel:
resis <- residuals(mod) # Residuen
preds <- fitted(mod)    # Vorhergesagte Werte

# Varianz der Residuen im 1. Viertel der vorhergesagten Werte
q1_var <- var(resis[preds <= quantile(preds, .25)])
# Varianz der Residuen im 4. Viertel der vorhergesagten Werte
q3_var <- var(resis[preds >= quantile(preds, .75)])

# Residuenplot
plot(mod, which = 1)

# car-Paket laden
library(car)

# Test For Non-Constant Error Variance
ncvTest(mod)

# Box-Cox Transformation
bc <- MASS::boxcox(mod, lambda = seq(-5, 5, .1))

# Optimales Lambda extrahieren
lam <- bc$x[which.max(bc$y)]
lam

# Transformation der AV
vegan$commitment_bc <- (vegan$commitment^lam - 1) / lam

# Neues Modell aufstellen
mod_bc <- lm(commitment_bc ~ health + environment + animals + social + workers + disgust, data = vegan)

# Non-Constant-Variance Test
ncvTest(mod_bc)

# Pakete laden
library(sandwich)   # für die Berechnung der HC3 Standardfehler
library(lmtest)     # für die Testung der Regressionsgewichte

# Standardfehler
vcov(mod) |> diag() |> sqrt()

# HC3 Standardfehler
vcovHC(mod) |> diag() |> sqrt()

# Inferenzstatistik der Regressionsgewichte
coeftest(mod, vcov = vcovHC(mod))

# QQ-Plot der Residuen
qqPlot(mod)

# Histogramm der Residuen
resid(mod) |> hist()

# Shapiro-Wilk-Test auf Normalverteilung
resid(mod) |> shapiro.test()

# Vier plots gleichzeitig darstellen
par(mfrow = c(2, 2))

# QQ-Plot ohne Transformation
qqPlot(mod)

# QQ-Plot mit Transformation
qqPlot(mod_bc)

# Histogramm ohne Transformation
resid(mod) |> hist()

# Histogramm mit Transformation
resid(mod_bc) |> hist()


# Normale Einstellung für Plots wiederherstellen
par(mfrow = c(1, 1))

# Shapiro-Wilk-Test nach Transformation
resid(mod_bc) |> shapiro.test()

set.seed(35355)

#### Händischer Bootstrap ----
# Originaldatensatz
og <- vegan[1:7, c('age', 'gender', 'commitment', 'animals')]
og

# Bootstrap-Datensatz
b1 <- og[sample(1:7, 7, replace = TRUE), ] #Wichtig: replace=TRUE --> mit Zurücklegen
b1

# # Manuelle Regressionsfunktion
# booting <- function(data) {
#   # Datensatz zufällig ziehen
#   b_data <- data[sample(1:nrow(data), nrow(data), replace = TRUE), ]
# 
#   # Regression durchführen
#   mod <- lm(commitment ~ health + environment + animals + social + workers + disgust, data = b_data)
# 
#   # Regressionsgewicht extrahieren
#   out <- coef(mod)[4]
# 
#   return(out)
# }
# 
# # Wiederholte anwendung
# booted <- replicate(5000, booting(vegan))

# Bootstrapping mit car-Paket
booted <- Boot(mod, R = 5000)

# ggplot2 Paket laden
library(ggplot2)

# Original Regressionsgewicht
b_og <- coef(mod)[4]
# Standardfehler
se_og <- sqrt(diag(vcov(mod))[4])

# 5000 Regressionen
b_boot <- booted$t

# ggplot2 Plot erstellen
ggplot(b_boot, aes(x = animals)) + 
  geom_histogram(aes(y = after_stat(density)), bins = 50, fill = "grey90", color = "black") +
  geom_function(fun = dnorm, args = list(mean = b_og, sd = se_og)) + 
  geom_vline(xintercept = b_og, linetype = "dashed")

# Standardabweichung der gebootstrappten Werte
sd(b_boot[, 4])

# Standardfehler der Regressionsgewichte
vcov(mod)[4, 4] |> sqrt()

# # Bootstrapping mit car-Paket
# booted <- Boot(mod, R = 5000)
# Zusammenfassung der Ergebnisse
confint(booted, type = 'perc')

# ## Grafische Prüfung der partiellen Linearität
# 
# # Residuenplots
# residualPlots(mod)

residualPlots(mod, tests = FALSE)

residualPlots(mod, plot = FALSE, tests = TRUE)

## Prüfung der Mulitkollinearität durch Inspektion der bivariaten Zusammenhänge

# Datensatz der Prädiktoren
UV <- vegan[, c('health', 'environment', 'animals', 'social', 'workers', 'disgust')]
# Korrelation der Prädiktoren
cor(UV)

# Varianzinflationsfaktor:
vif(mod)

# Toleranzwerte als Kehrwerte
1 / vif(mod)

#### Ausreißerdiagnostik ----
## Ausreißeridentifikation mit Hebelwerten und Cooks Distanz

# Hebelwerte
hebel <- hatvalues(mod) # Hebelwerte

# Cooks Distanz
cook <- cooks.distance(mod) # Cooks Distanz

# Abgleich mit verschiedenen Grenzwerten:
n <- length(hebel) # Anzahl der Beobachtungen

which(hebel > (4/n)) |> length() # Anzahl Hebelwerte > 4/n
which(hebel > (2*6/n)) |> length() # Anzahl Hebelwerte > 2*k/n
which(hebel > (3*6/n)) |> length() # Anzahl Hebelwerte > 3*k/n

# Abgleich für Cook
which(cook > 1) |> length() # Anzahl Cook's Distanz > 1

# Histogramm der Hebelwerte mit Grenzwerten
grenzen <- data.frame(h = c(4/n, 2*6/n, 3*6/n), 
                       Grenzwerte = c("4/n", "2*k/n", "3*k/n"))

ggplot(data = as.data.frame(hebel), aes(x = hebel)) +
  geom_histogram(aes(y =after_stat(density)),  bins = 15, fill="grey90", colour = "black") +
  geom_vline(data = grenzen, aes(xintercept = h, lty = Grenzwerte)) # Cut-off bei 4/n

# Cooks Distanz
CD <- cooks.distance(mod) # Cooks Distanz

# Erzeugung der Grafik
ggplot(as.data.frame(CD), aes(x = CD)) +
  geom_histogram(aes(y =after_stat(density)),  bins = 15, fill="grey90", colour = "black")

# Blasendiagramm, das simultan Hebelwerte, studentisierte Residuen und Cooks Distanz darstellt

InfPlot <- influencePlot(mod)
IDs <- as.numeric(row.names(InfPlot))

# Rohdaten der auffälligen Fälle
vegan[IDs, c('commitment', 'health', 'environment', 'animals', 'social', 'workers', 'disgust')]

# Standardisierte Skalenwerte
std <- vegan[, c('commitment', 'health', 'environment', 'animals', 'social', 'workers', 'disgust')] |>
  scale()
round(std[IDs, ], 3)



# Vergeichbarkeit
set.seed(1)

# Datensimulation UV (Normalverteilt)
Depressivitaet <- rnorm(n = 250) # Ohne Messfehler
Depressivitaet_mf <- sqrt(0.7)*Depressivitaet + rnorm(n  = 250, sd = sqrt(0.3)) # Mit Messfehler

# Datensimulation der AV
Lebenszufriedenheit <- -0.5 * Depressivitaet

# Zusammenfassung zu einem Datensatz (relevant für ggplot)
df <- data.frame(Lebenszufriedenheit = c(Lebenszufriedenheit, Lebenszufriedenheit),
                 Depressivitaet = c(Depressivitaet, Depressivitaet_mf),
                 Messfehler = c(rep("Ohne Messfehler", 250), rep("Mit Messfehler", 250)))

# Faktorisieren der Messfehlervariable
df$Messfehler <- factor(df$Messfehler, levels = c("Ohne Messfehler", "Mit Messfehler"))

# Grafische Darstellung
library(ggplot2)
ggplot(data = df, aes(x = Depressivitaet, y = Lebenszufriedenheit, group = Messfehler))+
  geom_point()+
  geom_smooth(method = "lm", se =F)+
  facet_wrap(~Messfehler)

# Regressionsmodelle (mit und ohne Messfehler)
summary(lm(Lebenszufriedenheit~Depressivitaet)) # Ohne Messfehler
summary(lm(Lebenszufriedenheit~Depressivitaet_mf)) # Mit Messfehler

# Konfidenzintervall des Regressionsgewichts
confint(lm(Lebenszufriedenheit~Depressivitaet))  # Ohne Messfehler
confint(lm(Lebenszufriedenheit~Depressivitaet_mf)) # Mit Messfehler
