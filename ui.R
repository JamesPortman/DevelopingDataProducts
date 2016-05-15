library(shiny)

shinyUI(
  navbarPage("Developing Data Products",
             
             tabPanel("Histogram",
                      
                      sidebarPanel(
                        sliderInput("bins",
                                    "Number of bins:",
                                    min = 1,
                                    max = 10,
                                    value = 6)
                      ),
                      
                      mainPanel(
                        plotOutput("mpgHistPlot")
                      )
                      
             ),
             
             tabPanel("Analysis",
                      fluidPage(
                        titlePanel("Variables affecting miles per gallon (mpg)"),
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
             ),
             
             
             tabPanel("Documentation",
                      
                       h4("Background"),
                      "The data is from the 1974 Motor Trend magazine article that lists 10 car specifications for 32 different types of cars. The manual cars in the set of data tend to have better MPG ratings but this can be explained by other specifications such as horsepower and weight.",
                      hr(),
                      h4("Original Project"),
                      helpText(  a("Download PDF", href="https://github.com/JamesPortman/DevelopingDataProducts/blob/master/DoesTransmissionTypeAffectMPG.pdf"))
             )
  )
)