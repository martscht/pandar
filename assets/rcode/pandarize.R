pandarize <- function(x) {
  .rmd <- dir(getwd(), pattern = paste0(x, '.Rmd'), recursive = TRUE)
  .location <- gsub(paste0(x, '.Rmd'), '', .rmd)
  .img_location <- gsub('content', '', .location)
  .md <- gsub('.Rmd', '.md', .rmd)
  .R <- gsub('.Rmd', '.R', .rmd)
  .html <- gsub('.Rmd', '.html', .rmd)
  
  knitr::knit(.rmd, .md, envir = new.env())
  knitr::purl(.rmd, .R, documentation = 0)
  
  readLines(.md) |>
    sub(pattern = '![](', replacement = paste0('![](', .img_location), x = _, fixed = TRUE) |>
    sub(pattern = '<img src="figure/', replacement = paste0('<img src="', .img_location, '/', x , '_files/figure-html/')) |>
    writeLines(con = .md)
  
  file.remove(.html)
}
