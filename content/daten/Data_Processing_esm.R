# Load data
esm <- read.csv('https://osf.io/download/bn8gu/')

# code groups
esm$group <- as.factor(esm$group)

# recode sharing partner
esm$sharee <- as.factor(esm$item38)
esm$sharee[esm$sharee == 'acquaintance'] <- 'stranger'
esm$sharee <- droplevels(esm$sharee)
esm$close <- factor(esm$sharee, levels = c('friend', 'family member', 'romantic parntner',
  'someone at work', 'stranger'), labels = c('close', 'close', 'close', 'non-close', 'non-close'))

# IER goals
esm$goal = as.factor(
  ifelse(esm$item41.1=="advice, help, or information" &
      esm$item41.2=="not empathy, care, or understanding",
    "advice only",
    ifelse(esm$item41.1=="not advice, help, or information" &
        esm$item41.2=="empathy, care, or understanding",
      "empathy only",
      ifelse(esm$item41.1=="advice, help, or information" &
          esm$item41.2=="empathy, care, or understanding",
        "both", NA))))

# IER strategies
esm$reappraisal <- as.numeric(esm$item42.1 == 'interpreted the situation in a positive light')
esm$solving <- as.numeric(esm$item42.2 == 'suggested solutions to the problem')
esm$invalidation <- as.numeric(esm$item42.3 == 'suggested that I was overreating')
esm$blaming <- as.numeric(esm$item42.4 == 'suggested that I contributed to the problem')
esm$sharing <- as.numeric(esm$item42.5 == 'encouraged me to share my feelings')
esm$affection <- as.numeric(esm$item42.6 == 'showed love or affection')
esm$other <- as.numeric(esm$item42.7 == 'none of these')

esm$warmth <- esm$item43_R
esm$problem <- esm$item44_R
esm$interpersonal <- esm$item45_R

# subset only active responses
esm$occurance <- as.factor(esm$item37)
esm <- esm[!is.na(esm$item37), ]

esm$id <- esm$participant_id

# select variables
esm <- subset(esm, select = c('id', 'daynumber', 'index1', 'group', 'occurance', 'close', 'goal', 'reappraisal', 'solving', 'invalidation', 'blaming', 'sharing', 'affection', 'other', 'warmth', 'problem', 'interpersonal', 'gender', 'age', 'race', 'education', 'relationshipstatus'))
