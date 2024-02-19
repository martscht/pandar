#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb23.rda'))  

# Nominalskalierte Variablen in Faktoren verwandeln
fb23$hand_factor <- factor(fb23$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb23$fach <- factor(fb23$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb23$ziel <- factor(fb23$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))

fb23$wohnen <- factor(fb23$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

fb23$fach_klin <- factor(as.numeric(fb23$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))

fb23$ort <- factor(fb23$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb23$job <- factor(fb23$job, levels=c(1,2), labels=c("nein", "ja"))


# Rekodierung invertierter Items
fb23$mdbf4_pre_r <- -1 * (fb23$mdbf4_pre - 4 - 1)
fb23$mdbf11_pre_r <- -1 * (fb23$mdbf11_pre - 4 - 1)
fb23$mdbf3_pre_r <-  -1 * (fb23$mdbf3_pre - 4 - 1)
fb23$mdbf9_pre_r <-  -1 * (fb23$mdbf9_pre - 4 - 1)
fb23$mdbf5_pre_r <- -1 * (fb23$mdbf5_pre - 4 - 1)
fb23$mdbf7_pre_r <- -1 * (fb23$mdbf7_pre - 4 - 1)


# Berechnung von Skalenwerten
fb23$wm_pre  <- fb23[, c('mdbf1_pre', 'mdbf5_pre_r', 
                        'mdbf7_pre_r', 'mdbf10_pre')] |> rowMeans()
fb23$gs_pre  <- fb23[, c('mdbf1_pre', 'mdbf4_pre_r', 
                        'mdbf8_pre', 'mdbf11_pre_r')] |> rowMeans()
fb23$ru_pre <-  fb23[, c("mdbf3_pre_r", "mdbf6_pre", 
                         "mdbf9_pre_r", "mdbf12_pre")] |> rowMeans()

# Einfache Regression
mod1 <- lm(nerd ~ 1 + extra, data = fb23)

# Ergebnisse
summary(mod1)

r2 <- summary(mod1)$r.squared
b0 <- coef(mod1)[1]
b1 <- coef(mod1)[2]

cor.test(fb23$nerd, fb23$extra)

# Multiple Regression
mod2 <- lm(nerd ~ 1 + extra + vertr + gewis + neuro + offen, 
  data = fb23)

# Ergebnisse
summary(mod2)

mod_tmp <- lm(neuro ~ extra, fb23)
b1_tmp <- coef(mod_tmp)[2]

# Gewichte aus der multiple Regression
b0 <- coef(mod2)[1]
b1 <- coef(mod2)[2]

# Scatterplot
plot(fb23$nerd ~ fb23$extra, 
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
  mean(fb23$vertr, na.rm = TRUE), 
  mean(fb23$gewis, na.rm = TRUE), 
  mean(fb23$neuro, na.rm = TRUE), 
  mean(fb23$offen, na.rm = TRUE)))

a <- coef(mod2) %*% X

## abline(a = a, b = b1, col = "darkgreen")

# Scatterplot
plot(fb23$nerd ~ fb23$extra, 
     xlab = "Extraversion", 
     ylab = "Nerdiness")

abline(mod1, col = "blue")
abline(a = b0, b = b1, col = "orange")
abline(a = a, b = b1, col = "darkgreen")

legend("topright", legend = c("Einfache Reg.", "Multiple Reg.", "Multiple Reg. (MW)"), col = c("blue", "orange", "darkgreen"), lty = 1)

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

# Test des inkrementellen R2
anova(mod1, mod2)

mr_dat <- na.omit(fb23[, c("nerd", "extra", "vertr", "gewis", "neuro", "offen")])

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

summary(mod1_new)$r.squared

plot(mr_dat$nerd ~ mr_dat$extra, 
     xlab = "Extraversion", 
     ylab = "Nerdiness")
lines(lowess(mr_dat$extra, mr_dat$nerd), col = "red")
abline(mod1_new, col = "blue")

par(mfrow = c(2, 2))
for (i in 3:6) {
  plot(mr_dat$nerd ~ mr_dat[, i], 
       xlab = names(mr_dat)[i], 
       ylab = "Nerdiness")
  lines(lowess(mr_dat[, i], mr_dat$nerd), col = "red")
  abline(lm(nerd ~ 1 + mr_dat[, i], data = mr_dat), col = "blue")
}

pred <- predict(mod2_new)
res <- resid(mod2_new)

plot(pred, res, 
     xlab = "Vorhergesagte Werte", 
     ylab = "Residuen")

plot(mod2_new, which = 3)

mod4 <- lm(lz ~ 1 + extra, fb23)
plot(mod4, which = 3)

car::ncvTest(mod2_new)

car::ncvTest(mod4)

car::qqPlot(mod2_new)

shapiro.test(resid(mod2_new))
