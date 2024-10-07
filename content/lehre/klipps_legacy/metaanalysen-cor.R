library(metafor)

head(dat.molloy2014)



summary(dat.molloy2014$ri)

boxplot(dat.molloy2014$ri)

boxplot_cors <- boxplot(dat.molloy2014$ri)

quantile(dat.molloy2014$ri, probs = c(0.1, 0.9))



data_transformed <- escalc(measure="ZCOR", ri=ri, ni=ni,
                           data=dat.molloy2014, 
                           var.names = c("z_ri", "v_ri"))
head(data_transformed)

data_transformed_2 <- escalc(measure="ZCOR", ri=dat.molloy2014$ri,
                             ni=dat.molloy2014$ni, 
                             var.names = c("z_ri", "v_ri"))
head(data_transformed_2)

data_transformed$v_ri[1:4]
1/(dat.molloy2014$ni - 3)[1:4] 

plot(x = data_transformed$ri, y = data_transformed$z_ri, 
     xlab = "r", ylab = "z",
     main = "Fisher's z-Transformation")

REM <- rma(yi = z_ri, vi = v_ri, data=data_transformed)
summary(REM)

names(REM)

REM$b
REM$tau2

predict(REM, transf=transf.ztor)

pred_REM <- predict(REM, transf=transf.ztor)
names(pred_REM)
pred_REM$pred # retransformierter gepoolter Korrelationskoeffizient



df <- data.frame(r = c(0.3, 0.3, 0.5, 0.4), 
                 RelX = c(0.6, 0.8, 1, 1), 
                 RelY = c(0.5, 0.7, 0.8, 1), 
                 n = c(65, 65, 34, 46))
head(df)

df$r_correct <- df$r/sqrt(df$RelX*df$RelY)
head(df)

plot(NA, xlim = c(-1,1), ylim = c(-1,1), xlab = "Gewissenhaftigkeit", ylab = "Medikamenteneinnahme",
     main = "Empirische Korrelationen zwischen\n Medikamenteneinnahme und Gewissenhaftigkeit")
for(i in 1:length(dat.molloy2014$ri))
{
     abline(a = 0, b = dat.molloy2014$ri[i], col = "grey80")
}

plot(NA, xlim = c(-1,1), ylim = c(-1,1), xlab = "Gewissenhaftigkeit", ylab = "Medikamenteneinnahme",
     main = "Empirische Korrelationen zwischen\n Medikamenteneinnahme und Gewissenhaftigkeit")
for(i in 1:length(dat.molloy2014$ri))
{
     abline(a = 0, b = dat.molloy2014$ri[i], col = "grey80")
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

trimfill(REM, estimator = "R0")

funnel(trimfill(REM, estimator = "R0"))

# forest plot
forest(REM)

# kumulativer Forest Plot
forest(cumul.rma.uni(REM))
