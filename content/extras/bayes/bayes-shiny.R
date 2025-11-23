# app.R
library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Beispiel einer Bayesianische Analyse"),
  sidebarLayout(
    sidebarPanel(
      h4("Prior (Beta Verteilung)"),
      sliderInput("alpha", "Alpha:",
        min = 0.5, max = 20, value = 2, step = 0.5),
      sliderInput("beta", "Beta:",
        min = 0.5, max = 20, value = 2, step = 0.5),
      br(),
      h4("Beobachtete Daten"),
      numericInput("trials", "Anzahl an Beobachtungen (n):", value = 0, min = 0),
      numericInput("successes", "Anzahl an Erfolgen (k):", value = 0, min = 0),
      actionButton("data", "Daten"),
      actionButton("run", "Analyse")
    ),
    mainPanel(
      h3("Prior, Likelihood & Posterior"),
      plotOutput("distPlot"),
      textOutput("priorMean"),
      textOutput("posteriorMean")
    )
  )
)

server <- function(input, output, session) {
  
  prior_mean <- reactive({
    input$alpha / (input$alpha + input$beta)
  })
  
  output$priorMean <- renderText({
    sprintf("Angenommene mittlere Erfolgsrate (Prior): %.3f", prior_mean())
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
    if (input$run == 0) {
      return("Implizierte mittlere Erfolgsrate (Posterior): (Analyse durchführen)")
    }
    params <- posterior_params()
    m <- params$alpha / (params$alpha + params$beta)
    sprintf(
      "Implizierte mittlere Erfolgsrate (Posterior) (nach %d Beobachtungen): %.3f",
      params$n, params$k, m
    )
  })
  
  output$distPlot <- renderPlot({
    
    p <- seq(0, 1, length.out = 1000)
    
    n <- max(input$trials, 0)
    k <- max(min(input$successes, n), 0)
    
    df <- data.frame(
      p = p,
      density = dbeta(p, input$alpha, input$beta),
      dist = "Prior"
    )
    
    # If Data or Run pressed → add likelihood
    if (input$data > 0 || input$run > 0) {
      likelihood <- data.frame(
        p = p,
        density = dbeta(p, k + 1, n - k + 1),  # ∝ Binomial likelihood
        dist = "Likelihood"
      )
      df <- rbind(df, likelihood)
    }
    
    # If Run pressed → also add posterior
    if (input$run > 0) {
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
          "Prior" = "#00618f",
          "Likelihood" = "#737c45",
          "Posterior" = "#e3ba0f"
        )
      ) +
      labs(
        x = "Erfolgsrate",
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

