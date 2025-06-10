library(yaml)
library(stringr)

search_rmd_dataset <- function(keyword, path = ".") {
  # Capitalize the dataset keyword for display.
  keyword <- str_to_title(keyword)
  
  # List all R Markdown files recursively (full paths).
  files <- list.files(path, pattern = "\\.Rmd$", recursive = TRUE, full.names = TRUE)
  found_in_titles <- c()
  
  for (file in files) {
    # Read file content.
    lines <- readLines(file, warn = FALSE)
    
    # Extract YAML header to get the title if available; fallback to the filename.
    yaml_end <- which(lines == "---")[2]
    if (!is.na(yaml_end)) {
      yaml_content <- paste(lines[2:(yaml_end - 1)], collapse = "\n")
      yaml_data <- yaml.load(yaml_content)
      title <- if (!is.null(yaml_data$title)) yaml_data$title else basename(file)
    } else {
      title <- basename(file)
    }
    
    # --- Build the Main File Link ---
    # Remove the leading "./content" from the file path.
    relative_path <- sub("^\\./content", "", file)
    # Ensure the path is root-relative.
    if (!startsWith(relative_path, "/")) {
      relative_path <- paste0("/", relative_path)
    }
    # Skip any file whose path (after removing "./content") contains "/daten/"
    if (grepl("/daten/", relative_path)) {
      next
    }
    # Remove the .Rmd extension to produce a typical Hugo URL.
    main_link <- sub("\\.Rmd$", "", relative_path)
    
    # --- Build the Category Link ---
    # The category is defined as the folder immediately containing the file.
    folder_path <- dirname(main_link)
    cat_name <- basename(folder_path)  # e.g. "fue-ii"
    
    # Build the category URL as /category/<cat_name>/ 
    category_link <- paste0("/category/", cat_name, "/")
    
    # Build the displayed category text:
    # Replace dashes with spaces and capitalize.
    display_cat <- str_to_title(gsub("-", " ", cat_name))
    # Additionally, if the display text contains a stand-alone "Ii", replace it with "II"
    display_cat <- gsub("\\bIi\\b", "II", display_cat)
    
    # Build the inner Markdown link for the category.
    inner_cat_link <- paste0("[", display_cat, "](", category_link, ")")
    # Now wrap that inner category link in an extra pair of square brackets.
    category_markdown <- paste0("[", inner_cat_link, "]")
    
    # --- Construct the Main File Markdown Link ---
    main_file_markdown <- paste0("[", title, "](", main_link, ")")
    
    # Only add this file if it contains the keyword (case-insensitive).
    if (any(grepl(keyword, lines, ignore.case = TRUE))) {
      combined_link <- paste(main_file_markdown, category_markdown)
      found_in_titles <- c(found_in_titles, combined_link)
    }
  }
  
  # Format the list of links: if there is more than one, insert "und" before the last entry.
  if (length(found_in_titles) > 1) {
    title_list <- paste(head(found_in_titles, -1), collapse = ", ")
    title_list <- paste(title_list, "und", tail(found_in_titles, 1))
  } else {
    title_list <- found_in_titles
  }
  
  # Construct the final output sentence.
  sentence <- if (length(found_in_titles) > 0) {
    paste0(keyword, " wird in den Beiträgen ", title_list, " genutzt.")
  } else {
    paste0(keyword, " wird in keinem Beitrag genutzt.")
  }
  
  return(sentence)
}

# Example usage:
search_rmd_dataset("raw_data")
