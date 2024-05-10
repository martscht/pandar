library(metafor)

## help("metafor")

df <- data.frame("Studie" = c("Studie 1", "Studie 2"), 
                 "X1" = c(1.5, 2.5), "SD1" = c(0.7, 0.9), "n1" = c(35, 132),
                 "X2" = c(2.7, 2.8), "SD2" = c(1.3, 1.1), "n2" = c(27, 126))
df



escalc(measure = "SMD", m1i = X1, m2i = X2, sd1i = SD1, sd2i = SD2,
       n1i = n1, n2i = n2,
       data = df)



head(dat.lopez2019)



F2F_CBT <- dat.lopez2019[dat.lopez2019$treatment == "F2F CBT",] # wähle nur Fälle mit F2F CBT

sum(F2F_CBT$n*F2F_CBT$diff)/sum(F2F_CBT$n)

FEM_n <- rma(yi = diff, vi =  1/n, data = F2F_CBT, method = "FE")
summary(FEM_n)











FEM <- rma(yi = diff, vi =  se^2, data = F2F_CBT, method = "FE")
summary(FEM)

FEM2 <- rma(yi = diff, sei =  se, data = F2F_CBT, method = "FE")
summary(FEM2)

REM <- rma(yi = diff, sei =  se, data = F2F_CBT)
summary(REM)



power <- 1 - pchisq(q = qchisq(p = .95, df = REM$k.all - 1), df = REM$k.all - 1, ncp = REM$QE)
power

# funnel plot
funnel(REM)

## trimfill(REM, estimator = "R0")





funnel(trimfill(REM, estimator = "R0"))

# forest plot
forest(REM)

# kumulativer Forest Plot
forest(cumul.rma.uni(REM))

# kumulativer Forest Plot
forest(cumul.rma.uni(REM), xlim = c(-10, 2))

F2F_CBT$intensity <- scale(F2F_CBT$intensity, center = T, scale = F) # nur zentrieren

MEM1 <- rma(yi = diff, sei =  se, data = F2F_CBT, 
            mods =~ intensity, 
            method = "ML")
summary(MEM1)







# factors erzeugen und den Ausprägungen Labels geben:
F2F_CBT$psed <- factor(F2F_CBT$psed, levels = c(0, 1), labels = c("no", "yes"))
F2F_CBT$soc <- factor(F2F_CBT$soc, levels = c(0, 1), labels = c("no", "yes"))
F2F_CBT$ba <- factor(F2F_CBT$ba, levels = c(0, 1), labels = c("no", "yes"))
F2F_CBT$home <- factor(F2F_CBT$home, levels = c(0, 1), labels = c("no", "yes"))


MEM2 <- rma(yi = diff, sei =  se, data = F2F_CBT, 
            mods =~ intensity + psed + soc + ba + home, 
            method = "ML")
summary(MEM2)

anova(MEM1, MEM2, test = "LRT")

## reporter(REM)
