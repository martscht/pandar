# Vorbereitungen
knitr::opts_chunk$set(echo = TRUE, fig.align = "center")
library(ggplot2) # ggplot2 und dplyr werden nur für Grafiken benötigt

## install.packages("metafor")

library(metafor)

help("metafor")

?dat.mcdaniel1994 # Studies on the Validity of Employment Interviews

head(dat.mcdaniel1994)
names(dat.mcdaniel1994)

dat.mcdaniel1994$ri

summary(dat.mcdaniel1994$ri)

plot(rep(1,length(dat.mcdaniel1994$ri)), dat.mcdaniel1994$ri, xaxt = "n", xlab = "Korrelationskoeffizient", ylab = "Korrelation pro Studie",
     main = "Empirische Korrelationen zwischen\n Interview Performanz und Job-Performanz")

boxplot(dat.mcdaniel1994$ri, main = "Empirische Korrelationen zwischen\n Interview Performanz und Job-Performanz")

boxplot_cors <- boxplot(dat.mcdaniel1994$ri, main = "Empirische Korrelationen zwischen\n Interview Performanz und Job-Performanz")

plot(NA, xlim = c(-2,2), ylim = c(-2,2), xlab = "Interview Performanz", ylab = "Job-Performanz",
     main = "Empirische Korrelationen zwischen\n Interview Performanz und Job-Performanz")
for(i in 1:length(dat.mcdaniel1994$ri))
{
     abline(a = 0, b = dat.mcdaniel1994$ri[i], col = "grey80")
}

data_transformed <- escalc(measure="ZCOR", ri=ri, ni=ni, data=dat.mcdaniel1994, var.names = c("z_ri", "v_ri"))
head(data_transformed)

data_transformed_2 <- escalc(measure="ZCOR", ri=dat.mcdaniel1994$ri, ni=dat.mcdaniel1994$ni, var.names = c("z_ri", "v_ri"))
head(data_transformed_2)

1:4
data_transformed$v_ri[1:4]
1/(dat.mcdaniel1994$ni - 3)[1:4] 

plot(x = data_transformed$ri, y = data_transformed$z_ri, xlab = "r", ylab = "z",
     main = "Fisher's z-Transformation")

REM <- rma(yi = z_ri, vi = v_ri, data=data_transformed)
REM

names(REM)

REM$b
REM$tau2

predict(REM, transf=transf.ztor)

pred_REM <- predict(REM, transf=transf.ztor)
names(pred_REM)
pred_REM$pred # retransformierter gepoolter Korrelationskoeffizient

plot(NA, xlim = c(-2,2), ylim = c(-2,2), xlab = "Interview Performanz", ylab = "Job-Performanz",
     main = "Empirische Korrelationen zwischen\n Interview Performanz und Job-Performanz")
for(i in 1:length(dat.mcdaniel1994$ri))
{
     abline(a = 0, b = dat.mcdaniel1994$ri[i], col = "grey80")
}
abline(a = 0, b = pred_REM$ci.lb, col = "blue", lwd = 5)
abline(a = 0, b = pred_REM$ci.ub, col = "blue", lwd = 5)
abline(a = 0, b = pred_REM$cr.lb, col = "gold3", lwd = 5)
abline(a = 0, b = pred_REM$cr.ub, col = "gold3", lwd = 5)
abline(a = 0, b = pred_REM$pred, col = "black", lwd = 5)
legend(x = "bottomright", col = c("black", "blue", "gold3", "grey60"), pch = NA, lwd = c(5,5,5,2),
       legend = c("Mittlere Korr.", "95% KI-Korr.", "Credibility Interval", "Emp. Korr."))

# funnel plot
funnel(REM)

# forest plot
forest(REM, xlim = c(-1, 2))

# kumulativer Forest Plot
forest(cumul.rma.uni(REM), xlim = c(-1, 2))

REM20 <- rma(yi = z_ri, vi = v_ri, data=data_transformed[1:20, ]) # wähle Studie 1 bis 20
# forest plot
forest(REM20, xlim = c(-1, 2))
# kumulativer Forest Plot
forest(cumul.rma.uni(REM20), xlim = c(-1, 2))

data_transformed$type
plot(z_ri ~ factor(type), data=data_transformed, col = c("blue", "gold3", "red"), xlab = "Interviewtyp",
     ylab = "z-transformierte Korrelation", main = "z-transformierte Korrelation pro Interviewtyp")
plot(ri ~ factor(type), data=data_transformed, col = c("blue", "gold3", "red"), xlab = "Interviewtyp",
     ylab = "Korrelation", main = "Korrelation pro Interviewtyp")

MEM_type <- rma(yi = z_ri, vi = v_ri, mods = ~ factor(type), data = data_transformed)
MEM_type

## anova(REM, MEM_type)

cat("Error in anova.rma(REM, MEM_type) : Observed outcomes and/or sampling 
 variances not equal in the full and reduced model.")

is.na(data_transformed$type)        # fehlt ein Wert = TRUE
which(is.na(data_transformed$type)) # welche Werte fehlen?

dim(data_transformed)
data_transformed_clean_type <- data_transformed[!is.na(data_transformed$type), ]
dim(data_transformed_clean_type)

REM_reduced_type <- rma(yi = z_ri, vi = v_ri, data = data_transformed_clean_type)
REM_reduced_type

## anova(REM_reduced_type, MEM_type)

cat("Warning in anova.rma(REM_reduced_type, MEM_type): Models with different fixed
 effects. REML comparisons are not meaningful.")

REM_reduced_type_ML <- rma(yi = z_ri, vi = v_ri, data = data_transformed_clean_type, method = "ML")
MEM_type_ML <- rma(yi = z_ri, vi = v_ri, mods = ~ factor(type), data=data_transformed_clean_type, method = "ML")
anova(REM_reduced_type_ML, MEM_type_ML)

MEM_type_ML

plot(NA, xlim = c(-2,2), ylim = c(-2,2), xlab = "Interview Performanz", ylab = "Job-Performanz",
     main = "Empirische Korrelationen zwischen\n Interview Performanz und Job-Performanz") # erzeuge einen leeren Plot mit vorgegbenen Achsenabschnitten
for(i in 1:length(dat.mcdaniel1994$ri))
{
     abline(a = 0, b = dat.mcdaniel1994$ri[i], col = "grey80") # füge Gerade pro Studie hinzu
}

plot(NA, xlim = c(-2,2), ylim = c(-2,2), xlab = "Interview Performanz", ylab = "Job-Performanz",
     main = "Empirische Korrelationen zwischen\n Interview Performanz und Job-Performanz") # erzeuge einen leeren Plot mit vorgegbenen Achsenabschnitten
for(i in 1:length(dat.mcdaniel1994$ri))
{
     abline(a = 0, b = dat.mcdaniel1994$ri[i], col = "grey80") # füge Gerade pro Studie hinzu
}
abline(a = 0, b = pred_REM$ci.lb, col = "blue", lwd = 5)
abline(a = 0, b = pred_REM$ci.ub, col = "blue", lwd = 5)
abline(a = 0, b = pred_REM$cr.lb, col = "gold3", lwd = 5)
abline(a = 0, b = pred_REM$cr.ub, col = "gold3", lwd = 5)
abline(a = 0, b = pred_REM$pred, col = "black", lwd = 5)
legend(x = "bottomright", col = c("black", "blue", "gold3", "grey60"), pch = NA, lwd = c(5,5,5,2),
       legend = c("Mittlere Korr.", "95% KI-Korr.", "Credibility Interval", "Emp. Korr.")) # Legende für Farbzuordnung

head(dat.bangertdrowns2004)
dat.bangertdrowns2004$yi # std. Mittelwertsdiff.
dat.bangertdrowns2004$ni # n
dat.bangertdrowns2004$vi # Varianz

sum(dat.bangertdrowns2004$ni*dat.bangertdrowns2004$yi)/sum(dat.bangertdrowns2004$ni)

rma_n_FE <- rma(yi = yi, vi =  1/ni, data = dat.bangertdrowns2004, method = "FE")
summary(rma_n_FE)

rma_n_RE <- rma(yi = yi, vi =  1/ni, data = dat.bangertdrowns2004)
summary(rma_n_RE)

rma_vi_RE <- rma(yi = yi, vi =  vi, data = dat.bangertdrowns2004)
summary(rma_vi_RE)

plot(dat.bangertdrowns2004$ni, dat.bangertdrowns2004$vi, pch = 16, col = "blue", cex = 1.5, xlab = expression(n[i]), ylab = expression(v[i]), main = expression(v[i]~"v.s."~n[i]))
