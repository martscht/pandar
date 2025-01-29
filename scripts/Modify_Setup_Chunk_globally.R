# Required libraries
library(stringr)
library(knitr)

# Function to modify the Rmd files
modify_rmd_files <- function(base_folder) {
  # List all .Rmd files in the base_folder and subdirectories
  rmd_files <- list.files(base_folder, pattern = "\\.Rmd$", full.names = TRUE, recursive = TRUE)
  
  for (file in rmd_files) {
    cat("Modifying:", file, "\n")
    
    # Read the file
    lines <- readLines(file)
    
    # Find the line number where the setup chunk begins
    setup_chunk_start <- grep("^```\\{r setup", lines)
    
    if (length(setup_chunk_start) > 0) {
      # Add the knitr setting after the setup chunk
      for (start in setup_chunk_start) {
        # Check if the next line after setup is already what we want
        if (!any(str_detect(lines[(start + 1)], "knitr::opts_chunk\\$set\\(fig.path"))) {
          # Find the next chunk closure
          chunk_end <- grep("^```", lines[(start + 1):length(lines)]) + start
          
          # Insert the new line after the setup chunk
          lines <- append(lines, "knitr::opts_chunk$set(fig.path = figure_path)", after = start)
        }
      }
      
      # Write the modified content back to the file
      writeLines(lines, file)
      cat("Modified successfully.\n")
    }
  }
}

# Run the function with your base folder path
base_folder <- "content"  
modify_rmd_files(base_folder)