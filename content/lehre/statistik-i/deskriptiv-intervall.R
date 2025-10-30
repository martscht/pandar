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


dim(fb25)

## Deskriptivstatistik

fb25$lz

# Minimum & Maximum
range(fb25$lz, na.rm=T)

# Quartile & Median
quantile(fb25$lz, c(.25, .5, .75), na.rm=T)

#Box-Whisker Plot
boxplot(fb25$lz)

# Histogramm
hist(fb25$lz)

# Histogramm (20 Breakpoints anfordern)
hist(fb25$lz,
     breaks = 20)

# Histogramm (ungleiche Kategorien)
hist(fb25$lz,
     breaks = c(1, 3, 3.3, 3.6, 3.9, 4.5, 5, 7))

# Arithmetisches Mittel
mean(fb25$lz, na.rm = TRUE)

# Händische Varianzberechnung
sum((fb25$lz - mean(fb25$lz, na.rm = TRUE))^2, na.rm = TRUE) / (nrow(fb25)-1)



is.na(fb25$lz) |> sum()

na.omit(fb25$lz) |> length() # mit Pipe
length(na.omit(fb25$lz))     # ohne Pipe

# Händische Varianzberechnung
sum((fb25$lz - mean(fb25$lz, na.rm = TRUE))^2, na.rm = TRUE) / (length(na.omit(fb25$lz)))

# R-interne Varianzberechnung
var(fb25$lz, na.rm = TRUE)

# Umrechnung der Varianzen
var(fb25$lz, na.rm = TRUE) * (nrow(fb25) - 1) / nrow(fb25)

# Umrechnung der Varianzen
var(fb25$lz, na.rm = TRUE) * (length(na.omit(fb25$lz)) - 1) / (length(na.omit(fb25$lz)))

# Umrechnung der Varianzen
var(fb25$lz, na.rm = TRUE) * (210 - 1) / 210

# Standardabweichung in R
sd(fb25$lz, na.rm = TRUE) # Populationsschaetzer

# Umrechnung der Standardabweichung
sd(fb25$lz, na.rm = TRUE) * sqrt((210 - 1) / 210)

# Händische Berechnung der empirischen Standardabweichung
(sum((fb25$lz - mean(fb25$lz, na.rm = TRUE))^2,
    na.rm = TRUE) / (length(na.omit(fb25$lz)))) |> sqrt()

# Zentrierung
lz_c <- fb25$lz - mean(fb25$lz, na.rm = TRUE)
head(lz_c)    # erste 6 zentrierte Werte

# z-Standardisierung
lz_z <- lz_c / sd(fb25$lz, na.rm = TRUE)
head(lz_z)    # erste 6 z-standardisierte Werte

## Befehl zum z-Standardisieren
lz_z <- scale(fb25$lz, center = TRUE, scale = TRUE) # Mittelwert auf 0 und Varianz auf 1
## Befehl zum Zentrieren (ohne Varianzrelativierung)
lz_c <- scale(fb25$lz, center = TRUE, scale = FALSE) # setzt Varianz nicht auf 1

fb25$mdbf4_r <- -1 * (fb25$mdbf4 - 5)
head(fb25$mdbf4)     # erste 6 Werte ohne Transformation
head(fb25$mdbf4_r)   # erste 6 Werte mit Transformation

head(fb25$mdbf11 == 1, 15) #Zeige die ersten 15 Antworten

fb25$mdbf11_r[fb25$mdbf11 == 1] <- 4
fb25$mdbf11_r[fb25$mdbf11 == 2] <- 3
fb25$mdbf11_r[fb25$mdbf11 == 3] <- 2
fb25$mdbf11_r[fb25$mdbf11 == 4] <- 1

head(fb25$mdbf11)
head(fb25$mdbf11_r)

# neuen Datensatz der relevanten Variablen erstellen 
gs_pre_data <- fb25[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')]
# Skalenwert in Originaldatensatz erstellen
fb25$gs_pre <- rowMeans(gs_pre_data)
head(fb25$gs_pre)

# Direkter Befehle
fb25$gs_pre  <- fb25[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
head(fb25$gs_pre )
