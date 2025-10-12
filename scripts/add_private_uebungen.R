# Load necessary packages
library(yaml)
library(rstudioapi)

# Function to extract YAML header from an Rmd file
extract_yaml_header <- function(file_path) {
  lines <- readLines(file_path, warn = FALSE)
  
  if (length(lines) == 0 || !grepl("^---\\s*$", lines[1])) return(NULL)
  
  header_start <- which(lines == "---")[1]
  header_end <- which(lines == "---")[-1][1]
  
  if (is.na(header_start) || is.na(header_end) || header_start == header_end) return(NULL)
  
  header_lines <- lines[(header_start + 1):(header_end - 1)]
  
  tryCatch(
    yaml::yaml.load(paste(header_lines, collapse = "\n")),
    error = function(e) NULL
  )
}

# Function to check if private is set to true
is_private_true <- function(header) {
  if (is.null(header$private)) return(FALSE)
  return(tolower(trimws(header$private)) == "true")
}

# Function to add or update the private parameter
add_private_true <- function(file_path) {
  lines <- readLines(file_path, warn = FALSE)
  header_start <- which(lines == "---")[1]
  header_end <- which(lines == "---")[-1][1]
  
  if (is.na(header_start) || is.na(header_end) || header_start == header_end) return()
  
  header_lines <- lines[(header_start + 1):(header_end - 1)]
  header_content <- paste(header_lines, collapse = "\n")
  header <- tryCatch(yaml::yaml.load(header_content), error = function(e) NULL)
  
  # Add private: true if not present or not set to true
  if (!is_private_true(header)) {
    header$private <- "true"
    new_header <- paste0("---\n", yaml::as.yaml(header), "---")
    updated_content <- c(new_header, lines[(header_end + 1):length(lines)])
    writeLines(updated_content, file_path)
    cat("Updated", file_path, "\n")
  }
}

# Main function to process files
process_rmd_files <- function(content_dir = "content") {
  rmd_files <- list.files(content_dir, pattern = "-(aufgaben|loesungen|uebungen)\\.Rmd$", recursive = TRUE, full.names = TRUE)
  lapply(rmd_files, add_private_true)
}

# Run the script
process_rmd_files()

cat("Processing complete. Private parameter added where necessary.\n")
