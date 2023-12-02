## load("C:/Users/Musterfrau/Desktop/PCA.RData")

load(url("https://pandar.netlify.app/daten/PCA.RData"))

library(psych)     # Datenaufbereitung und -diagnostik
library(corrplot)  # Korrelationsmatrixgrafiken

head(data)
head(dataUV)

round(head(data),2) # noch ein Überblick: diesmal auf 2 Nachkommastellen gerundet
# Mittelwerte der Daten
round(apply(X = data, MARGIN = 2, FUN = mean), 10) # identisch zu "colMeans(data)", wenn auch gerundet wird: round(colMeans(data), 10)
# SD der Daten
round(apply(X = data, MARGIN = 2, FUN = sd), 10)

cor(dataUV) # Korrelationsmatrix
cov(dataUV) # Kovarianzmatrix

R_UV <- cor(data[,1:6])

corrplot(R_UV)

corrplot(R_UV, method = "color",tl.col = "black", addCoef.col = "black",
         col=colorRampPalette(c("red","white","blue"))(100))

corrplot(R_UV, method = "color",tl.col = "black", addCoef.col = "black",
         col=colorRampPalette(c("blue","white","blue"))(100))

PCA1 <- pca(r = R_UV, nfactors = 6, rotate = "none")
PCA1

cat('Principal Components Analysis')

cat('Call: principal(r = r, nfactors = nfactors, residuals = residuals,
    rotate = rotate, n.obs = n.obs, covar = covar, scores = scores,
    missing = missing, impute = impute, oblique.scores = oblique.scores,
    method = method, use = use, cor = cor, correct = 0.5, weight = NULL)')

cat('Standardized loadings (pattern matrix) based upon correlation matrix
     PC1   PC2   PC3   PC4   PC5   PC6 h2       u2 com
x1  0.71  0.29  0.44  0.40 -0.19 -0.17  1 -4.4e-16 3.1
x2  0.78  0.41  0.10 -0.02  0.27  0.37  1 -2.2e-15 2.3
x3 -0.78 -0.33  0.21  0.37 -0.10  0.32  1  6.7e-16 2.5
x4 -0.36  0.66 -0.55  0.35  0.08 -0.05  1  5.6e-16 3.2
x5 -0.72  0.28  0.48 -0.02  0.38 -0.15  1  3.3e-16 2.8
x6  0.45 -0.75 -0.17  0.29  0.33 -0.10  1  8.9e-16 2.7')

cat('
                       PC1  PC2  PC3  PC4  PC5  PC6
SS loadings           2.57 1.43 0.81 0.50 0.38 0.30
Proportion Var        0.43 0.24 0.13 0.08 0.06 0.05
Cumulative Var        0.43 0.67 0.80 0.89 0.95 1.00
Proportion Explained  0.43 0.24 0.13 0.08 0.06 0.05
Cumulative Proportion 0.43 0.67 0.80 0.89 0.95 1.00')

cat('Mean item complexity =  2.8
Test of the hypothesis that 6 components are sufficient.

The root mean square of the residuals (RMSR) is  0

Fit based upon off diagonal values = 1')

names(PCA1)

PCA1$loadings

PCA1$loadings[,] # um alle zu sehen

round(PCA1$loadings, 1)

PCA1$Vaccounted

diag(t(PCA1$loadings[,]) %*% PCA1$loadings[,])

PCA1$weights

round(t(PCA1$weights) %*% PCA1$weights, 3)

round(t(PCA1$weights) %*% PCA1$weights %*% diag(PCA1$values), 10)

fa.parallel(dataUV, fa = "pc", error.bars = T)
# Eigenwerte größer 1?
abline(h = 1)

cat("Parallel analysis suggests that the number of factors =  NA  and the number of components =  2")

PCA2 <- pca(r = R_UV, nfactors = 2, rotate = "none")
PCA2

barplot(PCA2$loadings, beside = T, names.arg = rep(colnames(dataUV),2),
        xlab = "PC1                   -                    PC2",
        main  = "Ladungsmuster der Variablen \n auf den Hauptkomponenten")

plot(PCA2, pch = 1)

PCA3 <- pca(r = R_UV, nfactors = 2, rotate = "varimax")
PCA3

barplot(PCA3$loadings, beside = T, names.arg = rep(colnames(dataUV),2),
        xlab = "PC1                   -                    PC2",
        main  = "Ladungsmuster der Variablen \n auf den Hauptkomponenten")

plot(PCA3, cex = 2)

fa.diagram(PCA3)

plot(PCA3, xlim = c(-1,1),ylim = c(-1,1), cex  = 2)
par(new=TRUE)
plot(PCA2, xaxt = "n", yaxt = "n", ylab = "", xlab = "", xlim = c(-1,1),ylim = c(-1,1), pch = 1)

PCs <- as.matrix(dataUV) %*% PCA3$weights

cor(dataUV, PCs)
PCA3$loadings[,]

plot(PCs)

round(cor(PCs), 10)

cor(dataUV)
PCA3$loadings %*% t(PCA3$loadings)

round(cor(dataUV) - PCA3$loadings %*% t(PCA3$loadings), 2)

PCA5 <- pca(r = R_UV, nfactors = 5, rotate = "varimax")
round(cor(dataUV) - PCA5$loadings %*% t(PCA5$loadings), 2)

mx <- lm(y ~ 1 + x1 + x2 + x3 + x4 + x5 + x6, data = data)
summary(mx)

mpca <- lm(data$y ~ 1 + PCs[,1] + PCs[,2])
summary(mpca)

corrplot(R_UV, method = "color",tl.col = "black", addCoef.col = "black",
         col=colorRampPalette(c("red","white","blue"))(100))

corrplot(R_UV, method = "color",tl.col = "black", addCoef.col = "black",
         col=colorRampPalette(c("blue","white","blue"))(100))


barplot(PCA2$loadings, beside = T, names.arg = rep(colnames(dataUV),2),
        xlab = "PC1                   -                    PC2",
        main  = "Ladungsmuster der Variablen \n auf den Hauptkomponenten")

barplot(PCA3$loadings, beside = T, names.arg = rep(colnames(dataUV),2),
        xlab = "PC1                   -                    PC2",
        main  = "Ladungsmuster der Variablen \n auf den Hauptkomponenten")

plot(PCA3, xlim = c(-1,1),ylim = c(-1,1), cex  = 2)
par(new=TRUE) # neuen Plot erzeugen, welcher über den bereits erzeugten geplottet wird
plot(PCA2, xaxt = "n", yaxt = "n", ylab = "", xlab = "", xlim = c(-1,1),ylim = c(-1,1), pch = 1)

eigen(cor(dataUV))

Gamma <- eigen(R_UV)$vectors
theta <- eigen(R_UV)$values

# Plot der Eigenwerte
plot(theta, type="l", ylab = "Eigenwert", xlab = "Hauptkomponente")

Lambda <- Gamma %*% diag(sqrt(theta)) # sqrt zieht die Wurzel!
Lambda
PCA1$loadings[,] # Vergleich mit den Ladungen aus der pca-Funktion

dataUV$X <- rowMeans(dataUV)
R2 <- cor(dataUV)
round(R2,2)

eigen(R2)$values
plot(eigen(R2)$values, type="l", ylab = "Eigenwert", xlab = "Hauptkomponente")
abline(h=0, col="red")
solve(R2)

## install.packages("devtools")
## devtools::install_github("https://github.com/martscht/PCArt")

devtools::install_github("https://github.com/martscht/PCArt")

PCArt::pic1$image[, , 1][1:5, 1:5]
PCArt::pic1$image[, , 2][1:5, 1:5]
PCArt::pic1$image[, , 3][1:5, 1:5]

## PCArt::PCArtQuiz()
## 
## # analog:
## libary(PCArt)
## PCArtQuiz()

data('database1', envir = environment(), package = 'PCArt')

PCArt:::image_loop(pic2, max.tries = 2)
