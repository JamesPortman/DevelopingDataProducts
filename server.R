library(shiny)
library(datasets)

mtcars$am <- as.factor(mtcars$am)
levels(mtcars$am) <- c("Automatic", "Manual")
mpgData <- mtcars

shinyServer(function(input, output) {
  
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  
  formulaTextPoint <- reactive({
    paste("mpg ~", "as.integer(", input$variable, ")")
  })
  
  fit <- reactive({
    lm(as.formula(formulaTextPoint()), data = mpgData)
  })
  
  output$caption <- renderText({
    formulaText()
  })
  
  output$mpgBoxPlot <- renderPlot({
    boxplot(as.formula(formulaText()), 
            data = mpgData,
            xlab="Miles per Gallon",
            horizontal = TRUE)
  })
  
  output$mpgHistPlot <- renderPlot({
   
    x <- mpgData$mpg
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    h<-hist(x, breaks=bins, col="red", xlab="Miles per gallon", ylab="Frequency of Cars", main="Cars per mpg") 
    
    # Add a Normal Curve (Thanks to Peter Dalgaard)
    xfit<-seq(min(x),max(x),length=40) 
    yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
    yfit <- yfit*diff(h$mids[1:2])*length(x) 
    lines(xfit, yfit, col="blue", lwd=2)
    
    
  })
  
  output$fit <- renderPrint({
    summary(fit())
  })
  
  output$mpgPlot <- renderPlot({
    with(mpgData, {
      plot(as.formula(formulaTextPoint()))
      abline(fit(), col=2)
    })
  })
  
})