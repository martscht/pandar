## Vektorrechnung

x <- c(4, 2, 3)
y <- c(10, 8, 6)

y[2]

y[2:3]

y[c(1,3)]

x + y  # Addition

z <- c(1:6) # Zahlen 1 bis 6
z + y

length(x)

y-x

3*x

1/2*x

x*y 

## Matrixrechnung

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

A %*% B # Matrixprodukt A*B
B %*% A # Matrixprodukt B*A

## Spezielle Matrizen

diag(3) # Einheitsmatrix 3x3
diag(1:3) # Diagonalmatrix mit Elementen 1,2,3 auf der Diagonalen

C <- matrix(data = c(1:9), # Daten/Inhalt des Vektors (hier die Zahlen 1 bis 9)
            nrow = 3,      # Zeilenanzahl der Matrix
            ncol = 3,      # Spaltenanzahl der Matrix
            byrow = T)     # Zeilen der resultierenden Matrix werden zuerst mit data gefüllt
C

diag(C)





## Determinanten

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
K <- matrix(c(M[2,2], -M[1,2], -M[2,1], M[1,1]), byrow = TRUE, ncol = 2, nrow = 2)
K # Kofaktorenmatrix
1/(M[1,1]*M[2,2] - M[1,2]*M[2,1])*K # Inverse von M
solve(M) # Inverse von M

#### Statistiken mit Matrixoperationen bestimmen ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb25.rda'))


X <- as.matrix(fb25[, c("extra", "vertr", "gewis", "neuro", "offen")])
X <- na.omit(X)  # fehlende Werte wurden entfernt
n <- nrow(X)
z <- t(rep(1, n)) # 1en-Zeilenvektor der Länge n
z %*% X
colSums(X)

cov(X) 

u <- rep(1, nrow(X)) # u enthält so viele Einsen als Elemente, wie die Matrix X an Beobachtungen hat
x_mean <- 1/nrow(X) * t(u) %*% X
x_mean # Mittelwertevektor

X_mean <- u %*% x_mean # Mittelwertematrix
head(X_mean) # um die ersten sechs Zeilen der Matrix anzuzeigen

X_zentriert <- X - X_mean
head(X_zentriert)

kreuzprodukt <- t(X_zentriert) %*% X_zentriert
X_cov <- 1/(nrow(X)-1) * kreuzprodukt
X_cov

x <- matrix(data = c(3, -2, 1), nrow = 1) # Zeilenvektor x
y <- matrix(data = c(5, 1, 7), ncol = 1) # Spaltenvektor y

x %*% y

y %*% x
