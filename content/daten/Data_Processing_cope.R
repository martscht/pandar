# Load data
cope_raw <- readRDS(url('https://osf.io/download/r68xj/'))

# Include only people assigned to a condition
cope_raw <- cope_raw[!is.na(cope_raw$condition),]

# Build new dataset beginning with ethnicity
cope <- cope_raw[, grep('^b_dem_race_', names(cope_raw))]
cope <- cope[, !grepl('_7_text', names(cope)) & !grepl('_race_na$', names(cope))]
names(cope) <- gsub('^b_dem_', '', names(cope))

# Add gender identity
cope_tmp <- cope_raw[, grep('^b_dem_gender_', names(cope_raw))]
cope_tmp <- cope_tmp[, !grepl('_16_text', names(cope_tmp)) & !grepl('_gender_na', names(cope_tmp))]
names(cope_tmp) <- gsub('^b_dem_', '', names(cope_tmp))
cope <- cbind(cope, cope_tmp)

# Add biological gender
cope$sex <- cope_raw$b_dem_sex

# Add age
cope$age <- cope_raw$b_screener_age

# Add sexual orientation
cope$orientation <- cope_raw$b_dem_orientation

# Add condition
cope <- data.frame(condition = cope_raw$condition, cope)
cope$condition <- factor(cope$condition, levels = c(0, 1, 2), labels = c('Placebo Control', 'Project Personality', 'Project ABC'))

# Relevant outcomes
  # CDI: Children's Depression Inventory
  # CTS: COVID Trauma Symptoms
  # GAD: Generalized Anxiety Disorder
  # SHS: State Hope Scale, Perceived Agency Subscale
  # BHS: Beck Hopelessness Scale
# PFS: Program Feedback Scale (items see Tab. 2)
cope$CDI1 <- cope_raw$b_cdi_mean
cope$CDI3 <- cope_raw$f1_cdi_mean
cope$CTS1 <- cope_raw$b_cts_rs_mean
cope$CTS3 <- cope_raw$f1_cts_rs_mean
cope$GAD1 <- cope_raw$b_gad_mean
cope$GAD3 <- cope_raw$f1_gad_mean
cope$SHS1 <- cope_raw$b_shs_mean
cope$SHS2 <- cope_raw$pi_shs_mean
cope$SHS3 <- cope_raw$f1_shs_mean
cope$BHS1 <- cope_raw$b_bhs_mean
cope$BHS2 <- cope_raw$pi_bhs_mean
cope$BHS3 <- cope_raw$f1_bhs_mean
cope$DRS1 <- cope_raw$b_drs_mean
cope$DRS3 <- cope_raw$f1_drs_mean


cope_tmp <- cope_raw[, grep('^b_pfs_', names(cope_raw))]
cope_tmp <- cope_tmp[, !grepl('_mean', names(cope_tmp))]
names(cope_tmp) <- gsub('^b_', '', names(cope_tmp))
cope <- cbind(cope, cope_tmp)

# Add dropout
cope$dropout1 <- is.na(cope_raw$b_pfs_1) |> as.numeric() |> factor(levels = c(0, 1), labels = c('remain', 'dropout'))
cope$dropout2 <- is.na(cope_raw$f1_cdi_1) |> as.numeric() |> factor(levels = c(0, 1), labels = c('remain', 'dropout'))

# remove additional datasets
rm(cope_raw, cope_tmp)
