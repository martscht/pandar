#### Was bisher geschah: ----

# Daten laden
load(url("https://pandar.netlify.app/daten/fb24.rda"))

# Nominalskalierte Variablen in Faktoren verwandeln
fb24$hand_factor <- factor(fb24$hand,
  levels = 1:2,
  labels = c("links", "rechts")
)
fb24$fach <- factor(fb24$fach,
  levels = 1:5,
  labels = c("Allgemeine", "Biologische", "Entwicklung", "Klinische", "Diag./Meth.")
)
fb24$ziel <- factor(fb24$ziel,
  levels = 1:4,
  labels = c("Wirtschaft", "Therapie", "Forschung", "Andere")
)
fb24$wohnen <- factor(fb24$wohnen,
  levels = 1:4,
  labels = c("WG", "bei Eltern", "alleine", "sonstiges")
)
fb24$fach_klin <- factor(as.numeric(fb24$fach == "Klinische"),
  levels = 0:1,
  labels = c("nicht klinisch", "klinisch")
)
fb24$ort <- factor(fb24$ort, levels = c(1, 2), labels = c("FFM", "anderer"))
fb24$job <- factor(fb24$job, levels = c(1, 2), labels = c("nein", "ja"))
fb24$unipartys <- factor(fb24$uni3,
  levels = 0:1,
  labels = c("nein", "ja")
)

# Rekodierung invertierter Items
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 4 - 1)
fb24$mdbf11_r <- -1 * (fb24$mdbf11 - 4 - 1)
fb24$mdbf3_r <- -1 * (fb24$mdbf3 - 4 - 1)
fb24$mdbf9_r <- -1 * (fb24$mdbf9 - 4 - 1)
fb24$mdbf5_r <- -1 * (fb24$mdbf5 - 4 - 1)
fb24$mdbf7_r <- -1 * (fb24$mdbf7 - 4 - 1)

# Berechnung von Skalenwerten
fb24$wm_pre <- fb24[, c(
  "mdbf1", "mdbf5_r",
  "mdbf7_r", "mdbf10"
)] |> rowMeans()
fb24$gs_pre <- fb24[, c(
  "mdbf1", "mdbf4_r",
  "mdbf8", "mdbf11_r"
)] |> rowMeans()
fb24$ru_pre <- fb24[, c(
  "mdbf3_r", "mdbf6",
  "mdbf9_r", "mdbf12"
)] |> rowMeans()

# z-Standardisierung
fb24$ru_pre_zstd <- scale(fb24$ru_pre, center = TRUE, scale = TRUE)

## Einfaches Beispielmodell
## y ~ 1 + x

# ---- Zusammenhangsvisualisierung ----
plot(fb24$extra, fb24$nerd,
  xlab = "Extraversion", ylab = "Nerdiness",
  main = "Zusammenhang zwischen Extraversion und Nerdiness", xlim = c(0, 6), ylim = c(1, 5), pch = 19
)
lines(loess.smooth(fb24$extra, fb24$nerd), col = "blue") # beobachteter, lokaler Zusammenhang

# ---- Modellschätzung------------ ----
lm(formula = nerd ~ 1 + extra, data = fb24)

lin_mod <- lm(nerd ~ extra, fb24) # Modell erstellen und Ergebnisse im Objekt lin_mod ablegen

coef(lin_mod)
lin_mod$coefficients

formula(lin_mod)

# Scatterplot zuvor im Skript beschrieben
plot(fb24$extra, fb24$nerd,
  xlim = c(0, 6), ylim = c(1, 5), pch = 19
)
lines(loess.smooth(fb24$extra, fb24$nerd), col = "blue") # beobachteter, lokaler Zusammenhang
# Ergebnisse der Regression als Gerade aufnehmen
abline(lin_mod, col = "red")

# ---- Residuen------------------- ----
residuals(lin_mod)

# ---- Vorhergesagte-Werte-------- ----
predict(lin_mod)

extra_neu <- data.frame(extra = c(1, 2, 3, 4, 5))

predict(lin_mod, newdata = extra_neu)

# Konfidenzintervalle der Regressionskoeffizienten
confint(lin_mod)

# Detaillierte Modellergebnisse
summary(lin_mod)

# ---- Determinationskoeffizient-- ----
# Anhand der Varianz von lz
var(predict(lin_mod)) / var(fb24$nerd, use = "na.or.complete")

# Anhand der Summe der Varianzen
var(predict(lin_mod)) / (var(predict(lin_mod)) + var(resid(lin_mod)))

# Detaillierte Modellergebnisse
summary(lin_mod)

summary(lin_mod)$r.squared

# ---- Standardisierte-Regressionsgewichte ----
s_lin_mod <- lm(scale(nerd) ~ scale(extra), fb24) # standardisierte Regression
s_lin_mod

# Paket erst installieren (wenn nötig):
if (!requireNamespace("lm.beta", quietly = TRUE)) {
  install.packages("lm.beta")
}
library(lm.beta)

lin_model_beta <- lm.beta(lin_mod)
summary(lin_model_beta) # lin_mod |> lm.beta() |> summary()

cor(fb24$nerd, fb24$extra, use = "pairwise") # Korrelation
coef(s_lin_mod)["scale(extra)"] # Regressionsgewicht
round(coef(s_lin_mod)["scale(extra)"], 2) == round(cor(fb24$nerd, fb24$extra, use = "pairwise"), 2)

cor(fb24$nerd, fb24$extra, use = "pairwise")^2 # Quadrierte Korrelation
summary(s_lin_mod)$r.squared # Det-Koeffizient Modell mit standardisierten Variablen
round((cor(fb24$nerd, fb24$extra, use = "pairwise")^2), 3) == round(summary(s_lin_mod)$r.squared, 3)

cor(fb24$nerd, fb24$extra, use = "pairwise")^2 # Quadrierte Korrelation
summary(lin_mod)$r.squared # Det-Koeffizient Modell mit unstandardisierten Variablen
round((cor(fb24$nerd, fb24$extra, use = "pairwise")^2), 3) == round(summary(lin_mod)$r.squared, 3)
