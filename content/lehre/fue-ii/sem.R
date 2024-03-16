library(lavaan)
library(semPlot) # grafische Darstellung von Pfadanalyse- und Strukturgleichungsmodellen

## load("C:/Users/Musterfrau/Desktop/StressAtWork.rda")

load(url("https://pandar.netlify.app/daten/StressAtWork.rda"))

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



model_paths_IE_TE <- '
BOEEs ~ a*ZDs
BFs ~  b*BOEEs + c*ZDs

# Neue Parameter
IE := a*b
TE := IE + c
'

fit_paths_IE_TE <- sem(model_paths_IE_TE, data = StressAtWork)
summary(fit_paths_IE_TE)



set.seed(1234)
fit_paths_IE_TE_boot  <- sem(model_paths_IE_TE, data = StressAtWork, se = "boot", bootstrap = 1000)
parameterEstimates(fit_paths_IE_TE_boot, ci = TRUE)



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











abbrev(fit_sem_IE_TE, begin = "Defined Parameters", end = NULL, shift = 1)

set.seed(12345)
fit_sem_IE_TE_boot  <- sem(model_sem_IE_TE, data = StressAtWork, se = "boot", bootstrap = 1000)
parameterEstimates(fit_sem_IE_TE_boot, ci = TRUE)



semPaths(object = fit_sem_IE_TE,  what = "model", layout = "tree2",
         rotation = 2, curve = T, col = list(man = "skyblue", lat = "yellow"),
         curvePivot = T,  edge.label.cex=1.2, sizeMan = 5, sizeLat = 8)

semPaths(object = fit_sem_IE_TE, what = "est", layout = "tree2",
         rotation = 2, curve = T, col = list(man = "skyblue", lat = "yellow"),
         curvePivot = T,  edge.label.cex=1.2, sizeMan = 5, sizeLat = 8)

## library(ezCutoffs)
## ezCutoffs(model = model_sem_IE_TE, data = StressAtWork)



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





lavTestLRT(fit_sem_IE_TE_tau, fit_sem_IE_TE)

resLRT_tau <- lavTestLRT(fit_sem_IE_TE_tau, fit_sem_IE_TE) # freie Faktorladungen passen besser zu den Daten!
