#### lavaan Abbreviation ----
abbrev <- function(X, begin = 'Latent Variables', end = NULL, ellipses = 'both', shift = 2, ...) {
  
  tmp <- capture.output(lavaan::summary(X,...))
  
  if (is.null(begin)) begin <- 1
  else begin <- grep(begin, tmp, fixed = TRUE)[1]
  if (is.null(end)) end <- length(tmp)-shift
  else end <- grep(end, tmp, fixed = TRUE)[grep(end, tmp, fixed = TRUE) > begin][1]-shift
  
  if (ellipses == 'both') {
    cat('[...]\n', paste(tmp[begin:end], collapse = '\n'), '\n[...]\n')
  }
  if (ellipses == 'top') {
    cat('[...]\n', paste(tmp[begin:end], collapse = '\n'))
  }
  if (ellipses == 'bottom') {
    cat(paste(tmp[begin:end], collapse = '\n'), '\n[...]\n')
  }
  if (ellipses == 'none') {
    cat(paste(tmp[begin:end], collapse = '\n'))
  }
}

#### Goethe Color Palette ----
# thanks @ https://drsimonj.svbtle.com/
# define colors
goethe_colors <- c(`blue`='#00618f', 
  `yellow` = '#e3ba0f', 
  `magenta` = '#ad3b76', 
  `green` = '#737c45', 
  `orange` = '#c96215')

# define extractor
goethe_cols <- function(...) {
  cols <- c(...)
  if (is.null(cols)) return(goethe_colors)
  else goethe_colors[cols]
}

# define palette
goethe_palettes <- list(
  `main` = goethe_cols('blue', 'yellow', 'magenta'),
  `long` = goethe_cols()
)

# palette grabber
goethe_pal <- function(palette = "main", reverse = FALSE, ...) {
  pal <- goethe_palettes[[palette]]
  if (reverse) pal <- rev(pal)
  colorRampPalette(pal, ...)
}

# define scales for ggplot
scale_color_goethe <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- goethe_pal(palette = palette, reverse = reverse)
  if (discrete) {
    discrete_scale("colour", paste0("goethe_", palette), palette = pal, ...)
  } else {
    scale_color_gradientn(colours = pal(256), ...)
  }
}

scale_fill_goethe <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- goethe_pal(palette = palette, reverse = reverse)
  if (discrete) {
    discrete_scale("fill", paste0("goethe_", palette), palette = pal, ...)
  } else {
    scale_fill_gradientn(colours = pal(256), ...)
  }
}