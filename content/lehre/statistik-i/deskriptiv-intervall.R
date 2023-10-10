#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/post/fb22.rda'))  

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


fb22$lz

# Minimum & Maximum
range(fb22$lz, na.rm=T)

# Quartile
quantile(fb22$lz, c(.25, .5, .75), na.rm=T)

#Box-Whisker Plot
boxplot(fb22$lz)

# Histogramm
hist(fb22$lz)

# Histogramm (20 Breakpoints anfordern)
hist(fb22$lz,
     breaks = 20)

# Histogramm (ungleiche Kategorien)
hist(fb22$lz,
     breaks = c(1, 3, 3.3, 3.6, 3.9, 4.5, 5, 7))

# Arithmetisches Mittel
mean(fb22$lz, na.rm = TRUE)

# Händische Varianzberechnung
sum((fb22$lz - mean(fb22$lz, na.rm = TRUE))^2, na.rm = TRUE) / (nrow(fb22)-2)

library("RXKCD")
invisible(getXKCD(851))

is.na(fb22$lz) |> sum()

na.omit(fb22$lz) |> length() # mit Pipe
length(na.omit(fb22$lz))     # ohne Pipe

# Händische Varianzberechnung
sum((fb22$lz - mean(fb22$lz, na.rm = TRUE))^2, na.rm = TRUE) / (length(na.omit(fb22$lz)))

# R-interne Varianzberechnung
var(fb22$lz, na.rm = TRUE)

# Umrechnung der Varianzen
var(fb22$lz, na.rm = TRUE) * (nrow(fb22) - 1) / nrow(fb22)

# Umrechnung der Varianzen
var(fb22$lz, na.rm = TRUE) * (length(na.omit(fb22$lz)) - 1) / (length(na.omit(fb22$lz)))

# Umrechnung der Varianzen
var(fb22$lz, na.rm = TRUE) * (157 - 1) / 157

# Standardabweichung in R
sd(fb22$lz, na.rm = TRUE) # Populationsschaetzer

# Umrechnung der Standardabweichung
sd(fb22$lz, na.rm = TRUE) * sqrt((157 - 1) / 157)

# Händische Berechnung der empirischen Standardabweichung
(sum((fb22$lz - mean(fb22$lz, na.rm = TRUE))^2,
    na.rm = TRUE) / (length(na.omit(fb22$lz)))) |> sqrt()

# Zentrierung
lz_c <- fb22$lz - mean(fb22$lz, na.rm = TRUE)
head(lz_c)    # erste 6 zentrierte Werte

# Standardisierung
lz_z <- lz_c / sd(fb22$lz, na.rm = TRUE)
head(lz_z)    # erste 6 standardisierte Werte

## Befehl zum Standardisieren
lz_z <- scale(fb22$lz)
## Befehl zum Zentrieren (ohne Standardisierung)
lz_c <- scale(fb22$lz,
              scale = FALSE) # unterbindet Standardisierung

fb22$prok2_r <- -1 * (fb22$prok2 - 5)
head(fb22$prok2)     # erste 6 Werte ohne Transformation
head(fb22$prok2_r)   # erste 6 Werte mit Transformation

head(fb22$prok3 == 1, 15) #Zeige die ersten 15 Antworten

fb22$prok3_r[fb22$prok3 == 1] <- 4
fb22$prok3_r[fb22$prok3 == 2] <- 3
fb22$prok3_r[fb22$prok3 == 3] <- 2
fb22$prok3_r[fb22$prok3 == 4] <- 1

head(fb22$prok3)
head(fb22$prok3_r)

fb22$prok5_r <- -1 * (fb22$prok5 - 5)
fb22$prok7_r <- -1 * (fb22$prok7 - 5)
fb22$prok8_r <- -1 * (fb22$prok8 - 5)

# Datensatz der relevanten Variablen
prokrastination <- fb22[, c('prok1', 'prok2_r', 'prok3_r',
                            'prok4', 'prok5_r', 'prok6', 
                            'prok7_r', 'prok8_r', 'prok9', 
                            'prok10')]
# Skalenwert in Originaldatensatz erstellen
fb22$prok_ges <- rowMeans(prokrastination)
head(fb22$prok_ges)

# Direkter Befehle
fb22$prok_ges <- fb22[, c('prok1', 'prok2_r', 'prok3_r',
                          'prok4', 'prok5_r', 'prok6',
                          'prok7_r', 'prok8_r', 'prok9', 
                          'prok10')] |> rowMeans()
head(fb22$prok_ges)
