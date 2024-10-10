####    Datenvorbereitung   ####
#### Logistische Regression ####
# Daten aus Lin et al., https://doi.org/10.1016/j.jad.2023.02.148


# Daten einlesen
if (!require(haven)) install.packages('haven')
grit <- haven::read_sav(url('https://osf.io/download/6d5gj/'))

# Datenaufbereitung 
  # Siehe auch https://osf.io/gfh4u

# Auswahl
grit <- with(grit, data.frame(Suicide_Cat, ARS_tot, RSSTotal, IPC_Internal, IPC_External, GritTotal, Age, Sex, Employment, Marital, SES, Orient))
grit$Orient[is.na(grit$Orient)] <- 4
grit <- grit[complete.cases(grit), ]

# Variablenbenennung
names(grit) <- c('Suicide', 'ARS', 'RSS', 'ILOC', 'ELOC', 'Grit', 'Age', 'Sex', 'Employment', 'Marital', 'SES', 'Orientation')

# Nominale Kategorien
grit$Suicide <- factor(grit$Suicide, levels = c("0", "1", "2"), labels = c("None", "Ideator", "Attempter")) 
grit$Sex <- factor(grit$Sex, levels = c('0', '1', '7'), labels = c('Female', 'Male', 'Other'))
grit$Employment <- factor(grit$Employment, levels = c('1', '2', '3'), labels = c('Unemployed', 'Part-Time', 'Full-Time'))
grit$Marital <- factor(grit$Marital, levels = 1:5, labels = c('Never Married', 'Actively Married',
  'Not Actively Married', 'Divorced', 'Widowed'))
grit$SES <- factor(grit$SES, levels = 1:6, labels = names(attributes(grit$SES)$labels))
grit$Orientation <- factor(grit$Orientation, levels = 1:4, labels = c('Heterosexual', 'Homosexual', 'Bisexual', 'Other/Missing'))
