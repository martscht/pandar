library(knitr)
options_guide <- data.frame(
  Einstellung = c("Font Size", "Theme", "Rainbow Parentheses", "Indentation Guidelines"),
  Änderung = c("Tools>Global Options>Appearance>Font Size","Tools>Global Options>Appearance>Theme", "Tools>Global Options>Code>Display>Syntax>Use Rainbow Parentheses", "Tools>Global Options>Code>Display>General>Indentation Guidelines"),
  Beschreibung = c("Anpassen der Schriftgröße", "Themes beeinflussen Hintergrund- und Schriftfarbe. Idealerweise sollte ein Theme gewählt werden, welches hilft, die Syntax besser zu überblicken.", "Zusammengehörige Klammern erhalten dieselbe Farbe. Hilft bei der Übersichtlichkeit.", "Die eingerückte Fläche wird farbig markiert. Hilft beim Überblick.")
)
kable(options_guide)

(34+47+23+90+23+45+89+98)/8
mean(c(34,47,23,90,23,45,89,98))

mw <- mean(c(34,47,23,90,23,45,89,98))
mw

mw <- c(34,47,23,90,23,45,89,98) |> mean()
mw

## ls()

## rm(list = ls())

rm('mw', 'options_guide')

library(knitr)
data2 <- data.frame(
  Abschnitt = c("Description", "Usage", "Arguments", "Details", "Values","See also", "Examples"),
  Inhalt = c("Beschreibung der Funktion","Zeigt die Argumente an, die die Funktion entgegennimmt. Argumente auf die ein = folgt haben Standardeinstellungen und müssen nicht jedes mal aufs Neue definiert werden, Argumente ohne = jedoch schon.", "Liste der Argumente mit Beschreibung", "Zusatzinformationen zur Funktion","Übersicht über die möglichen Ergebnisinhalte der Funktion", "Ähnliche Funktionen", "Praxisbeispiel, Funktion wird angewendet")
)
kable(data2)

## 
## getwd()

## 
## setwd("/Users/luca/Desktop/rworkshop2025")
## 

## setwd("C:/Users/luca/workshop2025")

## data_raw <- read.csv(
##   file = "data_raw.csv", # Filename
##   na.strings = c("", "NA", "-9"), # -9 als fehlender Wert kodieren
##   header = TRUE, # Header für Spaltennamen
##   sep = ";" # Semikolon als Separator
##   )

data_raw <- read.csv(
  file = "data_raw.csv", # Filename
  na.strings = c("", "NA", "-9"), # -9 als fehlender Wert kodieren
  header = TRUE, # Header für Spaltennamen
  sep = ";" # Semikolon als Separator
  )


class(data_raw) # Klasse des Objekts
dim(data_raw) # Dimensionen des Datensatzes (Zeilen + Spalten)
head(data_raw, n = 1) # ersten Zeilen ausgeben
tail(data_raw, n = 1) # letzten Zeilen ausgeben
str(data_raw, vec.len = 2) # Struktur des Datensatzes


# install.packages("dplyr") # Nur einmalig nötig
library(dplyr)
glimpse(data_raw)

colnames(data_raw) # Spaltennamen des Datensatzes

## View(data_raw) # Datensatz in einem neuen Fenster anzeigen

head(data_raw[1, ])                      # erste Zeile, alle Spalten  
head(data_raw[, 1])                     # alle Zeilen, erste Spalte (als Vektor)  
head(data_raw[, 1, drop = FALSE])        # alle Zeilen, erste Spalte (als data.frame)  
head(data_raw[, "CASE", drop = FALSE])   # alle Zeilen, Spalte mit Namen "CASE" (als data.frame)  
data_raw[1, 1]                     # erste Zeile, erste Spalte  
data_raw[1:5, 1:3]                 # erste 5 Zeilen, erste 3 Spalten


head(data_raw$CASE)       # Zugriff über den $-Operator (direkt als Vektor)  
head(data_raw[["CASE"]])  # Zugriff als Vektor, dynamisch über Spaltennamen  
head(data_raw[,"CASE"])    # Zugriff als Data Frame


data_raw <- data_raw[-1, ] # erste Zeile entfernen
head(data_raw)



nrow(data_raw)
nrow(data_raw[-c(1:133), ]) # Zeilen 1 bis 113 entfernen


class(data_raw$TIME_SUM) # Klasse der Spalte TIME_SUM
mean(data_raw$TIME_SUM)

data_raw$TIME_SUM <- as.numeric(data_raw$TIME_SUM) 

colnames(data_raw)

vec_chr <- c("QUESTNNR", "MODE", "STARTED", "LASTDATA")

data_raw[, -match(vec_chr, colnames(data_raw))] <- lapply(
  X = data_raw[, -match(vec_chr, colnames(data_raw))], 
  FUN = as.numeric
  )


head(data_raw$STARTED)

data_raw[, c("STARTED", "LASTDATA")] <- lapply(
  X = data_raw[, c("STARTED", "LASTDATA")],
  FUN = as.POSIXct
)

class(data_raw$STARTED)
head(data_raw$STARTED)


# Geschlecht (Männlich = 1, Weiblich = 2, Divers = 3)
head(data_raw$WMD, n = 10)
data_raw$WMD <- factor(
  x = data_raw$WMD, 
  levels = c(1, 2, 3),
  labels = c("w", "m", "d")
  )


# ET: Entscheidung (1 = ja, 2 = nein)
# FK: Direkter Vorgesetzter (1 = ja, 2 = nein)

data_raw$EN <- factor(
  x = data_raw$EN, 
  levels = c(1, 2),
  labels = c("ja", "nein")
  )

data_raw$FK <- factor(
  x = data_raw$FK, 
  levels = c(1, 2),
  labels = c("ja", "nein")
  )



vec_nms <- c(
  "CASE", "STARTED", 
  paste0("DDM_AV_", 1:5), paste0("DDM_AP_", 1:5), "DDM_SI", 
  sprintf("EL_%02d", 1:14), paste0("PE_ME", 1:3), paste0("PE_CO", 1:3), 
  paste0("PE_SD", 1:3), "K", paste0("PE_IM", 1:3), 
  "ET", "AZ", "EN", "FK", "ALT", "WMD", "LASTDATA", "TIME_SUM"
  )
  

data_sub <- data_raw[, match(vec_nms, colnames(data_raw)) ]


data_sub <- subset(data_raw, select = vec_nms)

dim(data_raw)
dim(data_sub)


colnames(data_sub) <- tolower(colnames(data_sub))
colnames(data_sub)[c(37, 41:46)]
names(data_sub)[c(37, 41:46)] <- c("kontroll", "erwerb", "arbeit_std", "vorgesetzt", "entscheidung", "alter", "geschlecht")
colnames(data_sub)


# Falls nötig, das Paket installieren
# install.packages("knitr")

library(knitr)

log_ops <- data.frame(
  Operator = c("&", "|", "!", "&&", "||", "==", "!=", "<", "<=", ">", ">="),
  Bedeutung = c(
    "Elementweises UND",
    "Elementweises ODER",
    "Negation / NICHT",
    "Kurzes UND (erstes Element)",
    "Kurzes ODER (erstes Element)",
    "Gleich",
    "Ungleich",
    "Kleiner",
    "Kleiner oder gleich",
    "Größer",
    "Größer oder gleich"
  ),
  Beispiel = c(
    "c(TRUE,FALSE,TRUE) & c(TRUE,TRUE,FALSE)",
    "c(TRUE,FALSE,TRUE) | c(FALSE,TRUE,FALSE)",
    "!c(TRUE,FALSE)",
    "TRUE && FALSE",
    "TRUE || FALSE",
    "5 == 5",
    "5 != 3",
    "3 < 5",
    "3 <= 3",
    "5 > 3",
    "5 >= 5"
  ),
  Ergebnis = c(
    "TRUE FALSE FALSE",
    "TRUE TRUE TRUE",
    "FALSE TRUE",
    "FALSE",
    "TRUE",
    "TRUE",
    "TRUE",
    "TRUE",
    "TRUE",
    "TRUE",
    "TRUE"
  )
)

kable(log_ops, caption = "Übersicht der logischen Operatoren in R")


with(data_sub, table(time_sum < 60))

data_sub1 <- subset(data_sub, subset = time_sum >= 60) 

nrow(data_sub)
nrow(data_sub1)

table(data_sub1$kontroll, useNA = "always")

sum(data_sub1$kontroll != 1, na.rm = TRUE) # 21 Personen müssen ausgeschlossen werden

data_sub2 <- subset(data_sub1, subset = (kontroll == 1))
nrow(data_sub1)
nrow(data_sub2)

labels_erwerb <- c("ja", "nein_teilzeit", "nein")
data_sub2$erwerb <- factor(data_sub2$erwerb, levels = c(1, 2, 3), labels = labels_erwerb)

table(data_sub2$erwerb, useNA = "always")

data_sub3 <- subset(data_sub2, subset = erwerb == "ja")

min(data_sub3$alter, na.rm = TRUE) 
any(data_sub3$alter < 18) # Alternative

table(data_sub3$vorgesetzt, useNA = "always")
data_sub4 <- subset(data_sub3, subset = vorgesetzt == "ja")

nrow(data_raw)
nrow(data_sub4)



max_value <- 7
data_sub4$el_05i <- (max_value + 1) - data_sub4$el_05


data_sub4$ddm_ap_1i <- (max_value + 1) - data_sub4$ddm_ap_1
data_sub4$ddm_ap_2i <- (max_value + 1) - data_sub4$ddm_ap_2
data_sub4$ddm_ap_3i <- (max_value + 1) - data_sub4$ddm_ap_3
data_sub4$ddm_ap_4i <- (max_value + 1) - data_sub4$ddm_ap_4
data_sub4$ddm_ap_5i <- (max_value + 1) - data_sub4$ddm_ap_5


## 
## inv_item <- c("el_05", "ddm_ap_1", "ddm_ap_2", "ddm_ap_3", "ddm_ap_4", "ddm_ap_5")
## 
## paste0(inv_item, "i")
## 
## data_sub4[paste0(inv_item, "i")] <- lapply(X = data_sub4[inv_item], FUN = function(x) max_value - x)
## 

# Empowering Leadership (el)

c(sprintf("el_%02d", 1:4), "el_05i", sprintf("el_%02d", 6:14))

data_sub4$el <- rowMeans(data_sub4[, c(sprintf("el_%02d", 1:4), "el_05i", sprintf("el_%02d", 6:14))])

head(data_sub4$el)


grep(pattern = "^pe", x = names(data_sub4), value = TRUE)
data_sub4$pe <- rowMeans(data_sub4[, grep("^pe", names(data_sub4), value = TRUE)])
head(data_sub4$pe)


c(paste0("ddm_av_", 1:5), paste0("ddm_ap_", 1:5, "i")) 

data_sub4$ddm <- rowMeans(data_sub4[, c(paste0("ddm_av_", 1:5), paste0("ddm_ap_", 1:5, "i"))])
head(data_sub4$ddm)

data_analysis <- data_sub4

row.names(data_analysis) <- NULL #Zeilennummern zurücksetzen da diese nicht durchgängig sind nachdem wir welche entfernt haben

# install.packages("psych") 
library(psych)
psych::describe(data_analysis["alter"]) 

psych::describe(data_analysis[c("el", "pe", "ddm")]) 

scales_by_gender <- psych::describeBy(data_analysis[c("el", "pe", "ddm")], group = data_analysis$geschlecht)

print(scales_by_gender, digits = 2)


## describeBy(alter ~ geschlecht, data = data_analysis)

round(cor(data_analysis[c("el", "pe", "ddm")]), 3)

round(cor(data_analysis[c("el", "pe", "ddm")], method = "spearman"), 3)

table(data_analysis$geschlecht)

prop.table(table(data_analysis$geschlecht))

with(data_analysis, table(geschlecht, entscheidung))

x <- data_analysis$ddm
std <- sd(x)
m <- mean(x)
cv <- std / m

na.rm <- FALSE

calc_cv <- function(x, na.rm = FALSE) {
  std <- sd(x, na.rm = na.rm)
  m <- mean(x, na.rm = na.rm)
  cv <- std / m
  return(cv)
}


mean_ci <- function(x, conf = 0.95, na.rm = FALSE, digits = 2) {
  if (na.rm) x <- x[!is.na(x)]
  n <- length(x)
  m <- mean(x)
  s <- sd(x)
  se <- s / sqrt(n)
  alpha <- 1 - conf
  t_crit <- qt(1 - alpha / 2, df = n - 1)
  lower <- m - t_crit * se
  upper <- m + t_crit * se
  # Rundung auf gewünschte Anzahl Nachkommastellen
  result <- round(c(lower = lower, mean = m, upper = upper), digits = digits)
  return(result)
}

# Beispielaufruf
mean_ci(data_analysis$ddm)



# Hypothese 1 - Pfad C
modC <- lm(ddm ~ el, data_analysis)

summary(modC)

plot(modC, which = 1)

plot(modC, which = 3)

# install.packages("car")
library(car)
car::ncvTest(modC)

resid(modC) |> hist()

car::qqPlot(modC)

resid(modC) |> shapiro.test() # nicht signifikant

car::scatterplot(ddm ~ el, data_analysis)

car::residualPlots(modC)

InfPlotC <- influencePlot(modC)

# Die Zeilennummer der auffälligen Personen abspeichern
IDsC <- as.numeric(row.names(InfPlotC))

data_analysis[IDsC, c(sprintf("el_%02d", 1:4), "el_05i", sprintf("el_%02d", 6:14), paste0("ddm_av_", 1:5), paste0("ddm_ap_", 1:5, "i"), "erwerb", "arbeit_std", "vorgesetzt", "entscheidung", "alter", "geschlecht", "time_sum")]

modA <- lm(pe ~ el, data_analysis)

summary(modA)

plot(modA, which = 1)

plot(modA, which = 3)

car::ncvTest(modA)

# install.packages("sandwich")
library(sandwich)

se_corrected <- sandwich::vcovHC(modA)

# install.packages("lmtest")
library(lmtest)

lmtest::coeftest(modA, vcov. = se_corrected)

resid(modA) |> hist()

car::qqPlot(modA)

scatterplot(pe ~ el, data_analysis)

residualPlots(modA)

# Modell aufstellen
mod_pe_ddm <- lm(ddm ~ pe, data_analysis)
summary(mod_pe_ddm)

# Homoskedastizität
plot(mod_pe_ddm, which = 1) # lässt eine Verletzung vermuten

plot(mod_pe_ddm, which = 3) # rote Linie nicht wirklich horizontal

car::ncvTest(mod_pe_ddm) # bestätigt die Vermutung das eine Verletzung vorliegt


# Normalverteilung
resid(mod_pe_ddm) |> hist()

car::qqPlot(mod_pe_ddm) # sieht ok aus

# Bonus: Modell mit robusten Standardfehlern (HC3) rechnen
lmtest::coeftest(mod_pe_ddm, vcov. = sandwich::vcovHC(mod_pe_ddm))

# Schritt 1
boot_data <- data_analysis[sample(1:nrow(data_analysis), nrow(data_analysis), replace = TRUE), ]

# Schritt 2
boot_mod <- lm(ddm ~ pe, boot_data)

# Schritt 3
coef(boot_mod)["pe"]

booting <- function(data){
  
  # Schritt 1
  boot_data <- data_analysis[sample(1:nrow(data), size =
                                      nrow(data), replace =
                                      TRUE), ]

  # Schritt 2
  boot_mod <- lm(ddm ~ pe, boot_data)

  # Schritt 3
  return(coef(boot_mod)["pe"])
  
}

# Schritt 4
set.seed(12345) # damit wir alle das gleiche Ergebnis produzieren
boot_beta_pe <- replicate(n = 1000, booting(data_analysis))

# Schritt 5
mean(boot_beta_pe)

# Schritt 6
sd(boot_beta_pe)

quantile(boot_beta_pe, c(0.025, 0.975))

modBC <- lm(ddm ~ pe + el, data_analysis)

summary(modBC)

# Homoskedastizität
plot(modBC, which = 3) # starke Abweichungen zu erkennen

car::ncvTest(modBC) # signifikant --> Voraussetzung verletzt

# Normalverteilung
resid(modBC) |> hist()

car::qqPlot(modBC) # unproblematisch

# Linearität
car::residualPlots(modBC) # pe geht in Richtung eines quadratischen Effekts jedoch nicht signifikant

set.seed(12345)
psych::mediate(ddm ~ el + (pe), data = data_analysis) |> summary()
