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
## # NA-Werte ersetzen
## data <- data %>%
##   mutate(across(where(is.numeric), ~ na_if(.x, -9)))
## # Skalenwerte erstellen
## data <- data %>%
##   mutate(Total_Competence = rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")]))
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
# NA-Werte ersetzen
data <- data %>%
  mutate(across(where(is.numeric), ~ na_if(.x, -9)))
# Skalenwerte erstellen
data <- data %>%
  mutate(Total_Competence = rowMeans(data[,c("Total_Competence_Maths", "Total_Competence_English", "Total_Competence_Science")]))
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

gender_freq <- table(data$Gender)
barplot(gender_freq)

barplot(table(data$Gender), 
        main = "Geschlechtshäufigkeiten", 
        xlab = "Geschlecht", 
        ylab = "Absolute Häufigkeit")

boxplot(data$Total_Competence_Science, 
        main = "Boxplot der Kompetenz in Naturwissenschaften", 
        ylab = "Skalenscore")

boxplot(data$Total_Competence_Science, 
        main = "Boxplot der Kompetenz in Naturwissenschaften", 
        ylab = "Skalenscore",
        col = "blue",
        border = "red")

terrain.colors(2)

terrain.colors(2)[1]

boxplot(data$Total_Competence_Science, 
        main = "Boxplot der Kompetenz in Naturwissenschaften", 
        ylab = "Skalenscore",
        col = terrain.colors(2)[2],
        border = terrain.colors(2)[1])

hist(data$Total_SelfConcept_Maths, 
     main = "Histogramm des Selbstkonzepts in Mathematik", 
     xlab = "Selbstkonzept Mathematik", 
     ylab = "Absolute Häufigkeit")

hist(data$Total_SelfConcept_Maths, 
     main = "Histogramm des Selbstkonzepts in Mathematik", 
     xlab = "Selbstkonzept Mathematik", 
     ylab = "Absolute Häufigkeit",
     breaks = 10)

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
abline(h = 6)

aggregate(Total_SelfEsteem ~ Achiever, data = data, FUN = mean)

lm(formula = Maths_AttainmentData ~ 1 + Total_SelfConcept_Maths, data = data)

lm(Maths_AttainmentData ~ Total_SelfConcept_Maths, data = data)

mod <- lm(Maths_AttainmentData ~ Total_SelfConcept_Maths, data = data)

class(mod)

mod$coefficients
mod$call

summary(mod)

summary(data)

coef(mod)

plot(x = data$Total_SelfConcept_Maths, 
     y = data$Maths_AttainmentData, 
     main = "Scatterplot Mathematikleistung und Selbstkonzept",
     xlab = "Selbstkonzept Mathematik",
     ylab = "Mathematikleistung")
abline(mod)

mod_kont <- lm(Maths_AttainmentData ~ Total_SelfConcept_Maths + Total_Competence_Maths, data = data)

class(mod_kont)
summary(mod_kont)

mod_kat <- lm(Maths_AttainmentData ~ Total_SelfConcept_Maths + Total_Competence_Maths + Gender, data = data)
summary(mod_kat)

data$Total_SelfConcept_Maths_center <- scale(data$Total_SelfConcept_Maths, scale = F, center = T)
data$Total_Competence_Maths_center <- scale(data$Total_Competence_Maths, scale = F, center = T)

mean(data$Total_SelfConcept_Maths_center, na.rm = TRUE)
mean(data$Total_Competence_Maths_center, na.rm = TRUE)

mod_inter <- lm(Maths_AttainmentData ~ Total_SelfConcept_Maths_center + Total_Competence_Maths_center + Total_SelfConcept_Maths_center * Total_Competence_Maths_center, data = data)

mod_inter <- lm(Maths_AttainmentData ~ Total_SelfConcept_Maths_center * Total_Competence_Maths_center, data = data)


mod_inter <- lm(Maths_AttainmentData ~ Total_SelfConcept_Maths_center + Total_Competence_Maths_center + Total_SelfConcept_Maths_center:Total_Competence_Maths_center, data = data)
