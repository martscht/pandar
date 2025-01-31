pandarize <- function(x, purl = TRUE) {
  
  # saves the global environment to the temporary R folder (deletes after the session)
  save(list = ls(.GlobalEnv), file = file.path(tempdir(), "env.RData"), envir = .GlobalEnv)
  # empties global environment for the render step
  rm(list = setdiff(ls(.GlobalEnv), "pandarize"), envir = .GlobalEnv)
  
  try(expr = {
    # first lines define the names for files for a certain post
    .rmd <- dir(getwd(), pattern = paste0(x, '.Rmd'), recursive = TRUE)
    if (length(.rmd) > 1) {
      .rmd <- .rmd[1]
      warning(paste0('Multiple RMarkdown files found containing ', x, '. Only ', .rmd, ' will be rendered.'))
    }
    .location <- gsub(paste0(x, '.Rmd'), '', .rmd)
    .img_location <- gsub('content', '', .location) # old img_location
    .md <- gsub('.Rmd', '.md', .rmd)
    .R <- gsub('.Rmd', '.R', .rmd)
    .html <- gsub('.Rmd', '.html', .rmd)
    
    # next two lines delete previously created images for the post (if they exist) - old
    generated_images_folder_path <- paste0(.location, x, "_files")
    if (dir.exists(generated_images_folder_path)) {
      unlink(generated_images_folder_path, recursive = TRUE)
    }
    
    # change directory for figures to inside a static folder in the given folder globally
    figure_path = paste0(file.path(getwd(), "static", paste0(x, "_files")),"/") # puts everything into a base level static folder with an absolute path that is individually constructed
    knitr::opts_chunk$set(fig.path = figure_path)
    
    # debug for figures and images
    # print(getwd())
    # print(.img_location)
    print(paste0("Setting fig.path to: ", figure_path))
    
    # render the RMarkdown, use the global environment
    figure_path <<- figure_path # to pass param to rmarkdown, doing with params didnt work due to globalenv
    tryCatch({
      rmarkdown::render(.rmd, envir = globalenv())
    }, error = function(e){
      message("Error rendering ", .rmd, ": ", e$message)
    })
    
    
    # only purl the R code from the RMarkdown if the argument is TRUE
    if (purl) knitr::purl(.rmd, .R, documentation = 0)
    
    # rename figures and images links in the markdown so they are found and displayed aferwards
    
    # old method, can be removed if new one works just as well!
    # readLines(.md) |>
    #   sub(pattern = '![](', replacement = paste0('![](', .img_location), x = _, fixed = TRUE) |>
    #   sub(pattern = '](figure/', replacement = paste0('](', .img_location), x = _, fixed = TRUE) |>
    #   gsub(pattern = '<img src="', replacement = paste0('<img src="', .img_location)) |>
    #   writeLines(con = .md)
    # 
    
    # new (might be better at closing connections correctly)
    lines <- readLines(.md) |>
      sub(pattern = paste0('![](', gsub("\\\\", "/", figure_path)), 
          replacement = paste0('![](', sub(".*?/static/", "/", figure_path)), x = _, fixed = TRUE) |>
      sub(pattern = paste0('](', gsub("\\\\", "/", figure_path)), 
          replacement = paste0('](', sub(".*?/static/", "/", figure_path)), x = _, fixed = TRUE) |>
      gsub(pattern = paste0('<img src="', gsub("\\\\", "/", figure_path)), 
           replacement = paste0('<img src="', sub(".*?/static/", "/", figure_path)), x = _)
    
    con <- file(.md, "w")  # Open file connection for writing
    writeLines(lines, con)  # Write updated lines to the file
    close(con)  # Ensure the connection is closed
    
    # remove the created html because we do not need it
    if (file.exists(.html)){
      tryCatch({
        file.remove(.html)  
      }, error = function(e) {
        message("Could not remove ", .html, ": ", e$message)
      })
    }
  }
  )
  
  # delete everything from the global environment again
  rm(list = setdiff(ls(.GlobalEnv), "pandarize"), envir = .GlobalEnv)
  
  # reload the global environment from the temporary/session R folder
  env_file <- file.path(tempdir(), "env.RData")
  if (file.exists(env_file)){
    load(file = env_file, envir = .GlobalEnv)
  }
}
