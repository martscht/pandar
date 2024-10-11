# Daten einlesen
if (!require(haven)) install.packages('haven')
coercion <- haven::read_sav('https://osf.io/download/pmfd7/')

# Require variables:
  # Age
  # Sex
  # Factor1 (F1 Psychopathy)
  # Factor2 (F2 Psychopathy)
  # Maso (Masochistic sexual fantasies)
  # Sad (Sadistic sexual fantasies)
  # SexDrive
  # need to create coecion and coaxing based only on likelihood

tmp_coercion <- coercion[, paste0('TOSS_LIK_', c(2, 3, 5, 6, 8, 9, 11, 12, 13, 16, 17, 18, 23, 24, 26, 27, 28, 29, 31), '_1')]
coercion$coerce <- rowSums(round(tmp_coercion))

tmp_coercion <- coercion[, paste0('TOSS_LIK_', c(1, 4, 7, 10, 14, 15, 19, 20, 21, 22, 25, 30), '_1')]
coercion$coax <- rowSums(round(tmp_coercion))

coercion <- subset(coercion, 
  select = c('Age', 'Sex', 'Factor1', 'Factor2', 'Maso', 'Sad', 'SexDrive', 'coerce', 'coax'))
coercion$Age <- as.numeric(coercion$Age)
coercion$Sex <- factor(coercion$Sex, levels = c(1, 2), labels = c('Male', 'Female'))
coercion[, 3:ncol(coercion)] <- lapply(coercion[, 3:ncol(coercion)], as.numeric)

names(coercion) <- c('age', 'sex', 
  'f1', 'f2', 'maso', 'sadi', 'drive', 'coerce', 'coax')
coercion <- as.data.frame(coercion)

rm(tmp_coercion)