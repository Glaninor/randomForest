library(randomForest)
library(ROCR)

rf.train.x <- as.matrix(train[,3:1278])
rf.train.y <- as.matrix(train[,2])
rf.test.x <- as.matrix(test[,3:1278])
rf.test.y <- as.matrix(test[,2])

rf.model <- randomForest(x=rf.train.x,y=rf.train.y,ntree=500,importance=TRUE,proximity=TRUE)
print(rf.model)
Call:
 randomForest(x = rf.train.x, y = rf.train.y, ntree = 500, importance = TRUE,      proximity = TRUE) 
               Type of random forest: regression
                     Number of trees: 500
No. of variables tried at each split: 425

          Mean of squared residuals: 0.2123665
                    % Var explained: 14.64

rf.predict <- predict(rf.model,rf.test.x)
rf.prediction <- prediction(rf.predict,rf.test.y)
rf.prediction.auc <- performance(rf.prediction,'auc')
rf.prediction.auc@y.values
[[1]]
[1] 0.7530366

rf.importance.plot <- varImpPlot(rf.model,sort=TRUE,n.var=40)
