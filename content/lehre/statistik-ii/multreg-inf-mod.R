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

# this is code according to formular from klein
y_hat + t * sigma_e * sqrt(1 + x %*% solve(t(x_i) %*% x_i) %*% t(x))

# or alternatively with the vector of ones 
x_i_alt <- cbind(1, x_i)
x_alt <- as.matrix(c(1, x)) |> t()

# formula of klein is now equivalent to the predict function
y_hat + t * sigma_e * sqrt(1 + x_alt %*% solve(t(x_i_alt) %*% x_i_alt) %*% t(x_alt))

# could this be incorporated in the notation from Eid? What would the mean of the intercept be? 1? would not anything then
x_bar_alt <- c(1, x_bar)
y_hat + t * sigma_e * sqrt(1 + 1/n + (x_alt - x_bar_alt) %*% t((x_alt - x_bar_alt)) / sum((x_i_alt - x_bar_alt) %*% t((x_i_alt - x_bar_alt))))

# this is the code from the predict.lm function
res.var <- sigma_e^2
pred.var <- res.var
qrX <- stats:::qr.lm(mod)

X <- model.matrix(mod)
X <- X[1,1:4, drop = F]
X[2] <- 3
X[3] <- 4
X[4] <- 2
piv <- p1 <- 1:4
p <- 4
XRinv <- X[, piv] %*% qr.solve(qr.R(qrX)[p1, p1])
ip <- drop(XRinv^2 %*% rep(res.var, p))

level <- 0.95
df <- n-k-1
tfrac <- qt((1 - level)/2, df)
hwid <- tfrac * sqrt(ip + pred.var)

y_hat - hwid

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
