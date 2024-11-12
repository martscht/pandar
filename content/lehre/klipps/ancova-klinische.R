## source('https://pandar.netlify.app/daten/Data_Processing_cope.R')


# Ethnizität
ethnicity <- aggregate(cope[, grep('race_', names(cope))], by = list(cope$condition), FUN = sum)
names(ethnicity) <- c('condition', 'Native', 'Asian', 'Hispanic', 'Pacific Islander', 'White', 'Black', 'Other', 'Prefer not to say')
ethnicity

# Geschlecht
gender <- aggregate(cope[, grep('gender_', names(cope))], by = list(cope$condition), FUN = sum)
names(gender) <- c('condition', 'agender', 'not sure', 'other', 'androgynous', 'nonbinary', 'two spirited', 'Trangender female to male', 'trans female', 'trans male', 'Gender expansive', 'Third gender', 'Genderqueer', 'Transgender male to female', 'Man', 'Woman')
gender

# Biologisches Geschlecht
table(cope$sex, cope$condition)

# Sexuelle Orientierung
table(cope$orientation, cope$condition)

# Baseline CDI
psych::describeBy(cope$CDI1*12, cope$condition)

# Akzeptanz
pfs <- subset(cope, select = c('condition', grep('pfs_', names(cope), value = TRUE))) |> na.omit()
describeBy(pfs, pfs$condition)


dropouts <- table(cope$condition, cope$dropout1)
dropouts
prop.table(dropouts, margin = 1)
chisq.test(dropouts)

# Datenauswahl zur Dropout-Vorhersage
drop_dat <- cope[, c('dropout1', grep('^gender', names(cope), value = TRUE),
    grep('^race', names(cope), value = TRUE),
    'age', 'CDI1', 'CTS1', 'GAD1', 'SHS1', 'BHS1', 'DRS1')]

# Vorhersage von Dropout mit logistischer Regression
drop_mod <- glm(dropout1 ~ ., drop_dat, family = 'binomial')

summary(drop_mod)



# Vorgesagte Werte
cope$dropout_pred <- predict(drop_mod, cope, type = 'response') > .5
cope$dropout_pred <- factor(cope$dropout_pred, labels = c('remain', 'dropout'))

# Confusion Matrix
caret::confusionMatrix(cope$dropout_pred, cope$dropout1)

locf <- cope

# LOCF, post-intervention
locf$SHS2 <- ifelse(is.na(locf$SHS2), locf$SHS1, locf$SHS2)
locf$BHS2 <- ifelse(is.na(locf$BHS2), locf$BHS1, locf$BHS2)

# LOCF, follow-up
locf$CDI3 <- ifelse(is.na(locf$CDI3), locf$CDI1, locf$CDI3)
locf$CTS3 <- ifelse(is.na(locf$CTS3), locf$CTS1, locf$CTS3)
locf$GAD3 <- ifelse(is.na(locf$GAD3), locf$GAD1, locf$GAD3)
locf$SHS3 <- ifelse(is.na(locf$SHS3), locf$SHS2, locf$SHS3)
locf$BHS3 <- ifelse(is.na(locf$BHS3), locf$BHS2, locf$BHS3)
locf$DRS3 <- ifelse(is.na(locf$DRS3), locf$DRS1, locf$DRS3)

# ANOVA model
mod1a <- lm(CDI3 ~ condition, cope)

# Einfache ANCOVA, Primäres Outcome
mod1b <- lm(CDI3 ~ CDI1 + condition, cope)

# Ergebniszusammenfassung
summary(mod1a)$coef
summary(mod1b)$coef
