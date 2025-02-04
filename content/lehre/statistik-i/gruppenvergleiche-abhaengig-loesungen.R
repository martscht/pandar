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
fb24$fach_klin <- factor(as.numeric(fb24$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))

fb24$ort <- factor(fb24$ort, levels=c(1,2), labels=c("FFM", "anderer"))
fb24$job <- factor(fb24$job, levels=c(1,2), labels=c("nein", "ja"))


# Rekodierung invertierter Items
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 4 - 1)
fb24$mdbf11_r <- -1 * (fb24$mdbf11 - 4 - 1)
fb24$mdbf3_r <-  -1 * (fb24$mdbf3 - 4 - 1)
fb24$mdbf9_r <-  -1 * (fb24$mdbf9 - 4 - 1)
fb24$mdbf5_r <- -1 * (fb24$mdbf5 - 4 - 1)
fb24$mdbf7_r <- -1 * (fb24$mdbf7 - 4 - 1)

# Berechnung von Skalenwerten
fb24$wm_pre  <- fb24[, c('mdbf1', 'mdbf5_r', 
                        'mdbf7_r', 'mdbf10')] |> rowMeans()
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb24$ru_pre <-  fb24[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb24$ru_pre_zstd <- scale(fb24$ru_pre, center = TRUE, scale = TRUE)



wach <- fb24[, c("wm_pre", "wm_post")] #Erstellung eines neuen Datensatzes, welcher nur die für uns wichtigen Variablen enthält

wach <- na.omit(wach) #Entfernt alle Beobachtungen, die auf einer der beiden Variable einen fehlenden Wert haben

str(wach) #Ablesen der finalen Stichprobengröße

par(mfrow=c(2,1), mar=c(3,2,2,0)) # Zusammenfügen der zwei Histogramme in eine Plot-Datei und ändern der Ränder (margins) des Plot-Fensters

hist(wach[, "wm_pre"], xlim=c(0,5), ylim=c(1,50), main="Wachempfinden vor der Sitzung", xlab="", ylab="", las=1)
abline(v=mean(wach[, "wm_pre"]), lty=2, lwd=2)

hist(wach[, "wm_post"], xlim=c(0,5), ylim=c(1,50), main="Wachempfinden nach der Sitzung", xlab="", ylab="", las=1)
abline(v=mean(wach[, "wm_post"]), lty=2, lwd=2)

par(mfrow=c(1,1)) #Zurücksetzen auf default

summary(wach[, "wm_pre"])
summary(wach[, "wm_post"])
# aus dem Paket psych, das wir bereits installiert haben
library(psych)
describe(wach[, "wm_pre"])
describe(wach[, "wm_post"])
vorher <- describe(wach[, "wm_pre"])
nachher <- describe(wach[, "wm_post"])

par(mar=c(3,3,3,0)) #ändern der Ränder (margins) des Plot-Fensters
difference <- wach[, "wm_pre"]-wach[, "wm_post"]
hist(difference, xlim=c(-4,4), main="Verteilung der Differenzen", xlab="Differenzen", ylab="", las=1,freq=F)
curve(dnorm(x, mean=mean(difference), sd=sd(difference)), col="blue", lwd=2, add=T)
par(mfrow=c(1,1)) #Zurücksetzen auf default
qqnorm(difference,las=1)
qqline(difference, col="blue")

t.test(x = wach[, "wm_pre"], y  = wach[, "wm_post"], # die Werte vorher und nachher
       paired = T,                                   # Stichproben sind abhängig
       alternative = "two.sided",                    # unggerichtete Hypothese -> zweiseitig Testung
       conf.level = .95)                             # alpha = .05

## # Alternative Schreibweise
## t.test(x = wach$wm_pre, y = wach$wm_post,
##        paired = T,
##        alternative = "two.sided",
##        conf.level = .95)

ttest <- t.test(x = wach[, "wm_pre"], y  = wach[, "wm_post"], paired = T, alternative = "two.sided", conf.level = .95)

mean_d <- mean(difference) # Mittelwert der Differenzen
sd.d.est <- sd(difference) # geschätzte Populationsstandardabweichung der Differenzen
d <- mean_d/sd.d.est
d
