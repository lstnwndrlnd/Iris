library(xgboost)
library(tidyverse)
library(DT)

IrisClass <- xgb.load("iris_rpart_model.model")

load("DiamondClassInfo.rda")

generatePreds <- function(depth = 60, table = 50, price = 335, x = 4, y = 4){
  testDF <- as.matrix(
    depth, table, price, x, y
  )
  
  preds <- predict(DiamondClass, testDF)
  
  data.frame(
    Cut = DiamondClassInfo$var.levels
    ,preds
  ) %>%
    arrange(desc(preds))
}