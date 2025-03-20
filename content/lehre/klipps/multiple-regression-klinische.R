source('https://pandar.netlify.app/daten/Data_Processing_coercion.R')



# Paket für Deskriptivstatistik laden
library(psych)

# Deskriptives aus der Gesamtstichprobe
subset(coercion, select = c('drive', 'sadi', 'maso', 'f1', 'coerce')) |>
  describe()

# Deskriptives getrennt nach Geschlecht
subset(coercion, select = c('drive', 'sadi', 'maso', 'f1', 'coerce')) |>
  describeBy(coercion$sex)

# t-Test für coerce
t.test(coercion$coerce ~ coercion$sex, var.equal = TRUE)

# Cohen's d
cohen.d(coercion$coerce, coercion$sex)$cohen.d

# Teildatensätze
males <- subset(coercion, sex == 'Male')
females <- subset(coercion, sex == 'Female') 

# Multiple Regression
mod0m <- lm(coerce ~ drive + f1, data = males)
mod0f <- lm(coerce ~ drive + f1, data = females)

# Ergebnisse für Probanden
summary(mod0m)



# Paket laden
library(lm.beta)

# Standardisierte Regressionsgewichte
lm.beta(mod0m) |> summary()

# Paket laden
library(car)

# Varianzinflation
vif(mod0m)

# Moderierte Regression
mod1m <- lm(coerce ~ drive + f1 + drive:f1, males)

# Varianzinflation
vif(mod1m)

# Korrelation bei positiver Skala
x <- 1:5
z <- x * x
cor(x, z)

# Korrelation nach Zentrierung
x <- -2:2
z <- x * x
cor(x, z)

# Zentrierung
males$drive_c <- scale(males$drive, scale = FALSE)
males$f1_c <- scale(males$f1, scale = FALSE)

# Moderierte Regression
mod1m_c <- lm(coerce ~ drive_c + f1_c + drive_c:f1_c, males)

# Varianzinflation
vif(mod1m_c)

# Ergebnisse für Probanden
summary(mod1m_c)


# car-Paket laden
library(car)

# Normalverteilung der Residuen
qqPlot(mod1m_c)

# Homoskedastizität der Residuen
plot(mod1m_c, which = 3)

# Breusch-Pagan-Test
ncvTest(mod1m_c)

# Paket laden
library(sandwich)
library(lmtest)

# Ergebnisse mit robusten Standardfehlern
coeftest(mod1m_c, vcov = vcovHC)


# Konfidenzintervalle
coefci(mod1m_c, vcov = vcovHC)

# Modellvergleich
waldtest(mod1m_c, vcov = vcovHC)

# Standardabweichung von f1
sd(males$f1)


# Paket laden
library(interactions)

# Simple Slopes
sim_slopes(mod1m_c, pred = drive_c, modx = f1_c, robust = 'HC3')

# Grafische Darstellung
interact_plot(mod1m_c, pred = drive_c, modx = f1_c, robust = 'HC3')
