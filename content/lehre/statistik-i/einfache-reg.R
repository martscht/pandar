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

# z-Standardisierung
fb23$ru_pre_zstd <- scale(fb23$ru_pre, center = TRUE, scale = TRUE)


## y ~ 1 + x

plot(fb23$extra, fb23$nerd, xlab = "Extraversion", ylab = "Nerdiness", 
     main = "Zusammenhang zwischen Extraversion und Nerdiness", xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb23$extra, fb23$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang

lm(formula = nerd ~ 1 + extra, data = fb23)

lin_mod <- lm(nerd ~ extra, fb23)                  #Modell erstellen und Ergebnisse im Objekt lin_mod ablegen

coef(lin_mod) 
lin_mod$coefficients

formula(lin_mod)

# Scatterplot zuvor im Skript beschrieben
plot(fb23$extra, fb23$nerd, 
  xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb23$extra, fb23$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang
# Ergebnisse der Regression als Gerade aufnehmen
abline(lin_mod, col = 'red')

residuals(lin_mod)

fb23$res <- residuals(lin_mod)

predict(lin_mod)

extra_neu <- data.frame(extra = c(1, 2, 3, 4, 5))

predict(lin_mod, newdata = extra_neu)

#Konfidenzintervalle der Regressionskoeffizienten
confint(lin_mod)
confint <- confint(lin_mod)

#Detaillierte Modellergebnisse
summary(lin_mod)


# Anhand der Varianz von lz
var(predict(lin_mod)) / var(fb23$nerd, use = "na.or.complete")

# Anhand der Summe der Varianzen
var(predict(lin_mod)) / (var(predict(lin_mod)) + var(resid(lin_mod)))

#Detaillierte Modellergebnisse
summary(lin_mod)


summary(lin_mod)$r.squared

r2 <- summary(lin_mod)$r.squared*100

s_lin_mod <- lm(scale(nerd) ~ scale(extra), fb23) # standardisierte Regression
s_lin_mod

# Paket erst installieren (wenn nötig): install.packages("lm.beta")
library(lm.beta)

lin_model_beta <- lm.beta(lin_mod)
summary(lin_model_beta) # lin_mod |> lm.beta() |> summary()

cor(fb23$nerd, fb23$extra)   # Korrelation
coef(s_lin_mod)["scale(extra)"] # Regressionsgewicht
round(coef(s_lin_mod)["scale(extra)"],3) == round(cor(fb23$nerd, fb23$extra),3)

cor(fb23$nerd, fb23$extra)^2   # Quadrierte Korrelation
summary(s_lin_mod)$r.squared  # Det-Koeffizient Modell mit standardisierten Variablen
round((cor(fb23$nerd, fb23$extra)^2),3) == round(summary(s_lin_mod)$r.squared, 3)

cor(fb23$nerd, fb23$extra)^2   # Quadrierte Korrelation
summary(lin_mod)$r.squared  # Det-Koeffizient Modell mit unstandardisierten Variablen
round((cor(fb23$nerd, fb23$extra)^2),3) == round(summary(lin_mod)$r.squared, 3)
