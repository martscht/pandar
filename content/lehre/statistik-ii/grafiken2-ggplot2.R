# ggplot laden
library(ggplot2)

# Daten laden
load(url('https://pandar.netlify.app/daten/edu_exp.rda'))

# Datenaufbereitung
edu_exp$Wealth <- factor(edu_exp$Wealth, levels = c('low_income', 'lower_middle_income', 'upper_middle_income', 'high_income'),
  labels = c('Low', 'Lower Mid', 'Upper Mid', 'High'))
edu_exp$Region <- factor(edu_exp$Region, levels = c('africa', 'americas', 'asia', 'europe'),
  labels = c('Africa', 'Americas', 'Asia', 'Europe'))

# # Laden des pandaR Themes
# source('https://pandar.netlify.com/lehre/statistik-ii/pandar_theme.R')


theme_set(theme_pandar())

# Daten reduktion
edu_2014 <- subset(edu_exp, Year == 2014)

# Deskriptivstatistik 
psych::describe(edu_2014[, c('Primary', 'Index')])

# Daten reduktion
edu_2014 <- subset(edu_2014, !is.na(Primary) & !is.na(Index))

# Einfacher Scatterplot
ggplot(edu_2014, aes(x = Primary, y = Index)) +
  geom_point()

# Scatterplot mit nominaler Farbästhetik
ggplot(edu_2014, aes(x = Primary, y = Index)) +
  geom_point(aes(color = Region)) +
  scale_color_pandar()

# Reskalierung Bevölkerungszahl
edu_2014$Population <- edu_2014$Population / 1e6

# # Scatterplot mit nominaler Farbästhetik und intervallskalierter Punktgröße
# ggplot(edu_2014, aes(x = Primary, y = Index)) +
#   geom_point(aes(color = Region, size = Population)) +
#   scale_color_pandar()

# Anpassung der Benennung einer Ästhetik
ggplot(edu_2014, aes(x = Primary, y = Index)) +
  geom_point(aes(color = Region, size = Population)) +
  scale_color_pandar() + scale_size_continuous(name = 'Population\n(in Mio)')

# Datensatz mit mehreren Jahren
edu_sel <- subset(edu_exp,  Year %in% c(1999, 2004, 2009, 2014))
edu_sel$Year <- as.factor(edu_sel$Year)

# Datenreduktion auf Zeilen, bei denen sowohl Primary als auch Index vorhanden sind
edu_sel <- subset(edu_sel, !is.na(Primary) & !is.na(Index))

# Population reskalieren
edu_sel$Population <- edu_sel$Population / 1e6

# Beispiel einer etwas chaotischen Darstellung all dieser Jahresdaten zur selben Zeit
ggplot(edu_sel, aes(x = Primary, y = Index)) +
  geom_point(aes(color = Region, size = Population, pch = Year)) + 
  scale_color_pandar() + scale_size_continuous(name = 'Population\n(in Mio)')

# Übersichtlichkeit durch faceting, trennt in einzelne Abbildungen nach Jahr
ggplot(edu_sel, aes(x = Primary, y = Index)) +
  geom_point(aes(color = Region, size = Population)) + 
  scale_color_pandar() + scale_size_continuous(name = 'Population\n(in Mio)') +
  facet_wrap(~ Year)

# Scatterplot in Objekt ablegen (für plotly)
static <- ggplot(edu_2014, aes(x = Primary, y = Index)) +
  geom_point(aes(color = Region, size = Population)) +
  scale_color_pandar() + scale_size_continuous(name = 'Population\n(in Mio)')

# install.packages('plotly')

library(plotly)

# ggplotly(static)

# Statischen Scatterplot für Plotly überarbeiten
static <- ggplot(edu_2014, aes(x = Primary, y = Index)) +
  geom_point(aes(color = Region, size = Population)) +
  scale_color_pandar() + guides(size = 'none')

# ggplotly(static,
#   tooltip = c('colour', 'size', 'x', 'y'))

# Beispiellabel erzeugen
tmp <- subset(edu_2014, Country == 'Spain')  
cat(paste(tmp$Country, '\nRegion:', tmp$Region, '\nPopulation (in mio):', round(tmp$Population, 2)))



# Statischen Plot erzeugen
static <- ggplot(edu_2014, aes(x = Primary, y = Index,
    text = paste(Country, 
  '</br></br>Region:', Region, 
  '</br>Population (in mio):', round(Population, 2)))) +
  geom_point(aes(color = Region, size = Population)) +
  scale_color_pandar() + guides(size = 'none')

# ggplotly(static,
#   tooltip = 'text')
