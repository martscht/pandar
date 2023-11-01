#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb22.rda'))  

# Nominalskalierte Variablen in Faktoren verwandeln
fb22$geschl_faktor <- factor(fb22$geschl,
                             levels = 1:3,
                             labels = c("weiblich", "männlich", "anderes"))
fb22$fach <- factor(fb22$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb22$ziel <- factor(fb22$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))

fb22$wohnen <- factor(fb22$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

fb22$ort <- factor(fb22$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb22$job <- factor(fb22$job, levels=c(1,2), labels=c("nein", "ja"))
# Skalenbildung

fb22$prok2_r <- -1 * (fb22$prok2 - 5)
fb22$prok3_r <- -1 * (fb22$prok3 - 5)
fb22$prok5_r <- -1 * (fb22$prok5 - 5)
fb22$prok7_r <- -1 * (fb22$prok7 - 5)
fb22$prok8_r <- -1 * (fb22$prok8 - 5)

# Prokrastination
fb22$prok_ges <- fb22[, c('prok1', 'prok2_r', 'prok3_r',
                          'prok4', 'prok5_r', 'prok6',
                          'prok7_r', 'prok8_r', 'prok9', 
                          'prok10')] |> rowMeans()
# Naturverbundenheit
fb22$nr_ges <-  fb22[, c('nr1', 'nr2', 'nr3', 'nr4', 'nr5',  'nr6')] |> rowMeans()
fb22$nr_ges_z <- scale(fb22$nr_ges) # Standardisiert

# Weitere Standardisierungen
fb22$nerd_std <- scale(fb22$nerd)
fb22$neuro_std <- scale(fb22$neuro)


lin_mod <- lm(nerd ~ extra, fb22)                  #Modell erstellen und Ergebnisse im Objekt lin_mod ablegen

plot(fb22$extra, fb22$nerd, xlab = "Extraversion", ylab = "Nerdiness", 
     main = "Zusammenhang zwischen Extraversion und Nerdiness", xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb22$extra, fb22$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang

par(mfrow = c(2, 2)) #vier Abbildungen gleichzeitig
plot(lin_mod)
par(mfrow = c(1, 1)) #wieder auf eine Abbildung zurücksetzen

res1 <- residuals(lin_mod)   #Residuen speichern 

#QQ
qqnorm(res1)
qqline(res1)

#Histogramm
hist(res1, prob = T,ylim = c(0,1))    #prob: TRUE, da wir uns auf die Dichte beziehen
curve(dnorm(x, 
            mean = mean(res1, na.rm = T), 
            sd = sd(res1, na.rm = T)),
      main = "Histogram of residuals", ylab = "Residuals",
      col = "blue", add = T)   #add: soll Kurve in Grafik hinzugefügt werden?

#Shapiro
shapiro.test(res1)

## y ~ 1 + x

lm(formula = nerd ~ 1 + extra, data = fb22)

lin_mod <- lm(nerd ~ extra, fb22)

coef(lin_mod)

formula(lin_mod)

residuals(lin_mod)

fb22$res <- residuals(lin_mod)

predict(lin_mod)

extra_neu <- data.frame(extra = c(1, 2, 3, 4, 5))

predict(lin_mod, newdata = extra_neu)

# Scatterplot zuvor im Skript beschrieben
plot(fb22$extra, fb22$nerd, 
  xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb22$extra, fb22$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang
# Ergebnisse der Regression als Gerade aufnehmen
abline(lin_mod, col = 'red')

s_lin_mod <- lm(scale(nerd) ~ scale(extra), fb22)
s_lin_mod

# Anhand der Varianz von lz
var(predict(lin_mod)) / var(fb22$nerd, use = "na.or.complete")

# Anhand der Summe der Varianzen
var(predict(lin_mod)) / (var(predict(lin_mod)) + var(resid(lin_mod)))

#Detaillierte Modellergebnisse
summary(lin_mod)


summary(lin_mod)$r.squared

r2 <- summary(lin_mod)$r.squared*100

cor(fb22$nerd, fb22$extra)   # Korrelation
s_lin_mod <- lm(scale(nerd) ~ scale(extra), fb22) # Regression mit standardisierten Variablen
s_lin_mod
round(coef(s_lin_mod)["scale(extra)"],3) == round(cor(fb22$nerd, fb22$extra),3)

cor(fb22$nerd, fb22$extra)^2   # Quadrierte Korrelation
summary(s_lin_mod)$ r.squared  # Det-Koeffizient Modell mit standardisierten Variablen
round((cor(fb22$nerd, fb22$extra)^2),3) == round(summary(s_lin_mod)$ r.squared, 3)

cor(fb22$nerd, fb22$extra)^2   # Quadrierte Korrelation
summary(lin_mod)$ r.squared  # Det-Koeffizient Modell mit unstandardisierten Variablen
round((cor(fb22$nerd, fb22$extra)^2),3) == round(summary(lin_mod)$ r.squared, 3)

#Konfidenzintervalle der Regressionskoeffizienten
confint(lin_mod)
confint <- confint(lin_mod)

#Detaillierte Modellergebnisse
summary(lin_mod)

