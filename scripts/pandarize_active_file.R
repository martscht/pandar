library(rstudioapi)

apply_pandarize_to_active <- function(purl = FALSE, debugging = FALSE) {
  
  # Get the path of the active document
  active_doc <- getSourceEditorContext()$path
  
  # Debugging information
  if (debugging) {
    cat("Active document path:", active_doc, "\n")
  }
  
  # Check if the active document is a .Rmd file
  if (grepl("\\.Rmd$", active_doc)) {
    file_name <- tools::file_path_sans_ext(basename(active_doc))
    
    # Debugging information
    if (debugging) {
      cat("Applying pandarize to:", file_name, "with purl =", purl, "and debugging =", debugging, "\n")
    }
    
    # Apply pandarize with specified purl and debugging values
    tryCatch({
      pandarize(file_name, purl = purl, debugging = debugging)
      cat("Pandarize applied successfully to:", file_name, "\n")
    }, error = function(e) {
      cat("Error applying pandarize to:", file_name, "-", e$message, "\n")
    })
  } else {
    cat("The active document is not a .Rmd file.\n")
  }
}

# Example usage:
# Apply with default settings
apply_pandarize_to_active()

# Apply with purl = TRUE
apply_pandarize_to_active(purl = TRUE)

# Apply with debugging enabled
apply_pandarize_to_active(purl = TRUE, debugging = TRUE)
