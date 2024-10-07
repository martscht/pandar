######### Datenaufbereitungsskript von Max Angres und Julien P. Irmer

##### Libraries
library(haven) # Ermoeglicht das Laden von Datenssaetzen mit anderen Formaten
library(dplyr) # Vereinfacht das Selektieren und Sortieren von Variablen


##### Daten laden
# laden der dta Daten mit haven function read_dta()
data = read_dta(url("https://osf.io/a9vun/download"))


# Daten muessen f?r weitere Bearbeitung in Dataframe umgewandelt werden
data = as.data.frame(data)


##### Daten aufbereiten
# Herausfinden in welchen Columns die LEC Daten sind
# diese sind entweder mit 1 oder NA gef?llt. NA steht in diesem Fall f?r nicht zutreffend also 0
which(colnames(data) == "lec1_1")
which(colnames(data) == "lec16_5")
# Columns 168 bis 247 enthalten die LEC Daten also ersetzen wir dort NA mit 0
data[, 168:247][is.na(data[, 168:247])] <- 0

# Variable kreieren in der abgebildet wird, ob jemand sexuell missbraucht wurde
# mit der mutate() Funktion von dplyr kann man eine neue Variable kreieren, 
# deren Bedingungen mit if_else() festegelegt werden k?nnen
# in diesem Fall bekommt eine Person die sexuell missbraucht wurde eine 1 zugeteilt,
# falls sie das dazugeh?rigen Item (lec8_1) mit 1 ausgef?llt hat
# Ein Wert von 1 entspricht also der Erfahrung von sexueller Gewalt und 0 nicht
data <- data %>%
  mutate(sexual_assault = if_else(lec8_1 == 1, 1, 0)) %>% 
  
  # Variable f?r die Gruppierung des Trauma Erlebnisses nach Art
  # Zusammenfassung der LEC Items in f?nf Gruppen
  # 1. sexuelle Gewalt (lec8, lec9 & lec11); 2. physische Gewalt (lec6, lec7 & lec14)
  # 3. Schwere Krankheit  (lec12, lec13 & lec15); 4. Schwere Unfaelle (lec2, lec3, lec4 & lec5)
  # 5. Krieg / Naturkatastrophen (lec10, lec16 & lec1); 0. kein Traumata
  mutate(trauma_exp_kind = if_else(lec8_1 == 1 | lec8_2 == 1 | 
                                     lec9_2 == 1 | 
                                     lec11_1 == 1 | lec11_2 == 1, 1,
                                   if_else(lec6_1 == 1 | lec6_2 == 1 | 
                                             lec7_1 == 1 | lec7_2 == 1 | 
                                             lec14_1 == 1 | lec14_2 == 1, 2,
                                           if_else(lec12_1 == 1 | lec12_2 == 1 | 
                                                     lec13_1 == 1 | lec13_2 == 1 | 
                                                     lec15_1 == 1 | lec15_2 == 1, 3,
                                                   if_else(lec2_1 == 1 | lec2_2 == 1 | 
                                                             lec3_1 == 1 | lec3_2 == 1 | 
                                                             lec4_1 == 1 | lec4_2 == 1 | 
                                                             lec5_1 == 1 | lec5_2 == 1, 4,
                                                           if_else(lec10_1 == 1 | lec10_2 == 1 | 
                                                                     lec16_1 == 1 | lec16_2 == 1 |
                                                                     lec1_1 == 1 | lec1_2 == 1, 5, 0)))))) %>%
  
  # Variable f?r Form des LEC Erlebens
  # indirect experience = Person hat es gesehen / mitbekommen
  # direct experience = Person hat es selbst erfahren
  # no experience = Person hat kein traumatisches Erlebnis
  # Gruppen werden mit Trauma Art im Kombi mit den spezifischen Items gebildet, um die richtige Zuordnung zu gewhren 
  mutate(trauma_exp_form = if_else(trauma_exp_kind == 1 & (lec8_1 == 1 | lec11_1 == 1 ) | 
                                     trauma_exp_kind == 2 & (lec6_1 == 1 | lec7_1 == 1 | lec14_1 == 1 ) |
                                     trauma_exp_kind == 4 & (lec2_1 == 1 | lec3_1 == 1 | lec4_1 == 1 | lec5_1 == 1 ) |
                                     trauma_exp_kind == 3 & (lec12_1 == 1 | lec13_1 == 1 | lec15_1 == 1 ) |
                                     trauma_exp_kind == 5 & (lec10_1 == 1 | lec16_1 == 1 | lec1_1 == 1 ), "direct experience",
                                   if_else(trauma_exp_kind == 1 & (lec8_2 == 1 | lec9_2 == 1 |lec11_2 == 1) | 
                                             trauma_exp_kind == 2 & (lec6_2 == 1 | lec7_2 == 1 | lec14_2 == 1) |
                                             trauma_exp_kind == 3 & (lec12_2 == 1 | lec13_2 == 1 | lec15_2 == 1) |
                                             trauma_exp_kind == 4 & (lec2_2 == 1 | lec3_2 == 1 | lec4_2 == 1 | lec5_2 == 1) |
                                             trauma_exp_kind == 5 & (lec10_2 == 1 | lec16_2 == 1 | lec1_2 == 1), "indirect experience", "no experience"))) 



cor(data[, c("SAS_ttl_w_reversecoded5_9_13_17_", "p_neg_mean", "desc_total", "bdi_total")], use = "complete.obs")

gender <- data$d2gen # 0 = Frau / 1 = Mann
gender <- ifelse(test = gender == 0, "w", "m")
sas <- data$SAS_ttl_w_reversecoded5_9_13_17_ # Anxiety Werte, theoretische Range 20 - 80
bdi <- data$bdi_ttl # Depressions Werte, theoretische Range 0 - 63
sas_group <- data$sas_grp # Anxiety Einordnung 1 normal, 2 mild to mod, 3 mod to severe, 4 severe
bdi_group <- data$bdi_grp # Depressions Einordnung 1 normal, 2 mild to mod, 3 mod to severe, 4 severe
sexual_assault <- data$sexual_assault # Sexuelle ?bergriff 1 = ja / 0 = nein
trauma_exp_kind <- data$trauma_exp_kind # Art des Trauma Erlebnisses
# 1. sexuelle Gewalt; 2. physische Gewalt 3. Schwere Krankheit; 4. Schwere Unfaelle
# 5. Krieg / Naturkatastrophen; 0. kein Traumata 
trauma_exp_form <- data$trauma_exp_form # Form des Trauma Erlebnisse
# indirect experience = Person hat es vor Ort gesehen / mitbekommen
# direct experience = Person hat es selbst erfahren
# no experience = Person hat kein traumatisches Erlebnis
future <- data$future_mean # Einstellungen gegenüber der Zukunft
past_neg <- data$p_neg_mean # negative Erinnerungen an die Vergangenheit
dissociation <- data$desc_total # Dissoziation: Betroffen von dissoziativer Abspaltung sind meist die Bereiche 
# Wahrnehmung, Bewusstsein, Gedächtnis, Identität und Motorik, aber manchmal auch Körperempfindungen (etwa Schmerz und Hunger)

trauma_exp_kind[trauma_exp_kind == 1] <- "sexual"
trauma_exp_kind[trauma_exp_kind == 2] <- "physical"
trauma_exp_kind[trauma_exp_kind == 3] <- "disease"
trauma_exp_kind[trauma_exp_kind == 4] <- "accident"
trauma_exp_kind[trauma_exp_kind == 5] <- "warORnature"
trauma_exp_kind[trauma_exp_kind == 0] <- "none"
y <- c("none", unique(trauma_exp_kind)[-6]) # Sortieren, sodass "none" vorne steht 

data_trauma <- data.frame(gender, bdi, bdi_group, sas, sas_group, future, past_neg, dissociation, sexual_assault, trauma_exp_kind, trauma_exp_form)

# Vektor x f?r level f?r Faktorisierung von trauma_exp_form
x <- c("indirect experience", "direct experience", "no experience")

# Faktorisierung der Gruppenvariablen
data_trauma <- data_trauma %>%
  mutate(trauma_exp_form = factor(trauma_exp_form, levels = x)) %>%
  mutate(trauma_exp_kind = factor(trauma_exp_kind, levels = y))

# Faelle mit fehlenden Daten entferen
data_trauma <- na.omit(data_trauma)


### Final Data Set
trauma <- data_trauma

# delete temporal data
temps <- c("bdi", "bdi_group", "data", "data_trauma", "dissociation", "future",  "gender", "past_neg",
            "sas", "sas_group", "sexual_assault", "trauma_exp_form", "trauma_exp_kind", "x", "y", "temps") 
rm(list = temps) # nur noch der Datensatz trauma im Verzeichnis geladen


#### DISCLAIMER
# Mehrfach Traumata wurden in diesem Fall ignoriert und die Personen dem ersten abgefragten traumatischen Erlebnis zu geteilt. 
# Ebenso wurden die Gruppen nur auf Basis von Item?hnlichkeit gebildet und nicht basierend auf empirischen Erkenntnissen.
# Das ist keine Grundlage f?r empirisch valide Forschung, sondern gilt einzig der Vereinfachung der Uebungsrechnung


