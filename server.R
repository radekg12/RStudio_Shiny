
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

for (package in c('shiny', 'ggplot2', 'RgoogleMaps', 'geosphere', 'ggmap')) {
  if (!require(package, character.only = T, quietly = T)) {
    install.packages(package)
    library(package, character.only = T)
  }
}

function(input, output) {
  output$scatterplot1 <- renderPlot({
    ggplot(data = house_data, aes_string(x = input$x1, y = input$y1)) +
      geom_jitter(alpha = input$alpha1, size = input$size1)
  })
  
  output$densityplot1 <- renderPlot({
    ggplot(data = house_data, aes_string(x = input$x1)) +
      geom_density()
  })
  
  output$scatterplot2 <- renderPlot({
    ggplot(data = house_data, aes(x = yr_built, y = price)) +
      xlim(c(input$year2[1], input$year2[2])) +
      geom_jitter(alpha = 0.2, size = 0.2) +
      geom_smooth(aes(color = factor(waterfront)), se = FALSE) +
      labs(
        title = "Cena domu od roku jego budowy",
        y = "Cena",
        x = "Rok budowy",
        color = "Widok na wybrzeże"
      )
  })
  
  house_data_subset <- reactive({
    req(input$checkGroup3)
    subset(house_data, floors %in% as.vector(input$checkGroup3))
  })
  
  output$scatterplot3 <- renderPlot({
    ggplot(data = house_data_subset(), aes(yr_built)) +
      geom_density(aes(fill = factor(floors)) , alpha = 0.8) +
      labs(x = "Rok budowy",
           fill = "Liczba kondygnacji:")
  })
  
  house_data2 <- subset(house_data, yr_built %in% c(1990))
  house_data2 <- reactive({
    req(input$year5)
    subset(house_data, yr_built %in% c(input$year5))
  })
  
  
  KingCountryMap <- qmap(
    "King County",
    maprange = TRUE,
    base_layer = ggplot(data = house_data2, aes(x = long, y = lat))
  )
  
  output$mapplot5 <- renderPlot({
    KingCountryMap +
      geom_point(
        data = house_data2(),
        aes(
          x = long,
          y = lat,
          size = price,
          color = factor(floors)
        ),
        alpha = 0.6,
        fill = 0.5
      ) +
      stat_density2d(
        data = house_data2(),
        aes(x = long, y = lat),
        alpha = 0.2,
        size = 2,
        bins = 4,
        geom = "polygon"
      ) +
      labs(size = "Cena:",
           color = "Liczba kondygnacji:",
           title = "Mapa hrabstwa King")
  })
  
  
  output$scatterplot4 <- renderPlot({
    ggplot(data = house_data, aes(x = grade, y = price)) +
      geom_boxplot(aes(group = grade), outlier.shape = 1) +
      geom_smooth(se = FALSE) +
      xlim(c(input$grade4[1], input$grade4[2]) + 1) +
      ylim(c(input$price4[1], input$price4[2]))
  })
  
  
}

