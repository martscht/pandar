3 + 7 * 12

(3 + 7 * 12) == (3 * 29)

zahl <- round(sqrt(115))

6 * 1,56

6 * 1.56

sprinterin <- c('Elaine Thompson-Herah', 'Shelly-Ann Fraser-Pryce', 'Shericka Jackson', 'Marie-Josee Ta Lou', 'Ajla del Ponte')
zeit <- c(10.61, 10.74, 10.76, 10.91, 10.97)

class(sprinterin)
class(zeit)

olymp <- data.frame(sprinterin, zeit)
str(olymp)

olymp <- data.frame(sprinterin, zeit, stringsAsFactors = FALSE)
str(olymp)

olymp[3, 2]         # dirkete Auswahl via Position
olymp[3, 'zeit']    # Variablenauswahl per Name
olymp[olymp$sprinterin == 'Shericka Jackson', 'zeit']  # Filterauswahl

olymp[6, ] <- c('Muljinga Kambundji', 10.99)
olymp

nation <- c('Jamaika', 'Jamaika', 'Jamaika', 'Elfenbeinküste', 'Schweiz', 'Schweiz')
full <- data.frame(olymp, nation)   # via data.frame
# Alternative: via cbind
  # full <- cbind(olymp, nation)
full

olymp$nation <- c('Jamaika', 'Jamaika', 'Jamaika', 'Elfenbeinküste', 'Schweiz', 'Schweiz')
olymp

sum(olymp$zeit)
str(olymp)

olymp$zeit <- as.numeric(olymp$zeit)
str(olymp)

olymp <- data.frame(sprinterin, zeit)
olymp[6, ] <- data.frame('Muljinga Kambundji', 10.99)
str(olymp)

sum(olymp$zeit)

## setwd(...)
## fb23 <- read.table('fb23.csv',
##   header = TRUE,
##   sep = ',')

fb23 <- read.table('https://pandar.netlify.app/daten/fb23.csv', 
  header = TRUE,
  sep = ',')

str(fb23$ziel)

## # Umwandung von numeric in factor
## fb23$ziel <- as.factor(fb23$ziel)
## # Vergabe von levels
## levels(fb23$ziel) <- c('Wirtschaft', 'Therapie', 'Forschung', 'Andere')

fb23$ziel <- factor(fb23$ziel,
  labels = c('Wirtschaft', 'Therapie', 'Forschung', 'Andere'))

str(fb23$ziel)

fb23$uni <- fb23$uni1 + fb23$uni2 + fb23$uni3 + fb23$uni4
str(fb23$uni)

fb23$uni <- rowSums(fb23[, c('uni1', 'uni2', 'uni3', 'uni4')])
str(fb23$uni)

## help(subset)

therapie <- subset(fb23,            # Voller Datensatz
  subset = fb23$ziel == 'Therapie'  # Auswahlkriterium
  )
str(therapie)

## saveRDS(therapie, 'therapie.rds')
