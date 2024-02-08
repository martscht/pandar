# Vorbereitungen
knitr::opts_chunk$set(echo = TRUE, fig.align = "center")

## load("C:/Users/Musterfrau/Desktop/conspiracy.rda")

## load(url("https://pandar.netlify.app/post/conspiracy.rda"))
load("../../daten/conspiracy.rda")

dim(conspiracy)

head(conspiracy)

library(ez)

conspiracy$id <- as.factor(1:nrow(conspiracy))

ezANOVA(data = conspiracy, wid = id, dv = ET, between = urban)

ezANOVA(conspiracy, wid = id, dv = ET, between = edu, white.adjust = TRUE)

tapply(X = conspiracy$ET, INDEX = conspiracy$urban, FUN = mean)
tapply(X = conspiracy$ET, INDEX = conspiracy$edu, FUN = mean)

# Mithilfe des aggregate-Befehls
aggregate(ET ~ urban, data = conspiracy, mean)
aggregate(ET ~ edu, data = conspiracy, mean)

# Mithilfe des aggregate-Befehls mit anderer Schreibweise (wie bei tapply)
aggregate(conspiracy$ET, list(conspiracy$urban), mean)
aggregate(conspiracy$ET, list(conspiracy$edu), mean)

# Mithilfe des describeBy-Befehls aus dem psych-Paket
library(psych)
describeBy(conspiracy$ET, conspiracy$urban)
describeBy(conspiracy$ET, conspiracy$edu)

# Gruppierungskombinationen erstellen
kombi <- conspiracy[, c('urban', 'edu')]

# Kombinationsspezifische Mittelwertetabelle
tapply(X = conspiracy$ET, INDEX = kombi, FUN = mean)

ezStats(conspiracy, dv = ET, wid = id, between = c(urban, edu))

ezPlot(conspiracy, dv = ET, wid = id, between = c(urban, edu),
  x = urban, split = edu)

ezANOVA(conspiracy, dv = ET, wid = id, between = c(urban, edu), detailed = TRUE)

ezANOVA(conspiracy, dv = ET, wid = id, between = c(urban, edu), detailed = TRUE, white.adjust = TRUE)

TukeyHSD(aov(ET ~ urban*edu, conspiracy))

library(emmeans)

emm <- emmeans(aov(ET ~ urban*edu, conspiracy), ~ urban * edu)

emm

plot(emm)

plot(emm, comparisons = TRUE)

pwpp(emm)

ez1 <- ezANOVA(conspiracy, dv = ET, wid = id, between = c(urban, edu), detailed = TRUE, return_aov = T)
aov1 <- ez1$aov
emm1 <- emmeans(aov1, ~ urban * edu)
plot(emm1, comparisons = TRUE) # identisch zu oben

emm

cont1 <- c(1, -1, 0, 0, 0, 0, 0, 0, 0)

contrast(emm, list(cont1))

sum(cont1)
sum(cont1) == 0

cont2 <- c(0, 0, 1, 0, 0, -.5, 0, 0, -.5)

contrast(emm, list(cont1, cont2), adjust = 'bonferroni')

# QS-Typ 1, Reihenfolge 1
ezANOVA(conspiracy, dv = ET, wid = id, between = c(urban, edu), type = 1)

# QS-Typ 1, Reihenfolge 2
ezANOVA(conspiracy, dv = ET, wid = id, between = c(edu, urban), type = 1)

# QS-Typ 1, Reihenfolge 1 mit lm
anova(lm(ET ~ urban*edu, data = conspiracy))

# QS-Typ 1, Reihenfolge 2 mit lm
anova(lm(ET ~ edu*urban, data = conspiracy))

# QS-Typ 1, Reihenfolge 1 mit aov
summary(aov(ET ~ urban*edu, data = conspiracy))

# QS-Typ 1, Reihenfolge 2 mit aov
summary(aov(ET ~ edu*urban, data = conspiracy))

# QS-Typ 2
ezANOVA(conspiracy, dv = ET, wid = id, between = c(urban, edu), type = 2)

library(car)

Anova(lm(ET ~ urban*edu, data = conspiracy), type = "II")
Anova(aov(ET ~ urban*edu, data = conspiracy), type = "II")

# QS-Typ 3
ezANOVA(conspiracy, dv = ET, wid = id, between = c(urban, edu), type = 3)

# verstelle die Art, wie Kontraste bestimmt werden --- Achtung! Immer wieder zurückstellen
options(contrasts=c(unordered="contr.sum", ordered="contr.poly")) 
Anova(lm(ET ~ urban*edu, data = conspiracy), type = "III")
Anova(aov(ET ~ urban*edu, data = conspiracy), type = "III")

# Einstellungen zurücksetzen zum Default:
options(contrasts=c(unordered="contr.treatment", ordered="contr.poly"))

# Der Default kann getestet werden via
options("contrasts")
