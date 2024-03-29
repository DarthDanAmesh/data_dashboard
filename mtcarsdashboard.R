library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(DT)

ui <- dashboardPage(
  dashboardHeader(color = "blue",title = "Dashboard Demo", inverted = TRUE),
  dashboardSidebar(
    size = "thin", color = "teal",
    sidebarMenu(
      menuItem(tabName = "main", "Main", icon = icon("car")),
      menuItem(tabName = "extra", "Extra", icon = icon("table"))
    )
  ),
  dashboardBody(
    tabItems(
      selected = 1,
      tabItem(
        tabName = "main",
        fluidRow(
          box(width = 8,
              title = "Graph 1",
              color = "green", ribbon = TRUE, title_side = "top right",
              column(width = 8,
                     plotOutput("boxplot1")
              )
          ),
          box(width = 8,
              title = "Graph 2",
              color = "red", ribbon = TRUE, title_side = "top right",
              column(width = 8,
                     plotlyOutput("dotplot1")
              )
          )
        )
      ),
      tabItem(
        tabName = "extra",
        fluidRow(
          dataTableOutput("carstable")
        )
      )
    )
  )
)

server <- shinyServer(function(input, output, session) {
  data("mtcars")
  colscale <- c(semantic_palette[["red"]], semantic_palette[["green"]], semantic_palette[["blue"]])
  mtcars$am <- factor(mtcars$am,levels=c(0,1),
                      labels=c("Automatic","Manual"))
  output$boxplot1 <- renderPlot({
    ggplot(mtcars, aes(x = am, y = mpg)) +
      geom_boxplot(fill = semantic_palette[["green"]]) + 
      xlab("gearbox") + ylab("Miles per gallon")
  })
  
  output$dotplot1 <- renderPlotly({
    ggplotly(ggplot(mtcars, aes(wt, mpg))
             + geom_point(aes(colour=factor(cyl), size = qsec))
             + scale_colour_manual(values = colscale)
    )
  })
  output$carstable <- renderDataTable(mtcars)
})

shinyApp(ui, server)