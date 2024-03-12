## load("C:/Users/Musterfrau/Desktop/Therapy.rda")

load(url("https://pandar.netlify.app/daten/Therapy.rda"))

head(Therapy)
levels(Therapy$Intervention)
levels(Therapy$Geschlecht)

colnames(Therapy) # Spaltennamen ansehen
colnames(Therapy) <- c("LZ", "AB", "Dep", "AZ", "Intervention", "Geschlecht") # Spaltennamen neu zuordnen
head(Therapy)

library(heplots) # für Box-M Test für Kovarianzhomogenität
library(car)

boxM(cbind(LZ, AB, Dep, AZ) ~ Intervention, data = Therapy)

round(cov(Therapy[Therapy$Intervention == "Kontrollgruppe", 1:4]), digits = 2)
round(cov(Therapy[Therapy$Intervention == "VT Coaching", 1:4]), digits = 2)

Therapy[Therapy$Intervention == "VT Coaching + Gruppenuebung", 1:4] |> cov() |> round(digits = 2)

manova1 <- manova(cbind(LZ, AB, Dep, AZ) ~ Intervention, 
                  data = Therapy) 
M1 <- Manova(manova1)
summary(M1)

sum_manova1 <- summary(M1)

W <- sum_manova1$multivariate.tests$Intervention$SSPE # W-Matrix (E steht für errors)
B <- sum_manova1$multivariate.tests$Intervention$SSPH # B-Matrix (H steht für Hypothesis)

det(W)/(det(B + W)) # Wilks Lambda 



aggregate(cbind(LZ, AB, Dep, AZ) ~ Intervention, 
          data = Therapy, 
          FUN = mean)

summary.aov(manova1) # post hoc anovas





anovaLZ <- aov(LZ ~ Intervention, data = Therapy)
summary(anovaLZ)

pairwise.t.test(x = Therapy$LZ, g = Therapy$Intervention, p.adjust.method = "none")
pairwise.t.test(x = Therapy$Dep, g = Therapy$Intervention, p.adjust.method = "none")
pairwise.t.test(x = Therapy$AZ, g = Therapy$Intervention, p.adjust.method = "none")

TukeyHSD(aov(LZ ~ Intervention, data = Therapy)) # Tukey HSD für LZ


# als Plot
tukeyLZ <- TukeyHSD(aov(LZ ~ Intervention, data = Therapy))
plot(tukeyLZ, las = 1)

TukeyHSD(aov(Dep ~ Intervention, data = Therapy)) # Tukey HSD für Dep
plot(TukeyHSD(aov(Dep ~ Intervention, data = Therapy)), las = 1) # Tukey HSD-Plot für Dep

TukeyHSD(aov(AZ ~ Intervention, data = Therapy)) # Tukey HSD für AZ
plot(TukeyHSD(aov(AZ ~ Intervention, data = Therapy)), las = 1) # Tukey HSD-Plot für AZ

MD <- mahalanobis(resid(manova1), center = colMeans(resid(manova1)), cov = cov(resid(manova1)))
hist(MD, breaks = 20, col = "skyblue", border = "blue", freq = F, main = "Mahalnobisdistanz vs Chi2(4) Verteilung",
     xlab = "Mahalanobisdistanz")
xWerte <- seq(from = min(MD), to = max(MD), by = 0.01)
lines(x = xWerte, y = dchisq(x = xWerte, df = 4), lwd = 3, col = "blue")

qqPlot(MD, distribution = "chisq", df = 4)

manova3 <- manova(cbind(LZ, AB, Dep, AZ) ~ Intervention + Geschlecht, 
                  data = Therapy)
M3 <- Manova(manova3, test = "Wilks")
summary(M3)

aggregate(cbind(LZ, AB, Dep, AZ) ~ Intervention + Geschlecht, 
           data = Therapy,
           FUN = mean)



manova3b <- manova(cbind(LZ, AB, Dep, AZ) ~ Intervention + Geschlecht + Intervention:Geschlecht, 
                  data = Therapy)
M3b <- Manova(manova3b)
summary(M3b)

summary.aov(manova3)

library(ggplot2)
Therapy_long <- reshape(data = Therapy, varying = names(Therapy)[1:4],idvar = names(Therapy)[5:6],
         direction = "long", v.names = "AVs", timevar = "Variable", new.row.names = 1:360)

Therapy_long$Variable[Therapy_long$Variable == 1] <- "Lebenszufriedenheit"
Therapy_long$Variable[Therapy_long$Variable == 2] <- "Arbeitsbeanspruchung"
Therapy_long$Variable[Therapy_long$Variable == 3] <- "Depressivitaet"
Therapy_long$Variable[Therapy_long$Variable == 4] <- "Arbeitszufriedenheit"


ggplot(Therapy_long, aes(x = Intervention, y = AVs,  group = Variable, col = Variable))+ stat_summary(fun.data = mean_se)+stat_summary(fun.data = mean_se, geom = c("line"))



Therapy_repeated_wide <- reshape(data = Therapy_repeated, direction = "wide", 
                                v.names = c("LZ", "AB", "Dep", "AZ"), 
                                timevar = "day", 
                                idvar = "ID")



days <- factor(rep(1:3, 4))
rep_data <- data.frame("day" = days)
head(rep_data)

repeated_manova <- manova(cbind(LZ.1, LZ.2, LZ.3, AB.1, AB.2, AB.3, Dep.1, Dep.2, Dep.3, AZ.1, AZ.2, AZ.3) ~ Intervention*Sex, data = Therapy_repeated_wide)
Manova(repeated_manova, idata = rep_data, idesign =~ day, type = 3, test = "Wilks")
Manova(repeated_manova, idata = rep_data, idesign =~ day, type = 3, test = "Pillai")

repeated_manova <- manova(cbind(LZ, AB, Dep, AZ) ~ Intervention*Sex + factor(day) + Error(ID),
                          data = Therapy_repeated)
summary(repeated_manova, test = "Wilks")
