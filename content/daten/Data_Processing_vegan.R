# General preparation ####

# Load functions
toCamelCase = function(s) {
  s = gsub("-", " ", s)  # replace hyphens with spaces
  s = gsub("’", " ", s)  # replace right single quotation marks with spaces
  s = gsub("'", " ", s)  # replace simple single quotes with spaces
  s = strsplit(s, " ")[[1]]
  paste0(tolower(s[1]), paste0(sapply(s[-1], function(x) {paste(toupper(substring(x, 1, 1)), substring(x, 2), sep = "")}), collapse = ""))
}

## Vegans ####
vegan = read.table(file = "https://osf.io/download/rctkf/", header = T, sep = "\t", stringsAsFactors = F, na.strings = c("", "-1", "-2", -1, -2, -9), fileEncoding = "UCS-2LE")


### Data cleaning ####
#### Column cleaning ####
#### Choose relevant variables
vegan = vegan[, c(1, 6, 241, 227, 37, #survey
                38:41, #demographics
                157:191, #VEMI
                50:130, #validating measures
                154:156)] #vegan commitment

#### Give column names
colnames(vegan) = c(paste("survey", c("case", "start", "end", "timeVemi", "idSelf"), sep = "_"),
                   paste("demo", c("age", "gender", "race", "ethnicity"), sep = "_"),
                   paste("vemi", sprintf("%02d", c(1:35)), sep = "_"),
                   paste("healthAttitudes", sprintf("%02d", c(1:24)), sep = "_"),
                   paste("connectednessNature", sprintf("%02d", c(1:14)), sep = "_"),
                   paste("solidarityAnimals", c(1:5), sep = "_"),
                   paste("needBelong", sprintf("%02d", c(1:10)), sep = "_"),
                   paste("socialJustice", sprintf("%02d", c(1:11)), sep = "_"),
                   paste("fearCovid", c(1:7), sep = "_"),
                   paste("disgustPropensity", sprintf("%02d", c(1:10)), sep = "_"),
                   paste("commitment", c(1:3), sep = "_"))

#### Rescale/factor variables
vegan$demo_gender = factor(vegan$demo_gender, c(1:3), c("male", "female", "nonconformingOther"))

#### Race/Ethnicity
vegan$demo_race[which(vegan$demo_race == 5)] = 4
vegan$demo_race = factor(vegan$demo_race, c(1:7), c("White",
                                                  "Black",
                                                  "Asian",
                                                  "AIAN",
                                                  "NHPI",
                                                  "other",
                                                  "mixed"))
vegan$demo_ethnicity = 3 - vegan$demo_ethnicity
vegan$demo_ethnicity = factor(vegan$demo_ethnicity, c(1:2), c("non-Hispanic", "Hispanic"))


#### Row cleaning ####
#### Exclude participants with incorrect Prolific IDs
vegan = vegan[-c(1, 2, 71), ] # 3

#### Exclude participants with more than 2.5% missing values
naCount = rowSums(is.na(vegan))
vegan = vegan[which(naCount/153*100 <= 2.5), ] # 24

#### Exclude participants who answered more than one VEMI item per second
which(vegan$survey_timeVemi/35 < 0) # 0

#### Exclude participants who reprt being younger than 18 years
vegan = vegan[-which(vegan$demo_age < 18), ] # 1

#### Reset row names
rownames(vegan) = NULL


#### Health attitudes ####
healthAttitudes = vegan[, c(45:68)]
vegan$healthAttitudes = rowMeans(healthAttitudes, na.rm = T)

#### Connectedness to nature ####
connectednessNature = vegan[, c(69:82)]
vegan$connectednessNature = rowMeans(connectednessNature, na.rm = T)


#### Solidarity with animals ####
solidarityAnimals = vegan[, c(83:87)]
vegan$solidarityAnimals = rowMeans(solidarityAnimals, na.rm = T)


#### Need to belong ####
needBelong = vegan[, c(88:97)]
vegan$needBelong = rowMeans(needBelong, na.rm = T)


#### Social justice ####
socialJustice = vegan[, c(98:108)]
vegan$socialJustice = rowMeans(socialJustice, na.rm = T)


#### Fear of Covid-19 ####
fearCovid = vegan[, c(109:115)]
vegan$fearCovid = rowMeans(fearCovid, na.rm = T)


#### Disgust propensity ####
disgustPropensity = vegan[, c(116:125)]
vegan$disgustPropensity = rowMeans(disgustPropensity, na.rm = T)


#### VEMI ####
vegan_vemi = vegan[, c(10:44)]
colnames(vegan_vemi) = c("I want to be healthy",
                        "Plant-based diets are better for the environment",
                        "Animals do not have to suffer",
                        "I want to be like people in my social group",
                        "Animal agriculture creates terrible working conditions",
                        "It increases the risk of pandemics",
                        "The idea of eating meat disgusts me",
                        "I want to live a long time",
                        "Plant-based diets are more sustainable",
                        "Animals’ rights are respected",
                        "I want to be more like people I admire",
                        "People who work in animal agriculture are exploited",
                        "I do not want to cause a pandemic",
                        "I don’t want animal meat in my body",
                        "I care about my body",
                        "Eating meat is bad for the planet",
                        "Animal rights are important to me",
                        "I want to fit in",
                        "I want to protect the rights of people who work in animal agriculture",
                        "Animal agriculture reduces resistance to disease in humans",
                        "Eating meat is dirty",
                        "My health is important to me",
                        "Plant-based diets are environmentally-friendly",
                        "It does not seem right to exploit animals",
                        "I want to be more popular",
                        "People who work in animal agriculture are not treated well",
                        "Pandemics are usually caused by eating animals",
                        "Meat is unclean",
                        "Plants have less of an impact on the environment than animal products",
                        "I am concerned about animal rights",
                        "I want to be part of the in crowd",
                        "I want to avoid exploiting people working in animal agriculture",
                        "It can cause disease in humans",
                        "Meat is gross",
                        "I don’t want animals to suffer")
names(vegan_vemi) = sapply(names(vegan_vemi), toCamelCase)
vegan_vemi = vegan_vemi[ , order(names(vegan_vemi))]


## Scales ####
vegan$vemi_health = rowMeans(vegan_vemi[, which(colnames(vegan_vemi) %in% c("iWantToBeHealthy", "myHealthIsImportantToMe", "iCareAboutMyBody"))], na.rm = T)
vegan$vemi_environment = rowMeans(vegan_vemi[, which(colnames(vegan_vemi) %in% c("plantBasedDietsAreEnvironmentallyFriendly", "plantBasedDietsAreBetterForTheEnvironment", "plantBasedDietsAreMoreSustainable"))], na.rm = T)
vegan$vemi_animals = rowMeans(vegan_vemi[, which(colnames(vegan_vemi) %in% c("iDonTWantAnimalsToSuffer", "iAmConcernedAboutAnimalRights", "animalsRightsAreRespected"))], na.rm = T)
vegan$vemi_social = rowMeans(vegan_vemi[, which(colnames(vegan_vemi) %in% c("iWantToBeMorePopular", "iWantToBeLikePeopleInMySocialGroup", "iWantToBeMoreLikePeopleIAdmire"))], na.rm = T)
vegan$vemi_workers = rowMeans(vegan_vemi[, which(colnames(vegan_vemi) %in% c("iWantToProtectTheRightsOfPeopleWhoWorkInAnimalAgriculture", "iWantToAvoidExploitingPeopleWorkingInAnimalAgriculture", "peopleWhoWorkInAnimalAgricultureAreNotTreatedWell"))], na.rm = T)
vegan$vemi_pandemic = rowMeans(vegan_vemi[, which(colnames(vegan_vemi) %in% c("itIncreasesTheRiskOfPandemics", "pandemicsAreUsuallyCausedByEatingAnimals", "itCanCauseDiseaseInHumans"))], na.rm = T)
vegan$vemi_disgust = rowMeans(vegan_vemi[, which(colnames(vegan_vemi) %in% c("meatIsGross", "theIdeaOfEatingMeatDisgustsMe", "iDonTWantAnimalMeatInMyBody"))], na.rm = T)

### Commitment ###
commitment = vegan[, c(126:128)]
vegan$commitment = rowMeans(commitment, na.rm = T)


#### Select relevant data ----
vegan <- subset(vegan, select = c(
  'demo_age', 'demo_gender', 'demo_race',
  'commitment',
  'vemi_health', 'vemi_environment', 'vemi_animals',
  'vemi_social', 'vemi_workers', 'vemi_disgust'))

names(vegan) <- c('age', 'gender', 'race',
  'commitment',
  'health', 'environment', 'animals',
  'social', 'workers', 'disgust')

rm("commitment", "connectednessNature", "disgustPropensity", 
  "fearCovid", "healthAttitudes", "naCount", "needBelong", "socialJustice",
  "solidarityAnimals", "toCamelCase", "vegan_vemi")
