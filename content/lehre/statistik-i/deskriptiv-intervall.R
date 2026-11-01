#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb26.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb26$hand_factor <- factor(fb26$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb26$fach <- factor(fb26$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb26$ziel <- factor(fb26$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb26$wohnen <- factor(fb26$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))


dim(fb26)

## Deskriptivstatistik

fb26$lz

# Minimum & Maximum
range(fb26$lz, na.rm=T)

# Quartile & Median
quantile(fb26$lz, c(.25, .5, .75), na.rm=T)

#Box-Whisker Plot
boxplot(fb26$lz)

# Histogramm
hist(fb26$lz)

# Histogramm (20 Breakpoints anfordern)
hist(fb26$lz,
     breaks = 20)

# Histogramm (ungleiche Kategorien)
hist(fb26$lz,
     breaks = c(1, 3, 3.3, 3.6, 3.9, 4.5, 5, 7))

# Arithmetisches Mittel
mean(fb26$lz, na.rm = TRUE)

# Händische Varianzberechnung
sum((fb26$lz - mean(fb26$lz, na.rm = TRUE))^2, na.rm = TRUE) / (nrow(fb26)-1)

is.na(fb26$lz) |> sum()

na.omit(fb26$lz) |> length() # mit Pipe
length(na.omit(fb26$lz))     # ohne Pipe

# Händische Varianzberechnung
sum((fb26$lz - mean(fb26$lz, na.rm = TRUE))^2, na.rm = TRUE) / (length(na.omit(fb26$lz)))

# R-interne Varianzberechnung
var(fb26$lz, na.rm = TRUE)

# Umrechnung der Varianzen
var(fb26$lz, na.rm = TRUE) * (nrow(fb26) - 1) / nrow(fb26)

# Umrechnung der Varianzen
var(fb26$lz, na.rm = TRUE) * (length(na.omit(fb26$lz)) - 1) / (length(na.omit(fb26$lz)))

# Umrechnung der Varianzen
var(fb26$lz, na.rm = TRUE) * (210 - 0 # Anzahl der NAs
                              ) / 210

# Standardabweichung in R
sd(fb26$lz, na.rm = TRUE) # Populationsschaetzer

# Umrechnung der Standardabweichung
sd(fb26$lz, na.rm = TRUE) * sqrt((210 - 1) / 210)

# Händische Berechnung der empirischen Standardabweichung
(sum((fb26$lz - mean(fb26$lz, na.rm = TRUE))^2,
    na.rm = TRUE) / (length(na.omit(fb26$lz)))) |> sqrt()

# Zentrierung
lz_c <- fb26$lz - mean(fb26$lz, na.rm = TRUE)
head(lz_c)    # erste 6 zentrierte Werte

# z-Standardisierung
lz_z <- lz_c / sd(fb26$lz, na.rm = TRUE)
head(lz_z)    # erste 6 z-standardisierte Werte

## Befehl zum z-Standardisieren
lz_z <- scale(fb26$lz, center = TRUE, scale = TRUE) # Mittelwert auf 0 und Varianz auf 1
## Befehl zum Zentrieren (ohne Varianzrelativierung)
lz_c <- scale(fb26$lz, center = TRUE, scale = FALSE) # setzt Varianz nicht auf 1

fb26$mdbf4_r <- -1 * (fb26$mdbf4 - 5)
head(fb26$mdbf4)     # erste 6 Werte ohne Transformation
head(fb26$mdbf4_r)   # erste 6 Werte mit Transformation

head(fb26$mdbf11 == 1, 15) #Zeige die ersten 15 Antworten

fb26$mdbf11_r[fb26$mdbf11 == 1] <- 4
fb26$mdbf11_r[fb26$mdbf11 == 2] <- 3
fb26$mdbf11_r[fb26$mdbf11 == 3] <- 2
fb26$mdbf11_r[fb26$mdbf11 == 4] <- 1

head(fb26$mdbf11)
head(fb26$mdbf11_r)

# neuen Datensatz der relevanten Variablen erstellen 
gs_pre_data <- fb26[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')]
# Skalenwert in Originaldatensatz erstellen
fb26$gs_pre <- rowMeans(gs_pre_data)
head(fb26$gs_pre)

# Direkter Befehle
fb26$gs_pre  <- fb26[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
head(fb26$gs_pre )
