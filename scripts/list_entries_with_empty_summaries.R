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

# Function to check if summary is empty
is_empty_summary <- function(header) {
  if (is.null(header$summary)) return(FALSE)
  trimmed <- trimws(header$summary)
  return(trimmed == "")
}

# Main function to list Rmds with empty summary
list_rmds_with_empty_summary <- function(content_dir = "content") {
  rmd_files <- list.files(content_dir, pattern = "\\.Rmd$", recursive = TRUE, full.names = TRUE)
  
  empty_summary_files <- sapply(rmd_files, function(file) {
    header <- extract_yaml_header(file)
    if (!is.null(header) && is_empty_summary(header)) {
      return(file)
    } else {
      return(NA)
    }
  })
  
  na.omit(empty_summary_files)
}

# Get path of current script in RStudio
script_path <- rstudioapi::getActiveDocumentContext()$path
script_dir <- dirname(script_path)
output_file <- file.path(script_dir, "empty_summaries.txt")

# Run and save result
empty_rmds <- list_rmds_with_empty_summary()
writeLines(empty_rmds, con = output_file)

cat("List saved to", output_file, "\n")