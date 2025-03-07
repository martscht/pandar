library(knitr)

## library(haven)
## setwd("~/Pfad/zu/Ordner")
## data <- read_sav(file = "fb22_mod.sav")
## data$geschl_faktor <- factor(data$geschl,                                   # Ausgangsvariable
##                              levels = c(1, 2, 3),                           # Faktorstufen
##                              labels = c("weiblich", "männlich", "anderes")) # Label für Faktorstufen
## data$nr_ges <- rowMeans(data[,c("nr1", "nr2", "nr3", "nr4", "nr5", "nr6")])
## data$prok <- rowMeans(data[,c("prok1", "prok4", "prok6", "prok9", "prok10")])
## 
## data$wohnen_faktor <- factor(data$wohnen,
##                              levels = c(1, 2, 3, 4),
##                              labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

library(haven)
data <- read_sav(file = "../../daten/fb22_mod.sav")
data$geschl_faktor <- factor(data$geschl,                                   # Ausgangsvariable
                             levels = c(1, 2, 3),                           # Faktorstufen
                             labels = c("weiblich", "männlich", "anderes")) # Label für Faktorstufen
data$nr_ges <- rowMeans(data[,c("nr1", "nr2", "nr3", "nr4", "nr5", "nr6")])
data$prok <- rowMeans(data[,c("prok1", "prok4", "prok6", "prok9", "prok10")])

data$wohnen_faktor <- factor(data$wohnen,                                   
                             levels = c(1, 2, 3, 4),                                
                             labels = c("WG", "bei Eltern", "alleine", "sonstiges")) 

aggregate(extra ~ geschl_faktor, data = data, FUN = mean)

lm(extra ~ lz, data = data)

mod <- lm(extra ~ lz, data = data)

mod$coefficients
mod$call

class(data)
class(mod)

summary(mod)

summary(data)

mod_kont <- lm(lz ~ neuro + intel, data = data)

class(mod_kont)
summary(mod_kont)

mod_kat <- lm(lz ~ intel + geschl, data = data)
summary(mod_kat)

mod_kat <- lm(lz ~ intel + geschl_faktor, data = data)
summary(mod_kat)

data$neuro_center <- scale(data$neuro, scale = F, center = T)
data$intel_center <- scale(data$intel, scale = F, center = T)

mean(data$neuro_center)
mean(data$intel_center)

mod_inter_nocenter <- lm(lz ~ neuro + intel + neuro * intel, data = data)
mod_inter_center <- lm(lz ~ neuro_center + intel_center + neuro_center * intel_center, data = data)
summary(mod_inter_nocenter)
summary(mod_inter_center)

mod_inter_center <- lm(lz ~ neuro_center * intel_center, data = data)
summary(mod_inter_center)

mod_inter_center <- lm(lz ~ neuro_center + intel_center + neuro_center:intel_center, data = data)
summary(mod_inter_center)

## install.packages("interactions")
## library(interactions)

library(interactions)

interact_plot(model = mod_inter_center, pred = intel_center, modx = neuro_center)

mod_extra <- lm(extra ~ wohnen_faktor + vertr, data = data)
summary(mod_extra)

library(lm.beta)
lm.beta(mod_extra)
summary(lm.beta(mod_extra))

mod_extra |> lm.beta() |> summary()

data$nr_ges_center <- scale(data$nr_ges, scale = F, center = T) 
data$prok_center <- scale(data$prok, scale = F, center = T)
data$vertr_center <- scale(data$vertr, scale = F, center = T)

mod_falsch <- lm(extra ~ nr_ges_center * prok_center * vertr_center, data = data)
summary(mod_falsch)

mod_korrekt <- lm(extra ~ nr_ges_center + prok_center + vertr_center + nr_ges_center:prok_center:vertr_center, data = data)
summary(mod_korrekt)
