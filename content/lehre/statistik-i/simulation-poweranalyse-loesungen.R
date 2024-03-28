N <- 20

set.seed(12345)
X <- rnorm(N)
Z <- rnorm(N)
Y <- 0.5*X + sqrt(1 - 0.5^2)*Z
cor(X, Y) # empirische Korrelation
sd(X) 
sd(Y)

N <- 10^6

set.seed(12345)
X <- rnorm(N)
Z <- rnorm(N)
Y <- 0.5*X + sqrt(1 - 0.5^2)*Z
cor(X, Y) # empirische Korrelation
sd(X) 
sd(Y)

N <- 20
set.seed(12345)
pcor_H1 <- replicate(n = 10000, expr = {X <- rnorm(N)
                                        Z <- rnorm(N)
                                        Y <- 0.5*X + sqrt(1 - 0.5^2)*Z
                                        cortestH1 <- cor.test(X, Y)
                                        cortestH1$p.value})
mean(pcor_H1 < 0.05) # empirische Power

set.seed(12345)
cors_H1 <- replicate(n = 10000, expr = {X <- rnorm(N)
                                        Z <- rnorm(N)
                                        Y <- 0.5*X + sqrt(1 - 0.5^2)*Z
                                        cor(X, Y)})
summary(cors_H1)
hist(cors_H1, breaks = 50)

N <- 10^6

set.seed(12345)
X <- rnorm(N)
Z <- rnorm(N)
Y <- 0.5*X + sqrt(1 - 0.5^2)*Z
X_new <- 3*X
Y_new <- 0.5*Y
cor(X_new, Y_new) # empirische Korrelation
sd(X_new) 
sd(Y_new)

N <- 20
set.seed(12345)
pcor_H1_new <- replicate(n = 10000, expr = {X <- rnorm(N)
                                            Z <- rnorm(N)
                                            Y <- 0.5*X + sqrt(1 - 0.5^2)*Z
                                            X_new <- 3*X
                                            Y_new <- 0.5*Y
                                            cortestH1 <- cor.test(X_new, Y_new)
                                            cortestH1$p.value})
mean(pcor_H1_new < 0.05) # empirische Power

library(WebPower)
?wp.correlation

wp.correlation(n = 50, r = NULL, power = 0.95, alpha = 0.05, alternative = c("two.sided"))

N <- 20
set.seed(12345)
pt_H0 <- replicate(n = 10000, expr = {X <- rnorm(N)
                                      Y <- rnorm(N) 
                                      ttestH1 <- t.test(X, Y, var.equal = TRUE)
                                      ttestH1$p.value})
mean(pt_H0 < 0.001) # empirischer Alpha-Fehler

set.seed(12345)
pt_H1 <- replicate(n = 10000, expr = {X <- rnorm(N)
                                      Y <- rnorm(N) + 0.5
                                      ttestH1 <- t.test(X, Y, var.equal = TRUE)
                                      ttestH1$p.value})
mean(pt_H1 < 0.001) # empirische Power

set.seed(12345)
pt_H1_0 <- replicate(n = 10000, expr = {X <- rnorm(20)
                                        Y <- rnorm(20) 
                                        ttestH1 <- t.test(X, Y, var.equal = TRUE)
                                        ttestH1$p.value})
pt_H1_0.25 <- replicate(n = 10000, expr = {X <- rnorm(20)
                                           Y <- rnorm(20) + 0.25 
                                           ttestH1 <- t.test(X, Y, var.equal = TRUE)
                                           ttestH1$p.value})
pt_H1_0.5 <- replicate(n = 10000, expr = {X <- rnorm(20)
                                          Y <- rnorm(20) + 0.5 
                                          ttestH1 <- t.test(X, Y, var.equal = TRUE)
                                          ttestH1$p.value})
pt_H1_0.75 <- replicate(n = 10000, expr = {X <- rnorm(20)
                                           Y <- rnorm(20) + 0.75 
                                           ttestH1 <- t.test(X, Y, var.equal = TRUE)
                                           ttestH1$p.value})
pt_H1_1 <- replicate(n = 10000, expr = {X <- rnorm(20)
                                        Y <- rnorm(20) + 1 
                                        ttestH1 <- t.test(X, Y, var.equal = TRUE)
                                        ttestH1$p.value})
pt_H1_1.25 <- replicate(n = 10000, expr = {X <- rnorm(20)
                                           Y <- rnorm(20) + 1.25 
                                           ttestH1 <- t.test(X, Y, var.equal = TRUE)
                                           ttestH1$p.value})
t_power_d <- c(mean(pt_H1_0 < 0.05),
               mean(pt_H1_0.25 < 0.05),
               mean(pt_H1_0.5 < 0.05),
               mean(pt_H1_0.75 < 0.05),
               mean(pt_H1_1 < 0.05),
               mean(pt_H1_1.25 < 0.05))
Ds <- seq(0, 1.25, 0.25)
plot(x = Ds, y = t_power_d, type = "b", main = "Power vs. d")

N <- 20
set.seed(12345)
pt_H1_t <- replicate(n = 10000, expr = {X <- rnorm(N)
                                      Y <- rnorm(N) + 0.5
                                      ttestH1 <- t.test(X, Y, var.equal = TRUE)
                                      ttestH1$p.value})
mean(pt_H1_t < 0.05) # empirische Power des t-Tests

set.seed(12345)
pt_H1_W <- replicate(n = 10000, expr = {X <- rnorm(N)
                                      Y <- rnorm(N) + 0.5
                                      wilcoxonH1 <- wilcox.test(X, Y)
                                      wilcoxonH1$p.value})
mean(pt_H1_W < 0.05) # empirische Power des Wilcoxon-Tests
