## load(url('https://pandar.netlify.com/post/edu_exp.rda'))

load('../../daten/edu_exp.rda')

head(edu_exp)

library(ggplot2)

esp <- subset(edu_exp, geo == 'esp')

ggplot(esp)

ggplot(esp, aes(x = Year, y = Primary))

ggplot(esp, aes(x = Year, y = Primary)) + 
  geom_line()

ggplot(esp, aes(x = Year, y = Primary)) + 
  geom_line() + 
  geom_point()

basic <- ggplot(esp, aes(x = Year, y = Primary))

basic + geom_point()

ggplot(esp, aes(x = Year, y = Primary)) +
  geom_point(color = 'blue')

ggplot(esp, aes(x = Year, y = Primary)) +
  geom_point(aes(color = Primary))

sel <- subset(edu_exp, geo %in% c('gbr', 'fra', 'ita', 'esp', 'pol'))

ggplot(sel, aes(x = Year, y = Primary)) +
  geom_point()

ggplot(sel, aes(x = Year, y = Primary)) +
  geom_point(aes(color = Country))

ggplot(sel, aes(x = Year, y = Primary)) +
  geom_point(aes(color = Country)) + 
  geom_line(aes(color = Country))

## ggplot(sel, aes(x = Year, y = Primary, color = Country)) +
##   geom_point() + geom_line()

ggplot(esp, aes(x = Year)) +
  geom_line(aes(y = Primary), color = 'red') +
  geom_line(aes(y = Secondary), color = 'green') + 
  geom_line(aes(y = Tertiary), color = 'blue') 

sel_long <- reshape(sel, direction = 'long',
  varying = c('Primary', 'Secondary', 'Tertiary'),
  v.names = 'Expense',
  timevar = 'Type',
  times = c('Primary', 'Secondary', 'Tertiary'))

head(sel_long)

subset(sel_long, geo == 'esp') |> 
  ggplot(aes(x = Year, y = Expense, color = Type)) +
    geom_line() + geom_point()

ggplot(sel_long, aes(x = Year, y = Expense, color = Country)) +
  geom_point() + geom_line() +
  facet_wrap(~ Type)

ggplot(sel_long, aes(x = Year, y = Expense, color = Country)) +
  geom_point() + geom_line() +
  facet_grid(Type ~ Country)

ggplot(sel_long, aes(x = Year, y = Expense, color = Country)) +
  geom_point() + geom_line() +
  facet_grid(Type ~ Country, scales = 'free')
