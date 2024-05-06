osf <- read.csv(file = url("https://osf.io/zc8ut/download"))
names(osf)

osf <- osf[, c("ID", "group", "stratum", "bsi_post", "swls_post", "pas_post")]
head(osf)

dim(osf) # vorher
osf <- na.omit(osf)
dim(osf) # nach Fallauschluss

reg <- lm(bsi_post ~ 1 + swls_post + pas_post, data = osf)
summary(reg)

reg0 <-  lm(bsi_post ~ 1, data = osf)
anova(reg0, reg)

anova0 <- anova(reg0, reg)
R2 <- anova0$`Sum of Sq`[2] / anova0$RSS[1]
R2 # R^2 mit Hand
summary(reg)$r.squared # R^2 aus dem lm-Objekt
var(predict(reg))/var(osf$bsi_post) # über die Vorhersage von Werten mittels "predict"

F_emp <- (R2/2)/((1-R2)/91)
F_emp # empirischer F-Bruch mit Hand
anova0$F[2] # empirischer F-Bruch aus anova-Objekt

osf$group <- factor(osf$group)
reg_dummy1 <- lm(bsi_post  ~ 1 + group, data = osf)
summary(reg_dummy1)

levels(osf$group)

aggregate(bsi_post ~ group, data = osf, FUN = mean)

anova(reg0, reg_dummy1)

summary(reg_dummy1)$r.squared

# Paket laden (ggf. vorher installieren mit install.packages)
library(ez)

osf$ID <- as.factor(osf$ID)

ezANOVA(data = osf, wid = ID, dv = bsi_post, between = group)

ezANOVA(data = osf, wid = ID, dv = bsi_post, between = group, detailed = T)

ezANOVA1 <- ezANOVA(data = osf, wid = ID, dv = bsi_post, between = group, detailed = T)
ezANOVA1$ANOVA$ges
summary(reg_dummy1)$r.squared

ezANOVA1$ANOVA$F
anova(reg0, reg_dummy1)$F

ttest1 <- t.test(bsi_post ~ group, data = osf, var.equal = T)
ttest1

ezANOVA1$ANOVA$p
anova(reg0, reg_dummy1)$`Pr(>F)`
ttest1$p.value

ezANOVA1$ANOVA$F
anova(reg0, reg_dummy1)$F
ttest1$statistic^2

osf$stratum <- factor(osf$stratum)
ezANOVA1 <- ezANOVA(data = osf, dv = bsi_post, between = c(group, stratum), wid = ID,
                    detailed = T, type = 1)
ezANOVA1



ezPlot(data = osf, dv = bsi_post, between = c(group, stratum), wid = ID, x = stratum, split = group)

ezANOVA(data = osf, dv = bsi_post, between = c(stratum, group), wid = ID,
                    detailed = T, type = 1)

reg0 <- lm(bsi_post ~ 1, data = osf)  # Null-Modell (leeres Modell)
reg_g <- lm(bsi_post ~ group, data = osf) # Modell mit Haupteffekt des Treatments
reg_s <- lm(bsi_post ~ stratum, data = osf) # Modell mit Haupteffekt der Diagnose
reg_gs <- lm(bsi_post ~ group + stratum, data = osf) # Modell mit beiden Haupteffekten
reg_gsi <- lm(bsi_post ~ group + stratum + group:stratum, data = osf)  # Modell mit beiden Haupteffekten und Interaktion

anova(reg0, reg_g, reg_gs, reg_gsi)

anova(reg_gsi)

ezANOVA2 <- ezANOVA(data = osf, dv = bsi_post, between = c(group, stratum), wid = ID,
                    type = 2)
ezANOVA2
ezANOVA(data = osf, dv = bsi_post, between = c(stratum, group), wid = ID,
        type = 2)

library(car)
Anova(reg_gsi, type = 2)

Anova(reg_gs, type = 2) # simulatane Inkrementsprüfung
anova(reg_s, reg_gs) # Inkrement des Treatments
anova(reg_g, reg_gs) # Inkrement der Diagnose

ezANOVA(data = osf, dv = bsi_post, between = c(group, stratum), wid = ID,
        type = 3)

options("contrasts")

reg_gsi_contr.sum <- lm(bsi_post ~ group + stratum + group:stratum, data = osf, 
                        contrasts = list("group" = contr.sum, "stratum" = contr.sum))  # contr.sum-Kodierung
Anova(reg_gsi_contr.sum, type = 3)
