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


# # Einfaches Beispielmodell
# y ~ 1 + x

## Zusammenhangsvisualisierung

plot(fb25$gewis, fb25$trust, xlab = "Gewissenhaftigkeit", ylab = "Vertrauen in die Psychologie als Wissenschaft", 
     main = "Zusammenhang zwischen Gewissenhaftigkeit und Vertrauen in die Psychologie als Wissenschaft", xlim = c(0, 6), ylim = c(1, 5), pch = 19)

plot(fb25$gewis, fb25$trust, xlab = "Gewissenhaftigkeit", ylab = "Vertrauen in die Psychologie als Wissenschaft", 
     main = "Zusammenhang zwischen Gewissenhaftigkeit und Vertrauen in die Psychologie als Wissenschaft", xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb25$gewis, fb25$trust), col = 'blue')    #beobachteter, lokaler Zusammenhang

## Modellschätzung

lm(formula = trust ~ 1 + gewis, data = fb25)

lin_mod <- lm(trust ~ gewis, fb25)                  #Modell erstellen und Ergebnisse im Objekt lin_mod ablegen

formula(lin_mod)

coef(lin_mod) 
lin_mod$coefficients

# Scatterplot zuvor im Skript beschrieben
plot(fb25$gewis, fb25$trust, 
  xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb25$gewis, fb25$trust), col = 'blue')    #beobachteter, lokaler Zusammenhang
# Ergebnisse der Regression als Gerade aufnehmen
abline(lin_mod, col = 'red')

## Residuen
residuals(lin_mod)

## vorhergesate Werte
predict(lin_mod)

gewis_neu <- data.frame(gewis = c(1, 2, 3, 4, 5))

predict(lin_mod, newdata = gewis_neu)

#Konfidenzintervalle der Regressionskoeffizienten
confint(lin_mod)



#Detaillierte Modellergebnisse
summary(lin_mod)


## Determinationskoeffizient R^2

# Anhand der Varianz von lz
var(predict(lin_mod)) / var(fb25$trust, use = "na.or.complete")

# Anhand der Summe der Varianzen
var(predict(lin_mod)) / (var(predict(lin_mod)) + var(resid(lin_mod)))

#Detaillierte Modellergebnisse
summary(lin_mod)


summary(lin_mod)$r.squared



## Standardisierte Regressionsgewichte

s_lin_mod <- lm(scale(trust) ~ scale(gewis), fb25) # standardisierte Regression
s_lin_mod

# Paket erst installieren (wenn nötig):
if (!requireNamespace("lm.beta", quietly = TRUE)) {
  install.packages("lm.beta")
}
library(lm.beta)

lin_model_beta <- lm.beta(lin_mod)
summary(lin_model_beta) # lin_mod |> lm.beta() |> summary()

cor(fb25$trust, fb25$gewis, use = "pairwise")   # Korrelation
coef(lin_model_beta)["gewis"] # Regressionsgewicht
round(coef(lin_model_beta)["gewis"],2) == round(cor(fb25$trust, fb25$gewis,use = "pairwise"),2)

cor(fb25$trust, fb25$gewis,  use = "pairwise")^2   # Quadrierte Korrelation
summary(lin_model_beta)$r.squared  # Det-Koeffizient Modell mit standardisierten Variablen
round((cor(fb25$trust, fb25$gewis, use = "pairwise")^2),3) == round(summary(lin_model_beta)$r.squared, 3)

cor(fb25$trust, fb25$gewis,  use = "pairwise")^2   # Quadrierte Korrelation
summary(lin_mod)$r.squared  # Det-Koeffizient Modell mit unstandardisierten Variablen
round((cor(fb25$trust, fb25$gewis,  use = "pairwise")^2),3) == round(summary(lin_mod)$r.squared, 3)
