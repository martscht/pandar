#### Was bisher geschah: ----

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


# y ~ 1 + x

plot(fb23$extra, fb23$nerd, xlab = "Extraversion", ylab = "Nerdiness", 
     main = "Zusammenhang zwischen Extraversion und Nerdiness", xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb23$extra, fb23$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang

lm(formula = nerd ~ 1 + extra, data = fb23)

lin_mod <- lm(nerd ~ extra, fb23)                  #Modell erstellen und Ergebnisse im Objekt lin_mod ablegen

coef(lin_mod) 
lin_mod$coefficients

formula(lin_mod)

# Scatterplot zuvor im Skript beschrieben
plot(fb23$extra, fb23$nerd, 
  xlim = c(0, 6), ylim = c(1, 5), pch = 19)
lines(loess.smooth(fb23$extra, fb23$nerd), col = 'blue')    #beobachteter, lokaler Zusammenhang
# Ergebnisse der Regression als Gerade aufnehmen
abline(lin_mod, col = 'red')

residuals(lin_mod) |> round(2)

predict(lin_mod) |> round(2)

extra_neu <- data.frame(extra = c(1, 2, 3, 4, 5))

predict(lin_mod, newdata = extra_neu) 

#Konfidenzintervalle der Regressionskoeffizienten
confint(lin_mod)



#Detaillierte Modellergebnisse
summary(lin_mod)


#Detaillierte Modellergebnisse
summary(lin_mod)


summary(lin_mod)$r.squared



# Paket erst installieren (wenn nötig): install.packages("lm.beta")
library(lm.beta)

lin_model_beta <- lm.beta(lin_mod)
summary(lin_model_beta) # lin_mod |> lm.beta() |> summary()

library(ggplot2)
# Möglichkeit A:
ggplot(data = fb23, aes(x = extra, y = nerd))+ #Grund-Ästhetik auswählen
     geom_point() + # Darstellung der Testwerte als Punkte
  geom_abline(intercept = coef(lin_mod)[1], slope = coef(lin_mod)[2], color = 'red') # Hinzufügen der Regressionsgerade

# Möglichkeit B: Vorteil = Anzeige des Konfidenzintervalls
ggplot(data = fb23, aes(x = extra, y = nerd))+
     geom_point() +
  geom_smooth(method="lm", formula = "y~x", color = 'red')

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
summary(mod_quad)$r.squared - summary(mod)$r.squared  # Inkrement

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

# Lädt das Objekt aus der .rds-Datei und weist es der Variable workshopfb zu
workshopfb <- readRDS("workshopfb_bereinigt_2025-10-07.rds")

# Überprüfen, ob das Laden erfolgreich war
str(workshopfb)

# Anschauen der ersten Zeilen
head(workshopfb)

# ggplot2 laden, muss unter Umständen noch installiert werden, siehe prompt von RStudio
library(ggplot2)

# Daten für ggplot angeben, erstmal leere Fläche da aes und geom noch fehlen
ggplot(workshopfb)

# Erste Ästhetik (x-Achse) festlegen
ggplot(workshopfb, aes(x = auge))

# Ausprägungen der Variable
unique(workshopfb$auge)

# Augenfarbe in einen Factor mit Labels überführen
library(dplyr)
workshopfb <- workshopfb %>%
  mutate(
    auge = na_if(auge, -9) # Ersetzt alle -9 durch NA in der Spalte 'auge'
  )
workshopfb$augefac<- factor(workshopfb$auge, 
                                    levels = c(1, 2, 3, 4),
                                    labels = c('Braun', 'Blau', 'Grün', 'Sonstige'))

# Labels ausgeben lassen
levels(workshopfb$augefac)

# Erste Ästhetik (x-Achse) festlegen
ggplot(workshopfb, aes(x = augefac))

ggplot(
  data = workshopfb %>% filter(!is.na(augefac)), 
  aes(x = augefac)
)

ggplot(data = workshopfb %>% filter(!is.na(augefac)), aes(x = augefac)) +
  geom_bar()

# Speichert eine Grundlagenschicht in ggplot, basierend auf data und aes, diese gilt als Basis für die danach erstellten Grafiken
basic <- ggplot(data = workshopfb %>% filter(!is.na(augefac)), aes(x = augefac))

# Grundschema wird zusammen mit der Geometrie "Balken" aufgerufen
basic + geom_bar()

# Balken einfärben
ggplot(data = workshopfb %>% filter(!is.na(augefac)), aes(x = augefac)) +
  geom_bar(fill = 'blue', color = 'grey40')

# Farbverlauf durch Werte von x über aes
ggplot(data = workshopfb %>% filter(!is.na(augefac)), aes(x = augefac)) +
  geom_bar(aes(fill = augefac), color = 'grey40')


table(workshopfb$spick)

ggplot(data = workshopfb %>% filter(!is.na(augefac) & !is.na(spick_fac)), aes(x = augefac, group = spick_fac)) +
  geom_bar(aes(fill = spick_fac), color = 'grey40')

ggplot(data = workshopfb %>% filter(!is.na(augefac) & !is.na(spick_fac)), aes(x = augefac, group = spick_fac)) +
  geom_bar(aes(fill = spick_fac), color = 'grey40', position = 'dodge')

# Speichern des Grundmodells des scatter-plots, um es danach mit versch. Themes darzustellen
bars <- ggplot(data = workshopfb %>% filter(!is.na(augefac) & !is.na(spick_fac)), aes(x = augefac, group = spick_fac)) +
  geom_bar(aes(fill = spick_fac), color = 'grey40', position = 'dodge')

# Minimal theme
bars + theme_minimal()

# # Package für weitere ggplot-themes, kann man durch auskommentieren installieren
# install.packages('ggthemes')
# library(ggthemes)



# maximal Data, minimal Ink - Theme
bars + theme_tufte()

# Beispielhaft minimal als default-theme setzen
theme_set(theme_minimal())

# # Hiermit kann man zurück zum ursprünglichen R-Theme da R-Grundeinstellungen ersetzt werden
# theme_set(theme_grey())

# Einfügen von Beschriftungen für die einzelnen Bestandteile und Achsen
ggplot(data = workshopfb %>% filter(!is.na(augefac) & !is.na(spick_fac)), aes(x = augefac, group = spick_fac)) +
  geom_bar(aes(fill = spick_fac), color = 'grey40', position = 'dodge') +
  labs(x = 'Augenfarbe',
    y = 'Anzahl',
    fill = 'Ehrlichkeit') +
  ggtitle('Ehrlichkeit nach Augenfarbe', 'in absoluten Zahlen')


bars <- ggplot(
  data = workshopfb %>% filter(!is.na(augefac) & !is.na(spick_fac)), 
  aes(x = augefac, fill = spick_fac),
  geom_bar(position = 'dodge', color = 'grey40') +
  labs(x = 'Augenfarbe',
     y = 'Anzahl',
     fill = 'Ehrlichkeit')) +
  ggtitle('Ehrlichkeit nach Augenfarbe', 'in absoluten Zahlen')
  

# Abbildung in Objekt ablegen
ggplot(data = workshopfb %>% filter(!is.na(augefac) & !is.na(spick_fac)), aes(x = augefac, group = spick_fac)) +
  geom_bar(aes(fill = spick), color = 'grey40', position = 'dodge') +
  # Anpassung der Y-Achse (Count/Anzahl)
  scale_y_continuous(name = 'Anzahl der Teilnehmenden', # Neuer Achsentitel
                     limits = c(0, 30),                 # Beispiel-Limit festlegen
                     breaks = seq(0, 30, 5)            # Breaks in 10er-Schritten
                     ) + 
  # Anpassung der X-Achse (Augenfarbe)
  scale_x_discrete(name = 'Selbstberichtete Augenfarbe', # Neuer Achsentitel
                   # Hier könnten Sie z.B. die Labels der Kategorien überschreiben
                   # oder die Reihenfolge mit 'limits' festlegen.
                   # Wir lassen es hier einfach, da die Labels bereits gut sind.
                   ) + 
  ggtitle('Ehrlichkeit beim Spicken', 'verteilt nach Augenfarbe')

# Abbildung in Objekt ablegen
ggplot(data = workshopfb %>% filter(!is.na(augefac) & !is.na(spick_fac)), aes(x = augefac, group = spick_fac)) +
  # Wichtig: fill = MUSS den Factor (spick_fac) verwenden
  geom_bar(aes(fill = spick_fac), color = 'grey40', position = 'dodge') +
  
  # Anpassung der Y-Achse (Count/Anzahl)
  scale_y_continuous(name = 'Anzahl der Teilnehmenden', # Neuer Achsentitel
                     limits = c(0, 30),                 # Beispiel-Limit festlegen
                     breaks = seq(0, 30, 5)             # Breaks in 5er-Schritten
                     ) + 
  
  # Anpassung der X-Achse (Augenfarbe)
  scale_x_discrete(name = 'Selbstberichtete Augenfarbe'
                     ) + 
  
  # GRAU-STUFEN HINZUFÜGEN
  scale_fill_grey() + 
  
  ggtitle('Ehrlichkeit beim Spicken', 'verteilt nach Augenfarbe')

# Definieren einer custom Farbpalette basierend auf der Corporate Goethe Universität Palette
gu_colors <- c('#00618f', '#e3ba0f', '#ad3b76', '#737c45', '#c96215')

# Abbildung in Objekt ablegen
ggplot(
  data = workshopfb %>% filter(!is.na(augefac) & !is.na(entscheidung)), # <-- Fehler 1 behoben: Klammer für filter() geschlossen
  aes(x = augefac, group = entscheidung) # <-- Fehler 1 behoben: aes() ist jetzt ein separates Argument
) +
  # color und position stehen außerhalb von aes()
  geom_bar(aes(fill = entscheidung), color = 'grey40', position = 'dodge') + # <-- Fehler 2 behoben: Klammer für geom_bar() erst hier geschlossen
  
  # Anpassung der Y-Achse (Count/Anzahl)
  scale_y_continuous(name = 'Anzahl der Teilnehmenden', # Neuer Achsentitel
                     limits = c(0, 15),                 # Beispiel-Limit festlegen
                     breaks = seq(0, 15, 3)             # Breaks in 3er-Schritten
                     ) + 
  
  # Anpassung der X-Achse (Augenfarbe)
  scale_x_discrete(name = 'Selbstberichtete Augenfarbe'
                     ) + 
  
  # Goethe Farben HINZUFÜGEN
  scale_fill_manual(values = gu_colors) + # <-- Fehlendes '+' am Ende der Skala hinzugefügt
  
  ggtitle('Entscheidungsmodus', 'verteilt nach Augenfarbe')

ggplot(
  data = workshopfb %>% filter(!is.na(intoleranz_fac) & !is.na(mach)),
  aes(x = intoleranz_fac, y = mach)
) +
  geom_boxplot() +
  theme_minimal() +
  labs(
    x = 'Lebensmittelintoleranz',
    y = 'Machiavellismus' 
  )

ggplot(
  # Filtern Sie nur NA-Werte im Mach-Score selbst
  data = workshopfb %>% filter(!is.na(mach)),
  
  # x = Kontinuierliche Variable (Mach-Score)
  aes(x = mach)
) +
  geom_histogram(fill = "darkblue", color = "white", binwidth = 1) + 
  theme_minimal() +
  
  # Anpassung der Achsenbeschriftungen und Skalen
  scale_x_continuous(name = 'Machiavellismus-Score (Kontinuierlich)',
                     limits = c(0,100),
                     breaks = seq(0,100,10)
                    
                     ) + 
  scale_y_continuous(name = 'Anzahl der Teilnehmenden') + 
  
  labs(title = 'Verteilung des Machiavellismus-Scores')

ggplot(
  data = workshopfb %>% filter(!is.na(mach)),
  aes(x = mach)
  ) +
  geom_density() +
  theme_minimal() +
  labs(x = 'Selbsteingeschätzter Machiavellismus (0-100)')

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
