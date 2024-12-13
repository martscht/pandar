#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb24.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb24$hand_factor <- factor(fb24$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb24$fach <- factor(fb24$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb24$ziel <- factor(fb24$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb24$wohnen <- factor(fb24$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

# Rekodierung invertierter Items
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf11_r <- -1 * (fb24$mdbf11 - 5)
fb24$mdbf3_r <- -1 * (fb24$mdbf3 - 5)
fb24$mdbf9_r <- -1 * (fb24$mdbf9 - 5)

# Berechnung von Skalenwerten
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb24$ru_pre <-  fb24[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb24$ru_pre_zstd <- scale(fb24$ru_pre, center = TRUE, scale = TRUE)



summary(fb24$ru_pre)
summary(fb24$ru_post)

# Je ein Histogramm pro Werte, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert
par(mfrow=c(2,1), mar=c(3,3,2,0))
hist(fb24$ru_pre, 
     xlim=c(1,5),
     ylim = c(0,80),
     main="Subskalen 'Ruhig vs. Unruhig' vor der Sitzung", 
     xlab="", 
     ylab="", 
     las=1)
abline(v=mean(fb24$ru_pre, na.rm = T), 
       lwd=3,
       col="aquamarine3")

hist(fb24$ru_post, 
     xlim=c(1,5),
     ylim = c(0,80),
     main="Subskalen 'Ruhig vs. Unruhig' nach der Sitzung", 
     xlab="", 
     ylab="", 
     las=1)
abline(v=mean(fb24$ru_post, na.rm = T), 
       lwd=3,
       col="darksalmon")
par(mfrow=c(1,1)) #Zurücksetzen des Plotfensters, zuvor hatten wir "dev.off()" kennengelernt

difference <- fb24$ru_post-fb24$ru_pre
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

t.test(x = fb24$ru_post, y = fb24$ru_pre, # die beiden abhaengigen Variablen
      paired = T,                      # Stichproben sind abhaengig
      conf.level = .95)   




mean_d <- mean(difference, na.rm = T)
sd.d.est <- sd(difference, na.rm = T)
d_Wert <- mean_d/sd.d.est
d_Wert

#alternativ:
#install.packages("effsize")
library("effsize")

d2 <- cohen.d(fb24$ru_post, fb24$ru_pre, 
      paired = TRUE,  #paired steht fuer 'abhaengig'
      within = FALSE, #wir brauchen nicht die Varianz innerhalb
      na.rm = TRUE)   
d2

par(mfrow=c(1,2), mar=c(3,3,2,0))
hist(fb24$time_pre, 
     main="Bearbeitungszeit \nvor dem Praktikum", 
     breaks = 10)


hist(fb24$time_post, 
     main="Bearbeitungszeit \nnach dem Praktikum",
     breaks = 10)

par(mfrow=c(1,1)) #Zurücksetzen des Plotfensters

summary(fb24$time_pre)
summary(fb24$time_post)

dif_time <- fb24$time_post - fb24$time_pre
hist(dif_time,
     main="Differenzen Bearbeitungszeiten",
     breaks = 10)

wilcox.test(x = fb24$time_pre, 
            y = fb24$time_post,          # die beiden abhängigen Gruppen
            paired = T,                  # Stichproben sind abhängig
            alternative = "two.sided",   # ungerichtete Hypothese
            exact = F,                   # Approximation?
            conf.level = .95)            # alpha = .05
