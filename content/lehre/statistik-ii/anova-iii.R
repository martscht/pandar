# Vorbereitungen
knitr::opts_chunk$set(echo = TRUE, fig.align = "center")

## load("C:/Users/Musterfrau/Desktop/alc.rda")

load(url("https://pandar.netlify.app/daten/alc.rda"))

dim(alc)
head(alc)

table(alc$id)

alc_long <- reshape(data = alc,
  varying = list(c('alcuse.14', 'alcuse.15', 'alcuse.16')),
  direction = 'long')

head(alc_long)

## varying = list(c('alcuse.14', 'alcuse.15', 'alcuse.16'),
##   c('weeduse.14', 'weeduse.15', 'weeduse.16'))

alc_long[alc_long$id == 1, ]

alc_long <- reshape(data = alc,
  varying = list(c('alcuse.14', 'alcuse.15', 'alcuse.16')),
  direction = 'long',
  timevar = 'age')

head(alc_long)

alc_long <- reshape(data = alc,
  varying = list(c('alcuse.14', 'alcuse.15', 'alcuse.16')),
  direction = 'long',
  timevar = 'age',
  times = c(14, 15, 16))

head(alc_long)

alc_long <- reshape(data = alc,
  varying = list(c('alcuse.14', 'alcuse.15', 'alcuse.16')),
  direction = 'long',
  timevar = 'age',
  times = c(14, 15, 16),
  v.names = 'alcuse')

head(alc_long)

alc_wide <- reshape(alc_long, 
            v.names = 'alcuse', 
            timevar = 'age', 
            idvar = 'id', 
            direction = 'wide')
head(alc_wide)

library(ez)
ezStats(alc_long, alcuse, id, within = age)

alc_long$age <- as.factor(alc_long$age)

ezStats(alc_long, alcuse, id, within = age)

ezPlot(alc_long, alcuse, id, within = age,
  x = age)

alc$diff_1415 <- alc$alcuse.15 - alc$alcuse.14
alc$diff_1416 <- alc$alcuse.16 - alc$alcuse.14
alc$diff_1516 <- alc$alcuse.16 - alc$alcuse.15
var(alc[, c('diff_1415', 'diff_1416', 'diff_1516')])

ezANOVA(data = alc_long, dv = alcuse, wid = id, within = age)

psych::ICC(alc[, c('alcuse.14', 'alcuse.15', 'alcuse.16')])

library(emmeans)

# aov-Objekt erzeugen
wdh_aov <- aov(alcuse ~ age + Error(id/age), 
  data = alc_long)
wdh_aov

# Kontraste vorbereiten
em <- emmeans(wdh_aov, ~ age)
em

lin_cont <- c(-1, 0, 1)

library(ggplot2)

# ezPlot siehe oben
ezPlot(alc_long, alcuse, id, within = age,
  x = age) +
# beliebige ggplot Erweiterungen anfügen
  theme_minimal() +
  xlab('Alter')

ezPlot(alc_long, alcuse, id, within = age,
  x = age) +
  geom_smooth(aes(x = as.numeric(age)), method = 'lm', se = FALSE)

contrast(em, list(lin_cont))

ezPlot(alc_long, alcuse, id, within = age,
  x = age) +
  geom_smooth(aes(x = as.numeric(age)), method = 'lm', se = FALSE) +
  geom_smooth(aes(x = as.numeric(age)), method = 'lm', se = FALSE,
    formula = y ~ x + I(x^2), color = 'red')

lin_cont <- c(-1, 0, 1)
qua_cont <- c(1, -2, 1)

contrast(em, list(lin_cont, qua_cont),
  adjust = 'bonferroni')

contrast(em, interaction = 'poly')

contrast(em, interaction = 'poly',
  adjust = 'bonferroni')

# Alle paarweisen Vergleiche
contrast(em, method = 'pairwise',
  adjust = 'bonferroni')

# Vergleiche mit dem Mittel
contrast(em,
  adjust = 'bonferroni')

# Deskriptive Statistiken
ezStats(alc_long, 
  dv = alcuse, 
  wid = id, 
  within = age,   #zwischen den jährlichen Messungen
  between = coa)  #zwischen den Jugendlichen Gruppen

# Grafische Darstellung
ezPlot(alc_long, 
  dv = alcuse, 
  wid = id, 
  within = age, 
  between = coa,
  x = age, split = coa)

ezANOVA(alc_long, 
  dv = alcuse, 
  wid = id, 
  within = age, 
  between = coa)

heplots::boxM(alc[, c('alcuse.14', 'alcuse.15', 'alcuse.16')], group = alc$coa)

ezANOVA(alc_long, 
  dv = alcuse, 
  wid = id, 
  within = age, 
  between = coa)


set.seed(123) # für Vergleichbarkeit
Means <- c(0, 0, 0) # wahren Mittelwerte pro Zeitpunkt
Y <- Means[1] + rnorm(30)
Y <- c(Y, Means[2] + rnorm(30))
Y <- c(Y, Means[3] + rnorm(30))

times <- c(rep("1", 30), rep("2", 30), rep("3", 30))
id <- c(1:30, 1:30, 1:30)
df <- data.frame(Y, times, id)
df$times <- as.factor(times)
df$id <- as.factor(df$id)
head(df)

ezPlot(df, Y, id, within = times,
  x = times) +
  geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
              formula = y ~ x) +
  geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
    formula = y ~ x + I(x^2), color = 'red')+
    geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
    formula = y ~ 1, color = 'gold3')
whd_aov <- aov(Y ~ times + Error(id/times), data = data.frame(df))
em <- emmeans(whd_aov, ~ times)
contrast(em, interaction = 'poly')


set.seed(123) # für Vergleichbarkeit
Means <- c(0, 1, 2) # wahren Mittelwerte pro Zeitpunkt
Y <- Means[1] + rnorm(30)
Y <- c(Y, Means[2] + rnorm(30))
Y <- c(Y, Means[3] + rnorm(30))

times <- c(rep("1", 30), rep("2", 30), rep("3", 30))
id <- c(1:30, 1:30, 1:30)
df <- data.frame(Y, times, id)
df$times <- as.factor(times)
df$id <- as.factor(df$id)
head(df)

ezPlot(df, Y, id, within = times,
  x = times) +
  geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
              formula = y ~ x) +
  geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
    formula = y ~ x + I(x^2), color = 'red')+
    geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
    formula = y ~ 1, color = 'gold3')
whd_aov <- aov(Y ~ times + Error(id/times), data = data.frame(df))
em <- emmeans(whd_aov, ~ times)
contrast(em, interaction = 'poly')

set.seed(123) # für Vergleichbarkeit
Means <- c(0, 1, 0) # wahren Mittelwerte pro Zeitpunkt
Y <- Means[1] + rnorm(30)
Y <- c(Y, Means[2] + rnorm(30))
Y <- c(Y, Means[3] + rnorm(30))

times <- c(rep("1", 30), rep("2", 30), rep("3", 30))
id <- c(1:30, 1:30, 1:30)
df <- data.frame(Y, times, id)
df$times <- as.factor(times)
df$id <- as.factor(df$id)
head(df)

ezPlot(df, Y, id, within = times,
  x = times) +
  geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
              formula = y ~ x) +
  geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
    formula = y ~ x + I(x^2), color = 'red')+
    geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
    formula = y ~ 1, color = 'gold3')
whd_aov <- aov(Y ~ times + Error(id/times), data = data.frame(df))
em <- emmeans(whd_aov, ~ times)
contrast(em, interaction = 'poly')

set.seed(1234) # für Vergleichbarkeit
Means <- c(1^2, 2^2, 3^2) # wahren Mittelwerte pro Zeitpunkt
Y <- Means[1] + rnorm(30)
Y <- c(Y, Means[2] + rnorm(30))
Y <- c(Y, Means[3] + rnorm(30))

times <- c(rep("1", 30), rep("2", 30), rep("3", 30))
id <- c(1:30, 1:30, 1:30)
df <- data.frame(Y, times, id)
df$times <- as.factor(times)
df$id <- as.factor(df$id)
head(df)

ezPlot(df, Y, id, within = times,
  x = times) +
  geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
              formula = y ~ x) +
  geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
    formula = y ~ x + I(x^2), color = 'red')+
    geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
    formula = y ~ 1, color = 'gold3')
whd_aov <- aov(Y ~ times + Error(id/times), data = data.frame(df))
em <- emmeans(whd_aov, ~ times)
contrast(em, interaction = 'poly')
