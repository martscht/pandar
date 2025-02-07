## load('fairplayer.rda')

load(url("https://pandar.netlify.app/daten/fairplayer.rda"))

# Namen der Variablen abfragen
names(fairplayer)

# Anzahl der Zeilen und Spalten
dim(fairplayer)

# Struktur des Datensatz - Informationen zur Variablentypen
str(fairplayer)

# Ersten Zeilen des Datensatzes ansehen
head(fairplayer)

## fairplayer$rat1 <- (fairplayer$ra1t1 + fairplayer$ra2t1 + fairplayer$ra3t1) / 3

fairplayer$rat1 <- rowMeans(fairplayer[, c('ra1t1', 'ra2t1', 'ra3t1')],
  na.rm = TRUE)

fairplayer$emt1 <- rowMeans(fairplayer[, c('em1t1', 'em2t1', 'em3t1')],
  na.rm = TRUE)
fairplayer$sit1 <- rowMeans(fairplayer[, c('si1t1', 'si2t1', 'si3t1')],
  na.rm = TRUE)

summary(fairplayer$rat1)

summary(fairplayer$grp)

cov(fairplayer$rat1, fairplayer$sit1, use = 'complete')
cor(fairplayer$rat1, fairplayer$sit1, use = 'complete')

scales <- fairplayer[, c('rat1', 'emt1', 'sit1')]

cor(scales, use = 'complete')

cov(scales, use = 'complete')

diag(cov(scales, use = 'complete'))

mod <- lm(rat1 ~ 1 + sit1 + emt1, fairplayer)

mod

# Koeffizienten als Objekt ablegen
b <- coef(mod)

# Scatterplot mit Regressionslinie
library(ggplot2)
ggplot(fairplayer, aes(x = sit1, y = rat1)) +
  geom_point() +
  geom_abline(intercept = b['(Intercept)'], slope = b['sit1'],
    color = '#00618f', lwd = 1.5) +
  labs(x = 'Soziale Intelligenz', y = 'Relationale Aggression')

summary(mod)

summary(mod)$coef

summary(mod)$r.squared

mod <- 'rat1 ~ 1 + sit1 + emt1'

mod <- 'rat1 ~ 1 + sit1 + emt1
  rat1 ~~ rat1'

## mod <- '
##   # Regression
##   rat1 ~ 1
##   rat1 ~ sit1
##   rat1 ~ emt1
## 
##   # Residuum
##   rat1 ~~ rat1'

fit <- lavaan(mod, fairplayer)

## summary(fit)






abbrev(fit, 'Intercept', 'Variances')



summary(fit, standardized = TRUE)

inspect(fit, 'rsquare')

# Unstandardisierte Parameter
parameterEstimates(fit)

## # Standardisierte Parameter
## standardizedSolution(fit)
