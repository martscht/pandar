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
fb26$mdbf4_r <- -1 * (fb26$mdbf4 - 5)
fb26$mdbf11_r <- -1 * (fb26$mdbf4 - 5)
fb26$mdbf3_r <- -1 * (fb26$mdbf4 - 5)
fb26$mdbf9_r <- -1 * (fb26$mdbf4 - 5)

# Berechnung von Skalenwerten
fb26$gs_pre  <- fb26[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb26$ru_pre <-  fb26[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb26$ru_pre_zstd <- scale(fb26$ru_pre, center = TRUE, scale = TRUE)




## Deskriptive Begutachtung

anyNA(fb26$trust)

mean(fb26$trust, na.rm = TRUE)







## z-Test

pop_mean_trust <- 3.25                 # Mittelwert Grundgesamtheit
pop_sd_trust <- 2.5                   # SD der Grundgesamtheit
sample_mean_trust <- 
  mean(fb26$trust, na.rm = TRUE)      # Stichprobenmittelwert
sample_size <- 
  nrow(fb26) - sum(is.na(fb26$trust)) # Stichprobengröße (Anzahl NA von Stichprobengröße abziehen)

se_trust <- pop_sd_trust/sqrt(sample_size) # Standardfehler des Mittelwerts

z_emp <- (sample_mean_trust - pop_mean_trust)/ se_trust
z_emp



pnorm(z_emp, lower.tail = FALSE)

2*pnorm(z_emp, lower.tail = FALSE) #verdoppeln, da zweiseitig

z_krit <- qnorm(1-.05/2) # Bestimmung des kritischen Wertes
z_krit

abs(z_emp) > abs(z_krit)

z_quantil_zweiseitig <- qnorm(p = 1-(.05/2), mean = 0, sd = 1)
z_quantil_zweiseitig

up_conf_trust <- sample_mean_trust+((z_quantil_zweiseitig*pop_sd_trust)/sqrt(sample_size))

lo_conf_trust <- sample_mean_trust-((z_quantil_zweiseitig*pop_sd_trust)/sqrt(sample_size))

up_conf_trust
lo_conf_trust

conf_trust <- c(lo_conf_trust, up_conf_trust)
conf_trust

## t-Test

if (!requireNamespace("psych", quietly = TRUE)) {
  install.packages("psych")
}

library(psych)
describe(fb26$neuro)

anyNA(fb26$neuro)
sample_mean_neuro <- mean(fb26$neuro, na.rm = TRUE)
pop_mean_neuro <- 2.9

sample_sd_neuro <- sd(fb26$neuro, na.rm = TRUE)
sample_sd_neuro

sample_size <- nrow(fb26) - sum(is.na(fb26$neuro))
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



t.test(x = fb26$neuro, mu = 2.9, alternative = "greater", conf.level=0.99) #gerichtet, Stichprobenmittelwert höher

## Effektgröße

dz <- abs((sample_mean_trust - pop_mean_trust)/ pop_sd_trust) 
dz

dt <- abs((sample_mean_neuro - pop_mean_neuro)/ sample_sd_neuro)
dt













fb26$neuro_std <- scale(fb26$neuro, center = T, scale = T)
qqnorm(fb26$neuro_std)
qqline(fb26$neuro_std)
