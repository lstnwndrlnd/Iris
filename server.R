server <- function(input,output){
  
  
  Preds <- reactive({
    # generatePreds(
    #   depth = input$Depth
    #   ,table = input$Table
    #   ,price = input$Price
    # )
  })
  
  output$pred_table <- DT::renderDataTable({
    # Preds() %>%
    #   datatable() %>%
    #   formatPercentage(columns = 'preds', digits = 2)
  })
  
}