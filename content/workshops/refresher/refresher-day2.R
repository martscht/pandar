# Libraries ----

library(ggplot2)
library(ggthemes)
library(psych)
library(skimr)
library(car)
library(effsize)
library(lm.beta)

# ggplot ----

load(url('https://pandar.netlify.app/daten/edu_exp.rda'))

# Anschauen der ersten Zeilen
head(edu_exp)

## Schichten ----

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

# Package für weitere ggplot-themes, kann man durch auskommentieren installieren
#install.packages('ggthemes')
library(ggthemes)

# maximal Data, minimal Ink - Theme
bars + theme_tufte()

# Beispielhaft minimal als default-theme setzen
theme_set(theme_minimal())

# Hiermit kann man zurück zum ursprünglichen R-Theme da R-Grundeinstellungen ersetzt werden
theme_set(theme_grey())

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

ggplot(edu_2014, aes(x = Wealth, group = Region)) +
  geom_bar(aes(fill = Region), color = 'grey40', position = 'dodge') +
  scale_y_continuous(name = 'Count',
                     limits = c(0,40),
                     breaks = seq(0,40,5)
  ) + 
  scale_x_discrete(name = 'Country Wealth (GDP per Capita)') +
  ggtitle('Categorization of Countries in GapMinder Data', '(Data for 2014)')

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


# t-Test ----

## Einstichproben ----

source("https://pandar.netlify.app/daten/Data_Processing_distort.R")

# Kategoriale Variablen in Faktoren umwandeln
distort$east <- factor(distort$east,
                       levels = c(0, 1),
                       labels = c("westdeutsch", "ostdeutsch"))

distort$stud <- factor(distort$stud,
                       levels = c(0, 1),
                       labels = c("Nicht Studi", "Studi"))


# Pakete einlesen
library(psych)
library(skimr)

# Deskriptivstatistik
psych::describe(distort$cm)
skimr::skim(distort$cm)

### Normalverteilungsprüfung ----

# Paket einlesen
library(car)

# QQ-Plot zeichnen
car::qqPlot(distort$cm)

### Test ----
t.test(distort$cm,
       mu = 5.4,
       alternative = "less",
       conf.level = 0.95)

### Effektstärke ----

library(effsize)

effsize::cohen.d(distort$cm,
                 f = NA,
                 mu = 5.4,
                 conf.level = 0.95)

## Unabhängige Stichproben ----

### Normalverteilungsprüfung ----

# AV Spalte für die beiden Gruppen auftrennen
west_data <- subset(distort, subset = east == "westdeutsch")
ost_data <- subset(distort, subset = east == "ostdeutsch")

shapiro.test(west_data$cm)
shapiro.test(ost_data$cm)

### Varianz Homogenität ----

# Paket einlesen
library(car)     #wenn nicht schon geschehen

# Levene Test
car::leveneTest(distort$cm ~ distort$east)

### Test ----

t.test(distort$cm ~ distort$east, # abhängige Variable ~ unabhängige Variable
       alternative = "less",      # die erste Ausprägung "westdeutsch" soll "less" Verschwörungsmentalität aufweisen
       var.equal = TRUE,          # Homoskedastizität liegt vor
       conf.level = 0.95)         # alpha = 5%

### Effektstärke ----

effsize::cohen.d(distort$cm ~ distort$east,
                 conf.level = 0.95)


## Abhängige Stichproben ----

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


### Normalverteilungsprüfung ----

fb23$gs_diff <- fb23$gs_post - fb23$gs_pre

shapiro.test(fb23$gs_diff)

car::qqPlot(fb23$gs_diff)

### Test ----

t.test(fb23$gs_post, fb23$gs_pre,
       paired = TRUE,
       alternative = "two.sided",
       conf.level = 0.95)

### Effektstärke ----

effsize::cohen.d(fb23$gs_post, fb23$gs_pre, # Messzeitpunkte
                 paired = TRUE,             # abhängige Stichproben
                 conf.level = 0.95,         # alpha = 5%
                 within = FALSE,            # Korrektur die wir nicht brauchen         
                 na.rm = TRUE)              # da NAs in den Daten vorkommen


# Regression ----

## Vorbereitung ----

# Daten laden
load(url('https://pandar.netlify.app/daten/fb23.rda'))  

# Nominalskalierte Variablen in Faktoren verwandeln
fb23$hand_factor <- factor(fb23$hand,
                           levels = 1:2,
                           labels = c("links", "rechts"))
fb23$fach <- factor(fb23$fach,
                    levels = 1:5,
                    labels = c('Allgemeine', 'Biologische', 'Entwicklung', 'Klinische', 'Diag./Meth.'))
fb23$ziel <- factor(fb23$ziel,
                    levels = 1:4,
                    labels = c("Wirtschaft", "Therapie", "Forschung", "Andere"))

fb23$wohnen <- factor(fb23$wohnen, 
                      levels = 1:4, 
                      labels = c("WG", "bei Eltern", "alleine", "sonstiges"))

fb23$fach_klin <- factor(as.numeric(fb23$fach == "Klinische"),
                         levels = 0:1,
                         labels = c("nicht klinisch", "klinisch"))

fb23$ort <- factor(fb23$ort, levels=c(1,2), labels=c("FFM", "anderer"))

fb23$job <- factor(fb23$job, levels=c(1,2), labels=c("nein", "ja"))


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

# z-Standardisierung
fb23$ru_pre_zstd <- scale(fb23$ru_pre, center = TRUE, scale = TRUE)


## Einfache Lineare Reg. ----

plot(fb23$extra, fb23$nerd, xlab = "Extraversion", ylab = "Nerdiness", 
     main = "Zusammenhang zwischen Extraversion und Nerdiness", xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb23$extra, fb23$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang

lm(formula = nerd ~ 1 + extra, data = fb23)

lin_mod <- lm(nerd ~ extra, fb23) 

coef(lin_mod) 
lin_mod$coefficients

formula(lin_mod)


# Scatterplot zuvor im Skript beschrieben
plot(fb23$extra, fb23$nerd, 
     xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb23$extra, fb23$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang
# Ergebnisse der Regression als Gerade aufnehmen
abline(lin_mod, col = 'red')

residuals(lin_mod)

predict(lin_mod)

extra_neu <- data.frame(extra = c(1, 2, 3, 4, 5))

predict(lin_mod, newdata = extra_neu)

#Konfidenzintervalle der Regressionskoeffizienten
confint(lin_mod)

#Detaillierte Modellergebnisse
summary(lin_mod)

summary(lin_mod)$r.squared

r2 <- summary(lin_mod)$r.squared*100

library(lm.beta)

lin_model_beta <- lm.beta(lin_mod)
summary(lin_model_beta)

# Möglichkeit A:
ggplot(data = fb23, aes(x = extra, y = nerd))+ #Grund-Ästhetik auswählen
  geom_point() + # Darstellung der Testwerte als Punkte
  geom_abline(intercept = coef(lin_mod)[1], slope = coef(lin_mod)[2], color = 'red') # Hinzufügen der Regressionsgerade

# Möglichkeit B: Vorteil = Anzeige des Konfidenzintervalls
ggplot(data = fb23, aes(x = extra, y = nerd))+
  geom_point() +
  geom_smooth(method="lm", formula = "y~x", color = 'red')


## Multiple Reg. ----

burnout <- read.csv(file = url("https://osf.io/qev5n/download"))
burnout <- burnout[,2:8]
dim(burnout)

str(burnout)

mod <- lm(Violence ~ Exhaust + Distan + PartConfl, data = burnout)

summary(mod)

resid(mod)[1:10]

confint(mod, level = 0.95)

predict_data <- data.frame(Exhaust = 3, Distan = 4, PartConfl = 2)

predict(mod, newdata = predict_data)

predict(mod, newdata = predict_data, interval = "prediction", level = 0.95)

mod_quad <- lm(Violence ~ Exhaust + Distan + poly(PartConfl, 2), data = burnout)
summary(mod_quad)

# Vergleich mit Modell ohne quadratischen Trend
summary(mod)$r.squared - summary(mod_quad)$r.squared # Inkrement

anova(mod, mod_quad) # Signifikanztestung des Inkrements

# Regressionsmodell erstellen:
mod_g <- lm(lz ~ neuro + fach_klin, data = fb23)
summary(mod_g)

# Scatterplot erstellen
scatter <- ggplot(fb23, aes(x = neuro, y = lz, color = fach_klin)) + 
  geom_point()
scatter

# Regressionsgerade aus mod_g hinzufügen
scatter + 
  geom_abline(intercept = coef(mod_g)[1], slope = coef(mod_g)[2], 
              color = '#00618F') # Regressionsgerade für klinische Fachrichtung

scatter + 
  geom_abline(intercept = coef(mod_g)[1], slope = coef(mod_g)[2], 
              color = '#00618F') + # Regressionsgerade für klinische Fachrichtung
  geom_abline(intercept = coef(mod_g)[1] + coef(mod_g)[3], slope = coef(mod_g)[2], 
              color = '#ad3b76') # Regressionsgerade für nicht klinische Fachrichtung
