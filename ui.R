ui <- fluidPage(
  titlePanel("Iris species prediction"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("Sepal.Length"
                  ,label = "Sepal Length:"
                  ,value = mean(sepLength)
                  ,min = min(sepLength)
                  ,max = max(sepLength)
                  ,step = .1)
      
      ,sliderInput("Sepal.Width"
                  ,label = "Sepal Width:"
                  ,value = mean(sepWidth)
                  ,min = min(sepWidth)
                  ,max = max(sepWidth)
                  ,step = .1)
      ,sliderInput("Petal.Length"
                  ,label = "Petal Length:"
                  ,value = mean(petLength)
                  ,min = min(petLength)
                  ,max = max(petLength)
                  ,step = .1)
      
      ,sliderInput("Petal.Width"
                   ,label = "Petal Width:"
                   ,value = mean(petWidth)
                   ,min = min(petWidth)
                   ,max = max(petWidth)
                   ,step = .1)
    ),
    mainPanel(
     DT::dataTableOutput("pred_table")
    )
  )
)