# # Pakete aktualisieren
# update.packages(ask = FALSE)
# 
# # Paket car installieren (ausführen falls noch nicht installiert)
# install.packages("car")
# 
# # Alternativ: Automatisiert überprüfen, ob das Paket installiert ist
# # if (!requireNamespace("car", quietly = TRUE)) {
# #  install.packages("car")
# # }
# 
# # Paket car laden
# library(car)
# 
# # Version des Pakets ausgeben
# packageVersion("car")

# Numerischer Vektor
zahlen <- c(3, 7, 12, 15)

# Logischer Vektor
logik <- c(TRUE, FALSE, TRUE, TRUE)

# Kombination in einem data.frame
daten <- data.frame(zahlen, logik)

# Struktur des Datensatzes ausgeben
str(daten)

# Datensatz erstellen
alter <- c(22, 30, 27, 19, 34)

geschlecht <- factor(c(1, 2, 2, 1, 2), 
                     labels = c("männlich", "weiblich"))

df <- data.frame(alter, geschlecht)

# Filtern nach Alter > 25
gefiltert <- df[df$alter > 25, ]

# Anzahl der verbleibenden Beobachtungen ausgeben
nrow(gefiltert)
