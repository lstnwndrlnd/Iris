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

modFit <- train(Species~.,method="rpart",data=Iris)

g1 <- ggplot(data=iris, aes(x = Sepal.Length, y = Sepal.Width))

g1 + geom_point(aes(color=Species, shape=Species)) +
  xlab("Sepal Length") +  ylab("Sepal Width") +
  ggtitle("Sepal Length-Width")

rr <- rpart(factor(Species) ~  sepLength + petLength + sepWidth
            # + petWidth
            , data = Iris
)

multiclass.model <- rpart(Iris$Species~., data=Iris)
rpart.plot(multiclass.model)

DTreepreds <- predict(rr)[,2]
messageMetrics(DTreepreds, "Decision Tree")


