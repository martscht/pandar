source("https://pandar.netlify.app/lehre/statistik-ii/Data_Processing_punish.R")

head(punish)

mod1 <- lm(severe ~ country, punish)
summary(mod1)

class(punish$country)

contrasts(punish$country)

# Gruppenmittelwerte
tapply(punish$severe, punish$country, mean)

# Koeffizienten
coef(mod1)[1] # USA
coef(mod1)[1] + coef(mod1)[2] # China

t.test(punish$severe ~ punish$country, var.equal = TRUE)

contrasts(punish$country) <- contr.sum(2)

contrasts(punish$country)

mod1b <- lm(severe ~ country, punish)
summary(mod1b)

# Mittel der Gruppenmittelwerte
tapply(punish$severe, punish$country, mean) |> mean()

contrasts(punish$country) <- contr.treatment(2)
dimnames(contrasts(punish$country))[[2]] <- "China"

tab <- data.frame(
  country = c("U.S", "U.S", "China", "China"),
  bribe = c("group", "individual", "group", "individual")
)

tab$mod1 <- predict(mod1, tab)
tab

# ---- mod1-Plot ----
pred_plot <- ggplot(tab, aes(
  x = bribe,
  group = country, color = country
)) +
  geom_point(aes(y = mod1)) +
  geom_line(aes(y = mod1)) +
  theme_minimal() +
  ylim(c(4, 5.5))

pred_plot

mod2 <- lm(severe ~ country + bribe, punish)
summary(mod2)

# ---- mod2-Plot ----
tab$mod2 <- predict(mod2, tab)

pred_plot <- pred_plot +
  geom_point(aes(y = tab$mod2)) + geom_line(aes(y = tab$mod2), lty = 2)
pred_plot

# Übersicht über die Vorhersagten Werte
tab

# Unterschied der Bestechungstypen in den beiden Ländern
tab$mod2[2] - tab$mod2[1]
tab$mod2[4] - tab$mod2[3] # identisch

mod3 <- lm(severe ~ country + bribe + country:bribe, punish)
summary(mod3)

# ---- mod3-Plot ----
tab$mod3 <- predict(mod3, tab)

pred_plot <- pred_plot +
  geom_point(aes(y = tab$mod3)) + geom_line(aes(y = tab$mod3), lty = 3)
pred_plot

tab

anova(mod1, mod2, mod3)

# Deskriptiv
summary(mod2)$r.squared - summary(mod1)$r.squared
summary(mod3)$r.squared - summary(mod2)$r.squared

table(punish$age)

mod4 <- lm(severe ~ age, punish)
summary(mod4)

contrasts(punish$age)

tab <- data.frame(age = levels(punish$age))
tab$mod4 <- predict(mod4, tab)
tab

usa <- subset(punish, country == "U.S")

mod5 <- lm(severe ~ gains, usa)
summary(mod5)

mod6 <- lm(severe ~ gains + bribe, usa)
summary(mod6)

# ---- ANCOVA-Plot ----
# Scatterplot erstellen
scatter <- ggplot(usa, aes(x = gains, y = severe, color = bribe)) +
  geom_point()

# Regressionsgerade aus mod6 hinzufügen
scatter +
  # Kollektive Bestechung
  geom_abline(
    intercept = coef(mod6)[1], slope = coef(mod6)[2],
    color = "#00618F"
  ) +
  # Individuelle Bestechung
  geom_abline(
    intercept = coef(mod6)[1] + coef(mod6)[3], slope = coef(mod6)[2],
    color = "#ad3b76"
  )

mod7 <- lm(severe ~ gains + bribe + gains:bribe, usa)
summary(mod7)

# ---- Generalisierte-ANCOVA-Plot ----
scatter +
  # Kollektive Bestechung
  geom_abline(
    intercept = coef(mod7)[1], slope = coef(mod7)[2],
    color = "#00618f"
  ) +
  # Individuelle Bestechung
  geom_abline(
    intercept = coef(mod7)[1] + coef(mod7)[3], slope = coef(mod7)[2] + coef(mod7)[4],
    color = "#ad3b76"
  )

library(reghelper)
simple_slopes(mod7)

# ---- Appendix-A----------------- ----
mod8 <- lm(severe ~ country + bribe + gains, punish)
summary(mod8)

scatter <- ggplot(punish, aes(x = gains, y = severe, color = country:bribe)) +
  geom_point()

tmp <- coef(mod8)
tab <- data.frame(
  country = as.factor(c("U.S", "U.S", "China", "China")),
  bribe = as.factor(c("group", "individual", "group", "individual")),
  intercept = NA,
  slope = NA
)
tab$intercept <- c(tmp[1], sum(tmp[c(1, 3)]), sum(tmp[1:2]), sum(tmp[1:3]))
tab$slope <- tmp[4]

# ---- Komplexer-Plot(additiv) ----
scatter +
  geom_abline(data = tab, aes(
    intercept = intercept, slope = slope,
    color = country:bribe
  ))

# ---- Komplexer-Plot-mit-Interaktion ----
# Modell
mod9 <- lm(severe ~ country + bribe + gains + country:bribe, punish)

# Plot vorbereitung
tmp <- coef(mod9)
tab$intercept <- c(tmp[1], sum(tmp[c(1, 3)]), sum(tmp[1:2]), sum(tmp[c(1:3, 5)]))
tab$slope <- tmp[4]

# Plot
scatter +
  geom_abline(data = tab, aes(
    intercept = intercept, slope = slope,
    color = country:bribe
  ))

# Schrittweise Modelle mit Interaktionen
mod10 <- lm(severe ~ country + bribe + gains + country:bribe + country:gains, punish)
mod11 <- lm(severe ~ country + bribe + gains + country:bribe + bribe:gains, punish)
mod12 <- lm(severe ~ country + bribe + gains + country:bribe + country:gains + bribe:gains, punish)
mod13 <- lm(severe ~ country + bribe + gains + country:bribe + country:gains + bribe:gains + country:bribe:gains, punish)

# AIC Tabelle
aics <- rbind(
  extractAIC(mod8),
  extractAIC(mod9),
  extractAIC(mod10),
  extractAIC(mod11),
  extractAIC(mod12),
  extractAIC(mod13)
) |> data.frame()
names(aics) <- c("df", "AIC")
aics$model <- 8:13
aics

# ---- Komplexer-Plot-mit-vollständiger-Interaktion ----
# Plot vorbereitung
tmp <- coef(mod13)
tab$intercept <- c(tmp[1], sum(tmp[c(1, 3)]), sum(tmp[1:2]), sum(tmp[c(1:3, 5)]))
tab$slope <- c(tmp[4], sum(tmp[c(4, 7)]), sum(tmp[c(4, 6)]), sum(tmp[c(4, 6:8)]))

# Plot
scatter +
  geom_abline(data = tab, aes(
    intercept = intercept, slope = slope,
    color = country:bribe
  ))

simple_slopes(mod13, levels = list(gains = "sstest"))
