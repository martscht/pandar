## load(url('https://pandar.netlify.com/post/edu_exp.rda'))

load('../../daten/edu_exp.rda')

library(ggplot2)

## source('https://pandar.netlify.com/workshops/ggplotting/ggplotting-theme-source.R')

source('./ggplotting-theme-source.R')

sel <- subset(edu_exp, geo %in% c('gbr', 'fra', 'ita', 'esp', 'pol'))
subset(sel, !is.na(Primary)) |>
  ggplot(aes(x = Year, y = Primary, color = Country)) +
  geom_point() + geom_line() +
  ggtitle('Spending on Primary Education') +
  theme_pandar() + scale_color_pandar()

edu_exp$Wealth <- factor(edu_exp$Wealth,
  levels = c('high_income', 'upper_middle_income', 'lower_middle_income', 'low_income'),
  labels = c('High', 'Upper Mid.', 'Lower Mid.', 'Low'))

subset(edu_exp, Year == 2013) |>
  ggplot(aes(x = Primary, y = Index, color = Wealth)) +
    geom_point() +
    labs(x = 'Spending on Primary Eduction',
    y = 'UNDP Education Index',
    color = 'Country Wealth\n(GDP per Capita)') +
    ggtitle('Impact of Primary Education Investments', subtitle = 'Data for 2013') +
    theme_pandar() + scale_color_pandar()

static <- ggplot(edu_exp, aes(x = Primary, y = Index, color = Wealth)) +
  geom_point() +
  labs(x = 'Spending on Primary Eduction',
  y = 'UNDP Education Index',
  color = 'Country Wealth\n(GDP per Capita)') +
  ggtitle('Impact of Primary Education Investments') +
  theme_pandar() + scale_color_pandar()
static

static + facet_wrap(~ Year, scales = 'free')

trimmed <- subset(edu_exp, Year < 2017 & Year > 1997)
static <- ggplot(trimmed, aes(x = Primary, y = Index, color = Wealth)) +
  geom_point() +
  labs(x = 'Spending on Primary Eduction',
  y = 'UNDP Education Index',
  color = 'Country Wealth\n(GDP per Capita)') +
  ggtitle('Impact of Primary Education Investments') +
  theme_pandar() + scale_color_pandar()

subset(trimmed, Year %in% c(2008, 2009) & geo == 'esp')

## install.packages('gganimate')
## install.packages('gifski')

library('gganimate')

## fluid <- static + transition_time(Year)

## animated <- animate(fluid)
## anim_save('step1.gif', animated)

subset(trimmed, geo == 'ind', select = c('Country', 'Wealth', 'Year', 'Primary', 'Index'))

nomiss <- subset(trimmed, !(is.na(Primary) | is.na(Index)))

subset(nomiss, geo == 'ind', select = c('Country', 'Wealth', 'Year', 'Primary', 'Index'))

static <- ggplot(nomiss, aes(x = Primary, y = Index, color = Wealth, group = Country)) +
  geom_point() +
  labs(x = 'Spending on Primary Eduction',
  y = 'UNDP Education Index',
  color = 'Country Wealth\n(GDP per Capita)') +
  ggtitle('Impact of Primary Education Investments') +
  theme_pandar() + scale_color_pandar()

## fluid <- static + transition_time(Year)
## animated <- animate(fluid)
## anim_save('step2.gif', animated)

fluid <- static + transition_time(Year) +
  enter_fade(alpha = .1) + exit_fade(alpha = .1)

plot(fluid, 2)

fluid <- static + transition_time(Year) +
  enter_fade(alpha = .1) + exit_fade(alpha = .1) +
  shadow_wake(.5)

plot(fluid, 44)

## fluid <- static + transition_time(Year) +
##   enter_fade(alpha = .1) + exit_fade(alpha = .1) +
##   ease_aes('elastic-in')

fluid <- static + transition_time(Year) +
  enter_fade(alpha = .1) + exit_fade(alpha = .1) +
  view_follow()

fluid <- static + transition_time(Year) +
  enter_fade(alpha = .1) + exit_fade(alpha = .1) +
  ggtitle('Impact of Primary Education Investments', 'Year: {frame_time}')

## animated <- animate(fluid,
##   nframes = 200, fps = 10)

## animated <- animate(fluid,
##   nframes = 200, fps = 10,
##   start_pause = 20,
##   end_pause = 20)

edu_exp$Index_Rank <- ave(-edu_exp$Index, edu_exp$Year, FUN = function(x) rank(x, ties.method = 'first'))

subset(edu_exp, Index_Rank < 11 & Year == 1997)

edu_exp$Region <- factor(edu_exp$Region,
  levels = c('europe', 'asia', 'americas', 'africa'),
  labels = c('Europe', 'Asia', 'Americas', 'Africa'))

top10 <- subset(edu_exp, Index_Rank < 11)

static <- ggplot(top10,
  aes(y = Index_Rank, x = Index, fill = Region, group = Country))

static <- static + 
  geom_rect(aes(ymin = Index_Rank - .4, ymax = Index_Rank + .4,
  xmin = 0, xmax = Index))

static <- static +
  geom_text(hjust = 'right', aes(label = Country), color = 'white')

static <- static +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_reverse()

static <- static +
  ggtitle('Top Spots in the Education Race') +
  labs(y = element_blank(), x = 'UNDP Education Index') +
  theme_pandar() + scale_fill_pandar(drop = FALSE) +
  theme(axis.text.y = element_blank())

static + facet_wrap(~ Year, scales = 'free')

fluid <- static + 
  transition_states(Year, transition_length = 30, state_length = 1,
    wrap = FALSE)

fluid <- fluid + 
  ggtitle('Top Spots in the Education Race', subtitle = 'Year: {closest_state}')

fluid <- fluid + 
  enter_drift(y_mod = -1) + exit_drift(y_mod = -1)

fluid <- fluid + 
  enter_fade(alpha = .1) + exit_fade(alpha = .1)

plot(fluid, 12)

## animated <- animate(fluid,
##   fps = 20, duration = 15,
##   end_pause = 20)
