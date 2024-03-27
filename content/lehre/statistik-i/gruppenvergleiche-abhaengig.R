#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb23.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb23$hand_factor <- factor(fb23$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb23$fach <- factor(fb23$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb23$ziel <- factor(fb23$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb23$wohnen <- factor(fb23$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))
fb23$fach_klin <- factor(as.numeric(fb23$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))
fb23$ort <- factor(fb23$ort, levels=c(1,2), labels=c("FFM", "anderer"))
fb23$job <- factor(fb23$job, levels=c(1,2), labels=c("nein", "ja"))
fb23$unipartys <- factor(fb23$uni3,
                             levels = 0:1,
                             labels = c("nein", "ja"))

# Rekodierung invertierter Items
fb23$mdbf4_pre_r <- -1 * (fb23$mdbf4_pre - 4 - 1)
fb23$mdbf11_pre_r <- -1 * (fb23$mdbf11_pre - 4 - 1)
fb23$mdbf3_pre_r <-  -1 * (fb23$mdbf3_pre - 4 - 1)
fb23$mdbf9_pre_r <-  -1 * (fb23$mdbf9_pre - 4 - 1)
fb23$mdbf5_pre_r <- -1 * (fb23$mdbf5_pre - 4 - 1)
fb23$mdbf7_pre_r <- -1 * (fb23$mdbf7_pre - 4 - 1)

# Berechnung von Skalenwerten
fb23$wm_pre  <- fb23[, c('mdbf1_pre', 'mdbf5_pre_r', 
                        'mdbf7_pre_r', 'mdbf10_pre')] |> rowMeans()
fb23$gs_pre  <- fb23[, c('mdbf1_pre', 'mdbf4_pre_r', 
                        'mdbf8_pre', 'mdbf11_pre_r')] |> rowMeans()
fb23$ru_pre <-  fb23[, c("mdbf3_pre_r", "mdbf6_pre", 
                         "mdbf9_pre_r", "mdbf12_pre")] |> rowMeans()

# z-Standardisierung
fb23$ru_pre_zstd <- scale(fb23$ru_pre, center = TRUE, scale = TRUE)


summary(fb23$ru_pre)
summary(fb23$ru_post)


# Je ein Histogramm pro Werte, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert
par(mfrow=c(2,1), mar=c(3,3,2,0))
hist(fb23$ru_pre, 
     xlim=c(1,5),
     ylim = c(0,80),
     main="Subskalen 'Ruhig vs. Unruhig' vor der Sitzung", 
     xlab="", 
     ylab="", 
     las=1)
abline(v=mean(fb23$ru_pre, na.rm = T), 
       lwd=3,
       col="aquamarine3")

hist(fb23$ru_post, 
     xlim=c(1,5),
     ylim = c(0,80),
     main="Subskalen 'Ruhig vs. Unruhig' nach der Sitzung", 
     xlab="", 
     ylab="", 
     las=1)
abline(v=mean(fb23$ru_post, na.rm = T), 
       lwd=3,
       col="darksalmon")
par(mfrow=c(1,1)) #Zurücksetzen des Plotfensters, zuvor hatten wir "dev.off()" kennengelernt

difference <- fb23$ru_post-fb23$ru_pre
hist(difference, 
     xlim=c(-3,3), 
     ylim = c(0,1),
     main="Verteilung der Differenzen", 
     xlab="Differenzen", 
     ylab="", 
     las=1, 
     freq = F)
curve(dnorm(x, mean=mean(difference, na.rm = T), sd=sd(difference, na.rm = T)), 
      col="blue", 
      lwd=2, 
      add=T)
qqnorm(difference)
qqline(difference, col="blue")

t.test(x = fb23$ru_post, y = fb23$ru_pre, # die beiden abhaengigen Variablen
      paired = T,                      # Stichproben sind abhaengig
      conf.level = .95)   




mean_d <- mean(difference, na.rm = T)
sd.d.est <- sd(difference, na.rm = T)
d_Wert <- mean_d/sd.d.est
d_Wert

#alternativ:
#install.packages("effsize")
library("effsize")

d2 <- cohen.d(fb23$ru_post, fb23$ru_pre, 
      paired = TRUE,  #paired steht fuer 'abhaengig'
      within = FALSE, #wir brauchen nicht die Varianz innerhalb
      na.rm = TRUE)   
d2

load(url("https://pandar.netlify.app/daten/CBTdata.rda"))

head(CBTdata)

CBTdata <- CBTdata[CBTdata$Treatment == "CBT" & 
                     CBTdata$Disorder == "DEP", ]

summary(CBTdata$BDI_pre)
summary(CBTdata$BDI_post)

# Je ein Histogramm pro Gruppe, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert
par(mfrow=c(1,2), mar=c(3,3,2,0))
hist(CBTdata$BDI_pre, 
     main="Depressionsscore \nvor der Therapie", 
     breaks = 10)


hist(CBTdata$BDI_post, 
     main="Depressionsscore \nnach der Therapie",
     breaks = 10)

par(mfrow=c(1,1)) #Zurücksetzen des Plotfensters

dif_dep <- CBTdata$BDI_post - CBTdata$BDI_pre
hist(dif_dep,
     main="Differenzen Depressionsscores",
     breaks = 10)

wilcox.test(x = CBTdata$BDI_pre, 
            y = CBTdata$BDI_post,    # die beiden abhängigen Gruppen
            paired = T,              # Stichproben sind abhängig
            alternative = "greater", # gerichtete Hypothese
            exact = F,               # Approximation?
            conf.level = .95)        # alpha = .05
