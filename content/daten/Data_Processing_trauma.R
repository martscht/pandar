#### Haven laden ----
if (!require(haven)) install.packages('haven')

##### Daten laden
trauma <- read_dta(url("https://osf.io/a9vun/download")) |> as.data.frame()

##### Daten aufbereiten
# Columns 168 bis 247 enthalten die LEC Daten also ersetzen wir dort NA mit 0
trauma[, 168:247][is.na(trauma[, 168:247])] <- 0

trauma_tmp <- trauma[, FALSE]

trauma_tmp$sexual_assault <- if_else(trauma$lec8_1 == 1, 1, 0) 
  
# Zusammenfassung der LEC Items in f?nf Gruppen
# 1. sexuelle Gewalt (lec8, lec9 & lec11); 2. physische Gewalt (lec6, lec7 & lec14)
# 3. Schwere Krankheit  (lec12, lec13 & lec15); 4. Schwere Unfaelle (lec2, lec3, lec4 & lec5)
# 5. Krieg / Naturkatastrophen (lec10, lec16 & lec1); 0. kein Traumata
trauma_tmp$trauma_exp_kind <- with(trauma, 
  if_else(lec8_1 == 1 | lec8_2 == 1 | 
      lec9_2 == 1 | 
      lec11_1 == 1 | lec11_2 == 1, 'sexuelle Gewalt',
    if_else(lec6_1 == 1 | lec6_2 == 1 | 
        lec7_1 == 1 | lec7_2 == 1 | 
        lec14_1 == 1 | lec14_2 == 1, 'physische Gewalt',
      if_else(lec12_1 == 1 | lec12_2 == 1 | 
          lec13_1 == 1 | lec13_2 == 1 | 
          lec15_1 == 1 | lec15_2 == 1, 'schwere Krankheit',
        if_else(lec2_1 == 1 | lec2_2 == 1 | 
            lec3_1 == 1 | lec3_2 == 1 | 
            lec4_1 == 1 | lec4_2 == 1 | 
            lec5_1 == 1 | lec5_2 == 1, 'schwere Unfälle',
          if_else(lec10_1 == 1 | lec10_2 == 1 | 
              lec16_1 == 1 | lec16_2 == 1 |
              lec1_1 == 1 | lec1_2 == 1, 'Krieg/Naturkatastrophen', 'keine Traumata'))))))
trauma_tmp$trauma_exp_kind <- as.factor(trauma_tmp$trauma_exp_kind)
trauma$trauma_exp_kind <- as.numeric(trauma_tmp$trauma_exp_kind)
  # Variable f?r Form des LEC Erlebens
  # indirect experience = Person hat es gesehen / mitbekommen
  # direct experience = Person hat es selbst erfahren
  # no experience = Person hat kein traumatisches Erlebnis
  # Gruppen werden mit Trauma Art im Kombi mit den spezifischen Items gebildet, um die richtige Zuordnung zu gewhren 
trauma_tmp$trauma_exp_form <- with(trauma, 
  if_else(trauma_tmp$trauma_exp_kind == 1 & (lec8_1 == 1 | lec11_1 == 1 ) | 
      trauma_tmp$trauma_exp_kind == 2 & (lec6_1 == 1 | lec7_1 == 1 | lec14_1 == 1 ) |
      trauma_tmp$trauma_exp_kind == 4 & (lec2_1 == 1 | lec3_1 == 1 | lec4_1 == 1 | lec5_1 == 1 ) |
      trauma_tmp$trauma_exp_kind == 3 & (lec12_1 == 1 | lec13_1 == 1 | lec15_1 == 1 ) |
      trauma_tmp$trauma_exp_kind == 5 & (lec10_1 == 1 | lec16_1 == 1 | lec1_1 == 1 ), "direct experience",
    if_else(trauma_tmp$trauma_exp_kind == 1 & (lec8_2 == 1 | lec9_2 == 1 |lec11_2 == 1) | 
        trauma_tmp$trauma_exp_kind == 2 & (lec6_2 == 1 | lec7_2 == 1 | lec14_2 == 1) |
        trauma_tmp$trauma_exp_kind == 3 & (lec12_2 == 1 | lec13_2 == 1 | lec15_2 == 1) |
        trauma_tmp$trauma_exp_kind == 4 & (lec2_2 == 1 | lec3_2 == 1 | lec4_2 == 1 | lec5_2 == 1) |
        trauma_tmp$trauma_exp_kind == 5 & (lec10_2 == 1 | lec16_2 == 1 | lec1_2 == 1), "indirect experience", "no experience"))) 
trauma_tmp$trauma_exp_form <- as.factor(trauma_tmp$trauma_exp_form)

trauma_tmp$gender <- trauma$d2gen # 0 = Frau / 1 = Mann
trauma_tmp$gender <- ifelse(test = trauma_tmp$gender == 0, "w", "m") |> as.factor()
trauma_tmp$sas <- trauma$SAS_ttl_w_reversecoded5_9_13_17_ # Anxiety Werte, theoretische Range 20 - 80
trauma_tmp$bdi <- trauma$bdi_ttl # Depressions Werte, theoretische Range 0 - 63
trauma_tmp$sas_group <- trauma$sas_grp # Anxiety Einordnung 1 normal, 2 mild to mod, 3 mod to severe, 4 severe
trauma_tmp$bdi_group <- trauma$bdi_grp # Depressions Einordnung 1 normal, 2 mild to mod, 3 mod to severe, 4 severe
trauma_tmp$future <- trauma$future_mean # Einstellungen gegenüber der Zukunft
trauma_tmp$past_neg <- trauma$p_neg_mean # negative Erinnerungen an die Vergangenheit
trauma_tmp$dissociation <- trauma$desc_total # Dissoziation: Betroffen von dissoziativer Abspaltung sind meist die Bereiche 
# Wahrnehmung, Bewusstsein, Gedächtnis, Identität und Motorik, aber manchmal auch Körperempfindungen (etwa Schmerz und Hunger)

trauma <- trauma_tmp

trauma <- na.omit(trauma)
rm(trauma_tmp)
#### DISCLAIMER
# Mehrfach Traumata wurden in diesem Fall ignoriert und die Personen dem ersten abgefragten traumatischen Erlebnis zu geteilt. 
# Ebenso wurden die Gruppen nur auf Basis von Item?hnlichkeit gebildet und nicht basierend auf empirischen Erkenntnissen.
# Das ist keine Grundlage f?r empirisch valide Forschung, sondern gilt einzig der Vereinfachung der Uebungsrechnung