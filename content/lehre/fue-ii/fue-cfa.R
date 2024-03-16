load(url("https://pandar.netlify.app/daten/conspiracy_cfa.rda"))

# Anzahl der Personen
nrow(conspiracy)

# Anzahl der Variablen
ncol(conspiracy)

# Struktur des Datensatzes
str(conspiracy)

## 'GC =~ Q2 + Q7 + Q12'

## '# Faktorladungen
## GC =~ Q2 + Q7 + Q12
## 
## # Residualvarianzen
## Q2 ~~ Q2
## Q7 ~~ Q7
## Q12 ~~ Q12'

## '# Faktorladungen
## GC =~ Q2 + Q7 + Q12
## 
## # Residualvarianzen
## Q2 ~~ Q2
## Q7 ~~ Q7
## Q12 ~~ Q12
## 
## # Latente Varianz
## GC ~~ GC'

mod1 <- '# Faktorladungen
GC =~ Q2 + Q7 + Q12

# Residualvarianzen
Q2 ~~ Q2
Q7 ~~ Q7
Q12 ~~ Q12

# Latente Varianz
GC ~~ GC'

fit1 <- lavaan(mod1, conspiracy)

summary(fit1)



3 * (3 + 1) / 2

inspect(fit1, 'sampstat')



inspect(fit1, 'npar')

inspect(fit1, 'free')

free <- inspect(fit1, 'free')
free$theta

mod1 <- '# Faktorladungen
GC =~ 1*Q2 + Q7 + Q12

# Residualvarianzen
Q2 ~~ Q2
Q7 ~~ Q7
Q12 ~~ Q12

# Latente Varianz
GC ~~ GC'

mod1b <- '# Faktorladungen
GC =~ Q2 + Q7 + Q12

# Residualvarianzen
Q2 ~~ Q2
Q7 ~~ Q7
Q12 ~~ Q12

# Latente Varianz
GC ~~ 1*GC'

fit1 <- lavaan(mod1, conspiracy)

inspect(fit1, 'free')

summary(fit1)









inspect(fit1, 'rsquare')

summary(fit1, rsq = TRUE)


mod2 <- '
# Faktorladungen
GC =~ 1*Q2 + Q7 + Q12

# Residualvarianzen
Q2 ~~ Q2
Q7 ~~ Q7
Q12 ~~ Q12

# Latente Varianz
GC ~~ GC

# Intercepts
Q2 ~ 1
Q7 ~ 1
Q12 ~ 1'

fit2 <- lavaan(mod2, conspiracy)

summary(fit2)




mod1_simple <- 'GC =~ Q2 + Q7 + Q12'

fit2_simple <- cfa(mod1_simple, conspiracy,
  meanstructure = TRUE)

mod_two <- '
  GC =~ Q2 + Q7 + Q12
  CI =~ Q5 + Q10 + Q15'

fit_two <- cfa(mod_two, conspiracy,
  meanstructure = TRUE)

# Allgemeiner Überblick
summary(fit_two)

# Reliabilität der sechs Aussagen
inspect(fit_two, 'rsquare')

inspect(fit_two, 'cor.lv')

parameterEstimates(fit_two)



# Parameter in Objekt ablegen
para <- parameterEstimates(fit_two)

# Mittelwerte und Intercepts ausgeben
para[para$op == '~1', ]

summary(fit_two, ci = TRUE)


# Empirische Matrix
inspect(fit_two, 'sampstat')$cov

# Modellimplizierte Matrix
inspect(fit_two, 'cov.ov')

modelfit <- inspect(fit_two, 'fit.measures')

# Namen der Fitstatistiken
names(modelfit)

# LogLikelihood
modelfit['logl']

# LogLikelihood unrestringiertes Modell
modelfit['unrestricted.logl']

modelfit['df']



# Empirische Prüfgröße
emp <- 2 * (modelfit['unrestricted.logl'] - modelfit['logl'])
emp

# p-Wert
pchisq(q = emp, df = 8, lower.tail = FALSE)

# Aus inspect:
modelfit[c('chisq', 'df', 'pvalue')]

# Aufruf des lavaan Objekts
fit_two

modelfit[c('rmsea', 'srmr')]

modelfit[c('cfi', 'tli', 'gfi')]

## library(ezCutoffs)
## cutoff <- ezCutoffs(mod_two, conspiracy)




cutoff

inspect(fit_two, 'residuals')$cov

residuals(fit_two, 'standardized')$cov

modindices(fit_two, sort. = TRUE, minimum.value = 5)


# Modell
mod_three <- '
GC =~ Q2 + Q7 + Q12 + Q5
CI =~ Q5 + Q10 + Q15'

# Schätzung
fit_three <- cfa(mod_three, conspiracy,
meanstructure = TRUE)

summary(fit_three)



lavTestLRT(fit_two, fit_three)

residuals(fit_two, 'standardized')$cov

# Als Objekt anlegen
resi <- residuals(fit_two, 'standardized')$cov

# Varianzen in der Diagonale
diag(resi)

resi[1:3, 1:3]

resi[4:6, 4:6]

resi[4:6, 1:3]

#load(url("https://pandar.netlify.app/daten/stat_test.rda"))
load(url("https://courageous-donut-84b9e9.netlify.app/post/stat_test.rda"))

summary(stat_test)

# Modell
mod1 <- 'stat =~ test1 + test2 + test3'

# Schätzung
fit1 <- cfa(mod1, stat_test,
  meanstructure = TRUE)

summary(fit1)





# Modell
mod2 <- 'stat =~ 1*test1 + 1*test2 + 1*test3'

# Schätzung
fit2 <- cfa(mod2, stat_test,
  meanstructure = TRUE)

summary(fit2)

abbrev(fit2, shift = 1)



lavTestLRT(fit1, fit2)

# Modell
mod3 <- 'stat =~ 1*test1 + 1*test2 + 1*test3
  test1 ~ (alp)*1
  test2 ~ (alp)*1
  test3 ~ (alp)*1'

# Schätzung
fit3 <- cfa(mod3, stat_test,
  meanstructure = TRUE)

summary(fit3)



lavTestLRT(fit2, fit3)



mod4 <- 'stat =~ 1*test1 + 1*test2 + 1*test3
  test1 ~~ (eps)*test1
  test2 ~~ (eps)*test2
  test3 ~~ (eps)*test3'
fit4 <- cfa(mod4, stat_test,
  meanstructure = TRUE)

summary(fit4, rsq = TRUE)



lavTestLRT(fit2, fit4)

mod5 <- 'stat =~ 1*test1 + 1*test2 + 1*test3
  
  test1 ~ (alp)*1
  test2 ~ (alp)*1
  test3 ~ (alp)*1
  
  test1 ~~ (eps)*test1
  test2 ~~ (eps)*test2
  test3 ~~ (eps)*test3'

fit5 <- cfa(mod5, stat_test,
  meanstructure = TRUE)

lavTestLRT(fit1, fit2, fit3, fit5)

lavTestLRT(fit1, fit2, fit4, fit5)
