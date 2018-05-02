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
  
}