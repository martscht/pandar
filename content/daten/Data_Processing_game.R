# load data
game <- read.csv('https://osf.io/download/nkxpj/', sep = ';', dec = ',',
  na.strings = c('na', 'nr'))

# use names from OSF
names(game) <- c("id", "short_citation", "id_of_study", "id_of_es", "n_treatment_as",
  "n_control_as", "n_treatment_ob", "n_control_ob", "es", "v",
  "es_based_on", "dv_name", "dv_type", "tr_name", "tr_type",
  "ct_name", "ct_type", "age_m_tr", "age_m_ct", "male_per", 
  "edu_tr", "edu_ct", "income_tr", "income_ct", "ses_n",
  "ses_dur", "ses_w", "ses_tot", "followup_w", "comorb_scr",
  "comorb_samp", "comorb_crit", "diag_crit", "design", "country",
  "language", "peer_rev", "conf_intr", "year_pub", "corr_author",
  "corr_author_contact")

# in non-dplyr variant
game <- transform(game, 
  id = 1:nrow(game),
  followup_c = pmin(followup_w, 26) - 13,
  followup_long = as.numeric(followup_w > 26),
  permale_c = male_per - 50,
  study_dv = paste(id_of_study, dv_name, sep = "-"),
  study_ctype = paste(id_of_study, ct_type, sep = "-"),
  SE_v = sqrt(v))

game$tr_type[game$tr_type=="psychotherapy "] <- "psychotherapy"

game$tr_group <-
  factor(game$tr_type, levels = c(
    "Behavioral",
    "prevention",
    "school-based prevention program",
    "Parental program", "psychotherapy", 
    "family therapy", "psychotherapy + pharmacological",
    "Therapeutic camp + Parental program",
    "Brain stimulation", "Pharmacological",
    "physical exercise", "therapeutic camp"),
    labels = c('behavioral', rep('prevention', 2),
      rep('psychotherapy', 3),
      rep('other', 6)))

game$dv_group <- 
  factor(game$dv_name, levels = c("IAT", "K-IAT", "YIAT",
    "YIAS", "YIAS-K", 
    "DSM-5 score", "Video game problems (DSM-5)",
    "DSM-5 criteria", "IGDS9-SF", 
    "French version of Petry's 2014 IGD-scale. (Number of IDG-symptoms.)",
    "IGD criteria checklist",
    "CIAS", "GAST", "OGAS", "CSAS", "POGUS", "DGA-SF",
    "internet addiction self-diagnosis test",
    "number of addictive gamers",
    "AICA Self-Report",
    "Game dependecy", "KFN-CSAS-II",
    "Video game dependence test (TDV)",
    "Computer Gaming Addiction Invention"),
    labels = c(rep("IAT", 3),
      rep("YIAS", 2),
      rep("DSM-5", 6),
      rep("Other", 13)))

# retype Woelfling
game$short_citation[game$id %in% c(73, 74)] <- 'Woelfling et al. (2019)'

game <- data.frame(cite = game$short_citation,
  study = game$id_of_study,
  effect = game$id_of_es,
  tr_type = game$tr_group,
  ct_type = game$ct_type,
  dv_type = game$dv_group,
  es = game$es,
  v = game$v,
  tr_n_ob = game$n_treatment_ob,
  ct_n_ob = game$n_control_ob,
  follow = game$followup_w,
  male = game$male_per)
