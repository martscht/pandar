load(url('https://pandar.netlify.app/daten/fb24.rda'))
dim(fb24)





# eigene_funktion <- function(argument1, argument2, ...) {
#   # Durchgeführte Operationen
# }

x <- fb24$time_pre                # Variable in ein Objekt ablegen
n <- length(x)                    # Länge des Objekts bestimmen - Stichprobengröße
x_quer <- mean(x)                 # Mittelwert der Variable bestimmen
var <- sum((x - x_quer)^2) / n     # Bestimmung der quadrierten Abweichungen vom Mittelwert und Division durch die Stichprobengröße
var                                # Ausgabe des Ergebnis

rm(x, n, x_quer, var)    # Envrionment auf fb24 reduzieren

# Argumente und Operationen der neuen Funktion
function(x){
  n <- length(x)
  x_quer <- mean(x)
  var <- sum((x - x_quer)^2) / n
  var
}

var_eigen <- function(x){
  n <- length(x)
  x_quer <- mean(x)
  var <- sum((x - x_quer)^2) / n
  var
}

var_eigen(x = fb24$time_pre) # Durchführung der Funktion

var_eigen <- function(x){
  n <- length(x)
  x_quer <- mean(x)
  var <- sum((x - x_quer)^2) / n
  return(var)
}

var_eigen <- function(x, empirical){
  n <- length(x)
  x_quer <- mean(x)
  var <- sum((x - x_quer)^2) / n
  return(var)
}

var_eigen <- function(x, empirical){
  n <- length(x)
  x_quer <- mean(x)
  if (empirical == TRUE) {
    var <- sum((x - x_quer)^2) / n
  } 
  return(var)
}

var_eigen <- function(x, empirical){
  n <- length(x)
  x_quer <- mean(x)
  if (empirical == TRUE) {
    var <- sum((x - x_quer)^2) / n
  } else {
    var <- sum((x - x_quer)^2) / (n - 1)
  }
  return(var)
}







# var_eigen(x = fb24$time_pre)



var_eigen <- function(x, empirical = TRUE){
  n <- length(x)
  x_quer <- mean(x)
  if (empirical == TRUE) {
    var <- sum((x - x_quer)^2) / n
  } else {
    var <- sum((x - x_quer)^2) / (n - 1)
  }
  return(var)
}

var_eigen(x = fb24$time_pre)







try({
var_eigen <- function(x, empirical = TRUE){
  n <- length(x)
  x_quer <- mean(x)
  if (empirical == TRUE) {
    var <- sum((x - x_quer)^2) / n
  } else {
    var <- sum((x - x_quer)^2) / (n - 1)
  }
  return(var, n)
}

var_eigen(x = fb24$time_pre, empirical = TRUE)
})

var_eigen <- function(x, empirical = TRUE){
  n <- length(x)
  x_quer <- mean(x)
  if (empirical == TRUE) {
    var <- sum((x - x_quer)^2) / n
  } else {
    var <- sum((x - x_quer)^2) / (n - 1)
  }
  return(list(var, n))
}

var_eigen(x = fb24$time_pre, empirical = TRUE)

var_eigen <- function(x, empirical = TRUE){
  n <- length(x)
  x_quer <- mean(x)
  if (empirical == TRUE) {
    var <- sum((x - x_quer)^2) / n
  } else {
    var <- sum((x - x_quer)^2) / (n - 1)
  }
  return(list(Varianz = var, Stichprobengroesse = n))
}

var_eigen(x = fb24$time_pre, empirical = TRUE)

var_eigen(x = fb24$time_pre, empirical = TRUE)
var_eigen(x = fb24$mdbf1, empirical = TRUE)
var_eigen(x = fb24$mdbf2, empirical = TRUE)

# for (i in c("time_pre", "mdbf1", "mdbf2")) {
#   # Hier steht der Code, der für jedes Element ausgeführt wird
# }

for (i in c("time_pre", "mdbf1", "mdbf2")) {
  var_eigen(x = fb24[, i], empirical = TRUE)
}

for (i in c("time_pre", "mdbf1", "mdbf2")) {
  print(var_eigen(x = fb24[, i], empirical = TRUE))
}

for (i in c("time_pre", "mdbf1", "mdbf2")) {
  print(i)
  print(var_eigen(x = fb24[, i], empirical = TRUE))
}

try({
for (i in names(fb24)) {
  print(i)
  print(var_eigen(x = fb24[, i], empirical = TRUE))
}
})

for (i in names(fb24)) {
  print(i)
  if (is.character(fb24[, i])) {
    print("Eine character Variable.")
  } else {
    print(var_eigen(x = fb24[, i], empirical = TRUE))
  }
}









































A <- data.frame("a" = c(2,3,4), "b" = c(1,1,1))
apply(A, 2, mean) # Mittelwert über Spalten/Variablen
colMeans(A)

apply(A, 1, mean) # Mittelwert über Zeilen/Personen/Beobachtungen
rowMeans(A)

apply(A, 2, sd) # Standardabweichung über Spalten/Variable
