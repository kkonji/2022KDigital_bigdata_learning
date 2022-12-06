# part2.1 데이터 탐색과 통계분석석


# 기술적통계 descriptive statistics
# 수집한 데이터의 특성을 수치로 요약하거나 시각적으로 표현하는 통계분석 방법
# 평균, 표준편차, 교차표, 히스토그램, 막대그래프 등

# 추론적 통계 inferential statistics
# 수집한 표본집단으로부터 모집단의 특성을 추정하기 위한 통계분석 방법
# 가설검정, 평균검정, 분산분석, 카이제곱검정, 회귀분석 등

library(MASS)
qwe <- survey
table(qwe$Height)

# 원데이터가 정규분포인지 아닌지 확인
hist(qwe$Height)
summary(qwe)

library(stargazer)
stargazer(qwe)

# 집단별 기술통계량 : 집단의 특성을 파악하거나 집단 간의 차이를 비교하고자 할 때

# with <- $를 붙여준다.
# 2개 분석 <- p검정, 3개이상 분석 <- 분산분석

library(vcd)
arth <-Arthritis

# part2.2 확률과 통계
choose(45,6)

# 통계적 확률, 수학적 확률
# 큰 수의 법칙 Law of large numbers
# 표집 오차: 시행 횟수가 적을때는 통계적 확률이 수학적 확률에서 벗어남
# 기댓값 expected value
# 표본평균이 자료의 크기가 커짐에 따라 한없이 가까워지는 특정값
# 시행 횟수가 많아질수록 통계적확률은 기댓값에 가까워짐

# 이항분포 rbinom (n=시행횟수, size=크기, prob=확률)
windows(width=7, height=5) # 그래프 띄우는 함수

v <- (rbinom(n=1000000, size= 1000, prob=0.002))
hist(v, col='orange')

# 이항분포는 숫자가 많아질수록 정규분포에 수렴

# runif -> R uniform 균일한 랜덤값 생성

v <-runif(n=10000, min=0, max=100)
v
hist(v, col='chocolate', breaks=20)
mean(v)
sd(v)
colors()  # 사용할 수 있는 색깔 볼수 있음

# rnorm -> 정규분포로 랜덤값 생성
v <-rnorm(n=100000, mean=50, sd=20)
hist(v, col='plum')

# 몬테카를로 시뮬레이션
n_sim <- 1000
x<- vector(length=n_sim)
y <- vector(length=n_sim)
res = 0
for (i in 1:n_sim) {
  x[i] <- runif(1)
  y[i] <- runif(1)
  if (x[i]^2 + y[i]^2 <1) {
    res <- res +1
  }
}
4 * res / n_sim

circle <- function(x) sqrt(1-x^2)
plot(x,y, xlab='X', ylab='Y', col='blue')
curve(circle, from=0, to=1, add=T, col='red', lwd=2)
?curve

# 조건부확률

# 베이지 정리 Bayes' Theorem
# 베이즈 정리는 사건 B가 발생함으로써(사건 B가 진실이라는 것을 알게 됨으로써, 
# 즉 사건 B의 확률 P(B)=1이라는 것을 알게 됨으로써)
# 사건 A의 확률이 어떻게 변화하는지를 표현한 정리
# 모집단과 표본이 없음

# part2.3 확률변수와 확률분포 1
# 확률변수, 이산확률변수, 연속확률변수
# 확률분포, 이산확률분포 PMF, 연속확률분포 PDF

x <- seq(-3,3,length =100)
y <- dnorm(x)
y2 <- (1/sqrt(2*pi)) * exp(-(x^2)/2)
plot(x,y, type='l', col='tomato', lwd=3)
plot(x,y2, type='l', col='steelblue', lwd=3, add=T)

x <- seq(0,100,length =100)
y <- dnorm(x, mean=50, sd=20)
y2 <- (1/sqrt(2*pi)) * exp(-(x^2)/2)
plot(x,y, type='l', col='tomato', lwd=3)
plot(x,y2, type='l', col='steelblue', lwd=3, add=T)

# 균일분포
x <- seq(0,100,length =100)
y <- dunif(x, min=0, max=100)
plot(x,y, type='l', col='tomato', lwd=3)

runif
df <- airquality
sum(is.na(df))
for (i in 1:6) {
  df[is.na(df[names(df)[i]] ) ==T,] <- 0
  }
sum(is.na(df))
names(df)
mean(df[['Ozone']])

# 연습문제
# 국민소득이 평균 30000, 표준편차 10000, 정규분포를 따른다고 가정
# pnorm 함수 - pnorm(q=값, mean=평균, sd=표준편차)

pnorm(35000, mean=30000, sd=10000) - pnorm(25000, mean=30000, sd=10000)

pnorm(1) - pnorm(-1)  # 평균 0 표준편차 1 디폴트

pnorm(2) - pnorm(-2)

pnorm(2.58) - pnorm(-2.58)

(1-pnorm(87, mean=68, sd=10)) * 1000
# lower.tail 파라미터 : 위에서 부터 적분값
pnorm(87, mean=68, sd=10, lower.tail = F)

# 표준화(정규화)

pnorm(70, 60, 10, lower.tail = F)
pnorm(80, 70, 20, lower.tail = F)


x <-rbinom(1000000, size=100, prob=0.5)
hist(x, col ='steelblue')
sd(x)
curve(dnorm(x,50,5), 30,70, col='tomato', add=T, lwd=3, lty=2)


# 2.4 확률변수와 확률분포
# 확률변수random variable 
# 1. 이산확률변수, 연속확률변수 

# x축 범주형, y축 수치형 -> t-분포(2개), F-분포(3개이상)
# x축 범주형, y축 범주형 -> x^2 분포


# 표본추출: sampling
# 복원추출  : 추출한 표본을 되돌려 놓고 다음 표본을 추출
# 비복원추출 : 이미 추출한 표본은 제외하고 다음 표본을 추출

# 중심극한정리 central limit theorem
# 표본의 크기가 충분히 클 때 (n>= 30)
# 표본분포는 모집단의 분포와 상관없이 정규분포를 따른다.

# 표본평균 x의 확률분포는 N(m,sigma^2/n)에 대응

library(MASS)
height <- na.omit(survey$Height)

length(height)
# 샘플 추출
samp <- sample(height, 30)
# 다른 방식
height[sample(1:length(height), size=30)]

for (i in 1:100000) {
  samp <- sample(height, 30)
  x.bar[i] <- mean(samp)
  x.sd[i] <- sd(samp)
}
hist(x.bar, col='cyan', breaks=20, prob=T)
x <- seq(160,180,length=200)
curve(dnorm(x, mean(height), sd(x)), 160, 180, col='red', add=T, lwd=3, lty=2)


mean(height)
sd(height)


hist(height, col='salmon', breaks=50)
colors()

x.1 <- rnorm(n=5000, mean=80, sd=5)
x.2 <- rnorm(n=5000, mean=50, sd=5)


x <- c(x.1,x.2)

for (i in 1:100000) {
  samp <- sample(x, size=30)
  x.bar[i] <- mean(samp)
}
hist(x.bar, col='salmon', breaks=20,  prob=T)
x.samp <- seq(30, 90, length=200)
curve(dnorm(x.samp, mean(x), sd(x.samp)), 30,90, add=T, col='red')

# degree of freedom : 하나만 빼면 된다.
# 표본 평균 = 모집단 평균 같다고 가정
# 표본 표준편차 = 모집단 표준편차를 sqrt(n)으로 나눈다.
hist(x,col = 'salmon', breaks=50)


# part2.5 통계적 추정과 가설검정
# 점추정 : 모수에 대한 추정값을 하나의 값으로 추정
# 구간추정; 모수의 값이 포함되리라고 믿을 수 있는 범위를 추정

# 구간추정의 신뢰수준과 신뢰구간
# 신뢰수준 confidence level : 모수가 추정한 구간 내에 있을 것이라 믿을 수 있는 정도
# 신뢰구간 confidence interval : 신뢰도에 따라 모수가 포함될 것이라 믿을 수 있는 구간

# 가설검정의 오류
# 제1종오류ㅣ type1 error(alpha -> 유의수준 0.05 기준)
# 귀무가설이 참이지만, 검정 결과에 따라 귀무가설을 기각하는 오류

# 제2종오류 | type2 error
# 귀무가설이 거짓이지만, 검정 결과에 따라 귀무가설을 채택하는 오류


# 유의수준(alpha) : 1종오류를 범할 통계적 확률

# 유의확률(p-value) : 표본에서 관측한 통계량보다 더 극단적인 값이 발생할 확률
# p-value > alpha : 귀무가설을 기각할 수 있는 증거가 부족
# p-value < alpha : 귀무가설을 기각할 수 있는 증거가 충분

cor(iris[,-5])
# petal.width와 petal.length의 상관계수는 0.96 이고, 인워

cor.test(iris$Petal.Length, iris$Petal.Width)
# t: t-value, df: degree of freedom, p-value : 0.05 보다 작으면 됨
# 여기서 p-value : 2.2e^-16이 나옴, confidence interval : [0.949 0.972]


binom.test(x=60, n=100, p=0.5)

# qnorm : 백분위
qnorm(p=0.5, mean=50, sd=10)

qnorm(p=0.975, mean=50, sd=10)

qnorm(p=0.005, mean=50, sd=10)

qnorm(p=0.995, mean=50, sd=10)

# qnorm과 pnorm은 역함수 관계
pnorm(75.75829, mean=50, sd=10)
pnorm(24.24171, mean=50, sd=10)

# 신뢰구간 바꾸기 conf.level 파라미터 default 0.95
binom.test(x=35, n=100, p=0.5, conf.level = 0.99)

# 양측검정과 단측검정

binom.test(60,100,0.5, alternative = 'less')

# 정규성 검정 normality test
# 정규성 가정 : 
# 귀무가설 - 데이터의 분포가 정규분포를 따른다.
# 대립가설 - 데이터의 분포가 정규분포를 따르지 않는다.
# 샤피로-윌크 검정 shapiro-wilk normality test

# p-value 가 0.05보다 크면 됨  -> shapiro.test 사용
shapiro.test(survey$Height)
hist(survey$Height)

shapiro.test(iris$Sepal.Length)
shapiro.test(iris$Sepal.Width)
shapiro.test(mtcars$mpg)
shapiro.test(survey$Age)

# quantile-quantile plot, qqnorm, qqline을 이용해서 정규분포와 얼마나 비슷한지 확인 가능
# qqline으로 만든 직선에 가까울수록 정규성을 가진다고 한다.
qqnorm(survey$Height, col='blue')
qqline(survey$Height, col='tomato', lwd=3)

qqnorm(survey$Age, col='blue')
qqline(survey$Age, col='tomato', lwd=3)

# t-분포와 평균검정
# t-분포, f-분포, 카이스퀘어-분포
# 스튜던트의 t-분포 student's t-distribution
# 정규분포를 따르는 모집단으로부터 추출한 표본의 확률분포

# 검정통계량 = t-value = (bar(x)- mu) / (s / sqrt(n))
# n: 표본크기, bar(x): 표본평균, mu: 모평균, s: 표본표준편차, s/sqrt(n) : 표준오차

x <- seq(-3,3,length=200)
# dt: t분포값 생성, df: degree of freedom
dt(x,df=30)
dt(x,df=5)
dt(x,df=1)

# n> 30이면 t분포와 정규분포가 같다.

# t분포와 t검정
# 모집단의 평균을 알지만 표준편차를 모를때, 
# 모집단으로부터 추출한 표본으로부터 추정된 표준오차를 통해, 
# t-분포에 의존하여 가설을 검정하는 방법

# t-검정의 가정
# 정규성 가정: 모집단은 정규분포를 따른다.
# 등분산성 가정: 두 집단을 비교할 때, 두 집단의 분산이 동일하다.

# t분포로 난수 생성
v <- rt(n=10000, df=29)
hist(v, prob=T)
x <- seq(-4,4,length=200)  # dt : t분포를 따르는 확률밀도함수 생성
curve(dt(x, df=29), min(x), max(x), lty=2, lwd =3, col='tomato', add=T)
curve(dnorm(x), -4,4,add=T, col='violet', lwd=5, lty=4)
# t-분포와 정규분포가 같아짐을 알 수 있다.


# 선거할때 1000명의 여론조사가 필요한 이유 : 
# 통제변수 안에서 충분한 샘플을 만드려면 대충 1000개를 모으면 됨


pt(q=2.045, df=29)
pt(q=2.756, df=29)

qt(p=0.975, df=29)
qt(p=0.995, df=29)


# 평균검정 t-test
# 평균을 비교할 때 쓸 수 있는 가설검정 방법

# 단일표본 평균검정 one-sample t-test
# 표본평균을 가설로 정한 값과 비교

# 독립표본 평균검정 two-independent-samples t-test ( 3개이상일때는 t-test쓸수 없다.)
# 두 집단 간의 평균을 비교해서 집단의 차이에 대한 가설검정

# 대응표본 평균검정 paired-samples t-test
# 같은 집단인데, 관측값이 서로 쌍을 이루는 경우(예.사전-사후)에 대한 가설검정
library(MASS)
data(cats)
str(cats)

# 종속변수 :BWT(수치), 독립변수: 성별(범주) -> t-test하기 좋은 데이터
# 신뢰구간 안에 t값이 안 들어오는지도 확인해야한다. -> 안 들어와야 좋음
t.test(Bwt~ Sex, data=cats, conf.level=0.99)  # 우리는 p-value만 필요하다.

table(cats$Sex)

tapply(cats$Bwt, INDEX = list(Sex=cats$Sex), mean)


str(sleep)
# 대응표본 평균 검정 
t.test(extra~ group, data=sleep, paired=T)

# 대응표본 평균 검정 2
str(sleep)
sleep

# 롱포맷 (아래로긴것) -> 와이드포맷(옆으로긴것)  
# -> spread 함수 사용
library(tidyr)
wide.df <- spread(sleep, key=group, value=extra)
summary(wide.df) # 평균의 차이가 있어보이는데 과연 이것이 통계적으로 유의한 차이일까?
?tapply
tapply(sleep$extra, INDEX=list(sleep$group), FUN=mean)

# t.test 적용
t.test(extra~group, data=sleep, paired=T)
t.test(wide.df$'1', wide.df$'2', paired=T)
