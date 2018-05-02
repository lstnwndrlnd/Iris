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


noOutcome <- Iris[,-5]
x = noOutcome[,c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width')]
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

bst.cv <- xgb.cv(param = params
                 ,data = x
                 ,nrounds = cv.nround
                 ,nfold = 5
                 ,label = y
                 ,missing = NA
                 ,prediction = TRUE
)
# param = params, 
# label is like outcome

which.min(bst.cv$evaluation_log$test_mloglss_mean)
bst.cv$evaluation_log[cv.nround,]

IrisClass <- xgboost(param = params, data = x, label = y
                        ,nrounds = cv.nround, missing = NA)
xgb.importance(var.names, model = IrisClass)
xgb.save(IrisClass, "iris.model")

IrisClassInfo <- list(var.names = var.names
                         ,var.levels = var.levels)

save(IrisClassInfo, file = 'IrisClassInfo.rda')

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


















