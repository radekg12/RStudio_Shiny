
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

for (package in c('shiny', 'shinythemes')) {
  if (!require(package, character.only = T, quietly = T)) {
    install.packages(package)
    library(package, character.only = T)
  }
}

fluidPage(
  theme = shinytheme("cerulean"),
  
  titlePanel("Sprzedaż domów w hrabstwie King, USA"),
  navbarPage(
    "Menu",
    
    tabPanel("Strona 1",
             
             sidebarLayout(
               sidebarPanel(
                 selectInput(
                   inputId = "y1",
                   label = "Zależność ",
                   choices = c(
                     "ceny domu" = "price",
                     "liczby sypialni" = "bedrooms",
                     "liczby łazienek" = "bathrooms",
                     "wielkości pokoju dziennego" = "sqft_living"
                   ),
                   selected = "ceny domu"
                 ),
                 
                 
                 selectInput(
                   inputId = "x1",
                   label = "od",
                   choices = c(
                     "ceny domu" = "price",
                     "liczby sypialni" = "bedrooms",
                     "liczby łazienek" = "bathrooms",
                     "wielkości pokoju dziennego" = "sqft_living"
                   ),
                   selected = "liczby sypialni"
                 ),
                 sliderInput(
                   inputId = "alpha1",
                   label = "Alpha:",
                   min = 0,
                   max = 1,
                   value = 0.4
                 ),
                 
                 sliderInput(
                   inputId = "size1",
                   label = "Size:",
                   min = 0,
                   max = 5,
                   value = 1.0
                 )
               ),
               
               
               mainPanel(
                 plotOutput(outputId = "scatterplot1"),
                 plotOutput(outputId = "densityplot1", height = 200)
               )
             )),
    
    
    tabPanel("Strona 2",
             
             sidebarLayout(
               sidebarPanel(
                 sliderInput(
                   inputId = "year2",
                   label = "Rok budowy",
                   min = 1900,
                   max = 2015,
                   value = c(1900, 2015)
                 )
               ),
               
               mainPanel(plotOutput(outputId = "scatterplot2"))
             )),
    
    tabPanel("Strona 3",
             
             sidebarLayout(
               sidebarPanel(
                 sliderInput(
                   inputId = "year5",
                   label = "Rok budowy",
                   min = 1900,
                   max = 2015,
                   value = 1990
                 )
               ),
               
               mainPanel(plotOutput(outputId = "mapplot5"))
             )),
    
    tabPanel("Strona 4",
             
             sidebarLayout(
               sidebarPanel(
                 checkboxGroupInput(
                   inputId = "checkGroup3",
                   label = "Liczba kondygnacji",
                   choices = levels(factor(house_data$floors)),
                   selected = levels(factor(house_data$floors))
                 )
               ),
               
               mainPanel(plotOutput(outputId = "scatterplot3"))
             )),
    
    
    tabPanel("Strona 5",
             
             sidebarLayout(
               sidebarPanel(
                 sliderInput(
                   inputId = "price4",
                   label = "Cena",
                   min = 0,
                   max = 8000000,
                   value = c(0, 8000000)
                 ),
                 
                 sliderInput(
                   inputId = "grade4",
                   label = "Ocena",
                   min = 0,
                   max = 13,
                   value = c(0, 13)
                 )
               ),
               
               mainPanel(plotOutput(outputId = "scatterplot4"))
             ))
    
    
  )
)
