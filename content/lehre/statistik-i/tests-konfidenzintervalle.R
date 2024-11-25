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

# Rekodierung invertierter Items
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf11_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf3_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf9_r <- -1 * (fb24$mdbf4 - 5)

# Berechnung von Skalenwerten
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb24$ru_pre <-  fb24[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb24$ru_pre_zstd <- scale(fb24$ru_pre, center = TRUE, scale = TRUE)




anyNA(fb24$nerd)

mean(fb24$nerd, na.rm = TRUE)







pop_mean_nerd <- 2.5                 # Mittelwert Grundgesamtheit
pop_sd_nerd <- 3.1                   # SD der Grundgesamtheit
sample_mean_nerd <- 
  mean(fb24$nerd, na.rm = TRUE)      # Stichprobenmittelwert
sample_size <- 
  nrow(fb24) - sum(is.na(fb24$nerd)) # Stichprobengröße (Anzahl NA von Stichprobengröße abziehen)

se_nerd <- pop_sd_nerd/sqrt(sample_size) # Standardfehler des Mittelwerts

z_emp <- (sample_mean_nerd - pop_mean_nerd)/ se_nerd
z_emp



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

library(psych)
describe(fb24$neuro)

anyNA(fb24$neuro)
sample_mean_neuro <- mean(fb24$neuro, na.rm = TRUE)
pop_mean_neuro <- 3.1

sample_sd_neuro <- sd(fb24$neuro, na.rm = TRUE)
sample_sd_neuro

sample_size <- nrow(fb24) - sum(is.na(fb24$neuro))
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



t.test(x = fb24$neuro, mu = 3.1, alternative = "greater", conf.level=0.99) #gerichtet, Stichprobenmittelwert höher

dz <- abs((sample_mean_nerd - pop_mean_nerd)/ pop_sd_nerd) 
dz

dt <- abs((sample_mean_neuro - pop_mean_neuro)/ sample_sd_neuro)
dt

## install.packages('psych')          # installieren

library(psych)                     # laden

## ??psych                          # Hilfe







fb24$neuro_std <- scale(fb24$neuro, center = T, scale = T)
qqnorm(fb24$neuro_std)
qqline(fb24$neuro_std)
