server <- function(input,output){
  
  
  Preds <- reactive({
    generatePreds(
      sepLength = input$Sepal.Length
      ,sepWidth = input$Sepal.Width
      ,petLength = input$Petal.Length
      ,petWidth = input$Petal.Width
    )
  })
  
  output$pred_table <- DT::renderDataTable({
    Preds() %>%
      datatable() %>%
      formatPercentage(columns = 'preds', digits = 2)
  })
  
  output$plot1 <-renderPlot({
    ggplot(data=iris, aes(x = Sepal.Length, y = Sepal.Width))+ 
      geom_point(aes(color=Species, shape=Species)) +
      xlab("Sepal Length") +  ylab("Sepal Width") +
      ggtitle("Sepal Length-Width") # +
      # geom_vline(aes(xintercept = "Sepal.Length")
      #            , color = "red", linetype = "dashed") +
      # geom_hline(aes(yintercept = "Sepal.Width")
      #            , color = "red", linetype = "dashed")
  })
  
  output$plot2 <- renderPlot({
    ggplot(data=iris, aes(x=Sepal.Width, fill=Species))+
      geom_density(stat="density", alpha=I(0.2)) +
      xlab("Sepal Width") +  ylab("Density") +
      ggtitle("Density Curve of Sepal Width")
  })
  
}

# output$plot1 <- renderPlot({
#   plot(mtcars$wt, mtcars$mpg)