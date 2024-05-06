2 + 1

#### Wiederholung in R ----

1 + 2   # Addition

3 == 4   # Logische Abfrage auf Gleichheit

sum(1, 2) # Addition durch Funktion

log(x = 23, base = 10) # Benennung von Argumenten

## ?log

#### Objekte ----
my_num <- sum(3, 4, 1, 2) # Objekt zuweisen

my_num # Objekt anzeigen

sqrt(my_num) # Objekt in Funktion einbinden

sqrt(sum(3, 4, 1, 2)) # Verschachtelte Funktionen

sum(3, 4, 1, 2) |> sqrt() # Nutzung Pipe

my_vec <- c(1, 2, 3, 4) # Erstellung Vektor

## load("C:/Users/Musterfrau/Desktop/Depression.rda")

load(url("https://pandar.netlify.app/daten/Depression.rda"))

head(Depression) # ersten 6 Zeilen

names(Depression) # Namen der Variablen

dim(Depression) # Anzahl der Zeilen und Spalten 

str(Depression) # Informationen zu Variablentypen

is.factor(Depression$Geschlecht)

levels(Depression$Geschlecht)

levels(Depression$Geschlecht) <- c("maennlich", "weiblich")

Depression$Depressivitaet[5] # Extrahieren

Depression$Depressivitaet[c(1, 3:5)] # Mehrfach Extrahieren

Depression[c(1:2), c(1:2)] # Extrahieren aus Matrix

Depression[1, ]   # 1. Zeile, alle Spalten

Depression[5, 6]           # Aktuellen Inhalt abfragen
Depression[5, 6] <- "maennlich"    # Aktuellen Inhalt überschreiben
Depression[, 6]                    # Alle Geschlechter abfragen

mean(Depression$Depressivitaet) # Mittwelert
var(Depression$Depressivitaet) # Varianz

summary(Depression$Depressivitaet) # Zusammenfassung numerisch
summary(Depression$Geschlecht) # Zusammenfassung factor

## colMeans(Depression[1:4]) # Spaltenmittelwerte

plot(Depression$Lebenszufriedenheit, Depression$Depressivitaet, xlab = "Lebenszufriedenheit", ylab = "Depressivitaet")

lm(Depressivitaet ~ Lebenszufriedenheit, Depression) # lineare Regression

model <- lm(Depressivitaet ~ Lebenszufriedenheit, Depression) # Objektzuweisung

summary(model)

names(model) #andere Inhalte der Liste



t.test(Depressivitaet ~ Geschlecht,  # abhängige Variable ~ unabhängige Variable
       data = Depression, # Datensatz
       paired = FALSE, # Stichproben sind unabhängig 
      alternative = "two.sided",        # zweiseitige Testung (Default)
      var.equal = TRUE,                 # Homoskedastizität liegt vor (-> Levene-Test)
      conf.level = .95)                 # alpha = .05 (Default)







ttest <- t.test(Depressivitaet ~ Geschlecht,  # abhängige Variable ~ unabhängige Variable
       data = Depression, # Datensatz
       paired = FALSE, # Stichproben sind unabhängig 
      alternative = "two.sided",        # zweiseitige Testung (Default)
      var.equal = TRUE,                 # Homoskedastizität liegt vor (-> Levene-Test)
      conf.level = .95)                 # alpha = .05 (Default)
names(ttest)    # alle möglichen Argumente, die wir diesem Objekt entlocken können
ttest$statistic # (empirischer) t-Wert
ttest$p.value   # zugehöriger p-Wert















set.seed(1234567) # für Replizierbarkeit (bei gleicher R Version, kommen Sie mit diesem Seed zum selben Ergebnis!)
group1 <- rnorm(n = 1000, mean = 0, sd = 1) # Standardnormalverteilung mit n = 1000
hist(group1)
mean(group1)
sd(group1)

# Simulation der zweiten Stichprobe
set.seed(2)
group2 <- rnorm(n = 1000, mean = 0, sd = 1)
ttest <- t.test(group1, group2, var.equal = T)
ttest # Vergleich zwischen den beiden Stichproben

ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
    group1 <- rnorm(n = 1000, mean = 0, sd = 1)
    group2 <- rnorm(n = 1000, mean = 0, sd = 1)
    ttest <- t.test(group1, group2, var.equal = T)
    ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
    ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "(empirische) t-Werte nach 10000 Replikationen unter H0", xlab = expression("t"[emp]), freq = F)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter), lwd = 3)
hist(ps, main = "p-Werte nach 10000 Replikationen unter H0", xlab = "p", freq = F)
abline(a = 1, b = 0, lwd = 3)

ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
    group1 <- rnorm(n = 1000, mean = 0, sd = 1)
    group2 <- -0.1 + rnorm(n = 1000, mean = 0, sd = 1) # Mittelwertsdifferenz ist 0.1
    ttest <- t.test(group1, group2, var.equal = T)
    ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
    ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "(empirische) t-Werte nach 10000 Replikationen unter H1", xlab = expression("t"[emp]), freq = F)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter), lwd = 3)
hist(ps, main = "p-Werte nach 10000 Replikationen unter H1", xlab = "p", freq = F)
abline(a = 1, b = 0, lwd = 3)

set.seed(1)
par(mfrow = c(1,2))

group1 <- -rexp(1000, 1)
group1 <- group1 + 1
group2 <- rexp(1000, 2)
group2 <- group2 - 1/2
hist(group1); hist(group2)

set.seed(1)
ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
       group1 <- -rexp(n = 5, rate = 1) # simuliere Exponentialverteilung zur Rate 1 mit n = 5
        group1 <- group1 + 1 # zentriere, sodass der Populationsmittelwert wieder 0 ist
        group2 <- rexp(n = 5, rate = 2) # simuliere Exponentialverteilung zur Rate 2 mit n = 5
        group2 <- group2 - 1/2 # zentriere, sodass der Populationsmittelwert wieder 0 ist
        ttest <- t.test(group1, group2, var.equal = T)
        ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
        ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "t-Werte nach 10000 Replikationen unter Modellverstöße\n für kleine Stichproben", xlab = expression("t"[emp]), freq = F, breaks = 50)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter), lwd = 3)
hist(ps, main = "p-Werte nach 10000 Replikationen unter Modellverstößen\n für kleine Stichproben", xlab = "p", freq = F)
abline(a = 1, b = 0, lwd = 3)

set.seed(1)
ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
        group1 <- -rexp(n = 5, rate = 1) # simuliere Exponentialverteilung zur Rate 1 mit n = 5
        group1 <- group1 + 1 # zentriere, sodass der Populationsmittelwert wieder 0 ist
        group2 <- rexp(n = 5, rate = 2) # simuliere Exponentialverteilung zur Rate 2 mit n = 5
        group2 <- group2 - 1/2 # zentriere, sodass der Populationsmittelwert wieder 0 ist
        ttest <- t.test(group1, group2) # Welch Test
        ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
        ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "t-Werte (des Welch t-Tests) nach 10000 Replikationen\n unter Modellverstöße für kleine Stichproben", xlab = expression("t"[emp]), freq = F)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter), lwd = 3)
hist(ps, main = "p-Werte (des Welch t-Tests) nach 10000 Replikationen\n unter Modellverstößen für kleine Stichproben", xlab = "p", freq = F)
abline(a = 1, b = 0, lwd = 3)

set.seed(1234)
ts <- c(); ps <- c() # wir brauchen zunächst Vektoren, in die wir die t-Werte und die p-Werte hineinschreiben können
for(i in 1:10000)
{
        group1 <- -rexp(n = 100, rate = 1) # simuliere Exponentialverteilung zur Rate 1 mit n = 100
        group1 <- group1 + 1 # zentriere, sodass der Populationsmittelwert wieder 0 ist
        group2 <- rexp(n = 100, rate = 2) # simuliere Exponentialverteilung zur Rate 2 mit n = 100
        group2 <- group2 - 1/2 # zentriere, sodass der Populationsmittelwert wieder 0 ist
        ttest <- t.test(group1, group2) # Welch Test
        ts <- c(ts, ttest$statistic) # nehme den Vektor ts und verlängere ihn um den neuen t-Wert
        ps <- c(ps, ttest$p.value)   # nehme den Vektor ps und verlängere ihn um den neuen p-Wert
}

hist(ts, main = "t-Werte (des Welch t-Tests) nach 10000 Replikationen\n unter Modellverstöße für größere Stichproben", xlab = expression("t"[emp]), freq = F)
lines(x = seq(-4,4,0.01), dt(x = seq(-4,4,0.01), df = ttest$parameter), lwd = 3)
hist(ps, main = "p-Werte (des Welch t-Tests) nach 10000 Replikationen\n unter Modellverstößen für größere Stichproben", xlab = "p", freq = F)
abline(a = 1, b = 0, lwd = 3)
