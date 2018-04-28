library(xgboost)
library(tidyverse)
library(ggplot2)
library(rpart)
library(rpart.plot)
library(ModelMetrics)

Iris <- iris

messageMetrics <- function(preds, modelName = "GLM"){
  # AUC = auc(Iris$Species, preds)
  LL = logLoss(Iris$Species, preds)
  message(paste(modelName, ": ", "logLoss =", LL))
} # make a function

sepLength <- Iris$Sepal.Length
sepWidth <- Iris$Sepal.Width
petLength <- Iris$Petal.Length
petWidth <- Iris$Petal.Width

# modFit <- train(Species~.,method="rpart",data=Iris)
# 
# g1 <- ggplot(data=iris, aes(x = Sepal.Length, y = Sepal.Width))
# 
# g1 + geom_point(aes(color=Species, shape=Species)) +
#   xlab("Sepal Length") +  ylab("Sepal Width") +
#   ggtitle("Sepal Length-Width")

y1 <- Iris$Species
var.levels <- levels(y1)
# returns the options for data that can take one discrete values

y = as.integer(y1) - 1

var.names <- names(Iris)
x = as.matrix(Iris)

params <- list(
  "objective" = "multi:softprob"
  ,"eval_metric" = "mlogloss"
  ,"num_class" = length(table(y))
  ,"eta" = .5 # step size for xgboost
  ,"max_depth" = 3
)

cv.nround = 250

bst.cv <- xgb.cv(param = params,data = x, nrounds = cv.nround
                 ,nfold = 5
                 ,label = y
                 ,missing = NA
                 ,prediction = TRUE
)
# param = params, 
# label is like outcome

which.min(bst.cv$evaluation_log$test_mloglss_mean)
bst.cv$evaluation_log[nrounds,]

IrisClass <- xgboost(param = params, data = x, label = y
                        ,nrounds = cv.nround, missing = NA)