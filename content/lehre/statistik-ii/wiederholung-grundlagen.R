# ---- Wiederholung von Grundlagen in R ----
#Dieses Skript stammt von https://pandar.netlify.app/lehre/statistik-ii/wiederholung-grundlagen.R, von der PandaR-Website der Goethe Universität Frankfurt.
#Die Autoren dieses Skripts sind Kai J. Nehler, Johanna Schüller & Martin Schultze. Skriptkompilierung von Kevin Pommeranz.

# Aktuelle R-Version kontrollieren
R.Version()$version.string

## #Updated Packages, nur Ausklammern falls man dies durchführen will!
## update.packaes(ask = FALSE)

#Ein Additionsbeispiel, dass in der Konsole demonstriert wird
2 + 1

#### Wiederholung in R ----

1 + 2   # Addition

3 == 4   # Logische Abfrage auf Gleichheit

sum(1, 2) # Addition durch Funktion

#Listet die Argumente der Funktion, hier Zahl die Nachkommastellen angibt als Zusatz zu der zu rundenden Zahl
args(round)

#Demonstration von round und seinem Default-Wert für die Zahl!
round(1.2859)

#Ersetzenn des Default
round(1.2859, digits = 2)

#Hier wird gezeigt, dass die Reihenfolge der Operatoren egal ist, WENN sie explizit benannt werden
round(digits = 2, x = 1.2859)

#### Objekte ----

my_num <- sum(3, 4, 1, 2) # Objekt zuweisen

sqrt(my_num) # Objekt in Funktion einbinden

sqrt(sum(3, 4, 1, 2)) # Verschachtelte Funktionen

sum(3, 4, 1, 2) |> sqrt() # Nutzung Pipe

#### Vektoren ----

zahlen <- c(8, 3, 4) #Vektorerstellung

zahlen * 3 #Multiplikation der Elemente des Vektors

#Vier Typen von Vektor, logical/numeric/character/factor
#str() ermittelt die Klasse
str(zahlen)

#Umwandlung des Vektors in character
zeichen <- as.character(zahlen)
str(zeichen)

#Beispiel einer fehlerhaften Operation
zeichen * 3

#### Matrizen ----

mat<- matrix(c(7, 3, 9, 1, 4, 6), ncol = 2) #Matrixerstellung

#Erstelle Matrize anschauen, Typ der Matrize anschauen
mat
str(mat)

#Zugriff auf Eintrag in [Zeile, Spalte]
mat[3, 1]

#Bestimmung der Dimensionen, einzeln oder in einem
nrow(mat)
ncol(mat)
dim(mat) #alternativer Befehl

## #### Datenmanagement ----
## 
## #Beispiel, eine RDA zu laden, die sich auf dem eigenen Desktop befindet
## load("C:/Users/Musterfrau/Desktop/mach.rda")

#Laden des Datensatz aus dem Internet
# load(url("https://pandar.netlify.app/daten/mach.rda"))

#Betrachtung der Daten
head(mach) # ersten 6 Zeilen

names(mach) # Namen der Variablen

dim(mach) # Anzahl der Zeilen und Spalten 

#### Deskriptivstatistik ----

mean(mach$cvhn)    # Mittelwert
var(mach$cvhn)     # geschätzte Populationsvarianz

## #Beispiel der Indizierung über eckige Klammern statt Variablenname
## mach[, 25] #Alle Zeilen, Spalte 25


#Betrachten der Häufigkeit & Format der Variable
table(mach$engnat)
str(mach$engnat)

#Variable wird zum Faktor umgewandelt, da sie numerisch vorlag

mach$engnat <- factor(mach$engnat,                # Ausgangsvariable
                      levels = 1:2,               # Faktorstufen
                      labels = c("Ja", "Nein"))   # Bedeutung

str(mach$engnat)                                  # Test der Umwandlung

#Describe wird ohne Package ausgeführt um zu zeigen, dass es so einen Fehler wirft
describe(mach$cvhn)

## #Package kann nun installiert werden, wenn nicht bereits vorhanden
## install.packages("psych")

#Package wird aus der Library geladen und danach erneut describe () ausgeführt, sollte jetzt funktionieren
library(psych)
describe(mach$cvhn)

#### Lineare Regression ----

#Genereller Zusammenhang von Positiver Sichtweise und Zynischer Sichtweise
plot(mach$pvhn, mach$cvhn, xlab = "Positive Sichtweise", ylab = "Negative Sichtweise")

lm(cvhn ~ pvhn, mach) # lineare Regression

model <- lm(cvhn ~ pvhn, mach)  # Objektzuweisung

summary(model) #Ergebniszusammenfassung

#names() enthält unter anderem die 'residuals' für Voraussetzungsprüfung, als auch vorgehesagte Werte, 'fitted.values'
names(model) #andere Inhalte der Liste



#### T-test ----

#t-Test; H0: Mittelwert von cvhn ist nicht signifikant verschieden zwischen non-native english speakers und native english speakers, Voraussetzungen werden als erfüllt angenommen
t.test(cvhn ~ engnat,  # abhängige Variable ~ unabhängige Variable
       data = mach, # Datensatz
       paired = FALSE, # Stichproben sind unabhängig 
      alternative = "two.sided",        # zweiseitige Testung (Default)
      var.equal = TRUE,                 # Homoskedastizität liegt vor (-> Levene-Test)
      conf.level = .95)                 # alpha = .05 (Default)







#T-test wird abgespeichert, im Nachhinein wird gezeigt, dass man sich mit names() wieder alle Variablen anzeigen lassen kann

ttest <- t.test(cvhn ~ engnat,  # abhängige Variable ~ unabhängige Variable
       data = mach, # Datensatz
       paired = FALSE, # Stichproben sind unabhängig 
      alternative = "two.sided",        # zweiseitige Testung (Default)
      var.equal = TRUE,                 # Homoskedastizität liegt vor (-> Levene-Test)
      conf.level = .95)                 # alpha = .05 (Default)
names(ttest)    # alle möglichen Argumente, die wir diesem Objekt entlocken können
ttest$statistic # (empirischer) t-Wert
ttest$p.value   # zugehöriger p-Wert

set.seed(123)
group1 <- rnorm(20, mean = 10, sd = 2)
group2 <- rnorm(20, mean = 12, sd = 2)

t.test(group1, group2)

foo <- function(x) {
  x <- na.omit(x)
  sum((x - mean(x))^2)/length(x)
}
