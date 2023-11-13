# Daten abrufen
load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))
head(Schulleistungen)

#Pakete laden
library(ggplot2)       # für Graphiken

# grafische Darstellung mittels Scatterplot
ggplot(Schulleistungen, aes(x=reading, y=math)) + 
  geom_point() + 
  labs(x= "Leseleistung", y= "Mathematikleistung")

# Korrelationstest
cor.test(Schulleistungen$reading, Schulleistungen$math)

# Korrelation der Drittvariablen mit den beiden ursprünglichen Variablen
cor.test(Schulleistungen$IQ, Schulleistungen$reading)
cor.test(Schulleistungen$IQ, Schulleistungen$math)


# Regression 
reg_math_IQ <- lm(math ~ IQ, data = Schulleistungen)
reg_reading_IQ <- lm(reading ~ IQ, data = Schulleistungen)

# Residuen in Objekt ablegen (Residuen x)
res_reading_IQ <- residuals(reg_reading_IQ)

# Residuen in Objekt ablegen (Residuen y)
res_math_IQ <- residuals(reg_math_IQ)

# Partialkorrelation durch Residuen
cor(res_reading_IQ, res_math_IQ)

## # Paket für Partial- und Semipartialkorrelation
## install.packages("ppcor")

library(ppcor)

# Partialkorrelation mit Funktion
pcor.test(x=Schulleistungen$reading, y=Schulleistungen$math, z=Schulleistungen$IQ)

# Semipartialkorrelation durch Nutzung des Residuums
cor(Schulleistungen$reading, res_math_IQ)


# Semipartialkorrelation mit Funktion
spcor.test(x=Schulleistungen$reading, y=Schulleistungen$math, z=Schulleistungen$IQ)

