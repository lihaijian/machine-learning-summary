data(agaricus.train, package='xgboost')
data(agaricus.test, package='xgboost')
train <- agaricus.train
test <- agaricus.test
test$label


str(train)
dim(train$data)
dim(test$data)
class(train$data)[1]
class(train$label)


bstSparse <- xgboost(data = train$data, label = train$label, max.depth = 2, eta = 1, nthread = 2, nround = 2, objective = "binary:logistic")

bstDense <- xgboost(data = as.matrix(train$data), label = train$label, max.depth = 2, eta = 1, nthread = 2, nround = 2, objective = "binary:logistic")

dtrain <- xgb.DMatrix(data = train$data, label = train$label)

bstDMatrix <- xgboost(data = dtrain, max.depth = 2, eta = 1, nthread = 2, nround = 2, objective = "binary:logistic")


bst_1 <- xgboost(data = dtrain, max.depth = 2, eta = 1, nthread = 6, nround = 2, objective = "binary:logistic", verbose = 0)
bst_2 <- xgboost(data = dtrain, max.depth = 2, eta = 1, nthread = 2, nround = 2, objective = "binary:logistic", verbose = 1)
bst_3 <- xgboost(data = dtrain, max.depth = 2, eta = 1, nthread = 2, nround = 6, objective = "binary:logistic", verbose = 2)


pred <- predict(bst_3, test$data)
library(pROC)  
auc = roc(test$label, pred)
print(auc$auc)



prediction <- as.numeric(pred > 0.5)
print(head(prediction))

## predictingAverageError
err <- mean(as.numeric(pred > 0.5) != test$label)
print(paste("test-error=", err))

## ----DMatrix, message=F, warning=F---------------------------------------
dtrain <- xgb.DMatrix(data = train$data, label=train$label)
dtest <- xgb.DMatrix(data = test$data, label=test$label)

## ----watchlist, message=F, warning=F-------------------------------------
watchlist <- list(train=dtrain, test=dtest)

bst <- xgb.train(data=dtrain, max.depth=2, eta=1, nthread = 2, nround=2, watchlist=watchlist, objective = "binary:logistic")

## ----watchlist2, message=F, warning=F------------------------------------
bst <- xgb.train(data=dtrain, max.depth=2, eta=1, nthread = 2, nround=2, watchlist=watchlist, eval.metric = "error", eval.metric = "logloss", objective = "binary:logistic")

## ----linearBoosting, message=F, warning=F--------------------------------
bst <- xgb.train(data=dtrain, booster = "gblinear", max.depth=2, nthread = 2, nround=2, watchlist=watchlist, eval.metric = "error", eval.metric = "logloss", objective = "binary:logistic")

## ----DMatrixSave, message=F, warning=F-----------------------------------
xgb.DMatrix.save(dtrain, "dtrain.buffer")
# to load it in, simply call xgb.DMatrix
dtrain2 <- xgb.DMatrix("dtrain.buffer")
bst <- xgb.train(data=dtrain2, max.depth=2, eta=1, nthread = 2, nround=2, watchlist=watchlist, objective = "binary:logistic")

## ----DMatrixDel, include=FALSE-------------------------------------------
file.remove("dtrain.buffer")

## ----getinfo, message=F, warning=F---------------------------------------
label = getinfo(dtest, "label")
pred <- predict(bst, dtest)
err <- as.numeric(sum(as.integer(pred > 0.5) != label))/length(label)
print(paste("test-error=", err))

## ----dump, message=T, warning=F------------------------------------------
xgb.dump(bst, with.stats = T)

## ----saveModel, message=F, warning=F-------------------------------------
# save model to binary local file
xgb.save(bst, "xgboost.model")

## ----loadModel, message=F, warning=F-------------------------------------
# load binary model to R
bst2 <- xgb.load("xgboost.model")
pred2 <- predict(bst2, test$data)

# And now the test
print(paste("sum(abs(pred2-pred))=", sum(abs(pred2-pred))))

## ----clean, include=FALSE------------------------------------------------
# delete the created model
file.remove("./xgboost.model")

## ----saveLoadRBinVectorModel, message=F, warning=F-----------------------
# save model to R's raw vector
rawVec <- xgb.save.raw(bst)

# print class
print(class(rawVec))

# load binary model to R
bst3 <- xgb.load(rawVec)
pred3 <- predict(bst3, test$data)

# pred2 should be identical to pred
print(paste("sum(abs(pred3-pred))=", sum(abs(pred2-pred))))

