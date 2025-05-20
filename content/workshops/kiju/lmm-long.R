library(knitr)

load(url('https://pandar.netlify.app/daten/Sunday.rda'))
head(sunday)

## load('../../daten/Sunday.rda')
## head(sunday)

## # Für Plots der Modelle - dauert einen Moment
## install.packages('sjPlot', dependencies = TRUE)
## 
## # Für eine erweiterte Modellzusammenfassung
## installpackages('jtools')

## # Für Inferenz der fixed effects
## install.packages('lmerTest')
## 
## # Für Bestimmung von Pseudo R^2
## install.packages('MuMIn')

library(lme4)
library(sjPlot)
library(jtools)
library(ggplot2)

mod0 <- lmer(wm ~ 1 + (1 | id), sunday)
print(summ(mod0))

# Individuelle Traits (Ewartungswerte, beta0i)
coef(mod0)$id |> head()

# Abweichungen (u0i)
ranef(mod0)$id |> head()

plot_model(mod0, 're', sort.est = '(Intercept)')

mod1 <- lmer(wm ~ 1 + ctime + (1 | id), sunday)
print(summ(mod1))
sunday$pred_mod1 <- predict(mod1)

subset(sunday, as.numeric(id) < 10) |>
  ggplot(aes(x = ctime, y = wm, color = id)) + 
    geom_point() + 
    geom_line(aes(y = pred_mod1)) +
    theme_minimal() + facet_wrap(~ id)

plot_model(mod1, 'slope')
sunday$ct_quad <- sunday$ctime^2

cor(sunday$ctime, sunday$ctime^2)
poly(sunday$ctime, 2)

mod2 <- lmer(wm ~ 1 + poly(ctime, 2) + (1 | id), sunday)
print(summ(mod2))

tmp <- poly(sunday$ctime, 2)
sunday$poly1 <- tmp[,1]
sunday$poly2 <- tmp[,2]

## plot_model(mod2, 'pred') # hässlich
## 
## # schöner
## sunday$pred_mod2 <- predict(mod2)
## ggplot(sunday, aes(x = ctime, y = pred_mod2)) +
##   geom_smooth(se = FALSE)

tmp <- poly(sunday$ctime, 2)
tmp <- as.data.frame(tmp)
names(tmp) <- c('poly1', 'poly2')
sunday <- cbind(sunday, tmp)
mod3a <- lmer(wm ~ 1 + poly1 + poly2 + (1 + poly1 | id), sunday)
mod3b <- lmer(wm ~ 1 + poly1 + poly2 + (1 + poly1 + poly2 | id), sunday)
anova(mod2, mod3a, mod3b, refit = FALSE)

print(summ(mod3b))
VarCorr(mod3b)

sunday$pred_mod3 <- predict(mod3b)

subset(sunday, as.numeric(id) < 10) |>
  ggplot(aes(x = ctime, y = wm, color = id)) + 
    geom_point() + 
    geom_line(aes(y = pred_mod3)) +
    theme_minimal() + facet_wrap(~ id)

mod4 <- lmer(wm ~ 1 + poly1 + poly2 + pos + (1 + poly1 + poly2 | id), sunday)
print(summ(mod4))
sunday$pred_mod4 <- predict(mod4)

subset(sunday, as.numeric(id) < 10) |>
  ggplot(aes(x = ctime, y = wm, color = id)) + 
    geom_point(aes(shape = pos)) + 
    geom_line(aes(y = pred_mod4)) +
    theme_minimal() + facet_wrap(~ id)

mod5 <- lmer(wm ~ 1 + poly1 + poly2 + meq + (1 + poly1 + poly2 | id), sunday) # + meq = additiver Effekt auf das Mittel (Interaktion morning/evening)
print(summ(mod5))

mod5b <- lmer(wm ~ 1 + poly1 + poly2 + meq + meq:poly2 + meq:poly1 + # kann meq weggelassen werden, wenn es nicht interessiert?
                (1 + poly1 + poly2 | id), sunday)
summ(mod5b)

mod6 <- lmer(wm ~ 1 + poly1*meq + poly2*meq + (1 + poly1 + poly2 | id), sunday)
print(summ(mod6))
plot_model(mod6, 'pred', terms = c('poly1', 'meq'))

## # mit basis R-Befehlen
## sunday$wm_lag <- NA
## for (i in sunday$id) {
##   sunday[sunday$id == i, 'wm_lag'] <- embed(c(NA, sunday[sunday$id == i, 'wm']), 2)[, 2]
## }
## 
## # mit dplyr (sehr verbreitet)
## library(dplyr)
## sunday <- group_by(sunday, id) %>% mutate(wm_lag = lag(wm))

mod0 <- lmer(gs ~ 1 + (1 | id), sunday)
mod1 <- lmer(gs ~ 1 + gs_lag + (1 | id), sunday)
anova(mod0, mod1)

mod0b <- update(mod0, data = mod1@frame)
mod1b <- update(mod1, data = mod1@frame)
anova(mod0b, mod1b)

MuMIn::r.squaredGLMM(mod0b)
MuMIn::r.squaredGLMM(mod1b)

print(summ(mod1b))

curve(.47^x, xlim = c(0, 7))

library(nlme)
mod0_nlme <- lme(fixed = gs ~ 1, random = ~ 1 | id, data = sunday)
summary(mod0_nlme)
summary(mod0)
mod1_nlme <- lme(fixed = gs ~ 1, random = ~ 1 | id, data = sunday, 
  correlation = corAR1())
summary(mod1_nlme)

mod2_nlme <- lme(fixed = gs ~ 1, random = ~ 1 | id, data = sunday, 
  correlation = corCAR1(, form = ~ ctime))
summary(mod2_nlme)

difftime <- vector('numeric')
for (i in sunday$id) {
  difftime <- c(difftime, diff(sunday[sunday$id == i, 'ctime']))
}

