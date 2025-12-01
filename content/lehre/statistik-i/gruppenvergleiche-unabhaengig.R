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
fb25$mdbf11_r <- -1 * (fb25$mdbf4 - 5)
fb25$mdbf3_r <- -1 * (fb25$mdbf4 - 5)
fb25$mdbf9_r <- -1 * (fb25$mdbf4 - 5)

# Berechnung von Skalenwerten
fb25$gs_pre  <- fb25[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()
fb25$ru_pre <-  fb25[, c("mdbf3_r", "mdbf6", 
                         "mdbf9_r", "mdbf12")] |> rowMeans()

# z-Standardisierung
fb25$ru_pre_zstd <- scale(fb25$ru_pre, center = TRUE, scale = TRUE)



## Vorbereitung 

fb25$fach_klin <- factor(as.numeric(fb25$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))

## Deskriptivstatistik

table(fb25$fach_klin)

# Gruppierter Boxplot :
boxplot(fb25$lz ~ fb25$fach_klin, 
        xlab="Interesse", ylab="Lebenszufriedenheit", 
        las=1, cex.lab=1.5, 
        main="Lebenszufriedenheit je nach Interesse")

library(psych)
describeBy(x = fb25$lz, group = fb25$fach_klin)        # beide Gruppen im Vergleich 

# Werte in LZ für beide Gruppen, nur gültige Werte
lz_nichtKlin <- fb25$lz[fb25$fach_klin=="nicht klinisch"] |> na.omit()
lz_Klin <- fb25$lz[fb25$fach_klin=="klinisch"] |> na.omit()

# Gruppengrößen
n_nichtKlin <- length(lz_nichtKlin)
n_Klin      <- length(lz_Klin)

# Stichproben-Standardabweichungen
sd_nichtKlin <- sd(lz_nichtKlin) * sqrt((n_nichtKlin-1) / n_nichtKlin)
sd_nichtKlin
sd_Klin      <- sd(lz_Klin) * sqrt((n_Klin-1) / n_Klin)
sd_Klin


## Voraussetzungsprüfung
library(car)

# Gruppe 1 (nichtKlinisch) 
par(mfrow=c(1,2))

hist(lz_nichtKlin, 
     xlim=c(1,7), ylim=c(0,.5), 
     main="Lebenszufriedenheit (nicht klinisch)", 
     xlab="", ylab="", 
     las=1, probability=T)
curve(dnorm(x, 
            mean = mean(lz_nichtKlin), 
            sd = sd(lz_nichtKlin)), 
      col="blue", lwd=2, add=T)

qqPlot(lz_nichtKlin)

dev.off()

# Gruppe 2 (klinisch) 
par(mfrow=c(1,2))

hist(lz_Klin, 
     xlim=c(1,7), ylim=c(0,.5), 
     main="Lebenszufriedenheit (klinisch)", 
     xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, 
            mean = mean(lz_Klin, na.rm=T),
            sd = sd(lz_Klin, na.rm=T)), 
      col="blue", lwd=2, add=T)

qqPlot(lz_Klin)

dev.off()

leveneTest(fb25$lz ~ fb25$fach_klin)



## t-Test

t.test(fb25$lz ~ fb25$fach_klin,     # abhängige Variable ~ unabhängige Variable
      #paired = FALSE,                  # Stichproben sind unabhängig (Default) 
      alternative = "two.sided",        # zweiseitige Testung (Default)
      var.equal = TRUE,                 # Homoskedastizität liegt vor (-> Levene-Test)
      conf.level = .95)                 # alpha = .05 (Default)



library("effsize")
d <- cohen.d(fb25$lz, fb25$fach_klin, na.rm=T)
d

mw_nichtKlin <- mean(lz_nichtKlin)
mw_Klin <- mean(lz_Klin, na.rm=T)


# Gruppierter Boxplot:
boxplot(fb25$gs_pre ~ fb25$fach_klin, 
        xlab="Interesse", ylab="Gute Stimmung", 
        las=1, cex.lab=1.5, 
        main="Gute Stimmung nach Interesse")

describeBy(fb25$gs_pre, fb25$fach_klin) # beide Gruppen im Vergleich

## Voraussetzungsprüfung Median

# Gruppe 1 (nicht klinisch) 
par(mfrow=c(1,2))
gs_nichtKlinisch <- fb25[(fb25$fach_klin=="nicht klinisch"), "gs_pre"] |> na.omit()
hist(gs_nichtKlinisch, xlim=c(1,4), ylim=c(0,.9), main="Gute Sitmmung (nicht klin.)", xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, mean=mean(gs_nichtKlinisch, na.rm=T), sd=sd(gs_nichtKlinisch, na.rm=T)), col="blue", lwd=2, add=T)
gs_klinisch <- fb25[(fb25$fach_klin=="klinisch"), "gs_pre"] |> na.omit()
hist(gs_klinisch, xlim=c(1,4), ylim=c(0,.9), main="Gute Stimmung (klin.)", xlab="", ylab="", las=1, probability=T)
curve(dnorm(x, mean=mean(gs_klinisch, na.rm=T), sd=sd(gs_klinisch, na.rm=T)), col="blue", lwd=2, add=T)

# Wilcoxon

levels(fb25$fach_klin) # wichtig zu wissen: die erste der beiden Faktorstufen ist "nicht klinisch" 

wilcox.test(fb25$gs_pre ~ fb25$fach_klin,     # abhängige Variable ~ unabhängige Variable
            #paired = FALSE,              # Stichproben sind unabhängig (Default)
            alternative = "greater",      # einseitige Testung
            conf.level = .95)             # alpha = .05






## Appendix

is.factor(fb25$ort)
is.factor(fb25$job)

# Achtung, nur einmal durchführen (ansonsten Datensatz neu einladen und Code erneut durchlaufen lassen!)
fb25$ort <- factor(fb25$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb25$job <- factor(fb25$job, levels=c(1,2), labels=c("nein", "ja"))


tab <- table(fb25$ort, fb25$job)
tab

## Chi-Quadrat

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
ort_num <- as.numeric(fb25$ort)
job_num <- as.numeric(fb25$job)
cor(ort_num, job_num, use="pairwise")
