# Subsetting data
zika_full <- read.csv('https://osf.io/fn9aq/download') |> subset(finished == 1)

zika <- with(data = zika_full,
    data.frame(wave,
      age, gender,
      preg = NA,
      race = NA,
      educ,
      polparty,
      lklyget, contrl, cdceff,
      consp = NA))

# Race variable
zika_races <- zika_full[, grep('race', names(zika_full))]
zika_races <- zika_races[, -ncol(zika_races)]
zika_races[is.na(zika_races)] <- 0
zika_races[rowSums(zika_races) != 1, ] <- data.frame(0, 0, 0, 0, 0, 1)

zika$race <- as.matrix(zika_races) %*% c(4, 1, 2, 4, 3, 4) |> as.vector() |>
  factor(labels = c('Asian', 'African', 'Caucasian', 'Other'))

# Pregnancy
zika$preg <- ifelse(is.na(zika_full$youpreg),
  zika_full$getpreg,
  ifelse(zika_full$youpreg == 1,
    zika_full$getpreg,
    3)) |> factor(labels = c('Not planned', 'Planned', 'Currently pregnant'))

# Conspiracy scale value
zika$consp <- rowMeans(zika_full[, c('gmomosq', 'bioweap', 'popcntrl', 'badvax', 'pest')], na.rm = TRUE)
# Gender
zika$gender <- factor(zika$gender, labels = c('male', 'female', 'other'))
zika$gender[zika$gender == 'other'] <- NA
# Education
zika$educ <- factor(zika$educ, labels = c('< High School', '< High School', '< High School',
  'High School', 'Some College', 'Some College', 'Some College',
  'College +', 'College +', 'College +'))
# Pol Party
zika$polparty <- factor(zika$polparty, labels = c('Democrat', 'Republican',
  'Other', 'Other', 'Other', 'None'))

# Returning only final zika set
zika <- na.omit(zika) |> as.data.frame()
rm(zika_races, zika_full)
