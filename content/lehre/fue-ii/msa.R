## load("C:/Users/Musterfrau/Desktop/StressAtWork.rda")

load(url("https://pandar.netlify.app/daten/StressAtWork.rda"))

library(lavaan)
library(semPlot)

StressAtWork$BFs <- rowMeans(StressAtWork[,paste0("bf",1:20)])

model_sem <- '
# Messmodelle
ZD =~ zd1 + zd2 + zd6
BOEE =~ bo1 + bo6 + bo12 + bo19

# Strukturmodell
BOEE ~ ZD
BFs ~  BOEE + ZD
'

fit_sem <- sem(model_sem, StressAtWork)

semPaths(object = fit_sem,  what = "model", layout = "tree2",
         rotation = 2, curve = T, col = list(man = "skyblue", lat = "yellow"),
         curvePivot = T,  edge.label.cex=1.2, sizeMan = 5, sizeLat = 8)

fit_sem_MSA <- sem(model_sem, data = StressAtWork, group = "sex")
summary(fit_sem_MSA)







model_sem_IE_TE_MSA <- '
# Messmodelle
ZD =~ zd1 + zd2 + zd6
BOEE =~ bo1 + bo6 + bo12 + bo19

# Strukturmodell
BOEE ~ c(a1, a2)*ZD
BFs ~  c(b1, b2)*BOEE + c(c1,c2)*ZD

# Neue Parameter
IE1 := a1*b1
TE1 := IE1 + c1

IE2 := a2*b2
TE2 := IE2 + c2
'
fit_sem_IE_TE_MSA <- sem(model_sem_IE_TE_MSA, StressAtWork, group = "sex")
summary(fit_sem_IE_TE_MSA)







semPaths(object = fit_sem_IE_TE_MSA, what = "est", layout = "tree2",
         rotation = 2, curve = T, col = list(man = "skyblue", lat = "yellow"),
         curvePivot = T,  edge.label.cex=1, sizeMan = 5, sizeLat = 8, fade = F)

model_sem <- '
# Messmodelle
ZD =~ zd1 + zd2 + zd6
BOEE =~ bo1 + bo6 + bo12 + bo19

# Strukturmodell
BOEE ~ ZD
BFs ~  BOEE + ZD
'

fit_sem_sex_konfigural <- sem(model_sem, data = StressAtWork, 
                              group = "sex",
                              group.equal = c(""), 
                              group.partial = c("BFs~1", "BFs~~BFs"))
summary(fit_sem_sex_konfigural, fit.measures = T)



fit_sem_sex_metrisch <- sem(model_sem, data = StressAtWork, 
                            group = "sex",
                            group.equal = c("loadings"), 
                            group.partial = c("BFs~1", "BFs~~BFs"))
summary(fit_sem_sex_metrisch, fit.measures = T)





lavTestLRT(fit_sem_sex_metrisch, fit_sem_sex_konfigural)



fit_sem_sex_skalar <- sem(model_sem, data = StressAtWork, 
                          group = "sex",
                          group.equal = c("loadings", "intercepts"), 
                          group.partial = c("BFs~1", "BFs~~BFs"))
summary(fit_sem_sex_skalar, fit.measures = T)



lavTestLRT(fit_sem_sex_skalar, fit_sem_sex_metrisch)



fit_sem_sex_strikt <- sem(model_sem, data = StressAtWork, 
                          group = "sex",
                          group.equal = c("loadings", "intercepts", "residuals"), 
                          group.partial = c("BFs~1", "BFs~~BFs"))

lavTestLRT(fit_sem_sex_strikt, fit_sem_sex_skalar)



fit_sem_sex_voll <- sem(model_sem, data = StressAtWork, 
                        group = "sex",
                        group.equal = c("loadings", "intercepts", "residuals",
                                        "means",          # latente Mittelwerte
                                        "lv.variances",   # latente Varianzen
                                        "lv.covariances", # latente Kovarianzen
                                        "regressions"))   # Strukturparameter (Regressionsgewichte)

lavTestLRT(fit_sem_sex_voll, fit_sem_sex_strikt)



summary(fit_sem_sex_strikt)



semPaths(object = fit_sem_sex_strikt, what = "est", layout = "tree2",
         rotation = 2, curve = T, col = list(man = "skyblue", lat = "yellow"),
         curvePivot = T,  edge.label.cex=1, sizeMan = 5, sizeLat = 8)

StressAtWork$ZDs <- rowMeans(StressAtWork[,paste0("zd",c(1, 2, 6))])

model_pfad_msa <- 'BFs ~ ZDs'
fit_pfad_msa <- sem(model_pfad_msa, StressAtWork,
  group = 'sex')

summary(fit_pfad_msa)


model_pfad_msa <- '
  # Regressionen
  BFs ~ c(b11, b12)*ZDs

  # Interzepte
  BFs ~ c(b01, b02)*1

  # Differenzen
  b0d := b02 - b01
  b1d := b12 - b11'

fit_pfad_msa <- sem(model_pfad_msa, StressAtWork,
  group = 'sex')



StressAtWork$sexDum <- StressAtWork$sex - 1
StressAtWork$Int <- StressAtWork$ZDs * StressAtWork$sexDum

head(StressAtWork[, c('ZDs', 'sexDum', 'Int')])

model_pfad_moderiert <- 'BFs ~ ZDs + sexDum + Int'
fit_pfad_moderiert <- sem(model_pfad_moderiert, StressAtWork, meanstructure = T)





reg <- lm(BFs ~ factor(sex)*ZDs, data = StressAtWork)
summary(reg)



model_sem <- '
# Messmodelle
ZD =~ zd1 + zd2 + zd6
BOEE =~ bo1 + bo6 + bo12 + bo19

# Strukturmodell
BOEE ~ ZD
BFs ~  BOEE + ZD
'

fit_sem_sex_konfigural <- sem(model_sem, data = StressAtWork, group = "sex",
                                     group.equal = c(""), group.partial = c("BFs ~ 1", "BFs ~~*BFs"))
fit_sem_sex_konfigural2 <- sem(model_sem, data = StressAtWork,  group = "sex")

# chi^2, df, p-Wert
fitmeasures(fit_sem_sex_konfigural, c("chisq", 'df', "pvalue"))
fitmeasures(fit_sem_sex_konfigural2, c("chisq", 'df', "pvalue"))



model_sem_metrisch <- '
# Messmodelle
ZD =~ zd1 + c(l1, l1)*zd2 + c(l2, l2)*zd6
BOEE =~ bo1 + c(l3,l3)*bo6 + c(l4, l4)*bo12 + c(l5, l5)*bo19

# Strukturmodell
BOEE ~ ZD
BFs ~  BOEE + ZD'

fit_sem_sex_metrisch <- sem(model_sem, data = StressAtWork, 
                            group = "sex",
                            group.equal = c("loadings"), 
                            group.partial = c("BFs~1", "BFs ~~BFs"))
fit_sem_sex_metrisch2 <- sem(model_sem_metrisch, data = StressAtWork,  
                             group = "sex")

# chi^2, df, p-Wert
fitmeasures(fit_sem_sex_metrisch, c("chisq", 'df', "pvalue"))
fitmeasures(fit_sem_sex_metrisch2, c("chisq", 'df', "pvalue"))



model_sem_skalar <- '
# Messmodelle
ZD =~ zd1 + c(l1, l1)*zd2 + c(l2, l2)*zd6
BOEE =~ bo1 + c(l3,l3)*bo6 + c(l4, l4)*bo12 + c(l5, l5)*bo19

zd1 ~ c(tau1, tau1)*1
zd2 ~ c(tau2, tau2)*1
zd6 ~ c(tau3, tau3)*1

bo1 ~ c(tau4, tau4)*1
bo6 ~ c(tau5, tau5)*1
bo12 ~ c(tau6, tau6)*1
bo19 ~ c(tau7, tau7)*1

# Strukturmodell
BOEE ~ ZD
BFs ~  BOEE + ZD

BOEE ~ c(0, NA)*1
ZD ~ c(0, NA)*1
'

fit_sem_sex_skalar <- sem(model_sem, data = StressAtWork, 
                          group = "sex",
                          group.equal = c("loadings", "intercepts"), 
                          group.partial = c("BFs~1", "BFs ~~BFs"))
fit_sem_sex_skalar2 <- sem(model_sem_skalar, data = StressAtWork,  group = "sex")

# chi^2, df, p-Wert
fitmeasures(fit_sem_sex_skalar, c("chisq", 'df', "pvalue"))
fitmeasures(fit_sem_sex_skalar2, c("chisq", 'df', "pvalue"))



model_sem_strikt <- '
# Messmodelle
ZD =~ zd1 + c(l1, l1)*zd2 + c(l2, l2)*zd6
BOEE =~ bo1 + c(l3,l3)*bo6 + c(l4, l4)*bo12 + c(l5, l5)*bo19

zd1 ~ c(tau1, tau1)*1
zd2 ~ c(tau2, tau2)*1
zd6 ~ c(tau3, tau3)*1

bo1 ~ c(tau4, tau4)*1
bo6 ~ c(tau5, tau5)*1
bo12 ~ c(tau6, tau6)*1
bo19 ~ c(tau7, tau7)*1

zd1 ~~ c(t1, t1)*zd1
zd2 ~~ c(t2, t2)*zd2
zd6 ~~ c(t3, t3)*zd6

bo1 ~~ c(t4, t4)*bo1
bo6 ~~ c(t5, t5)*bo6
bo12 ~~ c(t6, t6)*bo12
bo19 ~~ c(t7, t7)*bo19

# Strukturmodell
BOEE ~ ZD
BFs ~  BOEE + ZD

BOEE ~ c(0, NA)*1
ZD ~ c(0, NA)*1
'

fit_sem_sex_strikt <- sem(model_sem, data = StressAtWork, 
                          group = "sex",
                          group.equal = c("loadings", "intercepts", "residuals"), 
                          group.partial = c("BFs~1", "BFs~~BFs"))
fit_sem_sex_strikt2 <- sem(model_sem_strikt, data = StressAtWork,  group = "sex")

# chi^2, df, p-Wert
fitmeasures(fit_sem_sex_strikt, c("chisq", 'df', "pvalue"))
fitmeasures(fit_sem_sex_strikt2, c("chisq", 'df', "pvalue"))



model_sem_voll <- '
# Messmodelle
ZD =~ zd1 + c(l1, l1)*zd2 + c(l2, l2)*zd6
BOEE =~ bo1 + c(l3,l3)*bo6 + c(l4, l4)*bo12 + c(l5, l5)*bo19

zd1 ~ c(tau1, tau1)*1
zd2 ~ c(tau2, tau2)*1
zd6 ~ c(tau3, tau3)*1

bo1 ~ c(tau4, tau4)*1
bo6 ~ c(tau5, tau5)*1
bo12 ~ c(tau6, tau6)*1
bo19 ~ c(tau7, tau7)*1

zd1 ~~ c(t1, t1)*zd1
zd2 ~~ c(t2, t2)*zd2
zd6 ~~ c(t3, t3)*zd6

bo1 ~~ c(t4, t4)*bo1
bo6 ~~ c(t5, t5)*bo6
bo12 ~~ c(t6, t6)*bo12
bo19 ~~ c(t7, t7)*bo19

# Strukturmodell
BOEE ~ c(a, a)*ZD
BFs ~  c(b, b)*BOEE + c(c, c)*ZD

BOEE ~ c(0, 0)*1
ZD ~ c(0, 0)*1
BFs ~ c(kappa, kappa)*1

ZD ~~ c(phi, phi)*ZD
BOEE ~~ c(psi1, psi1)*BOEE
BFs ~~ c(psi2, psi2)*BFs
'

fit_sem_sex_voll <- sem(model_sem, data = StressAtWork, 
                        group = "sex",
                        group.equal = c("loadings", "intercepts", "residuals",
                                        "means",          # latente Mittelwerte
                                        "lv.variances",   # latente Varianzen
                                        "lv.covariances", # latente Kovarianzen
                                        "regressions"))   # Strukturparameter (Regressionsgewichte)
fit_sem_sex_voll2 <- sem(model_sem_voll, data = StressAtWork,  
                         group = "sex")

# chi^2, df, p-Wert
fitmeasures(fit_sem_sex_voll, c("chisq", 'df', "pvalue"))
fitmeasures(fit_sem_sex_voll2, c("chisq", 'df', "pvalue"))
