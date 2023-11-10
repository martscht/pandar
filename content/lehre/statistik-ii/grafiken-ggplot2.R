# Hier kann der Fragebogen geladen werden, muss auskommentiert werden!

load(url('https://pandar.netlify.com/daten/edu_exp.rda'))

#### Variablenerklärung ----

# - `geo`: Länderkürzel, das zur Identifikation der Länder über verschiedene Datenquellen hinweg genutzt wird
# - `Country`: der Ländername im Englischen
# - `Wealth`: Wohlstandseinschätzung des Landes, unterteilt in fünf Gruppen 
# - `Region`: Einteilung der Länder in die vier groben Regionen `africa`, `americas`, `asia` und `europe`
# - `Year`: Jahreszahl
# - `Population`: Bevölkerung
# - `Expectancy`: Lebenserwartung eines Neugeborenen, sollten die Lebensumstände stabil bleiben.
# - `Income`: Stetiger Wohlstandsindikator für das Land (GDP pro Person)
# - `Primary`: Staatliche Ausgaben pro Schüler:in in der primären Bildung als Prozent des `income` (GDP pro Person)
# - `Secondary`: Staatliche Ausgaben pro Schüler:in in der sekundären Bildung als Prozent des `income` (GDP pro Person)
# - `Tertiary`: Staatliche Ausgaben pro Schüler:in oder Student:in in der tertiären Bildung als Prozent des `income` (GDP pro Person)
# - `Index`: Education Index des United Nations Development Programme

# Anschauen der ersten Zeilen
head(edu_exp)

# ggplot2 laden, muss unter Umständen noch installiert werden, siehe prompt von RStudio
library(ggplot2)

# Nur die Daten des Jahr 2013 in Subset anlegen
edu_2013 <- subset(edu_exp, Year == 2013)

# Daten für ggplot angeben, erstmal leere Fläche da aes und geom noch fehlen
ggplot(edu_2013)

#Aes wird hier mit einer IV/DV angeben für einen Scatter-Plot, Plot steht schon, aber Daten fehlen, da geom fehlt
ggplot(edu_2013, aes(x = Primary, y = Index))

#Nun wird der fertige Scatter Plot zwischen Grundschulbildung und Education Index dargestellt
ggplot(edu_2013, aes(x = Primary, y = Index)) +
  geom_point()

#Da Plot einen positiv linearen Zusammenhang vermuten lässt, wird nun die Korrelation getestet
cor.test(edu_2013$Index, edu_2013$Primary)

#Speichert eine Grundlagenschicht in ggplot, basierend auf data und aes, diese gilt als Basis für die danach erstellten Grafiken
basic <- ggplot(edu_2013, aes(x = Primary, y = Index))

#Grundschema wird zusammen mit Punkten für Datenpunkte aufgerufen
basic + geom_point()

#Es wird dargestellt, dass die geometrischen Formen der Datenpunkte gefärbt werden können, hier blau; Zeigt das Farbe nicht exklusiv bei aes geändert wird
ggplot(edu_2013, aes(x = Primary, y = Index)) +
  geom_point(color = 'blue')

#Farbverlauf durch Werte von x über aes
ggplot(edu_2013, aes(x = Primary, y = Index)) +
  geom_point(aes(color = Primary))

#Tabelle der vier "Kontinent", die sich im Datensatz befinden, Amerikas zusammengefasst, kein Australien
table(edu_2013$Region)

#Scatterplot mit Kontinenten als IV
ggplot(edu_2013, aes(x = Primary, y = Index)) +
  geom_point(aes(color = Region))

## #Verschiebt Farbgruppierung in allgemeinen Plot, damit diese an sich auf alle Geometrie-Elemente angewandt werden würde, wird nicht ausgewertet!
## ggplot(edu_2013, aes(x = Primary, y = Index, color = Region)) +
##   geom_point()

#Datensatz mit mehreren Jahren
edu_sel <- subset(edu_exp,  Year %in% c(1998, 2003, 2008, 2013))
edu_sel$Year <- as.factor(edu_sel$Year)

#Beispiel einer etwas chaotischen Darstellung all dieser Jahresdaten zur selben Zeit
ggplot(edu_sel, aes(x = Primary, y = Index, 
  color = Region, pch = Year)) +
  geom_point()

#Übersichtlichkeit durch faceting, trennt in einzelne Abbildungn nach Jahreszeit
ggplot(edu_sel, aes(x = Primary, y = Index, 
  color = Region)) +
  geom_point() +
  facet_wrap(~ Year)

#Speichern des Grundmodells des scatter-plots, um es danach mit versch. Themes darzustellen
scatter <- ggplot(edu_2013, aes(x = Primary, y = Index, color = Region)) +
  geom_point()

#Minimal theme
scatter + theme_minimal()

## #Pacakge für weitere ggplot-themes, kann man durch auskommentieren installieren
## install.packages('ggthemes')
## library(ggthemes)



#maximal Data, minimal Ink - Theme
scatter + theme_tufte()

#Komplexeres Theme basierend auf Prinzipien von Nate Silvers Website https://fivethirtyeight.com/
scatter + theme_fivethirtyeight()

#Beispielhaft minimal als default-theme setzen
theme_set(theme_minimal())

## #Hiermit kann man zurück zum ursprünglichen R-Theme da R-Grundeinstellungen ersetzt werden
## theme_set(theme_grey())

#Einfügen von Beschriftungen für die einzelnen Bestandteile und Achsen
ggplot(edu_2013, aes(x = Primary, y = Index, color = Region)) +
  geom_point() +
  labs(x = 'Spending on Primary Eduction',
    y = 'UNDP Education Index',
    color = 'World Region') +
  ggtitle('Impact of Primary Education Investments', '(Data for 2013)')

#Ändert die Faktornamen der Regionen, damit diese am Anfang großgeschrieben sind
edu_2013$Region <- factor(edu_2013$Region, levels = c('africa', 'americas', 'asia', 'europe'),
  labels = c('Africa', 'Americas', 'Asia', 'Europe'))

#Erneute Abbildung nun da die Faktoren geändert sind, dieses Mal wird sie auch wieder als Objekt hinterlegt damit man sie erneut aufrufen kann
scatter <- ggplot(edu_2013, aes(x = Primary, y = Index, color = Region)) +
  geom_point() +
  labs(x = 'Spending on Primary Eduction',
    y = 'UNDP Education Index',
    color = 'World Region') +
  ggtitle('Impact of Primary Education Investments', '(Data for 2013)')

scatter

#Ändert Farbe zu Grautönen, für Druckfreundlichkeit
scatter + scale_color_grey()

# definiren einer custom Farbpalette basierend auf der Corporate Goethe Universität Palette
gu_colors <- c('#00618f', '#e3ba0f', '#ad3b76', '#737c45', '#c96215')

#Zuweisung der händisch erstellten Farbpalette zum Scatterplot
scatter + scale_color_manual(values = gu_colors)

#Generellen Trend der Datenlage über geom_smooth abbilden
scatter + geom_smooth()

#Globaler Trend, schattierte Fläche um Linie ist Standardschätzfehler,
ggplot(edu_2013, aes(x = Primary, y = Index)) +
  geom_point(aes(color = Region)) +
  geom_smooth() +
  labs(x = 'Spending on Primary Eduction',
    y = 'UNDP Education Index',
    color = 'World Region') +
  ggtitle('Impact of Primary Education Investments', '(Data for 2013)')

#Regression, regionsspezifisch, ohne Standardfehler
scatter + geom_smooth(method = 'lm', se = FALSE)
