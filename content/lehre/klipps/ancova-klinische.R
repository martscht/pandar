# load(url('https://pandar.netlify.app/daten/roma.rda'))


roma$condition <- roma$warm:roma$comp

roma$condition <- factor(roma$warm:roma$comp, labels = c('high warmth + high competence', 'high warmth + low competence', 'low warmth + high competence', 'low warmth + low competence'))

psych::describeBy(roma[, c('condition', 'sss8', 'ssd12', 'phq9')], 'condition')

library(gtsummary)
# tbl_summary(data = roma,
#   by = condition,
#   include = c(age, gender, ssd12))


# tbl_summary(roma,
#   by = condition,
#   include = c(age, gender, education, occupation, sss8, ssd12, phq9, vignette, report),
#   statistic = list(all_continuous() ~ "{mean} ({sd})", all_categorical() ~ "{n} ({p})"),
#   digits = list(all_continuous() ~ 2, all_categorical() ~ c(0, 1)),
#   label = list(age ~ "Age, y",
#     gender ~ "Gender",
#     education ~ "Educational level",
#     occupation ~ "Occupation",
#     sss8 ~ "SSS-8",
#     ssd12 ~ "SSD-12",
#     phq9 ~ "PHQ-9",
#     vignette ~ "Had similar symptoms as described in the vignette",
#     report ~ "Had a similar doctor's report in the past"),
#   missing = "no") |>
# add_overall(last = TRUE)


library(afex)
ano1 <- aov_4(disease2 ~ comp * warm + (1 | id), roma)
summary(ano1)

# Mittelwerte
means <- aggregate(disease2 ~ comp * warm, roma, mean)
means

# Standardabweichungen
sds <- aggregate(disease2 ~ comp * warm, roma, sd)
sds

# Kompetenz - dummy
contrasts(roma$comp)

# Wärme - dummy
contrasts(roma$warm)

reg1 <- lm(disease2 ~ comp * warm, roma)
summary(reg1)

# Kompetenz - Kontrast
contrasts(roma$comp) <- 'contr.sum'
contrasts(roma$comp)

# Wärme - Kontrast
contrasts(roma$warm) <- 'contr.sum'
contrasts(roma$warm)

reg2 <- lm(disease2 ~ comp * warm, roma)
summary(reg2)

mean(means$disease2)

library(ggplot2)
ggplot(means, aes(x = warm, y = disease2, group = comp, color = comp)) + 
  geom_point() + geom_line() + 
  labs(x = 'Wärme', y = 'Subjektive Wahrscheinlichkeit schwerer Erkrankung', color = 'Kompetenz') + 
  theme_pandar() + scale_color_pandar()

means$sds <- sds$disease2
pd <- position_dodge(width = 0.2)

ggplot(means, aes(x = warm, y = disease2, group = comp, color = comp)) + 
  geom_point(position = pd) + geom_line(position = pd) +
  geom_errorbar(aes(ymin = disease2 - sds, ymax = disease2 + sds), position = pd) + 
  labs(x = 'Wärme', y = 'Subjektive Wahrscheinlichkeit schwerer Erkrankung', color = 'Kompetenz') + 
  theme_pandar() + scale_color_pandar()

# Effektstärke Kompetenz:
effsize::cohen.d(disease2 ~ comp, roma)

# Effektstärke Wärme:
effsize::cohen.d(disease2 ~ warm, roma)

aggregate(disease1 ~ comp * warm, roma, mean)

ano2 <- aov_4(disease2 ~ comp * warm + disease1 + (1 | id), roma, factorize = FALSE)
summary(ano2)

# summary(ano2$lm)



# Gruppenspezifische Regressionsgeraden bestimmen
lines <- expand.grid(disease1 = range(roma$disease1, na.rm = TRUE),
  warm = levels(roma$warm),
  comp = levels(roma$comp))

lines$disease2 <- predict(ano2$lm,
  newdata = lines)

lines$condition <- factor(lines$warm:lines$comp, labels = levels(roma$condition))

# Mittelwerte zusammenführen
tmp <- aggregate(cbind(disease1, disease2) ~ condition + warm + comp,
  data = roma, FUN = mean)

# Plot erstellen
ggplot(roma, aes(x = disease1, y = disease2, group = condition, color = condition)) + 
  geom_point(alpha = .25) + 
  geom_line(data = lines, aes(group = condition, color = condition)) + 
  scale_color_pandar() + theme_pandar() + coord_cartesian(ylim = range(roma$disease2, na.rm = TRUE), xlim = range(roma$disease1, na.rm = TRUE)) +
  geom_point(data = tmp, aes(x = disease1, y = disease2, color = condition), size = 4, pch = 18)

# Mittelwerte zusammenführen
tmp <- expand.grid(disease1 = 50,
  warm = levels(roma$warm),
  comp = levels(roma$comp))
tmp$disease2 <- predict(ano2$lm,
  newdata = tmp)
tmp$condition <- factor(tmp$warm:tmp$comp, labels = levels(roma$condition))

# Plot erstellen
ggplot(roma, aes(x = disease1, y = disease2, group = condition, color = condition)) + 
  geom_point(alpha = .25) + 
  geom_line(data = lines, aes(group = condition, color = condition)) + 
  scale_color_pandar() + theme_pandar() + coord_cartesian(ylim = range(roma$disease2, na.rm = TRUE), xlim = range(roma$disease1, na.rm = TRUE)) +
  geom_point(data = tmp, aes(x = disease1, y = disease2, color = condition), size = 4, pch = 18)

contrasts(roma$warm)



#### Change-Modelle ----

# Seed festlegen
set.seed(123)

# Werte Frauen
y1f <- rnorm(100, 70, 10)
y2f <- 5 + .5*y1f + rnorm(100, 35, sqrt(75))

# Werte Männer
y1m <- rnorm(100, 80, 10)
y2m <- 5 + .5*y1m + rnorm(100, 40, sqrt(75))

# Datensatz
d <- data.frame(y1 = c(y1f, y1m), y2 = c(y2f, y2m),
  g = rep(c('f', 'm'), each = 100))

# ANCOVA
lord_ancova <- lm(y2 ~ y1 + g, d)
summary(lord_ancova)

# Change-Modell
lord_change <- lm(y2 - y1 ~ g, d)
summary(lord_change)

# Change-Modell
reg3 <- lm(disease2 - disease1 ~ warm * comp, roma)

# Ergebniszusammenfassung
summary(reg3)

# Change zur ANOVA
anova(reg3)

ano3 <- aov_4(disease2 ~ comp * warm * disease1 + (1 | id), roma, factorize = FALSE)
summary(ano3)


# Gruppenspezifische Regressionsgeraden bestimmen
lines <- expand.grid(disease1 = range(roma$disease1, na.rm = TRUE),
  warm = levels(roma$warm),
  comp = levels(roma$comp))

lines$disease2 <- predict(ano3$lm,
  newdata = lines)

lines$condition <- factor(lines$warm:lines$comp, labels = levels(roma$condition))

# Plot erstellen
ggplot(roma, aes(x = disease1, y = disease2, group = condition, color = condition)) + 
  geom_point(alpha = .25) + 
  geom_line(data = lines, aes(group = condition, color = condition)) + 
  scale_color_pandar() + theme_pandar() + coord_cartesian(ylim = range(roma$disease2, na.rm = TRUE), xlim = range(roma$disease1, na.rm = TRUE))

roma$warm_cent <- scale(roma$warm_perc, scale = FALSE)
roma$comp_cent <- scale(roma$comp_perc, scale = FALSE)

mod1 <- lm(disease2 ~ warm_cent * comp_cent + disease1, roma)
summary(mod1)

library(lm.beta)
lm.beta(mod1) |> summary()

mod2 <- lm(cancer2 ~ warm_cent * comp_cent + cancer1, roma)
lm.beta(mod2) |> summary()

library(interactions)
sim_slopes(mod2, pred = warm_cent, modx = comp_cent)

interact_plot(mod2, pred = warm_cent, modx = comp_cent)

interact_plot(mod2, modx = warm_cent, pred = comp_cent)
