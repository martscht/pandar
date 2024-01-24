knitr::opts_chunk$set(echo = TRUE)

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


dim(fb22)
str(fb22)

plot(fb22$extra, fb22$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)

plot(fb22$vertr, fb22$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)

plot(fb22$gewis, fb22$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)

plot(fb22$neuro, fb22$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)

plot(fb22$intel, fb22$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)

fme <- lm(lz ~ extra, fb22)
summary(fme)

fmv <- lm(lz ~ vertr, fb22)
summary(fmv)

fmg <- lm(lz ~ gewis, fb22)
summary(fmg)

fmn <- lm(lz ~ neuro, fb22)
summary(fmn)

fmi <- lm(lz ~ intel, fb22)
summary(fmi)

plot(fb22$intel, fb22$lz, xlab = "Intellekt", ylab = "Lebenszufriedenheit", 
     main = "Zusammenhang zwischen Intellekt und Lebenszufriedenheit", xlim = c(0, 6), ylim = c(0, 7), pch = 19)
lines(loess.smooth(fb22$intel, fb22$lz), col = 'blue')    #beobachteter, lokaler Zusammenhang
fmi <- lm(lz ~ intel, fb22)                              #Modell erstellen und ablegen
abline(fmi, col = "red")                                  #Modellierter linearer Zusammenhang in zuvor erstellten Plot einzeichnen

par(mfrow = c(2, 2)) #Vier Abbildungen gleichzeitig
plot(fmi)
par(mfrow = c(1, 1)) #wieder auf eine Abbildung zurücksetzen

sfmi <- lm(scale(lz) ~ scale(intel), fb22)
sfmi


plot(fb22$neuro, fb22$lz, xlim = c(0, 6), ylim = c(0, 7), pch = 19)
abline(fmn, col = "red")

summary(fmn)
sum_fmn <- summary(fmn)

new <- data.frame(neuro = c(1.25, 2.75, 3.5, 4.25, 3.75, 2.15))
predict(fmn, newdata = new)
