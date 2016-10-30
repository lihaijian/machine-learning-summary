#QDA
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
qda.fit = qda(Direction~Lag1+Lag2,data = Smarket,subset = train)
qda.fit
summary(qda.fit)

qda.class = predict(qda.fit,Smarket.2005)$class
table(qda.class,Direction.2005)

mean(qda.class == Direction.2005)