source("https://pandar.netlify.app/daten/Data_Processing_conspiracy.R")

dim(conspiracy)

head(conspiracy)

str(conspiracy)

library(afex)

conspiracy$id <- as.factor(1:nrow(conspiracy))

aov_4(EC ~ edu + (1|id), data = conspiracy)

aggregate(EC ~ edu, conspiracy, mean)

# Mithilfe des tapply-Befehls
tapply(X = conspiracy$EC, INDEX = conspiracy$edu, FUN = mean)

# Mithilfe des aggregate-Befehls mit anderer Schreibweise (wie bei tapply)
aggregate(conspiracy$EC, list(conspiracy$edu), mean)

# Mithilfe des describeBy-Befehls aus dem psych-Paket
library(psych)
describeBy(conspiracy$EC, conspiracy$edu)

# Kombinationsspezifische Mittelwertetabelle
aggregate(EC ~ urban + edu, conspiracy, mean)

library(ggplot2)

aggregate(EC ~ urban + edu, conspiracy, mean) |> 
  ggplot(aes(x = urban, y = EC, color = edu, group = edu)) +
    geom_point() +
    geom_line() +
    labs(x = "Urban", y = "Mean EC", color = "Education")









aov_4(EC ~ urban + edu + urban : edu + (1|id), data = conspiracy)

aov_4(EC ~ urban + edu + urban : edu + (1|id), data = conspiracy)

# QS-Typ 2
aov_4(EC ~ urban + edu + urban : edu + (1|id), data = conspiracy, type = "II")







zweifakt <- aov_4(EC ~ urban + edu + urban : edu + (1|id), data = conspiracy)

library(emmeans)
emm_zweifakt <- emmeans(zweifakt, ~ urban + edu + urban : edu)

tukey <- pairs(emm_zweifakt, adjust = "tukey")
tukey

plot(tukey)

emm_zweifakt

cont1 <- c(-0.5, -0.5, -0.5, -0.5, -0.5, -0.5, 1, 1, 1)
sum(cont1) == 0 # Check ob die Koeffizienten sich zu 0 addieren

contrast(emm_zweifakt, list(cont1))

cont2 <- c(0.5, 0, -0.5, 0.5, 0, -0.5, -1, 0, 1)

contrast(emm_zweifakt, list(cont1, cont2), adjust = 'bonferroni')
