knitr::opts_chunk$set(message = FALSE, warning = FALSE)

library(tidyverse) 
library(here)
data_gis_raw <- read_csv(url("https://raw.githubusercontent.com/jlschnatz/PsyBSc8_Diagnostik/main/src/data/GIS-data.csv"))
head(data_gis_raw) 

data_gis_item <- select(data_gis_raw, starts_with("GIS"))
data_gis_item <- select(data_gis_raw, 7:27) # Alternative 
colnames(data_gis_item) # Ausgabe der Spalten des Datensatzes

anyNA(data_gis_item)
sum(is.na(data_gis_item)) # Alternative

## na.omit(data_gis_item)
## drop_na(data_gis_item)

library(psych)
describe(data_gis_item) 

describe(data_gis_raw$Age)

library(janitor)
tabyl(data_gis_raw$sex)

## tabyl(data_gis_raw$sex, show_na = TRUE)

library(sjPlot)
descr_age <- describe(data_gis_raw$Age)
tab_df(x = descr_age)

## tab_df(
##   x = descr_age,
##   file = "table_descr_age.doc"
##   )

descr_sex <- tabyl(data_gis_raw$sex)
tab_df(descr_sex)

descr_age_by_sex <- describeBy(x = data_gis_raw$Age,
           group = data_gis_raw$sex) 
print(descr_age_by_sex)
tab_dfs(
  x = descr_age_by_sex,
  titles = c("Weiblich","Männlich"),
  )

tab_dfs(
  x = list(descr_age, descr_sex), 
  titles = c("Descriptives of Age", "Descriptives of Sex")
  )

## tab_dfs(
##   x = list(descr_age, descr_sex),
##   titles = c("Descriptives of Age","Descriptives of Sex"),
##   file = "descriptives_all.doc" # wieder als .doc abspeichern
##   )

library(sjmisc)
inverse_items <- c("GIS9","GIS16","GIS17","GIS18") 
data_gis_rec <- data_gis_item %>% 
  mutate(across(
    .cols = inverse_items, 
    .fns = ~rec(x = .x, rec = "0=4; 1=3; 2=2; 3=1; 4=0"),
    .names = "{col}_r")
    ) %>% 
  select(-inverse_items) 
colnames(data_gis_rec)

sjt.itemanalysis(
  df = data_gis_rec,
  factor.groups.titles = "Erste Itemanalyse"
  )

col_order <- c(
  "GIS1","GIS2","GIS3","GIS4","GIS5","GIS6",
  "GIS7","GIS8","GIS9_r","GIS10", "GIS11",
  "GIS12","GIS13","GIS14","GIS15","GIS16_r",
  "GIS17_r","GIS18_r", "GIS19","GIS20","GIS21"
  )
data_gis_rec2 <- select(data_gis_rec, all_of(col_order))
sjt.itemanalysis(
  df = data_gis_rec2,
  factor.groups.titles = "Desktiptive Ergebnisse der Itemanalyse (mit angepasster Reihenfolge)"
  )

drop_discrm <- c("GIS9_r", "GIS16_r","GIS17_r", "GIS18_r")
data_gis_final <- select(data_gis_rec2, -all_of(drop_discrm))

sjt.itemanalysis(
  df = data_gis_final,
  factor.groups.titles = "Finale Itemanalyse"
  )

omega_items <- omega(data_gis_final,
                     plot = FALSE)
omega_items$omega.tot
omega_items$alpha
