# 1_1장
3+4
print("Hello, R")

x = 3

x <- 3  # 단축키 : alt + -
5 -> y
3 <- x

z <-  x+ y
print(z)

# 현재 파일 위치 
getwd()

plot(iris)
?iris

# View: 표를 띄운다
View(iris)

install.packages("cowsay")  # 콘솔창에 입력

library(cowsay)  # ctrl + s 누르면 설치안내 문구 뜸
library(ggplot2)

say('안녕녕')
say('안녕', by='chicken')
say('안녕', by='cow')
say('안녕', by='ghost')
say('안녕', by='rabbit')
say('안녕', by='shark')
say('안녕', by='facecat')
say('안녕', by='behindcat')
say('안녕', by='random')

# 내장 데이터셋

# 통계 분석에 필요한 데이터를 2차원형태로 만들어 놓은 데이터

# iris, mtcars
# 칼럼(변수variable or 변량variate), 로우(관측값observation)
# 수치형, 양적, 연속형 <-> 범주형, 질적, 명목형
# structure -> str : 데이터셋의 구조 알려줌
str(iris)
head(iris)
tail(iris)
# 범주형
class(iris$Species)

levels(iris$Species) # unique값

table(iris$Species)  # value_counts()

barplot(table(iris$Species))

# 수치형
class(iris$Petal.Length)

mean(iris$Petal.Length)

var(iris$Petal.Length)

sd(iris$Petal.Length)  # 표준편차

hist(iris$Petal.Length)

hist(iris$Petal.Length, col = 'steelblue', main = 'title', xlab = 'x축', ylab= 'ㅛㅊ')

mtcars$mpg

hist(mtcars$wt, col='orange', xlim= c(1,6), ylim= c(0,10))

plot(mtcars$mpg, mtcars$wt)
# 연습문제 2.1
plot(iris$Species, main='품종의 막대그래프', xlab ='품종', ylab = '개수', 
     col='tomato')
# 연습문제 2.2
mean(iris$Petal.Width)
var(iris$Petal.Width)
sd(iris$Petal.Width)
hist(iris$Petal.Width, col = 'tomato', xlab = 'width', ylab ='Freq',
     main = 'iris', breaks = 20)
# 연습문제 2.3
hist(mtcars$hp, xlim = c(0,400), ylim = c(0,12))
plot(mtcars$hp, mtcars$mpg, col='tomato', pch = '♬')
# 연습문제 2.4
str(cars)
?cars

plot(cars$speed, cars$dist)

summary(mtcars)
# 함수에 파라미터 넘겨줄 때, = 을 쓰고, 변수 이름 할당할 때는 -> 쓴다 

# logical(논리형)
# TRUE, FALSE, T, F

# 특수형
# NA, NULL, NaN, Inf, -Inf

# 산술 연산자
# %% <- python % , %/% <- python //

7 %% 3

7 %/% 3

2 ^ 10
2 ** 10

# R의 기본은 '벡터'이다.
v <- 1:100
class(v)
v
sum(1:100)

# if문 사용 , else는 반드시 } 있는 줄에 있어야 함, 커서의 위치도 중요
score <- 91
if (score >= 90) {
  grade <- "A"
} else if (score >= 80) {
  grade <- "B"
} else {
  grade <- "F"
}

grade

s <-  0
i <-  1
while (i <= 10) {
  s <-  s + i
  i <- i +1
}
s
# next, break

print(3.14)

cat(3.14)  # python에서의 print문

# exer 3.1
x <- c(5,10,15)
area <- x ** 2
area

r <-5
2 * pi * r

# exer 3.1 함수화

# 정사각형의 넓이
area <- function(x) x^2
# 반지름 r의 둘레와 넓이
round <- function(r) 2*pi*r
area2 <- function(r) pi*(r^2)

area(c(5,10,15))
round(c(5,10,15))
area2(c(5,10,15))

sapply(c(5,10,15), area)
sapply(c(5,10,15), round)
sapply(c(5,10,15), area2)

# exer 3.2 함수화
deliver <- function(n) {
  if (n %% 15 == 0) "pizzanarachickengongjoo"
  else if (n %% 3 == 0) "pizza"
  else if (n %% 5 == 0) "chicken"
  else "diet"
}

deliver2 <- function(n) ifelse(n %% 15 == 0,"pizzanarachickengongjoo", 
                               ifelse(n %% 3 == 0,"pizza", 
                                      ifelse(n %% 5 == 0,"chicken", "diet" )))


deliver2(33)
# exer 3.2
n <- 15; order <-  "다이어트"
if (n %% 15 == 0) {
  order <- "피자나라치킨공주"
} else if (n %% 3 == 0) {
  order <- "피자"
} else if (n %% 5 == 0) {
  order <- "치킨"
} 
order


# exer 3.3
cumsum <- function(n) sum((1:n)^3)
cumsum.1 <- function(n) (n * (n+1) /2) **2


n <- c(10,15,20)
S <-  (n * (n+1) /2) **2
S

n <- 5
S <- 1
for (i in 1:n) {
  S = S * i
}
S

gamma(5)  # gamma ft 호출 가능

# exer 3.4
for (i in sapply(1:15, deliver)) {cat(i, '\n')}

for (i in 1:15) {
  cat(i,deliver(i) ,'\n')
}

pizza <- sum(sapply(1:15, deliver) == 'pizza')
chicken <-  sum(sapply(1:15, deliver) == 'chicken')
combo <- sum(sapply(1:15, deliver) == 'pizzanarachickengongjoo')
diet <- sum(sapply(1:15,deliver ) == 'diet')
print(c(pizza, chicken, combo, diet))

# exer 3.5
num <- 9
for (j in 1:num) {
  for (i in 1:num) {
    cat('*')
  } 
  cat('\n')
}

for (j in 1:num) {
  for (i in 1:j) {
    cat('*')
  } 
  cat('\n')
}


for (j in 1:num) {
  if (j %% 2 == 1) {
    for (i in 1:5) {
      cat('*')
    } 
  } else {
    cat('*')
  }
  cat('\n')
}

# exer 3.6 소수 찾기
prime <- c(2)

x <- 1000000
for (num in x:3) {
  v <- 2:(num-1)
  if (length(v[num %% v == 0]) == 0 ) {
    prime <-c(prime, num)
}
}
# 소수 구하기
cat(prime)

# 소수 정렬
sort(prime)

# 소수 개수
length(prime)

length(v[num %% v == 0])
if (length(v[num %% v == 0]) == 0 ) {
  cat('소수입니다')
  
} else {
  v[num %% v == 0]
}


# exer 3.7
yaksoo <- function(n) (1:n)[n %% (1:n) == 0]

length(yaksoo(20))
# 약수 개수가 가장 큰 숫자 찾기 (숫자는 100)
ma <- 0; idx <- 0
for (i in 1:1000) {
  if (ma <= length(yaksoo(i))) {
    idx <- i
    ma <- length(yaksoo(i))
  }
}
# 숫자, 약수개수
c(idx, ma)

yaksoo2 <- function(n) {
  val <- c()
  for (i in  (1:sqrt(n))) {
    if (n %% i == 0) {
      ifelse (i == sqrt(n), val <- c(val, i), val <- c(val, i, n/i)) 
      }
    } return val 
}

yaksoo2(36)
# 논리형 < 숫자형 < 문자형
v <-c(T,T,F,T,F)
v
v2 <-  c(T,T,3,3.14)
v2
v3 <-  c(T,F,3,"3.14")
v3

v <-  c(10,20,30,40,50,60,70)
v[1]

v[7]

v[8] # 범위를 벗어나면 NA

# -를 붙이면 그 번호 제외하고 출력
v[-(1:3)]
v[1:3]

v[c(1,3,5,7)]

v[c(T,T,F,F,F,T,F)]
# 0을 넣으면 numeric(0)
v[0]
v[v]

# 소수를 넣으면 버림하고 정수부분으로 인덱싱
v[2.5]

v[7] <- 700
v

v[1:3] <-  c(100,200,300)
v

v[1:3] <- seq(100,300,100)
v

# 복소수는 허용안됨
w <-  3+4i
v[w]

# 브로드캐스팅
v + 1

# entrywise 계산
c(10,20) + c(30,40)
c(10,000.2) * c(0.5, 0.3)

v > 60
v[v>60]

# 벡터화 연산
1:9 + 1:2
v[c(T,F,T)]

# 1~100
a <- 1:100
sum(a[a%%7 == 0])

sum(seq(7,100,7))

v <- c()
# null 값 확인 하는 함수
is.null(v)

v <-  c(v,1)

for (i in 1:10) {
  v <- c(v,i)
}

v <- c(v, 1:10)

for (i in 1:10) {
  v[i] <- i
}

v <- 1:10
v
v[12] <- 12
v

v <- c(1,-1,2,-3,3.5,4,-2)

iris$Sepal.Length[111]
levels(iris$Species)

# 팩터 : R에서 범주형 데이터 처리하는 데이터 오브젝트
# 벡터의 이해
sex <- c('M', 'F', 'M','F','F')

sex
f.sex <- factor(sex)
f.sex

f <- factor(c('male','female', 'male', 'male','female'))
f
levels(f)

f[f == 'male']
f[f == 'female']
f[6] <-  'male'
f[9] <-  'female'

# NA값은 levels에 포함 안됨
levels(f)

# 작동 안됨(levels에는 male과 female만 들어감)
f[10] <- 'TG'

# 벡터에 없는값도 미리 라벨에 지정해서 나중에 집어넣을 수 있다.
f <- factor(c(1,2,1,2), levels=1:3,
            labels=c('male', 'female', 'tg'))

f[7] <- 'tg'
f

# 리스트
v.1 <-  c(1,2,3)
v.2 <- c('F','F','M')
c(v.1,v.2)
lst <-list(id = v.1,gender = v.2)
lst

lst$id
# 이름을 안 넣으면 아래와 같이 불러온다
lst2 <-list(v.1,v.2)
lst2[[1]]  # lst2[[1,2]] 도 가능

lst <-list(id = v.1,gender = factor(v.2))
lst

data.frame(lst)
# 행렬
# 행렬은 모든 원소가 동일한 원시 자료형을 가져야함

iris[1,]  # 첫번째 행 정보 추출
iris[,2]  # 두번째 열 정보 추출
iris[c(T,F),5] 
iris[1:2,2:3]  # 슬라이싱으로 추출
iris[,"Sepal.Width"] # 열 이름으로 추출
iris[1:5,-5]
iris[iris$Sepal.Length < 5,-5]

# nrow : 로우의 개수 (ncol은 컬럼의 개수)
nrow(iris[iris$Sepal.Length < 5,-5])

# petal.length가 평균보다 큰 데이터의 petal.width 평균값은 얼마인가
mean(iris[iris$Petal.Length > mean(iris$Petal.Length),-5]$Petal.Width)

# which 함수 -> True인 벡터부분의 인덱스 부분을 리턴
v <- seq(7,100,7)
v

which(v %% 3 == 0)
v[which(v %% 3 == 0)]

# n의 약수 모두 출력
num <-  100
v <- 1:num
v[num %% v == 0]
# 약수 개수
length(v[num %% v == 0])

# 축약버전
num <-  100
(1:num)[num %% (1:num) == 0]


# exer 4.1
# 약수의 개수 벡터 div
yaksoo2 <- function(n) length((1:n)[n %% (1:n) == 0])
div <- c(sapply(1:15, yaksoo2))
div
# 약수의 개수가 2인 원소의 개수는 몇개?
sum(div == 2)
# 약수의 개수가 2인 원소의 인덱스를 모두 출력
which(div==2)
# 1에서 15까지 소수의 개수는 몇개?
length(which(div==2))

# exer 4.2
height <- c(163,175,182,178,161)
weight <- c(65,87,74,63,51)
blood <- factor(c("A", "B", "AB","O", "A"))
lst <- list(height = height, weight = weight, blood = blood)
mean(lst$height)
mean(lst$weight)

# 빈도표 만들기
table(lst$blood)

