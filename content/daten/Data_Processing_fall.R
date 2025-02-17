#### Data preparation for meta-analysis quiz ----
if (!require("haven")) { install.packages("haven"); library(haven) }

kruisbrink <- read_stata('https://osf.io/download/r786b/') |> as.data.frame()

fall <- subset(kruisbrink, kruisbrink$arm_nr == 1 & kruisbrink$outcome_nr == 1,
  select = c('author', 'id_nr', 'quality', 'bodyawareness', 'holistic', 'meditation', 'discussion', 'dwithinversions_fu1', 'se_d_fu1', 'dwithinversions_fu2', 'se_d_fu2'))

names(fall) <- c('author', 'id', 'quality', 'bodyawareness', 'holistic', 'meditation', 'discussion', 'es_post', 'se_post', 'es_follow', 'se_follow')

rm(kruisbrink)
