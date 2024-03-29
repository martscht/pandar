# Vorbereitungen
knitr::opts_chunk$set(echo = TRUE, fig.align = "center")
library(ggplot2) # ggplot2 und dplyr werden nur für Grafiken benötigt

## install.packages("haven")
## library(haven)
## osf <- read_sav("C:/Users/Musterfrau/Desktop/Raw SubdataSet.sav")

library(haven)
osf <- read_sav(file = url("https://osf.io/prc92/download"))

names(osf)  # Variablennamen im Datensatz
dim(osf)    # Dimensionen des Datensatzes

missings_id <- which(is.na(osf$ANYDUMMY) |
                        is.na(osf$GENDER_R) |
                        is.na(osf$Depression_lvl))
length(missings_id)

osf <- osf[-missings_id, ]
dim(osf) # nach Fallausschluss

osf$GENDER_R <- as.factor(osf$GENDER_R)
levels(osf$GENDER_R) <- c("weiblich", "maennlich")

reg_model <- lm(ANYDUMMY ~ 1 + Depression_lvl, data = osf)
summary(reg_model)

library(car) # nötiges Paket laden
avPlots(model = reg_model, pch = 16)

library(MASS)# nötiges Paket laden
res <- studres(reg_model) # Studentisierte Residuen als Objekt speichern
hist(res, freq = F)
xWerte <- seq(from = min(res), to = max(res), by = 0.01)
lines(x = xWerte, y = dnorm(x = xWerte, mean = mean(res), sd = sd(res)), lwd = 3)

glm_model <- glm(ANYDUMMY ~ 1 + Depression_lvl, family = "binomial", data = osf)
summary(glm_model)

output <- capture.output(summary(glm_model))

cat(paste(output[1:4], collapse = "\n"))

cat(paste(output[6:13], collapse = "\n"))

cat(paste(output[15:19], collapse = "\n"))

## install.packages("lmtest")
## library(lmtest)

library(lmtest)

## lrtest(glm_model)

glm_model0 <- glm(ANYDUMMY ~ 1, data = osf)
lrtest(glm_model, glm_model0)

Depressionswerte <- seq(-20, 60, 0.1)
logit <- glm_model$coefficients[1] + glm_model$coefficients[2]*Depressionswerte 
plot(x = Depressionswerte, y = logit, type = "l", col = "blue", lwd = 3)

odds <- exp(logit)
plot(x = Depressionswerte, y = odds, type = "l", col = "blue", lwd = 3)

p <- odds/(1 + odds)
plot(x = Depressionswerte, y = p, type = "l", col = "blue", lwd = 3)

table(osf$GENDER_R, osf$ANYDUMMY)

glm_model2 <-  glm(ANYDUMMY ~ 1 + Depression_lvl + GENDER_R, family = "binomial", data = osf)
summary(glm_model2)

output <- capture.output(summary(glm_model2))
cat(paste(output[9:19], collapse = "\n"))

exp(glm_model2$coefficients) # Odds-Ratios

logit_glm2 <- predict(glm_model2)           # Logit unter Modell m2 bestimmen
odds_glm2 <- exp(logit_glm2)          # Logit unter Modell m2 in Odds transformieren
p_glm2 <- odds_glm2/(1 + odds_glm2)     # Odds in Wahrscheinlichkeiten transformieren
  
# dem Datensatz anhängen:
osf$logit_glm2 <- logit_glm2
osf$odds_glm2 <- odds_glm2
osf$p_glm2 <- p_glm2

library(ggplot2)
ggplot(data = osf, mapping = aes(x = Depression_lvl,
                                 y = logit_glm2,
                                 col = GENDER_R)) +
  geom_line(lwd = 2) +
  ggtitle("Logit vs Depression and Sex") +
  xlab("Depressionsscore") + 
  ylab("Logit")

ggplot(data = osf, mapping = aes(x = Depression_lvl,
                                 y = odds_glm2, 
                                 col = GENDER_R)) +
  geom_line(lwd = 2) +
  ggtitle("Odds vs Depression and Sex")+
  xlab("Depressionsscore") + 
  ylab("Odds")

ggplot(data = osf, mapping = aes(x = Depression_lvl, 
                                 y = p_glm2, 
                                 col = GENDER_R)) +
  geom_line(lwd = 2) +
  ggtitle("P vs Depression and Sex") +  
  xlab("Depressionsscore") + 
  ylab("P")

## lrtest(glm_model2)

lrtest(glm_model2, glm_model0)

lrtest(glm_model, glm_model2)

Logistic_functions <- function(beta0 = 0, beta1 = 1)
{
        par(mfrow=c(2,2)) # 4 Grafiken in einer

        xWerte <- seq(-5, 5, 0.1)
        logit <- beta0 + beta1*xWerte
        plot(x = xWerte, y = logit, type = "l", col = "blue", lwd = 3, main = "Logit vs X", xlab = "X")
        lines(xWerte, xWerte, col = "skyblue")
        abline(h = 0, lty = 3); abline(v = 0, lty = 3)

        odds <- exp(logit)
        plot(x = xWerte, y = odds, type = "l", col = "blue", lwd = 3, main = "Odds vs X", xlab = "X")
        abline(h = 0, lty = 3); abline(v = 0, lty = 3)
        lines(xWerte, exp(xWerte), col = "skyblue")



        p <- odds/(1 + odds)
        plot(x = xWerte, y = p, type = "l", col = "blue", lwd = 3, main = "P vs X", ylim = c(0,1), xlab = "X")
        lines(xWerte, exp(xWerte)/(1 + exp(xWerte)), col = "skyblue")
        abline(h = 0, lty = 3); abline(v = 0, lty = 3)

        set.seed(1234) # Vergleichbarkeit
        Y <- rbinom(n = length(xWerte), size = 1, prob = p)
        plot(x = xWerte, y = p, type = "l", col = "blue", lwd = 3, main = "P vs X und zufällige Realisierungen",
             ylim = c(0,1), xlab = "X", ylab = "P und Y")
        abline(h = 0, lty = 3); abline(v = 0, lty = 3)
        points(x = xWerte, y = Y, pch = 16, cex = .5, col = "red")
}

Logistic_functions(beta0 = 1, beta1 = -.5)

library(car) # nötiges Paket laden
avPlots(model = reg_model, pch = 16)

library(MASS)# nötiges Paket laden
res <- studres(reg_model) # Studentisierte Residuen als Objekt speichern
hist(res, freq = F)
xWerte <- seq(from = min(res), to = max(res), by = 0.01)
lines(x = xWerte, y = dnorm(x = xWerte, mean = mean(res), sd = sd(res)), lwd = 3)

library(ggplot2)

logit_glm2 <- predict(glm_model2)           # Logit unter Modell glm2 bestimmen
odds_glm2 <- exp(logit_glm2)          # Logit unter Modell glm2 in Odds transformieren
p_glm2 <- odds_glm2/(1 + odds_glm2)     # Odds in Wahrscheinlichkeiten transformieren
  
# dem Datensatz anhängen:
osf$logit_glm2 <- logit_glm2
osf$odds_glm2 <- odds_glm2
osf$p_glm2 <- p_glm2

ggplot(data = osf, mapping = aes(x =
                                   as.numeric(Depression_lvl),
                                 y = logit_glm2, col =
                                   GENDER_R)) +
  geom_line(lwd = 2) +
  ggtitle("Logit vs Depression and Sex") +
  xlab("Depressionsscore") + 
  ylab("Logit")

ggplot(data = osf, mapping = aes(x = Depression_lvl,
                                 y = odds_glm2, 
                                 col = GENDER_R)) +
  geom_line(lwd = 2) +
  ggtitle("Odds vs Depression and Sex")+
  xlab("Depressionsscore") + 
  ylab("Odds")

ggplot(data = osf, mapping = aes(x = Depression_lvl, 
                                 y = p_glm2, 
                                 col = GENDER_R)) +
  geom_line(lwd = 2) +
  ggtitle("P vs Depression and Sex") +  
  xlab("Depressionsscore") + 
  ylab("Logit")
