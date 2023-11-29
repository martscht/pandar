N <- 20

set.seed(12345)
X <- rnorm(N)
Z <- rnorm(N)
Y <- 0.5*X + sqrt(1 - 0.5^2)*Z
cor(X, Y) # empirische Korrelation
sd(X) 
sd(Y)
