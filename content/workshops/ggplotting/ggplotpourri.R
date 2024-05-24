library(ggplot2)
load(url('https://pandar.netlify.app/daten/edu_exp.rda'))
library(maps)
source('./ggplotting-theme-source.R')
library(knitr)
library(ggplot2)
library(magick)
library(cowplot)

# Pakete laden
library(ggplot2)

# Datensatz erstellen
df <- data.frame(software = factor(x = c("R", "MS Excel", "Python", "Stata"),
                                   levels = c("R", "MS Excel", "Python", "Stata")),
                 count = c(5,1,1,1))

# Einfaches Balkendiagramm
ggplot(df, aes(x=software, y=count)) +
  geom_col() 

library(magick)
library(cowplot)

# Software-Logos herunterladen und einlesen (Funktion aus dem Paket magick)
r <- image_read("https://www.r-project.org/logo/Rlogo.svg")
excel <- image_read("https://upload.wikimedia.org/wikipedia/commons/8/8d/Microsoft_Excel_Logo_%282013-2019%29.svg")
python <- image_read("https://upload.wikimedia.org/wikipedia/commons/f/f8/Python_logo_and_wordmark.svg")
stata <- image_read("https://upload.wikimedia.org/wikipedia/commons/5/5c/Stata_Logo.svg")

# ggplot-Befehl zur Erstellung der "nackten" Grafik 
ggplot(df, aes(x=software, y=count)) +
  geom_col() +
  theme_void() +
  labs(x="", y="") +
  theme(plot.margin = unit(c(3,0,0,0), "cm"),
        axis.text.y = element_blank(),
        axis.line.y = element_blank(),
        axis.ticks.y = element_blank()) -> plot

# Positionieren der Bilddateien auf den Balken (Paket cowplot)
ggdraw(plot) +
  draw_image(r, x = .13, y = .86, scale = .2, hjust = .5, vjust = .5) +
  draw_image(excel, x = .38, y = .26, scale = .14, hjust = .5, vjust = .5) +
  draw_image(python, x = .62, y = .26, scale = .18, hjust = .5, vjust = .5) +
  draw_image(stata, x = .86, y = .26, scale = .12, hjust = .5, vjust = .5) +
  scale_fill_manual(values = c(rgb(102,153,204, max=255), "grey", "grey", "grey")) +
  draw_plot(plot)

# original-Datensatz mit relevanten Variablen: wide
edu_exp |>
  subset(edu_exp$Country == "Germany" & edu_exp$Year == 2016,
         select = c("Country", "Year", "Primary", "Secondary", "Tertiary")) 

# Umstrukturierung in die long-Form 
edu_exp_long <- edu_exp |>
  subset(edu_exp$Country == "Germany" & edu_exp$Year == 2016, 
         select = c("Country", "Year", "Primary", "Secondary", "Tertiary")) |>
  reshape(direction = "long",
          varying = c("Primary", "Secondary", "Tertiary"),
          times  = c("Primary", "Secondary", "Tertiary"),
          v.name = "value",
          timevar = "exp") 
edu_exp_long

edu_exp_long |>
  ggplot(aes(x=exp, y=value)) +
  geom_bar(stat = "identity", fill = rgb(102, 153, 204, max=255)) +
  labs(x = "Educational level",
       y = "Expenditure", 
       title ="Expenditures in Education in Germany (2016)",
       subtitle = "Expenditure per student (% of GDP/Population)") +
  theme_classic()

library(ggthemes)

edu_exp |>
  subset(edu_exp$Year == 2016) |>
  ggplot(aes(x = Income)) +
  geom_histogram() +
  labs(x = "GPD per Person",
       y = "", 
       title ="Distribution of income across countries",
       caption = "Source: gapminder") +
  theme_economist() +
  theme(plot.margin = unit(c(0.5,1,0.5,0.5), "cm"))

library(ggthemes)

edu_exp |>
  subset(edu_exp$Year == 2016) |>
  ggplot(aes(x = Region, y = Income)) +
  geom_boxplot() +
  labs(x = "GPD per Person",
       y = "", 
       title ="Distribution of income across countries in 2016",
       caption = "Source: gapminder") +
  scale_x_discrete(labels = c("Africa", "Americas", "Asia", "Europe")) + 
  theme_fivethirtyeight()

library(ggthemes)

edu_exp |>
  subset(edu_exp$Year == 2016) |>
  ggplot(aes(x = Region, y = Income)) +
  geom_violin(aes(fill = Region), width = 1.5, show.legend = FALSE) +
  # geom_jitter(width = .1, height = 0, col = "grey") +
  geom_boxplot(width = .1, fill = "transparent", outlier.shape = NA) +
  labs(x = "GPD per Person",
       y = "", 
       title ="Distribution of income across countries in 2016",
       caption = "Source: gapminder") +
  scale_x_discrete(labels = c("Africa", "Americas", "Asia", "Europe")) + 
  theme_fivethirtyeight()

library(ggthemes)
library(ggridges)

edu_exp |>
  subset(edu_exp$Year == 2016) |>
  ggplot(aes(x = Income, y = Region)) +
  geom_density_ridges(aes(fill = Region), alpha=.8, show.legend = FALSE) +
  scale_y_discrete(labels = c("Africa", "Americas", "Asia", "Europe")) + 
  labs(x = "GPD per Person",
       y = "", 
       title ="Distribution of income across countries in 2016",
       caption = "Source: gapminder") +
  scale_x_discrete(labels = c("Africa", "Americas", "Asia", "Europe")) + 
  theme_tufte()

edu_exp$Total <- subset(edu_exp, select = c('Primary', 'Secondary', 'Tertiary')) |>
  rowSums()
tmp <- edu_exp[, c('Primary', 'Secondary', 'Tertiary')] / edu_exp$Total
names(tmp) <- c('PrimaryProp', 'SecondaryProp', 'TertiaryProp')
edu_exp <- cbind(edu_exp, tmp)

prop_long <- subset(edu_exp, Year == 2013 & !is.na(Total), 
  select = c('Country', 'Year',  
    'PrimaryProp', 'SecondaryProp', 'TertiaryProp')) |>
  reshape(direction = 'long',
    varying = c('PrimaryProp', 'SecondaryProp', 'TertiaryProp'),
    v.names = 'Proportion',
    timevar = 'Type',
    times = c('Primary', 'Secondary', 'Tertiary'))

spain <- subset(prop_long, Country == 'Spain')
spain$Max <- cumsum(spain$Proportion)
spain$Min <- c(0, head(spain$Max, n = -1))

spain

bar <- ggplot(spain, 
  aes(ymin = Min, ymax = Max, 
    xmin = 2, xmax = 3,
    fill = Type)) +
  geom_rect(color = 'white') +
  theme_void() + scale_fill_pandar()
bar

pie <- bar + coord_polar("y")
pie

spain$Position <- (spain$Max + spain$Min) / 2
spain$Percent <- paste0(round(spain$Proportion * 100, 1), '%')

pie <- pie +
  geom_text(data = spain, x = 2.5,
    aes(y = Position, label = Percent), 
      color = 'white', size = 5) +
  labs(fill = 'Education Type') + 
  ggtitle('Proportional Education Spending', 'Spain, 2013')
pie

pie + xlim(c(1, 3))

edu_exp |>
  subset(Year == 2015) |> 
  ggplot(aes(x=Income, y=Expectancy)) +
  geom_point() 

# Datensatz sortieren
edu_exp <- edu_exp[order(edu_exp$Population, decreasing = T),]

# Farben der vier Weltregionen 
tuerkis <- rgb(0,213,233, max=255)
gruen <- rgb(127,235,0, max=255)
rot <- rgb(255,88,114, max=255)
gelb <- rgb(255,231,0, max=255)

edu_exp |>
  # Auswahl der Daten von 2015:
  subset(Year == 2015) |> 
  # Grund-Grafik anfordern:
  ggplot(aes(x=Income, y=Expectancy)) +
  # Neu: Text für die Jahreszahl ("2015") einfügen, sodass diese ganz im Hintergrund steht
  annotate("text", x=8000, y=50, label="2015", size=50, colour ="grey90", family="courier new", fontface=2) +
  # Neu: Farbthema: heller Hintergrund, schwarze Linien an x- und y-Achse
  theme_classic() + 
  # Wie bisher: Punkte einzeichnen --> Streu-Punkt-Diagramm,
  # Neu: Unterscheidung der Punkte nach Farbe (Region) und Größe (Population);  
  # Transparenz der Datenpunkte (alpha), Rand um die Punkte (shape) 
  geom_point(aes(fill = Region, size = Population), shape=21, alpha=.7, show.legend=F) +
  # Skalieren der Größe der Punkte, sodass die Unterschiede deutlicher sind
  scale_size(range = c(1, 30)) +
  # Neu: Beschriftung der Achsen
  labs(x="Income", y="Life expectancy") +
  # Neu: Beschriftung an den Innenseiten der Achsen
  annotate("text", x=125000, y=11, label="per Person (GDP/capita, PPP$ inflation-adjusted)", hjust = 1, vjust = 1) +
  annotate("text", x=410, y=90, label="years", hjust = 1, vjust = -2, angle=90) +
  # Neu: manuelle Spezifikation der y-Achse: Wertebereich, Position der Beschriftungen (10er-Schritte)
  scale_y_continuous(limits = c(10, 92), 
                     breaks = seq(10,92, by=10)) +
  # Neu: manuelle Spezifikation der x-Achse: Wertebereich, log-Transformation, Position und Name der Beschriftungen
  scale_x_continuous(limits = c(400,128000),
                     trans = "log2", 
                     breaks = c(500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000),
                     labels = c("500", "1000", "2000", "4000", "8000", "16k", "32k", "64k", "128k")) +
  # Neu: manuelle Spezifikation der Farben
  scale_fill_manual(
    values = c(tuerkis, gruen, rot, gelb),
    breaks = c("africa", "americas", "asia", "europe")) +
  # Neu: Theme (Anpassung der Schriftgroesse, relativ zur Groesse 12, blaues Raster im Hintergrund, Rand für die Legende)
  theme(text = element_text(size=12),
        axis.text = element_text(size=rel(.8)),
        axis.title = element_text(size=rel(1.2)),
        panel.grid.major = element_line(colour = "azure2"),
        plot.margin = margin(1, 6, 1, 1, "cm")) -> plot_ohne_Legende

plot_ohne_Legende

library(magick)
library(cowplot)

# Weltkarte (Screenshot von der gapminder Webseite)
weltkarte <- image_read("ggplotting-gapminder-map.png")

ggdraw(plot_ohne_Legende) +
  draw_image(weltkarte, x = 1, y = .95, hjust = 1, vjust = 1, halign = 1, valign = 1, width = .2)

edu_exp |>
  ggplot(aes(x=Income, y=Expectancy)) +
  theme_classic() + 
  geom_point(aes(fill = Region, size = Population), shape=21, alpha=.7, show.legend=F) +
  scale_size(range = c(1, 30)) +
  labs(x="Income", y="Life expectancy") +
  annotate("text", x=125000, y=11, label="per Person (GDP/capita, PPP$ inflation-adjusted)", hjust = 1, vjust = 1) +
  annotate("text", x=410, y=90, label="years", hjust = 1, vjust = -2, angle=90) +
  scale_y_continuous(limits = c(10, 92), 
                     breaks = seq(10,92, by=10)) +
  scale_x_continuous(limits = c(400,128000),
                     trans = "log2", 
                     breaks = c(500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000),
                     labels = c("500", "1000", "2000", "4000", "8000", "16k", "32k", "64k", "128k")) +
  scale_fill_manual(
    values = c(tuerkis, gruen, rot, gelb),
    breaks = c("africa", "americas", "asia", "europe")) +
  theme(text = element_text(size=12),
        axis.text = element_text(size=rel(.8)),
        axis.title = element_text(size=rel(1.2)),
        panel.grid.major = element_line(colour = "azure2")) -> plot_ohne_Legende

## library(gganimate)
## 
## anim <- plot_ohne_Legende +
##   transition_time(Year) +
##   labs(title = "{frame_time}") +
##   theme(plot.title = element_text(hjust=.5))
## 
## animate(anim, start_pause = 20, end_pause = 20,
##         height = 15, width = 30, units = "cm", res = 300)

welt <- map_data('world')
head(welt)

ggplot(welt, aes(x = long, y = lat, group = group)) +
  geom_polygon()

ggplot(welt, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = 'white', color = 'black', lwd = .25) +
  theme_void()

setdiff(unique(welt$region), unique(edu_exp$Country))
setdiff(unique(edu_exp$Country), unique(welt$region))

edu_exp[grepl('Cote', edu_exp$Country), 'Country'] <- 'Ivory Coast'

# Recodes
edu_exp$Country <- car::recode(edu_exp$Country,
  "'Antigua and Barbuda' = 'Antigua';
  'Congo, Rep.' = 'Republic of Congo';
  'Congo, Dem. Rep.' = 'Democratic Republic of the Congo';
  'Micronesia, Fed. Sts.' = 'Micronesia';
  'United Kingdom' = 'UK';
  'Holy See' = 'Vatican';
  'Kyrgyz Republic' = 'Kyrgyzstan'; 
  'St. Kitts and Nevis' = 'Saint Kitts';
  'Lao' = 'Laos';
  'St. Lucia' = 'Saint Lucia';
  'North Macedonia' = 'Macedonia';
  'Slovak Republic' = 'Slovakia';
  'Eswatini' = 'Swaziland';
  'Trinidad and Tobago' = 'Trinidad';
  'United States' = 'USA';
  'Saint Vincent and the Grenadines' = 'Saint Vincent'")

edu_2017 <- subset(edu_exp, Year == 2017)

edu_map <- merge(welt, edu_2017, 
  by.x = 'region', by.y = 'Country', 
  all.x = TRUE, all.y = FALSE)
edu_map <- edu_map[order(edu_map$group, edu_map$order), ]

ggplot(edu_map, aes(x = long, y = lat, group = group)) +
geom_polygon(color = 'black', lwd = .25, 
  aes(fill = Index)) + 
  theme_void() + 
  scale_fill_pandar(discrete = FALSE, na.value = 'grey95')

library(rvest)

# Funktion zum Einlesen der Texte von Websites
make.text <- function(website){
  read_html(website) |> 
    html_nodes("p") |>
    html_text() |>
    paste(collapse = "")
}

# Anwenden der Funktion auf die relevanten pandaR-Seiten:
texte <- paste(
  make.text('https://pandar.netlify.app/lehre/statistik-ii/grafiken-ggplot2'),
  collapse = "")

library(tm)

# Erstellen der Wort-Häufigkeitstabelle
docs <- Corpus(VectorSource(texte))
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, '[/@\\|\\"]')
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords, stopwords("german"))
docs <- tm_map(docs, removeWords, c("dass"))
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, stripWhitespace)
tdm  <- as.matrix(TermDocumentMatrix(docs))
vec <- sort(rowSums(tdm), decreasing=TRUE)
table <- data.frame(word = names(vec), freq = vec)

head(table)

# Erstellen der wordcloud
library(ggwordcloud)

table$angle <- 90 * sample(c(0, 1), nrow(table), replace = TRUE, prob = c(60, 40))
ggplot(table[1:50,],) +
  geom_text_wordcloud(aes(label = word, size = freq,
                          color = factor(sample.int(10, 50, replace = TRUE)),
                          angle = angle)) +
  scale_size(range = c(1, 20)) +
  theme(panel.background = element_rect(fill = "grey90"))
