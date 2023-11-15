pandarize <- function(x, purl = TRUE) {
  
  # saves the global environment to the temporary R folder (deletes after the session)
  save(list = ls(.GlobalEnv), file = file.path(tempdir(), "env.RData"), envir = .GlobalEnv)
  # empties global environment for the render step
  rm(list = setdiff(ls(.GlobalEnv), "pandarize"), envir = .GlobalEnv)
  
  try(expr = {
  # first lines define the names for files for a certain post
  .rmd <- dir(getwd(), pattern = paste0(x, '.Rmd'), recursive = TRUE)
  .location <- gsub(paste0(x, '.Rmd'), '', .rmd)
  .img_location <- gsub('content', '', .location)
  .md <- gsub('.Rmd', '.md', .rmd)
  .R <- gsub('.Rmd', '.R', .rmd)
  .html <- gsub('.Rmd', '.html', .rmd)
  
  # next two lines delete previously created images for the post (if they exist)
  generated_images_folder_path <- paste0(.location, x, "_files")
  unlink(generated_images_folder_path, recursive = TRUE)
  

  # render the RMarkdown, use the global environment
  rmarkdown::render(.rmd, envir = globalenv())
  
  # only purl the R code from the RMarkdown if the argument is TRUE
  if (purl) knitr::purl(.rmd, .R, documentation = 0)
  
  # rename figures and images links in the markdown so they are found and displayed aferwards
  readLines(.md) |>
    sub(pattern = '![](', replacement = paste0('![](', .img_location), x = _, fixed = TRUE) |>
    sub(pattern = '](figure/', replacement = paste0('](', .img_location), x = _, fixed = TRUE) |>
    sub(pattern = '<img src="', replacement = paste0('<img src="', .img_location)) |>
    writeLines(con = .md)

  # remove the created html because we do not need it
  file.remove(.html)  
  }
  )
  
  # delete everything from the global environment again
  rm(list = setdiff(ls(.GlobalEnv), "pandarize"), envir = .GlobalEnv)
  
  # reload the global environment from the temporary/session R folder
  load(file = file.path(tempdir(), "env.RData"), envir = .GlobalEnv)
}
