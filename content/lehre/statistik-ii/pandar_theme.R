#### Source der Theme und Farbpalette von ggplotting ####

### Theme ----
theme_pandar <- function() {
  theme_minimal() %+replace%
    theme(plot.title = element_text(size = 18, hjust = .5),
      plot.subtitle = element_text(hjust = .5),
      axis.line = element_line(color = 'black'))
}

### Farbpalette ----
pandar_colors <- c('#00618f',  '#737c45', '#e3ba0f', '#ad3b76')

scale_color_pandar <- function(discrete = TRUE, ...) {
  pal <- colorRampPalette(pandar_colors)
  if (discrete) {
    discrete_scale('color', 'pandar_color', palette = pal, ...)
  } else {
    scale_color_gradientn(colors = pal(4), ...)
  }
}

scale_fill_pandar <- function(discrete = TRUE, ...) {
  pal <- colorRampPalette(pandar_colors)
  if (discrete) {
    discrete_scale('fill', 'pandar_fill', palette = pal, ...)
  } else {
    scale_fill_gradientn(colors = pal(4), ...)
  }
}
