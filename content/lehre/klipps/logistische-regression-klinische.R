## source('https://pandar.netlify.app/daten/Data_Processing_grit.R')



library(psych)
subset(grit, select = c(ARS, RSS, ELOC, ILOC, Grit, Age)) |>
  describeBy(grit$Suicide)

## table(grit$Suicide, grit$Sex) |> addmargins()
## table(grit$Suicide, grit$Employment) |> addmargins()
## table(grit$Suicide, grit$Marital) |> addmargins()
## table(grit$Suicide, grit$SES) |> addmargins()
## table(grit$Suicide, grit$Orientation) |> addmargins()

idea <- subset(grit, grit$Suicide %in% c('None', 'Ideator'))
idea$Suicide <- droplevels(idea$Suicide)

# Lineare Regression
mod0 <- lm(Suicide ~ 1 + Grit, idea)

# Lineare Regression
mod0 <- lm(as.numeric(Suicide) ~ 1 + Grit, idea)

# Ergebnisübersicht
summary(mod0)

ggplot(idea, aes(x = Grit, y = as.numeric(Suicide))) + 
  geom_point(alpha = .25) + 
  geom_smooth(method = 'lm', se = FALSE, color = pandar_colors[1]) +
  theme_pandar()

residuals(mod0) |> hist()

# Logistische Regression
mod1 <- glm(Suicide ~ 1 + Grit, data = idea, family = 'binomial')

# Ergebnisausgabe
summary(mod1)

# Odds
exp(coef(mod1))

# Ganze Werte auf der Grit Skala
new_data <- data.frame(Grit = 0:4)

# Vorhersage
new_data$Logits <- predict(mod1, newdata = new_data)

# Umrechnung in Wahrscheinlichkeit
new_data$Probability <- exp(new_data$Logits) / (1 + exp(new_data$Logits))

# Ausgabe
new_data

## new_data$Probability <- predict(mod1, newdata = new_data, type = 'response')

# Daten und Vorhersagen erstellen
plottable <- data.frame(Grit = seq(0, 4, .01))
plottable$Probability <- predict(mod1, newdata = plottable, type = 'response')

# GGplot erstellen
ggplot(plottable, aes(x = Grit, y = Probability)) +
  geom_line(color = pandar_colors[1]) + 
  theme_pandar() + 
  ylim(0, 1)

# Konfidenzintervalle
ci <- confint(mod1)

# Ergebnisse
results <- data.frame(
  Odds = exp(coef(mod1)),
  Lower = exp(ci[, 1]),
  Upper = exp(ci[, 2])
)

# Ausgabe
results

# Zentrierung
idea$ARS_c <- scale(idea$ARS, scale = FALSE)
idea$ILOC_c <- scale(idea$ILOC, scale = FALSE)
idea$Grit_c <- scale(idea$Grit, scale = FALSE)

# dichotome Orientierung
idea$Orientation_bin <- factor(idea$Orientation, 
  labels = c('Hetero', 'LGBTQ', 'LGBTQ', 'LGBTQ'))

# Modelle aus Tabelle 3, Model 1, Spalte 2
block1 <- glm(Suicide ~ 1 + Orientation_bin, 
  idea, family = 'binomial')
block2 <- glm(Suicide ~ 1 + Orientation_bin + ARS_c + ILOC_c + Grit_c,
  idea, family = 'binomial')
block3 <- glm(Suicide ~ 1 + Orientation_bin + ARS_c + ILOC_c + Grit_c +
    ARS_c:ILOC_c + ARS_c:Grit_c + ILOC_c:Grit_c,
  idea, family = 'binomial')
block4 <- glm(Suicide ~ 1 + Orientation_bin + ARS_c + ILOC_c + Grit_c +
    ARS_c:ILOC_c + ARS_c:Grit_c + ILOC_c:Grit_c +
    ARS_c:ILOC_c:Grit_c,
  idea, family = 'binomial')

# Modellvergleich
anova(block1, block2, block3, block4)

# Ergebnisse
summary(block2)

# Odds
results <- data.frame(Odds = exp(coef(block2)),
  Lower = exp(confint(block2)[, 1]),
  Upper = exp(confint(block2)[, 2])
)

# Ausgabe
results

# Vorhersagen
idea$Prediction <- predict(block2, type = 'response') > .5
idea$Prediction <- factor(idea$Prediction, labels = c('None', 'Ideator'))

# Confusion
table(idea$Prediction, idea$Suicide)

library(caret)
confusionMatrix(idea$Prediction, idea$Suicide)

confuse <- table(idea$Prediction, idea$Suicide)

# Zentrierung
grit$ARS_c <- scale(grit$ARS, scale = FALSE)
grit$ILOC_c <- scale(grit$ILOC, scale = FALSE)
grit$Grit_c <- scale(grit$Grit, scale = FALSE)

# dichotome Orientierung
grit$Orientation_bin <- factor(grit$Orientation, 
  labels = c('Hetero', 'LGBTQ', 'LGBTQ', 'LGBTQ'))

# Umwandlung in "numeric"
grit$ARS_c <- as.numeric(grit$ARS_c)
grit$ILOC_c <- as.numeric(grit$ILOC_c)
grit$Grit_c <- as.numeric(grit$Grit_c)

## # Paket installieren
## install.packages('nnet')

# Paket laden
library(nnet)

# Multinomiale logistische Regression
mod2 <- multinom(Suicide ~ 1 + Grit_c, grit)

# Ergebnisse aus multinom
summary(mod2)

# Odds
odds <- exp(coef(mod2))

odds

# Mittlerer Grit +/- 1 und 2 SD
new_data <- data.frame(Grit_c = c(-2*sd(grit$Grit), -sd(grit$Grit), 0, sd(grit$Grit), 2*sd(grit$Grit)))

# Vorhegesagte Wahrscheinlichkeiten
new_data$Probability <- predict(mod2, newdata = new_data, type = 'probs')

# Ausgabe
new_data

# Daten und Vorhersagen erstellen
plottable <- data.frame(Grit_c = seq(min(grit$Grit_c), max(grit$Grit_c), .01))
plottable <- cbind(plottable, predict(mod2, newdata = plottable, type = 'probs'))

# Ins long-format umstellen (reshape)
plottable <- reshape(plottable, 
  direction = 'long', 
  varying = 2:4, 
  v.names = 'Probability', timevar = 'Category', times = c('None', 'Ideator', 'Attempter'))

# Plot erstellen
ggplot(plottable, aes(x = Grit_c, y = Probability, color = Category)) +
  geom_line() +
  theme_pandar() +
  scale_color_pandar() +
  ylim(0, 1)

confint(mod2)

# Parameter
beta <- summary(mod2)$coefficients

# Standardfehler
se <- summary(mod2)$standard.errors


# z-Werte
z <- beta/se

# p-Werte (zweiseitig)
p <- 2 * pnorm(abs(z), lower.tail = FALSE)

# Blöcke aufstellen
block1 <- multinom(Suicide ~ 1 + Orientation_bin, 
  grit)
block2 <- multinom(Suicide ~ 1 + Orientation_bin + ARS_c + ILOC_c + Grit_c,
  grit)
block3 <- multinom(Suicide ~ 1 + Orientation_bin + ARS_c + ILOC_c + Grit_c +
    ARS_c:ILOC_c + ARS_c:Grit_c + ILOC_c:Grit_c,
  grit)
block4 <- multinom(Suicide ~ 1 + Orientation_bin + ARS_c + ILOC_c + Grit_c +
    ARS_c:ILOC_c + ARS_c:Grit_c + ILOC_c:Grit_c +
    ARS_c:ILOC_c:Grit_c,
  grit)

# Modellvergleiche
anova(block1, block2, block3, block4)

library(sjPlot)

tab_model(block4, show.r2 = FALSE, show.aic = TRUE)

# Referenzlevel ändern
grit$Suicide_r <- relevel(grit$Suicide, ref = 'Attempter')

# Modell
block4b <- multinom(Suicide_r ~ 1 + Orientation_bin + ARS_c + ILOC_c + Grit_c +
    ARS_c:ILOC_c + ARS_c:Grit_c + ILOC_c:Grit_c +
    ARS_c:ILOC_c:Grit_c,
  grit)

# Tabelle
tab_model(block4b, show.r2 = FALSE, show.aic = TRUE)

# Vorgesagte Kateogrien
grit$Prediction <- predict(block4)

# Confusion Matrix
confusionMatrix(grit$Prediction, grit$Suicide)
tab <- table(grit$Prediction, grit$Suicide)
