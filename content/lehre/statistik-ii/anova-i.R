## load("C:/Users/Musterfrau/Desktop/conspiracy.rda")

load(url("https://pandar.netlify.app/daten/conspiracy.rda"))

dim(conspiracy)

head(conspiracy)

# Gruppenmittelwerte ermitteln
y_mean_k <- aggregate(ET ~ urban, conspiracy, mean)
y_mean_k

names(y_mean_k) <- c('urban', 'ET_mean_k')

temp <- merge(conspiracy, y_mean_k, by = 'urban')
dim(temp)    # Dimensionen des temporären Datensatzes
names(temp)  # Spaltennamen des temporären Datensatzes
head(temp)   # ersten 6 Zeilen des temporären Datensatzes

# Gesamtmittelwert ermitteln
y_mean_ges <- mean(conspiracy$ET)
y_mean_ges 

# Gruppengrößen ermitteln
n_k <- table(conspiracy$urban)
n_k

QS_inn <- sum((temp$ET - temp$ET_mean_k)^2)

QS_zw <- sum(n_k * (y_mean_k[, 2] - y_mean_ges)^2)

N <- nrow(conspiracy) # Stichprobengröße bestimmen
K <- nlevels(conspiracy$urban) # Gruppenanzahl bestimmen

MQS_inn <- QS_inn / (N - K)
MQS_zw <- QS_zw / (K - 1)

F_wert <- MQS_zw/MQS_inn

pf(F_wert, nlevels(conspiracy$urban)-1, nrow(conspiracy) - nlevels(conspiracy$urban), lower.tail = FALSE)



## # Paket installieren
## install.packages("afex")

# Paket laden 
library(afex)

aov_4(ET ~ urban, data = conspiracy)

conspiracy$id <- 1:nrow(conspiracy)

aov_4(ET ~ urban + (1|id), data = conspiracy)

einfakt <- aov_4(ET ~ urban + (1|id), data = conspiracy)

pairwise.t.test(conspiracy$ET, conspiracy$urban, p.adjust = 'bonferroni')

## # Paket installieren
## install.packages("emmeans")

library(emmeans)

emm_einfakt <- emmeans(einfakt, ~ urban)

tukey <- pairs(emm_einfakt, adjust = "tukey")
tukey

confint(tukey)

plot(tukey)
