# Lädt Daten von Categorise_Dependencies gesammelt
pkg_df <- read.csv("scripts/dependencies_categorised.csv")
# Filtert die Packages die in der Version verfügbar sind
install_list <- unique(pkg_df[pkg_df[[3]],]$Package)
# Installiert Packages, die noch nicht installiert sind
install.packages(setdiff(install_list, installed.packages()[, "Package"]))
