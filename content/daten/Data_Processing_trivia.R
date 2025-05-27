#### Loading data from Fazio et al., 2022, https://doi.org/10.1037/xge0001211

# Complete data
trivia <- read.csv('https://osf.io/7ekb4/download')

# remove sequencing and spacing
trivia <- subset(trivia, select = -c(Condition, spacing))

# rename id for consistency
names(trivia)[1] <- 'id'

# convert conditions to factors
trivia$truth <- factor(trivia$truth, labels = c('true', 'false'))
trivia$headline <- as.factor(trivia$headline)
