# Vorbereitungen
knitr::opts_chunk$set(echo = TRUE, fig.align = "center")
library(ggplot2) # ggplot2 und dplyr werden nur für Grafiken benötigt

set.seed(123456) # Vergleichbarkeit
Z <- rnorm(10000) # 10^4 std. normalverteilte Zufallsvariablen simulieren
h <- hist(Z, breaks=50, plot=FALSE)
cuts <- cut(h$breaks, c(-4,-1,4))
plot(h, col=cuts,  freq = F)
lines(x = seq(-4,4,0.01), dnorm(seq(-4,4,0.01)), col = "blue", lwd = 3)
abline(v = -1, lwd = 3, lty = 3, col = "gold3")

h <- hist(Z, breaks=50, plot=FALSE)
cuts <- cut(h$breaks, c(-4,2,4))
plot(h, col=cuts,  freq = F)
lines(x = seq(-4,4,0.01), dnorm(seq(-4,4,0.01)), col = "blue", lwd = 3)
abline(v = 2, lwd = 3, lty = 3, col = "gold3")

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

plot(X, Y, pch = 16, col = "skyblue", cex = 1.5)
points(X, Y_obs, pch = 16, col = "black")
abline(reg_pop, col = "blue", lwd = 5)
abline(reg_obs, col = "gold3", lwd = 5)
legend(x = "bottomright", legend = c("all", "observed", "regression: all", "regression: observed"), col = c("skyblue", "black", "blue", "gold3"), lwd = c(NA, NA, 5, 5), pch = c(16, 16, NA, NA))

library(sampleSelection) # Paket laden
heckman <- heckit(selection = s ~ 1 + X, outcome = Y_obs ~ 1 + X)
summary(heckman)

cat(' --------------------------------------------
 Tobit 2 model (sample selection model)
 2-step Heckman / heckit estimation
 1000 observations (770 censored and 230 observed)
 7 free parameters (df = 994)')

cat(' Probit selection equation:
             Estimate Std. Error t value Pr(>|t|)    
 (Intercept) -1.97383    0.10924  -18.07   <2e-16 ***
 X            0.47668    0.03332   14.30   <2e-16 ***')

cat(' Outcome equation:
             Estimate Std. Error t value Pr(>|t|)  
 (Intercept)  -1.4740     5.3634  -0.275   0.7835  
 X             1.3896     0.7893   1.761   0.0786 .
 Multiple R-Squared:0.0687,   Adjusted R-Squared:0.0605')

cat('    Error terms:
               Estimate Std. Error t value Pr(>|t|)
 invMillsRatio   3.2594     2.4788   1.315    0.189
 sigma           3.5439         NA      NA       NA
 rho             0.9197         NA      NA       NA
 --------------------------------------------')

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

cat(' --------------------------------------------
 Tobit 2 model (sample selection model)
 2-step Heckman / heckit estimation
 100000 observations (76025 censored and 23975 observed)
 7 free parameters (df = 99994)
 Probit selection equation:
              Estimate Std. Error t value Pr(>|t|)    
 (Intercept) -2.004099   0.011093  -180.7   <2e-16 ***
 X            0.502194   0.003425   146.6   <2e-16 ***
 Outcome equation:
             Estimate Std. Error t value Pr(>|t|)    
 (Intercept)  0.41902    0.37339   1.122    0.262    
 X            1.21045    0.05605  21.595   <2e-16 ***
 Multiple R-Squared:0.1329,   Adjusted R-Squared:0.1328
    Error terms:
               Estimate Std. Error t value Pr(>|t|)    
 invMillsRatio   2.0698     0.1747   11.85   <2e-16 ***
 sigma           2.8613         NA      NA       NA    
 rho             0.7234         NA      NA       NA    
 ---
 Signif. codes:  0 \'***\' 0.001 \'**\' 0.01 \'*\' 0.05 \'.\' 0.1 \' \' 1
 --------------------------------------------')
