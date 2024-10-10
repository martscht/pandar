load(url('https://pandar.netlify.app/daten/edu_exp.rda'))

# Anschauen der ersten Zeilen
head(edu_exp)

# ggplot2 laden, muss unter Umständen noch installiert werden, siehe prompt von RStudio
library(ggplot2)

# Nur die Daten des Jahr 2014 in Subset anlegen
edu_2014 <- subset(edu_exp, Year == 2014)

# Daten für ggplot angeben, erstmal leere Fläche da aes und geom noch fehlen
ggplot(edu_2014)

# Erste Ästhetik (x-Achse) festlegen
ggplot(edu_2014, aes(x = Wealth))

# Ausprägungen der Variable
unique(edu_2014$Wealth)

# Variable in einen factor mit labels überführen
edu_2014$Wealth <- factor(edu_2014$Wealth, levels = c('low_income', 'lower_middle_income', 'upper_middle_income', 'high_income'),
  labels = c('Low', 'Lower Mid', 'Upper Mid', 'High'))

# Labels ausgeben lassen
levels(edu_2014$Wealth)

# Erste Ästhetik (x-Achse) festlegen
ggplot(edu_2014, aes(x = Wealth))

# Nun wird der fertige Scatter Plot zwischen Grundschulbildung und Education Index dargestellt
ggplot(edu_2014, aes(x = Wealth)) +
  geom_bar()

# Speichert eine Grundlagenschicht in ggplot, basierend auf data und aes, diese gilt als Basis für die danach erstellten Grafiken
basic <- ggplot(edu_2014, aes(x = Wealth))

# Grundschema wird zusammen mit der Geometrie "Balken" aufgerufen
basic + geom_bar()

# Balken einfärben
ggplot(edu_2014, aes(x = Wealth)) +
  geom_bar(fill = 'blue', color = 'grey40')

# Farbverlauf durch Werte von x über aes
ggplot(edu_2014, aes(x = Wealth)) +
  geom_bar(aes(fill = Wealth), color = 'grey40')

# Tabelle der vier "Kontinent", die sich im Datensatz befinden, Amerikas zusammengefasst, kein Australien
table(edu_2014$Region)

edu_2014$Region <- factor(edu_2014$Region, levels = c('africa', 'americas', 'asia', 'europe'),
  labels = c('Africa', 'Americas', 'Asia', 'Europe'))

ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40')

ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40', position = 'dodge')

# Speichern des Grundmodells des scatter-plots, um es danach mit versch. Themes darzustellen
bars <- ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40', position = 'dodge')

# Minimal theme
bars + theme_minimal()

## # Package für weitere ggplot-themes, kann man durch auskommentieren installieren
## install.packages('ggthemes')
## library(ggthemes)



# maximal Data, minimal Ink - Theme
bars + theme_tufte()

# Beispielhaft minimal als default-theme setzen
theme_set(theme_minimal())

## # Hiermit kann man zurück zum ursprünglichen R-Theme da R-Grundeinstellungen ersetzt werden
## theme_set(theme_grey())

# Einfügen von Beschriftungen für die einzelnen Bestandteile und Achsen
ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40', position = 'dodge') +
  labs(x = 'Country Wealth (GDP per Capita)',
    y = 'Count',
    fill = 'World Region') +
  ggtitle('Categorization of Countries in GapMinder Data', '(Data for 2014)')

# Abbildung in Objekt ablegen
bars <- ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40', position = 'dodge') +
  labs(x = 'Country Wealth (GDP per Capita)',
    y = 'Count',
    fill = 'World Region') +
  ggtitle('Categorization of Countries in GapMinder Data', '(Data for 2014)')

# Abbildung in Objekt ablegen
ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40', position = 'dodge') +
  scale_y_continuous(name = 'Count',
                     limits = c(0,40),
                     breaks = seq(0,40,5)
                     ) + 
  scale_x_discrete(name = 'Country Wealth (GDP per Capita)') +
  ggtitle('Categorization of Countries in GapMinder Data', '(Data for 2014)')

# Ändert Farbe zu Grautönen, für Druckfreundlichkeit
bars + scale_fill_grey()

# Definiren einer custom Farbpalette basierend auf der Corporate Goethe Universität Palette
gu_colors <- c('#00618f', '#e3ba0f', '#ad3b76', '#737c45', '#c96215')

# Zuweisung der händisch erstellten Farbpalette zum Barplot
bars + scale_fill_manual(values = gu_colors)

ggplot(
  data = edu_2014,
  aes(y = Index)
  ) +
  geom_boxplot() +
  theme_minimal() +
  labs(y = 'Education Index des United Nations Development Programme')

ggplot(
  data = edu_2014,
  aes(x = Index)
  ) +
  geom_histogram(fill = "lightgrey", color = "white") +
  theme_minimal() +
  scale_x_continuous(name = 'Education Index des United Nations Development Programm',
                     limits = c(0,1),
                     breaks = seq(0,1,0.1)) + 
  scale_y_continuous(name = 'Anzahl',
                     limits = c(0,20),
                     breaks = seq(0,20,5))

ggplot(
  data = edu_2014,
  aes(x = Index)
  ) +
  geom_density() +
  theme_minimal() +
  labs(x = 'Education Index des United Nations Development Programme')

source("https://pandar.netlify.app/daten/Data_Processing_distort.R")

# Kategoriale Variablen in Faktoren umwandeln
distort$east <- factor(distort$east,
                       levels = c(0, 1),
                       labels = c("westdeutsch", "ostdeutsch"))

distort$stud <- factor(distort$stud,
                       levels = c(0, 1),
                       labels = c("Nicht Studi", "Studi"))

stud_prop_table <- prop.table(table(distort$stud))

# Pakete einlesen
library(psych)
library(skimr)

# Deskriptivstatistik
psych::describe(distort$cm)
skimr::skim(distort$cm)

# Paket einlesen
library(car)

# QQ-Plot zeichnen
car::qqPlot(distort$cm)

t.test(distort$cm,
       mu = 5.4,
       alternative = "less",
       conf.level = 0.95)

one_sample_test <- t.test(distort$cm,
                          mu = 5.4,
                          alternative = "less",
                          conf.level = 0.95)

library(effsize)

effsize::cohen.d(distort$cm,
                 f = NA,
                 mu = 5.4,
                 conf.level = 0.95)

one_sample_eff <- effsize::cohen.d(distort$cm,
                                   f = NA,
                                   mu = 5.4,
                                   conf.level = 0.95)

# AV Spalte für die beiden Gruppen auftrennen
west_data <- subset(distort, subset = east == "westdeutsch")
ost_data <- subset(distort, subset = east == "ostdeutsch")

shapiro.test(west_data$cm)
shapiro.test(ost_data$cm)

# Paket einlesen
library(car)     #wenn nicht schon geschehen

# Levene Test
car::leveneTest(distort$cm ~ distort$east)

t.test(distort$cm ~ distort$east, # abhängige Variable ~ unabhängige Variable
       alternative = "less",      # die erste Ausprägung "westdeutsch" soll "less" Verschwörungsmentalität aufweisen
       var.equal = TRUE,          # Homoskedastizität liegt vor
       conf.level = 0.95)         # alpha = 5%

indep_two_sample_test <- t.test(distort$cm ~ distort$east,
                                alternative = "less",
                                var.equal = TRUE,
                                conf.level = 0.95)

effsize::cohen.d(distort$cm ~ distort$east,
                 conf.level = 0.95)

load(url('https://pandar.netlify.app/daten/fb23.rda'))

# Rekodierung invertierter Items
fb23$mdbf4_pre_r <- -1 * (fb23$mdbf4_pre - 4 - 1)
fb23$mdbf11_pre_r <- -1 * (fb23$mdbf11_pre - 4 - 1)
fb23$mdbf3_pre_r <-  -1 * (fb23$mdbf3_pre - 4 - 1)
fb23$mdbf9_pre_r <-  -1 * (fb23$mdbf9_pre - 4 - 1)
fb23$mdbf5_pre_r <- -1 * (fb23$mdbf5_pre - 4 - 1)
fb23$mdbf7_pre_r <- -1 * (fb23$mdbf7_pre - 4 - 1)

# Berechnung von Skalenwerten
fb23$wm_pre  <- fb23[, c('mdbf1_pre', 'mdbf5_pre_r', 
                        'mdbf7_pre_r', 'mdbf10_pre')] |> rowMeans()
fb23$gs_pre  <- fb23[, c('mdbf1_pre', 'mdbf4_pre_r', 
                        'mdbf8_pre', 'mdbf11_pre_r')] |> rowMeans()
fb23$ru_pre <-  fb23[, c("mdbf3_pre_r", "mdbf6_pre", 
                         "mdbf9_pre_r", "mdbf12_pre")] |> rowMeans()

fb23$gs_diff <- fb23$gs_post - fb23$gs_pre

shapiro.test(fb23$gs_diff)

car::qqPlot(fb23$gs_diff)

t.test(fb23$gs_post, fb23$gs_pre,
       paired = TRUE,
       alternative = "two.sided",
       conf.level = 0.95)

dep_two_sample_test <- t.test(fb23$gs_post, fb23$gs_pre,
                              paired = TRUE,
                              alternative = "two.sided",
                              conf.level = 0.95)

effsize::cohen.d(fb23$gs_post, fb23$gs_pre, # Messzeitpunkte
                 paired = TRUE,             # abhängige Stichproben
                 conf.level = 0.95,         # alpha = 5%
                 within = FALSE,            # Korrektur die wir nicht brauchen         
                 na.rm = TRUE)              # da NAs in den Daten vorkommen
