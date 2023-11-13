# Datensatz laden
load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))

##### Aufstellen der Modelle ----

m.c <- lm(math ~ reading + female, data = Schulleistungen)      # constrained
m.u <- lm(math ~ reading + female + IQ, data = Schulleistungen) # unconstrained
summary(m.c)
summary(m.u)

# Inkrement = Differenz in R2 aus restringiertem Modell 2 minus R2 aus unrestringiertem Modell 1
summary(m.u)$r.squared - summary(m.c)$r.squared

# Modellvergleich mit der anova-Funktion
anova(m.c, m.u)
# Man erhält einen signifikanten p-Wert, Modell 1 ohne IQ, Modell 2 unter Zunahme von IQ

# Berechnung von F per Hand über die Formel

R2.u <- summary(m.u)$r.squared
R2.c <- summary(m.c)$r.squared
df.diff <- summary(m.u)$df[1] - summary(m.c)$df[1] # Änderung in den df
df.e <- summary(m.u)$df[2] # Fehlerfreiheitsgrade des uneingeschränkten Modells
F.diff <- ((R2.u - R2.c) / df.diff) /
  ((1 - R2.u) / df.e)
p.diff <- 1-pf(F.diff, df.diff, df.e)
F.diff # F-Wert der Differenz in R^2
p.diff # zugehöriger p-Wert  

# Darstellung, das Rechnung auch mit Semipartialisierung umsetzbar ist (Quadrierte Korrelation zwischen Mathe und IQ, Leseleistung und Geschlecht rauspartialisiert)

R2.u - R2.c # Inkrement
library(ppcor)
sp <- spcor.test(x = Schulleistungen$math, y = Schulleistungen$IQ, z = Schulleistungen[, c("reading", "female")])
sp$estimate^2 # ebenfalls Inkrement!

#### Testen des Dekrements ----

m.u <- lm(math ~ reading + female + IQ, data = Schulleistungen) # unconstrained
m.c <- lm(math ~ reading + IQ, data = Schulleistungen) # constrained

summary(m.u)$r.squared - summary(m.c)$r.squared
# Modellvergleich mit der anova-Funktion
anova(m.c, m.u)

# Modelloptimierung über lm mit Package "olsrr"
# install.packages("olsrr")
library(olsrr)

#### Iterative Modelloptimierung ----
# Modell mit allen Prädiktoren
m <- lm(math ~ reading + female + IQ, data = Schulleistungen)

# Anwendung der iterativen Modellbildung
ols_step_both_p(m, pent = .05, prem = .10, details = TRUE)

# Optimierung des Modells nach AIC
summary(step(m, direction = "both"))

# Output der summary, Wert von AIC für Alle

out <- summary(step(m)) |> capture.output()
begin <- "Start"; end <- "Df"
out[grep(pattern = begin, out):(grep(pattern = end, out)-1)] |> paste(collapse = "\n") |> cat()

# Darstellung der Modelle

begin <- "Df"; end <- "Step"
out[grep(pattern = begin, out):(grep(pattern = end, out)-1)] |> paste(collapse = "\n") |> cat()

# Darstellung der nächsten Modelle, nachdem Leseleistung ausgeschlossen wurde; Ende bereits erreicht (minimale AIC)

begin <- "Step"; end <- "Call"
out[grep(pattern = begin, out):(grep(pattern = end, out)-1)] |> paste(collapse = "\n") |> cat()

# Optimierung mit BIC
summary(step(m, direction = "both", k=log(nrow(Schulleistungen))))
# Da BIC strenger in der Sparsamkeit ist, wird auch Geschlecht entfernt

# Vergleich des AIC in step und ols_step_both_p, liegt an Unterschied der AIC-Funktionen, bei denen step Konstanten entfernt
model <- lm(math ~ reading + female, data = Schulleistungen)
AIC(model)
extractAIC(model) # erstes Argument ist die Anzahl der Parameter (p)
