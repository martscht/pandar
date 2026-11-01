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

# Rekodierung invertierter Items
fb26$mdbf4_r <- -1 * (fb26$mdbf4 - 4 - 1)
fb26$mdbf11_r <- -1 * (fb26$mdbf11 - 4 - 1)
fb26$mdbf3_r <-  -1 * (fb26$mdbf3 - 4 - 1)
fb26$mdbf9_r <-  -1 * (fb26$mdbf9 - 4 - 1)

# Berechnung von Skalenwerten
fb26$gs_pre  <- fb26[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb26$ru_pre <-  fb26[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb26$ru_pre_zstd <- scale(fb26$ru_pre, center = TRUE, scale = TRUE)


dim(fb26)

anyNA(fb26$gewis) #keine NAs


set.seed(1234) #erlaubt Reproduzierbarkeit
fb26_sample <- fb26[sample(nrow(fb26), size = 31), ] #zieht eine Stichprobe mit n = 31


mean_gewis_pop <- mean(fb26$gewis, na.rm = TRUE) #Mittelwert der Population

sd_gewis_pop <- sd(fb26$gewis, na.rm = TRUE) * sqrt((length(na.omit(fb26$gewis)) - 1) / length(na.omit(fb26$gewis))) #empirische Standardabweichung der Population

se_gewis <- sd_gewis_pop / sqrt(length(na.omit(fb26$gewis))) #Standardfehler

mean_gewis_smpl2 <- mean(fb26_sample$gewis, na.rm = TRUE) #Mittelwert der Stichprobe

z_gewis2 <- (mean_gewis_smpl2 - mean_gewis_pop) / se_gewis #empirischer z-Wert

z_krit <- qnorm(1 - 0.05/2) #kritischer z-Wert, zweiseitig

abs(z_gewis2) > z_krit #signifikant

2 * pnorm(z_gewis2) #p < .05, signifikant
