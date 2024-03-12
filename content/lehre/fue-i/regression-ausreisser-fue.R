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





quantile(x = resid(our_model), probs = .25) # .25 = 25% = 25. PR mit der Funktion resid()
mean(x = our_model$residuals) # Mittelwert mit Referenzierung aus dem lm Objekt "our_model"





summary_our_model <- summary(lm.beta(our_model))
summary_our_model$coefficients # Koeffiziententabelle
names(summary_our_model)      # weitere mögliche Argumente, die wir erhalten können
summary_our_model$r.squared  # R^2

avPlots(model = our_model, pch = 16, lwd = 4) 


residualPlots(our_model, pch = 16)

res <- studres(our_model) # Studentisierte Residuen als Objekt speichern
hist(res, freq = F)
xWerte <- seq(from = min(res), to = max(res), by = 0.01)
lines(x = xWerte, y = dnorm(x = xWerte, mean = mean(res), sd = sd(res)), lwd = 3)

qqPlot(our_model, pch = 16, distribution = "norm")

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
