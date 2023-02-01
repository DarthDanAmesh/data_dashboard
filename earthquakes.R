# if installing leaflet for first time install install.packages("terra")
#install.packages("raster") install: sudo apt install libgdal-dev to avoid error
library(shiny)
library(shiny.semantic)
library(semantic.dashboard)
library(leaflet)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    size = "wide",
    sidebarMenu(
      menuItem(tabName = "map", text = "Map", icon = icon("map")),
      menuItem(tabName = "table", text = "Table", icon = icon("table"))
    )
  ),
  dashboardBody(
    tabItems(
      selected = 1,
      tabItem(
        tabName = "map",
        tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
        leafletOutput("map")
      ),
      tabItem(
        tabName = "table",
        fluidRow(
          h1("Quakes Table"),
          semantic_DTOutput("quakesTable")
        )
      )
    )
  )
)

server <- function(input, output) {
  output$map <- renderLeaflet({ leaflet() %>%
      setView(lng = 179.3355929, lat = -20.4428959, zoom = 6.5) %>%
      addProviderTiles("Esri.WorldStreetMap") %>%
      addCircles(
        data = quakes,
        radius = sqrt(10^quakes$mag) * 30,
        color = "#000000",
        fillColor = "#ffffff",
        fillOpacity = 0.5,
        popup = paste0(
          "Magnitude: ", quakes$mag, "
",
"Depth (km): ", quakes$depth, "
",
"Num. stations reporting: ", quakes$stations
        )
      )
  })
  
  output$quakesTable <- DT::renderDataTable(
    semantic_DT(quakes)
  )
}
shinyApp(ui, server)