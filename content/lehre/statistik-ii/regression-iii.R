#### Vorbereitung ----
# Datensatz laden
load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))

#### Modell aufstellen ----
# Leseleistung durch Geschlecht und IQ vorhersagen, von Interesse sind hier die Beta-Gewichte des Modells

mod <- lm(reading ~ female + IQ, data = Schulleistungen)
summary(mod)



# Berechnung standardisierter Koeffizienten
library(lm.beta)
summary(lm.beta(mod))

## Grafische Prüfung der partiellen Linearität

library(car) # Paket mit einigen Funktionen zur Regressionsdiagnostik

# partielle Regressionsplots
avPlots(model = mod, pch = 16, lwd = 4)

## Prüfung der Homoskedastizität (Grafisch)
# Residuenplots (+ Test auf Nicht-Linearität)
residualPlots(mod, pch = 16)

## Prüfung der Homoskedastizität (Test)
# Test For Non-Constant Error Variance
ncvTest(mod)

## Prüfung der Normalverteilung (Grafisch)
# Daten für ggplot extrahieren
library(MASS)
res <- studres(mod)       # Studentisierte Residuen als Objekt speichern
df_res <- data.frame(res) # als Data.Frame für ggplot
head(df_res)              # Kurzer Blick in den Datensatz

# ggplot erstellen
library(ggplot2)
# Histogramm der Residuen mit Normalverteilungs-Kurve
ggplot(data = df_res, aes(x = res)) + 
     geom_histogram(aes(y = after_stat(density)),
                    bins = 20,                    # Wie viele Balken sollen gezeichnet werden?
                    colour = "blue",              # Welche Farbe sollen die Linien der Balken haben?
                    fill = "skyblue") +           # Wie sollen die Balken gefüllt sein?
     stat_function(fun = dnorm, args = list(mean = mean(res), sd = sd(res)), col = "darkblue") + # Füge die Normalverteilungsdiche "dnorm" hinzu und nutze den empirischen Mittelwert und die empirische Standardabweichung "args = list(mean = mean(res), sd = sd(res))", wähle dunkelblau als Linienfarbe
     labs(title = "Histogramm der Residuen mit Normalverteilungsdichte", x = "Residuen") # Füge eigenen Titel und Achsenbeschriftung hinzu

# Grafisch: Q-Q-Diagramm mit der Funktion qqPlot aus dem Paket car
qqPlot(mod, pch = 16, distribution = "norm") 
  

## Prüfung der Normalverteilung (Test)

# Test auf Abweichung von der Normalverteilung mit dem Shapiro-Test
shapiro.test(res)

# Test auf Abwweichung von der Normalverteilung mit dem Kolmogorov-Smirnov Test
ks.test(res, "pnorm", mean(res), sd(res))

## Prüfung der Mulitkollinearität durch Inspektion der bivariaten ZUsammenhänge (T / VIF)

# Korrelation der Prädiktoren
cor(Schulleistungen$female, Schulleistungen$IQ)

# Varianzinflationsfaktor:
vif(mod)

# Toleranzwerte als Kehrwerte
1 / vif(mod)

#### Ausreißerdiagnostik ----

n <- length(residuals(mod)) # n für Berechnung der Cut-Off-Werte
h <- hatvalues(mod)         # Hebelwerte
df_h <- data.frame(h)       # als Data.Frame für ggplot

# Erzeugung der Grafik
ggplot(data = df_h, aes(x = h)) +
  geom_histogram(aes(y =after_stat(density)),  bins = 15, fill="skyblue", colour = "blue") +
  geom_vline(xintercept = 4/n, col = "red") # Cut-off bei 4/n

# Cooks Distanz gibt an, wie stark sich Regressionsgewichte ändern, wenn eine Person i aus dem Datensatz entfernt wird

# Cooks Distanz
CD <- cooks.distance(mod) # Cooks Distanz
df_CD <- data.frame(CD) # als Data.Frame für ggplot

# Erzeugung der Grafik
ggplot(data = df_CD, aes(x = CD)) +
  geom_histogram(aes(y =after_stat(density)),  bins = 15, fill="skyblue", colour = "blue") +
  geom_vline(xintercept = 1, col = "red") # Cut-Off bei 1

# Blasendiagramm, das simultan Hebelwerte, studentisierte Residuen und Cooks Distanz darstellt

InfPlot <- influencePlot(mod)
IDs <- as.numeric(row.names(InfPlot))

# Rohdaten der auffälligen Fälle (gerundet für bessere Übersichtlichkeit)
round(Schulleistungen[IDs,],2)

# z-Standardisierte Werte der auffälligen Fälle
round(scale(Schulleistungen)[IDs,],2) 

