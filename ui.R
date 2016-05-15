# ui.R
# Date: May 14, 2016
# Author: James Portman

library(shiny)

shinyUI(
  navbarPage("Motor Trend Analysis",
            
             # Panel 1 Provide background documentation.
             tabPanel("Documentation",
                      h4("Background"),
                      "The data is from the 1974 Motor Trend magazine article that lists 10 car specifications for 32 different types of cars. The manual cars in the set of data tend to have better MPG ratings but this can be explained by other specifications such as horsepower and weight.",
                      hr(),
                      h4("Original Project"),
                      helpText(  a("View PDF on GitHub", href="https://github.com/JamesPortman/DevelopingDataProducts/blob/master/DoesTransmissionTypeAffectMPG.pdf"))
             ),
             
             # Panel 2 Show a basic histogram of the data with a normal curve superimposed
             tabPanel("Histogram",
                      
                      sidebarPanel(
                        sliderInput("bins",
                                    "Number of bins:",
                                    min = 5,
                                    max = 15,
                                    value = 10)
                      ),
                      
                      mainPanel(
                        plotOutput("mpgHistPlot")
                      )
                      
             ),
             
             # Panel 3 Show box plots and fitted regression models.
             tabPanel("Analysis",
                      fluidPage(
                        titlePanel("Variables affecting miles per gallon"),
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("variable", "Variable:",
                                        c("Transmission" = "am",
                                          "Horsepower" = "hp",
                                          "Weight" = "wt",
                                          "Cylinders" = "cyl",
                                          "Engine Displacement" = "disp",
                                          "# of Gears" = "gear"
                                        ))
                          ),
                          
                          mainPanel(
                            h3(textOutput("caption")),
                            
                            tabsetPanel(type = "tabs", 
                                        tabPanel("Box Plot", plotOutput("mpgBoxPlot")),
                                        tabPanel("Regression model", plotOutput("mpgPlot"), verbatimTextOutput("fit")
                                        )
                            )
                          )
                        )
                      )
             )
    )
)
# End ui.R
