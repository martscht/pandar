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

y_hat <- predict(mod, newdata = predict_data)
sigma_e <- summary(mod)$sigma
n <- nrow(burnout)                             # da keine fehlenden Werte
k <- ncol(predict_data)                        # da in diesem Datensatz nur Werte der Prädiktoren
t <- qt(1 - 0.05/2, n - k - 1)                      # alpha von 0.05 üblich 

x <- as.matrix(predict_data)
x_bar <- colMeans(burnout[, c("Exhaust", "Distan", "PartConfl")])
x_i <- as.matrix(burnout[, c("Exhaust", "Distan", "PartConfl")])

y_hat + t * sigma_e * sqrt(1 + 1/n + (x - x_bar) %*% t((x - x_bar)) / sum((x_i - x_bar) %*% t((x_i - x_bar))))
y_hat - t * sigma_e * sqrt(1 + 1/n + (x - x_bar) %*% t((x - x_bar)) / sum((x_i - x_bar) %*% t((x_i - x_bar))))


y_hat + t * sigma_e * sqrt(1 + x %*% solve(t(x_i) %*% x_i) %*% t(x))

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
ols_step_both_p(mod_all, pent = .05, prem = .10, details = TRUE)

# Optimierung des Modells nach AIC
step(mod_all, direction = "both")







# Ergänzung des Outputs
summary(step(mod_all, direction = "both"))

# Optimierung mit BIC
summary(step(mod_all, direction = "both", k=log(nrow(burnout))))

# Vergleich des AIC in step und ols_step_both_p, liegt an Unterschied der AIC-Funktionen, bei denen step Konstanten entfernt
AIC(mod_all)
extractAIC(mod_all) # erstes Argument ist die Anzahl der Parameter (p)
