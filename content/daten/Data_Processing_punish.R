#### Data preparation file for punishment severity evaluation ----
# for the paper see: https://onlinelibrary.wiley.com/doi/10.1111/ajsp.12509

punish <- foreign::read.spss('https://osf.io/4wypx/download', use.value.labels = TRUE,
  to.data.frame = TRUE)

punish <- punish[, c('culture_group', 'bribery_type', 'age', 'gender',
  'gains_everage', 'difficulties_everage', 'noticed_probability_everage',
  'punishment_probability_everage', 'punishment_severity_everage')]
names(punish) <- c('country', 'bribe', 'age', 'gender', 'gains', 'difficult', 
  'notice', 'probable', 'severe')

levels(punish$age) <- c(levels(punish$age), 'over 50')
punish$age[punish$age %in% c('51-60', '61-70', 'over 70')] <- 'over 50'
punish$age <- droplevels(punish$age)