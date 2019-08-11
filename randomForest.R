library(randomForest)
library(ROCR)

rf.train.x <- as.matrix(train[,3:1278])
rf.train.y <- as.matrix(train[,2])
rf.test.x <- as.matrix(test[,3:1278])
rf.test.y <- as.matrix(test[,2])

rf.model <- randomForest(x=rf.train.x,y=rf.train.y,ntree=500,importance=TRUE,proximity=TRUE)
rf.predict <- predict(rf.model,rf.test.x)
rf.prediction <- prediction(rf.predict,rf.test.y)
rf.prediction.auc <- performance(rf.prediction,'auc')
rf.prediction.auc
rf.importance.plot <- varImpPlot(rf.model,sort=TRUE,n.var=40)
