library(lavaan)
library(semPlot)

## Example of a Full LISREL model path diagram with the same number of
## exgenous and endogenous variables:

# Lambda matrices:
LoadingsY <- matrix(c(1,0,
                      1,0,
                      0,1,
                      0,1),4,2, byrow = T)
LoadingsX <- as.matrix(c(1,1,1))

# Phi and Psi matrices:
Phi <- diag(1, 1, 1)
Psi <- diag(2)

# Beta matrix:
Beta <- matrix(0, 2, 2)
Beta[2, 1] <- 1

# Theta matrices:
ManVarX <- diag(1, nrow(LoadingsX), nrow(LoadingsX))
ManVarX[2,1] <- 1; ManVarX[1,2] <- 1
ManVarY <- diag(1, nrow(LoadingsY), nrow(LoadingsY))

# Gamma matrix:
Gamma <- as.matrix(c(1,1))

# Tau matrices:
tauX <- rep(0, nrow(LoadingsX))
tauY <- rep(0, nrow(LoadingsY))


# Alpha and Kappa matrices:
LatInts <- rep(0, 2)

# Combine model:
mod <- lisrelModel(LY = LoadingsY, PS = Psi, BE = Beta, TE = ManVarY, LX = LoadingsX,
    PH = Phi, GA = Gamma, TD = ManVarX, TY = tauY, TX = tauX, AL = c(0),
    KA = LatInts)

# Plot path diagram:
semPaths(mod, as.expression = c("nodes", "edges"), sizeMan = 5, sizeInt = 3,
    sizeLat = 7, label.prop = 1, layout = "tree2", edge.label.cex = 1)

pop_model_H0 <- '
# Messmodelle
Xi1 =~ x1 + 0.7*x2 + 0.6*x3
Eta1 =~ y1 + 0.8*y2
Eta2 =~ y3 + 0.9*y4

# Strukturmodell
Eta1 ~ 0.5*Xi1
Eta2 ~ 0.54*Xi1 + 0.4*Eta1

# Fehlerkovarianzen
x1 ~~ 0.4*x2
'

set.seed(123456)
data <- simulateData(model = pop_model_H0, meanstructure = F, sample.nobs = 200)

## head(data)

print(head(data))

model_H0 <- '
# Messmodelle
Xi1 =~ x1 + x2 + x3
Eta1 =~ y1 + y2
Eta2 =~ y3 + y4

# Strukturmodell
Eta1 ~ Xi1
Eta2 ~ Xi1 + Eta1

# Fehlerkovarianzen
x1 ~~ x2
'

fit_H0 <- sem(model = model_H0, data = data)
semPaths(fit_H0, curve = T, curvePivot = T)

fit_H0 <- sem(model = model_H0, data = data)
fit_H0

fit_H0

fitmeasures(fit_H0, c("chisq", 'df', "pvalue"))

model_H1_kov <- '
# Messmodelle
Xi1 =~ x1 + x2 + x3
Eta1 =~ y1 + y2
Eta2 =~ y3 + y4

# Strukturmodell
Eta1 ~ Xi1
Eta2 ~ Xi1 + Eta1
'

semPaths(sem(model_H1_kov, data))

model_H1_Struk <- '
# Messmodelle
Xi1 =~ x1 + x2 + x3
Eta1 =~ y1 + y2
Eta2 =~ y3 + y4

# Strukturmodell
Eta1 ~ Xi1
Eta2 ~ Eta1

# Fehlerkovarianzen
x1 ~~ x2
'

semPaths(sem(model_H1_Struk, data))

## fit_H1_kov <- sem(model_H1_kov, data)
## fit_H1_Struk <- sem(model_H1_Struk, data)
## 
## fitmeasures(fit_H0, c("chisq", 'df', "pvalue"))
## fitmeasures(fit_H1_kov, c("chisq", 'df', "pvalue"))
## fitmeasures(fit_H1_Struk, c("chisq", 'df', "pvalue"))

fit_H1_kov <- sem(model_H1_kov, data)
fit_H1_Struk <- sem(model_H1_Struk, data)

cat("H0:")
print(round(fitmeasures(fit_H0, c("chisq", 'df', "pvalue")), 3))
cat("H1: Fehlerkovarianz")
print(round(fitmeasures(fit_H1_kov, c("chisq", 'df', "pvalue")), 3))
cat("H1: Vollständige Mediation")
print(round(fitmeasures(fit_H1_Struk, c("chisq", 'df', "pvalue")), 3))

set.seed(123456)
data <- simulateData(model = pop_model_H0, meanstructure = F, sample.nobs = 1000)
fit_H0 <- sem(model = model_H0, data = data)
fit_H1_kov <- sem(model_H1_kov, data)
fit_H1_Struk <- sem(model_H1_Struk, data)

## fitmeasures(fit_H0, c("chisq", 'df', "pvalue"))
## fitmeasures(fit_H1_kov, c("chisq", 'df', "pvalue"))
## fitmeasures(fit_H1_Struk, c("chisq", 'df', "pvalue"))

cat("H0:")
print(round(fitmeasures(fit_H0, c("chisq", 'df', "pvalue")), 3))
cat("H1: Fehlerkovarianz")
print(round(fitmeasures(fit_H1_kov, c("chisq", 'df', "pvalue")), 3))
cat("H1: Vollständige Mediation")
print(round(fitmeasures(fit_H1_Struk, c("chisq", 'df', "pvalue")), 3))
