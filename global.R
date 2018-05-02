library(xgboost)
library(tidyverse)
library(DT)

IrisClass <- xgb.load("iris.model")

load("IrisClassInfo.rda")

generatePreds <- function(sepLength = mean(sepLength)
                          ,sepWidth = mean(sepWidth)
                          ,petLength = mean(petLength)
                          ,petWidth = mean(petWidth)
){
  testDF <- as.matrix(
    sepLength
    ,sepWidth 
    ,petLength
    ,petWidth 
  )
  
  preds <- predict(IrisClass, testDF)
  
  data.frame(
    Species = var.levels
    ,preds
  ) %>%
    arrange(desc(preds))
}

