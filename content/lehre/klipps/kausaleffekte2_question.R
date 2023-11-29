# Benötigte Pakete --> Installieren, falls nicht schon vorhanden
library(psych)        # Für logistische Transformationen
library(ggplot2)      # Grafiken
library(gridExtra)
library(MatchIt)      # Für das Propensity Score Matching

load(url("https://courageous-donut-84b9e9.netlify.app/post/CBTdata.rda"))
head(CBTdata)

knitr::kable(head(CBTdata))

BDI.PFE <- lm(BDI_post ~ Treatment, data = CBTdata)
BDI.adj <- lm(BDI_post ~ Treatment + Disorder + BDI_pre + SWL_pre, data = CBTdata)

# Vorhersage des Treatments durch Kovariaten
mod_ps1 <- glm(Treatment ~ Disorder + BDI_pre + SWL_pre,
              family = "binomial", data = CBTdata)
summary(mod_ps1)

# Einschluss von Wechselwirkungen, hierzu zunächst Zentrierung der Prädiktoren
CBTdata$BDI_pre_c <- scale(CBTdata$BDI_pre, scale = F)
CBTdata$SWL_pre_c <- scale(CBTdata$SWL_pre, scale = F)

mod_ps2 <- glm(Treatment ~ Disorder + BDI_pre_c + SWL_pre_c +
                Disorder:BDI_pre_c + Disorder:SWL_pre_c + BDI_pre_c:SWL_pre_c +
                Disorder:BDI_pre_c:SWL_pre_c,
              family = "binomial", data = CBTdata)
summary(mod_ps2)

CBTdata$PS_logit <- predict(mod_ps1)
CBTdata$PS_P <- logistic(CBTdata$PS_logit)
plot(CBTdata$PS_logit, CBTdata$PS_P)

## Overlap & Common Support ----
p1 <- ggplot(CBTdata, aes(x=PS_logit, fill = Treatment)) + 
  theme_bw() + theme(legend.position="top") +
  scale_fill_manual(values=c("#E69F00", "#56B4E9")) +
  geom_density(alpha=0.5)

p2 <- ggplot(CBTdata, aes(x=PS_P, fill = Treatment)) + 
  theme_bw() +
  labs(x="P(X=1)", y="") + xlim(c(0,1)) +
  scale_y_continuous(breaks=c(-1.5,1.5),     # "manuelle" Achsenbeschriftungen, um die Gruppen einzutragen
                     labels=c("CBT", "WL")) +
  geom_histogram(data = CBTdata[CBTdata$Treatment=="WL",], aes(y=..density..),   # Histogramm WL
                 alpha=0.5, fill="#E69F00") +
  geom_histogram(data = CBTdata[CBTdata$Treatment=="CBT",], aes(y=-..density..), # Histogramm CBT
                 alpha=0.5, fill="#56B4E9") +
  # Minimum in CBT und maximum in WL einzeichnen
  geom_vline(xintercept = c(min(CBTdata$PS_P[CBTdata$Treatment=="CBT"]),
                            max(CBTdata$PS_P[CBTdata$Treatment=="WL"])),
             linetype=2) +
  coord_flip()
grid.arrange(p1, p2, nrow=1) # Beide Plots nebeneinander

### Fälle außerhalb der Überschneidung ausschließen ----
# Fälle der Kontrollgruppe entfernen, deren Wahrscheinlichkeit kleiner ist als
# die kleinste Wahrscheinlichkeit in der Treatment-Gruppe
CBTdata <- CBTdata[!(CBTdata$Treatment=="WL" & 
                               CBTdata$PS_P < min(subset(CBTdata, Treatment=="CBT")$PS_P)),]
# Fälle der Treatment-Gruppe entfernen, deren Wahrscheinlichkeit größer ist als
# die größte Wahrscheinlichkeit in der Kontrollgruppe
CBTdata <- CBTdata[!(CBTdata$Treatment=="CBT" & 
                               CBTdata$PS_P > max(subset(CBTdata, Treatment=="WL")$PS_P)),]

## Overlap & Common Support nach Fallausschluss ----
p1 <- ggplot(CBTdata, aes(x=PS_logit, fill = Treatment)) + 
  theme_bw() + theme(legend.position="top") +
  scale_fill_manual(values=c("#E69F00", "#56B4E9")) +
  geom_density(alpha=0.5)

p2 <- ggplot(CBTdata, aes(x=PS_P, fill = Treatment)) + 
  theme_bw() +
  labs(x="P(X=1)", y="") + xlim(c(0,1)) +
  scale_y_continuous(breaks=c(-1.5,1.5),     # "manuelle" Achsenbeschriftungen, um die Gruppen einzutragen
                     labels=c("CBT", "WL")) +
  geom_histogram(data = CBTdata[CBTdata$Treatment=="WL",], aes(y=..density..),   # Histogramm WL
                 alpha=0.5, fill="#E69F00") +
  geom_histogram(data = CBTdata[CBTdata$Treatment=="CBT",], aes(y=-..density..), # Histogramm CBT
                 alpha=0.5, fill="#56B4E9") +
  coord_flip()
grid.arrange(p1, p2, nrow=1) # Beide Plots nebeneinander

BDI.adj <- lm(BDI_post ~ Treatment + Disorder + BDI_pre + SWL_pre, data = CBTdata)
round(coef(BDI.adj)[2],2)
BDI.PS <- lm(BDI_post ~ Treatment + PS_logit, data = CBTdata)
round(coef(BDI.PS)[2],2)

PS.match <- matchit(Treatment ~ Disorder + BDI_pre + SWL_pre, method = "nearest",
                    data = CBTdata, link = "logit", caliper = 0.1)

plot(PS.match, type = "jitter", interactive = F)

summary(PS.match)

plot(summary(PS.match),
     var.order = "unmatched", abs = FALSE)

CBTdata.PSM <- match.data(PS.match)
BDI.match <- lm(BDI_post ~ Treatment, data = CBTdata.PSM)
summary(BDI.match)

PS.strat <- matchit(Treatment ~ Disorder + BDI_pre + SWL_pre, data = CBTdata,
                 distance = 'logit', method = 'subclass', subclass = 5)
CBTdata.strat <- match.data(PS.strat)
# Zugehörigkeit der Fälle zu Treatment und Stratum
table(CBTdata.strat$Treatment, CBTdata.strat$subclass)

ggplot(CBTdata.strat, aes(x=distance, fill = Treatment)) + 
  theme_bw() + theme(text = element_text(size = 20)) +
  labs(x="P(X=1)", y="") +
  scale_y_continuous(breaks=c(-1.5,1.5),     # "manuelle" Achsenbeschriftungen, um die Gruppen einzutragen
                     labels=c("CBT", "WL")) +
  geom_histogram(data = CBTdata.strat[CBTdata.strat$Treatment=="WL",], aes(y=..density..),   # Histogramm WL
                 alpha=0.5, fill="#E69F00") +
  geom_histogram(data = CBTdata.strat[CBTdata.strat$Treatment=="CBT",], aes(y=-..density..), # Histogramm CBT
                 alpha=0.5, fill="#56B4E9") +
  coord_flip() +
  geom_vline(xintercept = aggregate(CBTdata.strat$distance, by=list(CBTdata.strat$subclass), FUN=min)$x[2:5],
             linetype=2) +
  coord_flip()

MWs <- tapply(CBTdata.strat$BDI_post, list(CBTdata.strat$subclass, CBTdata.strat$Treatment), mean)
MWW <- data.frame(Y0 = MWs[, 1], Y1 = MWs[, 2], ATEq = MWs[, 2]-MWs[, 1])
MWW$Wq <- tabulate(CBTdata.strat$subclass)/nrow(CBTdata.strat)
ATT.strat <- sum(MWW$Wq*MWW$ATEq)

##ATEs in den Strata berechnen und als neuen Datensatz
MWs <- tapply(CBTdata.strat$BDI_post, list(CBTdata.strat$subclass, CBTdata.strat$Treatment), mean)
MWW <- data.frame(Y0 = MWs[, 1], Y1 = MWs[, 2], ATEq = MWs[, 2]-MWs[, 1])
MWW
##Gesamt-ATE als gewichtetes Mittel über die Strata berechnen 
MWW$Wq <- tabulate(CBTdata.strat$subclass)/nrow(CBTdata.strat) # Anteil des Stratum an der Stichprobe
# Gesamteffekt als gewichtete Summe:
sum(MWW$Wq*MWW$ATEq)

# mit (CBTdata$Treatment=="CBT")*1 wird Treatment numerisch mit 1, Kontrollgruppe mit 0 kodiert
CBTdata$ps_w <- (CBTdata$Treatment=="CBT")*1/CBTdata$PS_P + (1 - (CBTdata$Treatment=="CBT")*1)/(1 - CBTdata$PS_P)

BDI.weighted <- lm(BDI_post ~ Treatment, data = CBTdata, weights = ps_w)
summary(BDI.weighted)
