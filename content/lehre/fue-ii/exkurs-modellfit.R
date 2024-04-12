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

fit_H1_kov <- sem(model_H1_kov, data)
fit_H1_Struk <- sem(model_H1_Struk, data)

fitmeasures(fit_H0, c("chisq", 'df', "pvalue"))
fitmeasures(fit_H1_kov, c("chisq", 'df', "pvalue"))
fitmeasures(fit_H1_Struk, c("chisq", 'df', "pvalue"))



set.seed(123456)
data <- simulateData(model = pop_model_H0, meanstructure = F, sample.nobs = 1000)
fit_H0 <- sem(model = model_H0, data = data)
fit_H1_kov <- sem(model_H1_kov, data)
fit_H1_Struk <- sem(model_H1_Struk, data)

fitmeasures(fit_H0, c("chisq", 'df', "pvalue"))
fitmeasures(fit_H1_kov, c("chisq", 'df', "pvalue"))
fitmeasures(fit_H1_Struk, c("chisq", 'df', "pvalue"))
