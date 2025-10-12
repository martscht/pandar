download.file('https://osf.io/download/tezca/', destfile = paste0(tempdir(), '/polar.xlsx'))
polar <- readxl::read_xlsx(paste0(tempdir(), '/polar.xlsx'))

polar$coercion <- polar$reallife_1
polar$policies <- rowMeans(polar[, c('sub_C_1', 'sub_C_2', 'sub_C_3')], na.rm = TRUE)
polar$mentality <- rowMeans(polar[, c('CMs_1', 'CMs_2', 'CMs_3', 'CMs_4', 'CMs_5')], na.rm = TRUE)
polar$beliefs <- rowMeans(polar[, c('CBs_1', 'CBs_2', 'CBs_3', 'CBs_4', 'CBs_5')], na.rm = TRUE)
polar$conviction <- rowMeans(polar[, c('Polar_1', 'Polar_2', 'Polar_3')], na.rm = TRUE)
polar$moralization <- rowMeans(polar[, c('Polar_4', 'Polar_5', 'Polar_6')], na.rm = TRUE)
polar$conflict <- rowMeans(polar[, c('Polar_7', 'Polar_8', 'Polar_9')], na.rm = TRUE)
polar$polar <- rowMeans(polar[, c('conviction', 'moralization', 'conflict')], na.rm = TRUE)
polar$vaccine <- factor(polar$Vac, levels = c(-1, 1), labels = c('no', 'yes'))
polar$gender <- factor(polar$Gen, levels = c(-1, 0, 1), labels = c('male', 'other', 'female'))
polar$country <- as.factor(polar$Country)
polar$age <- as.numeric(polar$Age)

polar <- polar[, c('country', 'age', 'gender', 'vaccine', 'coercion', 'policies', 'mentality', 'beliefs', 'conviction', 'moralization', 'conflict', 'polar')]

