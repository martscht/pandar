set.seed(1234) # Vergleichbarkeit
# (Pseudo-)Zufallsvariablen simulieren
X <- rnorm(n = 10, mean = 4, sd = 5)
X

set.seed(1234) # Vergleichbarkeit
# (Pseudo-)Zufallsvariablen simulieren
Y <- rnorm(n = 10, mean = 4, sd = 5)
Y

set.seed(4)

Z <- rnorm(n = 10, mean = 4, sd = 5)
Z

cbind(X, Y, Z) # Vergleiche alle erzeugten Variablen

cor(cbind(X, Y, Z)) # Korrelation der erstellten Zufallsvariablen

mean(X) # Mittelwert
sd(X)   # SD
n <- length(X) # Stichprobenumfang (Länge des Vektors = Anzahl an Ziehungen)
sd(X)/sqrt(n)  # SE

## for(Schleifen_internes_Argument in Schleifen_externes_Argument)
## {
##      # Schleifeninhalt, der auch auf Schleifen_internes_Argument zugreifen kann
## }

## N <- c(10, 50, 100)
## for(n in N)
## {
## 
## }

N <- c(10, 50, 100)
for(n in N)
{
     print(n)
}

Reps <- 10
for(i in 1:Reps)
{
     print(i)
}

i <- 1 # Initialisierung
while(i <= Reps)
{
     print(i)
     i <- i + 1 # Erhöhe i um 1
}

i <- 1 # Initialisierung
repeat
{
     if(i > Reps) # Prüfe, ob i nun größer Reps ist, falls ja, dann beende
     {
          break
     }
     
     print(i)
     i <- i + 1 # Erhöhe i um 1
}

Reps <- 10
M <- rep(NA, Reps)
M # M besteht nur aus Missings
for(i in 1:Reps)
{
     M[i] <- i^2
}
M # M besteht aus den Zahlen von 1 bis 10 zum Quadrat

Reps <- 10
M <- rep(NA, Reps)
set.seed(100) # Vergleichbarkeit
for(i in 1:Reps)
{
     X <- rnorm(n = 10, mean = 4, sd = 5)
     M[i] <- mean(X)
}
M # M besteht aus den Mittelwerten der 10 Trials

Reps <- 10
M <- rep(NA, Reps); SE <- rep(NA, Reps) # Zeilen lassen sich auch mit ";" hintereinander schreiben
set.seed(100) # Vergleichbarkeit
for(i in 1:Reps)
{
     X <- rnorm(n = 10, mean = 4, sd = 5)
     M[i] <- mean(X)
     SE[i] <- sd(X)/sqrt(length(X))
}
M # Mittelwerte der 10 Trials
SE # SEs der 10 Trials

Reps <- 10
set.seed(100) # Vergleichbarkeit
X_data <- replicate(n = Reps, expr = rnorm(n = 10, mean = 4, sd = 5), simplify = F)
X_data

X_data[[3]] # 3. Replikation

calculate_mean_SE <- function(X)
{
     M <- mean(X)
     SE <- sd(X)/sqrt(length(X))
     out <- list("Mean" = M, "StdError" = SE) # Output bestimmen
     return(out) # Funktionsoutput
}

calculate_mean_SE(X = X_data[[3]])

Erg3 <- calculate_mean_SE(X = X_data[[3]])
names(Erg3)
Erg3$Mean
Erg3$StdError

Results <- lapply(X = X_data, FUN = calculate_mean_SE)
Results[[3]] # 3. Listeneintrag

sResults <- sapply(X = X_data, FUN = calculate_mean_SE)
sResults

Mean_X <- mean(M) # äquivalent zu 
Mean_X2 <- mean(unlist(sResults[1, ])) #, denn die Mittelwerte stehen in der ersten Zeile 
# von sResults, die allerdings wieder als Liste ausgegeben wird und damit mit `unlist` erst
# in einen Vektor transformiert werden muss
Mean_X
Mean_X2

Bias <- Mean_X - 4
Bias

Rel_Bias <- (Mean_X - 4)/4   # oder <- Bias/4
Rel_Bias
Rel_Bias * 100 # in Prozent

MCSE <- mean(SE)
MCSE2 <- mean(unlist(sResults[2,]))

MCSD <- sd(M)
MCSD2 <- sd(unlist(sResults[1,]))

MCSE
MCSD

Bias_SE <- MCSE - MCSD
Bias_SE

Rel_Bias_SE <- (MCSE - MCSD)/MCSD
Rel_Bias_SE

MCSE - 5/sqrt(10)                   # Bias zum wahren SE
(MCSE - 5/sqrt(10))/(5/sqrt(10))    # rel. Bias zum wahren SE

M - 4 # die Abweichungen
(M-4)^2 # quadratischen Abweichungen
MSE <- mean((M-4)^2) # mittleren quadratischen Abweichungen
MSE
RMSE <- sqrt(MSE) # Wurzel aus den mittleren quadratischen Abweichungen
RMSE

Bias
MCSD^2

Bias^2 + MCSD^2 * 9/10 
MSE

RMSE

abs(M/SE)

M2 <- unlist(sResults[1,]) # andere Methode
SE2 <- unlist(sResults[2,]) # andere Methode
abs(M2/SE2) # identisch zu oben, also können wir uns auf eines der beiden konzentrieren

abs(M/SE) > 1.96

mean(abs(M/SE) > 1.96)



mean(M - 1.96 * SE <= 4 & M + 1.96 * SE >= 4)



mean(abs(M-4)/SE <= 1.96)

calculate_mean_SE_short <- function(X)
{
     return(list("Mean" = mean(X), "StdError" = sd(X)/sqrt(length(X))))
}
calculate_mean_SE_short(X = X_data[[3]])

my_coverage_function <- function(Ests, SEs, truth)
{
        absBias <- abs(Ests-truth)
        coverage <- mean(absBias/SEs <= 1.96)
        return(coverage)
}

# ausprobieren:
my_coverage_function(Est = M, SE = SE, truth = 4)

Trial <- 1:length(M) # Trial-Nr.
MSE <- data.frame(cbind(Trial, M, SE))

library(ggplot2)
ggplot(data = MSE,mapping = aes(x = Trial, y = M)) + geom_point(cex = 4)+geom_hline(yintercept = 4, lty = 3)+geom_errorbar(mapping = aes(ymin = M - 1.96*SE, ymax = M + 1.96*SE))+ggtitle("Konfidenzintervalle", subtitle = "Coverage ist die Wahrscheinlichkeit den wahren Wert einzuschließen")

Trial <- 1:length(M) # Trial-Nr.
M_transformed <- M - 4
MSE <- data.frame(cbind(Trial, M_transformed, SE))

library(ggplot2)
ggplot(data = MSE, mapping = aes(x = Trial, y = M_transformed)) + geom_point(cex = 4)+geom_hline(yintercept = 0, lty = 3)+geom_errorbar(mapping = aes(ymin = M_transformed - 1.96*SE, ymax = M_transformed + 1.96*SE))+ggtitle("Konfidenzintervalle um den wahren Wert verschoben", subtitle = "Coverage ist die Wahrscheinlichkeit den wahren Wert einzuschließen")

## library(progress) # Paket laden
## Reps <- 10^5 # entspricht 100000
## pb <- progress_bar$new(total = Reps,
##                        format = "  |:bar| :percent elapsed = :elapsed  ~ :eta",
##                        width = 80) # Progressbar vorbereiten und als "pb" abspeichern
## M <- rep(NA, Reps)
## set.seed(100) # Vergleichbarkeit
## for(i in 1:Reps)
## {
##      X <- rnorm(n = 10, mean = 4, sd = 5)
##      M[i] <- mean(X)
##      pb$tick() # Progress ausführen in der Schleife
## }



## Reps <- 10^6 # entspricht 1000000
## set.seed(100) # Vergleichbarkeit
## X_data <- pbreplicate(n = Reps, expr = rnorm(n = 10, mean = 4, sd = 5), simplify = F)



## sResults <- pbsapply(X = X_data, FUN = calculate_mean_SE)



plot(x = c(1,1,-1,-1,1), y = c(1,-1,-1,1,1), type = "l", 
     ylim = c(-1.2, 1.2), xlim = c(-1.2, 1.2), ylab = "Y", 
     xlab = "X", col = "red", lwd = 2, main = expression("Finding"~pi~"by MC-methods"))
x <- seq(-1,1,0.01)
lines(x = x, y = sqrt(1-x^2), lwd = 2, col = "blue") # Formel eines Kreises,
lines(x = x, y = -sqrt(1-x^2), lwd = 2, col = "blue") # umgestellt nach x

plot(x = c(1,1,-1,-1,1), y = c(1,-1,-1,1,1), type = "l", 
     ylim = c(-1.2, 1.2), xlim = c(-1.2, 1.2), ylab = "Y", 
     xlab = "X", col = "red", lwd = 2, main = expression("Finding"~pi~"by MC-methods"))
x <- seq(-1,1,0.01)
lines(x = x, y = sqrt(1-x^2), lwd = 2, col = "blue") # Formel eines Kreises,
lines(x = x, y = -sqrt(1-x^2), lwd = 2, col = "blue") # umgestellt nach x
data <- matrix(runif(n = 2*10^2, min = -1, max = 1), nrow = 10^2)
x <- data[,1]; y <- data[,2]
in_circle <- x^2+y^2<=1 # ! verneint eine boolsche (TRUE oder FALSE)-Variable:
points(x[in_circle], y[in_circle], col = "blue", pch = 16) # Punkte innerhalb des Kreises
points(x[!in_circle], y[!in_circle], col = "red", pch = 16) # Punkte außerhalb des Kreises

## data <- matrix(runif(n = 2*10^6, min = -1, max = 1), nrow = 10^6)
## inner_circle <- function(r, dat)
## {
##      x <- dat[1]; y <- dat[2]
##      return(x^2 + y^2 <= r)
## }
## in_circle <- pbapply(X = data, MARGIN = 1, FUN = inner_circle, r = 1)



mean(in_circle)*4 # pi
pi # aus R

# in short
x <- data[,1]; y <- data[,2]
in_circle <- x^2+y^2<=1
mean(in_circle)*4 # pi
pi # aus R

# in short
data <- matrix(runif(n = 2*10^8, min = -1, max = 1), nrow = 10^8)
x <- data[,1]; y <- data[,2]
in_circle <- x^2+y^2<=1
mean(in_circle)*4 # pi
pi # aus R
