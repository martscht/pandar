abbrev <- function(X, begin = 'Latent Variables', end = NULL, ellipses = 'both', shift = 2, group = 1, ...) {
  
  tmp <- capture.output(lavaan::summary(X,...))
  
  if (is.null(begin)) begin <- 1
  else begin <- grep(begin, tmp, fixed = TRUE)[group]
  if (is.null(end)) end <- length(tmp)-shift
  else end <- grep(end, tmp, fixed = TRUE)[grep(end, tmp, fixed = TRUE) > begin][1]-shift
  
  if (ellipses == 'both') {
    cat('[...]\n', paste(tmp[begin:end], collapse = '\n'), '\n[...]\n')
  }
  if (ellipses == 'top') {
    cat('[...]\n', paste(tmp[begin:end], collapse = '\n'))
  }
  if (ellipses == 'bottom') {
    cat(paste(tmp[begin:end], collapse = '\n'), '\n[...]\n')
  }
  if (ellipses == 'none') {
    cat(paste(tmp[begin:end], collapse = '\n'))
  }
}

d3 <- function(x) {formatC(as.numeric(x), format = 'f', digits = 3)}

## load("C:/Users/Musterfrau/Desktop/StressAtWork.rda")

#load(url("https://pandar.netlify.app/post/StressAtWork.rda"))
load(url("https://courageous-donut-84b9e9.netlify.app/post/StressAtWork.rda"))

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

abbrev(X = fit_sem_MSA, begin = "Number of observations per group", end = "Model Test User Model")

abbrev(X = fit_sem_MSA, begin = "Model Test User Model", end = "Parameter Estimates")

abbrev(X = fit_sem_MSA, begin = "Group 1", end = "Variances")

abbrev(X = fit_sem_MSA, begin = "Group 2", end = "Variances")

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

abbrev(X = fit_sem_IE_TE_MSA, begin = "Regressions", end = "Intercepts")

abbrev(X = fit_sem_IE_TE_MSA, begin = "Regressions", end = "Intercepts", group = 2)

abbrev(X = fit_sem_IE_TE_MSA, begin = "Defined Parameters", end = NULL, shift = 1)

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

abbrev(X = fit_sem_sex_konfigural, begin = "Model Test User Model", end = "Parameter Estimates", fit.measures = T)

fit_sem_sex_metrisch <- sem(model_sem, data = StressAtWork, 
                            group = "sex",
                            group.equal = c("loadings"), 
                            group.partial = c("BFs~1", "BFs~~BFs"))
summary(fit_sem_sex_metrisch, fit.measures = T)

abbrev(X = fit_sem_sex_metrisch, begin = "Model Test User Model", end = "Parameter Estimates", fit.measures = T)

abbrev(X = fit_sem_sex_metrisch, begin = "Group 1", end = "Intercepts")

abbrev(X = fit_sem_sex_metrisch, begin = "Group 2", end = "Intercepts")

## lavTestLRT(fit_sem_sex_metrisch, fit_sem_sex_konfigural)

res_metrisch <- lavTestLRT(fit_sem_sex_metrisch, fit_sem_sex_konfigural)
print(res_metrisch)

fit_sem_sex_skalar <- sem(model_sem, data = StressAtWork, 
                          group = "sex",
                          group.equal = c("loadings", "intercepts"), 
                          group.partial = c("BFs~1", "BFs~~BFs"))
summary(fit_sem_sex_skalar, fit.measures = T)

abbrev(X = fit_sem_sex_skalar, begin = "Group 1", end = "Variances")

abbrev(X = fit_sem_sex_skalar, begin = "Group 2", end = "Variances")

## lavTestLRT(fit_sem_sex_skalar, fit_sem_sex_metrisch)

res_skalar <- lavTestLRT(fit_sem_sex_skalar, fit_sem_sex_metrisch)
print(res_skalar)

fit_sem_sex_strikt <- sem(model_sem, data = StressAtWork, 
                          group = "sex",
                          group.equal = c("loadings", "intercepts", "residuals"), 
                          group.partial = c("BFs~1", "BFs~~BFs"))

## lavTestLRT(fit_sem_sex_strikt, fit_sem_sex_skalar)

res_strikt <- lavTestLRT(fit_sem_sex_strikt, fit_sem_sex_skalar)
print(res_strikt)

fit_sem_sex_voll <- sem(model_sem, data = StressAtWork, 
                        group = "sex",
                        group.equal = c("loadings", "intercepts", "residuals",
                                        "means",          # latente Mittelwerte
                                        "lv.variances",   # latente Varianzen
                                        "lv.covariances", # latente Kovarianzen
                                        "regressions"))   # Strukturparameter (Regressionsgewichte)

## lavTestLRT(fit_sem_sex_voll, fit_sem_sex_strikt)

res_voll <- lavTestLRT(fit_sem_sex_voll, fit_sem_sex_strikt)
print(res_voll)

## summary(fit_sem_sex_strikt)

abbrev(X = fit_sem_sex_strikt, begin = "Group 1", end = "Variances")

abbrev(X = fit_sem_sex_strikt, begin = "Group 2", end = "Variances")

semPaths(object = fit_sem_sex_strikt, what = "est", layout = "tree2",
         rotation = 2, curve = T, col = list(man = "skyblue", lat = "yellow"),
         curvePivot = T,  edge.label.cex=1, sizeMan = 5, sizeLat = 8)

StressAtWork$ZDs <- rowMeans(StressAtWork[,paste0("zd",c(1, 2, 6))])

model_pfad_msa <- 'BFs ~ ZDs'
fit_pfad_msa <- sem(model_pfad_msa, StressAtWork,
  group = 'sex')

## summary(fit_pfad_msa)
abbrev(fit_pfad_msa, 'Regressions:', 'Variances:', group = 1)
abbrev(fit_pfad_msa, 'Regressions:', 'Variances:', group = 2)

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

abbrev(fit_pfad_msa, 'Defined Parameters:', shift = 1)

StressAtWork$sexDum <- StressAtWork$sex - 1
StressAtWork$Int <- StressAtWork$ZDs * StressAtWork$sexDum

head(StressAtWork[, c('ZDs', 'sexDum', 'Int')])

model_pfad_moderiert <- 'BFs ~ ZDs + sexDum + Int'
fit_pfad_moderiert <- sem(model_pfad_moderiert, StressAtWork, meanstructure = T)

abbrev(fit_pfad_moderiert, 'Regressions:', 'Variances:')

tmp <- parameterestimates(fit_pfad_msa)
tmp2 <- parameterestimates(fit_pfad_moderiert)

reg <- lm(BFs ~ factor(sex)*ZDs, data = StressAtWork)
summary(reg)

library(ggplot2)
coefs <- coef(reg)
b0 <- cumsum(coefs[1:2])
b1 <- cumsum(coefs[3:4])
x <- c(-10,10); y <- c(-10,-10)
sex <- factor(c("Männer", "Frauen"))
df <- data.frame(b0, b1, sex, x, y)
ggplot(data = df, mapping = aes(x=x,y=y, col = sex))+geom_line()+xlim(c(-5,5))+ylim(c(0.5,3))+theme_minimal()+
  geom_abline(slope = b1, intercept = b0, col = c("blue", "gold3"), lwd = 2)+
  xlab("Zeitdruck")+ylab("Psychosomatische Beschwerden")+scale_color_manual(values = c("blue", "gold3"))

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

cat("group.equal:")
print(round(fitmeasures(fit_sem_sex_konfigural, c("chisq", 'df', "pvalue")), 3))
cat("zu Fuß/händisch:")
print(round(fitmeasures(fit_sem_sex_konfigural2, c("chisq", 'df', "pvalue")), 3))

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

cat("group.equal:")
print(round(fitmeasures(fit_sem_sex_metrisch, c("chisq", 'df', "pvalue")), 3))
cat("zu Fuß/händisch:")
print(round(fitmeasures(fit_sem_sex_metrisch2, c("chisq", 'df', "pvalue")), 3))

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

cat("group.equal:")
print(round(fitmeasures(fit_sem_sex_skalar, c("chisq", 'df', "pvalue")), 3))
cat("zu Fuß/händisch:")
print(round(fitmeasures(fit_sem_sex_skalar2, c("chisq", 'df', "pvalue")), 3))

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

cat("group.equal:")
print(round(fitmeasures(fit_sem_sex_strikt, c("chisq", 'df', "pvalue")), 3))
cat("zu Fuß/händisch:")
print(round(fitmeasures(fit_sem_sex_strikt2, c("chisq", 'df', "pvalue")), 3))

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

cat("group.equal:")
print(round(fitmeasures(fit_sem_sex_voll, c("chisq", 'df', "pvalue")), 3))
cat("zu Fuß/händisch:")
print(round(fitmeasures(fit_sem_sex_voll2, c("chisq", 'df', "pvalue")), 3))
