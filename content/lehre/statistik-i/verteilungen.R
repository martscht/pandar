#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb22.rda'))  

# Nominalskalierte Variablen in Faktoren verwandeln
fb22$geschl_faktor <- factor(fb22$geschl,
                             levels = 1:3,
                             labels = c("weiblich", "männlich", "anderes"))
fb22$fach <- factor(fb22$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb22$ziel <- factor(fb22$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb22$wohnen <- factor(fb22$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

# Skalenbildung

fb22$prok2_r <- -1 * (fb22$prok2 - 5)
fb22$prok3_r <- -1 * (fb22$prok3 - 5)
fb22$prok5_r <- -1 * (fb22$prok5 - 5)
fb22$prok7_r <- -1 * (fb22$prok7 - 5)
fb22$prok8_r <- -1 * (fb22$prok8 - 5)

#Prokrastination
fb22$prok_ges <- fb22[, c('prok1', 'prok2_r', 'prok3_r',
                          'prok4', 'prok5_r', 'prok6',
                          'prok7_r', 'prok8_r', 'prok9', 
                          'prok10')] |> rowMeans()
#Naturverbundenheit
fb22$nr_ges <-  fb22[, c('nr1', 'nr2', 'nr3', 'nr4', 'nr5',  'nr6')] |> rowMeans()
fb22$nr_ges_z <- scale(fb22$nr_ges) # Standardisiert


library("RXKCD")
invisible(getXKCD(483))

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

choose(n = 100, k = 20) * 0.2^20 * 0.8^80

dbinom(x = 20, size = 100, prob = 0.2) 

x <- c(0:100)   # alle möglichen Werte für x in unserem Beispiel
probs <- dbinom(x, size = 100, prob = 0.2) #Wahrscheinlichkeiten für alle möglichen Werte
plot(x = x, y = probs, type = "h", xlab = "Häufigkeiten des Ereignis Grün", ylab = "Wahrscheinlichkeit bei 100 Drehungen")

plot(x = x, y = probs, type = "h", xlab = "Häufigkeiten des Ereignis Grün", ylab = "Wahrscheinlichkeit bei 100 Drehungen", col = c(rep("black",20),"red", rep("black",79)))

plot(x = x, y = probs, type = "h", xlab = "Häufigkeiten des Ereignis Grün", ylab = "Wahrscheinlichkeit bei 100 Drehungen", col = c(rep("red",21), rep("black",79)))

pbinom(q = 20, size = 100, prob = 0.2, lower.tail = TRUE)

pbinom(q = 20, size = 100, prob = 0.2, lower.tail = TRUE) - pbinom(q = 14, size = 100, prob = 0.2, lower.tail = TRUE)

x <- c(0:100)   # alle möglichen Werte für x in unserem Beispiel
probs <- pbinom(x, size = 100, prob = 0.2, lower.tail = TRUE) #Wahrscheinlichkeiten für alle möglichen Werte
plot(x = x, y = probs, type = "h", 
     xlab = "Häufigkeiten für Ereignis Grün", 
     ylab = "kumulierte Wahrscheinlichkeit")

plot(x = x, y = probs, type = "h", xlab = "Häufigkeiten für Ereignis Grün", ylab = "kumulierte Wahrscheinlichkeit", col = c(rep("black",20),"red", rep("black",79)))

plot(x = x, y = probs, type = "h", xlab = "Häufigkeiten des Ereignis Grün", ylab = "Wahrscheinlichkeit bei 100 Drehungen")
abline(h= 0.1, col = "red")

qbinom(p = 0.1, size = 100, prob = 0.2, lower.tail = TRUE)

rbinom(n = 1, size = 100, prob = 0.2)

curve(expr = dnorm(x, mean = 100, sd = 15), 
      from = 70, 
      to = 130, 
      main = "Normalverteilung", 
      xlab = "IQ-Werte",
      ylab = "Dichte f(x)")

dnorm(x = 114.3, mean = 100, sd = 15) 

curve(expr = dnorm(x, mean = 100, sd = 15), 
      from = 70, 
      to = 130, 
      main = "Normalverteilung", 
      xlab = "IQ-Werte",
      ylab = "Dichte f(x)")

curve(expr = dnorm(x, mean = 100, sd = 15), 
      from = 70, 
      to = 130, 
      main = "Normalverteilung", 
      xlab = "IQ-Werte",
      ylab = "Dichte f(x)")
abline(v = 114.3, col = "red")

x <- seq(70, 130, 0.5) 
y <- dnorm(x,100,15)
plot(x, y, type="l", 
      main = "Normalverteilung", 
      xlab = "IQ-Werte",
      ylab = "Dichte f(x)")
polygon(c(min(x), x[x<=114.3],  114.3), c(0, y[x<=114.3],  0), col="red")

pnorm(114.3, mean = 100, sd = 15, lower.tail = TRUE)

curve(expr = pnorm(x, mean = 100, sd = 15, lower.tail = TRUE),
     from = 70,
     to = 130,
     main = "Verteilungsfunktion", 
     xlab = "IQ-Werte",
     ylab = "F(x)")

curve(expr = pnorm(x, mean = 100, sd = 15, lower.tail = TRUE),
     from = 70,
     to = 130,
     main = "Verteilungsfunktion", 
     xlab = "IQ-Werte",
     ylab = "F(x)")
abline(v = 114.3,col=  "red")

qnorm(p = 0.5, mean = 100, sd = 15, lower.tail = TRUE)

curve(expr = pnorm(x, mean = 100, sd = 15, lower.tail = TRUE),
     from = 70,
     to = 130,
     main = "Verteilungsfunktion", 
     xlab = "IQ-Werte",
     ylab = "F(x)")
abline(h = 0.5,col=  "red")

set.seed(500)                   #zur Konstanthaltung der zufälligen Ergebnisse
rnorm(10,mean = 100,sd = 15)

hist(fb22$nerd, xlim=c(0,6), main="Score", xlab="", ylab="", probability=T)

## curve(dnorm(x, mean=mean(fb22$nerd), sd=sd(fb22$nerd)), add=T)

hist(fb22$nerd, xlim=c(0,6), main="Score", xlab="", ylab="", probability=T)
curve(dnorm(x, mean=mean(fb22$nerd), sd=sd(fb22$nerd)), add=T)

fb22$nerd_std <- scale(fb22$nerd, center = T, scale = T)
qqnorm(fb22$nerd_std)
qqline(fb22$nerd_std)
