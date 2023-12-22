## load(url('https://pandar.netlify.com/post/edu_exp.rda'))

load('../../daten/edu_exp.rda')

library(ggplot2)

edu_2013 <- subset(edu_exp, Year == 2013)

ggplot(edu_2013, aes(x = Primary, y = Index, color = Wealth)) + 
  geom_point()

unique(edu_2013$Wealth)

edu_2013$Wealth <- factor(edu_2013$Wealth,
  levels = c('high_income', 'upper_middle_income', 'lower_middle_income', 'low_income'),
  labels = c('High', 'Upper Mid.', 'Lower Mid.', 'Low'))

ggplot(edu_2013, aes(x = Primary, y = Index, color = Wealth)) + 
  geom_point()

subset(edu_2013, !is.na(Wealth)) |>
  ggplot(aes(x = Primary, y = Index, color = Wealth)) + 
    geom_point()

scatter <- ggplot(edu_2013, aes(x = Primary, y = Index, color = Wealth)) +
  geom_point() +
  labs(x = 'Spending on Primary Eduction',
    y = 'UNDP Education Index',
    color = 'Country Wealth\n(GDP per Capita)') +
  ggtitle('Impact of Primary Education Investments', '(Data for 2013)')

scatter

scatter + theme_minimal()

## install.packages('ggthemes')
## library(ggthemes)

library(ggthemes)

scatter + theme_tufte()

scatter + theme_fivethirtyeight()

theme_set(theme_minimal())

## theme_set(theme_grey())

args(element_text)

scatter + 
  theme(plot.title = element_text(size = 18, hjust = .5))

scatter + 
  theme(plot.title = element_text(size = 18, hjust = .5),
    plot.subtitle = element_text(hjust = .5))

scatter + 
  theme(plot.title = element_text(size = 18, hjust = .5),
    plot.subtitle = element_text(hjust = .5),
    axis.line = element_line(color = 'black'))

theme_update(plot.title = element_text(size = 18, hjust = .5),
    plot.subtitle = element_text(hjust = .5),
    axis.line = element_line(color = 'black'))

scatter

theme_pandar <- function() {
  theme_minimal() %+replace%
    theme(plot.title = element_text(size = 18, hjust = .5),
      plot.subtitle = element_text(hjust = .5),
      axis.line = element_line(color = 'black'))
}

scatter + theme_grey()

scatter + theme_pandar()

theme_set(theme_pandar())

ggplot(edu_2013, aes(x = Primary, y = Index, color = log(Income))) +
  geom_point() 

scatter + scale_color_grey()

pandar_colors <- c('#00618f',  '#737c45', '#e3ba0f', '#ad3b76')

scatter + 
  scale_color_manual(values = pandar_colors)

scale_color_pandar <- function(discrete = TRUE, ...) {
  pal <- colorRampPalette(pandar_colors)
  if (discrete) {
    discrete_scale('color', 'pandar_colors', palette = pal, ...)
  } else {
    scale_color_gradientn(colors = pal(4), ...)
  }
}

scatter + scale_color_pandar()

edu_2013$Wealth_bin <- edu_2013$Wealth
levels(edu_2013$Wealth_bin) <- list('High' = c('High', 'Upper Mid.'), 
  'Low' = c('Lower Mid.', 'Low'))

ggplot(edu_2013, aes(x = Primary, y = Index, color = Wealth_bin)) +
  geom_point() +
  scale_color_pandar()

ggplot(edu_2013, aes(x = Primary, y = Index, color = log(Income))) +
  geom_point() +
  scale_color_pandar(discrete = FALSE)
