## source('https://pandar.netlify.app/daten/Data_Processing_game.R')
source('../../daten/Data_Processing_game.R')

# Anzahl der Studien im Datensatz
unique(game$cite) |> length()

# Effektstärke für Wölfling et al. (2019)
wolf <- data.frame(
  occasion = c(1, 2),
  tr_mean = c(5.7, 4.6),
  ct_mean = c(11.4, 10.5),
  tr_sd = c(3.99, 3.46),
  ct_sd = c(4.70, 4.33),
  tr_n = c(72, 72),
  ct_n = c(71, 71)
)

wolf

# Paket laden
library(esc)

# Effektstärke berechnen
with(wolf[1, ],          # Datensatz, 1. MZP auswählen
  esc_mean_sd(
    grp1m = tr_mean,     # Mittelwert der Interventionsgruppe
    grp1sd = tr_sd,      # Standardabweichung der Interventionsgruppe
    grp1n = tr_n,        # Stichprobengröße der Interventionsgruppe
    grp2m = ct_mean,     # Mittelwert der Kontrollgruppe
    grp2sd = ct_sd,      # Standardabweichung der Kontrollgruppe
    grp2n = ct_n,        # Stichprobengröße der Kontrollgruppe
  )
)

# Hedges g berechnen
with(wolf[1, ],          # Datensatz, 1. MZP auswählen
  esc_mean_sd(
    grp1m = tr_mean,     # Mittelwert der Interventionsgruppe
    grp1sd = tr_sd,      # Standardabweichung der Interventionsgruppe
    grp1n = tr_n,        # Stichprobengröße der Interventionsgruppe
    grp2m = ct_mean,     # Mittelwert der Kontrollgruppe
    grp2sd = ct_sd,      # Standardabweichung der Kontrollgruppe
    grp2n = ct_n,        # Stichprobengröße der Kontrollgruppe
    es.type = 'g'        # Effektstärke Hedge's g
  )
)

# Effektstärke für Wölfling et al. (2019) im Datensatz
game[game$cite == 'Woelfling et al. (2019)', ]

# Minimaler Abstand zur Intervention pro Studie
post <- aggregate(game$follow, list(game$cite), \(x) min(abs(x)))
names(post) <- c('cite', 'follow')

# Post-Messungen auswählen
post <- merge(game, post, by = c('cite', 'follow'))

# Mittelwert der Effekte
mean(post$es)

# Gewichte bestimmen
post$w <- 1 / post$v

# Gewichtete Effektschätzung
sum(post$w * post$es) / sum(post$w)

## # Gegebenenfalls das Paket installieren
## install.packages('metafor')
# Paket laden
library(metafor)

# Fixed Effects Model (Post Erhebungen)
modFE <- rma(yi = es, vi = v, data = post, method = 'FE')

# Ergebnisse
summary(modFE)












# Random Effects Model (Post Erhebungen)
modRE <- rma(yi = es, vi = v, data = post)

# Zusammenfassung der Ergebnisse
summary(modRE)

fe_exp <- data.frame(study = as.factor(1:3), n = c(30, 70, 120), theta_hat = c(.6, .36, .175))
ggplot(fe_exp, aes(x = theta_hat)) +
  geom_function(fun = dnorm, args = list(mean = .3, sd = sqrt(1/30)), color = pandar_colors[1], xlim=c(-.05, .75)) +
  geom_function(fun = dnorm, args = list(mean = .3, sd = sqrt(1/70)), color = pandar_colors[2], xlim=c(-.05, .75)) +
  geom_function(fun = dnorm, args = list(mean = .3, sd = sqrt(1/120)), color = pandar_colors[3], xlim=c(-.05, .75)) +
  geom_segment(aes(x = theta_hat, xend = theta_hat, y = 0, yend = dnorm(theta_hat, mean = .3, sd = sqrt(1/n)), color = study), lty = 2) +
  geom_segment(x = .3, xend = .3, y = 0, yend = 5, color = 'grey50') +
  geom_text(aes(x = theta_hat, y = 0, label = paste0("hat(theta)[", study, "]")), 
    parse = TRUE, vjust = 1.5) +
  geom_text(x = .3, y = 0, label = paste0("theta"), 
    parse = TRUE, vjust = 2.5) +
  ylim(-.2, 4.4) +
  labs(y = element_blank(), x = element_blank(), color = 'Studie') +
  scale_color_manual(values = pandar_colors[1:3]) + theme_pandar() 

re_exp <- data.frame(study = as.factor(1:3), n = c(30, 70, 120), theta = c(.4, .45, .2), theta_hat = c(.6, .36, .175))
ggplot(re_exp, aes(x = theta_hat)) +
  geom_function(fun = dnorm, args = list(mean = .3, sd = sqrt(1/50)), color = 'grey50', xlim=c(-.05, .75)) +
  geom_segment(x = .3, xend = .3, y = 0, yend = 5, color = 'grey50') +
  geom_segment(aes(x = theta, xend = theta, y = 0, yend = dnorm(theta, mean = .3, sd = sqrt(1/50)), color = study), lty = 1) +
  geom_text(aes(x = theta, y = 0, label = paste0("theta[", study, "]")), 
    parse = TRUE, vjust = 2.2) +
  geom_text(x = .3, y = 0, label = paste0("theta"), 
    parse = TRUE, vjust = 2.5) +
  ylim(-.2, 4.4) +
  labs(y = element_blank(), x = element_blank(), color = 'Studie') +
  scale_color_manual(values = pandar_colors[1:3]) + theme_pandar()

ggplot(re_exp, aes(x = theta_hat)) +
  geom_function(fun = dnorm, args = list(mean = .4, sd = sqrt(1/30)), color = pandar_colors[1], xlim=c(-.05, .75)) +
  geom_function(fun = dnorm, args = list(mean = .45, sd = sqrt(1/70)), color = pandar_colors[2], xlim=c(-.05, .75)) +
  geom_function(fun = dnorm, args = list(mean = .2, sd = sqrt(1/120)), color = pandar_colors[3], xlim=c(-.05, .75)) +
  geom_function(fun = dnorm, args = list(mean = .3, sd = sqrt(1/50)), color = 'grey50', xlim=c(-.05, .75)) +
  geom_segment(x = .3, xend = .3, y = 0, yend = 5, color = 'grey50') +
  geom_segment(aes(x = theta, xend = theta, y = 0, yend = dnorm(theta, mean = theta, sd = sqrt(1/n)), color = study), lty = 1) +
  geom_segment(aes(x = theta_hat, xend = theta_hat, y = 0, yend = dnorm(theta_hat, mean = theta, sd = sqrt(1/n)), color = study), lty = 2) +
  geom_text(aes(x = theta, y = 0, label = paste0("theta[", study, "]")), 
    parse = TRUE, vjust = 2.2) +
  geom_text(aes(x = theta_hat, y = 0, label = paste0("hat(theta)[", study, "]")), 
    parse = TRUE, vjust = 1.5) +
  geom_text(x = .3, y = 0, label = paste0("theta"), 
    parse = TRUE, vjust = 2.5) +
  ylim(-.2, 4.4) +
  labs(y = element_blank(), x = element_blank(), color = 'Studie') +
  scale_color_manual(values = pandar_colors[1:3]) + theme_pandar() 


# Diagnosemaße
diagnostics <- influence(modRE)

# Zusammenführen der Diagnosemaße und Studieninformationen
diagnostics <- data.frame(cite = post$cite, es = post$es,
  diagnostics$inf)

# ggplot
ggplot(diagnostics, aes(y = cite, x = cook.d)) +
  geom_point() +
  labs(x = 'Cook\'s Distanz', y = 'Studie') +
  theme_pandar()

# Ausreißer entfernen
post <- post[post$study != 15, ]

# Fixed Effects Model
modFE <- update(modFE, data = post)

# Random Effects Model
modRE <- update(modRE, data = post)

# Forest Plot
forest(modRE, slab = post$cite, order = post$es,
  shade = TRUE)

# Farben für Interventionstyp
colors <- factor(post$tr_type, 
  labels = pandar_colors[1:4]) |> as.character()

# Forest Plot
forest(modRE, slab = post$cite, order = post$es,
  colout = colors)

# Legende hinzufügen
legend('bottomleft', legend = levels(factor(post$tr_type)), 
  fill = pandar_colors[1:4],
  cex = .75)

# Meta-Regression
modMR1 <- rma(yi = es, vi = v, data = post, mods = ~ tr_type)

# Ergebnissdarstellung
summary(modMR1)









# Interventionsarten
table(post$tr_type)

# Meta-Regression
modMR1b <- rma(yi = es, vi = v, data = post, mods = ~ 0 + tr_type)

# Ergebnissdarstellung
summary(modMR1b)

# Umrechnen der Geschlechtervariable
post$genbal <- post$male - 50

# Meta-Regression mit Kovariate
modMR2 <- rma(yi = es, vi = v, data = post, mods = ~ 0 + tr_type + genbal)

# Ergebniszusammenfassung
summary(modMR2)

# Ausreißer entfernen
game <- game[game$study != 15, ]

# Paket laden
library(clubSandwich)

# Geschätzte CHE Kovarianzmatrix
V <- impute_covariance_matrix(
  game$v,
  cluster = game$study,
  r = .6,
  smooth_vi = TRUE)

# Multilevel Meta-Analyse
modML <- rma.mv(yi = es, V = V, data = game, 
  random = ~ 1 | study/effect)

# Ergebnissdarstellung
summary(modML)


# Gender-Balance Variable erstellen
game$genbal <- game$male - 50

# ML Meta-Regression
modML2 <- rma.mv(yi = es, V = v, data = game, 
  random = ~ 1 | study/effect, 
  mods = ~ 0 + tr_type + genbal + follow)

## # Ergebnissdarstellung
## summary(modML2)



# Omnibus-Test der Interventionsarten
modML2b <- update(modML2, btt = 1:4)

## # Ergebnissdarstellung
## summary(modML2b)





# Funnel Plot
funnel(modML,                           # Modell mit unbedingten Effekten
  refline = 0,                          # Ort der Referenzlinie
  level = c(90, 95, 99),                # Konfidenzintervalle
  shade=c("white", "gray55", "gray75"), # Färbung der verschiendenn Bereiche
  back = FALSE)                         # Hintergrundfarbe
abline(v = coef(modML)[1], lty = 2)     # Geschätzter Interventionseffekt

# Egger's Test + PET
regtest(es, v, data = game)

# PEESE
regtest(es, v, data = game, predictor = "vi")
