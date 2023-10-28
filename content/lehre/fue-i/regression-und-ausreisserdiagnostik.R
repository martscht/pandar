knitr::opts_chunk$set(echo = TRUE, fig.align = "center")

## install.packages("car")            # Die Installation ist nur einmalig von Nöten!
## install.packages("lm.beta")        # Sie müssen nur zu Update-Zwecken erneut installiert werden.
## install.packages("MASS")

library(lm.beta)  # Standardisierte beta-Koeffizienten für die Regression
library(car)      # Zusätzliche Funktion für Diagnostik von Datensätzen
library(MASS)     # Zusätzliche Funktion für Diagnostik von Datensätzen 

## load("C:/Users/Musterfrau/Desktop/Schulleistungen.rda")

load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))

head(Schulleistungen)

lm(reading ~ 1 + female + IQ, data = Schulleistungen)

our_model <- lm(reading ~ 1 + female + IQ, data = Schulleistungen)
summary(our_model)

summary(lm.beta(our_model))

our_model |> lm.beta() |> summary()

cat('
 Call:
 lm(formula = reading ~ 1 + female + IQ, data = Schulleistungen)')

cat('
Residuals:
    Min       1Q   Median       3Q      Max 
-208.779  -64.215   -0.211   58.652  174.254 
')

quantile(x = resid(our_model), probs = .25) # .25 = 25% = 25. PR mit der Funktion resid()
mean(x = our_model$residuals) # Mittelwert mit Referenzierung aus dem lm Objekt "our_model"

cat('
Coefficients:
           Estimate Standardized Std. Error t value Pr(>|t|)    
(Intercept)  88.2093       0.0000    56.5061   1.561   0.1218    
female       38.4705       0.1810    17.3863   2.213   0.0293 *  
IQ            3.9444       0.5836     0.5529   7.134 1.77e-10 ***
---
Signif. codes:  0 \'***\' 0.001 \'**\' 0.01 \'*\' 0.05 \'.\' 0.1 \' \' 1')

cat('
Residual standard error: 86.34 on 97 degrees of freedom
Multiple R-squared:  0.3555, Adjusted R-squared:  0.3422 
F-statistic: 26.75 on 2 and 97 DF,  p-value: 5.594e-10
')

summary_our_model <- summary(lm.beta(our_model))
summary_our_model$coefficients # Koeffiziententabelle
names(summary_our_model)      # weitere mögliche Argumente, die wir erhalten können
summary_our_model$r.squared  # R^2

avPlots(model = our_model, pch = 16, lwd = 4) 

residualPlots(model = our_model, pch = 16)

res <- studres(our_model) # Studentisierte Residuen als Objekt speichern
hist(res, freq = F)
xWerte <- seq(from = min(res), to = max(res), by = 0.01)
lines(x = xWerte, y = dnorm(x = xWerte, mean = mean(res), sd = sd(res)), lwd = 3)

#qqPlot(our_model, pch = 16, distribution = "norm")

ks.test(x = res, y = "pnorm")

quad_int_model <- lm(reading ~ 1 + female*IQ   + I(IQ^2), data = Schulleistungen)
summary(quad_int_model)

# Korrelation der Prädiktoren
cor(Schulleistungen$female, Schulleistungen$IQ)

vif(our_model)        # VIF
1/vif(our_model)      # Toleranz

1/(1-cor(Schulleistungen$female, Schulleistungen$IQ)^2) # 1/(1-R^2) = VIF
1-cor(Schulleistungen$female, Schulleistungen$IQ)^2 # 1-R^2 = Toleranz

n <- length(residuals(our_model))   # Anzahl an Personen bestimmen
h <- hatvalues(our_model)           # Hebelwerte
hist(h, breaks  = 20)               
abline(v = 2*(2+1)/n, col = "red")  # Cut-off als große Stichprobe
abline(v = 3*(2+1)/n, col = "blue")  # Cut-off als kleine Stichprobe

# Cooks Distanz
CD <- cooks.distance(our_model) # Cooks Distanz
hist(CD, breaks  = 20)
abline(v = 1, col = "red")  # Cut-off bei 1

# Cooks Distanz nochmal
hist(CD, breaks  = 20, xlim = c(0, 1))
abline(v = 1, col = "red")  # Cut-off bei 1

# Blasendiagramm mit Hebelwerten, studentisierten Residuen und Cooks Distanz
# In "IDs" werden die Zeilennummern der auffälligen Fälle gespeichert,
# welche gleichzeitig als Zahlen im Blasendiagramm ausgegeben werden
InfPlot <- influencePlot(our_model)
IDs <- as.numeric(row.names(InfPlot))
# Werte der identifizierten Fälle
InfPlot

# Rohdaten der auffälligen Fälle (gerundet für bessere Übersichtlichkeit)
round(Schulleistungen[IDs,],2)
# z-standardisierte Werte der auffälligen Fälle
round(scale(Schulleistungen)[IDs,],2) 

par(mfrow=c(2,2),cex.axis = 1.1, cex.lab= 1.2, cex.main = 1.3, mar = c(5, 5, 2, 1),
    bty="n",bg="white", mgp=c(2, 0.8, 0))

library(car)
X <- sort(rnorm(25))
y <- X + rnorm(25, sd = 0.3) 
reg <- lm(y~X)


X_ <- c(X, 0)
y_ <- c(y, 0 + 0 + rnorm(1, sd = 0.3))
reg1 <- lm(y_ ~ X_)

plot(X_,y_, pch = 16, main = "A)  kleine CD, kleiner Hebelwert", xlab = "X", ylab = "Y", xlim = c(-2,4), ylim = c(-2, 4))
abline(reg = reg, lwd = 3)
legend(x="topleft", legend = c("normal", "outlier"), col = c("black", "darkblue"), pch = 16, cex = 1.1, box.col = "grey")



X_ <- c(X, 4)
y_ <- c(y, 3.7 + rnorm(1, sd = 0.3))
reg1 <- lm(y_ ~ X_)

plot(X_,y_, pch = 16, main = "B)  kleine CD, großer Hebelwert", xlab = "X", ylab = "Y", xlim = c(-2,4), ylim = c(-2, 4))
abline(reg = reg, lwd = 3)
abline(reg = reg1, lwd = 5, col = "blue")
points(X_[length(X)+1], y_[length(X)+1], pch = 15, cex = 2.8, col = "gold")
points(X_[length(X)+1], y_[length(X)+1], pch = 16, cex = 2, col = "darkblue")

legend(x="topleft", legend = c("normal", "outlier"), col = c("black", "darkblue"), pch = 16, cex = 1.1, box.col = "grey")


X_ <- c(X, 0)
y_ <- c(y, 0 + 3.7 + rnorm(1, sd = 0.3))
reg1 <- lm(y_ ~ X_)

plot(X_,y_, pch = 16, main = "C)  große CD, kleiner Hebelwert", xlab = "X", ylab = "Y", xlim = c(-2,4), ylim = c(-2, 4))
abline(reg = reg, lwd = 3)
abline(reg = reg1, lwd = 5, col = "blue")
legend(x="topleft", legend = c("normal", "outlier"), col = c("black", "darkblue"), pch = 16, cex = 1.1, box.col = "grey")
points(X_[length(X)+1], y_[length(X)+1], pch = 15, cex = 2.8, col = "gold")
points(X_[length(X)+1], y_[length(X)+1], pch = 16, cex = 2, col = "darkblue")


X_ <- c(X, 4)
y_ <- c(y, 0  + rnorm(1, sd = 0.3))
reg1 <- lm(y_ ~ X_)

plot(X_,y_, pch = 16, main = "D)  große CD, großer Hebelwert", xlab = "X", ylab = "Y", xlim = c(-2,4), ylim = c(-2, 4))
abline(reg = reg, lwd = 3)
abline(reg = reg1, lwd = 5, col = "blue")
legend(x="topleft", legend = c("normal", "outlier"), col = c("black", "darkblue"), pch = 16, cex = 1.1, box.col = "grey")
points(X_[length(X)+1], y_[length(X)+1], pch = 15, cex = 2.8, col = "gold")
points(X_[length(X)+1], y_[length(X)+1], pch = 16, cex = 2, col = "darkblue")

library(ellipse)
mu1 <- c(0,0)
mu2 <- c(1,0)
S1 <- matrix(c(1,1,1,4),2,2)
#S2 <- matrix(c(4,0,0,1),2,2)
plot(0, col = "white", xlim = c(-3,3.5),ylim = c(-6,6), xlab = expression(X[1]), ylab = expression(X[2]), 
     main = "Kurven gleicher Wahrscheinlichkeit/\n Kurven gleicher Mahalanobisdistanz")

points(mu1[1],mu1[2],pch=19,col="green", cex = 3)
#points(mu2[1],mu2[2],pch=19, col = "blue", cex = 3)
# plotte einzelne Kovarianzmatrizen
color <- c("yellow","gold3", "gold3", "red")
i <- 1
for (q in c(0.5, 0.8,0.95,.99))
{
  lines(ellipse(S1,level=q)[,1]+mu1[1],ellipse(S1,level=q)[,2]+mu1[2], col = color[i], lwd = 4) 
  #lines(ellipse(S2,level=q)[,1]+mu2[1],ellipse(S2,level=q)[,2]+mu2[2],col= color [i], lwd = 4)
  i <- i +1 
}

X <- ellipse(S1,level=0.8)[,1]+mu1[1]
Y <- ellipse(S1,level=0.8)[,2]+mu1[2]

i <- 25
lines(c(X[i], 0), c(Y[i], 0), lwd = 3, col = "blue")
points(X[i],Y[i], cex = 2, pch = 16)

l <- sqrt(X[i]^2 + Y[i]^2)

i <- 1
l2 <-  sqrt(X[i]^2 + Y[i]^2)
lines(c(0, X[i]), c(0, Y[i]), lwd = 3)

arrows(x0=0,x1= X[i]*l/l2, y0=0,y1= Y[i]*l/l2, lwd = 3, col = "blue", code = 3, angle = 90, length = 0.1)

points(X[i],Y[i], cex = 2, pch = 16)
points(mu1[1],mu1[2],pch=19,col="green", cex = 3)

X <- cbind(Schulleistungen$reading, Schulleistungen$math) # Datenmatrix mit Leseleistung in Spalte 1 und Matheleistung in Spalte 2
colMeans(X)  # Spaltenmittelwerte (1. Zahl = Mittelwert der Leseleistung, 2. Zahl = Mittelwert der Matheleistung)
cov(X) # Kovarianzmatrix von Leseleistung und Matheleistung
cor(X) # zum Vergleich: die Korrelationsmatrix (die Variablen scheinen mäßig zu korrelieren, was unbedingt in die Ausreißerdiagnostik involviert werden muss)
MD <- mahalanobis(x = X, center = colMeans(X), cov = cov(X))

hist(MD, freq = F, breaks = 15)
xWerte <- seq(from = min(MD), to = max(MD), by = 0.01)
lines(x = xWerte, y = dchisq(x = xWerte, df = 2), lwd = 3)
qqPlot(x = MD,distribution =  "chisq", df = 2, pch = 16)

qchisq(p = .01, lower.tail = F, df = 2)    # alpha = 1%
qchisq(p = .001, lower.tail = F, df = 2)   # alpha = 0.1%

MD

MD[MD > qchisq(p = .01, lower.tail = F, df = 2)]      # Mahalanobiswerte > krit. Wert
which(MD > qchisq(p = .01, lower.tail = F, df = 2))   # Pbn-Nr.

our_next_model <- lm(math ~ reading + IQ, data = Schulleistungen)
our_next_model

# Vektor Y
y <- Schulleistungen$math
head(y)
# Matrix X vorbereiten (Spalten mit beiden Prädiktoren + Spalte mit Einsen anfügen)
X <- as.matrix(Schulleistungen[,c("reading", "IQ")])       
X <- cbind(rep(1,nrow(X)), X)                         
head(X)

# Berechnung der Kreuzproduktsumme X’X in R
XX <- t(X) %*% X        # X' erhalten Sie durch t(X)
XX

# Berechnung der Inversen (mit Regel nach Sarrus) in R
solve(XX)

#Berechnung des Kreuzproduksummenvektors X`y in R
Xy <- t(X) %*% y        
head(Xy)

# Berechnung des Einflussgewichtsvektors in R
b_hat <- solve(XX) %*% Xy     # Vektor der geschätzten Regressionsgewichte
b_hat
y_hat <- as.vector(X %*% b_hat) # Vorhersagewerte
head(y_hat)

#Berechnung der standardisierten Regressionsgewichte
y_s <- scale(y) # Standardisierung y
X_s <- scale(X) # Standardisierung X
X_s[,1] <- 1    # Einsenvektor ist nach Standardisierung zunächst NaN, muss wieder gefüllt werden
b_hat_s <- solve(t(X_s)%*% X_s) %*% t(X_s)%*%y_s #Regressionsgewichte aus den standardisierten Variablen
round(b_hat_s, 3)

lm.beta(our_next_model)

# Determinationskoeffizient R2
Q_d <- sum((y_hat - mean(y))^2)    # Regressionsquadratsumme
Q_e <- sum((y - y_hat)^2)          # Fehlerquadratsumme
R2 <- Q_d / (Q_d + Q_e)            # Determinationskoeffizient R2

# F-Wert
n <- length(y)                     # Fallzahl (n=100)
m <- ncol(X)-1                     # Zahl der Prädiktoren (m=2)
F_omn <- (R2/m) / ((1-R2)/(n-m-1))   # F-Wert
F_krit <- qf(.95, df1=m, df2=n-m-1)  # kritischer F-Wert (alpha=5%)
p <- 1-pf(F_omn, m, n-m-1)           # p-Wert

lm(reading ~ 1 + female + IQ, data = Schulleistungen)

lm(reading ~ 0 + female + IQ, data = Schulleistungen)

lm(reading ~ female + IQ, data = Schulleistungen)

lm(formula = 1 + reading ~ female + IQ, data = Schulleistungen) 

lm(data = Schulleistungen, formula = 1 + reading ~ female + IQ) 

lm("reading ~ 1 + female + IQ", data = Schulleistungen) 

lm(Schulleistungen$reading ~ 1 + Schulleistungen$female + Schulleistungen$IQ) 

AV <- Schulleistungen$reading
UV1 <- Schulleistungen$female
UV2 <- Schulleistungen$IQ

lm(AV ~ 1 + UV1 + UV2)

library(ggplot2)
df_res <- data.frame(res) # als Data.Frame für ggplot
ggplot(data = df_res, aes(x = res)) + 
     geom_histogram(aes(y =..density..),
                    bins = 15,                    # Wie viele Balken sollen gezeichnet werden?
                    colour = "blue",              # Welche Farbe sollen die Linien der Balken haben?
                    fill = "skyblue") +           # Wie sollen die Balken gefüllt sein?
     stat_function(fun = dnorm, args = list(mean = mean(res), sd = sd(res)), col = "darkblue") + # Füge die Normalverteilungsdiche "dnorm" hinzu und nutze den empirischen Mittelwert und die empirische Standardabweichung "args = list(mean = mean(res), sd = sd(res))", wähle dunkelblau als Linienfarbe
     labs(title = "Histogramm der Residuen mit Normalverteilungsdichte", x = "Residuen") # Füge eigenen Titel und Achsenbeschriftung hinzu

# hier nochmal nur das Nötigste:
ggplot(data = df_res, aes(x = res)) + 
     geom_histogram(aes(y =..density..),  bins = 15) +           
     stat_function(fun = dnorm, args = list(mean = mean(res), sd = sd(res)))

n <- length(residuals(our_model))
h <- hatvalues(our_model) # Hebelwerte
df_h <- data.frame(h) # als Data.Frame für ggplot
ggplot(data = df_h, aes(x = h)) + 
     geom_histogram(aes(y =..density..),  bins = 15)+
  geom_vline(xintercept = 4/n, col = "red") # Cut-off bei 4/n

# Cooks Distanz
CD <- cooks.distance(our_model) # Cooks Distanz
df_CD <- data.frame(CD) # als Data.Frame für ggplot
ggplot(data = df_CD, aes(x = CD)) + 
     geom_histogram(aes(y =..density..),  bins = 15)+
  geom_vline(xintercept = 1, col = "red") # Cut-Off bei 1

XX_1 <- matrix(c(100,0,0,
               0,100,0,
               0,0,100),3,3)
XX_1 # Die Matrix X'X im Fall 1
I_1 <- solve(XX_1)*1 # I (*1 wegen Residualvarianz = 1)
I_1
sqrt(diag(I_1)) # Wurzel aus den Diagonalelementen der Inverse = SE, wenn sigma_e^2=1

XX_2 <- matrix(c(100,0,0,
               0,100,99,
               0,99,100),3,3)
XX_2 # Die Matrix X'X im Fall 2
I_2 <- solve(XX_2)*1 # I (*1 wegen Residualvarianz = 1)
I_2
sqrt(diag(I_2)) # SEs im Fall 2
sqrt(diag(I_1)) # SEs im Fall 1

det(XX_2) # Determinante Fall 2
det(XX_1) # Determinante Fall 1

XX_3 <- matrix(c(100,0,0,
               0,100,100,
               0,100,100),3,3)
XX_3 # Die Matrix X'X im Fall 3
det(XX_3) # Determinante on X'X im Fall 3

## I_3 <- solve(XX_3)*1 # I (*1 wegen Residualvarianz = 1)
## I_3
## sqrt(diag(I_3)) # Wurzel aus den Diagonalelementen der Inverse = SE, wenn sigma_e^2=1
## 
## # hier wird eine Fehlermeldung ausgegeben, wodurch der Code nicht ausführbar ist und I_3 nicht gebildet werden kann:
## 
## #    Error in solve.default(XX_3) :
## #    Lapack routine dgesv: system is exactly singular: U[2,2] = 0
