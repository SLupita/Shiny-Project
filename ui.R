library(shiny)

# Producing interactive plot for various parameters from "gapminder" data and observing the trend over years
shinyUI(fluidPage(

  # Application title
  titlePanel("Health outcomes for 184 countries from 1960 to 2016"),

  # Sidebar with a slider input for x and y parameters
  sidebarLayout(
    sidebarPanel(
       sliderInput("minyear",
                   "Starting year:",
                   min = min(gapminder$year),
                   max = max(gapminder$year),
                   value = min(gapminder$year),
                   step=1),
       
       sliderInput("maxyear",
                   "Ending year:",
                   min = min(gapminder$year),
                   max = max(gapminder$year),
                   value = max(gapminder$year),
                   step=1),
       
       selectInput("y", "Choose parameter to observe the trend over years:",choices = colnames(gapminder[-c(1,2,7,8,9)]))
    ),

    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plot1")
    )
  )
))
