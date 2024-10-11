## source('https://pandar.netlify.app/daten/Data_Processing_coercion.R')



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

# Ergebnisse für männliche Probanden
summary(mod0m)
