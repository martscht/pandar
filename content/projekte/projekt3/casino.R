set.seed(999)

Ergebnis1 <- NULL
Ergebnis2 <- NULL
Bedeutung <- NULL
Konsequenz <- NULL

for (i in 1:50) {         # Wie lang soll die Schleife sein? - 50 Wiederholungen
  wuerfel1 <- sample(1:6, 1)  # Zufallsziehung von Würfel 1
  Ergebnis1[i] <- wuerfel1    # Das Ergebnis von Würfel 1 wird jeweils in einem neuen Eintrag (Eintrag "i" für die i-te Runde/den i-ten Durchlauf) im Objekt "Ergebnis1" gespeichert.
  wuerfel2 <- sample(1:6, 1)  # Zufallsziehung von Würfel 2
  Ergebnis2[i] <- wuerfel2    # Abspeicherung des Ergebnisses von Würfel 2
  if (wuerfel1 == wuerfel2) {     # Wenn die beiden Würfel die gleiche Augenzahl haben, dann soll in dem Objekt "Bedeutung" abgespeichert werden, dass ein Pasch gewürfelt wurde. Ebenso soll in dem Objekt "Konsequenz" die Anweisung "Du bist frei!" ausgegeben werden.
    Bedeutung[i] <- "Pasch"
    Konsequenz[i] <- "Du bist frei!"
  } else {                # Ansonsten soll im Objekt "Bedeutung" abgespeichert werden, dass kein Pasch gewürfelt wurde und im Objekt "Konsequenz" die Anweisung "Bleib im Gefängnis!"
    Bedeutung[i] <- "kein Pasch"
    Konsequenz[i] <- "Bleib im Gefängnis!"
  }
}
Monopoly_Gefaengnis <- data.frame(Ergebnis1, Ergebnis2, Bedeutung, Konsequenz) # Datensatz aus den drei Objekten erstellen


## View(Monopoly_Gefaengnis)     # Datensatz anschauen

knitr::kable(Monopoly_Gefaengnis[1:10, ], "html")

wuerfel1 <- 0    # Würfel 1
wuerfel2 <- 1    # Würfel 2
m <- 0       # Anzahl Würfe

while (wuerfel1 != wuerfel2) {      # Bedingung
  m <- m + 1                # zählt die Durchgänge - pro Durchlauf +1
  wuerfel1 <- sample(1:6, 1)    # Würfel 1
  wuerfel2 <- sample(1:6, 1)    # Würfel 2
  print(c(wuerfel1, wuerfel2))      # Die beiden Augenzahlen werden pro Wurf ausgegeben, um die Ergebnisse nachvollziehen zu können.
}

m

sample(0:36)

sample(0:36, 1)

sample(0:36, 5, replace = T)

Ziehungen <- sample(0:36, 50, replace = T)
Ziehungen

Ziehungen <- NULL
for (i in 1:50) {
  Ziehungen[i] <- sample(0:36, 1)
}
Ziehungen

Gewinne <- ifelse(Ziehungen == 9, 180, -5)

Gewinne

Gesamtgewinn <- sum(Gewinne)
Gesamtgewinn

RED <- c(1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36)
BLACK <- c(2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35)
EVEN <- seq(2, 36, by = 2)
ODD <- seq(1, 35, by = 2)
firstThird <- 1:12
secondThird <- 13:24
lastThird <- 25:36

# x = Ergebnis Roulette
x <- sample(0:36, 1)
# y = Einsatz (beispielhaft 10 Euro)
y <- 10
# z = Zahl/Gruppe von Zahlen, auf die gesetzt wurde (beispielhaft ungerade Zahlen)
z <- ODD

if (is.element(x, z)) {
  if (identical(z, RED)) {
    y
  } else if (identical(z, BLACK)) {
    y
  } else if (identical(z, ODD)) {
    y
  } else if (identical(z, EVEN)) {
    y
  } else if (identical(z, firstThird)) {
    y * 2
  } else if (identical(z, secondThird)) {
    y * 2
  } else if (identical(z, lastThird)) {
    y * 2
  } else {
    y * 35
  }
} else {
  -y
}

if (is.element(x, z)) {
  if (identical(z, RED) | identical(z, BLACK) | 
      identical(z, ODD) | identical(z, EVEN)) {
    y
  } else if (identical(z, firstThird) | 
      identical(z, secondThird) | 
      identical(z, lastThird)) {
    y * 2
  } else {
    y * 35
  }
} else {
  -y
}

Gewinne <- NULL
Ziehungen <- NULL
z <- ODD

for (i in 1:50) {
  x <- sample(0:36, 1)
  Ziehungen[i] <- x
  Gewinne[i] <- if (is.element(x, z)) {
    if (identical(z, RED) | identical(z, BLACK) | 
        identical(z, ODD) | identical(z, EVEN)) {
      y
    } else if (identical(z, firstThird) | 
        identical(z, secondThird) |
        identical(z, lastThird)) {
      y * 2
    } else {
      y * 35
    }
  } else {
  -y
  }
}

Ziehungen
Gewinne

Spiel_Odd_50 <- data.frame(Ziehungen, Gewinne)
head(Spiel_Odd_50)

cumsum(Gewinne)
sum(Gewinne)

y <- 10
z <- RED
Gewinn <- NULL

Gesamtgewinn <- 0

Durchgaenge <- 0

## while (Gesamtgewinn < 50) {
##   x <- sample(0:36, 1)
##   Gewinn <- if (is.element(x, z)) {
##     if (identical(z, RED) | identical(z, BLACK) |
##         identical(z, ODD) | identical(z, EVEN)) {
##       y
##     } else if (identical(z, firstThird) |
##         identical(z, secondThird) |
##         identical(z, lastThird)) {
##       y * 2
##     } else {
##       y * 35
##     }
##   } else {
##   -y
##   }
##   Gesamtgewinn <- Gesamtgewinn + Gewinn
##   print (Gesamtgewinn)
##   Durchgaenge <- Durchgaenge + 1
## }

Gesamtgewinn <- 0
Durchgaenge <- 0
while (Gesamtgewinn < 50) {
  x <- sample(0:36, 1)
  Gewinn <- if (is.element(x, z)) {
    if (identical(z, RED) | identical(z, BLACK) |
        identical(z, ODD) | identical(z, EVEN)) {
      y
    } else if (identical(z, firstThird) |
        identical(z, secondThird) |
        identical(z, lastThird)) {
      y * 2
    } else {
      y * 35
    }
  } else {
  -y
  }
  Gesamtgewinn <- Gesamtgewinn + Gewinn
  Durchgaenge <- Durchgaenge + 1
  if (Durchgaenge == 500) break
}
Gesamtgewinn

## Roulette(Einsatz, Wette)

## Roulette_2(Einsatz, Wette, Runden)

Wuerfeln1 <- function (){
  message ("Bitte jetzt würfeln!")
  Augenzahl <- sample (1:6, 1)
  message ("Du hast eine ", Augenzahl, " geworfen!")}
Wuerfeln1 ()

Wuerfeln2 <- function (){
  message ("Bitte jetzt würfeln!")
  Augenzahl <- sample (1:6, 1)
  Sys.sleep (3.0)
  message ("Du hast eine ", Augenzahl, " geworfen!")}
Wuerfeln2 ()

Roulette <- function (y, z) {
  x <- sample (0:36, 1)
  Gewinn <- if (is.element(x, z)) {
    if (identical(z, RED) | identical(z, BLACK) |
        identical(z, ODD) | identical(z, EVEN)) {
      y
    } else if (identical(z, firstThird) |
        identical(z, secondThird) |
        identical(z, lastThird)) {
      y * 2
    } else {
      y * 35
    }
  } else {
  -y
  }
  print(c(x, Gewinn))
}
Roulette(10,7)

Roulette <- function (y, z) {
  x <- sample (0:36, 1)
  Gewinn <- if (is.element(x, z)) {
    if (identical(z, RED) | identical(z, BLACK) |
        identical(z, ODD) | identical(z, EVEN)) {
      y
    } else if (identical(z, firstThird) |
        identical(z, secondThird) |
        identical(z, lastThird)) {
      y * 2
    } else {
      y * 35
    }
  } else {
  -y
  }
  message ("Roulettekugel startet")
  Sys.sleep (2.0)
  message ("Rien ne va plus!")
  Sys.sleep (2.0)
  message ("Es ist eine ", x, ".")
  Sys.sleep (2.0)
  if (is.element (x, z)) {
    message ("Du hast gewonnen!")
    Sys.sleep (2.0)
    message ("Dein Gewinn beträgt ", Gewinn, " Euro." )
  } else {
    message ("Du hast verloren!")
    Sys.sleep (2.0)
    message ("Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.")
  }
}

Roulette(10,RED)

Roulette_Schleife <- function(y, z, o) {
  x <- sample(0:36, 1)
  Gewinn <- if (is.element(x, z)) {
    if (identical(z, RED) | identical(z, BLACK) |
        identical(z, ODD) | identical(z, EVEN)) {
      y
    } else if (identical(z, firstThird) |
        identical(z, secondThird) |
        identical(z, lastThird)) {
      y * 2
    } else {
      y * 35
    }
  } else {
  -y
  }
}

Roulette_Schleife <- function (y, z, o) {
  Durchgaenge <- 0
  repeat {
    Durchgaenge <- Durchgaenge + 1
    x <- sample (0:36, 1)
    Gewinn <- if (is.element(x, z)) {
      if (identical(z, RED) | identical(z, BLACK) |
          identical(z, ODD) | identical(z, EVEN)) {
        y
      } else if (identical(z, firstThird) |
          identical(z, secondThird) |
          identical(z, lastThird)) {
        y * 2
      } else {
        y * 35
      }
    } else {
      -y
    }
  if(Durchgaenge == o) break
  }
}

Roulette_Schleife <- function (y, z, o) {
  Durchgaenge <- 0
  repeat {
    Durchgaenge <- Durchgaenge + 1
    x <- sample (0:36, 1)
    Gewinn <- if (is.element(x, z)) {
      if (identical(z, RED) | identical(z, BLACK) |
          identical(z, ODD) | identical(z, EVEN)) {
        y
      } else if (identical(z, firstThird) |
          identical(z, secondThird) |
          identical(z, lastThird)) {
        y * 2
      } else {
        y * 35
      }
    } else {
      -y
    }
    message ("Roulettekugel startet")
    Sys.sleep (2.0)
    message ("Rien ne va plus!")
    Sys.sleep (2.0)
    message ("Es ist eine ", x, ".")
    Sys.sleep (2.0)
    if (is.element (x, z)) {
      message ("Du hast gewonnen!")
      Sys.sleep (2.0)
      message ("Dein Gewinn beträgt ", Gewinn, " Euro." )
      Sys.sleep (1.0)
    } else {
      message ("Du hast verloren!")
      Sys.sleep (2.0)
      message ("Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.")
      Sys.sleep (1.0)
    }
  if(Durchgaenge == o) break
  }
}

Roulette_Schleife <- function (y, z, o) {
  Durchgaenge <- 0
  Gesamtgewinn <- 0
  repeat {
    Durchgaenge <- Durchgaenge + 1
    message ("Runde ", Durchgaenge, "!")
    x <- sample (0:36, 1)
    Gewinn <- if (is.element(x, z)) {
      if (identical(z, RED) | identical(z, BLACK) |
          identical(z, ODD) | identical(z, EVEN)) {
        y
      } else if (identical(z, firstThird) |
          identical(z, secondThird) |
          identical(z, lastThird)) {
        y * 2
      } else {
        y * 35
      }
    } else {
      -y
    }
    Gesamtgewinn <- Gesamtgewinn + Gewinn
    message ("Roulettekugel startet")
    Sys.sleep (2.0)
    message ("Rien ne va plus!")
    Sys.sleep (2.0)
    message ("Es ist eine ", x, ".")
    Sys.sleep (2.0)
    if (is.element (x, z)) {
      message ("Du hast gewonnen!")
      Sys.sleep (2.0)
      message ("Dein Gewinn beträgt ", Gewinn, " Euro." )
      Sys.sleep (1.0)
      message ("Damit liegt dein Gesamtgewinn bisher bei ", Gesamtgewinn, " Euro.")
      Sys.sleep (1.0)
    } else {
      message ("Du hast verloren!")
      Sys.sleep (2.0)
      message ("Damit liegt dein Gesamtgewinn bisher bei ", Gesamtgewinn, " Euro.")
      Sys.sleep (1.0)
      message ("Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.")
      Sys.sleep (1.0)
    }
  if(Durchgaenge == o) break
  }
}

Roulette_Schleife <- function (y, z, o) {
  Durchgaenge <- 0
  Gesamtgewinn <- 0
  repeat {
    Durchgaenge <- Durchgaenge + 1
    message ("Runde ", Durchgaenge, "!")
    x <- sample (0:36, 1)
    Gewinn <- if (is.element(x, z)) {
      if (identical(z, RED) | identical(z, BLACK) |
          identical(z, ODD) | identical(z, EVEN)) {
        y
      } else if (identical(z, firstThird) |
          identical(z, secondThird) |
          identical(z, lastThird)) {
        y * 2
      } else {
        y * 35
      }
    } else {
      -y
    }
    Gesamtgewinn <- Gesamtgewinn + Gewinn
    message ("Roulettekugel startet")
    Sys.sleep (2.0)
    message ("Rien ne va plus!")
    Sys.sleep (2.0)
    message ("Es ist eine ", x, ".")
    Sys.sleep (2.0)
    if (is.element (x, z)) {
      message ("Du hast gewonnen!")
      Sys.sleep (2.0)
      message ("Dein Gewinn beträgt ", Gewinn, " Euro." )
      Sys.sleep (1.0)
      message ("Damit liegt dein Gesamtgewinn bisher bei ", Gesamtgewinn, " Euro.")
      Sys.sleep (1.0)
    } else {
      message ("Du hast verloren!")
      Sys.sleep (2.0)
      message ("Damit liegt dein Gesamtgewinn bisher bei ", Gesamtgewinn, " Euro.")
      Sys.sleep (1.0)
      message ("Gib nicht auf! In der nächsten Runde wird das Glück wieder auf deiner Seite stehen.")
      Sys.sleep (1.0)
    }
  if(Durchgaenge == o) break
  }
  message ("Deine ", Durchgaenge, " Runden sind durch.")
  Sys.sleep (3.0)
  message ("Du hast heute in ", Durchgaenge, " Spielrunden jeweils mit einem Einsatz von ", y, " Euro auf ", z, " einen Gesamtgewinn von ", Gesamtgewinn, " Euro erzielt!")
  Sys.sleep (3.0)
  if (Gesamtgewinn > 0) {
    message("Herzlichen Glueckwunsch!")
  } else if (Gesamtgewinn == 0) {
    message("Sie haben heute nichts gewonnen. Wollen Sie wirklich schon gehen?")
  } else {
    message("Schade. Aber seien Sie nicht traurig. Das nächste Mal steht das Glueck wieder auf Ihrer Seite!")
  }
}

Roulette_Schleife(5, BLACK, 3)
Roulette_Schleife(100, ODD, 4)
