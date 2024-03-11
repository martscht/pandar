## load("C:/Users/Musterfrau/Desktop/conspiracy.rda")

load(url("https://pandar.netlify.app/daten/conspiracy.rda"))

dim(conspiracy)

head(conspiracy)

library(car)
leveneTest(conspiracy$ET ~ conspiracy$urban)

# Gruppenmittelwerte ermitteln
mu_k <- aggregate(conspiracy$ET, list(conspiracy$urban), mean)
mu_k

names(mu_k) <- c('urban', 'ET_mu_k')

temp <- merge(conspiracy, mu_k, by = 'urban')
dim(temp)
names(temp)

# Gesamtmittelwert ermitteln
mu <- mean(conspiracy$ET)

# Gruppengrößen ermitteln
n_k <- table(conspiracy$urban)

QS_inn <- sum((temp$ET - temp$ET_mu_k)^2)

QS_zw <- sum(n_k * (mu_k[, 2] - mu)^2)

MQS_inn <- QS_inn / (nrow(conspiracy) - nlevels(conspiracy$urban))
MQS_zw <- QS_zw / (nlevels(conspiracy$urban)-1)

F_wert <- MQS_zw/MQS_inn

pf(F_wert, nlevels(conspiracy$urban)-1, nrow(conspiracy) - nlevels(conspiracy$urban), lower.tail = FALSE)



## # Paket installieren
## install.packages("ez")

# Paket laden 
library(ez)

conspiracy$id <- 1:nrow(conspiracy)

conspiracy$id <- as.factor(conspiracy$id)

ezANOVA(conspiracy, wid = id, dv = ET, between = urban)

ezANOVA(conspiracy, wid = id, dv = ET, between = urban, detailed = TRUE)

pairwise.t.test(conspiracy$ET, conspiracy$urban, p.adjust = 'bonferroni')

alternative<- aov(ET ~ urban, data = conspiracy)

summary(alternative)

TukeyHSD(alternative, conf.level = 0.95)

tuk <- TukeyHSD(aov(ET ~ urban, data = conspiracy))
plot(tuk)

aov_t <- ezANOVA(conspiracy, wid = id, dv = ET, between = urban, return_aov = T)
names(aov_t)

class(aov_t$aov)

TukeyHSD(aov_t$aov, conf.level = 0.95)
