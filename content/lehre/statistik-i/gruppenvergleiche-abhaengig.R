## Vorbereitung

#### Was bisher geschah: ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb25.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb25$hand_factor <- factor(fb25$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb25$fach <- factor(fb25$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb25$ziel <- factor(fb25$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))
fb25$wohnen <- factor(fb25$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

# Rekodierung invertierter Items
fb25$mdbf4_r <- -1 * (fb25$mdbf4 - 5)
fb25$mdbf11_r <- -1 * (fb25$mdbf11 - 5)
fb25$mdbf3_r <- -1 * (fb25$mdbf3 - 5)
fb25$mdbf9_r <- -1 * (fb25$mdbf9 - 5)

# Berechnung von Skalenwerten
fb25$gs_pre  <- fb25[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb25$ru_pre <-  fb25[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb25$ru_pre_zstd <- scale(fb25$ru_pre, center = TRUE, scale = TRUE)



## Deskriptivstatistik

summary(fb25$ru_pre)
summary(fb25$ru_post)

# oder mittels der Funktion describe() aus dem Package 'psych'
library(psych)
describe(fb25$ru_pre)
describe(fb25$ru_pos)


# Je ein Histogramm pro Werte, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert
par(mfrow=c(2,1), mar=c(3,3,2,0))
hist(fb25$ru_pre, 
     xlim=c(1,5),
     ylim = c(0,110),
     main="Subskalen 'Ruhig vs. Unruhig' vor der Sitzung", 
     xlab="", 
     ylab="", 
     las=1)
abline(v=mean(fb25$ru_pre, na.rm = T), 
       lwd=3,
       col="aquamarine3")

hist(fb25$ru_post, 
     xlim=c(1,5),
     ylim = c(0,110),
     main="Subskalen 'Ruhig vs. Unruhig' nach der Sitzung", 
     xlab="", 
     ylab="", 
     las=1)
abline(v=mean(fb25$ru_post, na.rm = T), 
       lwd=3,
       col="darksalmon")
par(mfrow=c(1,1)) #Zurücksetzen des Plotfensters, zuvor hatten wir "dev.off()" kennengelernt

## Vorraussetzungen

difference <- fb25$ru_post - fb25$ru_pre

par(mfrow=c(1,2), mar=c(3,3,2,2))
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

par(mfrow=c(1,1))

## t-Test

t.test(x = fb25$ru_post, y = fb25$ru_pre, # die beiden abhaengigen Variablen
      paired = T,                      # Stichproben sind abhaengig
      conf.level = .95)   




## Populationseffektsschätzung

mean_d <- mean(difference, na.rm = T)
sd.d.est <- sd(difference, na.rm = T)
d_Wert <- mean_d/sd.d.est
d_Wert

if (!requireNamespace("effsize", quietly = TRUE)) {
  install.packages("effsize")
}
library("effsize")

d2 <- cohen.d(fb25$ru_post, fb25$ru_pre, 
      paired = TRUE,  #paired steht fuer 'abhaengig'
      within = FALSE, #wir brauchen nicht die Varianz innerhalb
      na.rm = TRUE)   
d2

## Deskriptivstatistik-Median

par(mfrow=c(1,2), mar=c(3,3,2,0))
hist(fb25$time_pre, 
     main="Bearbeitungszeit \nvor dem Praktikum", 
     breaks = 10)


hist(fb25$time_post, 
     main="Bearbeitungszeit \nnach dem Praktikum",
     breaks = 10)

par(mfrow=c(1,1)) #Zurücksetzen des Plotfensters

summary(fb25$time_pre)
summary(fb25$time_post)

## Voraussetzungen-Median

dif_time <- fb25$time_post - fb25$time_pre
hist(dif_time,
     main="Differenzen Bearbeitungszeiten",
     breaks = 10)

## Wilcoxon

wilcox.test(x = fb25$time_pre, 
            y = fb25$time_post,          # die beiden abhängigen Gruppen
            paired = T,                  # Stichproben sind abhängig
            alternative = "two.sided",   # ungerichtete Hypothese
            exact = F,                   # Approximation?
            conf.level = .95)            # alpha = .05
