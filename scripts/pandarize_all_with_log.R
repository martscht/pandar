# Required library
library(tools)

apply_function_to_rmds <- function(base_folder) {
  # Get the path of the script's directory
  script_dir <- dirname(rstudioapi::getSourceEditorContext()$path)  # For RStudio
  
  # Set the log file to be saved in the script's directory
  log_file <- file.path(script_dir, "process_log.txt")
  log_con <- file(log_file, open = "wt")
  
  # Start saving the console output to a file
  sink(log_con, append = TRUE, type = "message")  # `append = TRUE` ensures logs are added to the file, message captures messages and errors
  
  # Ensure all connections are closed on exit
  on.exit({
    sink(type = "message")
    close(log_con)
  }, add = TRUE)
  
  cat("Starting the processing...\n")
  
  # List all .Rmd files in the base folder and subdirectories
  rmd_files <- list.files(base_folder, pattern = "\\.Rmd$", full.names = TRUE, recursive = TRUE)
  
  for (file in rmd_files) {
    # Extract the filename without the extension (without ".Rmd")
    rmd_name <- tools::file_path_sans_ext(basename(file))
    
    # Check if a corresponding .R file exists to match prior Purl choice
    r_file <- file.path(dirname(file), paste0(rmd_name, ".R"))
    r_file_exists <- file.exists(r_file)

    # Use tryCatch to catch any errors or warnings during the process
    tryCatch({
      # Call pandarize with filename and Purl boolean
      pandarize(rmd_name, r_file_exists)
    }, error = function(e) {
      # catch errors and log them
      message("Error in processing file: ", rmd_name, " - ", e$message)
    }, warning = function(w) {
      # catch warnings and log them
      message("Warning in processing file: ", rmd_name, " - ", w$message)
    })
  }
  
  cat("Processing complete.\n")
}

# Run the function with your base folder path and log file
base_folder <- "content"
apply_function_to_rmds(base_folder)