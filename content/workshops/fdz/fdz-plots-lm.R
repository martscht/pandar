library(knitr)

## # Paket einladen
## library(readxl)
## library(dplyr)
## library(forcats)
## # Pfad setzen
## rstudioapi::getActiveDocumentContext()$path |>
##   dirname() |>
##   setwd()
## # Daten einladen
## data <- read_excel("Pennington_2021.xlsx", sheet = "Study_Data")
## # Faktoren erstellen
## data$Gender <- factor(data$Gender,
##                          levels = c(1, 2),
##                          labels = c("weiblich", "männlich"))
## data$Year <- as.factor(data$Year)
## # Faktoren Rekodieren
## data$Year <- fct_recode(data$Year,
##                         "7. Schuljahr" = "Year7",
##                         "8. Schuljahr" = "Year8")
## data$Ethnicity <- as.factor(data$Ethnicity)
## # NA-Werte ersetzen
## data <- data %>%
##   mutate(across(where(is.numeric), ~ na_if(.x, -9)))
## # Skalenwerte erstellen
## data <- data %>%
##   mutate(Total_Competence = rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")]))
## data$Total_SelfConcept <- rowMeans(data[, c("Total_SelfConcept_Maths", "Total_SelfConcept_Science", "Total_SelfConcept_English")])
## # Gruppierungsvariablen erstellen
## data <- data %>%
##   mutate(Achiever = case_when(
##     Total_Competence_Maths >= 4 &
##     Total_Competence_English >= 4 &
##     Total_Competence_Science >= 4 ~ "High Achiever",
## 
##     Total_Competence_Maths == 1 &
##     Total_Competence_English == 1 &
##     Total_Competence_Science == 1 ~ "Low Achiever",
## 
##     TRUE ~ "Medium Achiever"  # Alle anderen Fälle
##   ))
## data <- data %>%
##   mutate(Career_Recommendation = case_when(
##     Maths_AttainmentData > 10 |
##     Science_AttainmentData > 10 |
##     Eng_AttainmentData > 10 |
##     Computing_AttainmentData > 10 ~ "Empfohlen",
## 
##     TRUE ~ "Nicht empfohlen"
##   ))  # Erstellen der neuen Variable

# Paket einladen
library(readxl)
library(dplyr)
library(forcats)
# Daten einladen
source("https://pandar.netlify.app/workshops/fdz/fdz_data_prep.R")
# Faktoren erstellen
data$Gender <- factor(data$Gender, 
                         levels = c(1, 2),
                         labels = c("weiblich", "männlich"))
data$Year <- as.factor(data$Year)
# Faktoren Rekodieren
data$Year <- fct_recode(data$Year, 
                        "7. Schuljahr" = "Year7",
                        "8. Schuljahr" = "Year8")
data$Ethnicity <- as.factor(data$Ethnicity)
# NA-Werte ersetzen
data <- data %>%
  mutate(across(where(is.numeric), ~ na_if(.x, -9)))
# Skalenwerte erstellen
data <- data %>%
  mutate(Total_Competence = rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")]))
data$Total_SelfConcept <- rowMeans(data[, c("Total_SelfConcept_Maths", "Total_SelfConcept_Science", "Total_SelfConcept_English")])
# Gruppierungsvariablen erstellen
data <- data %>%
  mutate(Achiever = case_when(
    Total_Competence_Maths >= 4 & 
    Total_Competence_English >= 4 & 
    Total_Competence_Science >= 4 ~ "High Achiever",
    
    Total_Competence_Maths == 1 & 
    Total_Competence_English == 1 & 
    Total_Competence_Science == 1 ~ "Low Achiever",
    
    TRUE ~ "Medium Achiever"  # Alle anderen Fälle
  ))
data <- data %>%
  mutate(Career_Recommendation = case_when(
    Maths_AttainmentData > 10 |
    Science_AttainmentData > 10 |
    Eng_AttainmentData > 10 |
    Computing_AttainmentData > 10 ~ "Empfohlen",
    
    TRUE ~ "Nicht empfohlen"
  ))  # Erstellen der neuen Variable

#### Grafikerstellung ----
gender_freq <- table(data$Gender)  # absolute Häufigkeiten in Objekt ablegen
barplot(gender_freq)  # Balkendiagramm erstellen

barplot(table(data$Gender), 
        main = "Geschlechtshäufigkeiten", 
        xlab = "Geschlecht", 
        ylab = "Absolute Häufigkeit")

# Erstellung eines Boxplots mit passender Beschriftung
boxplot(data$Total_Competence_Science, 
        main = "Boxplot der Kompetenz in Naturwissenschaften", 
        ylab = "Skalenscore")

# Erstellung eines Boxplots mit passender Beschriftung und Farbgebung
boxplot(data$Total_Competence_Science, 
        main = "Boxplot der Kompetenz in Naturwissenschaften", 
        ylab = "Skalenscore",
        col = "blue",
        border = "red")

terrain.colors(2)   # Farben aus einer Palette abrufen

terrain.colors(2)[1]  # Erste Farbe aus den zwei abgerufenen Farben aus der Palette

# Erstellung eines Boxplots mit passender Beschriftung und Farbgebung der Palette
boxplot(data$Total_Competence_Science, 
        main = "Boxplot der Kompetenz in Naturwissenschaften", 
        ylab = "Skalenscore",
        col = terrain.colors(2)[2],
        border = terrain.colors(2)[1])

# Erstellung eines Histogramms mit passender Beschriftung
hist(data$Total_SelfConcept_Maths, 
     main = "Histogramm des Selbstkonzepts in Mathematik", 
     xlab = "Selbstkonzept Mathematik", 
     ylab = "Absolute Häufigkeit")

# Erstellung eines Histogramms mit passender Beschriftung und gewünschter Anzahl an Klassen
hist(data$Total_SelfConcept_Maths, 
     main = "Histogramm des Selbstkonzepts in Mathematik", 
     xlab = "Selbstkonzept Mathematik", 
     ylab = "Absolute Häufigkeit",
     breaks = 10)

# Erstellung eines Scatterplots mit passender Beschriftung
plot(x = data$Total_SelfConcept_Maths, 
     y = data$Maths_AttainmentData, 
     main = "Scatterplot Mathematikleistung und Selbstkonzept",
     xlab = "Selbstkonzept Mathematik",
     ylab = "Mathematikleistung")

plot(x = data$Total_SelfConcept_Maths, 
     y = data$Maths_AttainmentData, 
     main = "Scatterplot Mathematikleistung und Selbstkonzept",
     xlab = "Selbstkonzept Mathematik",
     ylab = "Mathematikleistung")
abline(h = 6) # Horizontale Linie bei 6 einfügen

# Berechnung des Mittelwerts der Selbstkonzeptwerte in Abhängigkeit der Gruppierung nach Achiever
aggregate(Total_SelfEsteem ~ Achiever, data = data, FUN = mean)

# Einfache lineare Regression 
# Formel = abhängige Variable ~ unabhängige Variable
lm(formula = Maths_AttainmentData ~ 1 + Total_SelfConcept_Maths, data = data)

# Reduktion der Syntax
lm(Maths_AttainmentData ~ Total_SelfConcept_Maths, data = data)

# Speichern des Modells in einem Objekt
mod <- lm(Maths_AttainmentData ~ Total_SelfConcept_Maths, data = data)

class(mod)  # Klasse des Objekts

mod$coefficients  # Koeffizienten der Regression
mod$call          # Aufruf der Funktion

summary(mod)    # Zusammenfassung des Modells

summary(data)   # Zusammenfassung des Datensatzes

coef(mod)     # Koeffizienten der Regression durch Funktion

# Scatterplot mit Beschriftung
plot(x = data$Total_SelfConcept_Maths, 
     y = data$Maths_AttainmentData, 
     main = "Scatterplot Mathematikleistung und Selbstkonzept",
     xlab = "Selbstkonzept Mathematik",
     ylab = "Mathematikleistung")
# Regressionsgerade einzeichnen
abline(mod)

# Multiples lineares Regressionsmodell mit zwei kontinuierlichen Prädiktoren
mod_kont <- lm(Maths_AttainmentData ~ Total_SelfConcept_Maths + Total_Competence_Maths, data = data)

class(mod_kont)       # Klasse des Objekts
summary(mod_kont)     # Zusammenfassung des Modells

# Multiples lineares Regressionsmodell mit einem kategorialen und einem kontinuierlichen Prädiktor
mod_kat <- lm(Maths_AttainmentData ~ Total_SelfConcept_Maths + Total_Competence_Maths + Gender, data = data)
summary(mod_kat)

# Zentrierung der Prädiktoren
data$Total_SelfConcept_Maths_center <- scale(data$Total_SelfConcept_Maths, scale = F, center = T)
data$Total_Competence_Maths_center <- scale(data$Total_Competence_Maths, scale = F, center = T)

# Check der Mittelwerte der Variablen
mean(data$Total_SelfConcept_Maths_center, na.rm = TRUE)
mean(data$Total_Competence_Maths_center, na.rm = TRUE)

# Multiple Regression mit Interaktionseffekt
mod_inter <- lm(Maths_AttainmentData ~ Total_SelfConcept_Maths_center + Total_Competence_Maths_center + Total_SelfConcept_Maths_center * Total_Competence_Maths_center, data = data)

# Multiple Regression mit Interaktionseffekt reduzierte Schreibweise
mod_inter <- lm(Maths_AttainmentData ~ Total_SelfConcept_Maths_center * Total_Competence_Maths_center, data = data)


# Multiple Regression mit Interaktionseffekt präzise Schreibweise
mod_inter <- lm(Maths_AttainmentData ~ Total_SelfConcept_Maths_center + Total_Competence_Maths_center + Total_SelfConcept_Maths_center:Total_Competence_Maths_center, data = data)
