> Logistic regression

the first one example for the logistic regression.Now let's begin the code for logistic regression.

download some r packages

```
install.packages("ISLR")
```

then,begin the data analysis.

```
> library(ISLR)
> names(Smarket)
[1] "Year"      "Lag1"      "Lag2"      "Lag3"      "Lag4"      "Lag5"     
[7] "Volume"    "Today"     "Direction"

> dim(Smarket)
[1] 1250    9

> summary(Smarket)
     Year                         Lag1                     
 Min.   :2001.0000000000000   Min.   :-4.92199999999999971  
 1st Qu.:2002.0000000000000   1st Qu.:-0.63949999999999996  
 Median :2003.0000000000000   Median : 0.03900000000000000  
 Mean   :2003.0160000000001   Mean   : 0.00383440000000000  
 3rd Qu.:2004.0000000000000   3rd Qu.: 0.59675000000000011  
 Max.   :2005.0000000000000   Max.   : 5.73299999999999965  
      Lag2                             Lag3                       
 Min.   :-4.9219999999999997087   Min.   :-4.9219999999999997087  
 1st Qu.:-0.6394999999999999574   1st Qu.:-0.6400000000000000133  
 Median : 0.0389999999999999999   Median : 0.0384999999999999995  
 Mean   : 0.0039192000000000003   Mean   : 0.0017160000000000001  
 3rd Qu.: 0.5967500000000001137   3rd Qu.: 0.5967500000000001137  
 Max.   : 5.7329999999999996518   Max.   : 5.7329999999999996518  
      Lag4                             Lag5                       
 Min.   :-4.9219999999999997087   Min.   :-4.9219999999999997087  
 1st Qu.:-0.6400000000000000133   1st Qu.:-0.6400000000000000133  
 Median : 0.0384999999999999995   Median : 0.0384999999999999995  
 Mean   : 0.0016360000000000001   Mean   : 0.0056096000000000002  
 3rd Qu.: 0.5967500000000001137   3rd Qu.: 0.5969999999999999751  
 Max.   : 5.7329999999999996518   Max.   : 5.7329999999999996518  
     Volume                       Today                      Direction 
 Min.   :0.3560700000000000   Min.   :-4.92199999999999971   Down:602  
 1st Qu.:1.2574000000000001   1st Qu.:-0.63949999999999996   Up  :648  
 Median :1.4229499999999999   Median : 0.03850000000000000             
 Mean   :1.4783050000000000   Mean   : 0.00313840000000000             
 3rd Qu.:1.6416750000000000   3rd Qu.: 0.59675000000000011             
 Max.   :3.1524700000000001   Max.   : 5.73299999999999965   
> pairs(Smarket)#图片如下pairs_picture.png

> str(Smarket)
'data.frame':	1250 obs. of  9 variables:
 $ Year     : num  2001 2001 2001 2001 2001 ...
 $ Lag1     : num  0.381 0.959 1.032 -0.623 0.614 ...
 $ Lag2     : num  -0.192 0.381 0.959 1.032 -0.623 ...
 $ Lag3     : num  -2.624 -0.192 0.381 0.959 1.032 ...
 $ Lag4     : num  -1.055 -2.624 -0.192 0.381 0.959 ...
 $ Lag5     : num  5.01 -1.055 -2.624 -0.192 0.381 ...
 $ Volume   : num  1.19 1.3 1.41 1.28 1.21 ...
 $ Today    : num  0.959 1.032 -0.623 0.614 0.213 ...
 $ Direction: Factor w/ 2 levels "Down","Up": 2 2 1 2 2 2 1 2 2 2 ...

```

图
![pairs_picture](E:\\workp\\github_ku\\machine-learning-summary\\logistic regression\\pairs_pictures.png)



```
> glm.fit = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data=Smarket,family=binomial)
> summary(glm.fit)

Call:
glm(formula = Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + 
    Volume, family = binomial, data = Smarket)

Deviance Residuals: 
   Min      1Q  Median      3Q     Max  
-1.446  -1.203   1.065   1.145   1.326  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)
(Intercept) -0.126000   0.240736  -0.523    0.601
Lag1        -0.073074   0.050167  -1.457    0.145
Lag2        -0.042301   0.050086  -0.845    0.398
Lag3         0.011085   0.049939   0.222    0.824
Lag4         0.009359   0.049974   0.187    0.851
Lag5         0.010313   0.049511   0.208    0.835
Volume       0.135441   0.158360   0.855    0.392

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 1731.2  on 1249  degrees of freedom
Residual deviance: 1727.6  on 1243  degrees of freedom
AIC: 1741.6

Number of Fisher Scoring iterations: 3


> coef(glm.fit)
 (Intercept)         Lag1         Lag2         Lag3         Lag4         Lag5       Volume 
-0.126000257 -0.073073746 -0.042301344  0.011085108  0.009358938  0.010313068  0.135440659 
> summary(glm.fit)$coef
                Estimate Std. Error    z value  Pr(>|z|)
(Intercept) -0.126000257 0.24073574 -0.5233966 0.6006983
Lag1        -0.073073746 0.05016739 -1.4565986 0.1452272
Lag2        -0.042301344 0.05008605 -0.8445733 0.3983491
Lag3         0.011085108 0.04993854  0.2219750 0.8243333
Lag4         0.009358938 0.04997413  0.1872757 0.8514445
Lag5         0.010313068 0.04951146  0.2082966 0.8349974
Volume       0.135440659 0.15835970  0.8552723 0.3924004
> summary(glm.fit)$coef[,4]
(Intercept)        Lag1        Lag2        Lag3        Lag4        Lag5      Volume 
  0.6006983   0.1452272   0.3983491   0.8243333   0.8514445   0.8349974   0.3924004 
> glm.probs = predict(glm.fit,type = "response")
> glm.pred = rep("Down",1250)
> glm.pred[glm.probs > .5] = "Up"
> table(glm.pred,Direction)
        Direction
glm.pred Down  Up
    Down  145 141
    Up    457 507
> (141+457)/1250
[1] 0.4784
> mean(glm.pred == Direction)
[1] 0.5216


> train = (Year < 2005)#True or False
> length(train)#1250
[1] 1250
> Smarket.2005 = Smarket[!train,] #2005年的
> dim(Smarket.2005)
[1] 252   9
> Direction.2005 = Direction[!train]
> glm.fit = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data = Smarket,family=binomial,subset=train)
> summary(glm.fit)

Call:
glm(formula = Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + 
    Volume, family = binomial, data = Smarket, subset = train)

Deviance Residuals: 
   Min      1Q  Median      3Q     Max  
-1.302  -1.190   1.079   1.160   1.350  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)
(Intercept)  0.191213   0.333690   0.573    0.567
Lag1        -0.054178   0.051785  -1.046    0.295
Lag2        -0.045805   0.051797  -0.884    0.377
Lag3         0.007200   0.051644   0.139    0.889
Lag4         0.006441   0.051706   0.125    0.901
Lag5        -0.004223   0.051138  -0.083    0.934
Volume      -0.116257   0.239618  -0.485    0.628

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 1383.3  on 997  degrees of freedom
Residual deviance: 1381.1  on 991  degrees of freedom
AIC: 1395.1

Number of Fisher Scoring iterations: 3

> glm.probs = predict(glm.fit,Smarket.2005,type = "response")
> glm.pred= rep("Down",252)
> glm.pred[glm.probs > .5] = "Up"
> table(glm.pred,Direction.2005)
        Direction.2005
glm.pred Down Up
    Down   77 97
    Up     34 44
> mean(glm.pred == Direction.2005)
[1] 0.4801587



> glm.fit = glm(Direction~Lag1+Lag2,data = Smarket,family=binomial,subset=train)
> summary(glm.fit)

Call:
glm(formula = Direction ~ Lag1 + Lag2, family = binomial, data = Smarket, 
    subset = train)

Deviance Residuals: 
   Min      1Q  Median      3Q     Max  
-1.345  -1.188   1.074   1.164   1.326  

Coefficients:
            Estimate Std. Error z value Pr(>|z|)
(Intercept)  0.03222    0.06338   0.508    0.611
Lag1        -0.05562    0.05171  -1.076    0.282
Lag2        -0.04449    0.05166  -0.861    0.389

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 1383.3  on 997  degrees of freedom
Residual deviance: 1381.4  on 995  degrees of freedom
AIC: 1387.4

Number of Fisher Scoring iterations: 3

> glm.probs = predict(glm.fit,Smarket.2005,type = "response")
> glm.pred = rep("Down",252)
> glm.pred[glm.probs > .5]="Up"
> table(glm.pred,Direction.2005)
        Direction.2005
glm.pred Down  Up
    Down   35  35
    Up     76 106
> mean(glm.pred == Direction.2005)
[1] 0.5595238
> predict(glm.fit,newdata = data.frame(Lag1 = c(1.2,1.5),Lag2 = c(1.1,-0.8)),type = "response")
        1         2 
0.4791462 0.4960939 

```