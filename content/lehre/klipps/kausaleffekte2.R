library(knitr)
library(kableExtra)

# Benötigte Pakete --> Installieren, falls nicht schon vorhanden
library(psych)        # Für logistische Transformationen
library(ggplot2)      # Grafiken
library(gridExtra)
library(MatchIt)      # Für das Propensity Score Matching
library(questionr)    # Für gewichtete Tabellen

load(url("https://pandar.netlify.app/daten/CBTdata.rda"))
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

# Zentrierte Variablen wieder löschen
CBTdata <- subset(CBTdata, select = -c(BDI_pre_c, SWL_pre_c))

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

min(subset(CBTdata, Treatment=="CBT")$PS_P)

CBTdata[(CBTdata$Treatment=="WL" &
                           CBTdata$PS_P < min(subset(CBTdata, Treatment=="CBT")$PS_P)),]

max(subset(CBTdata, Treatment=="WL")$PS_P)

CBTdata[(CBTdata$Treatment=="CBT" &
                           CBTdata$PS_P > max(subset(CBTdata, Treatment=="WL")$PS_P)),]

### Fälle außerhalb der Überschneidung ausschließen ----
# Fälle der Kontrollgruppe entfernen, deren Wahrscheinlichkeit kleiner ist als
# die kleinste Wahrscheinlichkeit in der Treatment-Gruppe
CBTdata.red <- CBTdata[!(CBTdata$Treatment=="WL" &
                           CBTdata$PS_P < min(subset(CBTdata, Treatment=="CBT")$PS_P)),]
# Fälle der Treatment-Gruppe entfernen, deren Wahrscheinlichkeit größer ist als
# die größte Wahrscheinlichkeit in der Kontrollgruppe
CBTdata.red <- CBTdata.red[!(CBTdata.red$Treatment=="CBT" &
                               CBTdata.red$PS_P > max(subset(CBTdata, Treatment=="WL")$PS_P)),]

## Overlap & Common Support nach Fallausschluss ----
p1 <- ggplot(CBTdata.red, aes(x=PS_logit, fill = Treatment)) + 
  theme_bw() + theme(legend.position="top") +
  scale_fill_manual(values=c("#E69F00", "#56B4E9")) +
  geom_density(alpha=0.5)

p2 <- ggplot(CBTdata.red, aes(x=PS_P, fill = Treatment)) + 
  theme_bw() +
  labs(x="P(X=1)", y="") + xlim(c(0,1)) +
  scale_y_continuous(breaks=c(-1.5,1.5),     # "manuelle" Achsenbeschriftungen, um die Gruppen einzutragen
                     labels=c("CBT", "WL")) +
  geom_histogram(data = CBTdata.red[CBTdata.red$Treatment=="WL",], aes(y=..density..),   # Histogramm WL
                 alpha=0.5, fill="#E69F00") +
  geom_histogram(data = CBTdata.red[CBTdata.red$Treatment=="CBT",], aes(y=-..density..), # Histogramm CBT
                 alpha=0.5, fill="#56B4E9") +
  coord_flip()
grid.arrange(p1, p2, nrow=1) # Beide Plots nebeneinander

BDI.adj <- lm(BDI_post ~ Treatment + Disorder + BDI_pre + SWL_pre, data = CBTdata.red)
round(coef(BDI.adj)[2],2)
BDI.PS <- lm(BDI_post ~ Treatment + PS_logit, data = CBTdata.red)
round(coef(BDI.PS)[2],2)

# Optimal Pair Matching
m.optimal <- matchit(Treatment ~ Disorder + BDI_pre + SWL_pre, method = "optimal",
                     data = CBTdata, distance = "glm", link = "logit")
# Full Optimal Matching
m.full <- matchit(Treatment ~ Disorder + BDI_pre + SWL_pre, method = "full",
                  data = CBTdata, distance = "glm", link = "logit")

# Datensätze speichern und nach Subklasse & Treatment sortieren
df.optimal <- match.data(m.optimal) 
df.optimal <- df.optimal[order(df.optimal$subclass, df.optimal$Treatment),]

df.full <- match.data(m.full) 
df.full <- df.full[order(df.full$subclass, df.full$Treatment),] 

head(df.optimal)

kable_styling(kable(head(df.optimal)))

df.full[df.full$subclass %in% c(5,6),]

kable_styling(kable(df.full[df.full$subclass %in% c(5,6),]))

# Auszug as dem Datensatz
demo.df <- subset(df.full, as.numeric(subclass) < 10)
demo.df$subclass <- droplevels(demo.df$subclass)
# Ungewichtete Häufigkeiten
table(demo.df$Treatment, demo.df$subclass)
# Gewichtete Häufigkeiten
round(wtd.table(y = demo.df$subclass, 
                x = demo.df$Treatment, weights = demo.df$weights), 2)

plot(summary(m.optimal), xlim=c(-0.1,1.5), main="Optimal Pair")
plot(summary(m.full), xlim=c(-0.1,1.5), main = "Full Optimal")

lm.PFE <- lm(BDI_post ~ Treatment, data = CBTdata)
lm.optimal <- lm(BDI_post ~ Treatment, data = df.optimal)
lm.full <- lm(BDI_post ~ Treatment, data = df.full, weights = weights)
lm.adj <- lm(BDI_post ~ Treatment + Disorder + BDI_pre + SWL_pre, data = CBTdata)

lm.PFE <- lm(BDI_post ~ Treatment, data = CBTdata)
summary(lm.PFE)

lm.optimal <- lm(BDI_post ~ Treatment, data = df.optimal)
summary(lm.optimal)

lm.full <- lm(BDI_post ~ Treatment, data = df.full, weights = weights)
summary(lm.full)

m.strat <- matchit(Treatment ~ Disorder + BDI_pre + SWL_pre, data = CBTdata,
                 distance = "logit", method = "subclass", subclass = 5)
df.strat <- match.data(m.strat)

# Zugehörigkeit der Fälle zu Treatment und Stratum
table(df.strat$Treatment, df.strat$subclass)

ggplot(df.strat, aes(x=distance, fill = Treatment)) + 
  theme_bw() + theme(text = element_text(size = 20)) +
  labs(x="P(X=1)", y="") +
  scale_y_continuous(breaks=c(-1.5,1.5),     # "manuelle" Achsenbeschriftungen, um die Gruppen einzutragen
                     labels=c("CBT", "WL")) +
  geom_histogram(data = df.strat[df.strat$Treatment=="WL",], aes(y=..density..),   # Histogramm WL
                 alpha=0.5, fill="#E69F00") +
  geom_histogram(data = df.strat[df.strat$Treatment=="CBT",], aes(y=-..density..), # Histogramm CBT
                 alpha=0.5, fill="#56B4E9") +
  coord_flip() +
  geom_vline(xintercept = aggregate(df.strat$distance, by=list(df.strat$subclass), FUN=min)$x[2:5],
             linetype=2) +
  coord_flip()

ggplot(df.strat, aes(x=distance, fill = Treatment, weights=weights)) + 
         theme_bw() + theme(text = element_text(size = 20)) +
         labs(x="P(X=1)", y="") +
         scale_y_continuous(breaks=c(-1.5,1.5),     # "manuelle" Achsenbeschriftungen, um die Gruppen einzutragen
                            labels=c("CBT", "WL")) +
         geom_histogram(data = df.strat[df.strat$Treatment=="WL",], aes(y=..density..),   # Histogramm WL
                        alpha=0.5, fill="#E69F00") +
         geom_histogram(data = df.strat[df.strat$Treatment=="CBT",], aes(y=-..density..), # Histogramm CBT
                        alpha=0.5, fill="#56B4E9") +
         coord_flip() +
         geom_vline(xintercept = aggregate(df.strat$distance, by=list(df.strat$subclass), FUN=min)$x[2:5],
                    linetype=2) +
         coord_flip()

lm.strat <- lm(BDI_post ~ Treatment, data = df.strat, weights = weights)

lm.strat <- lm(BDI_post ~ Treatment, data = df.strat, weights = weights)
summary(lm.strat)

# mit (CBTdata$Treatment=="CBT")*1 wird Treatment numerisch mit 1, Kontrollgruppe mit 0 kodiert
CBTdata$ps_w <- (CBTdata$Treatment=="CBT")*1/CBTdata$PS_P + (1 - (CBTdata$Treatment=="CBT")*1)/(1 - CBTdata$PS_P)

BDI.weighted <- lm(BDI_post ~ Treatment, data = CBTdata, weights = ps_w)
summary(BDI.weighted)

## Overlap & Common Support ----
plot(density(CBTdata$PS_P[CBTdata$Treatment == "CBT"]), 
     type = "l")
lines(density(CBTdata$PS_P[CBTdata$Treatment == "WL"]))

## Overlap & Common Support ----
plot(density(CBTdata$PS_P[CBTdata$Treatment == "CBT"]), 
     col = "#56B4E9", lwd = 2, type = "l", main = "")
lines(density(CBTdata$PS_P[CBTdata$Treatment == "WL"]), 
      col = "#E69F00", lwd = 2)
legend(legend = c("CBT", "WL"), lwd = 2, 
       col = c("#56B4E9", "#E69F00"), x = "bottom")


MWs <- tapply(df.strat$BDI_post, list(df.strat$subclass, df.strat$Treatment), mean)
MWW <- data.frame(Y0 = MWs[, 1], Y1 = MWs[, 2], ATEq = MWs[, 2]-MWs[, 1])
MWW$Wq <- tabulate(df.strat$subclass)/nrow(df.strat)
ATT.strat <- sum(MWW$Wq*MWW$ATEq)

##ATEs in den Strata berechnen und als neuen Datensatz
MWs <- tapply(df.strat$BDI_post, list(df.strat$subclass, df.strat$Treatment), mean)
MWW <- data.frame(Y0 = MWs[, 1], Y1 = MWs[, 2], ATEq = MWs[, 2]-MWs[, 1])
MWW

##Gesamt-ATE als gewichtetes Mittel über die Strata berechnen 
MWW$Wq <- table(df.strat$subclass)/nrow(df.strat) # Anteil des Stratum an der Stichprobe
# Gesamteffekt als gewichtete Summe:
sum(MWW$Wq * MWW$ATEq)

aggregate(BDI_post ~ subclass + Treatment, data = df.strat, FUN = mean)
