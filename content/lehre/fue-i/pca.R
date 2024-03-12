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





PCA1 <- pca(r = R_UV, nfactors = 6, rotate = "none")
PCA1











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



PCA2 <- pca(r = R_UV, nfactors = 2, rotate = "none")
PCA2



plot(PCA2, pch = 1)

PCA3 <- pca(r = R_UV, nfactors = 2, rotate = "varimax")
PCA3



plot(PCA3, cex = 2)

fa.diagram(PCA3)



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



PCArt::pic1$image[, , 1][1:5, 1:5]
PCArt::pic1$image[, , 2][1:5, 1:5]
PCArt::pic1$image[, , 3][1:5, 1:5]

## PCArt::PCArtQuiz()
## 
## # analog:
## library(PCArt)
## PCArtQuiz()
