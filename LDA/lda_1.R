#LDA
library(ISLR)
names(Smarket)
dim(Smarket)
summary(Smarket)
pairs(Smarket)
View(Smarket)
str(Smarket)

cor(Smarket)
cor(Smarket[,-9])
attach(Smarket)

train = (Year < 2005)#True or False
length(train)#1250
Smarket.2005 = Smarket[!train,] #2005ÄêµÄ

dim(Smarket.2005)

Direction.2005 = Direction[!train]

library(MASS)
lda.fit = lda(Direction~Lag1+Lag2,data = Smarket,subset =train)
lda.fit
summary(lda.fit)
lda.pred = predict(lda.fit,Smarket.2005)

names(lda.pred)

lda.class = lda.pred$class
table(lda.class,Direction.2005)
mean(lda.class == Direction.2005)

sum(lda.pred$posterior[,1] >= .5)
sum(lda.pred$posterior[,1] < .5)

lda.pred$posterior[1:20,1]
lda.class[1:20]

sum(lda.pred$posterior[,1] > .9)