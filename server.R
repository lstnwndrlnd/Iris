server <- function(input,output){
  
  
  Preds <- reactive({
    generatePreds(
      sepLength = input$sepLength
      ,sepWidth = input$sepWidth
      ,petLength = input$petLength
    )
  })
  
  output$pred_table <- DT::renderDataTable({
    Preds() %>%
      datatable() %>%
      formatPercentage(columns = 'preds', digits = 2)
  })
  
}