#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb24.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb24$hand_factor <- factor(fb24$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb24$fach <- factor(fb24$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb24$ziel <- factor(fb24$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb24$wohnen <- factor(fb24$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))


dim(fb24)

## Deskriptivstatistik

fb24$lz

# Minimum & Maximum
range(fb24$lz, na.rm=T)

# Quartile & Median
quantile(fb24$lz, c(.25, .5, .75), na.rm=T)

#Box-Whisker Plot
boxplot(fb24$lz)

# Histogramm
hist(fb24$lz)

# Histogramm (20 Breakpoints anfordern)
hist(fb24$lz,
     breaks = 20)

# Histogramm (ungleiche Kategorien)
hist(fb24$lz,
     breaks = c(1, 3, 3.3, 3.6, 3.9, 4.5, 5, 7))

# Arithmetisches Mittel
mean(fb24$lz, na.rm = TRUE)

# Händische Varianzberechnung
sum((fb24$lz - mean(fb24$lz, na.rm = TRUE))^2, na.rm = TRUE) / (nrow(fb24)-2)



is.na(fb24$lz) |> sum()

na.omit(fb24$lz) |> length() # mit Pipe
length(na.omit(fb24$lz))     # ohne Pipe

# Händische Varianzberechnung
sum((fb24$lz - mean(fb24$lz, na.rm = TRUE))^2, na.rm = TRUE) / (length(na.omit(fb24$lz)))

# R-interne Varianzberechnung
var(fb24$lz, na.rm = TRUE)

# Umrechnung der Varianzen
var(fb24$lz, na.rm = TRUE) * (nrow(fb24) - 1) / nrow(fb24)

# Umrechnung der Varianzen
var(fb24$lz, na.rm = TRUE) * (length(na.omit(fb24$lz)) - 1) / (length(na.omit(fb24$lz)))

# Umrechnung der Varianzen
var(fb24$lz, na.rm = TRUE) * (191 - 1) / 191

# Standardabweichung in R
sd(fb24$lz, na.rm = TRUE) # Populationsschaetzer

# Umrechnung der Standardabweichung
sd(fb24$lz, na.rm = TRUE) * sqrt((191 - 1) / 191)

# Händische Berechnung der empirischen Standardabweichung
(sum((fb24$lz - mean(fb24$lz, na.rm = TRUE))^2,
    na.rm = TRUE) / (length(na.omit(fb24$lz)))) |> sqrt()

# Zentrierung
lz_c <- fb24$lz - mean(fb24$lz, na.rm = TRUE)
head(lz_c)    # erste 6 zentrierte Werte

# z-Standardisierung
lz_z <- lz_c / sd(fb24$lz, na.rm = TRUE)
head(lz_z)    # erste 6 z-standardisierte Werte

## Befehl zum z-Standardisieren
lz_z <- scale(fb24$lz, center = TRUE, scale = TRUE) # Mittelwert auf 0 und Varianz auf 1
## Befehl zum Zentrieren (ohne Varianzrelativierung)
lz_c <- scale(fb24$lz, center = TRUE, scale = FALSE) # setzt Varianz nicht auf 1

fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 5)
head(fb24$mdbf4)     # erste 6 Werte ohne Transformation
head(fb24$mdbf4_r)   # erste 6 Werte mit Transformation

head(fb24$mdbf11 == 1, 15) #Zeige die ersten 15 Antworten

fb24$mdbf11_r[fb24$mdbf11 == 1] <- 4
fb24$mdbf11_r[fb24$mdbf11 == 2] <- 3
fb24$mdbf11_r[fb24$mdbf11 == 3] <- 2
fb24$mdbf11_r[fb24$mdbf11 == 4] <- 1

head(fb24$mdbf11)
head(fb24$mdbf11_r)

# neuen Datensatz der relevanten Variablen erstellen 
gs_pre_data <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')]
# Skalenwert in Originaldatensatz erstellen
fb24$gs_pre <- rowMeans(gs_pre_data)
head(fb24$gs_pre)

# Direkter Befehle
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
head(fb24$gs_pre )
