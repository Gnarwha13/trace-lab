library(shiny)

ui <- fluidPage(
  titlePanel("ERP Viewer"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("time", "Time window (ms)",
                  min = -200, max = 800,
                  value = c(-200, 800))
    ),
    mainPanel(
      plotOutput("erpPlot")
    )
  )
)

server <- function(input, output) {
  output$erpPlot <- renderPlot({
    t <- seq(input$time[1], input$time[2], by = 1)
    plot(t, sin(t/100) * exp(-t/500),
         type = "l", col = "steelblue", lwd = 2,
         xlab = "Time (ms)", ylab = "Amplitude (µV)",
         main = "ERP Waveform")
    abline(v = 0, lty = 2, col = "gray")
    abline(h = 0, lty = 2, col = "gray")
  })
}

shinyApp(ui = ui, server = server)
