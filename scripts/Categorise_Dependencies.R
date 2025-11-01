#### Parameter ----
root <- "content"
output_file <- "dependencies_categorised.csv"

#### Hilfsfunktionen ----

get_subfolders <- function(path) {
  dirs <- list.dirs(path, recursive = F, full.names = T)
  dirs[file.info(dirs)$isdir]
}

get_rmd <- function(path) {
  list.files(path, pattern = "\\.Rmd$", recursive = T, full.names = T)
}

package_extract <- function(filepath) {
  lines <- readLines(filepath, warn = F)
  
  # library() und require() identifizieren
  lib_matches <- regmatches(
    lines,
    gregexpr("\\b(library|require)\\s*\\(\\s*([A-Za-z0-9\\.]+)", lines, perl = TRUE)
  )
  # Package Name extrahieren
  lib_calls <- unlist(lapply(lib_matches, function(x) {
    gsub(".*\\b(library|require)\\s*\\(\\s*([A-Za-z0-9\\.]+).*", "\\2", x)
  }))
  
  # Selbiges für :: und ::: package-calls
  ns_matches <- regmatches(
    lines,
    gregexpr("([A-Za-z0-9\\.]+)(?=:::|::)", lines, perl = TRUE)
  )
  ns_calls <- unlist(ns_matches)
  
  # Filtern für einzigartige Calls
  unique(c(lib_calls, ns_calls))
}

get_subfolder_packages <- function(folder) {
  rmd_files <- get_rmd(folder)
  if (length(rmd_files) == 0) {
    return(character(0))
  }
  unique(unlist(lapply(rmd_files, package_extract)))
}



#### Main ----

subfolders <- get_subfolders(root)
results <- lapply(subfolders, get_subfolder_packages)
names (results) <- basename(subfolders)

pkg_df <- do.call(rbind, lapply(names(results), function(name) {
  pkgs <- results[[name]]
  if (length(pkgs) == 0) {
    return(NULL)
  }
  data.frame(subfolder = name, package = sort(pkgs), stringsAsFactors = F)
}))



#### Output ----
if (is.null(pkg_df) || nrow(pkg_df) == 0) {
  cat("No packages found in any subfolder.\n")
} else {
  cat("Packages found per subfolder:\n\n")
  for (name in unique(pkg_df$subfolder)) {
    cat("•", name, "→", paste(pkg_df$package[pkg_df$subfolder == name], collapse = ", "), "\n")
  }
  
  if (!is.null(output_file)) {
    write.csv(pkg_df, output_file, row.names = FALSE)
    cat("\nPackage summary saved to:", output_file, "\n")
  }
}

file.path(getwd(), output)