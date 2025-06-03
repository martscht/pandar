#### Example Data for FE II ----

# Load the data
raw_osf_frischlich <- read.csv('https://osf.io/download/k4xcv/')

distort <- subset(raw_osf_frischlich, select = c('VP', 'Sex', 'Age', 'dummy_student', 'dummy_eastgerman', 'Federal_state',
  'articletype', 'articleideology', 'Political_Ideology', 'Politbarometer', grep('_mean', names(raw_osf_frischlich), value = TRUE)))

names(distort) <- c('id', 'sex', 'age', 'stud', 'east', 'state', 'type', 'ideology', 'leaning', 'attitude', 'attention',
  'rwa', 'cm', 'credibility', 'perception', 'threat', 'marginal')

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
# attention: level of attention to politics
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
