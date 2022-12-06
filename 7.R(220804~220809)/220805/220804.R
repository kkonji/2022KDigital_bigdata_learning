# 5장. 함수의 이해

# 사용자 정의 함수
# function.name <- function( parameters) {내용   return return_values}
# return value는 하나만 가능
fun <- function(x) {
  return (x+y+5)
}

y <-35
fun(5)


fun(fun(fun(fun(5))))

my.fun <-  function(x=2,y,z =3) {
  cat(x,y,z,'\n')
  return (x + y*2 + z*3)
}

my.fun 
my.fun(1,4)

seq(from =2, to=100, by=2)

#  return 문장을 안 쓰면 마지막 계산 문장이 실행
# n의 약수 구하기
divisor <- function(n) {
  # to do
  v <- 1:n
  x <- v[n %% v == 0]
  return (x)
}

divisor(n = 32)


divisor <- function(n) {
  # to do
  v <- 1:n
  v[n %% v == 0]
}
divisor(n = 32)

divisor <- function(n) (1:n)[n %% (1:n) == 0]

divisor(n = 32)
# sapply (simple apply)
sapply(c(16,32,45,77), divisor)

# 함수형 프로그래밍
# 모든 코드를 함수를 위주로 구현하고자 하는 프로그래밍 패러다임
# 조건문과 반복문을 매우 싫어함

# ifelse(condition, true.value, false.value) -> excel이랑 유사

# 6장. data.frame
summary(iris$Sepal.Length)['1st Qu.']

df <- iris  
str(df)
class(df)
dim(df)
nrow(df)
ncol(df)

# 행 이름 추출
rownames(df)
# 열 이름 추출
colnames(df)
head(df)

v <- c(korean = 85,math = 77,english= 96)
# 이름 추출 및 설정
names(v)  
w <- c(92,64,44)
names(w) <- c('kor', 'eng','math')
w

w["kor"]

# 컬럼 벡터 추가
df$Sepal.sum <- df$Sepal.Length + df$Sepal.Width
df
head(df[,5:6])

df$Sepal.Sep <- ifelse(df$Sepal.sum > mean(df$Sepal.sum), 'Big', 'Small')

df$Sepal.Sep <- factor(df$Sepal.Sep)
levels(df$Sepal.Sep)
barplot(table(df$Sepal.Sep))


# 데이터 객체의 자료형 확인과 변환
# is.xxx() 함수: 데이터 구조의 자료형 확인
# as.xxx() 함수: 데이터 구조의 자료형 변환

class(state.x77)
is.matrix(state.x77)
is.data.frame(state.x77)

df.x77 <- as.data.frame(state.x77)
is.data.frame(df.x77)
colnames(df.x77)
dim(df.x77)

mak <- function(col) {
  val <- c(rownames(df.x77)[which(df.x77[col] == max(df.x77[col]))],
           rownames(df.x77)[which(df.x77[col] == min(df.x77[col]))])
  return (val)
}

df.x77
colnames(df.x77)

sapply(colnames(df.x77), mak)

max(df.x77["Population"])

rownames(df.x77)[which(df.x77["Population"] == max(df.x77["Population"]))]
rownames(df.x77)[which(df.x77["Murder"] == min(df.x77["Murder"]))]
rownames(df.x77)[which(df.x77["HS Grad"] == max(df.x77["HS Grad"]))]
rownames(df.x77)[which(df.x77["Frost"] == min(df.x77["Frost"]))]

# 문맹률과 고등 졸업 산점도
plot(df.x77$Illiteracy, df.x77$`HS Grad`)

# 상관계수
cor(df.x77$Illiteracy, df.x77$`HS Grad`)

# 데이터 프레임의 저장과 불러오기
df <- iris
df$Sepal.sum <- df$Sepal.Length + df$Sepal.Width
write.csv(df,"my.iris.csv")  # 데이터프레임 저장
# write.csv(df,"my.iris.csv", row.names =F)
getwd()

df2 <- read.csv("my.iris.csv", header=T)
df2

# 엑셀파일 불러오기 (install.packages("readxl"))
library(readxl)
df <- read_excel("성적표.xlsx", sheet = 1)
df
str(df)
class(df)  
# tibble로 나오는데 데이터프레임으로 간주해도 무방
df <- data.frame(df)

# 데이터프레임엔 apply 사용, MARGIN은 축을 결정 : 2이면 열, 1이면 행
df$평균 <- apply(df[,3:5], MARGIN = 1, mean)
head(df)

write.csv(df, 'score.csv', row.names = F)

# 7장. 데이터 전처리 Data preprocessing
# 본격적인 통계분석을 시작하기 전에 필요한 데이터 정제 작업
# 결측치와 이상치
# 데이터의 변환
# 데이터의 표준화

# 결측치 missing values

x <- c(45,NA, 60, 35, 20,75)
mean(x)
mean(x, na.rm=T)
# 결측치 확인 is.na()
x[!is.na(x)]

x[is.na(x)] <- mean(x, na.rm = T)
x

df <- airquality
complete.cases(df) # 데이터프레임에서 결측치가포함된 관측값 확인

str(df)

mean(df$Ozone, na.rm = T)
ozone <- df$Ozone
ozone[is.na(ozone)] <-  mean(ozone, na.rm = T)
ozone
plot(df)
cor(df)


# 평균으로 결측치를 보정하면, 표준편차가 손상될 우려가 있다.
# sample 함수로 대체
ozone <- df$Ozone
ozone[is.na(ozone)] <-  sample(na.omit(ozone), 37)
ozone
mean(ozone)
sd(ozone)

# 결측치 제거
complete.cases(df)
df <- df[complete.cases(df),]
df

?complete.cases

# 결측치 분포와 발생패턴 확인
library(VIM)
?aggr
aggr(airquality, numbers=T, sortVar=T)

# 이상치 Outliers 처리
df <- data.frame(state.x77)

boxplot(df$Income, pch=19, col='orange',border='brown')

# boxplot.stats() 함수를 이용해서 이상치에 대한 상세 확인
boxplot.stats(df$Income)

df[df$Income == boxplot.stats(df$Income)$out,]

# 이상치가 통계량을 왜곡할 때는 결측치로 처리해서 제외

# 독립변수 independent variable, 종속변수 dependent variable
# 종속변수 ~ 독립변수1 + 독립변수2 + ...
df <- iris
boxplot(Petal.Length ~ Species + Petal.Width, data=df, col='skyblue')
boxplot(Petal.Length ~ Species, data=df, col='skyblue')

df_setosa <-  df[df$Species == 'setosa',]
df_setosa[boxplot.stats(df_setosa$Petal.Length)$out == df_setosa$Petal.Length,]

df_versi <-  df[df$Species == 'versicolor',]
df_versi[boxplot.stats(df_versi$Petal.Length)$out == df_versi$Petal.Length,]

df_virgi <-   df[df$Species == 'verginica',]
df_virgi[boxplot.stats(df_virgi$Petal.Length)$out == df_virgi$Petal.Length,]


colnames(df)[5]
srt <- function(df, sp) next # 함수화하려다가 맘

# 이상치가 여러 개인 경우
boxplot(Petal.Width ~ Species, data=df, col='skyblue')
df <- with(iris, iris[Species == "setosa",])
outlier <- boxplot.stats(df$Petal.Width)$out

iris[iris$Petal.Width == outlier,]   # 모든 경우가 출력하지 않음

iris[iris$Petal.Width %in% outlier,]  # python에서의 in 역할



# 8. 데이터 전처리(2)
# 선택, 집계, 분리, 결합, 정렬
# subset, merge, sort

# subset함수 내에서 subset -> 행별 조건, select -> 열별 조건
subset(iris, subset = Species == 'setosa')

st <- data.frame(state.x77)
st[st$Population ==max(st$Population),c(3,6)]
subset(st, subset=st$Population ==max(st$Population), select= c(3,6))

iris[,-5]
subset(iris, select=1:4)

# split 함수
seto <- iris[iris$Species == 'setosa',]
vir <- iris[iris$Species == 'virginica',]
ver <- iris[iris$Species == 'versicolor',]

# 위의 작업 간략화
levels(iris$Species)

sp <- split(iris, f=iris$Species)
length(sp)
str(sp)

sp$setosa
sp$virginica
sp$versicolor

dim(sp$setosa)
dim(sp$virginica) 

df.2 <- rbind(sp$setosa, sp$virginica, sp$versicolor)
dim(df.2)

iris[,1:2]
iris[,3:4]

df.3 <-  cbind(iris[,1:2],
               iris[,3:4])
df.3


# merge (결합) : 특정 변수의 값이 같은 행을 기준으로 데이터 프레임을 병합

x <- data.frame(name=c('A','B','C'), kor=c(50,60,70))
y <- data.frame(name=c('A','B','D'), eng=c(70,50,40))
cbind(x,y)  # -> 이상하게 나옴

merge(x,y)

library(readxl)
df.1 <- read_excel('성적표.xlsx', sheet=1)
df.2 <- read_excel('성적표.xlsx', sheet=2)

cbind(df.1,df.2)

merge(df.1,df.2) # inner join

merge(df.1, df.2, all=T) # outer join

df.1 <- read_excel('성적표.xlsx', sheet=1)
df.2 <- read_excel('성적표.xlsx', sheet=2)
df <-merge(df.1, df.2, all=T, by.x=c('번호', '이름'), by.y=c('number', 'name'))

# 컬럼 이름 변경
colnames(df) <- c('no', 'name', 'py','r','machine', 'deep', 'cloud')

df

# aggregate() 함수
df <- subset(iris, select = c(1,2))
df
# aggregate(df, by=list(테이블명=나눌분류), FUN=함수)
aggregate(df, by=list(Species= iris$Species), FUN = length)

aggregate(df, by=list(Species= iris$Species), FUN = length)


library(MASS)
data("survey")
df <- survey
str(df)

df <- na.omit(df)

df <- df[complete.cases(df),]
dim(df)

hist(df$Height, breaks= 20)

hist(df[df$Sex == 'Male',]$Height)
hist(df[df$Sex == 'Female',]$Height)

mean(df[df$Sex == 'Male',]$Height)
mean(df[df$Sex == 'Female',]$Height)

aggregate(df[,c(10,12)],by=list(gender = df$Sex), FUN=mean)

# t.test
t.test(Height ~ Sex, data = df) # p-value : 유의 확률 

boxplot(Height ~ Sex, data=df, col=c('orange', 'tomato'))


# x: 수치, y: 범주 -> 로지스틱 회귀분석 사용


# 정렬: sort(), order() 사용
# sort(), order()
v <- c(30,50,25,70,20) 
v
sort(v)  # 정렬 (디폴트: ASC)

sort(v, decreasing = T) # 내림차순 정렬

df <-  data.frame(state.x77)

str(df)

sort(df$Illiteracy, decreasing = T)
# 정렬
ord <- order(df$Illiteracy, decreasing = T)
df[ord,c(3,2)]

# 여러 기준으로 정렬 
ord <- order(df$Illiteracy, df$Income, decreasing = T)
df[ord[1:10],c(3,2)]

# 하나는 오름 , 다른건 내림으로 할경우에는 마이너스를 단다.







# sample 함수

# sample(1:10, size=5) -> 랜덤하게 추출, 10개중에 5개 추출

v <- c()
v <- c(v, sample(1:10, size=5))
v
hist(v)


 s <-  0
 for ( i in 1:1000000) {
   x <- sample(1:10, size=5, replace = T)
   s <- s + sum(x==7)
 }
 set.seed(2021)  # 시드 생성

 sample(1:10, size=5, replace=T)   # 복원추출: 중복을 허용해서 추출
 
 idx <- sample(1:nrow(iris), size=50)
 iris[idx,]
 
df <- iris


# 9장. 탐색적 데이터 분석
# 확증적 데이터 분석 CDA, confirmatory data analysis
# 가설을 수립하고 데이터를 통해 통계적 유의성을 검정하는 전통적 분석 기법
# Ronald Fisher: 가설검정, 신뢰구간, 유의확률, 유의수준(p-value)

# 탐색적 데이터 분석 EDA, exploratory data analysis
# 정해진 가설과 모형없이 데이터의 구조와 특성을 통해 통찰을 얻는 분석 기법
# John Tukey : EDA는 우리가 존재한다고 믿는 것들은 물론이고, 존재하지 않는다고 
# 믿는 것들을 발견하려는 태도, 유연성, 그리고 자발성

library(palmerpenguins)

# 패키지 별로 데이터 찾는 법
data(package='palmerpenguins')

data('penguins') # data loading

pg <- data.frame(penguins)

str(pg)

library(VIM)

aggr(pg, numbers=T, prop = F)  # missing value 제거

pg <- na.omit(pg) #NA값 제거

dim(pg)
# 범주형 데이터 특성 파악
table(pg$species)  # 도수분포표

barplot(table(pg$species)) # 도수분포도

table(pg$island)

barplot(table(pg$island))

barplot(table(pg$sex))

str(pg[,3:6])

summary(pg[,3:6])

# 그래프 4분할
par(mfrow = c(2,2))
hist(pg$bill_length_mm, col=2:6)
hist(pg$bill_depth_mm, col=7:11)
hist(pg$flipper_length_mm, col=12:16)
hist(pg$body_mass_g, col=c('orange', 'violet','pink'))
par(mfrow=c(1,1))

par(mfrow = c(1,4))
hist(pg$bill_length_mm)
hist(pg$bill_depth_mm)
hist(pg$flipper_length_mm)
hist(pg$body_mass_g)
par(mfrow=c(1,1))

my.color <- ifelse(pg$species == 'Gentoo', 'tomato', 
                   ifelse(pg$species == 'Adelie', 'steelblue', 'orange'))

plot(pg$bill_depth_mm, pg$bill_length_mm, pch= '🐧', col=my.color)
cor(pg$bill_depth_mm, pg$bill_length_mm)
