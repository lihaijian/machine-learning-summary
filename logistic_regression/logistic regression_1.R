install.packages("ISLR")
library(ISLR)
names(Smarket)
dim(Smarket)
summary(Smarket)
pairs(Smarket)
View(Smarket)



glm.fit = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data=Smarket,family=binomial)
summary(glm.fit)


coef(glm.fit)
summary(glm.fit)$coef

summary(glm.fit)$coef[,4]
glm.probs = predict(glm.fit,type = "response")


glm.pred = rep("Down",1250)
glm.pred[glm.probs > .5] = "Up"

table(glm.pred,Direction)

(141+457)/1250

mean(glm.pred == Direction)


train = (Year < 2005)#True or False
length(train)#1250
Smarket.2005 = Smarket[!train,] #2005ÄêµÄ

dim(Smarket.2005)

Direction.2005 = Direction[!train]

glm.fit = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data = Smarket,family=binomial,subset=train)
summary(glm.fit)

glm.probs = predict(glm.fit,Smarket.2005,type = "response")

glm.pred= rep("Down",252)
glm.pred[glm.probs > .5] = "Up"
table(glm.pred,Direction.2005)

mean(glm.pred == Direction.2005)






glm.fit = glm(Direction~Lag1+Lag2,data = Smarket,family=binomial,subset=train)
summary(glm.fit)

glm.probs = predict(glm.fit,Smarket.2005,type = "response")
glm.pred = rep("Down",252)
glm.pred[glm.probs > .5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred == Direction.2005)

predict(glm.fit,newdata = data.frame(Lag1 = c(1.2,1.5),Lag2 = c(1.1,-0.8)),type = "response")