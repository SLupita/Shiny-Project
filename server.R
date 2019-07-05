
library(shiny)
require(graphics)
require(ggplot2)
library(dslabs)
library(dplyr)

# Create interactive graph for plotting various factors against a range of years

shinyServer(function(input, output) {

# Reading value to be used for y-axis
  getyInput <- reactive({
      yInput <- input$y
  })
  
# Reading the starting and ending year to be used for x-axis
  getYear <- reactive({
      seq(from=input$minyear, to=input$maxyear, by=1)
  })

# Plotting
  output$plot1 <- renderPlot({

      yearInput <- getYear()
      
      gapminder <- gapminder[complete.cases(gapminder),] %>%
          filter(year %in% yearInput) %>%
          group_by(continent, year) %>%
          summarize(
              avg_infant_mortality = mean(infant_mortality),
              avg_life_expectancy = mean(life_expectancy),
              total_population = sum(population),
              avg_fertility = mean(fertility)
          )
      
      if(input$y == "infant_mortality"){
          p <- ggplot(gapminder, aes(year, avg_infant_mortality, color=continent)) +
              geom_smooth() +
              ggtitle("Average infant mortality per year") +
              xlab("Year") + ylab("Average Infant Mortality")
      }

      if(input$y == "life_expectancy"){
          p <- ggplot(gapminder, aes(year, avg_life_expectancy, color=continent)) +
              geom_smooth() +
              ggtitle("Average life expectancy per year") +
              xlab("Year") + ylab("Average Life Expectancy")
      }

      if(input$y == "fertility"){
          p <- ggplot(gapminder, aes(year, avg_fertility, color=continent)) +
              geom_smooth() +
              ggtitle("Average fertility per year") +
              xlab("Year") + ylab("Average fertility")
      }

      if(input$y == "population"){
          p <- ggplot(gapminder, aes(year, total_population, color=continent)) +
              geom_smooth() +
              ggtitle("Total population per year") +
              xlab("Year") + ylab("Total population")
      }
      
      print(p)
    })
})
