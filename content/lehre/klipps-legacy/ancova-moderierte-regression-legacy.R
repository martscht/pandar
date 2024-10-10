osf <- read.csv(file = url("https://osf.io/zc8ut/download"))
osf <- osf[, c("ID", "group", "stratum", "bsi_post", "swls_post", "pas_post")]

# Missings ausschließen
osf <- na.omit(osf)
head(osf) # finaler Datensatz

# Skalenniveaus anpassen: Factors bilden
osf$group <- factor(osf$group)
osf$stratum <- factor(osf$stratum)

# Zentrieren
osf$swls_post <- scale(osf$swls_post, center = T, scale = F)
osf$pas_post <- scale(osf$pas_post, center = T, scale = F)

reg_swl <- lm(bsi_post ~ 1 + swls_post, data = osf)
summary(reg_swl)







reg_ancova <- lm(bsi_post  ~  1 + group + swls_post, data = osf)
summary(reg_ancova)

library(car)
Anova(reg_ancova)



reg_gen_ancova <- lm(bsi_post  ~  1 + group + swls_post  + group:swls_post, 
                     data = osf)
summary(reg_gen_ancova)

Anova(reg_gen_ancova, type = 2)



reg_gen_ancova_s <- lm(bsi_post ~ stratum + swls_post + stratum:swls_post, data = osf)
Anova(reg_gen_ancova_s)





mod_reg <- lm(bsi_post ~ swls_post + pas_post + swls_post:pas_post, data = osf)
summary(mod_reg)

library(interactions)
interact_plot(model = mod_reg, pred = pas_post, modx = swls_post)



mod_quad_reg <- lm(bsi_post ~ swls_post + pas_post + swls_post:pas_post + I(swls_post^2) + I(pas_post^2), data = osf)
summary(mod_quad_reg)

interact_plot(model = mod_quad_reg, pred = pas_post, modx = swls_post)



quad_reg <-  lm(bsi_post ~ swls_post + pas_post  + I(swls_post^2) + I(pas_post^2), data = osf)
anova(quad_reg, mod_quad_reg)

library(ggplot2) # ggplot2-Paket laden
ggplot(data = osf,  mapping = aes(x = swls_post, y = bsi_post))+
  geom_point()+
   geom_line(mapping = aes(x = swls_post, y = predict(reg_swl)))+
   theme_minimal()

ggplot(data = osf,  mapping = aes(x = group, y = bsi_post, col = group, group = group))+geom_point()+
     theme_minimal()

ggplot(data = osf,  mapping = aes(x = swls_post, y = bsi_post, col = group))+
  geom_point()+
   geom_line(mapping = aes(x = swls_post, y = predict(reg_swl)), col = "black")+
   theme_minimal()

ggplot(data = osf,  mapping = aes(x = swls_post, y = bsi_post, col = group))+
  geom_point()+
  geom_line(mapping = aes(x = swls_post, y = predict(reg_ancova)))+
  theme_minimal()

ggplot(data = osf,  mapping = aes(x = swls_post, y = bsi_post,  col = group))+
  geom_point()+
  geom_line(mapping = aes(x = swls_post, y = predict(reg_gen_ancova)))+
  theme_minimal()

ggplot(data = osf,  mapping = aes(x = swls_post, y = bsi_post,  col = stratum))+
   geom_point()+
  geom_line(mapping = aes(x = swls_post, y = predict(reg_gen_ancova_s)))+
  theme_minimal()

reg_gen_ancova_gs <- lm(bsi_post ~ group*stratum*swls_post, data = osf)
summary(reg_gen_ancova_gs)

Anova(reg_gen_ancova_gs)
ggplot(data = osf,  mapping = aes(x = swls_post, y = bsi_post,  col = stratum, lty = group, pch = group))+
   geom_point()+
   geom_line(mapping = aes(x = swls_post, y = predict(reg_gen_ancova_gs)))+
   theme_minimal()

library(plot3D)
# Übersichtlicher: Vorbereitung
x <- c(osf$pas_post)
y <- c(osf$bsi_post)
z <- c(osf$swls_post)
fit <- lm(y ~ x + z + x:z)
grid.lines = 26
x.pred <- seq(min(x), max(x), length.out = grid.lines)
z.pred <- seq(min(z), max(z), length.out = grid.lines)
xz <- expand.grid(x = x.pred, z = z.pred)
y.pred <- matrix(predict(fit, newdata = data.frame(xz)), 
                 nrow = grid.lines, ncol = grid.lines)
fitpoints <- predict(fit)

# Plot:
scatter3D(x = x, y = z, z = y, pch = 16, cex = 1.2, 
          theta = -30, phi = 30, ticktype = "detailed",
          xlab = "Panikstörungs- und Agoraphobiesymptomatik", ylab = "Lebenszufriedenheit", zlab = "Symptomschwere",  
          surf = list(x = x.pred, y = z.pred, z = y.pred,  
                      facets = NA, fit = fitpoints), 
          main = "Moderierte Regression")

# Übersichtlicher: Vorbereitung
x <- c(osf$pas_post)
y <- c(osf$bsi_post)
z <- c(osf$swls_post)
fit <- lm(y ~ x + z + z:x + I(x^2) + I(z^2)) # Modellerweiterung um quadratische Effekte
grid.lines = 26
x.pred <- seq(min(x), max(x), length.out = grid.lines)
z.pred <- seq(min(z), max(z), length.out = grid.lines)
xz <- expand.grid(x = x.pred, z = z.pred)
y.pred <- matrix(predict(fit, newdata = data.frame(xz)), 
                 nrow = grid.lines, ncol = grid.lines)
fitpoints <- predict(fit)

# Plot:
scatter3D(x = x, y = z, z = y, pch = 16, cex = 1.2, 
          theta = -20, phi = 30, ticktype = "detailed",
          xlab = "Panikstörungs- und Agoraphobiesymptomatik", ylab = "Lebenszufriedenheit", zlab = "Symptomschwere",  
          surf = list(x = x.pred, y = z.pred, z = y.pred,  
                      facets = NA, fit = fitpoints), 
          main = "Moderierte Regression\nmit quadratischen Effekten")

A <- seq(0, 10, 0.1)

cor(A, A^2)

A_c <- A - mean(A)
mean(A_c)

A_c2 <- scale(A, center = T, scale = F)  # scale = F bewirkt, dass nicht auch noch die SD auf 1 gesetzt werden soll
mean(A_c2)

cor(A_c, A_c^2)
cor(A, A^2)

# auf 15 Nachkommastellen gerundet:
round(cor(A_c, A_c^2), 15)
round(cor(A, A^2), 15)

set.seed(1234) # Vergleichbarkeit
X <- rnorm(1000, mean = 2, sd = 1) # 1000 normalverteile Zufallsvariablen mit Mittelwert 2 und Standardabweichung = 1
Z <- X + rnorm(1000, mean = 1, sd = 0.5) # generiere Z ebenfalls normalverteilt und korreliert zu X
cor(X, Z)      # Korrelation zwischen X und Z

X_c <- scale(X, center = T, scale = F)
Z_c <- scale(Z, center = T, scale = F)

cor(X, X*Z)
cor(X_c, X_c*Z_c)

var(A)
var(A_c)

# Kovarianz 
cov(A, A^2)
2*mean(A)*var(A)

# zentriert:
round(cov(A_c, A_c^2), 14)
round(2*mean(A_c)*var(A_c), 14)

A <- rexp(1000)
hist(A)
mean(A) # Mittelwert von A
sd(A)   # SD(A)

B <- (A + rexp(1000))/sqrt(2) # durch Wurzel 2 teilen für vergleichbare Varianzen von A und B
mean(B) # Mittelwert von B
sd(B)   # SD(B)

cor(A, B)
cov(A, B)

cor(A, A*B)
cov(A, A*B)

cor(A, A^2)
cov(A, A^2)

A_c <- scale(A, center = T, scale = F)
B_c <- scale(B, center = T, scale = F)

cor(A_c, A_c*B_c) # Korrelation und Kovarianz von 0 verschieden 
cov(A_c, A_c*B_c) # zwischen A_c und Interaktion, jedoch etwas kleiner als nicht-zentriert

cor(A_c, A_c^2)  # Korrelation und Kovarianz von 0 verschieden 
cov(A_c, A_c^2)  # zwischen A_c und A_c^2, jedoch etwas kleiner als nicht-zentriert
