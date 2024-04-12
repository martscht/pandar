library(dplyr)

# Geografische Informationen
raw_geo <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/ddf--entities--geo--country.csv')

# Populationsdaten
pop <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/countries-etc-datapoints/ddf--datapoints--total_population_with_projections--by--geo--time.csv')

# Lebenserwartung
expect <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/countries-etc-datapoints/ddf--datapoints--life_expectancy_at_birth_data_from_ihme--by--geo--time.csv')

# Einkommen (GDP / Person)
income <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/countries-etc-datapoints/ddf--datapoints--gdppercapita_us_inflation_adjusted--by--geo--time.csv')

# Investition in Bildung (nach Bildungsstufe getrennt)
primary <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/countries-etc-datapoints/ddf--datapoints--expenditure_per_student_primary_percent_of_gdp_per_person--by--geo--time.csv')
secondary <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/countries-etc-datapoints/ddf--datapoints--expenditure_per_student_secondary_percent_of_gdp_per_person--by--geo--time.csv')
tertiary <- read.csv('https://raw.githubusercontent.com/open-numbers/ddf--gapminder--systema_globalis/master/countries-etc-datapoints/ddf--datapoints--expenditure_per_student_tertiary_percent_of_gdp_per_person--by--geo--time.csv')

hdr <- read.csv('https://hdr.undp.org/sites/default/files/2023-24_HDR/HDR23-24_Composite_indices_complete_time_series.csv')
names(hdr)[1] <- 'geo'
hdr$geo <- tolower(hdr$geo)

eys <- select(hdr, geo, starts_with('eys_')) |> 
  pivot_longer(cols = -geo, names_to = 'year', values_to = 'eys',
    names_prefix = 'eys_') |> 
  mutate(year = as.integer(year))

mys <- select(hdr, geo, starts_with('mys_')) |> 
  pivot_longer(cols = -geo, names_to = 'year', values_to = 'mys',
    names_prefix = 'mys_') |> 
  mutate(year = as.integer(year))

edx <- merge(eys, mys, by = c('geo', 'year')) |> 
  mutate(index = round((mys/15 + eys/18)/2,2)) |>
  select(-eys, -mys) |> rename(time = year)

geo <- transmute(raw_geo, geo = country, Country = name, Wealth = income_groups, Region = world_4region)

names(geo)

geo <- right_join(geo, pop, by = 'geo') |>
  full_join(expect, by = c('geo', 'time')) |>
  full_join(income, by = c('geo', 'time')) 

edu <- full_join(primary, secondary, by = c('geo', 'time')) |>
  full_join(tertiary, by = c('geo', 'time')) |>
  full_join(edx, by = c('geo', 'time'))

edu_exp <- full_join(geo, edu, by = c('geo', 'time'))

edu_exp <- filter(edu_exp, time < 2018 & time > 1996) |>
  filter(!is.na(Country))

names(edu_exp)

names(edu_exp)[-c(1:4)] <- c('Year', 'Population', 'Expectancy', 'Income', 'Primary', 'Secondary', 'Tertiary', 'Index')

head(edu_exp)
