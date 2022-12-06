# 12장
library(MASS)
cor(cats$Bwt, cats$Hwt)

# 상관계수의 종류
# 피어슨, 스피어만, 켄달
cor(cats$Bwt, cats$Hwt, method='pearson')
cor(cats$Bwt, cats$Hwt, method='spearman')
cor(cats$Bwt, cats$Hwt, method='kendall')

# 상관계수에 대한 유의성 검증 (2 변수)
# cor.test 사용
cor.test(cats$Bwt, cats$Hwt)

cor.test(~Bwt + Hwt, data=cats)

cor.test(~Bwt + Hwt, data=cats, subset=(Sex=='F'))

# 3개 이상의 변수간의 상관계수 유의성 검정
# corr.test 사용
library(psych)

corr.test(iris[,-5])

print(corr.test(iris[,-5]), short=F)

# 상관관계 도표
library(psych)
pairs.panels(state.x77, bg='red', pch=21, hist.col='gold', main='correlation')

library(corrgram)
corrgram(state.x77, lower.panel = panel.pie, order=T, upper.panel = panel.conf)


# 편상관관계
# 두 변수 간의 관계를 분석할 때는 다른 변수의 영향을 주의 깊게 살펴봐야 함

# 편상관계수 : 두 변수간의 순수한 상관관계를 파악하기 위한 지표
colnames(mtcars)
mtcars2 <- mtcars[,c('mpg', 'cyl', 'hp', 'wt')]

cor(mtcars2)
# 연비와 나머지 3변수는 높은 상관관계를 보여

# 연비와 마력 간의 편상관계수 구하기
library(ggm)

# pcor (벡터, 공분산행렬)
# 벡터의 첫 두 인덱스는 편상관계수를 계산할 변수, 나머지는 통제할 변수
# 공분산행렬은 cov로 계산
pcor(c(1,3,2,4), cov(mtcars2))

# 편상관계수에 대한 유의성 검정 
# pcor.test(pcor함수, q=통제변수 개수, n=행 개수)
pcor.test(pcor(c(1,3,2,4), cov(mtcars2)), q=2, n=nrow(mtcars2))
# p-value는 0.14로 귀무가설을 기각하지 못한다. 그러므로
# mpg와 hp간에는 순수한 상관관계는 존재x
install.packages('ppcor')
library(ppcor)

pcor.test(mtcars2['mpg'], mtcars2['hp'], mtcars2[c('cyl', 'wt')])

# 13장
library(HistData)

df <- GaltonFamilies
str(df)
cor(df$midparentHeight,df$childHeight)
plot(jitter(df$midparentHeight),jitter(df$childHeight), col='coral', pch=19 )


model <-lm(childHeight~ midparentHeight, data=df)

abline(model, col='purple', lwd=3)
# 회귀 계수, 선형회귀식

# 성별별로 회귀선 

# 회귀분석 regression analysis 
# 독립변수와 종속변수의 관계를 잘 설명하는 회귀식을 찾는 과정

# 독립변수와 종속변수의 관계를 설명 또는 예측할 수 있다.

# 잔차(residual, error) : 실제데이터의 값(관측값) 과 회귀식의 값(예측값)과의 차이

# 모형 적합 fitting a model : 데이터 전체를 고려했을 때, 잔차가 가장 작은 직선의 방정식

# 평균절대오차 MAE mean absolute error
# 평균제곱오차 MSE mean squared error
# 제곱근 평균제곱오차 RMSE rooted mean squared error

# 잔차제곱합 RSS 

x <- runif(n=100, min=0, max=100)
y <- 3*x +5 + rnorm(100, 0, 50)
plot(x,y, pch=19, col='hotpink')

cor(x,y)
model <-lm(y ~x)
?lm
abline(model, col='tomato', lwd=2)

summary(model)
# Estimate : 예측값, std.Error : 표준오차, 
# t value : 잔차들의 분포가 t분포를 따르기 때문에 t value 가 나온다. 
# Pr로 기울기와 절편의 유의확률이 나온다. 
# 여기서의 Pr의 귀무가설은 상관관계가 없다 이다.
# 그래서 Pr이 매우 낮게 나오면 귀무가설은 기각되고 대립가설이 채택된다. (즉 상관관계가 있다.)
# Residual standard error 잔차 표준 오차
# multiple r-sqaured  어느 정도로 모델이 좋은지 알려줌, 변수가 2개일 때 사용 (1에 가까울수록 좋음)
# adjusted r-squared 어느 정도로 모델이 좋은지 알려줌, 변수가 여러개일 때 사용(1에 가까울수록 좋음)

# F-statistic : F 분포, p-value: 이 회귀식 전체가 쓸만한지 아닌지 알려줌, 낮을수록 예측력이 좋다고 판단


abline ( a=1, b=5, col='coral', lwd=1, lty=2)

# 14. 회귀분석의 유형
# 단순회귀분석
# 캐나다의 인구조사 데이터: 변수 6개, 관측값 102개

library(car)
str(Prestige)
df <- Prestige

table(df$type)
barplot(table(df$type), col='tomato3')

hist(df$income, col='wheat', breaks=20)
shapiro.test(df$income)
hist(df$education, col='wheat', breaks=20)
shapiro.test(df$education)
hist(df$women, col='wheat', breaks=20)
shapiro.test(df$women)
hist(df$prestige, breaks=20)
shapiro.test(df$prestige)

plot(df[,-(5:6)])
cor(df[,-(5:6)])
colors()

model <-lm(income ~ education, data=df)
model2 <-lm(income ~ women, data=df)
model3 <-lm(income ~ prestige, data=df)
summary(model)

plot(income~education, data=df, col='tomato', pch='🍅')
abline(model, col='skyblue', lwd=2)

par(mfrow=c(1,3))
plot(income~education, data=df, col='tomato', pch='🍅')
abline(model, col='skyblue', lwd=2)
plot(income~women, data=df, col='orange', pch='🍣')
abline(model2, col='skyblue', lwd=2)
plot(income~prestige, data=df, col='green', pch='🍞')
abline(model3, col='skyblue', lwd=2)
par(mfrow=c(1,1))

summary(resid(model))

# 신뢰구간 반환
confint(model)
# 회귀계수 반환
coef(model)
# 분산분석표 반환
anova(model)
# 예측값 반환
fitted(model)

# predict 함수를 이용해서 예측
# 새로운 데이터 newdata 넣기
prestige.new <- data.frame(education=c(5,10,15))
# 예측
predict(model, newdata=prestige.new)
# interval= 95%신뢰구간 출력
predict(model, newdata=prestige.new, interval = 'confidence')

# 서브셋 조건을 지정하고 단순회귀분석
lm(income ~ education, data=Prestige, subset = (education > mean(education)))

lm(income ~ education, data=Prestige, subset = (education <= mean(education)))


# 다중 회귀분석
# 종속변수에 영향을 미치는 독립변수가 여러개인 경우 -> 다중회귀식
formula = income ~ education + women + prestige
model <-lm(formula, data=df)
summary(model)

formula = income ~ women + prestige
model <-lm(formula, data=df)
summary(model)

# 다항회귀분석: 단순회귀분석이 1차항에 대해서만 했다면, 다항회귀분석은 2차 이상의 항을 가진 다항함수에 피팅시키는 회귀방법
model <- lm(income ~ education + I(education^2), data=Prestige)
summary(model)

plot(Prestige$income~Prestige$education, pch=19, col='darkorange', xlab='education', ylab='income', main= 'Education and income')
library(dplyr)
lines(arrange(data.frame(Prestige$education, fitted(model)), Prestige$education ), col='cornflowerblue', lwd=2)

library(stargazer) # 정보를 예쁘게 출력
stargazer(model, type='text')

# 선형 회귀에 관한 가정
# 선형성 가정, 정규성 가정, 등분산성 가정을 체크 해주는 그래프 plot(model)
par(mfrow=c(2,2))
plot(model)
par(mfrow=c(1,1))

model <- lm(income ~ education + I(education^2), data=df)
plot(income ~ education, data=df)

plot(income ~ education + I(education^2), data=df)
summary(model)
library(tidyverse)
with(df,lines(arrange(data.frame(education, fitted(model)), education)), col='tomato' )


# 15장. 회귀모델의 설명력
df <- mtcars
str(df)
df <- mtcars[,1:6]
str(df)

plot(df, col='coral', pch=19)
cor(df)

library(corrgram)
corrgram(df)

model <- lm(mpg~., data=df)
summary(model)



# AIC : Akaike informalion criterion
# 전진선택법, 후진선택법, 단계법

camn <- lm(mpg~hp + wt+disp+drat,data=mtcars)
step(camn, direction = 'backward') 


# 연습문제
df <- read.csv('train.csv')


names(df)
str(df)
length(names(df))


g <- c('SalePrice ~')
for (i in 1:80) {
  if (is.numeric(df[,i])) {
    g <- paste(g, names(df)[i], '+')
    print(paste(g, '+',names(df)[i]))
  }
}
g
formula <- SalePrice ~ Id + MSSubClass + LotFrontage + LotArea + OverallQual + OverallCond +YearBuilt + YearRemodAdd + MasVnrArea + BsmtFinSF1 + BsmtFinSF2 + BsmtUnfSF + TotalBsmtSF + X1stFlrSF +X2ndFlrSF + LowQualFinSF + GrLivArea + BsmtFullBath + BsmtHalfBath + FullBath + HalfBath +BedroomAbvGr + KitchenAbvGr + TotRmsAbvGrd + Fireplaces + GarageYrBlt + GarageCars + GarageArea +WoodDeckSF + OpenPorchSF + EnclosedPorch + X3SsnPorch + ScreenPorch + PoolArea + MiscVal + MoSold + YrSold 
camn <- lm(SalePrice ~., data=df)
step(camn, direction = 'backward') 


camn <- lm(formula=formula, data=df)
step(camn, direction = 'forward') 


# 교수님 방법
is.num <- c()
for (i in 1:80) {
  is.num[i] <- is.numeric(df[,i])
}

is.num
df <- df[, is.num]
df<- df[,-1]
dim(df)
df <- df[complete.cases(df),]  # 결측치 제거
dim(df)

model <- lm(SalePrice ~., data=df)
step(model, direction = 'backward')
summary(model)

model <- lm(SalePrice ~ 1, data=df)
step(model, direction = 'forward', scope = list(lower = ~1,
                                                upper = ~MSSubClass + LotFrontage + LotArea + OverallQual + OverallCond +YearBuilt + YearRemodAdd + MasVnrArea + BsmtFinSF1 + BsmtFinSF2 + BsmtUnfSF + TotalBsmtSF + X1stFlrSF +X2ndFlrSF + LowQualFinSF + GrLivArea + BsmtFullBath + BsmtHalfBath + FullBath + HalfBath +BedroomAbvGr + KitchenAbvGr + TotRmsAbvGrd + Fireplaces + GarageYrBlt + GarageCars + GarageArea +WoodDeckSF + OpenPorchSF + EnclosedPorch + X3SsnPorch + ScreenPorch + PoolArea + MiscVal + MoSold + YrSold  )) 

# 회귀분석을 위한 변수가 수치형이 아닐 때, 
# 더미 변수로 변환하여 회귀분석을 할 수 있음

# contrasts : 더미변수의 코딩 구조 확인 가능
df <- InsectSprays
str(df)
lm(count ~ spray, data=df)
model <- lm(count ~ spray, data=df)  # 더미 인코딩을 이용해서 5개의 값이 나온다.
summary(model)

contrasts(df$spray)  # 더미 변수 보는법

df <- mtcars[,1:6]
str(df)
df$cyl <- factor(df$cyl)
head(df)

table(df$cyl)

model <- lm(mpg~., data=df)
summary(model)


plot(iris[,c(1,5)])

df <- split(iris, f=iris$Species)
df <-rbind(df$setosa, df$versicolor)
plot(df[,c(3,5)])

# 16장. 선형모델의 일반화
# 이항 로지스틱 함수

# 최대 우도법

# 푸아송 회귀분석 : 결과변수가 특정 기간 이내의 사건발생횟수인 경우에 적용
library(robust)
data("breslow.dat")
str(breslow.dat)

seizure <- breslow.dat[c('Base', 'Age', 'Trt', 'sumY')]
summary(seizure)

hist(seizure$sumY, breaks=20)
# 종속변수가 횟수이기 때문에 푸아송 분포를 사용
model <- glm(sumY~ Base + Age + Trt, data=seizure, family=poisson)
summary(model)

# 신약이 효과가 있다고 주장해도 무방하다.

coef(model)

exp(coef(model))
# 이 모델이 잘 맞는지 평가하려면, 선형일때랑은 또 다르다. (더 복잡)

# 약을 처방받은 환자 집단은 플라시보를 복용한 환자 집단에 비해 발작횟수가 14.2%감소

# 이항 로지스틱 회귀분석 binomial logistic regression model :

df <- split(iris, f=iris$Species)
df <-rbind(df$setosa, df$versicolor)
plot(df[,c(3,5)])
df$Species <- as.numeric(df$Species) -1

model <- glm(Species ~ Petal.Length, data=df, family=binomial(link = 'logit'))
abline(model, col='red')

# 로지스틱은 분류결과가 맞는지 틀린지 구별하는 것이 중요
# 혼동 행렬 confusion matrix : 이진 분류기가 분류할 때, 얼마나 많이 헷갈렸는가를 나타냄

# 정밀도 type 1 error, 재현율 type 2 error
# ROC 곡선 : 이진 분류의 결과에서 fp비율과 tp비율의 관계를 그린 곡선, 
# AUC (area under curve) : roc곡선의 하부 면적으로 표현하는 성능 평가 지표


# exer penguin

library(palmerpenguins)
pg <- penguins
str(pg)
pg <- pg[complete.cases(pg), -8]
str(pg)    #🐧
dim(pg)

# Adelie인지 Adelie가 아닌지를 기준으로 이항으로 species 분류
pg$is.adelie <- factor(
  ifelse(pg$species == 'Adelie',
         'Yes', 'No'))

barplot(table(pg$is.adelie))

pg <- pg[,-1]
str(pg)

model <- glm(is.adelie~., data=pg, family = binomial(link = 'logit'))
summary(model)
# 0이 될 확률, 1이 될 확률 -> fitted
model$fitted.values
pg$pred <- factor(ifelse(model$fitted.values > 0.5, 'Yes', 'No'))

table(pg$is.adelie, pg$pred)  # adelie인지 아닌지 정확하게 계산했다.


df <- iris
df$Species <- factor(ifelse(df$Species == 'virginica', 'Yes', 'No'))
table(df$Species)

model <- glm(Species~., data=df, family=binomial(link='logit'))
summary(model)
df$pred <- factor(ifelse(model$fitted.values > 0.5, 'Yes', 'No'))
# 혼동행렬
tab <-table(df$Species, df$pred)
TP <- tab[2,2]
TN <- tab[1,1]
FP <- tab[2,1]
FN <- tab[1,2]
accuracy <- (TP + TN)/(TP+TN+FP+FN)
precision <-TP / (TP+FP)
recall <- TP / (TP+FN)
F1.score <- 2* precision * recall / (precision+recall)
# AUC 구하기 -> pROC 라이브러리의 roc함수 필요
library(pROC)
roc(Species ~ model$fitted.values, data=df, plot=T, main='ROC curve', col='tomato')
# 0.9986 -> 1에 가까울 수록 좋은 이진 분류기라는 뜻 (0.8이상이면 괜찮을 지표)

# p-value, 잔차 등의 지표를 활용할 수가 없다.
# 대신, 실제로 값을 넣어보고 잘 작동하는지 확인 -> 혼동행렬 제작

