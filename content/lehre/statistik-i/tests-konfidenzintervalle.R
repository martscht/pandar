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

# Rekodierung invertierter Items
fb23$mdbf4_pre_r <- -1 * (fb23$mdbf4_pre - 4 - 1)
fb23$mdbf11_pre_r <- -1 * (fb23$mdbf11_pre - 4 - 1)
fb23$mdbf3_pre_r <-  -1 * (fb23$mdbf3_pre - 4 - 1)
fb23$mdbf9_pre_r <-  -1 * (fb23$mdbf9_pre - 4 - 1)

# Berechnung von Skalenwerten
fb23$gs_pre  <- fb23[, c('mdbf1_pre', 'mdbf4_pre_r', 
                        'mdbf8_pre', 'mdbf11_pre_r')] |> rowMeans()
fb23$wm_pre <-  fb23[, c("mdbf3_pre_r", "mdbf6_pre", 
                         "mdbf9_pre_r", "mdbf12_pre")] |> rowMeans()

# z-Standardisierung
fb23$wm_pre_zstd <- scale(fb23$wm_pre, center = TRUE, scale = TRUE)


curve(expr = dnorm(x, mean = 2.5, sd = 3.1),
     from = -0.5,
     to = 5.5,
     main = "Population", 
     xlab = "Nerdiness-Werte",
     ylab = "Dichte")
abline(v = mean(fb23$nerd),col=  "red")

anyNA(fb23$nerd)

mean(fb23$nerd)







pop_mean_nerd <- 2.5                 # Mittelwert Grundgesamtheit
pop_sd_nerd <- 3.1                 # SD der Grundgesamtheit
sample_mean_nerd <- mean(fb23$nerd)  # Stichprobenmittelwert
sample_size <- nrow(fb23)            # Stichprobengröße (da keine NA)

se_nerd <- pop_sd_nerd/sqrt(sample_size) # Standardfehler des Mittelwerts

z_emp <- (sample_mean_nerd - pop_mean_nerd)/ se_nerd
z_emp

x <- seq(-0.5, 5.5, 0.1) 
y <- dnorm(x, 2.5, 3.1/sqrt(nrow(fb23)))
plot(x, y, type="l", 
      main = "SKV des MW für Nerdiness Population mit unserer Stichprobengröße", 
      xlab = "Nerdiness-Werte",
      ylab = "Dichte f(x)")
polygon(c(min(x), x[x<=mean(fb23$nerd)],  mean(fb23$nerd)), c(0, y[x<=mean(fb23$nerd)],  0), col="red")
abline(v = mean(fb23$nerd),col=  "red")

pnorm(z_emp, lower.tail = FALSE)

2*pnorm(z_emp, lower.tail = FALSE) #verdoppeln, da zweiseitig

z_krit <- qnorm(1-.05/2) # Bestimmung des kritischen Wertes
z_krit

abs(z_emp) > abs(z_krit)

z_quantil_zweiseitig <- qnorm(p = 1-(.05/2), mean = 0, sd = 1)
z_quantil_zweiseitig

up_conf_nerd <- sample_mean_nerd+((z_quantil_zweiseitig*pop_sd_nerd)/sqrt(sample_size))

lo_conf_nerd <- sample_mean_nerd-((z_quantil_zweiseitig*pop_sd_nerd)/sqrt(sample_size))

up_conf_nerd
lo_conf_nerd

conf_nerd <- c(lo_conf_nerd, up_conf_nerd)
conf_nerd

## install.packages('psych')          # installieren

library(psych)                     # laden

## ??psych                          # Hilfe

describe(fb23$neuro)





hist(fb23$neuro, xlim=c(0,6), main = "Histogramm",
     xlab = "Score", ylab= "Dichte", freq = FALSE)
curve(dnorm(x, mean = mean(fb23$neuro), sd = sd(fb23$neuro)), add = T)

fb23$neuro_std <- scale(fb23$neuro, center = T, scale = T)
qqnorm(fb23$neuro_std)
qqline(fb23$neuro_std)

anyNA(fb23$neuro)
sample_mean_neuro <- mean(fb23$neuro)
pop_mean_neuro <- 3.1

sample_sd_neuro <- sd(fb23$neuro)
sample_sd_neuro

sample_size <- nrow(fb23)
se_neuro <- sample_sd_neuro/sqrt(sample_size)

t_emp <- (sample_mean_neuro - pop_mean_neuro) / se_neuro
t_emp

pt(t_emp, df = sample_size - 1, lower.tail = F) #einseitige Testung

t_krit <- qt(0.01, df = sample_size-1, lower.tail = FALSE)
t_krit

t_emp > t_krit

t_quantil_einseitig <- qt(0.01, df = sample_size-1, lower.tail = FALSE)
t_quantil_einseitig

sample_mean_neuro - t_quantil_einseitig *(sample_sd_neuro / sqrt(sample_size))



t.test(x = fb23$neuro, mu = 3.1, alternative = "greater", conf.level=0.99) #gerichtet, Stichprobenmittelwert höher

dz <- abs((sample_mean_nerd - pop_mean_nerd)/ pop_sd_nerd) 
dz

dt <- abs((sample_mean_neuro - pop_mean_neuro)/ sample_sd_neuro)
dt
