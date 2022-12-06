
# 카이 스퀘어 그래프
x <- seq(from=0,to=10, by=0.001)

fn.x <- function (x, k) {
  1/(2^(k/2)* gamma(k/2)) * x^(k/2 -1) * exp(-x/2)
}

plot(x, fn.x(x,3), pch=19,col='steelblue'  ) 

# 안전벨트 착용과 승객 안전간의 관계 분석

survivors <- matrix(c(1443,151,47,1781,312,135), ncol=2)
dimnames(survivors) <- list('status'=c('minor injury', 'serious injury', 'dead'), 'seatbelt' = c('with seatbelt', 'without seatbelt'))
                            
survivors

addmargins(survivors)

eij <- c(1367, 1855.9, 196.9, 267.4, 77.1, 104.7)
oij <- c(1443, 1781, 151, 312, 47, 135)
cs.value <- sum(((eij-oij)^2) / eij)
cs.value # 카이스퀘어 값


# 카이스퀘어 분포 그림
v <- rchisq(n=10000, df=1)
hist(v, col='steelblue', prob=T)

x <- seq(0,15, length=200)
curve(dchisq(x, df=1), 0, 15, add=T, col='red')

curve(dchisq(x, df=1), 0, 15, col='red', lwd=2)
curve(dchisq(x, df=5), 0, 15, add=T, col='tomato', lwd=2)
curve(dchisq(x, df=10), 0, 15, add=T, col='purple', lwd=2)

qchisq(p=0.95, df=1)
pchisq(q=2.5, df=1)
pchisq(q=3.845, df=1)
pchisq(q=5, df=1, lower.tail = F)

#교차표 만들기

Titanic
Titanic.margin <- margin.table(Titanic, margin=c(4,1) )
Titanic.margin

chisq.test(Titanic.margin)

addmargins(Titanic.margin)

# 두 범주형 변수간의 관련성 강도 평가
library(vcd)
assocstats(Titanic.margin)
# likelihood ratio -> 우도 비 검정

# 두 범주형 변수 간의 관계 모자이크 플롯으로 시각화

# 적합성 검정
# 머리색이 갈색, 검은색, 흑발이 각각 
# 50%, 25%, 15% 라는 주장에 대한 적합성 검정

str(HairEyeColor)
hairs <- margin.table(HairEyeColor, margin=1)

chisq.test(hairs,  p=c(0.25, 0.5, 0.1, 0.15))
# p-value 값이 매우 작은것으로 봐서 귀무가설을 기각하고 대립가설을 세운다.


# f-분포와 분산분석

v <-rf(n=10000, df1=1, df2=30)
hist(v, col='steelblue')

 x<- seq(0,15,length=200)
curve(df(x,df1=1, df2=30) , 0,15, col='tomato', lwd=2, lty=1)
curve(df(x,df1=5, df2=30) , 0,15, col='purple', lwd=2, lty=1, add=T)
curve(df(x,df1=10, df2=80) , 0,15, col='orange', lwd=2, lty=1, add=T)

qf (p=0.95, df1=1, df2=30)
pf (q=4.170877, df1=1, df2=30, lower.tail = F)


# 분산분석 -> aov
str(adhd)

# 빠르게 스킵

# 2.10 일원 분산분석과 이원 분산분석
# 일원 분산분석
# 이원 분산분석
# 반복측정 분석
# 공분산 분석 (ancova)
# 다변량 분산분석 (manova)

# InsectSprays
df <- InsectSprays
str(df)
table(df$spray)

round(tapply(df$count, INDEX = list(df$spray), FUN=mean),3)
# 차이가 있어보인다

boxplot(count~spray, data=df, col=rainbow(7))

result <-aov(count~spray, data=df)

summary(result)
# 통계적으로 유의한 차이 (집단간의 결과를 분산까지 모두 고려해서 한것)

# 집단 중에 어느 그룹이 차이가 확연하게 나는가? -> 사후검증
TukeyHSD(result)

### 다시 시작
library(gplots)
# boxplot이랑 비슷한 그래프 plotmeans
plotmeans(count~spray, data=df, barcol = 'tomato', col='orange', lwd=3, barwidth = 3)

model.tables(result, type='mean')
model.tables(result, type='effect')

# 그래프 그리기 (0에 닿은 그룹끼리 관련이 있다.)
plot(TukeyHSD(result), col='blue', las=1)

library(car)
qqPlot(df$count, col='orange')

shapiro.test(df$count)

# 등분산성 테스트( leveneTest, bartlett.test)
leveneTest(count~spray, data=df)

bartlett.test(count~spray, data=df)

# 정규성, 등분산성이 다른 경우에는 어떡할까?

oneway.test(count~ spray, data=df)  # 여기서도 p-value 낮게 나왓으니 우리가 잘못한게 아니다.

# 이원 분산분석

df <- ToothGrowth
str(df) # len : 토끼의 이빨길이, supp: orange juice, vitamin C, dose:알약 투여량
unique(df$dose)

df$dose <- factor(df$dose, levels=c(0.5, 1.0, 2.0), labels=c('low','mid','high'))
df$dose

df[seq(1,60,5),]
with(df, tapply(len, INDEX=list(SUPP=supp, DOSE=dose), FUN=mean))

# 두 개는 같은 뜻
boxplot(len~ supp * dose, data=df, col=c('steelblue', 'coral'))
boxplot(len~ supp + dose +supp:dose, data=df, col=c('steelblue', 'coral'))
# 오렌지 주스 >> 비타민 씨 효과 -> 주효과 확인
# 상호작용 효과 확인
aov.result <- aov(len~supp*dose, data=df)
# 아노바 결과: SUPP효과, DOSE효과, SUPP+DOSE같이 효과

summary(aov.result)

TukeyHSD(aov.result)
plot(TukeyHSD(aov.result), las=1)

# 2-11. 반복측정과 공분산 분석
# 반복측정 분산분석
# 표준패키지의 CO2 데이터셋: 식물이 저온의 생장환경에서 견디는 정도에 대한 실험 결과
str(CO2)

# 나중에 채우기

# 공분산 분석
# faraway 패키지의 sexab 데이터셋 : 아동기의 성폭력 경험이 성인의 정신건강에 미치는 영향 연구
library(faraway)
str(sexab)


## HH 패키지의 ancova() 함수
library(HH)


# 다변량 분산분석 -> manova() 함수 : 여러개의 변수에 대해서 분산분석
# heplots 패키지의 Skulls 데이터셋: 이집트 지역에서 발굴된 인간의 두개골 크기 측정
library(heplots)
str(Skulls)

     