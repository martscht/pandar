## load("C:/Users/Musterfrau/Desktop/StudentsInClasses.rda")

## load(url("https://pandar.netlify.app/daten/StudentsInClasses.rda"))

load(url("https://github.com/jpirmer/MSc1_FEI/blob/master/data/StudentsInClasses.rda?raw=true"))

head(StudentsInClasses)

colMeans(StudentsInClasses)

library(lme4)       # für das Durchführen von Multi-Level Regressionen
library(lmerTest) # lmerTest markiert in der Ausgabe signifikante Koeffizienten und korrigiert Modellvergleiche für Varianzen
library(robumeta)   # Datensatzmanipulation
library(ggplot2) # ggplot2 und dplyr werden nur für Grafiken benötigt
library(dplyr)   # für Datensatzmanipulationen

m0 <- lmer(MatheL ~ 1 +  (1 | schulklasse), data = StudentsInClasses)
summary(m0)

cat('Linear mixed model fit by REML. t-tests use Satterthwaite\'s method [
lmerModLmerTest]
Formula: MatheL ~ 1 + (1 | schulklasse)
  Data: StudentsInClasses
')

cat('
REML criterion at convergence: 6565.3

Scaled residuals:
    Min      1Q  Median      3Q     Max
-4.5448 -0.5642 -0.0015  0.5695  3.5476
')

cat('
Random effects:
 Groups      Name        Variance Std.Dev.
 schulklasse (Intercept)  23.87    4.885
 Residual                123.12   11.096
Number of obs: 850, groups:  schulklasse, 40
')

# Per Hand
23.87 / (23.87 + 123.12)
# Mit Zugriff auf das Nullmodell-Objekt
VarCorr(m0)$schulklasse[1] / (VarCorr(m0)$schulklasse[1] + summary(m0)$sigma^2)

VarCorr(m0) # nur die Standardabweichungen (also Wurzel aus den Varianzen) werden angezeigt
VarCorr(m0)$schulklasse # auch Varianzen werden angezeigt
VarCorr(m0)$schulklasse[1] # das erste Element ist die Varianz des Interzepts

summary(m0)$sigma # Residualstandardabweichung
summary(m0)$sigma^2 # Residualvarianz

names(summary(m0)) # alle Informationen, die wir der Summary entlocken können

cat('
Fixed effects:
            Estimate Std. Error      df t value Pr(>|t|)
(Intercept)  54.0235     0.8658 37.0961    62.4   <2e-16 ***
---
Signif. codes:  0 \'***\' 0.001 \'**\' 0.01 \'*\' 0.05 \'.\' 0.1 \' \' 1')

StudentsInClasses$Motivation_c <- StudentsInClasses$Motivation - mean(StudentsInClasses$Motivation)
round(colMeans(StudentsInClasses), 10) # Spaltenmittelwerte gerundet auf 10 Nachkommastellen

m1 <- lmer(MatheL ~ 1 + Motivation_c + (1 | schulklasse), data = StudentsInClasses)
summary(m1)

VarE0 <- summary(m0)$sigma^2 # Varianz des Residuums im Nullmodell
VarE1 <- summary(m1)$sigma^2 # Varianz des Residuums im Modell mit Motivation als Prädiktor

1- VarE1/VarE0

# oder kurz:
1 - summary(m1)$sigma^2/summary(m0)$sigma^2

VarU0 <- VarCorr(m0)$schulklasse[1]  # Varianz des Interzepts im Nullmodell
VarU1 <- VarCorr(m1)$schulklasse[1]  # Varianz des Interzepts im Modell mit Motivation als Prädiktor

1- VarU1/VarU0

# oder kurz:
1 - VarCorr(m1)$schulklasse[1]/VarCorr(m0)$schulklasse[1]

VarE0 <- summary(m0)$sigma^2 # Varianz des Residuums im Nullmodell
VarE1 <- summary(m1)$sigma^2 # Varianz des Residuums im Modell mit Motivation als Prädiktor

VarU0 <- VarCorr(m0)$schulklasse[1]  # Varianz des Interzepts im Nullmodell
VarU1 <- VarCorr(m1)$schulklasse[1]  # Varianz des Interzepts im Modell mit Motivation als Prädiktor

1- (VarU1 + VarE1)/(VarU0 + VarE0)

# oder kurz:
1 - (VarCorr(m1)$schulklasse[1] + summary(m1)$sigma^2)/(VarCorr(m0)$schulklasse[1] + summary(m0)$sigma^2)

m2 <- lmer(MatheL ~ 1 + Motivation_c + (1 + Motivation_c | schulklasse), data = StudentsInClasses)
summary(m2)

anova(m1, m2, test = "LRT", refit = F) 

cat('Data: StudentsInClasses
Models:
m1: MatheL ~ 1 + Motivation_c + (1 | schulklasse)
m2: MatheL ~ 1 + Motivation_c + (1 + Motivation_c | schulklasse)')

cat('    npar    AIC    BIC  logLik deviance  Chisq Df Pr(>Chisq)    
 m1    4 6239.1 6258.1 -3115.6   6231.1                         
 m2    6 5781.6 5810.1 -2884.8   5769.6 461.51  2  < 2.2e-16 ***
---
Signif. codes:  0 \'***\' 0.001 \'**\' 0.01 \'*\' 0.05 \'.\' 0.1 \' \' 1')

# Histogramm der Klassenspezifischen Koeffizienten
hist(coef(m2)$schulklasse[,2], breaks = 10, freq = F, col = "skyblue", border = "blue",
     main = "Verteilung der Steigungskoeffizienten der Motivation",
     xlab = expression("Steigungskoeffizient Motivation:"~beta[1~"j"]~"="~gamma[10]+u[1~"j"])) # Histogramm
gamma10 <- mean(coef(m2)$schulklasse[,2]) # Mittlere Steigung
VarU1 <- var(coef(m2)$schulklasse[,2]) # Varianz der Steigung
abline(v=gamma10, col = "red", lwd = 5)   # Mittlere Steigung in der Grafik
text(x = gamma10+2, y = 0.05, labels = expression(gamma[10]), cex = 3, col = "red") # Bennenung gamma01
lines(x=seq(-10,20,0.01), dnorm(x = seq(-10,20,0.01), mean = gamma10,
                                sd = sqrt(VarU1)), col = "darkblue", lwd = 3) # Normalverteilung als Vergleich
arrows(y0 = dnorm(x = gamma10+sqrt(VarU1), mean = gamma10,
                  sd = sqrt(VarU1)), y1 = dnorm(x = gamma10+sqrt(VarU1), mean = gamma10,sd = sqrt(VarU1)),
       x0 = gamma10-sqrt(VarU1), x1 = gamma10+sqrt(VarU1),
       code = 3, col = "blue", lwd = 3, angle = 90) # +/- 1 SD in der Grafik
text(x = 17, y= 0.04, labels = "+/- 1SD", col = "blue", cex = 2)

#### Das Modell zeichnen!
model <- m2
beta <- coef(model)$schulklasse   # Übergeben der Koeffizienten pro Klasse (Interzept und Steigungskoeffizent)
summary_model <- summary(model)
library(ggplot2)
ggplot(data = StudentsInClasses, aes(x=Motivation_c, y = MatheL))+geom_point(col = "grey50")+
  theme_minimal()  + geom_abline(intercept =beta$`(Intercept)`,          # Interzepts
                                 slope = beta$Motivation_c, lwd = .2) +   # und Slopes für Grafiken verwenden
  geom_abline(intercept = summary_model$coefficients[1,1],          # Interzepts und Slope von Durchschnitt nehmen
              slope = summary_model$coefficients[2,1], lwd = 2, col = "blue")


anova(m0, m1) # KEIN refit

m3 <- lmer(MatheL ~ 1 + KlassenG + Motivation_c  + (1 | schulklasse), data=StudentsInClasses)
summary(m3)

cat('Correlation of Fixed Effects:
            (Intr) KlssnG
KlassenG    -0.971
Motivatin_c  0.003 -0.003')

StudentsInClasses$KlassenG_c <- StudentsInClasses$KlassenG - mean(StudentsInClasses$KlassenG)

m3b <- lmer(MatheL ~ 1 + KlassenG_c + Motivation_c + (1 | schulklasse), data=StudentsInClasses)
summary(m3b)

m4 <- lmer(MatheL ~ 1 + KlassenG_c + Motivation_c  + KlassenG_c:Motivation_c + (1 | schulklasse), 
           data=StudentsInClasses)
summary(m4)

m4b <- lmer(MatheL ~ 1 + KlassenG_c*Motivation_c + (1 | schulklasse), data=StudentsInClasses)
summary(m4b)

library(ggplot2); library(dplyr)
StudentsInClasses %>%
  mutate(Leistung = fitted(m4)) %>% # Vorhergesagte Werte in den Datensatz
  ggplot(aes(x=Motivation_c, Leistung, group=schulklasse, color=KlassenG_c)) +
  scale_color_gradient(low="blue", high = "gold3") +
  theme_classic() +
    geom_point(aes(y=MatheL), alpha = 0.1, color="grey") +  # beobachtete Werte als Punkte
  geom_line(size=0.5)  # Vorhergesagte Werte als Linien

m4c <- lmer(MatheL ~ 1 + KlassenG_c + Motivation_c  + KlassenG_c:Motivation_c + 
              (1 + Motivation_c | schulklasse), 
            data=StudentsInClasses)
summary(m4c)

anova(m4, m4c, test = "LRT", refit = F)

# group-mean-centering:
StudentsInClasses$Motivation_groupc <- group.center(var = StudentsInClasses$Motivation, 
                                                    grp = StudentsInClasses$schulklasse)

# bestimmen der gruppenspezifischen Mittelwerte (durch Umstellen der Gleichung)
StudentsInClasses$Mot_groupmeans <- group.mean(var = StudentsInClasses$Motivation,
                                               grp = StudentsInClasses$schulklasse)

# Zentrieren der Gruppenmittelwertsvariable
StudentsInClasses$Mot_groupmeans_c <- StudentsInClasses$Mot_groupmeans -
  mean(StudentsInClasses$Motivation)

head(StudentsInClasses)

# (Spalten-)Mittelwerte (gerundet auf 10 Nachkommastellen)
round(colMeans(StudentsInClasses), 10)

# Histogramm der Klassenspezifischen Koeffizienten
model <- m2
beta <- coef(model)$schulklasse   # Übergeben der Koeffizienten pro Klasse (Interzept und Steigungskoeffizent)
hist(beta[,2], breaks = 10, freq = F, col = "skyblue", border = "blue",
     main = "Verteilung der Steigungskoeffizienten der Motivation",
     xlab = expression("Steigungskoeffizient Motivation:"~beta[1~"j"]~"="~gamma[10]+u[1~"j"])) # Histogramm
gamma10 <- mean(beta[,2]) # Mittlere Steigung
VarU1 <- var(beta[,2]) # Varianz der Steigung
abline(v=gamma10, col = "red", lwd = 5)   # Mittlere Steigung in der Grafik
text(x = gamma10+2, y = 0.05, labels = expression(gamma[10]), cex = 3, col = "red") # Bennenung gamma01
lines(x=seq(-10,20,0.01), dnorm(x = seq(-10,20,0.01), mean = gamma10,
                                sd = sqrt(VarU1)), col = "darkblue", lwd = 3) # Normalverteilung als Vergleich
arrows(y0 = dnorm(x = gamma10+sqrt(VarU1), mean = gamma10,
                  sd = sqrt(VarU1)), y1 = dnorm(x = gamma10+sqrt(VarU1), mean = gamma10,sd = sqrt(VarU1)),
       x0 = gamma10-sqrt(VarU1), x1 = gamma10+sqrt(VarU1),
       code = 3, col = "blue", lwd = 3, angle = 90) # +/- 1 SD in der Grafik
text(x = 17, y= 0.04, labels = "+/- 1SD", col = "blue", cex = 2) # Text in Grafik einfügen

 #### Das Modell zeichnen!
model <- m2
beta <- coef(model)$schulklasse   # Übergeben der Koeffizienten pro Klasse (Interzept und Steigungskoeffizent)
summary_model <- summary(model)
library(ggplot2)
ggplot(data = StudentsInClasses, aes(x=Motivation_c, y = MatheL))+geom_point(col = "grey50")+
  theme_minimal()  + geom_abline(intercept =beta$`(Intercept)`,          # Interzepts
                                 slope = beta$Motivation_c, lwd = .2) +   # und Slopes für Grafiken verwenden
  geom_abline(intercept = summary_model$coefficients[1,1],          # Interzepts und Slope von Durchschnitt nehmen
              slope = summary_model$coefficients[2,1], lwd = 2, col = "blue")

library(ggplot2) # Lade ggplot2
library(dplyr) # Lade dplyr, um Datensätze zu manipulieren (via "mutate" und "%>%")

StudentsInClasses %>%             # Datensatz wird manipuliert
  mutate(Leistung = fitted(m4)) %>% # Vorhergesagte Werte in den Datensatz via Funktion fitted(), nenne diese Variable Leistung
  ggplot(aes(x = Motivation_c, Leistung, group = schulklasse, color = KlassenG_c)) +
  scale_color_gradient(low="blue", high = "gold3") +     # von blau bis gold skalieren
  theme_classic() +                                      # klassisches Thema wählen, sodass der Hintergrund nicht grau ist
  geom_point(aes(y = MatheL), alpha = 0.1, color="grey")+ # beobachtete Werte als Punkte
  geom_line(size=0.5)  # Vorhergesagte Werte als Linien


plot_within_between_effects <- function(nb = 50, nw = 50, between_effect = 1, within_effect = 1)
{
       # Wiederholungsfunktion
        reps <- function(X, r)
        {
                out <- c()
                for(x in X)
                {
                        out <- c(out, rep(x, r))
                }
                out
        }


        # Daten generieren (Normalverteilt)
        Xb <- rnorm(nb, mean = 0)
        Yb <- between_effect*Xb + rnorm(nb)

        # between Effekte
        between <- cbind(Xb, Yb)
        between <- apply(between, 2, FUN = function(x) reps(X = x, r = nw))

        # Within Effekte
        Xw <- .1*rnorm(dim(between)[1])
        Yw <- within_effect*Xw + .1*rnorm(dim(between)[1])
        within <- cbind(Xw, Yw)

        # Gesamteffekte
        total <- between + within
        Cluster <- rep(1:nb, nw); Cluster <- sort(Cluster)

        total <- cbind(total, Cluster)
        total <- data.frame(total)
        names(total) <- c("X", "Y", "Cluster")

        total$Cluster <- as.factor(total$Cluster)


        # Grafik erstellen
        library(ggplot2)
        ggplot(data = total, mapping = aes(x = X, y = Y, col = Cluster))+geom_point()+
          theme_minimal()
}

plot_within_between_effects(nb = 50, nw = 50, between_effect = -1, within_effect = 1)
