wuerfel <- c(1:6)
expand.grid(wuerfel,wuerfel)

pos <- expand.grid(wuerfel,wuerfel)
pos$sum <- pos$Var1+pos$Var2
sum(pos$sum) / nrow(pos)

sample(x = wuerfel, size = 1)

sample(x = wuerfel, size = 2, replace = TRUE)

sample(x = wuerfel, size = 2, replace = TRUE) |> sum()

replicate(n = 10, expr = sum(sample(x = wuerfel, size = 2, replace = TRUE)))

replicate(n = 10, expr = sum(sample(x = wuerfel, size = 2, replace = TRUE)))

set.seed(500)
replicate(n = 10, expr = sum(sample(x = wuerfel, size = 2, replace = TRUE)))

set.seed(500)
results_10 <- sample(x = wuerfel, size = 2, replace = TRUE) |> sum() |> replicate(n = 10)
results_10

## Häufigkeitsverteilung

hist(results_10,xlim = c(1.5,12.5), breaks = c(1.5:12.5))

set.seed(500)
results_50 <- sample(x = wuerfel, size = 2, replace = TRUE) |> sum() |> replicate(n = 50)
hist(results_50, xlim = c(1.5,12.5), breaks = c(1.5:12.5))
results_250 <- sample(x = wuerfel, size = 2, replace = TRUE) |> sum() |> replicate(n = 250)
hist(results_250, xlim = c(1.5,12.5), breaks = c(1.5:12.5))
results_10000 <- sample(x = wuerfel, size = 2, replace = TRUE) |> sum() |> replicate(n = 10000)
hist(results_10000, xlim = c(1.5,12.5), breaks = c(1.5:12.5))

mean(results_10)
mean(results_50)
mean(results_250)
mean(results_10000)

## Binomialverteilung

choose(n = 100, k = 20) * 0.2^20 * 0.8^80

dbinom(x = 20, size = 100, prob = 0.2) 

x <- c(0:100)   # alle möglichen Werte für x in unserem Beispiel
probs <- dbinom(x, size = 100, prob = 0.2) #Wahrscheinlichkeiten für alle möglichen Werte
plot(x = x, y = probs, type = "h", xlab = "Häufigkeiten des Ereignis Grün", ylab = "Wahrscheinlichkeit bei 100 Drehungen")





pbinom(q = 20, size = 100, prob = 0.2, lower.tail = TRUE)

pbinom(q = 20, size = 100, prob = 0.2, lower.tail = TRUE) - pbinom(q = 14, size = 100, prob = 0.2, lower.tail = TRUE)

x <- c(0:100)   # alle möglichen Werte für x in unserem Beispiel
probs <- pbinom(x, size = 100, prob = 0.2, lower.tail = TRUE) #Wahrscheinlichkeiten für alle möglichen Werte
plot(x = x, y = probs, type = "h", 
     xlab = "Häufigkeiten für Ereignis Grün", 
     ylab = "kumulierte Wahrscheinlichkeit")





qbinom(p = 0.1, size = 100, prob = 0.2, lower.tail = TRUE)

rbinom(n = 1, size = 100, prob = 0.2)



## Stetige Zufallsvariablen

dnorm(x = 114.3, mean = 100, sd = 15) 

1 / (15 * sqrt(2 * pi)) * exp(-0.5 * ((114.3 - 100) / 15)^2)

curve(expr = dnorm(x, mean = 100, sd = 15), 
      from = 70, 
      to = 130, 
      main = "Normalverteilung", 
      xlab = "IQ-Werte",
      ylab = "Dichte f(x)")





pnorm(114.3, mean = 100, sd = 15, lower.tail = TRUE)

integrate(f = dnorm, lower = -Inf, upper = 114.3, mean = 100, sd = 15)

curve(expr = pnorm(x, mean = 100, sd = 15, lower.tail = TRUE),
     from = 70,
     to = 130,
     main = "Verteilungsfunktion", 
     xlab = "IQ-Werte",
     ylab = "F(x)")



qnorm(p = 0.5, mean = 100, sd = 15, lower.tail = TRUE)



set.seed(500)                   #zur Konstanthaltung der zufälligen Ergebnisse
rnorm(10,mean = 100,sd = 15)
