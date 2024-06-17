### Load data ----
shoot <- read.csv('https://osf.io/download/txm64/')

shoot <- with(shoot, 
  aggregate(correctDummy, data.frame(object, race, participant), mean))

names(shoot) <- c('object', 'race', 'id', 'prop')

shoot$stim <- paste(shoot$race, shoot$object, sep = '_')
shoot$object <- NULL; shoot$race <- NULL

dems <- read.csv('https://osf.io/download/7k6gm/')
dems <- subset(dems, 
  select = c('Participant..', 'Condition', 'Caf.Condition'))
names(dems) <- c('id', 'sleep', 'caffeine')

shoot <- merge(dems, shoot, by = 'id')
shoot <- subset(shoot, shoot$caffeine != 'sustained')

shoot$sleep <- as.factor(shoot$sleep)
shoot$caffeine <- as.factor(shoot$caffeine)
shoot$stim <- as.factor(shoot$stim)

shoot <- reshape(shoot,
  v.names = c('prop'),
  timevar = c('stim'),
  idvar = c('id'),
  direction = 'wide')

rm(dems)
