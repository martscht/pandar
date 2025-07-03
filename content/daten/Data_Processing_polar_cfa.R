download.file('https://osf.io/download/tezca/', destfile = paste0(tempdir(), '/polar.xlsx'))
polar <- readxl::read_xlsx(paste0(tempdir(), '/polar.xlsx'))

polar$vaccine <- factor(polar$Vac, levels = c(-1, 1), labels = c('no', 'yes'))
polar$gender <- factor(polar$Gen, levels = c(-1, 0, 1), labels = c('male', 'other', 'female'))
polar$country <- as.factor(polar$Country)
polar$age <- as.numeric(polar$Age)

polar <- polar[, c('country', 'age', 'gender', 'vaccine', 
  paste0('reallife_', 1:3),
  paste0('CBs_', 1:5), paste0('Polar_', 1:9))]

names(polar) <- c('country', 'age', 'gender', 'vaccine', paste0('coercion', 1:3),
  paste0('belief', 1:5), paste0('convict', 1:3), paste0('moral', 1:3), paste0('conflict', 1:3))
