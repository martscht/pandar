raw_data <- readRDS(url("https://osf.io/awz3d/download"))

names(raw_data) <- c("observe", "describe", "awaren.", "nonjudg.",
                     "nonreact.", "interest",  "emotions",  "sleep",
                     "tired",  "appetite", "selfim.",
                     "concentr.", "speed")

load(url("https://pandar.netlify.app/daten/alc.rda"))

load(url("https://pandar.netlify.app/daten/alc_extended.rda"))

load(url("https://pandar.netlify.app/daten/StressAtWork.rda"))

load(url('https://pandar.netlify.app/daten/edu_exp.rda'))

load(url("https://pandar.netlify.app/daten/fairplayer.rda"))

load(url("https://pandar.netlify.app/daten/Depression.rda"))

load(url("https://pandar.netlify.app/daten/Big5_EFA.rda"))

## source("https://pandar.netlify.app/daten/Data_Processing_distort.R")
source('./Data_Processing_distort.R')

library(metafor)
F2F_CBT <- dat.lopez2019[dat.lopez2019$treatment == "F2F CBT",] # wähle nur Fälle mit F2F CBT

load(url("https://pandar.netlify.app/daten/Assessment.rda"))

load(url("https://pandar.netlify.app/daten/WorldPopulation.rda"))

## load(url('https://pandar.netlify.com/daten/ecr.rda'))
load('./ecr.rda')

load(url('https://pandar.netlify.app/daten/fb22.rda'))

load(url('https://pandar.netlify.app/daten/fb23.rda'))

## load(url('https://pandar.netlify.app/daten/fb24.rda'))
load('./fb24.rda')

library(haven)
osf <- read_sav(file = url("https://osf.io/prc92/download"))

library(metafor)
load(url('https://pandar.netlify.app/daten/reliabilites.molloy2014.rda'))

data_combined <- dat.molloy2014
data_combined$rel1 <- reliabilites.molloy2014$RelGewissenhaftigkeit
data_combined$rel2 <- reliabilites.molloy2014$RelCondition
head(data_combined)

load(url("https://pandar.netlify.app/daten/PCA.RData"))

## load(url("https://pandar.netlify.app/daten/HeckData.rda"))

osf <- read.csv(file = url("https://osf.io/zc8ut/download"))
osf <- osf[, c("ID", "group", "stratum", "bsi_post", "swls_post", "pas_post")]

library(haven)
body <- haven::read_sav(file = url('https://osf.io/43xv5/download'))

body <- body[, 1:27]

## load(url("https://pandar.netlify.app/daten/conspiracy_cfa.rda"))

dataKooperation <- data.frame(Paar = 1:10, Juenger = c(0.49,0.25,0.51,0.55,0.35,0.54,0.24,0.49,0.38,0.50), Aelter = c(0.4,0.25,0.31,0.44,0.25,0.33,0.26,0.38,0.23,0.35))

source("https://pandar.netlify.app/daten/Data_Processing_punish.R")

#### Data preparation file for punishment severity evaluation ----
# for the paper see: https://onlinelibrary.wiley.com/doi/10.1111/ajsp.12509

punish <- foreign::read.spss('https://osf.io/4wypx/download', use.value.labels = TRUE,
  to.data.frame = TRUE)

punish <- punish[, c('culture_group', 'bribery_type', 'age', 'gender',
  'gains_everage', 'difficulties_everage', 'noticed_probability_everage',
  'punishment_probability_everage', 'punishment_severity_everage')]
names(punish) <- c('country', 'bribe', 'age', 'gender', 'gains', 'difficult', 
  'notice', 'probable', 'severe')

levels(punish$age) <- c(levels(punish$age), 'over 50')
punish$age[punish$age %in% c('51-60', '61-70', 'over 70')] <- 'over 50'
punish$age <- droplevels(punish$age)

load(url("https://pandar.netlify.app/daten/PISA2009.rda"))

load(url("https://pandar.netlify.app/daten/mach.rda"))

data <- read.csv(url("https://osf.io/g6ya4/download"))

load(url("https://pandar.netlify.app/daten/mdbf.rda"))

## source(url("https://pandar.netlify.app/daten/Data_Processing_Quiz4b.R"))

load(url("https://pandar.netlify.app/daten/nature.rda"))

load(url("https://pandar.netlify.app/daten/NerdData.rda"))

burnout <- read.csv(file = url("https://osf.io/qev5n/download"))
burnout <- burnout[,2:8]

library(dplyr)
library(ICC)
library(lme4)
library(interactions)

# Daten einlesen und vorbereiten ----
lockdown <- read.csv(url("https://osf.io/dc6me/download"))

# Entfernen der Personen, für die weniger als zwei Messpunkte vorhanden sind
# (Auschluss von Fällen, deren ID nur einmal vorkommt)
lockdown <- lockdown[-which(lockdown$ID %in% names(which(table(lockdown$ID)==1))),] 

# Daten aufbereiten, Variablen auswählen extrahieren und in Nummern umwandeln
# Entfernen von Minderjährigen & unbestimmtes Gender mit den Funktionen filter() & select () aus dplyr.
lockdown <- lockdown %>%
  filter(Age > 18 & Gender == 1 | Gender == 2) %>%
  select(c("ID", "Wave", "Age", "Gender", "Income", "EWB","PWB","SWB",
           "IWB","E.threat","H.threat", "Optimism",
           "Self.efficacy","Hope","P.Wisdom","ST.Wisdom","Grat.being",
           "Grat.world","PD","Acc","Time","EWB.baseline","PWB.baseline",
           "SWB.baseline","IWB.baseline"))

# Standardisieren der AVs
lockdown[,c("EWB", "PWB", "SWB", "IWB")] <- scale(lockdown[,c("EWB", "PWB", "SWB", "IWB")])
# Standardisieren möglicher Prädiktoren
lockdown[,c("E.threat", "H.threat", "Optimism", "Self.efficacy", "Hope", "P.Wisdom", 
            "ST.Wisdom", "Grat.being", "Grat.world")] <-
  scale(lockdown[,c("E.threat", "H.threat", "Optimism", "Self.efficacy", "Hope", "P.Wisdom", 
            "ST.Wisdom", "Grat.being", "Grat.world")])

load(url("https://pandar.netlify.app/daten/CBTdata.rda"))

load(url("https://pandar.netlify.app/daten/Schulleistungen.rda"))

load(url("https://pandar.netlify.app/daten/conspiracy.rda"))

load(url("https://pandar.netlify.app/daten/StudentsInClasses.rda"))

load(url("https://pandar.netlify.app/daten/Therapy.rda"))

load(url("https://pandar.netlify.app/daten/Titanic.rda"))

source(url("https://pandar.netlify.app/daten/Data_Processing_Quiz1.R"))

## source("https://pandar.netlify.app/daten/Data_Processing_vegan.R")
source('./Data_Processing_vegan.R')

load(url("https://pandar.netlify.app/daten/Behandlungsform.rda"))

load(url("https://pandar.netlify.app/daten/Xmas.rda"))
