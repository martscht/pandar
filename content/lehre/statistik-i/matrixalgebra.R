x <- c(1, 2, 3)
y <- c(10, 8, 6)

y[2]

y[2:3]

y[c(1,3)]

x + y  # Addition

z <- c(1:6) # Zahlen 1 bis 6
z + y

3*x

1/2*x

-1*x

x*y 

names(x) <- c("Orangen", "Äpfel", "Bananen")
names(y) <- c("Orangen", "Äpfel", "Bananen")
x
y

length(x)

as.matrix(x)

A <- cbind(x, y)
A
B <- rbind(x, y)
B

B[1, 2] 

B[1, ] # 1. Zeile
B[, 2] # 2. Spalte

A
t(A)
B

# A + B



t(A) + B

B * 2 # skalare Multiplikation

t(A) * B

B^2

A %*% B # Matrixprodukt A*B
B %*% A # Matrixprodukt B*A

P <- matrix(c(.5, .3, .2))
rownames(P) <- c("Orange", "Äpfel", "Banane")
colnames(P) <- "Preis"
P

B %*% P

P <- matrix(c(.5, .05,
              .3, .05,
              .2, 1), nrow = 3, ncol = 2,
            byrow = TRUE)
rownames(P) <- c("Orangen", "Äpfel", "Bananen")
colnames(P) <- c("Laden A", "Laden B")
B %*% P

diag(3) # Einheitsmatrix 3x3
diag(1:3) # Diagonalmatrix mit Elementen 1,2,3 auf der Diagonalen

C <- matrix(data = c(1:9), nrow = 3, ncol = 3, byrow = T)
C

diag(C)

# solve(C)



det(C)
round(det(C), 14)

2*C[, 2] - C[, 1]     # 2*2.Spalte - 1. Spalte rechnen ist gleich
C[, 3]               # 3. Spalte

C^-1
C^-1 %*% C # ist nicht die Einheitsmatrix
C^-1 * C   # elementeweise ergibt überall 1 - ist immer noch nicht die Einheitsmatrix!

D <- matrix(c(1, 0, 0,
              1, 1, 1,
              2, 4, 5), 3, 3, byrow = T)
det(D)

solve(D)
D %*% solve(D)
solve(D) %*% D

M <- matrix(c(2, 2, 3, 4), ncol = 2, nrow = 2, byrow = TRUE)
M
det(M)
M[1,1]*M[2,2] - M[1,2]*M[2,1] # Determinante mit Hand
K <- matrix(c(M[2,2], -M[1,2], M[2,1], M[1,1]), byrow = TRUE, ncol = 2, nrow = 2)
K # Kofaktorenmatrix
1/(M[1,1]*M[2,2] - M[1,2]*M[2,1])*K # Inverse von M
solve(M) # Inverse von M

P <- matrix(c(.5, .1, 2,
              .3, .05, 2.5,
              .2, 1, 3), nrow = 3, ncol = 3,
            byrow = TRUE)
colnames(P) <- c("Orangen", "Äpfel", "Bananen")
rownames(P) <- c("Laden A", "Laden B", "Laden C")
P

P[1,]

b <- as.matrix(c(15.4, 18.3, 25.4))
rownames(b) <- c("Laden A", "Laden B", "Laden C")
b

x <- solve(P) %*% b
x

P %*% x
b

# Daten laden
load(url('https://pandar.netlify.app/daten/fb24.rda'))

# Nominalskalierte Variablen in Faktoren verwandeln
fb24$geschl_faktor <- factor(fb24$hand,
                             levels = 1:2,
                             labels = c("links", "rechts"))
fb24$fach <- factor(fb24$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb24$ziel <- factor(fb24$ziel,
                        levels = 1:4,
                        labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))

fb24$wohnen <- factor(fb24$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))


# Rekodierung invertierter Items
fb24$mdbf4_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf11_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf3_r <- -1 * (fb24$mdbf4 - 5)
fb24$mdbf9_r <- -1 * (fb24$mdbf4 - 5)

# Berechnung von Skalenwerten
fb24$gs_pre  <- fb24[, c('mdbf1', 'mdbf4_r', 
                        'mdbf8', 'mdbf11_r')] |> rowMeans()

X <- as.matrix(fb24[, 1:3])
n <- nrow(X)
z <- t(rep(1, n)) # 1en-Zeilenvektor der Länge n
z %*% X
colSums(X)

x <- X[,1]
y <- X[,2]
sum(x*y)
t(x) %*% y
mean(x)
1/n * (z %*% x)
mean(x)*mean(y)
1/n * (z %*% x) %*% 1/n* (z %*% y)
cov(x,y)
1/(n-1) * (t(x) %*% y - (z %*% x) %*% 1/n* (z %*% y))

1/(n-1)*(t(X) %*% X - 1/n*t(z %*% X)  %*% (z %*% X))
cov(X)

1/(n-1)*(t(X) %*% X - n*colMeans(X)  %*% t(colMeans(X)))
