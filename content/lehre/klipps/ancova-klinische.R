## source('https://pandar.netlify.app/daten/Data_Processing_cope.R')


# Ethnizität
ethnicity <- aggregate(cope[, grep('race_', names(cope))], by = list(cope$condition), FUN = sum)
names(ethnicity) <- c('condition', 'Native', 'Asian', 'Hispanic', 'Pacific Islander', 'White', 'Black', 'Other', 'Prefer not to say')
ethnicity

# Geschlecht
gender <- aggregate(cope[, grep('gender_', names(cope))], by = list(cope$condition), FUN = sum)
names(gender) <- c('condition', 'agender', 'not sure', 'other', 'androgynous', 'nonbinary', 'two spirited', 'Trangender female to male', 'trans female', 'trans male', 'Gender expansive', 'Third gender', 'Genderqueer', 'Transgender male to female', 'Man', 'Woman')
gender

# Biologisches Geschlecht
table(cope$sex, cope$condition)

# Sexuelle Orientierung
table(cope$orientation, cope$condition)

# Baseline CDI
psych::describeBy(cope$CDI1*12, cope$condition)

# Akzeptanz
pfs <- subset(cope, select = c('condition', grep('pfs_', names(cope), value = TRUE))) |> na.omit()
psych::describeBy(pfs, pfs$condition)


dropouts <- table(cope$condition, cope$dropout1)
dropouts
prop.table(dropouts, margin = 1)
chisq.test(dropouts)

# Datenauswahl zur Dropout-Vorhersage
drop_dat <- cope[, c('dropout1', grep('^gender', names(cope), value = TRUE),
    grep('^race', names(cope), value = TRUE),
    'age', 'CDI1', 'CTS1', 'GAD1', 'SHS1', 'BHS1', 'DRS1')]

# Vorhersage von Dropout mit logistischer Regression
drop_mod <- glm(dropout1 ~ ., drop_dat, family = 'binomial')

summary(drop_mod)



# Vorgesagte Werte
cope$dropout_pred <- predict(drop_mod, cope, type = 'response') > .5
cope$dropout_pred <- factor(cope$dropout_pred, labels = c('remain', 'dropout'))

# Confusion Matrix
caret::confusionMatrix(cope$dropout_pred, cope$dropout1)

locf <- cope

# LOCF, post-intervention
locf$SHS2 <- ifelse(is.na(locf$SHS2), locf$SHS1, locf$SHS2)
locf$BHS2 <- ifelse(is.na(locf$BHS2), locf$BHS1, locf$BHS2)

# LOCF, follow-up
locf$CDI3 <- ifelse(is.na(locf$CDI3), locf$CDI1, locf$CDI3)
locf$CTS3 <- ifelse(is.na(locf$CTS3), locf$CTS1, locf$CTS3)
locf$GAD3 <- ifelse(is.na(locf$GAD3), locf$GAD1, locf$GAD3)
locf$SHS3 <- ifelse(is.na(locf$SHS3), locf$SHS2, locf$SHS3)
locf$BHS3 <- ifelse(is.na(locf$BHS3), locf$BHS2, locf$BHS3)
locf$DRS3 <- ifelse(is.na(locf$DRS3), locf$DRS1, locf$DRS3)

# ANOVA model
mod1 <- lm(CDI3 ~ condition, cope)

# Ergebniszusammenfassung
summary(mod1)

# Gruppenmittelwerte zur Baseline
tapply(cope$CDI1, cope$condition, mean)

# Einfache ANCOVA
mod2 <- lm(CDI3 ~ CDI1 + condition, cope)

# Ergebniszusammenfassung
summary(mod2)

# Regressionsergebnisse zusammenführen
lines <- data.frame(condition = c("Placebo Control", "Project Personality", "Project ABC"), 
  int1 = coef(mod1)[1] + c(0,coef(mod1)[2:3]),
  slo1 = 0,
  int2 = coef(mod2)[1] + c(0,coef(mod2)[3:4]),
  slo2 = coef(mod2)[2],
  mns = tapply(cope$CDI1, cope$condition, mean))

# Grafische Darstellung
scatter <- ggplot(cope, aes(x = CDI1, y = CDI3, color = condition)) + 
  theme_pandar() + scale_color_pandar() + geom_point(alpha = 0) + xlim(0.75, 1.25) + ylim(.6, 1.2) 

# Regressionsgeraden
scatter +
  geom_abline(data = lines, aes(intercept = int2, slope = slo2, color = condition), linetype = 'solid') +
  geom_point(data = lines, aes(x = mns, y = mns*slo2+int2))

# Modell mit Last-Observation-Carried-Forward
mod2_locf <- lm(CDI3 ~ CDI1 + condition, locf)

# Ergebniszusammenfassung
summary(mod2_locf)

# Regressionsergebnisse zusammenführen
lines$int3 <- coef(mod2_locf)[1] + c(0,coef(mod2_locf)[3:4])
lines$slo3 <- coef(mod2_locf)[2]

# Grafische Darstellung
scatter +
  geom_abline(data = lines, aes(intercept = int2, slope = slo2, color = condition), linetype = 'solid') +
  geom_abline(data = lines, aes(intercept = int3, slope = slo3, color = condition), linetype = 'dashed') 


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
mod3 <- lm(CDI3 - CDI1 ~ condition, cope)

# Ergebniszusammenfassung
summary(mod3)

# Change zur ANOVA
anova(mod3)

# Zenrierung der Kovariate
cope$CDI1_c <- scale(cope$CDI1, scale = FALSE)

# Generalisierte ANCOVA
mod4 <- lm(CDI3 ~ CDI1_c * condition, cope)

# Ergebniszusammenfassung
summary(mod4)

# ANCOVA mit zentriertem Prädiktor aufstellen (zum Vergleich)
mod2b <- lm(CDI3 ~ CDI1_c + condition, cope)

# Regressionsergebnisse zusammenführen
lines <- data.frame(condition = c("Placebo Control", "Project Personality", "Project ABC"), 
  int1 = coef(mod2b)[1] + c(0, coef(mod2b)[3:4]),
  slo1 = coef(mod2b)[2],
  int2 = coef(mod4)[1] + c(0, coef(mod4)[3:4]),
  slo2 = coef(mod4)[2] + c(0, coef(mod4)[5:6]))

# Grafische Darstellung
scatter <- ggplot(cope, aes(x = CDI1_c, y = CDI3, color = condition)) + 
  theme_pandar() + scale_color_pandar() + geom_point(alpha = 0) + xlim(-.25, .25) + ylim(.75, 1.25)

scatter +
  geom_abline(data = lines, aes(intercept = int1, slope = slo1, color = condition), linetype = 'solid') +
  geom_abline(data = lines, aes(intercept = int2, slope = slo2, color = condition), linetype = 'dashed') 


# Effekt bei überdurchschnittlicher Kovariate
cope$CDI1_above <- cope$CDI1_c + sd(cope$CDI1_c)
mod4b <- lm(CDI3 ~ CDI1_above * condition, cope)
summary(mod4b)

# Effekt bei unterdurchschnittlicher Kovariate
cope$CDI1_below <- cope$CDI1_c - sd(cope$CDI1_c)
mod4c <- lm(CDI3 ~ CDI1_below * condition, cope)
summary(mod4c)
