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
fb24$mdbf11_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf3_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf9_r <- -1 * (fb24$mdbf4 - 5)

# Berechnung von Skalenwerten
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb24$ru_pre <-  fb24[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb24$ru_pre_zstd <- scale(fb24$ru_pre, center = TRUE, scale = TRUE)



fb24$fach_klin <- factor(as.numeric(fb24$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))

is.factor(fb24$fach_klin)

levels(fb24$fach_klin)

table(fb24$fach_klin)

# Gruppierter Boxplot :
boxplot(fb24$lz ~ fb24$fach_klin, 
        xlab="Interesse", ylab="Lebenszufriedenheit", 
        las=1, cex.lab=1.5, 
        main="Lebenszufriedenheit je nach Interesse")

# Je ein Histogramm pro Gruppe, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert
par(mfrow=c(2,1), mar=c(3,2,2,0))
hist(fb24[(fb24$fach_klin=="nicht klinisch"), "lz"], main="(nicht klinisch)", 
     xlim=c(1,7), xlab="", ylab="", las=1)
abline(v=mean(fb24[(fb24$fach_klin=="nicht klinisch"), "lz"], na.rm=T), col="aquamarine3", lwd=3)
hist(fb24[(fb24$fach_klin=="klinisch"), "lz"], main="(klinisch)", 
     xlim=c(1,7), xlab="", ylab="", las=1)
abline(v=mean(fb24[(fb24$fach_klin=="klinisch"), "lz"], na.rm=T), col="darksalmon", lwd=3)

dev.off()

library(psych)
describeBy(x = fb24$lz, group = fb24$fach_klin)        # beide Gruppen im Vergleich 

vertr_nichtKlinisch <- fb24$vertr[fb24$fach_klin=="nicht klinisch"]
sigma_nichtKlinisch <- sd(vertr_nichtKlinisch, na.rm = T)
n_nichtKlinisch <- length(vertr_nichtKlinisch[!is.na(vertr_nichtKlinisch)])
sd_nichtKlinisch <- sigma_nichtKlinisch * sqrt((n_nichtKlinisch-1) / n_nichtKlinisch)
sd_nichtKlinisch

vertr_klinisch <- fb24$vertr[fb24$fach_klin=="klinisch"]
sigma_klinisch <- sd(vertr_klinisch, na.rm = T)
n_klinisch <- length(vertr_klinisch[!is.na(vertr_klinisch)])
sd_klinisch <- sigma_klinisch * sqrt((n_klinisch-1) / n_klinisch)
sd_klinisch

library(car)

# Gruppe 1 (nichtKlinisch) 
par(mfrow=c(1,2))

lz_nichtKlinisch <- fb24[(fb24$fach_klin=="nicht klinisch"), "lz"]

hist(lz_nichtKlinisch, 
     xlim=c(1,7), ylim=c(0,.8), 
     main="Lebenszufriedenheit (nicht klinisch)", 
     xlab="", ylab="", 
     las=1, probability=T)
curve(dnorm(x, 
            mean = mean(lz_nichtKlinisch, na.rm=T), 
            sd = sd(lz_nichtKlinisch, na.rm=T)), 
      col="blue", lwd=2, add=T)

qqPlot(lz_nichtKlinisch)

dev.off()

# Gruppe 2 (klinisch) 
par(mfrow=c(1,2))

lz_klinisch <- fb24[(fb24$fach_klin=="klinisch"), "lz"]
hist(lz_klinisch, 
     xlim=c(1,7), ylim=c(0,.8), 
     main="Lebenszufriedenheit (klinisch)", 
     xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, 
            mean = mean(lz_klinisch, na.rm=T),
            sd = sd(lz_klinisch, na.rm=T)), 
      col="blue", lwd=2, add=T)

qqPlot(lz_klinisch)

dev.off()

leveneTest(fb24$lz ~ fb24$fach_klin)



t.test(fb24$lz ~ fb24$fach_klin,     # abhängige Variable ~ unabhängige Variable
      #paired = FALSE,                  # Stichproben sind unabhängig (Default) 
      alternative = "two.sided",        # zweiseitige Testung (Default)
      var.equal = TRUE,                 # Homoskedastizität liegt vor (-> Levene-Test)
      conf.level = .95)                 # alpha = .05 (Default)



lz_nichtKlinisch <- fb24[(fb24$fach_klin=="nicht klinisch"), "lz"]
mw_nichtKlinisch <- mean(lz_nichtKlinisch, na.rm=T)
n_nichtKlinisch <- sum(!is.na(lz_nichtKlinisch))
sigma_qu_nichtKlinisch <- var(lz_nichtKlinisch, na.rm=T) 

lz_klinisch <- fb24[(fb24$fach_klin=="klinisch"), "lz"]
mw_klinisch <- mean(lz_klinisch, na.rm=T)
n_klinisch <- sum(!is.na(lz_klinisch))
sigma_qu_klinisch <- var(lz_klinisch, na.rm=T) 

sigma_inn <- sqrt((sigma_qu_nichtKlinisch* (n_nichtKlinisch - 1) + sigma_qu_klinisch* (n_klinisch - 1)) / (n_nichtKlinisch-1 + n_klinisch-1))

d1 <- (mw_nichtKlinisch - mw_klinisch) / sigma_inn
d1

# install.packages("effsize")
library("effsize")

d2 <- cohen.d(fb24$lz, fb24$fach_klin, na.rm=T)
d2

# Gruppierter Boxplot:
boxplot(fb24$gs_pre ~ fb24$fach_klin, 
        xlab="Interesse", ylab="Gute Stimmung", 
        las=1, cex.lab=1.5, 
        main="Gute Stimmung nach Interesse")

describeBy(fb24$gs_pre, fb24$fach_klin) # beide Gruppen im Vergleich

# Gruppe 1 (nicht klinisch) 
par(mfrow=c(1,2))
gs_nichtKlinisch <- fb24[(fb24$fach_klin=="nicht klinisch"), "gs_pre"]
hist(gs_nichtKlinisch, xlim=c(1,4), ylim=c(0,.8), main="Gute Sitmmung (nicht klin.)", xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, mean=mean(gs_nichtKlinisch, na.rm=T), sd=sd(gs_nichtKlinisch, na.rm=T)), col="blue", lwd=2, add=T)
qqPlot(gs_nichtKlinisch)
# Gruppe 2 (klinisch) 
par(mfrow=c(1,2))
gs_klinisch <- fb24[(fb24$fach_klin=="klinisch"), "gs_pre"]
hist(gs_klinisch, xlim=c(1,4), ylim=c(0,.8), main="Gute Stimmung (klin.)", xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, mean=mean(gs_klinisch, na.rm=T), sd=sd(gs_klinisch, na.rm=T)), col="blue", lwd=2, add=T)
qqPlot(gs_klinisch)

leveneTest(fb24$gs_pre ~ fb24$fach_klin)



levels(fb24$fach_klin) # wichtig zu wissen: die erste der beiden Faktorstufen ist "nicht klinisch" 

wilcox.test(fb24$gs_pre ~ fb24$fach_klin,     # abhängige Variable ~ unabhängige Variable
            #paired = FALSE,              # Stichproben sind unabhängig (Default)
            alternative = "greater",      # einseitige Testung
            conf.level = .95)             # alpha = .05






is.factor(fb24$ort)
is.factor(fb24$job)

# Achtung, nur einmal durchführen (ansonsten Datensatz neu einladen und Code erneut durchlaufen lassen!)
fb24$ort <- factor(fb24$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb24$job <- factor(fb24$job, levels=c(1,2), labels=c("nein", "ja"))


tab <- table(fb24$ort, fb24$job)
tab

tab_mar <- addmargins(tab) # Randsummen zu Tabelle hinzufügen
tab_mar

expected <- data.frame(nein=c((tab_mar[1,3]*tab_mar[3,1])/tab_mar[3,3],
                              (tab_mar[2,3]*tab_mar[3,1])/tab_mar[3,3]),
                       ja=c((tab_mar[1,3]*tab_mar[3,2])/tab_mar[3,3],
                            (tab_mar[2,3]*tab_mar[3,2])/tab_mar[3,3]))
expected

chi_quadrat_Wert <- (tab[1,1]-expected[1,1])^2/expected[1,1]+
                    (tab[1,2]-expected[1,2])^2/expected[1,2]+
                    (tab[2,1]-expected[2,1])^2/expected[2,1]+
                    (tab[2,2]-expected[2,2])^2/expected[2,2]
chi_quadrat_Wert

qchisq(.95, 1) # kritischer Wert
pchisq(chi_quadrat_Wert, 1, lower.tail = FALSE) # p-Wert

chisq.test(tab,        # Kreuztabelle
           correct=F)  # keine Kontinuinitätskorrektur nach Yates

effekt_YulesQ <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
                 (tab[1,1]*tab[2,2]+tab[1,2]*tab[2,1])
effekt_YulesQ

effekt_phi <- (tab[1,1]*tab[2,2]-tab[1,2]*tab[2,1])/
  sqrt((tab[1,1]+tab[1,2])*(tab[1,1]+tab[2,1])*(tab[1,2]+tab[2,2])*(tab[2,1]+tab[2,2]))
effekt_phi

# alternativ mit psych Paket
library(psych)
phi(tab, digits = 8)
Yule(tab)

# Äquivalentes Ergebnis mittels Pearson-Korrelation (kommt in den nächsten Sitzungen)
# (dichotome Variablen)
ort_num <- as.numeric(fb24$ort)
job_num <- as.numeric(fb24$job)
cor(ort_num, job_num, use="pairwise")
