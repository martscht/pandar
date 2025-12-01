# app.R
if (!requireNamespace("shiny", quietly = TRUE)) {
  install.packages("shiny")
}
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Beispiel einer Bayesianische Analyse"),
  sidebarLayout(
    sidebarPanel(
      h4("Prior (Beta Verteilung)"),
      sliderInput("alpha", "Alpha:",
        min = 1, max = 100, value = 10, step = 1),
      sliderInput("beta", "Beta:",
        min = 1, max = 100, value = 10, step = 1),
      br(),
      h4("Beobachtete Daten"),
      numericInput("trials", "Anzahl an Beobachtungen (n):", value = 0, min = 0),
      numericInput("successes", "Anzahl an KliPPs Präferenzen (k):", value = 0, min = 0),
      actionButton("data", "Daten"),
      actionButton("run", "Analyse"),
      actionButton("clear", "Zurücksetzen")
    ),
    mainPanel(
      h3("Prior, Likelihood & Posterior"),
      plotOutput("distPlot"),
      textOutput("priorMean"),
      textOutput("likeMean"),
      textOutput("posteriorMean")
    )
  )
)

server <- function(input, output, session) {
  
  ## State for what to show
  state <- reactiveValues(
    show_like = FALSE,
    show_post = FALSE
  )
  
  observeEvent(input$data, {
    state$show_like <- TRUE
  })
  
  observeEvent(input$run, {
    state$show_like <- TRUE
    state$show_post <- TRUE
  })
  
  observeEvent(input$clear, {
    state$show_like <- FALSE
    state$show_post <- FALSE
    
    updateSliderInput(session, "alpha", value = 2)
    updateSliderInput(session, "beta",  value = 2)
    updateNumericInput(session, "trials",    value = 0)
    updateNumericInput(session, "successes", value = 0)
  })
  
  ## Means
  prior_mean <- reactive({
    input$alpha / (input$alpha + input$beta)
  })
  
  output$priorMean <- renderText({
    sprintf("Angenommener KliPPs-Anteil (Prior): %.3f", prior_mean())
  })
  
  like_mean <- reactive({
    n <- input$trials
    if (n > 0) input$successes / n else NA_real_
  })
  
  output$likeMean <- renderText({
    if (input$trials == 0) {
      return("KliPPs-Anteil in der Stichprobe: (keine Daten)")
    }
    sprintf("KliPPs-Anteil in der Stichprobe: %.3f", like_mean())
  })
  
  posterior_params <- eventReactive(input$run, {
    n <- max(input$trials, 0)
    k <- max(min(input$successes, n), 0)
    
    list(
      alpha = input$alpha + k,
      beta  = input$beta + n - k,
      n = n,
      k = k
    )
  })
  
  output$posteriorMean <- renderText({
    if (!state$show_post) {
      return("Implizierter KliPPs-Anteil (Posterior): (Analyse durchführen)")
    }
    params <- posterior_params()
    m <- params$alpha / (params$alpha + params$beta)
    sprintf("Implizierter KliPPs-Anteil (Posterior): %.3f", m)
  })
  
  ## Plot
  output$distPlot <- renderPlot({
    
    p <- seq(0, 1, length.out = 1000)
    
    n <- max(input$trials, 0)
    k <- max(min(input$successes, n), 0)
    
    df <- data.frame(
      p = p,
      density = dbeta(p, input$alpha, input$beta),
      dist = "Prior"
    )
    
    if (state$show_like) {
      likelihood <- data.frame(
        p = p,
        density = dbeta(p, k + 1, n - k + 1),  # normalisierte Likelihood
        dist = "Likelihood"
      )
      df <- rbind(df, likelihood)
    }
    
    if (state$show_post) {
      params <- posterior_params()
      posterior <- data.frame(
        p = p,
        density = dbeta(p, params$alpha, params$beta),
        dist = "Posterior"
      )
      df <- rbind(df, posterior)
    }
    
    ggplot(df, aes(x = p, y = density, color = dist)) +
      geom_line(linewidth = 1) +
      scale_color_manual(
        values = c(
          "Prior"      = "#00618f",
          "Likelihood" = "#737c45",
          "Posterior"  = "#e3ba0f"
        )
      ) +
      labs(
        x = "KliPPs-Anteil",
        y = "Dichte",
        color = ""
      ) +
      ggtitle(sprintf(
        "Beta Prior: α = %.1f, β = %.1f",
        input$alpha, input$beta
      )) +
      theme_minimal(base_size = 14)
  })
}

shinyApp(ui = ui, server = server)