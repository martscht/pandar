library(knitr)

## load(url('https://pandar.netlify.app/post/kultur.rda'))
## head(kultur)[, 1:8] # alle Zeilen und Spalten 1-8 für die ersten 6 Personen

load("../../daten/kultur.rda")
head(kultur)[, 1:8] # alle Zeilen und Spalten 1-8 für die ersten 6 Personen

levels(kultur$nation) # Übersicht über alle vorkommenden Nationen

dim(kultur) # Anzahl Zeilen und Spalten des ganzen Datensatzes

mod <- lm(lezu ~ 1 + pa, kultur) # Interzept wird hier explizit angefordert
summary(mod)

library(ggplot2)
ggplot(kultur, aes(x = pa, y = lezu)) + 
  geom_point() +
  geom_abline(intercept = coef(mod)[1], slope = coef(mod)[2], color = 'blue') +
  theme_minimal()

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
mod0 <- lmer(lezu ~ 1 + (1 | nation), kultur)

summary(mod0)

confint(mod0)

library(lmerTest)
mod0 <- lmer(lezu ~ 1 + (1 | nation), kultur)
summary(mod0)

summary(mod0)$var

library(sjPlot)
plot_model(mod0, type = 're', sort.est = '(Intercept)') +  # Plot für Random Effects (re), sortiert nach Schätzung (est) der Interzept ('(Intercept)')
  ggplot2::theme_minimal() # Layout

# Breite der Fehlerbalken hängt mit Stichprobengröße zusammen

ranef(mod0)

tmp <- VarCorr(mod0) |> as.data.frame()
tmp$vcov[1] / sum(tmp$vcov)

library(jtools)
print(summ(mod0))

mod1 <- lmer(lezu ~ 1 + pa + (1 | nation), kultur) # pa als Prädiktor zusätzlich aufnehmen
print(summ(mod1))

coef(mod1)$nation['Canada',] # spezifische Koeffizienten für Kanada auswählen

mod1b <- lmer(lezu ~ 1 + pa + (1 + pa | nation), kultur) # Random Intercept Random Slope Modell
summ(mod1b)

plot_model(mod1, type = 're', sort.est = '(Intercept)')

mod2 <- lmer(lezu ~ 1 + pa + na + (1 | nation), kultur)
print(summ(mod2))

anova(mod0, mod1, mod2)

kultur_comp <- mod2@frame
mod0_u <- update(mod0, data = kultur_comp)
mod1_u <- update(mod1, data = kultur_comp)
mod2_u <- update(mod2, data = kultur_comp)

anova(mod0_u, mod1_u, mod2_u)

mod3 <- lmer(lezu ~ 1 + pa + na + (1 + pa + na | nation), kultur)

# Optimizer wechseln, langsamer aber Versuch Konvergenz zu erreichen
opts <- lmerControl(optimizer = 'bobyqa')
mod3 <- lmer(lezu ~ 1 + pa + na + (1 + pa + na | nation), kultur, control = opts)

print(summ(mod3))

summary(mod3)$varcor

## anova(mod0, mod1) # Fehlermeldung, da Modelle auf den gleichen Datensatz angewandt werden müssen

# Respezifizierung
mod0b <- update(mod0, data = mod1@frame)
mod1b <- update(mod1, data = mod1@frame)

anova(mod0b, mod1b)

anova(mod2, mod3, refit = FALSE)

## confint(mod3)
load('KiJu_LMMs_confint3.rda')
print(ci_mod3)

coef(mod3)

plot_model(mod3, type = 're', grid = FALSE, sort.est = TRUE)[c(1,3)]

mod4 <- lmer(lezu ~ 1 + pa + na + gdp + (1 | nation), kultur)
print(summ(mod4))

cwc <- with(kultur, aggregate(cbind(pa, na) ~ nation, FUN = mean))
names(cwc) <- c('nation', 'pa_mean', 'na_mean')
kultur_cen <- merge(kultur, cwc, by = 'nation', all.x = TRUE)

kultur$pa_cwc <- kultur$pa - kultur$pa_mean
kultur$na_cwc <- kultur$na - kultur$na_mean

mod5 <- lmer(lezu ~ 1 + pa_mean + pa_cwc + na_mean + na_cwc + (1 | nation), kultur)
print(summ(mod5))

mod6 <- lmer(lezu ~ pa_cwc*gdp + na_cwc*gdp + pa_mean*gdp + na_mean*gdp + (pa_cwc + na_cwc | nation), kultur)
print(summ(mod6))
plot_model(mod6, 'pred', 
  terms = c('na_cwc', 'gdp'))

plot_model(mod6, 'est')
