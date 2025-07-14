# Datensatz einlesen
load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))
head(Schulleistungen)

# Standardisierung der Variablen
Schulleistungen_std <- data.frame(scale(Schulleistungen))
# standardisierten Datensatz abspeichern als data.frame
colMeans(Schulleistungen_std) # Mittelwert pro Spalte ausgeben
apply(Schulleistungen_std, 2, sd) # SD pro Spalte ausgeben

# Einfache Regression ohne Interaktion
mod1 <- lm(reading ~ IQ, Schulleistungen_std)
summary(mod1)

# Multiple Regression ohne Interaktion
mod2 <- lm(reading ~ IQ + math, Schulleistungen_std)
summary(mod2)

# Regression mit Moderator Matheleistungen
mod_reg <- lm(reading ~ IQ + math + IQ:math, data = Schulleistungen_std)
summary(mod_reg)

library(interactions)
interact_plot(
  model = mod_reg,
  pred = IQ,
  modx = math,
  main = "Matheleistung als Moderator"
)

library(reghelper)
simple_slopes(mod_reg)

interact_plot(
  model = mod_reg,
  pred = math,
  modx = IQ,
  main = "IQ als Moderator"
)

library(plot3D)
# Übersichtlicher: Vorbereitung
x <- Schulleistungen_std$IQ
y <- Schulleistungen_std$reading
z <- Schulleistungen_std$math
fit <- lm(y ~ x * z)
grid.lines <- 26
x.pred <- seq(min(x), max(x), length.out = grid.lines)
z.pred <- seq(min(z), max(z), length.out = grid.lines)
xz <- expand.grid(x = x.pred, z = z.pred)
y.pred <- matrix(predict(fit, newdata = xz),
  nrow = grid.lines, ncol = grid.lines
)
fitpoints <- predict(fit)

# Plot:
scatter3D(
  x = x, y = z, z = y, pch = 16, cex = 1.2,
  theta = 0, phi = 0, ticktype = "detailed",
  xlab = "IQ", ylab = "math", zlab = "reading",
  surf = list(
    x = x.pred, y = z.pred, z = y.pred,
    facets = NA, fit = fitpoints
  ),
  main = "Moderierte Regression"
)

scatter3D(
  x = x, y = z, z = y, pch = 16, cex = 1.2,
  theta = 20, phi = 20, ticktype = "detailed",
  xlab = "IQ", ylab = "math", zlab = "reading",
  surf = list(
    x = x.pred, y = z.pred, z = y.pred,
    facets = NA, fit = fitpoints
  ),
  main = "Moderierte Regression"
)
