knitr::opts_chunk$set(echo = TRUE, fig.align = "center")
load("../../daten/mdbf.rda")

a <- 3 #Zunächst definieren wir eine Variable
# mehrere Zeilen
if (a == 3) {
  print("Ja, die Variable a enthält den Wert 3")
}
# eine Zeile 
if (a == 3) print("Ja, die Variable a enthält den Wert 3")

(a == 3)

a <- 5
if (a == 3) {
  print("Ja, die Variable a enthält den Wert 3")
}

person = "Monica"
if (person %in%  c("Monica", "Rachel", "Chandler",  "Phoebe", "Ross", "Joey")) {
  print("Yes, this is a character from Friends.")
}

person = c("Marcus")
if (person %in%  c("Monica", "Rachel", "Chandler",  "Phoebe", "Ross", "Joey")) {
  print("Yes, this is a character from Friends.")
}

persons = c("Monica", "Marcus")
if (any(persons %in%  c("Monica", "Rachel", "Chandler",  "Phoebe", "Ross", "Joey"))) {
  print("Yes, at least one of them is a character from Friends.")
}

if (all(persons %in%  c("Monica", "Rachel", "Chandler",  "Phoebe", "Ross", "Joey"))) {
  print("Yes, at all of them are a character from Friends.")
}

# mindestens 1 ist TRUE
any(persons %in%  c("Monica", "Rachel", "Chandler",  "Phoebe", "Ross", "Joey")) 
# alle 1 sind TRUE
all(persons %in%  c("Monica", "Rachel", "Chandler",  "Phoebe", "Ross", "Joey"))

if (weekdays(Sys.Date()) == "Friday") {
  print("Fast Wochenende!")
}

if (weekdays(Sys.Date()) == "Saturday" | weekdays(Sys.Date()) == "Sunday") {
  print("Hoch die Hände, Wochenende!")
}

# mehrere Zeilen
if (weekdays(Sys.Date()) == "Saturday" | weekdays(Sys.Date()) == "Sunday") {
  print("Hoch die Hände, Wochenende!")
}else{
  print("Nur noch wenige Tage bis zum ersehnten Wochenende!")
}

# eine enorm lange Zeile
if (weekdays(Sys.Date()) == "Saturday" | weekdays(Sys.Date()) == "Sunday") print("Hoch die Hände, Wochenende!") else print("Nur noch wenige Tage bis zum ersehnten Wochenende!")

if (weekdays(Sys.Date()) == "Saturday" | weekdays(Sys.Date()) == "Sunday") 
{
  print("Hoch die Hände, Wochenende!")
}else
{
  print("Nur noch wenige Tage bis zum ersehnten Wochenende!")
}

if (weekdays(Sys.Date()) %in% c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')) {
  if (weekdays(Sys.time()) == 'Monday') {
    print('Zurück ins Bett...')
    } else if (weekdays(Sys.time()) == 'Wednesday') { 
    print('Wuhu, es ist Mitte der Woche!')
      } else if (weekdays(Sys.time()) == 'Friday') { 
    print('Yeah, das Wochenende steht bevor!')
        } else {
    print('Es ist irgendein anderer Tag.')
        }
  } else {
  print("Hoch die Hände, Wochenende!")
}

## if (weekdays(Sys.Date()) %in% c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')) {

## if (weekdays(Sys.time()) == 'Monday') {
##     print('Zurück ins Bett...')
##     } else if (weekdays(Sys.time()) == 'Wednesday') {
##     print('Wuhu, es ist Mitte der Woche!')
##       } else if (weekdays(Sys.time()) == 'Friday') {
##     print('Yeah, das Wochenende steht bevor!')
##         } else {
##     print('Es ist irgendein anderer Tag.')
##         }

##   } else {
##   print("Hoch die Hände, Wochenende!")
## }

x <- sample(1:10, 1)
if (x > 5) {
  y <- 1
} else {
  y <- 0
}
x
y

ifelse(test = weekdays(Sys.Date()) == 'Friday', yes = 'Yeah, das Wochenende steht bevor!', no = 'Es ist irgendein anderer Tag...')

vekt <- c("Hallo!", "Viel Spaß im R Praktikum.", "Viel Erfolg für das weitere Semester.")
for (i in vekt) {
  print(i)
}

## load(url("https://pandar.netlify.app/post/mdbf.rda"))
## head(mdbf)

mdbf$stim4_r[mdbf$stim4 == 1] <- 4
mdbf$stim4_r[mdbf$stim4 == 2] <- 3
mdbf$stim4_r[mdbf$stim4 == 3] <- 2
mdbf$stim4_r[mdbf$stim4 == 4] <- 1

mdbf$stim4_r <- -1 * (mdbf$stim4 - 5)

# Kopie des Datensatzes erstellen, um Datenverlust vorzubeugen
mdbf_r <- mdbf

# Vektor der negativen Items
neg <- c("stim3", "stim4", "stim5", "stim7", "stim9", "stim11")

for (i in neg) {
  mdbf_r[, i] <- -1 * (mdbf[, i] - 5)
}

cor(mdbf[, "stim3"], mdbf_r[, "stim3"])

Buchstaben <- c("A", "B", "C")
Zahlen <- c(1,2)
for (i in Buchstaben) {
  for (ii in Zahlen) {
    print(i)
    print(ii) 
  }
}

## eigene_funktion <- function(argument1, argument2, ...) {
##   # Durchgeführte Operationen
## }

x <- mdbf[, 1]
n <- length(x)
s2 <- sum((x - mean(x))^2) / n
s2

empVar <- function(x) {
  n <- length(x)
  s2 <- sum((x - mean(x))^2)/n
}

empVar(mdbf[, 1])

empVar <- function(x) {
  n <- length(x)
  s2 <- sum((x - mean(x))^2)/n
  return(s2)
}

empVar(mdbf[, 1])
empVar(mdbf[, 2])

empVar <- function(x) {
  n <- length(x)
  s2 <- sum((x - mean(x))^2)/n
  out <- list("s2" = s2, "n" = n)
  return(out)
}
empVar(mdbf[, 2])

Vari <- function(x, empirical) {
  n <- length(x)
  if (empirical) {
    s2 <- sum((x - mean(x))^2)/n
  } else {
    s2 <- sum((x - mean(x))^2)/(n-1)
  }
  return(s2)
}

Vari(mdbf[, 2], TRUE)
Vari(mdbf[, 2], FALSE)

## Vari(mdbf[, 2])

cat('Error in Vari(mdbf[, 2]) : 
  argument "empirical" is missing, with no default')

Vari <- function(x, empirical = TRUE) {
  n <- length(x)
  if (empirical) {
    s2 <- sum((x - mean(x))^2)/n
  } else {
    s2 <- sum((x - mean(x))^2)/(n-1)
  }
  return(s2)
}

Vari(mdbf[, 2])

N <- 20
set.seed(1234)
replicate(n = 10, expr = {X <- rnorm(N)
                          Y <- rnorm(N)
                          ttestH0 <- t.test(X, Y, var.equal = TRUE)
                          ttestH0$p.value})

## {X <- rnorm(N)
##  Y <- rnorm(N)
##  ttestH0 <- t.test(X, Y, var.equal = TRUE)
##  ttestH0$p.value}

mySim <- function(N)
{
  X <- rnorm(N)
  Y <- rnorm(N)
  ttestH0 <- t.test(X, Y, var.equal = TRUE)
  return(ttestH0$p.value)
}
set.seed(1234)
replicate(n = 10, expr = mySim(N = 20))

mySim2 <- function(N)
{
  X <- rnorm(N)
  Y <- rnorm(N)
  ttestH0 <- t.test(X, Y, var.equal = TRUE)
  return(c("p" = ttestH0$p.value, "t" = ttestH0$statistic))
}
set.seed(1234)
replicate(n = 10, expr = mySim2(N = 20))

S <- matrix(c(1, .7, .7, 2), 2, 2) # Populationskovarianzmatrix
S
# install.packages("mvtnorm")
library(mvtnorm)
set.seed(1234)
X <- rmvnorm(n = 10^3, mean = c(2, 3), sigma = S)
colMeans(X)
cov(X)

eps <- rnorm(10^3, sd = 1.3)
X1 <- X[,1]
X2 <- X[,2]
Y <- 0.3 + 0.5*X1 + 0.3*X2 + eps
df <- data.frame("X1" = X1, "X2" = X2, "Y" = Y)

reg <- lm(Y ~ 1 + X1 + X2, data = df)
coef(reg) # Koeffizienten abgreifen

myRegSim <- function(N)
{
  S <- matrix(c(1, .7, .7, 2), 2, 2) # Populationskovarianzmatrix
  X <- rmvnorm(n = N, mean = c(2, 3), sigma = S)
  eps <- rnorm(N, sd = 1.3)
  X1 <- X[,1]
  X2 <- X[,2]
  Y <- 0.3 + 0.5*X1 + 0.3*X2 + eps
  df <- data.frame("X1" = X1, "X2" = X2, "Y" = Y)
  reg <- lm(Y ~ 1 + X1 + X2, data = df)
  coef(reg) # Koeffizienten abgreifen
  return(coef(reg))
}
set.seed(1234)
replicate(n = 10, expr = myRegSim(N = 10^3))

set.seed(1234)
mySimErg <- t(replicate(n = 10, expr = myRegSim(N = 10^3)))
colMeans(mySimErg)

# Münze erstellen
coin <- c('Kopf', 'Zahl')

# Leeres Objekt für die Aufzeichnung erstellen
toss <- NULL

# Loop
while (sum(toss == 'Kopf')<10) {
  toss <- c(toss, sample(coin, 1))
}

# Würfe ansehen
toss

fibo <- c(1, 1)

repeat {
  n <- length(fibo)
  fibo[n+1] <- fibo[n] + fibo[n - 1]
  if (fibo[n+1] > 1000) break
}

fibo

A <- data.frame("a" = c(2,3,4), "b" = c(1,1,1))
apply(A, 2, mean) # Mittelwert über Spalten/Variablen
colMeans(A)

apply(A, 1, mean) # Mittelwert über Zeilen/Personen/Beobachtungen
rowMeans(A)

apply(A, 2, sd) # Standardabweichung über Spalten/Variable

# simuliere 1000 Beobachtungen und bestimme den Mittelwert 
X <- rnorm(10^3, mean = 1, sd = 2)
m <- mean(X)

t1 <- Sys.time() # speichere die Startzeit
X_c <- X
for(x in X)
{
  X_c[i] <- x - m
}
Sys.time() - t1 # bestimmte die Laufzeit durch aktuelle Zeit minus Startzeit

t2 <- Sys.time() # speichere die Startzeit
X_c <- X - m
Sys.time() - t2 # bestimmte die Laufzeit durch aktuelle Zeit minus Startzeit
