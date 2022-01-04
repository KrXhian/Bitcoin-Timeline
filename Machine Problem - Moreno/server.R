library(shiny)
library(shinythemes)
library(shinyWidgets)
library(ggplot2)
library(plotly)
library(xts)
library(hrbrthemes)
library(tidyverse)
library(htmlwidgets)
library(dplyr)
library(extrafont)
library(prophet)
library(dygraphs)


# Main Dataset

dataset <- read.csv("Dataset.csv",header = TRUE)
Day <- as.Date(dataset$Date)


server <- function(input, output, session) {
  
  #  Dataset Table
  output$table1 <- DT::renderDataTable({
                   DT::datatable(dataset, options = list
                   (pageLength = 25))})
  
  
  #  Plot 1 - Bitcoin Price Timeline with Trend Line (Interactive)
  #  Bitcoin Price Plotly
  
  output$plot1 <- renderPlotly({
                  ggplotly(dataset %>% ggplot(aes(x = Day, y = Price)) +
                  geom_line (color="gold2") +
                  geom_area(fill="gold", alpha=0.25) +
                  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
                  xlab("Date") +
                  ylab("Price (USD)") +
                  theme_ipsum(), 
                  dynamicTicks = TRUE) %>%
                  layout(height = 400, width = 800, hovermode="x unified",
                         xaxis = list(rangeselector = list(buttons = list(
                               list(count = 1, label = "1d", step = "day", stepmode = "backward"),
                               list(count = 5, label = "5d", step = "day", stepmode = "backward"),
                               list(count = 1, label = "1m", step = "month", stepmode = "backward"),
                               list(count = 6, label = "6m", step = "month", stepmode = "backward"),
                               list(count = 1, label = "1y",step = "year",stepmode = "backward"),
                               list(count = 5, label = "5y",step = "year",stepmode = "backward"),
                               list(count = 1, label = "YTD", step = "year", stepmode = "todate"),
                               list(label = "Max",step = "all"))))
                         )
                  })
  
  
  #  Plot 2 - Bitcoin Energy Consumption Timeline with Trend Line (Interactive)
  #  Bitcoin Estimated Energy Consumption Plotly

  output$plot2 <- renderPlotly({
                  ggplotly(dataset %>%ggplot(aes(x = Day, y = Consumption)) +
                  geom_line (color="gold2") +
                  geom_area(fill="gold", alpha=0.25) +
                  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
                  xlab("Date") +
                  ylab("TWh (Annualized)") +
                  theme_ipsum(),
                  dynamicTicks = TRUE) %>%
                  layout(height = 400, width = 800,hovermode="x unified",
                         xaxis = list(rangeselector = list(buttons = list(
                               list(count = 1, label = "1d", step = "day", stepmode = "backward"),
                               list(count = 5, label = "5d", step = "day", stepmode = "backward"),
                               list(count = 1, label = "1m", step = "month", stepmode = "backward"),
                               list(count = 6, label = "6m", step = "month", stepmode = "backward"),
                               list(count = 1, label = "1y",step = "year",stepmode = "backward"),
                               list(count = 5, label = "5y",step = "year",stepmode = "backward"),
                               list(count = 1, label = "YTD", step = "year", stepmode = "todate"),
                               list(label = "Max",step = "all")))))
                  })
  
  
  #  Plot 3 - Correlation 
  #  Price and Consumption Correlation
  #cor(dataset$Price, dataset$Consumption)
  
  output$plot3 <- renderPlotly({
                  ggplotly(dataset %>% ggplot(aes(x = Price, y = Consumption)) +
                  geom_point(color = "gold") +
                  geom_smooth(method='lm', formula= y~x, lty = "dashed", color = "bisque4", lwd = 0.75) +
                  labs (x = "Bitcoin Price (USD)",y = "Energy Consumption TWh (Annualised)") +
                  theme_ipsum()) %>% 
                  layout(height = 400, width = 800)
                  })

  
  # Price Forecasting Dataset and Functions
  
  priceForecastdata <- data.frame(ds = c(dataset$Date), y = c(dataset$Price))
  Model1 <- prophet(priceForecastdata)
  Future1 <- make_future_dataframe(Model1, periods = 1825)
  Forecast1 <- predict(Model1, Future1)
  
  
  # Energy Forecasting Dataset and Functions
  
  energyForecastdata <- data.frame(ds = c(dataset$Date), y = c(dataset$Consumption))
  Model2 <- prophet(energyForecastdata)
  Future2 <- make_future_dataframe(Model2, periods = 1825)
  Forecast2 <- predict(Model2, Future2)  
  
  
  # Forecasting Bitcoin Price for 5 years
  
  output$dygraph1 <- renderDygraph({dyplot.prophet(Model1, Forecast1)})
  
  
  # Forecasting Bitcoin Energy Consumption for 5 years
  
  output$dygraph2 <- renderDygraph({dyplot.prophet(Model2, Forecast2)})
}