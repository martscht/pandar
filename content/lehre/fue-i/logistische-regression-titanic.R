## load("C:/Users/Musterfrau/Desktop/Titanic.rda")

#load(url("https://pandar.netlify.app/daten/Titanic.rda"))
load(url("https://courageous-donut-84b9e9.netlify.app/post/Titanic.rda"))

head(Titanic)
dim(Titanic) # Dimensionen des Datensatzes

Münze <- c(0, 1, 0, 0)
mean(Münze)

library(lm.beta) # std. Koeffizienten
reg_model <- lm(survived ~ 1 + age, data = Titanic)
summary(lm.beta(reg_model))

library(car) # nötiges Paket laden

avPlots(model = reg_model, pch = 16)
residualPlots(model = reg_model, pch = 16)

library(MASS)# nötiges Paket laden
res <- studres(reg_model) # Studentisierte Residuen als Objekt speichern
hist(res, freq = F)
xWerte <- seq(from = min(res), to = max(res), by = 0.01)
lines(x = xWerte, y = dnorm(x = xWerte, mean = mean(res), sd = sd(res)), lwd = 3)

m1 <- glm(survived ~ 1 + age, family = "binomial", data = Titanic)
summary(m1)

cat('
 Call:
 glm(formula = survived ~ 1 + age, family = "binomial", data = Titanic)

 Deviance Residuals: 
     Min       1Q   Median       3Q      Max  
 -1.1488  -1.0361  -0.9544   1.3159   1.5908')

cat('
 Coefficients:
              Estimate Std. Error z value Pr(>|z|)
 (Intercept) -0.05672    0.17358  -0.327   0.7438  
 age         -0.01096    0.00533  -2.057   0.0397 *
 ---
 Signif. codes:  0 \'***\' 0.001 \'**\' 0.01 \'*\' 0.05 \'.\' 0.1 \' \' 1')

cat('     Null deviance: 964.52  on 713  degrees of freedom
 Residual deviance: 960.23  on 712  degrees of freedom
 AIC: 964.23

 Number of Fisher Scoring iterations: 4')

AltersWerte <- seq(-500, 500, 0.1)
logit <- m1$coefficients[1] + m1$coefficients[2]*AltersWerte 
plot(x = AltersWerte, y = logit, type = "l", col = "blue", lwd = 3)

odds <- exp(logit)
plot(x = AltersWerte, y = odds, type = "l", col = "blue", lwd = 3)

p <- odds/(1 + odds)
plot(x = AltersWerte, y = p, type = "l", col = "blue", lwd = 3)

is.factor(Titanic$sex)

table(Titanic$survived, Titanic$sex)

m2 <-  glm(survived ~ 1 + age + sex, family = "binomial", data = Titanic)
summary(m2)

cat(' Coefficients:
              Estimate Std. Error z value Pr(>|z|)
 (Intercept) -1.188647   0.222432  -5.344  9.1e-08 ***
 age         -0.005426   0.006310  -0.860     0.39    
 sex1         2.465920   0.185384  13.302  < 2e-16 ***')

Titanic$sex
levels(Titanic$sex)

exp(m2$coefficients) # Odds-Ratios

library(ggplot2)

logit_m2 <- predict(m2)           # Logit unter Modell m2 bestimmen
odds_m2 <- exp(logit_m2)          # Logit unter Modell m2 in Odds transformieren
p_m2 <- odds_m2/(1 + odds_m2)     # Odds in Wahrscheinlichkeiten transformieren
  
# dem Datensatz anhängen:
Titanic$logit_m2 <- logit_m2
Titanic$odds_m2 <- odds_m2
Titanic$p_m2 <- p_m2

head(Titanic)

knitr::kable(head(Titanic))

ggplot(data = Titanic, mapping = aes(x = age, y = logit_m2, col = sex)) +
        geom_line(lwd = 2) +
        ggtitle("Logit vs Age and Sex")

ggplot(data = Titanic, mapping = aes(x = age, y = odds_m2, col = sex)) +
        geom_line(lwd = 2) +
        ggtitle("Odds vs Age and Sex")

ggplot(data = Titanic, mapping = aes(x = age, y = p_m2, col = sex)) +
        geom_line(lwd = 2) +
        ggtitle("P vs Age and Sex")

levels(Titanic$pclass)

m3 <-  glm(survived ~ 1 + age + sex + pclass, family = "binomial", data = Titanic)
summary(m3)

anova(m2, m3, test = "LRT")

exp(m3$coefficients) # Odds-Ratio

logit_m3 <- predict(m3)           # Logit unter Modell m3 bestimmen
odds_m3 <- exp(logit_m3)          # Logit unter Modell m3 in Odds transformieren
p_m3 <- odds_m3/(1 + odds_m3)     # Odds in Wahrscheinlichkeiten transformieren
  
# dem Datensatz anhängen:
Titanic$logit_m3 <- logit_m3
Titanic$odds_m3 <- odds_m3
Titanic$p_m3 <- p_m3

head(Titanic)

knitr::kable(head(Titanic))

ggplot(data = Titanic, mapping = aes(x = age, y = logit_m3, col = pclass, lty = sex)) +
     geom_line(lwd = 1) +
     ggtitle("Logit vs Age, Sex and Class")

ggplot(data = Titanic, mapping = aes(x = age, y = odds_m3, col = pclass, lty = sex)) +
     geom_line(lwd = 1) +
     ggtitle("Odds vs Age, Sex and Class")

ggplot(data = Titanic, mapping = aes(x = age, y = p_m3, col = pclass, lty = sex)) +
     geom_line(lwd = 1) +
     ggtitle("P vs Age, Sex and Class")

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
