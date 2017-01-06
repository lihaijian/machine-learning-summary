rm(list=ls())

#about glmnet
#glmnet(x, y, family=c("gaussian","binomial","poisson","multinomial","cox","mgaussian"),
#       weights, offset=NULL, alpha = 1, nlambda = 100,
#       lambda.min.ratio = ifelse(nobs<nvars,0.01,0.0001), lambda=NULL,
#       standardize = TRUE, intercept=TRUE, thresh = 1e-07,  dfmax = nvars + 1,
#       pmax = min(dfmax * 2+20, nvars), exclude, penalty.factor = rep(1, nvars),
#       lower.limits=-Inf, upper.limits=Inf, maxit=100000,
#       type.gaussian=ifelse(nvars<500,"covariance","naive"),
#       type.logistic=c("Newton","modified.Newton"),
#       standardize.response=FALSE, type.multinomial=c("ungrouped","grouped"))

#weights  权重，默认为1
#offset 
#alpha  0-1
#nlambda  default is 100
#lambda.min.ratio  Smallest value for lambda 数据量大于属性数，0.0001;相反，0.01
#lambda  
#standardize  x 标准化

#thresh  坐标梯度收敛的阈值,默认为1E-7
#dfmax  最大变量数
 
#gaussian   1/2 RSS/nobs + λ*penalty,
#other models   -loglik/nobs + λ*penalty
#penalty  (1-α)/2||β_j||_2^2+α||β_j||_2



library(glmnet)
setwd("D:\\r\\R-3.2.3\\library\\glmnet\\data")
load("QuickStartExample.RData")
fit = glmnet(x, y)
plot(fit)




# Gaussian
x=matrix(rnorm(100*20),100,20)
y=rnorm(100)
fit1=glmnet(x,y)
print(fit1)
coef(fit1,s=0.01) # extract coefficients at a single value of lambda
predict(fit1,newx=x[1:10,],s=c(0.01,0.005)) # make predictions

#multivariate gaussian
y=matrix(rnorm(100*3),100,3)
fit1m=glmnet(x,y,family="mgaussian")
plot(fit1m,type.coef="2norm")

#binomial
g2=sample(1:2,100,replace=TRUE)
fit2=glmnet(x,g2,family="binomial")

#multinomial
g4=sample(1:4,100,replace=TRUE)
fit3=glmnet(x,g4,family="multinomial")
fit3a=glmnet(x,g4,family="multinomial",type.multinomial="grouped")
#poisson
N=500; p=20
nzc=5
x=matrix(rnorm(N*p),N,p)
beta=rnorm(nzc)
f = x[,seq(nzc)]%*%beta
mu=exp(f)
y=rpois(N,mu)
fit=glmnet(x,y,family="poisson")
plot(fit)
pfit = predict(fit,x,s=0.001,type="response")
plot(pfit,y)

#Cox
set.seed(10101)
N=1000;p=30
nzc=p/3
x=matrix(rnorm(N*p),N,p)
beta=rnorm(nzc)
fx=x[,seq(nzc)]%*%beta/3
hx=exp(fx)
ty=rexp(N,hx)
tcens=rbinom(n=N,prob=.3,size=1)# censoring indicator
y=cbind(time=ty,status=1-tcens) # y=Surv(ty,1-tcens) with library(survival)
fit=glmnet(x,y,family="cox")
plot(fit)

# Sparse
n=10000;p=200
nzc=trunc(p/10)
x=matrix(rnorm(n*p),n,p)
iz=sample(1:(n*p),size=n*p*.85,replace=FALSE)
x[iz]=0
sx=Matrix(x,sparse=TRUE)
inherits(sx,"sparseMatrix")#confirm that it is sparse
beta=rnorm(nzc)
fx=x[,seq(nzc)]%*%beta
eps=rnorm(n)
y=fx+eps
px=exp(fx)
px=px/(1+px)
ly=rbinom(n=length(px),prob=px,size=1)
system.time(fit1<-glmnet(sx,y))
system.time(fit2n<-glmnet(x,y))
