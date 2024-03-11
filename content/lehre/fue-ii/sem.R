abbrev <- function(X, begin = 'Latent Variables', end = NULL, ellipses = 'both', shift = 2, ...) {

  tmp <- capture.output(lavaan::summary(X,...))

  if (is.null(begin)) begin <- 1
  else begin <- grep(begin, tmp, fixed = TRUE)[1]
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


library(lavaan)
library(semPlot) # grafische Darstellung von Pfadanalyse- und Strukturgleichungsmodellen

## load("C:/Users/Musterfrau/Desktop/StressAtWork.rda")

#load(url("https://pandar.netlify.app/post/StressAtWork.rda"))
load(url("https://courageous-donut-84b9e9.netlify.app/post/StressAtWork.rda"))

head(StressAtWork)
names(StressAtWork)
dim(StressAtWork)

StressAtWork$ZDs <- rowMeans(StressAtWork[,paste0("zd",c(1, 2, 6))])
StressAtWork$BOEEs <- rowMeans(StressAtWork[,paste0("bo",c(1, 6, 12, 19))])
StressAtWork$BFs <- rowMeans(StressAtWork[,paste0("bf",1:20)])

model_paths <- '
BOEEs ~ ZDs
BFs ~  BOEEs + ZDs
'

model_paths_lavaan <- '
BOEEs ~ ZDs
BFs ~  BOEEs + ZDs
BOEEs ~~ BOEEs
BFs ~~ BFs
'

fit_paths <- sem(model_paths, data = StressAtWork)
summary(fit_paths, rsq = T, fit.measures = T)

lavaan::summary(fit_paths, rsq = T, fit.measures = T)

abbrev(X = fit_paths, begin = "Model Test User Model", end = "Model Test Baseline Model", fit.measures = T)

abbrev(X = fit_paths, begin = "User Model versus Baseline Model", end = "Parameter Estimates", fit.measures = T)

abbrev(X = fit_paths, begin = "Regressions", end = "Variances", fit.measures = T)

abbrev(X = fit_paths, begin = "R-Square", end = NULL, shift = 1, rsq = T)

semPaths(fit_paths)

semPaths(fit_paths, what = "est")

semPaths(object = fit_paths, what = "model", layout = "tree2", rotation = 2,
         col = list(man = "skyblue"),  edge.label.cex=1, sizeMan = 5)

semPaths(object = fit_paths, what = "est", layout = "tree2", rotation = 2,
         col = list(man = "skyblue"),  edge.label.cex=1, sizeMan = 5)

model_paths_abc <- '
BOEEs ~ a*ZDs
BFs ~  b*BOEEs + c*ZDs
'

fit_paths_abc <- sem(model_paths_abc, data = StressAtWork)
summary(fit_paths_abc)

abbrev(fit_paths_abc, begin = "Regressions", end = "Variances")

model_paths_IE_TE <- '
BOEEs ~ a*ZDs
BFs ~  b*BOEEs + c*ZDs

# Neue Parameter
IE := a*b
TE := IE + c
'

fit_paths_IE_TE <- sem(model_paths_IE_TE, data = StressAtWork)
summary(fit_paths_IE_TE)

abbrev(fit_paths_IE_TE, begin = "Defined Parameters", shift = 1)

## set.seed(1234)
## fit_paths_IE_TE_boot  <- sem(model_paths_IE_TE, data = StressAtWork, se = "boot", bootstrap = 1000)
## parameterEstimates(fit_paths_IE_TE_boot, ci = TRUE)

#load(url("https://pandar.netlify.app/daten/fit_paths_IE_TE_boot.RData"))
load(url("https://courageous-donut-84b9e9.netlify.app/post/fit_paths_IE_TE_boot.RData"))
cat("[...]")
print(parameterEstimates(fit_paths_IE_TE_boot, ci = TRUE)[7:8,])
cat("[...]")

semPaths(object = fit_paths_IE_TE, what = "model", layout = "tree2", rotation = 2,
         col = list(man = "skyblue"),  edge.label.cex=1)

model_paths_IE_TE <- '
BOEEs ~ a*ZDs
BFs ~  b*BOEEs + c*ZDs

# Neue Parameter
IE := a*b
TE := IE + c
'

model_sem_IE_TE <- '
# Messmodelle
ZD =~ zd1 + zd2 + zd6
BOEE =~ bo1 + bo6 + bo12 + bo19

# Strukturmodell
BOEE ~ a*ZD
BFs ~  b*BOEE + c*ZD

# Neue Parameter
IE := a*b
TE := IE + c
'

fit_sem_IE_TE <- sem(model_sem_IE_TE, StressAtWork)

abbrev(fit_sem_IE_TE, begin = "Model Test User Model", end = "Parameter Estimates", fit.measures = T, rsq = T)

abbrev(fit_sem_IE_TE, begin = "Latent Variables", end = "Regressions")

abbrev(fit_sem_IE_TE, begin = "R-Square", end = "Defined Parameters", rsq = T)

abbrev(fit_sem_IE_TE, begin = "Regressions", end = "Variances")

abbrev(fit_sem_IE_TE, begin = "R-Square", end = "Defined Parameters", rsq = T)

abbrev(fit_sem_IE_TE, begin = "Defined Parameters", end = NULL, shift = 1)

## set.seed(12345)
## fit_sem_IE_TE_boot  <- sem(model_sem_IE_TE, data = StressAtWork, se = "boot", bootstrap = 1000)
## parameterEstimates(fit_sem_IE_TE_boot, ci = TRUE)

#load(url("https://pandar.netlify.app/post/fit_sem_IE_TE_boot.RData"))
load(url("https://courageous-donut-84b9e9.netlify.app/post/fit_sem_IE_TE_boot.RData"))
print(parameterEstimates(fit_sem_IE_TE_boot, ci = TRUE)[21:22,])

semPaths(object = fit_sem_IE_TE,  what = "model", layout = "tree2",
         rotation = 2, curve = T, col = list(man = "skyblue", lat = "yellow"),
         curvePivot = T,  edge.label.cex=1.2, sizeMan = 5, sizeLat = 8)

semPaths(object = fit_sem_IE_TE, what = "est", layout = "tree2",
         rotation = 2, curve = T, col = list(man = "skyblue", lat = "yellow"),
         curvePivot = T,  edge.label.cex=1.2, sizeMan = 5, sizeLat = 8)

## library(ezCutoffs)
## ezCutoffs(model = model_sem_IE_TE, data = StressAtWork)

cat("Data Generation

  |==================================================| 100% elapsed = 11s  ~  0s

Model Fitting

  |==================================================| 100% elapsed =  8s  ~  0s


      Empirical fit Cutoff (alpha = 0.05)
chisq  18.444008456           29.49324699
cfi     0.999650351            0.97982435
tli     0.999456102            0.96861566
rmsea   0.008993101            0.04575465
srmr    0.027500985            0.04021870")

## model_sem_IE_TE <- '
## # Messmodelle
## ZD =~ zd1 + zd2 + zd6
## BOEE =~ bo1 + bo6 + bo12 + bo19
## 
## # Strukturmodell
## BOEE ~ a*ZD
## BFs ~  b*BOEE + c*ZD
## 
## # Neue Parameter
## IE := a*b
## TE := IE + c
## '

model_sem_IE_TE_tau <- '
# Messmodelle
ZD =~ l1*zd1 + l1*zd2 + l1*zd6
BOEE =~ l2*bo1 + l2*bo6 + l2*bo12 + l2*bo19

# Strukturmodell
BOEE ~ a*ZD
BFs ~  b*BOEE + c*ZD

# Neue Parameter
IE := a*b
TE := IE + c
'

fit_sem_IE_TE_tau <- sem(model_sem_IE_TE_tau, StressAtWork)
summary(fit_sem_IE_TE_tau, fit.measures = T, rsq = T)

abbrev(fit_sem_IE_TE_tau, begin = "Model Test User Model", end = "Parameter Estimates", fit.measures = T, rsq = T)

abbrev(fit_sem_IE_TE_tau, begin = "Latent Variables", end = "Regressions")

lavTestLRT(fit_sem_IE_TE_tau, fit_sem_IE_TE)

resLRT_tau <- lavTestLRT(fit_sem_IE_TE_tau, fit_sem_IE_TE) # freie Faktorladungen passen besser zu den Daten!
