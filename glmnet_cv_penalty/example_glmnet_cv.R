library(Matrix)
library(glmnet)
library(pROC)


some_dataframe <- read.table("C:\\Users\\zhangxiang\\Desktop\\some_data.txt",header =T)
View(some_dataframe)
print(some_dataframe)
some_matrix <- data.matrix(some_dataframe[1:10])
print(some_matrix)

#spare matrix
library(Matrix)
print(Matrix(some_matrix, sparse=TRUE))


#2/3 train,1/3 test
set.seed(2)
split <- sample(nrow(some_dataframe), floor(0.7*nrow(some_dataframe)))
train <-some_dataframe[split,]
test <- some_dataframe[-split,]

train[,1:10]

#spare model
library(glmnet) 
train_sparse <- sparse.model.matrix(~.,train[,1:10])
test_sparse <- sparse.model.matrix(~.,test[,1:10])
print(train_sparse)


fit <- glmnet(train_sparse,train[,11])
pred <- predict(fit, test_sparse, type="class")
print(head(pred[,1:5]))


#cv,use cv.glmnet to find best lambda/penalty 
cv <- cv.glmnet(train_sparse,train[,11],nfolds=3)
pred <- predict(fit, test_sparse,type="response", s=cv$lambda.min)


#  receiver operating characteristic (ROC curves)
library(pROC)  
auc = roc(test[,11], pred)
print(auc$auc)
























