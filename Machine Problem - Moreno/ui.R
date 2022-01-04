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
library(dygraphs)
library(rsconnect)


navbarPage(
    theme = shinytheme("sandstone"),
    "Bitcoin Timeline",
    
    tabPanel("Home", 
             fluidRow(column(12,wellPanel(
             h4("WHAT IS BITCOIN?"),
             
             p(style = "text-align: justify;",
               "Bitcoin is a decentralized digital currency, without a central bank or 
               single administrator, that can be sent from user to user on the peer-to-peer 
               bitcoin network without the need for intermediaries. It was created and eveloped by 
               Satoshi Nakamoto in 2008."),
             ))),
             
             fluidRow(column(12,wellPanel(
               h4("ENVIRONMENTAL CONCERNS"),
               
               p(style = "text-align: justify;",
               "During the last 5 years the price and popularity of the said cryptocurrency have
               skyrocketed at an unprecedented rate and have been observed to keep increasing over time.
               The increase of Bitcoin’s popularity is alarming as it also increases the
               difficulty of mining a single coin, and thus resulting in an increase on the Bitcoin’s energy
               consumption"),
               
               p(style = "text-align: justify;",
               "The increase of the energy consumption correlates to the Bitcoin’s
               popularity. This increase is very alarming as 79.56% of the world’s total energy
               production is from burning fossil fuels which is one of the biggest contributors to the
               GHG emissions in the atmosphere."),
               
               p(style = "text-align: justify;",
               "Bitcoin and other forms of cryptocurrencies utilize the Blockchain technology
               to record transactions. Blockchain is a series of network compromising of several
               computers working together to record cryptocurrencies transactions; this is to avoid
               reusing the same coin more than once. Due to the decentralized nature of
               cryptocurrencies, there is no singular entity that controls or monopolizes the entire
               network, meaning anyone who have a computer or a mining device with the mining
               software installed into can join the blockchain network."),
               
               style = "text-align: justify;",p(
               "Mining bitcoins requires aspecially-designed hardware with sufficient amount of computational 
               power to solve complex mathematical problems to mine new coins. The amount of computational
               power to mine a single coin is extremely high, the mathematical problems in which the
               computer needs to solve becomes harder progressively thus the computational power
               needed is increased as well. Mining these coins requires a lot of computational power, it also 
               requires a lot of energy to power these computers. According to a study conducted by 
               Harald V.(2017), the order of magnitude for the energy consumption of mining cryptocurrencies 
               is around the range of 100-500 MW"))))
             ),
  
    
    # Dataset
    tabPanel("Dataset", fluidRow(column(12,
              wellPanel( DT::dataTableOutput('table1'))))
             ),  
  
  
    # Visualization
    tabPanel("Visualization", 
             navlistPanel("DATA VISUALIZATION", 
             tabPanel("Price Timeline",wellPanel(tabPanel("Price Timeline"), 
                      align="center",
                      plotlyOutput("plot1"),
                      wellPanel(h4("Price Timeline"),
                      p("As shown above, The Bitcoin’s price increased exponentially
                      during the past 5 years. This shows that more people 
                      are more involved Bitcoin over the past years. 
                      The time-series graph shows that between the year 2020 and 
                      2021,  the price of bitcoin skyrocketed to an unprecedented 
                      amount; a 1000% increase in just a span of a few months.")))
                      ),
             
             tabPanel("Energy Consumption Timeline",wellPanel(tabPanel("Energy Consumption Timeline"),
                      align="center",
                      plotlyOutput("plot2"),
                      wellPanel(h4("Energy Consumption Timeline"),
                      p("Relative to the rising popularity of bitcoin, the 
                      energy consumption of bitcoin also exploded. As shown above, 
                      between the year 2020 and 2021, the Bitcoin’s energy consumption 
                      doubled. This increase in energy consumption is alarming, 
                      as the world’s total energy consumption is reliant to the
                      burning of fossil fuel, which is one of the biggest contributor 
                      of GHG emissions in the Earth’s atmosphere.")))
                      ),
             
             tabPanel("Data Correlation",wellPanel(tabPanel("Price and Consumption Correlation"),
                      align="center",
                      plotlyOutput("plot3"),
                      wellPanel(h4("Price and Consumption Relationship"),
                      p("The resulting correlation coefficient returned as 0.8518158, which
                      means that there is a very strong correlation between the two variables and that
                      the increase in price of bitcoin also increases the required energy to be
                      consumed. We can observe that the variables in the scatter plot are somewhat 
                      close to the linear regression line. There is a bit of scattering observable in
                      the plot. However, we can clearly observe  the variables moving 
                      in a linear trend.")))
                      ),
             
             tabPanel("About the Visualization Model",wellPanel( 
                      wellPanel(
                      h4(style = "text-align: justify;", "Time Series Plots"),
                      p(style = "text-align: justify;",
                      "A time series plot is a graph that displays data collected in a time sequence 
                      from any process. The chart can be used to determine how the data is trending over 
                      time and if the data points are random or exhibit any pattern."),
                      h4(style = "text-align: justify;", "Scatter Plots"),
                      p(style = "text-align: justify;",
                      "The scatter plot on the other hand is a type of plot or mathematical diagram that
                      uses the Cartesian coordinates to display values for typically two variables 
                      for a set of data. If the points are coded, one additional 
                      variable can be displayed.")))
                      )
             )),
     
    
    # Forecasting
    tabPanel("Forecasting", 
             navlistPanel("DATA FORECASTING", 
             tabPanel("Price Forecasting",wellPanel(
                      align="center",
                      dygraphOutput("dygraph1"),
                      wellPanel(h4("Bitcoin Price Forecast for 5 years"),
                      p("Based on the Predictive model, the price of Bitcoin will continue to rise and
                      will reach 100,000 USD in a span of a few months, nearly doubling the current 
                      price of Bitcoin. We can aso observe in the model that the price of Bitcoin will 
                      continue to increase exponentially in the following years.")))
                      ),
             
             tabPanel("Energy Consumption Forecasting",wellPanel( 
                      align="center",
                      dygraphOutput("dygraph2"),
                      wellPanel(h4("Bitcoin Energy Consumption Forecast for 5 years"),
                      p("The Predictive model of the Bitcoin Energy Consumption also shows an
                      increase in the energy consumption. Based on the predictive model, the energy 
                      consumption required to mine Bitcoin will increase exponentially on the succeeding 
                      years and will continue to grow in correlation with the price of Bitcoin.")))
                      ),
             
             tabPanel("About the Forecasting Model",wellPanel( 
                      wellPanel(h4(style = "text-align: justify;", "Prophet Forecasting"),
                      p(style = "text-align: justify;", 
                      "Forecasting is a statistical technique used to estimate or predict future values
                      by utilizing historical data as the basis for the prediction. There is a lot of
                      forecasting method available. However, I preferred to use the prophet package developed by 
                      Facebook. Prophet is a procedure for forecasting time series data based on an additive 
                      model where non-linear trends are fit with yearly, weekly, and daily seasonality, 
                      plus holiday effects. It works best with time series that have strong seasonal 
                      effects and several seasons of historical data. Prophet is robust to missing data and 
                      shifts in the trend, and typically handles outliers well. It is available for 
                      download on both CRAN and PyPI.")))
                      )
             )),       
    
    
    # About
    tabPanel("About",
             fluidRow(column(12,wellPanel(
                      h4(style = "text-align: justify;", "ABOUT THE AUTHOR"),
                      p(style = "text-align: justify;",
                      "Kristian Moreno is a Filipino Data Science Student
                      at the University of Southeastern Philippines in Davao City. 
                      He is currently finishing his undergraduate studies in the said 
                      University and is aiming to become a Data Scientist after graduating.")))
                      ),
             
             fluidRow(column(12,wellPanel(
                      h4(style = "text-align: justify;","DATA SOURCES"),
                      p(style = "text-align: justify;",
                      "Bitcoin Price Dataset from: https://www.cryptodatadownload.com/data/binance/"),
                      p(style = "text-align: justify;",
                      "Bitcoin Energy Consumption Dataset from: https://ccaf.io/cbeci/index")))
                      ),
                      
             fluidRow(column(12,wellPanel(
                      h4(style = "text-align: justify;", "CONTACT AUTHOR"),
                      p(style = "text-align: justify;",
                      "Email: kmoreno@usep.edu.ph"),
                      p(style = "text-align: justify;",
                      "Github: https://github.com/KrXhian"),
                      p(style = "text-align: justify;",
                      "Phone: (+63)961-341-9314")))
                      ),
             
             fluidRow(column(12,wellPanel(
                      h4(style = "text-align: justify;", "ADDITIONAL INFORMATION"),
                      p(style = "text-align: justify;",
                      "All required specifications of the Machine Problems in Modules 1-4 are 
                      applied in this shiny application.")))
                      )
             )
)