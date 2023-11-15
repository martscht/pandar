# Datensatz laden
load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))
names(Schulleistungen)

# Vektor y
y <- Schulleistungen$math
str(y)

# Matrix X vorbereiten 
X <- as.matrix(Schulleistungen[,c("reading", "IQ")])      

# Matrix X erweitern
constant <- rep(1, nrow(X))
X <- cbind(constant, X)                         
head(X)

# Transponierte Matrix - Befehl
t(X) # X' erhalten Sie durch t(X)

# Erster Schritt:
# Berechnung der Kreuzproduktsumme X’X in R
X.X <- t(X) %*% X       
X.X



# Zweiter Schritt:
# Berechnung der Inversen (mit Regel nach Sarrus) in R
solve(X.X)

# Dritter Schritt:
# Berechnung des Kreuzproduksummenvektors X`y in R
X.y <- t(X) %*% y        
X.y

# Vierter Schritt:
# Berechnung des Einflussgewichtsvektor in R
b_hat <- solve(X.X) %*% X.y     # Vektor der geschätzten Regressionsgewichte
b_hat

# Vektor mit den vorhergesagten Werten
y_hat <- X %*% b_hat # Vorhersagewerte für jede einzelne Person 
head(y_hat)


#Berechnung der standardisierten Regressionsgewichte
y_s <- scale(y) # Standardisierung y
X_s <- scale(X) # Standardisierung X
head(X_s)

X_s <-  X_s[,-1]     # erste Spalte entfernen   

#Kombination der Einzelschritte zur Bestimmung der Regressionsgewichte
b_hat_s <- solve(t(X_s)%*% X_s) %*% t(X_s)%*%y_s #Regressionsgewichte aus den standardisierten Variablen
round(b_hat_s, 3)


Q_t <- sum((y - mean(y))^2)          # Totale Quadratsumme
Q_t

Q_d <- sum((y_hat - mean(y))^2)    # Regressionsquadratsumme
Q_d

Q_e <- sum((y - y_hat)^2)          # Fehlerquadratsumme
Q_e

#Zusammenrechnung der gerundeten Werte, um zu zeigen, dass sich Q_t aus der Summe von Q_d und Q_e ergibt
round(Q_t,2) == round(Q_d + Q_e, 2)

R2 <- Q_d / (Q_d + Q_e)            # Determinationskoeffizient R^2
# Alternativ Q_d / Q_t

#Determinationskoeffizient über quadrierte Korrelation
corx1y <- cor(y, X[,2])
corx1y^2 

#Semipartialkorrelation mit ppcor, aus y wird partialisiert, x2 ist Prädiktor "allgemeine Intelligenz", z, "Lesefähigkeit" ist Variable die rauspartialisiert wird
library(ppcor)
spcor.test(x = y, y = X[,3], z = X[,2])

#Ergebnis wird in Objekt abgelegt und gezeigt, dass per $estimate der Wert der spcor angezeigt werden kann
semipartial <- spcor.test(x = y, y = X[,3], z = X[,2])
semipartial$estimate

#Aufaddieren zur Bestimmung des multiplen Determinationskoeffizienten
corx1y^2 + semipartial$estimate^2

#Bestimmen von n (Anzahl Personen/Fälle) und m (Anzahl Prädiktoren), sowie empirischer F-Wert
n <- length(y)                     # Fallzahl (n=100)
m <- ncol(X)-1                     # Zahl der Prädiktoren (m=2)
F_omn <- (R2/m) / ((1-R2)/(n-m-1)) # empirischer F-Wert
F_omn

#Berechnung des alpha-Fehlers
F_krit <- qf(.95, df1=m, df2=n-m-1)  # kritischer F-Wert (alpha=5%)

#Vergleich des kritischen und empirischen F
F_krit < F_omn  # Vergleich durch logische Überprüfung

#Verwerfen der Nullhypothese da kritischer Wert kleiner, jetzt jedoch noch alternative Methode mit p-Wert die das selbe ausgibt
p <- 1-pf(F_omn, m, n-m-1)           # p-Wert
p < 0.05

# Regressionsanalyse mit lm (nicht mehr händisch)
reg <- lm(math ~ reading + IQ, data = Schulleistungen)

#Vergleich der Ergebnisse mit händischer Berechnung
summary(reg)
sum_reg <- summary(reg)

## #Paket für Anzeige der standardisiserten Regressionsgewichte - installieren wenn noch nicht vorhanden, dafür auskommentieren!
## install.packages("lm.beta") #Paket installieren (wenn nötig)

#Nun Paket laden
library(lm.beta)

# Ergebnisausgabe einschließlich standardisierter Koeffizienten mit lm.beta
reg_s <- lm.beta(reg)
summary(reg_s)         # reg |> lm.beta() |> summary()
