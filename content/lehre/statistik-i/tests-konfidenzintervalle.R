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

# Rekodierung invertierter Items
fb25$mdbf4_r <- -1 * (fb25$mdbf4 - 5)
fb25$mdbf11_r <- -1 * (fb25$mdbf4 - 5)
fb25$mdbf3_r <- -1 * (fb25$mdbf4 - 5)
fb25$mdbf9_r <- -1 * (fb25$mdbf4 - 5)

# Berechnung von Skalenwerten
fb25$gs_pre  <- fb25[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb25$ru_pre <-  fb25[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb25$ru_pre_zstd <- scale(fb25$ru_pre, center = TRUE, scale = TRUE)




## Deskriptive Begutachtung

anyNA(fb25$trust)

mean(fb25$trust, na.rm = TRUE)







## z-Test

pop_mean_trust <- 3.25                 # Mittelwert Grundgesamtheit
pop_sd_trust <- 2.5                   # SD der Grundgesamtheit
sample_mean_trust <- 
  mean(fb25$trust, na.rm = TRUE)      # Stichprobenmittelwert
sample_size <- 
  nrow(fb25) - sum(is.na(fb25$trust)) # Stichprobengröße (Anzahl NA von Stichprobengröße abziehen)

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
describe(fb25$neuro)

anyNA(fb25$neuro)
sample_mean_neuro <- mean(fb25$neuro, na.rm = TRUE)
pop_mean_neuro <- 2.9

sample_sd_neuro <- sd(fb25$neuro, na.rm = TRUE)
sample_sd_neuro

sample_size <- nrow(fb25) - sum(is.na(fb25$neuro))
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



t.test(x = fb25$neuro, mu = 2.9, alternative = "greater", conf.level=0.99) #gerichtet, Stichprobenmittelwert höher

## Effektgröße

dz <- abs((sample_mean_trust - pop_mean_trust)/ pop_sd_trust) 
dz

dt <- abs((sample_mean_neuro - pop_mean_neuro)/ sample_sd_neuro)
dt













fb25$neuro_std <- scale(fb25$neuro, center = T, scale = T)
qqnorm(fb25$neuro_std)
qqline(fb25$neuro_std)
