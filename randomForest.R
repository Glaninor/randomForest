library(randomForest)
library(ROCR)

ntrain = sample(nrow(all.judge),floor(0.7*nrow(all.judge)),replace=FALSE)
train = all.judge[ntrain,]
test = all.judge[-ntrain,]
train[which(is.na(train[1,]))]
train <- train[,-which(names(train)=="mcq240y")]
train <- train[,-which(names(train)=="mcq240r")]
train <- train[,-which(names(train)=="mcq240k")]
train <- train[,-which(names(train)=="mcq240i")]
train <- train[,-which(names(train)=="mcq240d")]
train <- train[,-which(names(train)=="mcq230d")]
test <- test[,-which(names(test)=="mcq240y")]
test <- test[,-which(names(test)=="mcq240r")]
test <- test[,-which(names(test)=="mcq240k")]
test <- test[,-which(names(test)=="mcq240i")]
test <- test[,-which(names(test)=="mcq240d")]
test <- test[,-which(names(test)=="mcq230d")]
rf.train.x <- as.matrix(train[,3:1278])
rf.train.y <- as.matrix(train[,2])
rf.test.x <- as.matrix(test[,3:1278])
rf.test.y <- as.matrix(test[,2])

rf.model <- randomForest(x=rf.train.x,y=rf.train.y,ntree=500,mtry=500,importance=TRUE,proximity=TRUE)
print(rf.model)

Call:
 randomForest(x = rf.train.x, y = rf.train.y, ntree = 500, mtry = 500,      importance = TRUE, proximity = TRUE) 
               Type of random forest: regression
                     Number of trees: 500
No. of variables tried at each split: 500

          Mean of squared residuals: 0.2124953
                    % Var explained: 14.74

rf.predict <- predict(rf.model,rf.test.x)
rf.prediction <- prediction(rf.predict,rf.test.y)
rf.prediction.auc <- performance(rf.prediction,'auc')
rf.prediction.auc@y.values

[[1]]
[1] 0.7530366

rf.importance.plot <- varImpPlot(rf.model,sort=TRUE,n.var=40)

