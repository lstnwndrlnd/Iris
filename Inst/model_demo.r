library(xgboost)
library(tidyverse)

Diamonds <- diamonds

y1 <- Diamonds$cut
var.levels <- levels(y1)
# returns the options for data that can take one discrete values

y = as.integer(y1) - 1

noOutcome <- Diamonds[,-2]
x = noOutcome[,c('depth', 'table', 'price', 'x', 'y')]
# base r version of select function from dplyr
var.names <- names(x)
x = as.matrix(x)

params <- list(
  "objective" = "multi:softprob"
  ,"eval_metric" = "mlogloss"
  ,"num_class" = length(table(y))
  ,"eta" = .5 # step size for xgboost
  ,"max_depth" = 3
)

cv.nround = 250

bst.cv <- xgb.cv(param = params, data = x, label = y
                 ,nfold = 5, nrounds = cv.nround
                 ,missing = NA, prediction = TRUE
                 )
# label is like outcome

which.min(bst.cv$evaluation_log$test_mloglss_mean)
bst.cv$evaluation_log[nrounds,]

DiamondClass <- xgboost(param = params, data = x, label = y
                        ,nrounds = cv.nround, missing = NA)

xgb.importance(var.names, model = DiamondClass)
xgb.save(DiamondClass, "diamonds.model")

DiamondClassInfo <- list(var.names = var.names
                          ,var.levels = var.levels)

save(DiamondClassInfo, file = 'DiamondClassInfo.rda')

generatePreds <- function(depth = 60, table = 50, price = 335, x = 4, y = 4){
    testDF <- as.matrix(
      depth, table, price, x, y
    )
  
  preds <- predict(DiamondClass, testDF)
  
  data.frame(
    Cut = var.levels
    ,preds
  ) %>%
    arrange(desc(preds))
}

































