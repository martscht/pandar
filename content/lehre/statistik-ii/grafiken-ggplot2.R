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

# Komplexeres Theme
bars + theme_excel()

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

# Ändert Farbe zu Grautönen, für Druckfreundlichkeit
bars + scale_fill_grey()

# Definiren einer custom Farbpalette basierend auf der Corporate Goethe Universität Palette
gu_colors <- c('#00618f', '#e3ba0f', '#ad3b76', '#737c45', '#c96215')

# Zuweisung der händisch erstellten Farbpalette zum Barplot
bars + scale_fill_manual(values = gu_colors)
