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

str(alc_long)

alc_long$age <- as.factor(alc_long$age)

aggregate(alcuse ~ age, data = alc_long, FUN = mean)

library(ggplot2)

aggregate(alcuse ~ age, data = alc_long, FUN = mean) |> 
  ggplot(aes(x = age, y = alcuse, group = 1)) +
    geom_point() +
    geom_line() +
    labs(x = "Age", y = "Mean Alcuse")

library(afex)



aov_4(alcuse ~ 1  + (age | id), alc_long)

alc$diff_1415 <- alc$alcuse.15 - alc$alcuse.14
alc$diff_1416 <- alc$alcuse.16 - alc$alcuse.14
alc$diff_1516 <- alc$alcuse.16 - alc$alcuse.15
var(alc[, c('diff_1415', 'diff_1416', 'diff_1516')])

anova_mw <- aov_4(alcuse ~ 1  + (age | id), alc_long)
summary(anova_mw)

aov_4(alcuse ~ 1  + (age | id), alc_long, anova_table = list(correction = "HF"))

psych::ICC(alc[, c('alcuse.14', 'alcuse.15', 'alcuse.16')])

library(emmeans)

emm_mw <- emmeans(anova_mw, ~ age)

lin_cont <- c(-1, 0, 1)

aggregate(alcuse ~ age, data = alc_long, FUN = mean) |> 
  ggplot(aes(x = age, y = alcuse, group = 1)) +
    geom_point() +
    geom_line() +
    labs(x = "Age", y = "Mean Alcuse")

aggregate(alcuse ~ age, data = alc_long, FUN = mean) |> 
  ggplot(aes(x = age, y = alcuse, group = 1)) +
    geom_point() +
    geom_line() +
    labs(x = "Age", y = "Mean Alcuse") +
  geom_smooth(aes(x = as.numeric(age)), method = 'lm', se = FALSE)

contrast(emm_mw, list(lin_cont))

aggregate(alcuse ~ age, data = alc_long, FUN = mean) |> 
  ggplot(aes(x = age, y = alcuse, group = 1)) +
    geom_point() +
    geom_line() +
    labs(x = "Age", y = "Mean Alcuse") +
  geom_smooth(aes(x = as.numeric(age)), method = 'lm', se = FALSE) +
  geom_smooth(aes(x = as.numeric(age)), method = 'lm', se = FALSE,
    formula = y ~ x + I(x^2), color = 'red')

lin_cont <- c(-1, 0, 1)
qua_cont <- c(1, -2, 1)

contrast(emm_mw, list(lin_cont, qua_cont),
  adjust = 'bonferroni')

contrast(emm_mw, interaction = 'poly')

contrast(emm_mw, interaction = 'poly',
  adjust = 'bonferroni')

# Alle paarweisen Vergleiche
contrast(emm_mw, method = 'pairwise',
  adjust = 'bonferroni')

# Vergleiche mit dem Mittel
contrast(emm_mw,
  adjust = 'bonferroni')

aggregate(alcuse ~ age + coa, data = alc_long, FUN = mean) |> 
  ggplot(aes(x = age, y = alcuse, color = coa, group = coa)) +
    geom_point() +
    geom_line() +
    labs(x = "Age", y = "Mean Alcuse", color = "Coa")

anova_sp <- aov_4(alcuse ~ 1 + coa + (age | id), alc_long, type = 3)
summary(anova_sp)

heplots::boxM(alc[, c('alcuse.14', 'alcuse.15', 'alcuse.16')], group = alc$coa)




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

aggregate(Y ~ times, df, mean) |>
  ggplot(aes(x = times, y = Y, group = 1)) +
  geom_point() +
  geom_line() +
  geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
              formula = y ~ x) +
  geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
    formula = y ~ x + I(x^2), color = 'red')+
    geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
    formula = y ~ 1, color = 'gold3')
whd_aov <- aov_4(Y ~ times + (times | id), data = data.frame(df))
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

aggregate(Y ~ times, df, mean) |>
  ggplot(aes(x = times, y = Y, group = 1)) +
  geom_point() +
  geom_line() +
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

aggregate(Y ~ times, df, mean) |>
  ggplot(aes(x = times, y = Y, group = 1)) +
  geom_point() +
  geom_line() +
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

aggregate(Y ~ times, df, mean) |>
  ggplot(aes(x = times, y = Y, group = 1)) +
  geom_point() +
  geom_line() +
  geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
              formula = y ~ x) +
  geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
    formula = y ~ x + I(x^2), color = 'red')+
    geom_smooth(aes(x = as.numeric(times)), method = 'lm', se = FALSE,
    formula = y ~ 1, color = 'gold3')
whd_aov <- aov(Y ~ times + Error(id/times), data = data.frame(df))
em <- emmeans(whd_aov, ~ times)
contrast(em, interaction = 'poly')
