## install.packages("car")            # Die Installation ist nur einmalig von Nöten!
## install.packages("lm.beta")        # Sie müssen nur zu Update-Zwecken erneut installiert werden.
## install.packages("MASS")

library(lm.beta)  # Standardisierte beta-Koeffizienten für die Regression
library(car)      # Zusätzliche Funktion für Diagnostik von Datensätzen
library(MASS)     # Zusätzliche Funktion für Diagnostik von Datensätzen 

## load("C:/Users/Musterfrau/Desktop/Depression.rda")

load(url("https://pandar.netlify.app/post/Depression.rda"))

head(Depression)

levels(Depression$Geschlecht) <- c("maennlich", "weiblich")
Depression[5, 6] <- "maennlich"    

lm(Depressivitaet ~ 1 + Geschlecht + Lebenszufriedenheit, data = Depression)

model <- lm(Depressivitaet ~ 1 + Geschlecht + Lebenszufriedenheit, data = Depression)
summary(model)

lm.beta(model) |> summary()
model |> lm.beta() |> summary() # alternativ 

output <- capture.output(summary(lm.beta(model)))
cat(paste(output[1:4], collapse = "\n"))

cat(paste(output[5:8], collapse = "\n"))

mean(x = resid(model)) # Mittelwert mit Referenzierung aus dem lm Objekt "model"

cat(paste(output[9:17], collapse = "\n"))

cat(paste(output[16:21], collapse = "\n"))

summary_model <- summary(lm.beta(model))
summary_model$coefficients # Koeffiziententabelle
summary_model$r.squared  # R^2
names(summary_model) # weitere mögliche Argumente, die wir erhalten können

# Korrelation der Prädiktoren
cor(as.numeric(Depression$Geschlecht), Depression$Lebenszufriedenheit)

vif(model)        # VIF
1/vif(model)      # Toleranz

1/(1-cor(as.numeric(Depression$Geschlecht), Depression$Lebenszufriedenheit)^2) # 1/(1-R^2) = VIF
1-cor(as.numeric(Depression$Geschlecht), Depression$Lebenszufriedenheit)^2 # 1-R^2 = Toleranz

n <- length(residuals(model))   # Anzahl an Personen bestimmen
h <- hatvalues(model)           # Hebelwerte
hist(h, breaks  = 20)               
abline(v = 2*(2+1)/n, col = "red")  # Cut-off als große Stichprobe
abline(v = 3*(2+1)/n, col = "blue")  # Cut-off als kleine Stichprobe

# Cook's Distanz
CD <- cooks.distance(model) # Cook's Distanz
hist(CD, breaks  = 20)
abline(v = 1, col = "red")  # Cut-off bei 1

# Cook's Distanz nochmal
hist(CD, breaks  = 20, xlim = c(0, 1))
abline(v = 1, col = "red")  # Cut-off bei 1

# Blasendiagramm mit Hebelwerten, studentisierten Residuen und Cook's Distanz
InfPlot <- influencePlot(model)
# Werte der identifizierten Fälle
InfPlot
# In "IDs" werden die Zeilennummern der auffälligen Fälle gespeichert,
# welche gleichzeitig als Zahlen im Blasendiagramm ausgegeben werden
IDs <- as.numeric(row.names(InfPlot))

# Rohdaten der auffälligen Fälle 
Depression[IDs,]
# z-standardisierte Werte der auffälligen Fälle
scale(Depression[,1:4])[IDs,]

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

lm(Depressivitaet ~ 1 + Geschlecht + Lebenszufriedenheit, data = Depression)

lm(Depressivitaet ~ 0 + Geschlecht + Lebenszufriedenheit, data = Depression)

lm(Depressivitaet ~ Geschlecht + Lebenszufriedenheit, data = Depression)

lm(formula = Depressivitaet ~ 1 + Geschlecht + Lebenszufriedenheit, data = Depression) 

lm(data = Depression, formula = Depressivitaet ~ 1 + Geschlecht + Lebenszufriedenheit) 

lm("Depressivitaet ~ 1 + Geschlecht + Lebenszufriedenheit", data = Depression) 

lm(Depression$Depressivitaet ~ 1 + Depression$Geschlecht + Depression$Lebenszufriedenheit) 

AV <- Depression$Depressivitaet
UV1 <- Depression$Geschlecht
UV2 <- Depression$Lebenszufriedenheit

lm(AV ~ 1 + UV1 + UV2)

n <- length(residuals(model)) #Anzahl Personen
h <- hatvalues(model) # Hebelwerte
library(ggplot2)
df_h <- data.frame(h) # als Data.Frame für ggplot
ggplot(data = df_h, aes(x = h)) + 
     geom_histogram(aes(y =..density..),  
                    bins = 15,             # Wie viele Balken sollen gezeichnet werden?
                     colour = "blue",              # Welche Farbe sollen die Linien der Balken haben?
                    fill = "skyblue") +           # Wie sollen die Balken gefüllt sein?
  geom_vline(xintercept = 4/n, col = "red")+ # Cut-off bei 4/n
  labs(title = "Histogramm der Hebelwerte", x = "Hebelwerte") # Füge eigenen Titel und Achsenbeschriftung hinzu

# Cook's Distanz
CD <- cooks.distance(model) # Cook's Distanz
df_CD <- data.frame(CD) # als Data.Frame für ggplot
ggplot(data = df_CD, aes(x = CD)) + 
     geom_histogram(aes(y =..density..),  bins = 15)+
  geom_vline(xintercept = 1, col = "red") # Cut-Off bei 1

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

X <- cbind(Depression$Depressivitaet, Depression$Lebenszufriedenheit) # Datenmatrix mit Depressivitaet in Spalte 1 und Lebenszufriedenheit in Spalte 2
colMeans(X)  # Spaltenmittelwerte (1. Zahl = Mittelwert der Depressivitaet, 2. Zahl = Mittelwert der Lebenszufriedenheit)
cov(X) # Kovarianzmatrix von Depressivitaet und Lebenszufriedenheit
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
which(MD > qchisq(p = .01, lower.tail = F, df = 2))   # Pbn-Nr. 1%
which(MD > qchisq(p = .001, lower.tail = F, df = 2))   # Pbn-Nr. 0.1%
