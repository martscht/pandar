#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb23.rda'))  

# Nominalskalierte Variablen in Faktoren verwandeln

fb23$fach <- factor(fb23$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb23$ziel <- factor(fb23$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb23$wohnen <- factor(fb23$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))



# Naturverbundenheit


# Weitere Standardisierugen
fb23$nerd_std <- scale(fb23$nerd)
fb23$neuro_std <- scale(fb23$neuro)


anyNA(fb23$nerd)

mean(fb23$nerd)

pop_mean_nerd <- 2.5                 # Mittelwert Grundgesamtheit
pop_sd_nerd <- 0.9                   # SD der Grundgesamtheit
sample_mean_nerd <- mean(fb23$nerd)  # Stichprobenmittelwert
sample_size <- nrow(fb23)            # Stichprobengröße (da keine NA)

se_nerd <- pop_sd_nerd/sqrt(sample_size) # Standardfehler des Mittelwerts

z_emp <- (sample_mean_nerd - pop_mean_nerd)/ se_nerd
z_emp

z_krit <- qnorm(1-.05/2) # Bestimmung des kritischen Wertes
z_krit

z_emp > z_krit

pnorm(z_emp, lower.tail = FALSE)

2*pnorm(z_emp, lower.tail = FALSE) #verdoppeln, da zweiseitig

z_quantil_zweiseitig <- qnorm(p = 1-(.05/2), mean = 0, sd = 1)
z_quantil_zweiseitig

up_conf_nerd <- sample_mean_nerd+((z_quantil_zweiseitig*pop_sd_nerd)/sqrt(sample_size))
up_conf_nerd

lo_conf_nerd <- sample_mean_nerd-((z_quantil_zweiseitig*pop_sd_nerd)/sqrt(sample_size))
lo_conf_nerd

conf_nerd <- c(lo_conf_nerd, up_conf_nerd)
conf_nerd

## install.packages('psych')          # installieren

library(psych)                     # laden

## ??psych                          # Hilfe

describe(fb23$neuro)

qqnorm(fb23$neuro) 
qqline(fb23$neuro)

mean_men_height <- mean(men_height)
mean_men_height

sd_men_height <- sd(men_height)
sd_men_height

n_men_height <- length(men_height)
se_men_height <- sd_men_height/sqrt(n_men_height)

average_men_height <- 180

t_men_height <- abs((mean_men_height-average_men_height)/se_men_height)
t_men_height

krit_t_men_height <- qt(0.95, df=n_men_height-1) 
krit_t_men_height

t_men_height > krit_t_men_height

p_t_men_height <- pt(t_men_height, n_men_height-1, lower.tail = F) #einseitige Testung
p_t_men_height



t.test(fb23$neuro, mu=3.3, alternative="greater", conf.level=0.99) #gerichtet, Stichprobenmittelwert höher

z_quantil_einseitig <- qnorm(p = 1-.05, mean = 0, sd = 1)
z_quantil_einseitig

new_mean_IQ-((z_quantil_einseitig*sd_IQ)/sqrt(sample_size))

mean_Neuro <- mean(fb23$neuro) #Neurotizismuswert der Stichprobe
sd_Neuro <- sd(fb23$neuro, na.rm = T) #Stichproben SD (Populationsschätzer)
mean_Popu_Neuro <- 3.3 #Neurotizismuswert der Grundgesamtheit
d <- abs((mean_Neuro-mean_Popu_Neuro)/sd_Neuro) #abs(), da Betrag
d
