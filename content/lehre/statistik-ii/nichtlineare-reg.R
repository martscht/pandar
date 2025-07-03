#### Vorbereitung ----
# Datensatz laden
source("https://pandar.netlify.app/daten/Data_Processing_vegan.R")

#### Detektieren von Non-Linearität ----

# Einfache lineare Regression
mod_lin <- lm(commitment ~ animals, data = vegan)

# Ergebnisse
summary(mod_lin)

# car laden
library(car)

# Residuenplot
residualPlot(mod_lin)

#### LOESS-Linien ----
# ggplot2 laden
library(ggplot2)

# Scatterplot mit LOESS-Linie
ggplot(data = vegan, aes(x = animals, y = commitment)) +
  geom_point() +
  geom_smooth() +
  labs(title = "Scatterplot mit LOESS-Linie")

a <- 1
b <- 0
c <- 0
x <- seq(-2, 2, 0.01)
f <- a * x^2 + b * x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x, y = f)) +
  geom_line(col = "black") +
  labs(
    x = "x", y = "f(x)",
    title = expression("f(x)=" ~ x^2)
  )

a <- 0.5
b <- 0
c <- 0
x <- seq(-2, 2, 0.01)
f <- a * x^2 + b * x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x, y = f)) +
  geom_line(col = "blue", lwd = 2) +
  geom_line(mapping = aes(x, x^2), lty = 3) +
  labs(
    x = "x", y = "f(x)",
    title = expression("f(x)=" ~ 0.5 * x^2)
  )

a <- 2
b <- 0
c <- 0
x <- seq(-2, 2, 0.01)
f <- a * x^2 + b * x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x, y = f)) +
  geom_line(col = "blue", lwd = 2) +
  geom_line(mapping = aes(x, x^2), lty = 3) +
  labs(
    x = "x", y = "f(x)",
    title = expression("f(x)=" ~ 2 * x^2)
  )

a <- -1
b <- 0
c <- 0
x <- seq(-2, 2, 0.01)
f <- a * x^2 + b * x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x, y = f)) +
  geom_line(col = "blue", lwd = 2) +
  geom_line(mapping = aes(x, x^2), lty = 3) +
  labs(
    x = "x", y = "f(x)",
    title = expression("f(x)=" ~ -x^2)
  )

a <- 1
b <- 0
c <- 1
x <- seq(-2, 2, 0.01)
f <- a * x^2 + b * x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x, y = f)) +
  geom_line(col = "blue", lwd = 2) +
  geom_line(mapping = aes(x, x^2), lty = 3) +
  labs(
    x = "x", y = "f(x)",
    title = expression("f(x)=" ~ x^2 + 1)
  )

a <- 1
b <- 1
c <- 0
x <- seq(-2, 2, 0.01)
f <- a * x^2 + b * x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x, y = f)) +
  geom_line(col = "blue", lwd = 2) +
  geom_line(mapping = aes(x, x^2), lty = 3) +
  labs(
    x = "x", y = "f(x)",
    title = expression("f(x)=" ~ x^2 + x)
  )

a <- -0.5
b <- 1
c <- 2
x <- seq(-2, 2, 0.01)
f <- a * x^2 + b * x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x, y = f)) +
  geom_line(col = "blue", lwd = 2) +
  geom_line(mapping = aes(x, x^2), lty = 3) +
  labs(
    x = "x", y = "f(x)",
    title = expression("f(x)=" ~ -0.5 * x^2 + x + 2)
  )

#### Aufnahme quadratischer Effekte ----
# Quadrierter Prädiktor
vegan$animals2 <- vegan$animals^2

# Modell
mod_quad <- lm(commitment ~ animals + animals2, data = vegan)

# Ergebnisse
summary(mod_quad)

# Korrelation
cor(vegan$animals, vegan$animals2)

# VIF
vif(mod_quad)

# Beispielwerte erstellen und quadrieren
A <- 0:9
A2 <- A^2

# Gegenüberstellung
cbind(A, A2)

# Zentrierung
Ac <- scale(A, scale = FALSE)
Ac2 <- Ac^2

# Gegenüberstellung
cbind(Ac, Ac2)

# Zentrierung des Prädiktors
vegan$animals_c <- scale(vegan$animals, scale = FALSE)

# Quadrieren
vegan$animals_c2 <- vegan$animals_c^2

# Korrelation
cor(vegan$animals_c, vegan$animals_c2)

# Beispielwerte erstellen und quadrieren
B <- c(0, 0, 0, 0, 0, 2, 4, 6, 8, 9)
Bc <- scale(B, scale = FALSE)
Bc2 <- Bc^2

# Gegenüberstellung
cbind(Bc, Bc2)

# Korrelation
cor(Bc, Bc2)

# Beispielwerte erstellen und quadrieren
B <- c(0, 0, 0, 0, 0, 2, 4, 6, 8, 9, 9, 9, 9, 9)
Bc <- scale(B, scale = FALSE)
Bc2 <- Bc^2

# Korrelation
cor(Bc, Bc2)

# Histogramm
hist(vegan$animals)

# Modell mit zentriertem Prädiktor
mod_quad_c <- lm(commitment ~ animals_c + animals_c2, data = vegan)

# VIF
vif(mod_quad_c)

# Modell mit poly()-Prädiktor
mod_quad_poly <- lm(commitment ~ poly(animals, 2), data = vegan)

# Modellergebnisse
summary(mod_quad_poly)

# R-Quadrat, Rohwerte
summary(mod_quad)$r.squared

# R-Quadrat, Zentrierung
summary(mod_quad_c)$r.squared

# R-Quadrat, poly()
summary(mod_quad_poly)$r.squared

# Modellvergleich, Rohwerte
anova(mod_lin, mod_quad)

# Modellvergleich, Zentrierung
anova(mod_lin, mod_quad_c)

# Modellvergleich, poly()
anova(mod_lin, mod_quad_poly)

# Modellergebnisse, Rohwerte
summary(mod_quad)$coef

# Modellergebnisse, Zentrierung
summary(mod_quad_c)$coef

# Modellergebnisse, poly()
summary(mod_quad_poly)$coef

# Vorhersagen, Rohwerte
predict(mod_quad)[1:3]

# Vorhersagen, Zentrierung
predict(mod_quad_c)[1:3]

# Vorhersagen, poly()
predict(mod_quad_poly)[1:3]

# Abbildung des Modells
ggplot(data = vegan, aes(x = animals, y = commitment)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), col = "#00618f", se = FALSE) +
  geom_smooth(method = "lm", formula = y ~ x, col = "#e3ba0f", se = FALSE)
labs(title = "Scatterplot mit quadratischer Regression")

# Modell mit kubischem Effekt
mod_cubic <- lm(commitment ~ poly(animals, 3), data = vegan)

# Modellvergleich
anova(mod_quad_poly, mod_cubic)

# Abbildung des Modells
ggplot(data = vegan, aes(x = animals, y = commitment)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ poly(x, 3), col = "#ad3b76", se = FALSE) +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), col = "#00618f", se = FALSE) +
  geom_smooth(method = "lm", formula = y ~ x, col = "#e3ba0f", se = FALSE) +
  labs(title = "Scatterplot mit polynomialen Regressionsmodellen")

#### Logarithmische Effekte ----
# Daten einlesen
source("https://pandar.netlify.app/daten/Data_Processing_trivia.R")

# Einschränken auf Pinnochio
trivia <- subset(trivia, headline == 3)

# Lineare Regression
mod_lin <- lm(rating ~ repetition, data = trivia)

# Ergebnisse
summary(mod_lin)

# Logarithmische Regression
mod_log <- lm(rating ~ log(repetition), data = trivia)

# Ergebnisse
summary(mod_log)

# Abbildung der Modelle
ggplot(data = trivia, aes(x = repetition, y = rating)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x, col = "#e3ba0f", se = FALSE) +
  geom_smooth(method = "lm", formula = y ~ log(x, base = 10), col = "#00618f", se = FALSE) +
  labs(title = "Scatterplot mit linearer und logarithmischer Regression")

# AIC der Modelle
AIC(mod_lin, mod_log)

# Wertereihe
newX <- data.frame(repetition = c(1, 2, 4, 8, 16))

# Vorhersage
pred_log <- predict(mod_log, newdata = newX)
cbind(newX, pred_log)

# Differenzen
diff(pred_log)

# Logarithmische Regression, Basis 2
mod_log2 <- lm(rating ~ log(repetition, base = 2), data = trivia)

# Ergebnisse
summary(mod_log2)

# R-Quadrat der Modelle
summary(mod_log)$r.squared
summary(mod_log2)$r.squared

# AIC der Modelle
AIC(mod_log, mod_log2)

# ---- Appendix A----------------- ----
A <- seq(0, 10, 0.1)

cor(A, A^2)

A_c <- A - mean(A)
mean(A_c)

A_c2 <- scale(A, center = T, scale = F) # scale = F bewirkt, dass nicht auch noch die SD auf 1 gesetzt werden soll
mean(A_c2)

cor(A_c, A_c^2)
cor(poly(A, 2))

# auf 15 Nachkommastellen gerundet:
round(cor(A_c, A_c^2), 15)
round(cor(poly(A, 2)), 15)

# auf 15 Nachkommastellen gerundet:
round(cor(cbind(A, A^2, A^3, A^4)), 2)
round(cor(cbind(A_c, A_c^2, A_c^3, A_c^4)), 2)
round(cor(poly(A, 4)), 2)

var(A)
var(A_c)

# Kovarianz
cov(A, A^2)
2 * mean(A) * var(A)

# zentriert:
round(cov(A_c, A_c^2), 14)
round(2 * mean(A_c) * var(A_c), 14)

# ---- Appendix B----------------- ----
# gleiches Ergebnis:
10^3
exp(3 * log(10))

# gleiches Ergebnis:
log(10^3, base = 10) # Logarithmus von 1000 zur Basis 10
log(10^3) / log(10) # mit ln

# gleiches Ergebnis:
log(9, base = 3) # Logarithmus von 9 zur Basis 3
log(9) / log(3) # mit ln
