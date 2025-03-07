# Pakete einladen
if (!require("httr")) install.packages("httr"); library(httr)  # Wenn httr nicht installiert ist, installieren
if (!require("readxl")) install.packages("readxl"); library(readxl)  # Wenn readxl nicht installiert ist, installieren


url <- "https://osf.io/download/snqwr"   # URL zum Download der Excel-Datei

# Für das herkömmliche Einladen des Datensatzes wäre der Download der Datei einfach möglich
# anschließend können folgende Befehle verwendet werden
# setwd("C:/Users/...") # Verzeichnis anpassen
# df_7 <- read_excel("Gender differences in scholastic attitdues & achievement, OSF Datasets.xlsx", sheet = "Study 1 Year 7 Data")
# df_8 <- read_excel("Gender differences in scholastic attitdues & achievement, OSF Datasets.xlsx", sheet = "Study 2 Year 8 Data")

# Datei direkt in den Arbeitsspeicher laden
temp_file <- tempfile(fileext = ".xlsx")
# Datei von der URL herunterladen und in der temporären Datei speichern
GET(url, write_disk(temp_file, overwrite = TRUE))
# Excel-Datei einlesen - Spezifisch ein Tabellenblatt
df_7 <- read_excel(temp_file, sheet = "Study 1 Year 7 Data")
df_8 <- read_excel(temp_file, sheet = "Study 2 Year 8 Data")

# Egal welcher Weg gewählt wurde - nun sollten die Datensätze df_7 und df_8 vorliegen
# Damit kann die Aufbereitung des Datensatzes gestartet werden

# Autor*innen des Papers haben sich dafür entschieden, die Daten getrennt zu analysieren
# für unsere Übungen ist es aber schöner, wenn wir einen größeren Datensatz mit mehr Gruppierungsvariablen haben
# also bilden wir einen Datensatz, der beide Datensätze enthält
data <- rbind(df_7, df_8) # Datensätze in einem zusammenführen

# Autor*innen des Papers haben sich außerdem dafür entschieden, fehlende Werte durch den Mittelwert der Skalen zu ersetzen
# abgesehen von methodischen Kritiken daran ist es für die Übungen schöner, fehlende Werte im Datensatz zu belassen
# also ersetzen wir die Mittelwerte wieder durch einen fehlende Werte Indikator (-9)
# glücklicherweise sind die Mittelwerte einfach zu identifizieren, weil es die einzigen Werte mit Nachkommastellen sind
# also ersetzen wir alle Werte, die Nachkommastellen haben, durch -9
# diese Funktion ist sehr komplex und geht über diese Tutorials hinaus
data[] <- lapply(data, function(x) {
  if (is.numeric(x)) {  # Nur numerische Spalten bearbeiten
    x[as.integer(x) != x] <- -9  # Werte mit Nachkommastellen ersetzen
  }
  return(x)
})
colSums(data == -9)  # Anzahl der fehlenden Werte pro Spalte anzeigen)

# im Datensatz liegen kategoriale Variablen bereits als Text vor
# zur Übung wäre es aber auch gut, wenn diese erstmal nur Zahlen sind
# daher wird Geschlecht nochmal als numerisch rekodiert
data$Gender <- as.numeric(factor(data$Gender)) # Geschlecht als numerisch rekodieren
rm(df_7, df_8)  # Die beiden Datensätze sind nicht mehr nötig
rm(url, temp_file)  # Die URL und die temporäre Datei sind auch nicht mehr nötig)
