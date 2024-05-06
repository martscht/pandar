burnout <- read.csv(file = url("https://osf.io/qev5n/download"))
burnout <- burnout[,2:8]
dim(burnout)

str(burnout)

mod <- lm(Violence ~ Exhaust + Distan + PartConfl, data = burnout)

summary(mod)

resid(mod)[1:10]





confint(mod, level = 0.95)

predict_data <- data.frame(Exhaust = 3, Distan = 4, PartConfl = 2)

predict(mod, newdata = predict_data)

predict(mod, newdata = predict_data, interval = "prediction", level = 0.95)

mod_unrestricted <- lm(Violence ~ Exhaust + Distan + 
                         PartConfl + Neglect + PartEstrang, data = burnout)

mod_restricted <- mod

summary(mod_unrestricted)$r.squared
summary(mod_restricted)$r.squared

summary(mod_unrestricted)$r.squared - summary(mod_restricted)$r.squared

anova(mod_restricted, mod_unrestricted)

## install.packages("olsrr")

library(olsrr)

# Modell mit allen Prädiktoren
mod_all <- lm(Violence ~ ., data = burnout)

# Anwendung der iterativen Modellbildung
ols_step_both_p(mod_all, p_enter = .05, p_remove = .10, details = TRUE)

# Optimierung des Modells nach AIC
step(mod_all, direction = "both")







# Ergänzung des Outputs
summary(step(mod_all, direction = "both"))

# Optimierung mit BIC
summary(step(mod_all, direction = "both", k=log(nrow(burnout))))

# Vergleich des AIC in step und ols_step_both_p, liegt an Unterschied der AIC-Funktionen, bei denen step Konstanten entfernt
AIC(mod_all)
extractAIC(mod_all) # erstes Argument ist die Anzahl der Parameter (p)
