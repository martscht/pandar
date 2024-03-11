library(lavaan)
library(fontawesome)

abbrev <- function(X, begin = 'Latent Variables', end = NULL, ellipses = 'both', shift = 2, ...) {
  
  tmp <- capture.output(lavaan::summary(X,...))
  
  if (is.null(begin)) begin <- 1
  else begin <- grep(begin, tmp, fixed = TRUE)[1]
  if (is.null(end)) end <- length(tmp)-shift
  else end <- grep(end, tmp, fixed = TRUE)[grep(end, tmp, fixed = TRUE) > begin][1]-shift
  
  if (ellipses == 'both') {
    cat('[...]\n', paste(tmp[begin:end], collapse = '\n'), '\n[...]\n')
  }
  if (ellipses == 'top') {
    cat('[...]\n', paste(tmp[begin:end], collapse = '\n'))
  }
  if (ellipses == 'bottom') {
    cat(paste(tmp[begin:end], collapse = '\n'), '\n[...]\n')
  }
  if (ellipses == 'none') {
    cat(paste(tmp[begin:end], collapse = '\n'))
  }
}

## load('fairplayer.rda')

#load(url('https://pandar.netlify.com/daten/fairplayer.rda'))
load(url("https://courageous-donut-84b9e9.netlify.app/post/fairplayer.rda"))

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

plot(fairplayer$rat1 ~ fairplayer$sit1)
abline(coef(mod)[1], coef(mod)[2])

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
lavaan::summary(fit)

abbrev(fit, 'Regressions', 'Intercepts')

summary(lm(rat1 ~ sit1 + emt1, fairplayer))$coef

abbrev(fit, 'Intercept', 'Variances')

abbrev(fit, 'Variances', ellipses = 'top', shift = 1)

inspect(fit, 'rsquare')
