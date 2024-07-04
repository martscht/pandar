# getting data
yr1 <- read.csv('https://osf.io/download/jknzd/', na.strings = c('NA', '-99'))
yr1 <- subset(yr1, select = c('participant_id', 'Y1PLWPUB', paste0('y1kre', 1:10)))
names(yr1)[1:2] <- c('id', 'y1pub')

yr2 <- read.csv('https://osf.io/download/xum9p/', na.strings = c('NA', '-99'))
yr2 <- subset(yr2, select = c('participant_id', 'Y2PLWPUB', paste0('y2kre', 1:10)))
names(yr2)[1:2] <- c('id', 'y2pub')

yr3 <- read.csv('https://osf.io/download/753r4/', na.strings = c('NA', '-99'))
yr3 <- subset(yr3, select = c('participant_id', 'Y3PLWPUB', paste0('y3kre', 1:10)))
names(yr3)[1:2] <- c('id', 'y3pub')

yr4 <- read.csv('https://osf.io/download/ec3z4/', na.strings = c('NA', '-99'))
yr4 <- subset(yr4, select = c('participant_id', 'Y4PLWPUB', paste0('y4kre', 1:10)))
names(yr4)[1:2] <- c('id', 'y4pub')

yr5 <- read.csv('https://osf.io/download/9268a/', na.strings = c('NA', '-99'))
yr5 <- subset(yr5, select = c('participant_id', 'Y5PLWPUB', paste0('y5kre', 1:10)))
names(yr5)[1:2] <- c('id', 'y5pub')

yr6 <- read.csv('https://osf.io/download/qxubk/', na.strings = c('NA', '-99'))
yr6 <- subset(yr6, select = c('participant_id', 'Y6PLWPUB', paste0('Y6KRE', 1:10)))
names(yr6) <- c('id', 'y6pub', tolower(names(yr6)[-c(1,2)]))

yr7 <- read.csv('https://osf.io/download/kgx35/', na.strings = c('NA', '-99'))
yr7 <- subset(yr7, select = c('participant_id', 'Y7PLWPUB', paste0('Y7KRE', 1:10)))
names(yr7) <- c('id', 'y7pub', tolower(names(yr7)[-c(1,2)]))

yr8 <- read.csv('https://osf.io/download/9cef6/', na.strings = c('NA', '-99'))
yr8 <- subset(yr8, select = c('participant_id', 'Y8PLWPUB', paste0('Y8KRE', 1:10)))
names(yr8) <- c('id', 'y8pub', tolower(names(yr8)[-c(1,2)]))

# combining data
ecr <- merge(yr1, yr2, by = 'id')
ecr <- merge(ecr, yr3, by = 'id')
ecr <- merge(ecr, yr4, by = 'id')
ecr <- merge(ecr, yr5, by = 'id')
ecr <- merge(ecr, yr6, by = 'id')
ecr <- merge(ecr, yr7, by = 'id')
ecr <- merge(ecr, yr8, by = 'id')

ecr <- ecr[, c('id', paste0('y', 1:8, 'pub'),
  paste0('y1kre', 1:10),
  paste0('y2kre', 1:10),
  paste0('y3kre', 1:10),
  paste0('y4kre', 1:10),
  paste0('y5kre', 1:10),
  paste0('y6kre', 1:10),
  paste0('y7kre', 1:10),
  paste0('y8kre', 1:10))]

for (iterator in 1:8) {
  ecr[, paste0('y', iterator, 'pub')] <- factor(ecr[, paste0('y', iterator, 'pub')], levels = c(1, 2),
    labels = c('Yes', 'No'))
}

# remove temporary data
rm(yr1, yr2, yr3, yr4, yr5, yr6, yr7, yr8, iterator)
