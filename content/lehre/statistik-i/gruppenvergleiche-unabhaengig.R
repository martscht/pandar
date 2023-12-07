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

# Rekodierung invertierter Items
fb23$mdbf4_pre_r <- -1 * (fb23$mdbf4_pre - 4 - 1)
fb23$mdbf11_pre_r <- -1 * (fb23$mdbf11_pre - 4 - 1)
fb23$mdbf3_pre_r <-  -1 * (fb23$mdbf3_pre - 4 - 1)
fb23$mdbf9_pre_r <-  -1 * (fb23$mdbf9_pre - 4 - 1)

# Berechnung von Skalenwerten
fb23$gs_pre  <- fb23[, c('mdbf1_pre', 'mdbf4_pre_r', 
                        'mdbf8_pre', 'mdbf11_pre_r')] |> rowMeans()
fb23$ru_pre <-  fb23[, c("mdbf3_pre_r", "mdbf6_pre", 
                         "mdbf9_pre_r", "mdbf12_pre")] |> rowMeans()

# z-Standardisierung
fb23$ru_pre_zstd <- scale(fb23$ru_pre, center = TRUE, scale = TRUE)


fb23$fach_klin <- factor(as.numeric(fb23$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))

is.factor(fb23$fach_klin)

levels(fb23$fach_klin)

table(fb23$fach_klin)

# Gruppierter Boxplot :
boxplot(fb23$vertr ~ fb23$fach_klin, 
        xlab="Interesse", ylab="Verträglichkeit", 
        las=1, cex.lab=1.5, 
        main="Verträglichkeit je nach Interesse")

# Je ein Histogramm pro Gruppe, untereinander dargestellt, vertikale Linie für den jeweiligen Mittelwert
par(mfrow=c(2,1), mar=c(3,2,2,0))
hist(fb23[(fb23$fach_klin=="nicht klinisch"), "vertr"], main="(nicht klinisch)", 
     xlim=c(0,6), xlab="", ylab="", las=1)
abline(v=mean(fb23[(fb23$fach_klin=="nicht klinisch"), "vertr"], na.rm=T), col="aquamarine3", lwd=3)
hist(fb23[(fb23$fach_klin=="klinisch"), "vertr"], main="(klinisch)", 
     xlim=c(0,6), xlab="", ylab="", las=1)
abline(v=mean(fb23[(fb23$fach_klin=="klinisch"), "vertr"], na.rm=T), col="darksalmon", lwd=3)

dev.off()

library(psych)
describeBy(x = fb23$vertr, group = fb23$fach_klin)        # beide Gruppen im Vergleich 

vertr_nichtKlinisch <- fb23$vertr[fb23$fach_klin=="nicht klinisch"]
sigma_nichtKlinisch <- sd(vertr_nichtKlinisch, na.rm = T)
n_nichtKlinisch <- length(vertr_nichtKlinisch[!is.na(vertr_nichtKlinisch)])
sd_nichtKlinisch <- sigma_nichtKlinisch * sqrt((n_nichtKlinisch-1) / n_nichtKlinisch)
sd_nichtKlinisch

vertr_klinisch <- fb23$vertr[fb23$fach_klin=="klinisch"]
sigma_klinisch <- sd(vertr_klinisch, na.rm = T)
n_klinisch <- length(vertr_klinisch[!is.na(vertr_klinisch)])
sd_klinisch <- sigma_klinisch * sqrt((n_klinisch-1) / n_klinisch)
sd_klinisch

# Gruppe 1 (nichtKlinisch) 
par(mfrow=c(1,2))

vertr_nichtKlinisch <- fb23[(fb23$fach_klin=="nicht klinisch"), "vertr"]

hist(vertr_nichtKlinisch, 
     xlim=c(0,6), ylim=c(0,.8), 
     main="Verträglichkeit (nicht klinisch)", 
     xlab="", ylab="", 
     las=1, probability=T)
curve(dnorm(x, 
            mean = mean(vertr_nichtKlinisch, na.rm=T), 
            sd = sd(vertr_nichtKlinisch, na.rm=T)), 
      col="blue", lwd=2, add=T)

qqnorm(vertr_nichtKlinisch)
qqline(vertr_nichtKlinisch, col="blue")

dev.off()

# Gruppe 2 (klinisch) 
par(mfrow=c(1,2))

vertr_klinisch <- fb23[(fb23$fach_klin=="klinisch"), "vertr"]
hist(vertr_klinisch, 
     xlim=c(0,6), ylim=c(0,.8), 
     main="Verträglichkeit (klinisch)", 
     xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, 
            mean = mean(vertr_klinisch, na.rm=T),
            sd = sd(vertr_klinisch, na.rm=T)), 
      col="blue", lwd=2, add=T)

qqnorm(vertr_klinisch)
qqline(vertr_klinisch, col="blue")

dev.off()

library(car)
leveneTest(fb23$vertr ~ fb23$fach_klin)

levene <- leveneTest(fb23$vertr ~ fb23$fach_klin)
f <- round(levene$`F value`[1], 2)
p <- round(levene$`Pr(>F)`[1], 3)

t.test(fb23$vertr ~ fb23$fach_klin,     # abhängige Variable ~ unabhängige Variable
      paired = FALSE,                   # Stichproben sind unabhängig 
      alternative = "two.sided",        # zweiseitige Testung (Default)
      var.equal = TRUE,                 # Homoskedastizität liegt vor (-> Levene-Test)
      conf.level = .95)                 # alpha = .05 (Default)

ttest <- t.test(fb23$vertr ~ fb23$fach_klin, paired = FALSE, alternative = "two.sided", var.equal = TRUE, conf.level = .95)

vertr_nichtKlinisch <- fb23[(fb23$fach_klin=="nicht klinisch"), "vertr"]
mw_nichtKlinisch <- mean(vertr_nichtKlinisch, na.rm=T)
n_nichtKlinisch <- length(vertr_nichtKlinisch[!is.na(vertr_nichtKlinisch)])
sigma_qu_nichtKlinisch <- var(vertr_nichtKlinisch, na.rm=T) 

vertr_klinisch <- fb23[(fb23$fach_klin=="klinisch"), "vertr"]
mw_klinisch <- mean(vertr_klinisch, na.rm=T)
n_klinisch <- length(vertr_klinisch[!is.na(vertr_klinisch)])
sigma_qu_klinisch <- var(vertr_klinisch, na.rm=T) 

sigma_inn <- sqrt((sigma_qu_nichtKlinisch* (n_nichtKlinisch - 1) + sigma_qu_klinisch* (n_klinisch - 1)) / (n_nichtKlinisch-1 + n_klinisch-1))

d1 <- (mw_nichtKlinisch - mw_klinisch) / sigma_inn
d1

# install.packages("effsize")
library("effsize")

d2 <- cohen.d(fb23$vertr, fb23$fach_klin, na.rm=T)
d2

# Gruppierter Boxplot:
boxplot(fb23$lz ~ fb23$fach_klin, 
        xlab="Interesse", ylab="lz", 
        las=1, cex.lab=1.5, 
        main="Lebenszufriedenheit nach Interesse")

describeBy(fb23$lz, fb23$fach_klin) # beide Gruppen im Vergleich

# Gruppe 1 (nicht klinisch) 
par(mfrow=c(1,2))
lz_nichtKlinisch <- fb23[(fb23$fach_klin=="nicht klinisch"), "lz"]
hist(lz_nichtKlinisch, xlim=c(0,8), ylim=c(0,.8), main="Lebenszufriedenheit (nicht klinisch)", xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, mean=mean(lz_nichtKlinisch, na.rm=T), sd=sd(lz_nichtKlinisch, na.rm=T)), col="blue", lwd=2, add=T)
qqnorm(lz_nichtKlinisch)
qqline(lz_nichtKlinisch, col="blue")
# Gruppe 2 (klinisch) 
par(mfrow=c(1,2))
lz_klinisch <- fb23[(fb23$fach_klin=="klinisch"), "lz"]
hist(lz_klinisch, xlim=c(0,8), ylim=c(0,.8), main="Lebenszufriedenheit (klinisch)", xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, mean=mean(lz_klinisch, na.rm=T), sd=sd(lz_klinisch, na.rm=T)), col="blue", lwd=2, add=T)
qqnorm(lz_klinisch)
qqline(lz_klinisch, col="blue")

leveneTest(fb23$lz ~ fb23$fach_klin)

levene2 <- leveneTest(fb23$lz ~ fb23$fach_klin)
f2 <- round(levene2$`F value`[1], 2)
p2 <- round(levene2$`Pr(>F)`[1], 3)

levels(fb23$fach_klin) # wichtig zu wissen: die erste der beiden Faktorstufen ist "nicht klinisch" 

wilcox.test(fb23$lz ~ fb23$fach_klin,     # abhängige Variable ~ unabhängige Variable
            paired = FALSE,               # Stichproben sind unabhängig
            alternative = "less",         # einseitige Testung
            conf.level = .95)             # alpha = .05


wilcox <- wilcox.test(fb23$lz ~ fb23$fach_klin, paired = FALSE, alternative = "less", conf.level = .95, exact = TRUE)

deskr <- describeBy(fb23$lz, fb23$fach_klin) # beide Gruppen im Vergleich

is.factor(fb23$ort)
is.factor(fb23$job)

# Achtung, nur einmal durchführen (ansonsten Datensatz neu einladen und Code erneut durchlaufen lassen!)
fb23$ort <- factor(fb23$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb23$job <- factor(fb23$job, levels=c(1,2), labels=c("nein", "ja"))


tab <- table(fb23$ort, fb23$job)
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
ort_num <- as.numeric(fb23$ort)
job_num <- as.numeric(fb23$job)
cor(ort_num, job_num, use="pairwise")
