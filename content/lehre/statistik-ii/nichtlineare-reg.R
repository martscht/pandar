load(url("https://pandar.netlify.app/daten/PISA2009.rda"))
dim(PISA2009)

str(PISA2009)

library(car)    
library(MASS)
library(lm.beta) # erforderlich für standardiserte Gewichte
library(ggplot2) # für grafische Darstellungen
library(interactions) # für Interaktionsplots in moderierten Regressionen

# Berechnung des Modells und Ausgabe der Ergebnisse
m1 <- lm(Reading ~ HISEI + MotherEdu + Books, data = PISA2009)
summary(lm.beta(m1))

# Residuenplots
residualPlots(m1, pch = 16)

res <- studres(m1) # Studentisierte Residuen als Objekt speichern
df_res <- data.frame(res) # als Data.Frame für ggplot
# Grafisch: Histogramm mit Normalverteilungskurve
library(ggplot2)
ggplot(data = df_res, aes(x = res)) + 
     geom_histogram(aes(y =after_stat(density)),
                    bins = 15,                    # Wie viele Balken sollen gezeichnet werden?
                    colour = "blue",              # Welche Farbe sollen die Linien der Balken haben?
                    fill = "skyblue") +           # Wie sollen die Balken gefüllt sein?
     stat_function(fun = dnorm, args = list(mean = mean(res), sd = sd(res)), col = "darkblue") + # Füge die Normalverteilungsdiche "dnorm" hinzu und nutze den empirischen Mittelwert und die empirische Standardabweichung "args = list(mean = mean(res), sd = sd(res))", wähle dunkelblau als Linienfarbe
     labs(title = "Histogramm der Residuen mit Normalverteilungsdichte", x = "Residuen")+ # Füge eigenen Titel und Achsenbeschriftung hinzu
  theme_minimal()

# Test auf Abweichung von der Normalverteilung mit dem Shpiro Test
shapiro.test(res)

m1.b <- lm(Reading ~ HISEI + poly(MotherEdu, 2) + Books, data = PISA2009)
summary(lm.beta(m1.b))

# Vergleich mit Modell ohne quadratischen Trend
summary(m1.b)$r.squared - summary(m1)$r.squared # Inkrement

anova(m1, m1.b)

residualPlots(m1.b, pch = 16)



load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))

head(Schulleistungen)



Schulleistungen_std <- data.frame(scale(Schulleistungen)) # standardisierten Datensatz abspeichern als data.frame
colMeans(Schulleistungen_std)     # Mittelwert pro Spalte ausgeben
apply(Schulleistungen_std, 2, sd) # Standardabweichungen pro Spalte ausgeben

mod_reg <- lm(reading ~ math + IQ + math:IQ, data = Schulleistungen_std)
summary(mod_reg)

library(interactions)
interact_plot(model = mod_reg, pred = IQ, modx = math)



##################
#### Einstellen der Koeffizienten und berechnen von f(x)
#### 
x <- seq(-1,2,0.1) # x = Variablen (als Zahlen zwischen -1 und 2)
a <- 2   # Vorfaktor, der die Ausprägung an der Stelle x=0 beschreibt
b <- 3   #  Basis des exponentiellen Wachstums
c <- 1.5 # *eigentlich redundanter* Ratenparameter
f <- a*b^(c*x) # f(x), eine exponentiell-wachsende Funktion in x

##################
#### Plot von f(x) vs. x
#### 
plot(x = x, y = f, type = "l", col = "blue", lwd = 2, main = "Plot von f(x) vs. x") # plotte f(x) gegen x
abline(v = 0, lwd = 0.7) # y-Achse, v = 0 zeichnet eine vertikale Linie bei x = 0
abline(h = a, lty = 3) # im Punkt a schneidet f (das exponentielle Wachstum) die y-Achse (x=0), h = a zeichnet zu y = a eine horizontale Linie

##################
#### Plot von ln(f(x)) vs. x
#### 
plot(x = x, y = log(f), type = "l", col = "blue", lwd = 2, main = "Plot von ln(f(x)) vs. x") # plotte ln(f(x)) gegen x
abline(v = 0, lwd = 0.7) # y-Achse, v = 0 zeichnet eine vertikale Linie bei x = 0
abline(h = log(a), lty = 3)  # im Punkt log(a) schneidet log(f) (das linearisierte exponentielle Wachstum) die y-Achse (x=0), h =llog(a) zeichnet zu y = log(a) eine horizontale Linie

load(url("https://pandar.netlify.app/daten/WorldPopulation.rda"))

head(WorldPopulation)

ggplot(data = WorldPopulation, aes(x = Year, y = Population))+geom_point()+theme_minimal()

ggplot(data = WorldPopulation, aes(x = Year, y = Population))+
     geom_point()+geom_smooth(method="lm", formula = "y~x")+
  theme_minimal()# plotte linearen Verlauf 
m_l <- lm(Population ~ Year, data = WorldPopulation) # linearer Verlauf
summary(m_l)  

#########
### Normalverteilung der Residuen?
##
res <- studres(m_l) # Studentisierte Residuen als Objekt speichern
df_res <- data.frame(res) # als Data.Frame für ggplot
# Grafisch: Histogramm mit Normalverteilungskurve
ggplot(data = df_res, aes(x = res)) + 
     geom_histogram(aes(y =after_stat(density)),
                    bins = 10,                    # Wie viele Balken sollen gezeichnet werden?
                    colour = "blue",              # Welche Farbe sollen die Linien der Balken haben?
                    fill = "skyblue") +           # Wie sollen die Balken gefüllt sein?
     stat_function(fun = dnorm, args = list(mean = mean(res), sd = sd(res)), col = "darkblue") + # Füge die Normalverteilungsdiche "dnorm" hinzu und nutze den empirischen Mittelwert und die empirische Standardabweichung "args = list(mean = mean(res), sd = sd(res))", wähle dunkelblau als Linienfarbe
     labs(title = "Histogramm der Residuen mit Normalverteilungsdichte\n für das lineare Modell", x = "Residuen")+ # Füge eigenen Titel und Achsenbeschriftung hinzu
  theme_minimal()

WorldPopulation$log_Population <- log(WorldPopulation$Population) # Logarithmus der Weltbevölkerung

m_log <- lm(log_Population ~ Year, data = WorldPopulation) # lineares Modell mit log(y) als AV (logarithmische Skala)
summary(m_log)



m_log2 <- lm(I(log(Population)) ~ Year, data = WorldPopulation) # lineares Modell mit log(y) als AV (logarithmische Skala)
summary(m_log2)

ggplot(data = WorldPopulation, aes(x = Year, y = log_Population))+
     geom_point()+geom_smooth(method="lm", formula = "y~x", col = "red")+
  labs(title = "Logarithmierte Weltbevölkerung vs. Jahr")+
  theme_minimal()

WorldPopulation$pred_Pop_exp <- exp(predict(m_log)) # Abspeichern der retransformierten vorhergesagten Werten (wieder auf der Skala der Weltbevölkerung)
head(WorldPopulation)

ggplot(data = WorldPopulation, aes(x = Year, y = Population))+
     geom_point()+geom_smooth(method="lm", formula = "y~x")+         # plotte linearen Verlauf 
     geom_line(aes(x = Year, y = pred_Pop_exp), col = "red", lwd = 1.5)

exp(coef(m_log))

X <- 1:10   # Variable X
X2 <- X^2   # Variable X hoch 2
X_poly <- poly(X, 2)  # erzeuge Variable X und X hoch mit Hilfe der poly Funktion
colnames(X_poly) <- c("poly(X, 2)1", "poly(X, 2)2")
cbind(X, X2, X_poly)

round(apply(X = cbind(X, X2, X_poly), MARGIN = 2, FUN = mean), 2) # Mittelwerte über die Spalten hinweg berechnen
round(apply(X = cbind(X, X2, X_poly), MARGIN = 2, FUN = sd), 2) # Standardabweichung über die Spalten hinweg berechnen
round(cor(cbind(X, X2, X_poly)),2) # Korrelationen berechnen

m1.b1 <- lm(Reading ~ HISEI + poly(MotherEdu, 1) + Books, data = PISA2009)
summary(lm.beta(m1.b1))
m1.b2 <- lm(Reading ~ HISEI + poly(MotherEdu, 2) + Books, data = PISA2009)
summary(lm.beta(m1.b2))

PISA2009$MotherEdu2 <- PISA2009$MotherEdu^2 # füge dem Datensatz den quadrierten Bildungsabschluss der Mutter hinzu
m1.c1 <- lm(Reading ~ HISEI + MotherEdu + Books, data = PISA2009)
summary(lm.beta(m1.c1))
m1.c2 <- lm(Reading ~ HISEI + MotherEdu + MotherEdu2 + Books, data = PISA2009)
summary(lm.beta(m1.c2))

rbind(coef(m1.b1), coef(m1.c1)) # vgl Koeffizienten
rbind(coef(m1.b2),coef(m1.c2)) # vgl Koeffizienten

rbind(summary(m1.b1)$r.squared, summary(m1.c1)$r.squared) # vgl R^2
rbind(summary(m1.b2)$r.squared,summary(m1.c2)$r.squared) # vgl R^2

a <- 1; b <- 0; c <- 0
x <- seq(-2,2,0.01)
f <- a*x^2 + b*x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x,  y = f)) + 
     geom_line(col = "black")+
     labs(x = "x", y =  "f(x)",
          title = expression("f(x)="~x^2))

a <- 0.5; b <- 0; c <- 0
x <- seq(-2,2,0.01)
f <- a*x^2 + b*x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x,  y = f)) + 
     geom_line(col = "blue", lwd = 2)+ geom_line(mapping = aes(x, x^2), lty = 3)+
     labs(x = "x", y =  "f(x)",
          title = expression("f(x)="~0.5*x^2))

a <- 2; b <- 0; c <- 0
x <- seq(-2,2,0.01)
f <- a*x^2 + b*x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x,  y = f)) + 
     geom_line(col = "blue", lwd = 2)+ geom_line(mapping = aes(x, x^2), lty = 3)+
     labs(x = "x", y =  "f(x)",
          title = expression("f(x)="~2*x^2))

a <- -1; b <- 0; c <- 0
x <- seq(-2,2,0.01)
f <- a*x^2 + b*x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x,  y = f)) + 
     geom_line(col = "blue", lwd = 2)+ geom_line(mapping = aes(x, x^2), lty = 3)+
     labs(x = "x", y =  "f(x)",
          title = expression("f(x)="~-x^2))

a <- 1; b <- 0; c <- 1
x <- seq(-2,2,0.01)
f <- a*x^2 + b*x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x,  y = f)) + 
     geom_line(col = "blue", lwd = 2)+ geom_line(mapping = aes(x, x^2), lty = 3)+
     labs(x = "x", y =  "f(x)",
          title = expression("f(x)="~x^2+1))

a <- 1; b <- 1; c <- 0
x <- seq(-2,2,0.01)
f <- a*x^2 + b*x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x,  y = f)) + 
     geom_line(col = "blue", lwd = 2)+ geom_line(mapping = aes(x, x^2), lty = 3)+
     labs(x = "x", y =  "f(x)",
          title = expression("f(x)="~x^2+x))

a <- -0.5; b <- 1; c <- 2
x <- seq(-2,2,0.01)
f <- a*x^2 + b*x + c
data_X <- data.frame(x, f)
ggplot(data = data_X, aes(x = x,  y = f)) + 
     geom_line(col = "blue", lwd = 2)+ geom_line(mapping = aes(x, x^2), lty = 3)+
     labs(x = "x", y =  "f(x)",
          title = expression("f(x)="~-0.5*x^2+x+2))

X <- scale(poly(PISA2009$MotherEdu, 2))
std_par_ME <- c(0.1588, -0.1436)
pred_effect_ME <- X %*% std_par_ME
std_ME <- X[,1]
data_ME <- data.frame(std_ME, pred_effect_ME)
ggplot(data = data_ME, aes(x = std_ME,  y = pred_effect_ME)) + geom_point(pch = 16, col = "blue", cex = 4)+
     labs(y = "std. Leseleistung | Others", x =  "std. Bildungsabschluss der Mutter | Others",
          title = "Standardisierte bedingte Beziehung zwischen\n Bildungsabschluss der Mutter und Leseleistung")

A <- seq(0, 10, 0.1)

cor(A, A^2)

A_c <- A - mean(A)
mean(A_c)

A_c2 <- scale(A, center = T, scale = F)  # scale = F bewirkt, dass nicht auch noch die SD auf 1 gesetzt werden soll
mean(A_c2)

cor(A_c, A_c^2)
cor(poly(A, 2))

# auf 15 Nachkommastellen gerundet:
round(cor(A_c, A_c^2), 15)
round(cor(poly(A, 2)), 15) 

# auf 15 Nachkommastellen gerundet:
round(cor(cbind(A, A^2, A^3, A^4)), 2)
round(cor(cbind(A_c, A_c^2, A_c^3, A_c^4)), 2) 
round(cor(poly(A, 4)), 2)


var(A)
var(A_c)

# Kovarianz 
cov(A, A^2)
2*mean(A)*var(A)

# zentriert:
round(cov(A_c, A_c^2), 14)
round(2*mean(A_c)*var(A_c), 14)

library(plot3D)
# Übersichtlicher: Vorbereitung
x <- Schulleistungen_std$IQ
y <- Schulleistungen_std$reading
z <- Schulleistungen_std$math
fit <- lm(y ~ x*z)
grid.lines = 26
x.pred <- seq(min(x), max(x), length.out = grid.lines)
z.pred <- seq(min(z), max(z), length.out = grid.lines)
xz <- expand.grid( x = x.pred, z = z.pred)
y.pred <- matrix(predict(fit, newdata = xz), 
                 nrow = grid.lines, ncol = grid.lines)
fitpoints <- predict(fit)

# Plot:
scatter3D(x = x, y = z, z = y, pch = 16, cex = 1.2, 
          theta = 0, phi = 0, ticktype = "detailed",
          xlab = "IQ", ylab = "math", zlab = "reading",  
          surf = list(x = x.pred, y = z.pred, z = y.pred,  
                      facets = NA, fit = fitpoints), 
          main = "Moderierte Regression")

scatter3D(x = x, y = z, z = y, pch = 16, cex = 1.2, 
          theta = 20, phi = 20, ticktype = "detailed",
          xlab = "IQ", ylab = "math", zlab = "reading",  
          surf = list(x = x.pred, y = z.pred, z = y.pred,  
                      facets = NA, fit = fitpoints), 
          main = "Moderierte Regression")

# gleiches Ergebnis:
10^3
exp(3*log(10))

# gleiches Ergebnis:
log(10^3, base = 10) # Logarithmus von 1000 zur Basis 10
log(10^3)/log(10) # mit ln

# gleiches Ergebnis:
log(9, base = 3) # Logarithmus von 9 zur Basis 3
log(9)/log(3) # mit ln
