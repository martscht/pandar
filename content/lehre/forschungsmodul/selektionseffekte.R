set.seed(123456)                 # Vergleichbarkeit
Z <- rnorm(10000)                # 10^4 std. normalverteilte Zufallsvariablen simulieren
pnorm(q = -1, mean = 0, sd = 1)  # Theoretische Wahrscheinlichkeit, dass Z <= -1
mean(Z <= -1)                    # Empirische (beoabachtete) Wahrscheinlichkeit, dass Z <= -1
pnorm(q = 2, mean = 0, sd = 1)   # Theoretische Wahrscheinlichkeit, dass Z <= 2
mean(Z <= 2)                     # Empirische (beoabachtete) Wahrscheinlichkeit, dass Z <= 2

set.seed(1234567)
n <- 1000
Z <- rnorm(n = n, mean = 0, sd = 1)
X <- rnorm(n = n, mean = 2, sd = 5) # die Verteilung von X ist beliebig

# Selektion
beta0 <- -2
beta1 <- .5
s <- beta0 + beta1*X + Z > 0

probit_model <- glm(s ~ 1 + X, family = binomial(link = "probit"))
summary(probit_model)

set.seed(1234567)
n <- 1000
X <- rnorm(n = n, mean = 2, sd = 2)
Z <- rnorm(n = n, mean = 0, sd = 1)

# Populationsregression
b0 <- 0.5
b1 <- 1.2
r <- 2
sigma <- 2

eps <- rnorm(n = n, mean = 0, sd = sigma)
Y <- b0 + b1*X + r*Z + eps # Populationsregression


# Selektion
beta0 <- -2
beta1 <- .5
s <- beta0 + beta1*X + Z > 0   # Selektionsmechanismus

Y_obs <-rep(NA, length(Y))
Y_obs[s == 1] <- Y[ s== 1]     # beobachtbares Y

reg_obs <- lm(Y_obs ~ X)
reg_obs

reg_pop <- lm(Y ~ X)
reg_pop

cor(X[s==1], Z[s==1])

cor(X, Z)

cor.test(X[s==1], Z[s==1])
cor.test(X, Z)



library(sampleSelection) # Paket laden
heckman <- heckit(selection = s ~ 1 + X, outcome = Y_obs ~ 1 + X)
summary(heckman)









coef(summary(heckman))

heckman_ML <- selection(selection = s ~ 1 + X, outcome = Y_obs ~ 1 + X)
summary(heckman_ML)

coef(summary(heckman_ML))

## load(url("https://pandar.netlify.app/post/HeckData.rda"))

set.seed(123456) # Vergleichbarkeit
Z <- rnorm(10000) # 10^4 std. normalverteilte Zufallsvariablen simulieren
h <- hist(Z, breaks=50, plot=FALSE)
cuts <- cut(h$breaks, c(-4,-1,4)) # Grenzen festlegen für Färbung
plot(h, col=cuts,  freq = F)
lines(x = seq(-4,4,0.01), dnorm(seq(-4,4,0.01)), col = "blue", lwd = 3)
abline(v = -1, lwd = 3, lty = 3, col = "gold3")

h <- hist(Z, breaks=50, plot=FALSE)
cuts <- cut(h$breaks, c(-4,2,4)) # Grenzen festlegen für Färbung
plot(h, col=cuts,  freq = F)
lines(x = seq(-4,4,0.01), dnorm(seq(-4,4,0.01)), col = "blue", lwd = 3)
abline(v = 2, lwd = 3, lty = 3, col = "gold3")

plot(X, Y, pch = 16, col = "skyblue", cex = 1.5)
points(X, Y_obs, pch = 16, col = "black")
abline(reg_pop, col = "blue", lwd = 5)
abline(reg_obs, col = "gold3", lwd = 5)
legend(x = "bottomright", legend = c("all", "observed", "regression: all", "regression: observed"), col = c("skyblue", "black", "blue", "gold3"), lwd = c(NA, NA, 5, 5), pch = c(16, 16, NA, NA))

simulate_heckman <- function(n, 
                             beta0, beta1,
                             b0, b1, r,
                             sigma)
{
     X <- rnorm(n = n, mean = 2, sd = 2)
     Z <- rnorm(n = n, mean = 0, sd = 1)
     
     # Populationsregression
     eps <- rnorm(n = n, mean = 0, sd = sigma)
     Y <- b0 + b1*X + r*Z + eps # Populationsregression
     
     
     # Selektion
     s <- beta0 + beta1*X + Z > 0   # Selektionsmechanismus
     
     Y_obs <-rep(NA, length(Y))
     Y_obs[s == 1] <- Y[s == 1]     # beobachtbares Y
     
     df <- data.frame("X" = X, "s" = s, "Y_obs" = Y_obs)
     return(df)
}

set.seed(404) # Vergleichbarkeit
# Daten simulieren
data_heckman <- simulate_heckman(n = 10^5, 
                                 beta0 = -2, beta1 = 0.5, 
                                 b0 = 0.5, b1 = 1.2, r = 2, sigma = 2)
head(data_heckman) # Daten ansehen

## # Heckman Modell schätzen für große n
## heckman_model  <- heckit(selection = s ~ 1 + X, outcome = Y_obs ~ 1 + X, data = data_heckman)
## summary(heckman_model)
