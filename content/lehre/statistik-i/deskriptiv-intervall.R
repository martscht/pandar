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


dim(fb23)

fb23$lz

# Minimum & Maximum
range(fb23$lz, na.rm=T)

# Quartile & Median
quantile(fb23$lz, c(.25, .5, .75), na.rm=T)

#Box-Whisker Plot
boxplot(fb23$lz)

# Histogramm
hist(fb23$lz)

# Histogramm (20 Breakpoints anfordern)
hist(fb23$lz,
     breaks = 20)

# Histogramm (ungleiche Kategorien)
hist(fb23$lz,
     breaks = c(1, 3, 3.3, 3.6, 3.9, 4.5, 5, 7))

# Arithmetisches Mittel
mean(fb23$lz, na.rm = TRUE)

# Händische Varianzberechnung
sum((fb23$lz - mean(fb23$lz, na.rm = TRUE))^2, na.rm = TRUE) / (nrow(fb23)-2)

library("RXKCD")
invisible(getXKCD(851))

is.na(fb23$lz) |> sum()

na.omit(fb23$lz) |> length() # mit Pipe
length(na.omit(fb23$lz))     # ohne Pipe

# Händische Varianzberechnung
sum((fb23$lz - mean(fb23$lz, na.rm = TRUE))^2, na.rm = TRUE) / (length(na.omit(fb23$lz)))

# R-interne Varianzberechnung
var(fb23$lz, na.rm = TRUE)

# Umrechnung der Varianzen
var(fb23$lz, na.rm = TRUE) * (nrow(fb23) - 1) / nrow(fb23)

# Umrechnung der Varianzen
var(fb23$lz, na.rm = TRUE) * (length(na.omit(fb23$lz)) - 1) / (length(na.omit(fb23$lz)))

# Umrechnung der Varianzen
var(fb23$lz, na.rm = TRUE) * (177 - 1) / 177

# Standardabweichung in R
sd(fb23$lz, na.rm = TRUE) # Populationsschaetzer

# Umrechnung der Standardabweichung
sd(fb23$lz, na.rm = TRUE) * sqrt((177 - 1) / 177)

# Händische Berechnung der empirischen Standardabweichung
(sum((fb23$lz - mean(fb23$lz, na.rm = TRUE))^2,
    na.rm = TRUE) / (length(na.omit(fb23$lz)))) |> sqrt()

# Zentrierung
lz_c <- fb23$lz - mean(fb23$lz, na.rm = TRUE)
head(lz_c)    # erste 6 zentrierte Werte

# z-Standardisierung
lz_z <- lz_c / sd(fb23$lz, na.rm = TRUE)
head(lz_z)    # erste 6 z-standardisierte Werte

## Befehl zum z-Standardisieren
lz_z <- scale(fb23$lz, center = TRUE, scale = TRUE) # Mittelwert auf 0 und Varianz auf 1
## Befehl zum Zentrieren (ohne Varianzrelativierung)
lz_c <- scale(fb23$lz, center = TRUE, scale = FALSE) # setzt Varianz nicht auf 1

fb23$mdbf4_pre_r <- -1 * (fb23$mdbf4_pre - 5)
head(fb23$mdbf4_pre)     # erste 6 Werte ohne Transformation
head(fb23$mdbf4_pre_r)   # erste 6 Werte mit Transformation

head(fb23$mdbf11_pre == 1, 15) #Zeige die ersten 15 Antworten

fb23$mdbf11_pre_r[fb23$mdbf11_pre == 1] <- 4
fb23$mdbf11_pre_r[fb23$mdbf11_pre == 2] <- 3
fb23$mdbf11_pre_r[fb23$mdbf11_pre == 3] <- 2
fb23$mdbf11_pre_r[fb23$mdbf11_pre == 4] <- 1

head(fb23$mdbf11_pre)
head(fb23$mdbf11_pre_r)

# neuen Datensatz der relevanten Variablen erstellen 
gs_pre_data <- fb23[, c('mdbf1_pre', 'mdbf4_pre_r', 
                        'mdbf8_pre', 'mdbf11_pre_r')]
# Skalenwert in Originaldatensatz erstellen
fb23$gs_pre <- rowMeans(gs_pre_data)
head(fb23$gs_pre)

# Direkter Befehle
fb23$gs_pre  <- fb23[, c('mdbf1_pre', 'mdbf4_pre_r', 
                        'mdbf8_pre', 'mdbf11_pre_r')] |> rowMeans()
head(fb23$gs_pre )
