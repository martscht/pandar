#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb24.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb24$hand_factor <- factor(fb24$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb24$fach <- factor(fb24$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb24$ziel <- factor(fb24$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb24$wohnen <- factor(fb24$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))
fb24$fach_klin <- factor(as.numeric(fb24$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))
fb24$ort <- factor(fb24$ort, levels=c(1,2), labels=c("FFM", "anderer"))
fb24$job <- factor(fb24$job, levels=c(1,2), labels=c("nein", "ja"))
fb24$unipartys <- factor(fb24$uni3,
                             levels = 0:1,
                             labels = c("nein", "ja"))

# Rekodierung invertierter Items
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 4 - 1)
fb24$mdbf11_r <- -1 * (fb24$mdbf11 - 4 - 1)
fb24$mdbf3_r <-  -1 * (fb24$mdbf3 - 4 - 1)
fb24$mdbf9_r <-  -1 * (fb24$mdbf9 - 4 - 1)
fb24$mdbf5_r <- -1 * (fb24$mdbf5 - 4 - 1)
fb24$mdbf7_r <- -1 * (fb24$mdbf7 - 4 - 1)

# Berechnung von Skalenwerten
fb24$wm_pre  <- fb24[, c('mdbf1', 'mdbf5_r', 
                        'mdbf7_r', 'mdbf10')] |> rowMeans()
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb24$ru_pre <-  fb24[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb24$ru_pre_zstd <- scale(fb24$ru_pre, center = TRUE, scale = TRUE)


# Einfache Regression
mod1 <- lm(nerd ~ 1 + extra, data = fb24)

# Ergebnisse
summary(mod1)



cor.test(fb24$nerd, fb24$extra)

# Multiple Regression
mod2 <- lm(nerd ~ 1 + extra + vertr + gewis + neuro + offen, 
  data = fb24)

# Ergebnisse
summary(mod2)



# Gewichte aus der multiple Regression
b0 <- coef(mod2)[1]
b1 <- coef(mod2)[2]

# Scatterplot
plot(fb24$nerd ~ fb24$extra, 
     xlab = "Extraversion", 
     ylab = "Nerdiness")

# Ergebnis der einfachen Regression
abline(mod1, col = "blue")

# Ergebnis der multiplen Regression
abline(a = b0, b = b1, col = "orange")

# Legende
legend("topright", legend = c("Einfache Reg.", "Multiple Reg."), col = c("blue", "orange"), lty = 1)

# Achsenabschnitt bestimmen
X <- matrix(c(1, 0, 
  mean(fb24$vertr, na.rm = TRUE), 
  mean(fb24$gewis, na.rm = TRUE), 
  mean(fb24$neuro, na.rm = TRUE), 
  mean(fb24$offen, na.rm = TRUE)))

a <- coef(mod2) %*% X

# abline(a = a, b = b1, col = "darkgreen")



summary(mod2)$coefficients

summary(mod1)$r.squared

summary(mod2)$r.squared



# R2 durch Extraversion
R2e <- summary(mod1)$r.squared

# R2 durch alle Big Five
R2u <- summary(mod2)$r.squared

R2e
R2u

# Inkrementelles R2 der vier anderen
R2u - R2e

# # Test des inkrementellen R2
# anova(mod1, mod2)



mr_dat <- na.omit(fb24[, c("nerd", "extra", "vertr", "gewis", "neuro", "offen")])

# Modell 1, updated
mod1_new <- update(mod1, data = mr_dat)

# Modell 2, updated
mod2_new <- update(mod2, data = mr_dat)

# Test des inkrementellen R2
anova(mod1_new, mod2_new)

# Modell 3
mod3 <- lm(nerd ~ 1 + vertr + gewis + neuro + offen, data = mr_dat)

# Test des inkrementellen R2
anova(mod3, mod2_new)

# Inkrementelles R2
summary(mod2_new)$r.squared - summary(mod3)$r.squared

plot(mr_dat$nerd ~ mr_dat$extra, 
     xlab = "Extraversion", 
     ylab = "Nerdiness")
lines(lowess(mr_dat$extra, mr_dat$nerd), col = "red")
abline(mod1_new, col = "blue")



pred <- predict(mod2_new)
res <- resid(mod2_new)

plot(pred, res, 
     xlab = "Vorhergesagte Werte", 
     ylab = "Residuen")

plot(mod2_new, which = 3)

car::ncvTest(mod2_new)

car::qqPlot(mod2_new)

shapiro.test(resid(mod2_new))
