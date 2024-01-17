knitr::opts_chunk$set(message = FALSE, warning = FALSE)

library(tidyverse)
library(here)
data_gis_final <- read.csv(url("https://raw.githubusercontent.com/jlschnatz/PsyBSc8_Diagnostik/main/src/data/data-gis-final.csv"))
glimpse(data_gis_final)

library(sjPlot)
sjt.itemanalysis(
  df = data_gis_final, 
  factor.groups.titles = NULL # kein Titel
  ) 

# Base
eigen(cor(data_gis_final))$values 
# Alternative Schreibweise (mit pipes):
cor(data_gis_final) %>% 
  eigen() %>% 
  chuck("values") 
# in Tabellenform:
cor(data_gis_final) %>% 
  eigen() %>% 
  chuck("values") %>% 
  as_tibble() %>% 
  rename(Eigenvalue = value) %>% 
  tab_df(
    title = "Eigenwertverlauf",
    col.header = "Eigenwert",
    show.rownames = TRUE
    )

library(FactoMineR)
pca <- PCA(data_gis_final, graph = FALSE) 
eigen <- as_tibble(pca$eig) # als dataframe abspeichern
eigen <- as_tibble(pca[["eig"]]) # Alternative
# in Tabellenform:
tab_df(
  x = eigen,
  show.rownames = TRUE,
  title = "Eigenwertverlauf mit zusätzlicher Information hinsichtlich erklärte Varianz",
  col.header  = c("Eigenwert", "Erklärte Varianz", "Kum. erklärte Varianz")
  ) 

library(psych)
scree(
  rx = data_gis_final, 
  factors = TRUE,
  pc = FALSE, # sollen Hauptkomponenten auch dargestellt werden?
  hline = 1 # Plot mit Knicklinie, hline = -1 -> ohne Linie
  ) 

data_eigen <- tibble(
  Eigenwert = eigen(cor(data_gis_final))$values,
  Faktor = 1:length(Eigenwert)
)
# Basis-ggplot Layer
ggplot(data = data_eigen, aes(x = Faktor, y = Eigenwert)) + 
  # Horizontale Linie bei y = 1
   geom_hline(
    color = "darkgrey", 
    yintercept = 1,
    linetype = "dashed" 
    ) +
  # Hinzufügen der Linien
  geom_line(alpha = 0.6) + 
  # Hinzufügen der Punkte
  geom_point(size = 3) +
  # Achsenveränderung der y-Achse
  scale_y_continuous(
    breaks = seq(0, 10, 2),
    limits = c(0, 10),
    expand = c(0, 0)
  ) +
  # Achsenveränderung der x-Achse
  scale_x_continuous(
    breaks = seq(1, 17),
    limits = c(1, 17)
  ) +
  # Theme
  theme_classic() + 
  theme(axis.title = element_text(face = "bold"))

fa.parallel(
  x = data_gis_final, 
  fm = "pa", # Principal Axis Factoring Extraktion
  fa = "both", # FA + PCA
  n.iter = 500, # Anzahl der Simulationen
  quant = .95, # Vergleichsintervall
  main = "Parallelanalyse mittels Base R und psych-Package"
  )

data_pa <- fa.parallel(
  x = data_gis_final, 
  fm= "pa", 
  fa = "fa", 
  plot = FALSE,
  n.iter = 500,
  quant = .95
  )
# Dataframe
tibble(
  Observed = data_pa$fa.values, # empirisch
  Simulated = data_pa$fa.sim    # simuliert
) %>% 
  # Zeilennummer als eigene Variable
  rownames_to_column(var = "Factor") %>% 
  mutate(Factor = as.integer(Factor)) %>% 
  # Wide-Format in Long-Format
  pivot_longer(
    cols = -Factor,
    names_to = "obs_sim",
    values_to = "Eigenvalue"
    ) %>% 
  ggplot(aes(x = Factor, y = Eigenvalue, color = obs_sim)) + 
  geom_line(
    size = 0.7,
    alpha = .8
    ) + 
  geom_point(
    size = 3.5,
    alpha = .8
    ) + 
  scale_y_continuous(
    breaks = seq(0, 9, 3),
    limits = c(-.5, 9),
    expand = c(0, 0)
  ) + 
  scale_x_continuous(
    breaks = seq(1, 17),
    limits = c(0, 17),
    expand = c(0, 0)
  ) +
  scale_color_manual(
    name = NULL,
    values = c("#1D3554", "#DFE07C")
    ) +
  coord_cartesian(clip = "off") + 
  theme_light() + 
  theme(legend.position = "bottom")
  

tab_fa(
  data = data_gis_final,
  nmbr.fctr = 3, 
  rotation = "oblimin", 
  fctr.load.tlrn = 0, 
  method = "pa",
  title = "Faktorenanalyse",
  )

drop_facload1 <- c("GIS6","GIS11")
data_gis_fa1<- select(data_gis_final, -all_of(drop_facload1))
tab_fa(
  data = data_gis_fa1, 
  nmbr.fctr = 3,
  rotation = "oblimin", 
  fctr.load.tlrn = 0, 
  method = "pa",
  title = "Finale Faktorenanalyse"
  )

fa_index <- tab_fa(
  data = data_gis_fa1, 
  nmbr.fctr = 3, 
  rotation = "oblimin", 
  fctr.load.tlrn = 0, 
  method = "pa"
  ) %>% 
  pluck("factor.index")
sjt.itemanalysis(
  df = data_gis_fa1, 
  factor.groups = fa_index, 
  factor.groups.titles = c("Faktor 1","Faktor 2","Faktor 3")
  )

index <- as.data.frame(fa_index) %>% 
  rownames_to_column(var = "item") 
f1_names <- pull(filter(index, fa_index == 1), item)
f2_names <- pull(filter(index, fa_index == 2), item)
f3_names <- pull(filter(index, fa_index == 3), item)
# Funktionsinput: Dataframe & Vektor der Variablennamen des jeweiligen Faktors
get_reliability <- function(.data, .var_names) {
  om <- omega(select(.data, all_of(.var_names)), plot = FALSE)
  out <- list(
    omega = om$omega.tot, 
    alpha = om$alpha
  )
  # Angabe, welche Objekte ausgegeben werden sollen
  return(out)
}
 
get_reliability(data_gis_fa1, f1_names)
get_reliability(data_gis_fa1, f2_names)
get_reliability(data_gis_fa1, f3_names)

data_gis_fa1 <- data_gis_fa1 %>% 
  rowwise() %>% 
  mutate(gis_score = sum(c_across(everything()))) %>% 
  mutate(
    f1 = sum(c_across(all_of(f1_names))),
    f2 = sum(c_across(all_of(f2_names))),
    f3 = sum(c_across(all_of(f3_names))),
    ) 

tab_df(describe(data_gis_fa1$f1))
tab_df(describe(data_gis_fa1$f2))
tab_df(describe(data_gis_fa1$f3))

library(ggh4x)
ggplot(data_gis_fa1, aes(x = gis_score)) +  # oder x = f1/f2/f3
  geom_histogram(
    binwidth = 3,
    fill = "lightgrey",
    ) +
  stat_theodensity(
    mapping = aes(y = after_stat(count)), 
    distri = "norm", 
    color = "darkblue",
    size = 0.5
    ) +
  scale_x_continuous(
    name = "GIS Score",
    limits = c(0, 80), # Achsenlimit
    breaks = seq(0, 80, 10), # Achsenabschnitte
    expand = c(0, 0)
    ) +
  scale_y_continuous(
    name = "Frequency",
    limits = c(0, 60),
    breaks = seq(0, 60, 10),
    expand = c(0, 0)
  ) +
  theme_light()

library(ggh4x)
strip_labels <- as_labeller(c(f1 = "Factor 1", f2 = "Factor 2",
                              f3 = "Factor 3", gis_score = "Gesamtscore"))
data_gis_fa1 %>% 
  select(f1, f2, f3, gis_score) %>% 
  pivot_longer(
    cols = everything(),
    names_to = "factor",
    values_to = "score"
    ) %>% 
  ggplot(aes(x = score, fill = factor)) + 
  facet_wrap(
    facets  = vars(factor), 
    labeller = strip_labels,
    scales = "free" 
    )  +
  geom_histogram(
    bins = 30,
    alpha = 0.7,
    show.legend = FALSE
  ) +
  stat_theodensity(aes(y = after_stat(count), color = factor)) +
  facetted_pos_scales(
    x = list(
      factor == "f1" ~ scale_x_continuous(limits = c(0, 30)),
      factor == "f2" ~ scale_x_continuous(limits = c(0, 30)),
      factor == "f3" ~ scale_x_continuous(limits = c(0, 30)),
      factor == "gis_score" ~ scale_x_continuous(limits = c(0, 80))
      )
    ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 70),
    breaks = seq(0, 70, 10)
    ) +
  scale_x_continuous(expand = c(0, 0)) +
  coord_cartesian(clip = "off") +
  xlab("Score") + 
  ylab("Frequency") +
  scale_fill_manual(values=c("#68768cFF","#d4d47bFF","#e87261FF","#6d9388FF")) +
  scale_colour_manual(values=c("#293d5cFF","#c1c243FF","#e73e26FF","#2e6657FF")) +
  guides(color = "none", fill = "none") +
  theme_light() + 
  theme(
    panel.spacing = unit(.35, "cm"),
    axis.title = element_text(face = "bold"),
    strip.text = element_text(
      face = "bold", 
      color = "black",
      margin = margin(b = 5)),
    strip.background = element_rect(fill = "white")
    )
