# Benötigte Pakete --> Installieren, falls nicht schon vorhanden
library(psych)        # Für Deskriptivstatistiken
library(EffectLiteR)  # Für die Schätzung adjustierter Effekte
library(car)          # Quadratsummen in Anova-Output

load(url("https://pandar.netlify.app/daten/CBTdata.rda"))
head(CBTdata)



table(CBTdata$Treatment) 

# Deskriptivstatistiken der Gruppen für Alter und Prätest-Werte
describeBy(CBTdata[, c("Age", "BDI_pre", "SWL_pre")], group = CBTdata$Treatment, range=F)

t.age <- t.test(Age ~ Treatment, data = CBTdata)
d.age <- cohen.d(Age ~ Treatment, data = CBTdata)
t.bdi <- t.test(BDI_pre ~ Treatment, data = CBTdata)
d.bdi <- cohen.d(BDI_pre ~ Treatment, data = CBTdata)
t.swl <- t.test(SWL_pre ~ Treatment, data = CBTdata)
d.swl <- cohen.d(SWL_pre ~ Treatment, data = CBTdata)

# Tabelle erzeugen
tab.gender <- table(CBTdata$Treatment, CBTdata$Gender)
# Kreuztabelle mit Anteilen Zeilenweise, durch Multiplikation mit 100 als Zeilenprozent zu lesen
round(prop.table(tab.gender, 2)*100)
# Chi2-Test
chisq.test(tab.gender)

tab.disorder <- table(CBTdata$Treatment, CBTdata$Disorder)
round(prop.table(tab.disorder, 2)*100)
chisq.test(tab.disorder)

boxplot(CBTdata$BDI_post ~ CBTdata$Treatment)

BDI.PFE <- lm(BDI_post ~ Treatment, data = CBTdata)
summary(BDI.PFE)

# ANCOVA mit Treatment und Kovariaten
BDI.adj <- lm(BDI_post ~ Treatment + Disorder + BDI_pre + SWL_pre, data = CBTdata)
summary(BDI.adj)

# Zentrierte Kovariaten bilden
CBTdata$BDI_pre_c <- scale(CBTdata$BDI_pre, scale = F)
CBTdata$SWL_pre_c <- scale(CBTdata$SWL_pre, scale = F)
# Generalisierte ANCOVA mit allen Wechselwirkungen zwischen Kovariaten und Treatment
BDI.adj2 <- lm(BDI_post ~ Treatment + Disorder + BDI_pre_c + SWL_pre_c +
                Treatment:Disorder + Treatment:BDI_pre_c + Treatment:SWL_pre_c, data = CBTdata)
summary(BDI.adj2)

Anova(BDI.adj2, type = 2)

BDI.adj3 <- lm(BDI_post ~ 1  +  BDI_pre_c + SWL_pre_c + Disorder +                  # Interzept
                 Disorder:BDI_pre_c + Disorder:SWL_pre_c +                          # Interzept
                 Treatment +                                                        # Slope
                 Treatment:BDI_pre_c + Treatment:SWL_pre_c + Treatment:Disorder +   # Slope
                 Treatment:Disorder:BDI_pre_c +  Treatment:Disorder:SWL_pre_c,      # Slope
               data = CBTdata)                      
summary(BDI.adj3)
Anova(BDI.adj3)

BDI.EL <- effectLite(y="BDI_post", x="Treatment", z=c("BDI_pre_c", "SWL_pre_c"), k=c("Disorder"), data = CBTdata, method = "lm")

# Schätzung des Effekts des Treatments auf BDI_post mit effectLite,
# Prätest-Werte als kontinuierliche, Störung als kategoriale Kovariate
# 'lm' als Methode für eine Schätzung per ANCOVA
effectLite(y="BDI_post", x="Treatment", z=c("BDI_pre_c", "SWL_pre_c"), k=c("Disorder"), data = CBTdata, method = "lm")

