#### Example Data for FE II ----

# Load the data
raw_osf_frischlich <- read.csv('https://osf.io/download/k4xcv/')

distort <- subset(raw_osf_frischlich, select = c('VP', 'Sex', 'Age', 'dummy_student', 'dummy_eastgerman', 'Federal_state',
  'articletype', 'articleideology', 'Political_Ideology', 'Politbarometer', 
  grep('RWA', names(raw_osf_frischlich), value = TRUE),
  grep('CM', names(raw_osf_frischlich), value = TRUE),
  grep('Credibility', names(raw_osf_frischlich), value = TRUE),
  grep('Pos_Att', names(raw_osf_frischlich), value = TRUE),
  grep('Threat_Refugees', names(raw_osf_frischlich), value = TRUE),
  grep('Marginalization', names(raw_osf_frischlich), value = TRUE)))

distort <- distort[, !grepl('_mean', names(distort))]

names(distort) <- c('id', 'sex', 'age', 'stud', 'east', 'state', 'type', 'ideology', 'leaning', 'attitude',
  paste0('rwa', 1:9),
  paste0('cm', 1:5),
  paste0('credibility', 1:7),
  paste0('perception', 1:8), 
  paste0('threat', 1:9),
  paste0('marginal', 1:8))

# Variable Overview
# id: Participant
# sex: gender
# age: age
# stud: student status
# east: east-german residence
# state: German federal state
# type: article type (neutral vs. distorted)
# ideology: ideology of the article (right vs. left wing)
# leaning: political leaning of the participant (mid = 5)
# attitude: attitude towards candidate
# rwa: right wing authoritarianism
# cm: conspiracy mentality
# credibility: credibility of the article
# perception: perception of candidate
# threat: perceived threat of refugees
# marginal: perceived marginalization

distort$sex <- as.factor(distort$sex)
distort$state <- as.factor(distort$state)
distort$type <- as.factor(distort$type)
distort$ideology <- as.factor(distort$ideology)

rm(raw_osf_frischlich)
