library(xgboost)
library(tidyverse)
library(DT)

IrisClass <- load("./IrisClassInfo.rda")

model <- readRDS("./final_model.rds")

generatePreds <- function(sepLength = mean(sepLength)
                          , sepWidth = mean(sepWidth)
                          , petLength = mean(petLength)
                          , petWidth = mean(petWidth)
                          ){
  testDF <- as.matrix(
    sepLength, sepWidth , petLength, petWidth 
  )
  
  preds <- predict(IrisClass, testDF)
  
  data.frame(
    Species = DiamondClassInfo$var.levels
    ,preds
  ) %>%
    arrange(desc(preds))
}
