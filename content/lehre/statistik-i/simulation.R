N <- 20
set.seed(1234)
X_1 <- rnorm(N)
X_2 <- rnorm(N)

mean(X_1)
mean(X_2)

ttestH0 <- t.test(X_1, X_2, var.equal = TRUE)
ttestH0
ttestH0$statistic # t-Wert
ttestH0$p.value   # zugehöriger p-Wert

replicate(n = 5, expr = rnorm(3))

## X_1 <- rnorm(N)
## X_2 <- rnorm(N)
## ttestH0 <- t.test(X_1, X_2, var.equal = TRUE)
## ttestH0$p.value

set.seed(1234)
replicate(n = 10, expr = {X_1 <- rnorm(N)
                          X_2 <- rnorm(N)
                          ttestH0 <- t.test(X_1, X_2, var.equal = TRUE)
                          ttestH0$p.value})

set.seed(1234)
pt_H0 <- replicate(n = 10000, expr = {X_1 <- rnorm(N)
                                      X_2 <- rnorm(N)
                                      ttestH0 <- t.test(X_1, X_2, var.equal = TRUE)
                                      ttestH0$p.value})

hist(pt_H0, breaks = 20) 

mean(pt_H0 < 0.05)

set.seed(1234)
tt_H0 <- replicate(n = 10000, expr = {X_1 <- rnorm(N)
                                      X_2 <- rnorm(N)
                                      ttestH0 <- t.test(X_1, X_2, var.equal = TRUE)
                                      ttestH0$statistic})


hist(tt_H0, breaks = 50, freq = FALSE) # freq = FALSE, damit relative Häufigkeiten eingetragen werden!
x <- seq(-4, 4, 0.01) # Sequenz von -4 bis 4 in 0.01 Schritten
lines(x = x, y = dt(x = x, df = 38), lwd = 2) # lwd = Liniendicke

t_krit <- qt(p = .975, df = 38)
mean(abs(tt_H0) > t_krit) # empirischer Alpha-Fehler

set.seed(1234)
Y <- rnorm(N)
Z <- rnorm(N)
cor(Y, Z) # empirische Korrelation
cortestH0 <- cor.test(Y, Z)
cortestH0$p.value # empirischer p-Wert

set.seed(1234)
pcor_H0 <- replicate(n = 10000, expr = {Y <- rnorm(N)
                                        Z <- rnorm(N)
                                        cortestH0 <- cor.test(Y, Z)
                                        cortestH0$p.value})

hist(pcor_H0, breaks = 20) 

mean(pcor_H0 < 0.05)

set.seed(12345)
X_1 <- rnorm(N)
X_2 <- rnorm(N) + 0.5 
ttestH1 <- t.test(X_1, X_2, var.equal = TRUE)
ttestH1$p.value

set.seed(12345)
pt_H1 <- replicate(n = 10000, expr = {X_1 <- rnorm(N)
                                      X_2 <- rnorm(N) + 0.5 
                                      ttestH1 <- t.test(X_1, X_2, var.equal = TRUE)
                                      ttestH1$p.value})
mean(pt_H1 < 0.05) # empirische Power
hist(pt_H1, breaks = 20)

set.seed(12345)
tt_H1 <- replicate(n = 10000, expr = {X_1 <- rnorm(N)
                                      X_2 <- rnorm(N) + 0.5 
                                      ttestH1 <- t.test(X_1, X_2, var.equal = TRUE)
                                      ttestH1$statistic})
hist(tt_H1, breaks = 50, freq = FALSE) # freq = FALSE, damit relative Häufigkeiten eingetragen werden!
x <- seq(-4, 4, 0.01) # Sequenz von -4 bis 4 in 0.01 Schritten
lines(x = x, y = dt(x = x, df = 38), lwd = 2) # lwd = Liniendicke

set.seed(12345)
pt_H1_20 <- pt_H1
pt_H1_40 <- replicate(n = 10000, expr = {X_1 <- rnorm(40)
                                         X_2 <- rnorm(40) + 0.5 
                                         ttestH1 <- t.test(X_1, X_2, var.equal = TRUE)
                                         ttestH1$p.value})
pt_H1_60 <- replicate(n = 10000, expr = {X_1 <- rnorm(60)
                                         X_2 <- rnorm(60) + 0.5 
                                         ttestH1 <- t.test(X_1, X_2, var.equal = TRUE)
                                         ttestH1$p.value})
pt_H1_80 <- replicate(n = 10000, expr = {X_1 <- rnorm(80)
                                         X_2 <- rnorm(80) + 0.5 
                                         ttestH1 <- t.test(X_1, X_2, var.equal = TRUE)
                                         ttestH1$p.value})
pt_H1_100 <- replicate(n = 10000, expr = {X_1 <- rnorm(100)
                                          X_2 <- rnorm(100) + 0.5 
                                          ttestH1 <- t.test(X_1, X_2, var.equal = TRUE)
                                          ttestH1$p.value})

t_power <- c(mean(pt_H1_20 < 0.05),
             mean(pt_H1_40 < 0.05),
             mean(pt_H1_60 < 0.05),
             mean(pt_H1_80 < 0.05),
             mean(pt_H1_100 < 0.05))
t_power

Ns <- seq(20, 100, 20)
plot(x = Ns, y = t_power, type = "b", main = "Power vs. N")

library(pwr)
Erg <- c()
for(n in c(2, seq(5, 500, 5)))
{
     d = seq(-1,1,0.02)   
     temp <- pwr.t.test(n = n, d = d)
     Erg <- rbind(Erg, cbind(temp$power, d, n))
     
}
Erg <- data.frame(Erg)
names(Erg) <- c("Power", "d", "n")

library(papaja)
library(ggplot2)
ggplot(data = Erg, aes(x = d, y = Power, col = n, group = n))+
     geom_line(lwd=1)+
     geom_abline(slope = 0,intercept = .05, lty = 3)+
     geom_abline(slope = 0,intercept = .8, lty = 2) + 
     scale_colour_gradientn(colours=rainbow(4))+
     ggtitle("Power vs. d and n", subtitle = " Using formulas instead of simulation")+ theme_apa(base_size = 20)

# falls noch nicht installiert: "install.packages("pwr")"
 library(pwr)
 pwr.t.test(n = 20, d = 0.5)
