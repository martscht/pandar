## Vorbereitung

#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb25.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb25$hand_factor <- factor(fb25$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb25$fach <- factor(fb25$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb25$ziel <- factor(fb25$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb25$wohnen <- factor(fb25$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))
fb25$fach_klin <- factor(as.numeric(fb25$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))
fb25$ort <- factor(fb25$ort, levels=c(1,2), labels=c("FFM", "anderer"))
fb25$job <- factor(fb25$job, levels=c(1,2), labels=c("nein", "ja"))
fb25$unipartys <- factor(fb25$uni3,
                             levels = 0:1,
                             labels = c("nein", "ja"))

# Rekodierung invertierter Items
fb25$mdbf4_r <- -1 * (fb25$mdbf4 - 4 - 1)
fb25$mdbf11_r <- -1 * (fb25$mdbf11 - 4 - 1)
fb25$mdbf3_r <-  -1 * (fb25$mdbf3 - 4 - 1)
fb25$mdbf9_r <-  -1 * (fb25$mdbf9 - 4 - 1)
fb25$mdbf5_r <- -1 * (fb25$mdbf5 - 4 - 1)
fb25$mdbf7_r <- -1 * (fb25$mdbf7 - 4 - 1)

# Berechnung von Skalenwerten
fb25$wm_pre  <- fb25[, c('mdbf1', 'mdbf5_r', 
                        'mdbf7_r', 'mdbf10')] |> rowMeans()
fb25$gs_pre  <- fb25[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb25$ru_pre <-  fb25[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb25$ru_pre_zstd <- scale(fb25$ru_pre, center = TRUE, scale = TRUE)


# Einfache Regression
mod1 <- lm(lz ~ 1 + neuro, data = fb25)

# Ergebnisse
summary(mod1)



cor.test(fb25$neuro, fb25$lz)

# Multiple Regression
mod2 <- lm(lz ~ 1 + neuro + vertr + extra + gewis + offen, 
  data = fb25)

# Ergebnisse
summary(mod2)



# Gewichte aus der multiple Regression
b0 <- coef(mod2)[1]
b1 <- coef(mod2)[2]

# Scatterplot
plot(fb25$lz ~ fb25$neuro, 
     xlab = "Neurotizismus", 
     ylab = "Lebenszufriedenheit")

# Ergebnis aus der einfachen Regression
abline(mod1, col = "blue")

# Ergebnis der multiplen Regression
abline(a = b0, b = b1, col = "orange")

# Legende
legend("topright", legend = c("Einfache Reg.", "Multiple Reg."), col = c("blue", "orange"), lty = 1)

# Achsenabschnitt bestimmen
X <- matrix(c(1, 0, 
  mean(fb25$vertr, na.rm = TRUE), 
  mean(fb25$extra, na.rm = TRUE), 
  mean(fb25$gewis, na.rm = TRUE), 
  mean(fb25$offen, na.rm = TRUE)))

a <- coef(mod2) %*% X





summary(mod2)$coefficients |> round(3)
# Runden auf 3 Nachkommastellen für bessere Lesbarkeit

summary(mod1)$r.squared

summary(mod2)$r.squared



# R2 durch Gewissenhaftigkeit
R2e <- summary(mod1)$r.squared

# R2 durch alle Big Five
R2u <- summary(mod2)$r.squared

R2e
R2u

# Inkrementelles R2 der vier anderen Prädiktoren
R2u - R2e





# Daten ohne fehlende Werte auf den relevanten Variablen
mr_dat <- na.omit(fb25[, c("lz", "neuro", "vertr", "extra", "gewis", "offen")])

# Modell 1, updated
mod1_new <- update(mod1, data = mr_dat)

# Modell 2, updated
mod2_new <- update(mod2, data = mr_dat)

# Test des inkrementellen R2
anova(mod1_new, mod2_new)

# Modell 3
mod3 <- lm(lz ~ vertr + extra + gewis + offen, data = mr_dat)

# Test des inkrementellen R2
anova(mod3, mod2_new)

# Inkrementelles R2
summary(mod2_new)$r.squared - summary(mod3)$r.squared

plot(mr_dat$lz ~ mr_dat$neuro, 
     xlab = "Neurotizismus", 
     ylab = "Lebenszufriedenheit")
lines(loess.smooth(mr_dat$neuro, mr_dat$lz), col = "blue")
abline(mod1_new, col = "red")



pred <- predict(mod2_new)
res <- resid(mod2_new)

plot(pred, res, 
     xlab = "Vorhergesagte Werte", 
     ylab = "Residuen")

plot(mod2_new, which = 3)

car::ncvTest(mod2_new)

car::qqPlot(mod2_new)

shapiro.test(resid(mod2_new))
