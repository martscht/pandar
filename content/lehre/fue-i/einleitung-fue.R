## load("C:/Users/Musterfrau/Desktop/Schulleistungen.rda")

## Daten laden
load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))

#### Datenüberblick ----

head(Schulleistungen)

# Namen der Variablen abfragen
names(Schulleistungen)

# Anzahl der Zeilen
nrow(Schulleistungen)
# Anzahl der Spalten
ncol(Schulleistungen)

# Anzahl der Zeilen und Spalten kombiniert
dim(Schulleistungen)

# Struktur des Datensatzes - Informationen zu Variablentypen
str(Schulleistungen)

Schulleistungen$IQ

#### Deskriptivstatistik ----

# Summe
sum(Schulleistungen$IQ)

# Mittelwert
mean(Schulleistungen$IQ)
1/100*sum(Schulleistungen$IQ) # auch der Mittelwert

# Varianz
var(Schulleistungen$IQ)

# SD
sd(Schulleistungen$IQ)
sqrt(var(Schulleistungen$IQ)) # die Wurzel aus der Varianz ist die SD, hier: sqrt() ist die Wurzel Funktion

summary(Schulleistungen$IQ)

colMeans(Schulleistungen)

#### t-Test ----
## Datensimulation
set.seed(1234567) # für Replizierbarkeit (bei gleicher R Version, kommen Sie mit diesem Seed zum selben Ergebnis!)
X <- rnorm(n = 1000, mean = 0, sd = 1) # Standardnormalverteilung mit n = 1000
hist(X, breaks = 50) # breaks gibt die Anzahl der Balken vor
mean(X)
sd(X)

set.seed(2)
Y <- rnorm(n = 1000, mean = 0, sd = 1)
t.test(X, Y, var.equal = T)

set.seed(2)
Y <- rnorm(n = 1000, mean = 0, sd = 1)
ttest <- t.test(X, Y, var.equal = T)
ttest

# Output
cat('
Two Sample t-test
')

cat(' data:  X and Y
 t = -1.4456, df = 1998, p-value = 0.1484')

cat(' alternative hypothesis: true difference in means is not equal to 0
 95 percent confidence interval:
  -0.15317201  0.02317988
 sample estimates:
    mean of x    mean of y 
 -0.002997332  0.061998736')

# Abspeichern des Tests als R-Objekt
ttest <- t.test(X, Y, var.equal = T)
names(ttest)    # alle möglichen Argumente, die wir diesem Objekt entlocken können
ttest$statistic # (empirischer) t-Wert
ttest$p.value   # zugehöriger p-Wert

# Code der Histogramme der Verteilungen unter H0
ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
    X <- rnorm(n = 1000, mean = 0, sd = 1)
    Y <- rnorm(n = 1000, mean = 0, sd = 1)
    ttest <- t.test(X, Y, var.equal = T)
    ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
    ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "(empirische) t-Werte nach 10000 Replikationen unter H0", 
     xlab = "T", freq = F, breaks = 50)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter), 
      lwd = 3)
hist(ps, main = "p-Werte nach 10000 Replikationen unter H0", 
     xlab = "p", freq = F, breaks = 50)
abline(a = 1, b = 0, lwd = 3)

# Code der Histogramme der Verteilungen unter H1
ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
    X <- rnorm(n = 1000, mean = 0, sd = 1)
    Y <- -0.1 + rnorm(n = 1000, mean = 0, sd = 1) # Mittelwertsdifferenz ist 0.1
    ttest <- t.test(X, Y, var.equal = T)
    ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
    ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "(empirische) t-Werte nach 10000 Replikationen unter H1", 
     xlab = "T", freq = F, breaks = 50)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter), lwd = 3)
hist(ps, main = "p-Werte nach 10000 Replikationen unter H1", 
     xlab = "p", freq = F, breaks = 50)
abline(a = 1, b = 0, lwd = 3)

# Code der Power-Darstellung
ps_null <- ps
load(url("https://github.com/jpirmer/MSc1_FEI/blob/master/data/Erg.RData?raw=true"))
library(papaja)
library(ggplot2)
ggplot(data = Erg, aes(x = d, y = Power, col = n, group = n))+
  geom_line(lwd=1)+
  geom_abline(slope = 0,intercept = .05, lty = 3)+
  geom_abline(slope = 0,intercept = .8, lty = 2) + 
  scale_colour_gradientn(colours=rainbow(4))+
  ggtitle("Power vs. d and n")+ theme_apa(base_size = 20)

# Darstellung rein durch die Formel
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

#### Verstöße gegen die Modellannahmen ----

set.seed(1)
par(mfrow = c(1,2))

X <- -rexp(1000, 1)
X <- X + 1
Y <- rexp(1000, 2)
Y <- Y - 1/2
hist(X, breaks = 50); hist(Y, breaks = 50)

set.seed(1)
ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
        X <- -rexp(5, 1)
        X <- X + 1
        Y <- rexp(5, 2)#rnorm(n = 1000, mean = 0, sd = 1000)
        Y <- Y - 1/2
        ttest <- t.test(X, Y, var.equal = T)
        ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
        ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "t-Werte nach 10000 Replikationen unter Modellverstöße\n für kleine Stichproben", 
     xlab = "t", freq = F, breaks = 50)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter),
      lwd = 3)
hist(ps, main = "p-Werte nach 10000 Replikationen unter Modellverstößen\n für kleine Stichproben", 
     xlab = "p", freq = F, breaks = 50)
abline(a = 1, b = 0, lwd = 3)

#### Appendix A

ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
    X <- rnorm(n = 1000, mean = 0, sd = 1)
    Y <- rnorm(n = 1000, mean = 0, sd = 1)
    ttest <- t.test(X, Y, var.equal = T)
    ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
    ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "(empirische) t-Werte nach 10000 Replikationen unter H0", 
     xlab = "T", freq = F, breaks = 50)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter), 
      lwd = 3)
hist(ps, main = "p-Werte nach 10000 Replikationen unter H0", 
     xlab = "p", freq = F, breaks = 50)
abline(a = 1, b = 0, lwd = 3)

ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
    X <- rnorm(n = 1000, mean = 0, sd = 1)
    Y <- -0.1 + rnorm(n = 1000, mean = 0, sd = 1) # Mittelwertsdifferenz ist 0.1
    ttest <- t.test(X, Y, var.equal = T)
    ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
    ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "(empirische) t-Werte nach 10000 Replikationen unter H1", 
     xlab = "T", freq = F, breaks = 50)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter), 
      lwd = 3)
hist(ps, main = "p-Werte nach 10000 Replikationen unter H1", 
     xlab = "p", freq = F, breaks = 50)
abline(a = 1, b = 0, lwd = 3)

set.seed(1)
ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
       X <- -rexp(n = 5, rate = 1) # simuliere Exponentialverteilung zur Rate 1 mit n = 5
        X <- X + 1 # zentriere, sodass der Populationsmittelwert wieder 0 ist
        Y <- rexp(n = 5, rate = 2) # simuliere Exponentialverteilung zur Rate 2 mit n = 5
        Y <- Y - 1/2 # zentriere, sodass der Populationsmittelwert wieder 0 ist
        ttest <- t.test(X, Y, var.equal = T)
        ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
        ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "t-Werte nach 10000 Replikationen unter Modellverstöße\n für kleine Stichproben", 
     xlab = "t", freq = F, breaks = 50)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter), 
      lwd = 3)
hist(ps, main = "p-Werte nach 10000 Replikationen unter Modellverstößen\n für kleine Stichproben", 
     xlab = "p", freq = F, breaks = 50)
abline(a = 1, b = 0, lwd = 3)

set.seed(1)
ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
        X <- -rexp(n = 5, rate = 1) # simuliere Exponentialverteilung zur Rate 1 mit n = 5
        X <- X + 1 # zentriere, sodass der Populationsmittelwert wieder 0 ist
        Y <- rexp(n = 5, rate = 2) # simuliere Exponentialverteilung zur Rate 2 mit n = 5
        Y <- Y - 1/2 # zentriere, sodass der Populationsmittelwert wieder 0 ist
        ttest <- t.test(X, Y) # Welch Test
        ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
        ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "t-Werte (des Welch t-Tests) nach 10000 Replikationen\n unter Modellverstöße für kleine Stichproben", 
     xlab = "t", freq = F, breaks = 50)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter), 
      lwd = 3)
hist(ps, main = "p-Werte (des Welch t-Tests) nach 10000 Replikationen\n unter Modellverstößen für kleine Stichproben", 
     xlab = "p", freq = F, breaks = 50)
abline(a = 1, b = 0, lwd = 3)

set.seed(1234)
ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
        X <- -rexp(n = 100, rate = 1) # simuliere Exponentialverteilung zur Rate 1 mit n = 100
        X <- X + 1 # zentriere, sodass der Populationsmittelwert wieder 0 ist
        Y <- rexp(n = 100, rate = 2) # simuliere Exponentialverteilung zur Rate 2 mit n = 100
        Y <- Y - 1/2 # zentriere, sodass der Populationsmittelwert wieder 0 ist
        ttest <- t.test(X, Y) # Welch Test
        ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
        ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "t-Werte (des Welch t-Tests) nach 10000 Replikationen\n unter Modellverstöße für größere Stichproben", 
     xlab = "t", freq = F, breaks = 50)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter), 
      lwd = 3)
hist(ps, main = "p-Werte (des Welch t-Tests) nach 10000 Replikationen\n unter Modellverstößen für größere Stichproben", 
     xlab = "p", freq = F, breaks = 50)
abline(a = 1, b = 0, lwd = 3)

#### Appendix B ----

 library(pwr)
 pwr.t.test(n = 1000, d = 0.1)

#### Appendix C ----

X <- c(1, 2, 3)
Y <- c(10, 8, 6)

Y[2]

X + Y  # Addition
X - Y  # Subtraktion
3*X    # Skalare Multiplikation
1/2*X

Z <- c(1:6) # Zahlen 1 bis 6
Z + Y

X*Y # elementeweise Multiplikation

as.matrix(X)

A <- cbind(X, Y)
A
B <- rbind(X, Y)
B

A[1, 2] # Eintrag 1. Zeile 2. Spalte in A

A[1, ] # 1. Zeile
A[, 2] # 2. Spalte

A
t(A)
B

## A + B

cat("Error in A + B : non-conformable arrays")

A * 2

A %*% B # Matrixprodukt A*B
B %*% A # Matrixprodukt B*A

diag(3) # Einheitsmatrix 3x3
diag(1:3) # Diagonalmatrix mit Elementen 1,2,3 auf der Diagonalen

C <- matrix(data = c(1:9), nrow = 3, ncol = 3, byrow = T)
C

diag(C)

## solve(C)

cat("Error in solve.default(C) : 
  system is computationally singular: reciprocal condition number = 2.59052e-18")

det(C)
round(det(C), 14)

2*C[, 2] - C[, 1]     # 2*2.Spalte - 1. Spalte rechnen ist gleich
C[, 3]               # 3. Spalte

C^-1
C^-1 %*% C # ist nicht die Einheitsmatrix
C^-1 * C   # elementeweise ergibt überall 1 - ist immer noch nicht die Einheitsmatrix!

D <- matrix(c(1, 0, 0,
              1, 1, 1,
              2, 4, 5), 3, 3, byrow = T)
det(D)

solve(D)
D %*% solve(D)
solve(D) %*% D
