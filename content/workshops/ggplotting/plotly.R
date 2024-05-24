## install.packages('plotly')
library('plotly')

## load(url('https://pandar.netlify.com/daten/edu_exp.rda'))
load('../../daten/edu_exp.rda')

edu_exp$Wealth <- factor(edu_exp$Wealth,
  levels = c('high_income', 'upper_middle_income', 'lower_middle_income', 'low_income'),
  labels = c('High', 'Upper Mid.', 'Lower Mid.', 'Low'))
edu_exp$Region <- factor(edu_exp$Region,
  levels = c('europe', 'asia', 'americas', 'africa'),
  labels = c('Europe', 'Asia', 'Americas', 'Africa'))

## source('https://pandar.netlify.com/post/ggplotting-theme-source.R')
source('./ggplotting-theme-source.R')

scatter2013 <- subset(edu_exp, Year == 2013) |>
  ggplot(aes(x = Primary, y = Index, color = Wealth)) +
    geom_point() +
    labs(x = 'Investment on Primary Eduction',
    y = 'UNDP Education Index',
    color = 'Country Wealth\n(GDP per Capita)') +
    ggtitle('Impact of Primary Education Investments', subtitle = 'Data for 2013') +
    theme_pandar() + scale_color_pandar()
scatter2013

## ggplotly(scatter2013)

## ggplotly(scatter2013,
##   tooltip = c('colour', 'x', 'y'))

## scatter2013 <- scatter2013 +
##   geom_point(aes(text = '...'))

tmp <- subset(edu_exp, Year == 2013 & Country == 'Spain')  
cat(paste0(tmp$Country, '\nRegion: ', tmp$Region, '\nGDP/Capita: ', tmp$Income))

## paste0(Country,
##   '</br></br>Region: ', Region,
##   '</br>GDP/Capita: ', Income)

## paste0(Country,
##   '</br></br>Region: ', Region,
##   '</br>GDP/Capita: ', Income,
##   '</br>Investment/Student: ', round((Primary/100)*Income))

cat(paste0(tmp$Country, 
  '\nRegion: ', tmp$Region, 
  '\nGDP/Capita: ', tmp$Income, 
  '\nInvestment/Student: ', round((tmp$Primary/100)*tmp$Income)))

scatter2013 <- subset(edu_exp, Year == 2013) |>
  ggplot(aes(x = Primary, y = Index, color = Wealth,
    text = paste0(Country, 
      '</br></br>Region: ', Region, 
      '</br>GDP/Capita: ', Income, 
      '</br>Investment/Student: ', round((Primary/100)*Income)))) +
    geom_point() +
    labs(x = 'Investment on Primary Eduction',
    y = 'UNDP Education Index',
    color = 'Country Wealth\n(GDP per Capita)') +
    ggtitle('Impact of Primary Education Investments', 
      subtitle = 'Data for 2013') +
    theme_pandar() + scale_color_pandar()

## ggplotly(scatter2013,
##   tooltip = 'text')

scatter <- ggplot(edu_exp, aes(x = Primary, y = Index, color = Wealth,
  frame = Year, group = Country,
  text = paste0(Country, 
    '</br></br>Region: ', Region, 
    '</br>GDP/Capita: ', Income, 
    '</br>Investment/Student: ', round((Primary/100)*Income)))) +
  geom_point() +
  labs(x = 'Investment on Primary Eduction',
  y = 'UNDP Education Index',
  color = 'Country Wealth\n(GDP per Capita)') +
  ggtitle('Impact of Primary Education Investments') +
  theme_pandar() + scale_color_pandar()

args(animation_opts)

## ggplotly(scatter,
##   tooltip = 'text') |>
##   animation_opts(transition = 200)

cat("'layout' objects don't have these attributes: 'something.wrong'
Valid attributes include:
'font', 'title', 'uniformtext', 'autosize', 'width', 'height', 'margin',
'computed', 'paper_bgcolor', 'plot_bgcolor', 'separators', 'hidesources',
'showlegend', 'colorway', 'datarevision', 'uirevision', 'editrevision', 
'selectionrevision', 'template', 'modebar', 'newshape', 'activeshape',
'meta', 'transition', '_deprecated', 'clickmode', 'dragmode', 'hovermode',
'hoverdistance', 'spikedistance', 'hoverlabel', 'selectdirection', 'grid',
'calendar', 'xaxis', 'yaxis', 'ternary', 'scene', 'geo', 'mapbox', 'polar',
'radialaxis', 'angularaxis', 'direction', 'orientation', 'editType',
'legend', 'annotations', 'shapes', 'images', 'updatemenus', 'sliders',
'colorscale', 'coloraxis', 'metasrc', 'barmode', 'bargap', 'mapType'")

## layout(p,
##   legend = list(x = 100, y = .5))

scatter <- ggplot(edu_exp, aes(x = Primary, y = Index, color = Wealth,
  frame = Year, group = Country,
  text = paste0(Country, 
    '</br></br>Region: ', Region, 
    '</br>GDP/Capita: ', Income, 
    '</br>Investment/Student: ', round((Primary/100)*Income)))) +
  geom_point() +
  labs(x = 'Investment on Primary Eduction',
  y = 'UNDP Education Index',
  color = NULL) +
  ggtitle('Impact of Primary Education Investments') +
  theme_pandar() + scale_color_pandar()

interact <- ggplotly(scatter, tooltip = 'text') |>
  animation_opts(transition = 200) |>
  layout(legend = list(x = 100, y = .5, 
        title = list(text = 'Country Wealth</br></br>(GDP per Capita)')))
## interact

## interact |>
##   config(modeBarButtonsToRemove = c('lasso2d', 'zoomIn2d', 'zoomOut2d'))

scatter2013 <- subset(edu_exp, Year == 2013) |>
  ggplot(aes(x = Primary, y = Index)) +
    geom_smooth(method = 'gam', color = 'grey70', se = FALSE) + 
    geom_point(aes(color = Wealth)) +
    labs(x = 'Investment on Primary Eduction',
    y = 'UNDP Education Index',
    color = 'Country Wealth\n(GDP per Capita)') +
    ggtitle('Impact of Primary Education Investments', subtitle = 'Data for 2013') +
    theme_pandar() + scale_color_pandar()
scatter2013

smooth <- ggplot(edu_exp, aes(x = Primary, y = Index, frame = Year)) +
  geom_smooth(method = 'gam', color = 'grey70', alpha = .2, se = FALSE) +
  geom_point(aes(color = Wealth,
        text = paste0(Country,
          '</br></br>Region: ', Region,
          '</br>GDP/Capita: ', Income,
          '</br>Investment/Student: ', round((Primary/100)*Income)))) +
  labs(x = 'Investment on Primary Eduction',
    y = 'UNDP Education Index',
    color = NULL) +
  ggtitle('Impact of Primary Education Investments') +
  theme_pandar() + scale_color_pandar()

menus <- list(
  list(type = 'buttons',
    x = 1.3, y = .2, align = 'left',
    buttons = list(
      list(method = 'restyle',
        args = list('line.color', 'rgba(179,179,179,1)'),
        label = 'Smoother On'),
      list(method = 'restlye',
        args = list('line.color', 'rgba(179,179,179,0)'),
        label = 'Smoother Off')
    ))
)

## smoothly <- ggplotly(smooth, tooltip = 'text') |>
##   animation_opts(transition = 200) |>
##   layout(legend = list(x = 100, y = .5,
##     title = list(text = 'Country Wealth</br></br>(GDP per Capita)')),
##     updatemenus = menus)
## smoothly
