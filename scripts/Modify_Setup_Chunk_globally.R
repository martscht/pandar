# Required libraries
library(stringr)
library(knitr)

# Function to modify the Rmd files
modify_rmd_files <- function(base_folder) {
  # List all .Rmd files in the base_folder and subdirectories
  rmd_files <- list.files(base_folder, pattern = "\\.Rmd$", full.names = TRUE, recursive = TRUE)
  
  for (file in rmd_files) {
    cat("Processing:", file, "\n")
    
    # Read the file
    lines <- readLines(file)
    
    # Define the new code block
    new_lines <- c(
      "if (exists(\"figure_path\")) {",
      "  knitr::opts_chunk$set(fig.path = figure_path)",
      "}"
    )
    
    # Check if the entire if-block already exists as a contiguous block
    full_if_block_pattern <- paste(new_lines, collapse = "\n")
    if (str_detect(paste(lines, collapse = "\n"), fixed(full_if_block_pattern))) {
      cat("Skipping modification for:", file, "since the full 'if' block already exists.\n")
      next  # Skip this file
    }
    
    # Find if a standalone knitr::opts_chunk$set(fig.path) exists
    existing_knitr_line <- grep("knitr::opts_chunk\\$set\\(fig.path", lines)
    
    if (length(existing_knitr_line) > 0) {
      # Check if the existing line is already inside an if-block
      if (existing_knitr_line > 1 && grepl("^if \\(exists\\(\"figure_path\"\\) \\) \\{", lines[existing_knitr_line - 1])) {
        cat("Skipping modification for:", file, "since knitr::opts_chunk$set is already inside an 'if' block.\n")
        next  # Skip modification
      }
      
      # Replace old knitr::opts_chunk$set(fig.path) with the full if block
      cat("Replacing old knitr::opts_chunk$set statement in:", file, "\n")
      lines <- append(lines[-existing_knitr_line], new_lines, after = existing_knitr_line[1] - 1)
    } else {
      # Find setup chunk
      setup_chunk_start <- grep("^```\\{r setup", lines)
      
      if (length(setup_chunk_start) > 0) {
        for (start in setup_chunk_start) {
          # Insert the new block after the setup chunk if no old setting exists
          lines <- append(lines, new_lines, after = start)
        }
      }
    }
    
    # Write the modified content back to the file
    writeLines(lines, file)
    cat("Modified successfully.\n")
  }
}

# Run the function with your base folder path
base_folder <- "content"  
modify_rmd_files(base_folder)
