# 1.여러가지 R함수

# object : R에서 자료, 함수, 연산자 등 객체, 메모리에 저장
# ls() : 객체들의 리스트
# rm() : R 객체를 삭제
# ex. rm(x,y) : x 또는 y라는 이름을 가진 객체 삭제
# help() : R 객체 도움말 출력
# getwd() : 작업 디렉토리(working directory) 탐색 및 지정
# save.image() : 작업 공간(workspace) 저장
# search() : 설치된 R패키지들을 확인하는 명령
# library() : R에 설치된 모든 패키지 및 설명
# library(package_name) : 패키지를 현재 R세션으로 로딩

# install.packages() : R에 새로운 패키지 설치
# ex. install.packages("stringr") 

# 객체별 표시방법 : 알파벳, 숫자, _,. 등의 특수문자의 조합


x <- 1
print(x)

search()
library()


# 2. R 객체의 타입
# atomic(상수), vector(벡터), matrix(행렬), list(리스트), data.frame(데이터프레임), function(함수), operator(연산자), ...
# 2.1 상수 데이터 객체 유형
# 정수형(integer), 실수형(double), 문자형(character), 논리형(logical), 복소수형(complex number)
# 특수 부호 및 값
# NA: 결측치, Inf, -Inf : 무한대, -무한대
# NaN: Not a number

# 정수형, 실수형
# typeof(): 객체의 타입을 알려줌
typeof(10L) # integer

typeof(10) # double

# 문자형
typeof('hello world')

# 논리형
typeof(2<4)

# 2.2 벡터 데이터 객체 유형
# 벡터는 하나 이상의 원소로 이루어진 자료
# 벡터를 구성하는 각 원소는 그 유형(data type)이 동일해야 함
# c(,...,) : 벡터 또는 상수의 연결
# : <- 연속된 정수벡터를 생성하는 연산자

x1 <- c(1,2,3,4)
x3 <- c('Aaa', 'Bbb')
x2 <- 10:15
y <- c(x1,0,x2); y

# rep() : 같은 수의 반복
rep(2,10)

# 벡터의 각 멤버들 5개씩 생성
rep(c(1,2), each=5)

# seq() : 등차 수열 생성 , seq(시작,종료,length=벡터수)
seq(0,1,length=11)  # length=에는 결과물로 나오는 총 벡터 수

seq(1,9,by=2) # by=에는 마다 올라가는 숫자입력

integer(length=10)  # 정수 10개로 구성된 벡터 생성

# 벡터의 클래스
# numeric : 연속형, factor : 범주형, ordered: 순서있는 범주형
x <- c(1:10) # class(x): numeric
class(x)

x <- factor(1:10)  # class(x): factor
class(x)

x <- ordered(1:10) # class(x): ordered, factor
class(x)

# 벡터의 component 접근 : 인덱스 or component이름 이용
x <- c(1,10,7) # 파이썬이랑 다르게 index 1로 시작, 그리고 2<= x <= 3
x[c(2:3)]      # 파이썬이랑 똑같이 인덱싱도 []사용

y <- c(a=1, b=10, c=7) # 여기서 a,b,c가 component 이름이 된다.
y[c("a", "c")]  # component이름 사용해서 인덱싱

# 2.3 행렬 
# 행렬은 matrix() 함수 사용하고, ncol로 컬럼수 지정, 컬럼씩 채워지며 숫자가 들어간다
A <- matrix(c(2,12,5,6,7,3,30,32,20,5,4,2), ncol=3) 
A
A <- matrix(c(2,12,5,6,7,3,30,32,20,5,4,2), ncol=4) 
A
A <- matrix(c(2,12,5,6,7,3,30,32,20,5,4,2), ncol=5) 
# 데이터의길이12가 열의개수5의 배수가 되지 않으면 에러가 난다.

# matrix()의 생성
# nrow로 로우수 지정,
X1 <- matrix(1:20, nrow=2, ncol=5)
X1

# diag(들어갈 숫자, 행수(열수)) -> diagonal matrix 
# diag(행수(열수)) -> diagonal matrix
X2 <- diag(1,5)
X2

X2 <- diag(10)
X2

# diag(벡터) -> 벡터 순서대로 들어가는 diagonal matrix
X2 <- diag(1:10)
X2

X2 <- diag(c(1,3,5,7,9))
X2
# diag(행렬) -> 행렬의 diag 출력
diag(X2) 
# cbind(벡터,벡터) -> 벡터가 컬럼으로 들어가며 행렬이 만들어진다.
x <- c(1,2,3); y <- c(4,5,6)  # cbind -> column bind
cbind(x,y)

# rbind(벡터,벡터) -> 벡터가 로우로 들어가며 행렬이 만들어진다.
rbind(x,y)

# 원소끼리 곱셈(entrywise product)
x <- matrix(c(1:6), ncol=3); x
y <- matrix(c(1,2,3,-1,2,1), ncol=3); y
x*y

# 전치행렬(transpose matrix)
t(x)

# 행렬곱(matrix product) -> %*%
z <- t(x)%*%y; z

# 역행렬(matrix inversion) -> solve
A <- matrix(c(1,2,3,4,1,2,3,1,2), ncol=3); A
solve(A)


# 2.4 리스트
# 서로 다른 R 오브젝트들을 원소로 구성하는 R 오브젝트
# 리스트의 원소
# 상수/벡터, 행렬/데이터프레임, 함수 등 모든 R 오브젝트
# 리스트 생성 -> list() 함수 이용
# list(name_1 = obj_1, ..., name_m = obj_m), name은 component의 이름, obj은 component의 값
Lst <- list(name="Fred", wife="mary", child.ages = c(4,7,9))
Lst

# 리스트의 구성요소(원소)에 접근하는 방법
Lst[[1]]
# 구성요소 이름이 있는 경우
Lst[["name"]]
Lst$name

# 서브리스트 -> :로 표현
Lst[2:3]

# component의 개수 -> length()
length(Lst)

# 리스트의 결합
# 두 개 이상의 리스트를 하나의 리스트로 결합하는 방법
# c() : 벡터 생성 또는 둘 이상의 벡터 결합과 동일
list1 <- list(a1=1, b1=1:3)
list2 <- list(a2=c("kim", "park"))
c(list1, list2)

# 2.5 데이터프레임
# 데이터프레임 : 테이블 형태의 데이터 객체
# 컬럼은 vector, factor 등 서로 다른 속성을 가질 수 있음
# 변수(열)은 길이가 모두 동일

# 데이터프레임을 생성하는 방법
# data.frame() 함수
name <- c("kim", "lee", "park",'oh')
sex <- c('f','m','f','m')
income <- c(100, 102, 300, 204)
d1 <- data.frame(name=name, gender= sex, income = income)
d1  # 넣은 벡터들이 컬럼으로 들어간다

# 리스트나 행렬을 데이터프레임으로 변환 -> as.data.frame() 사용
as.data.frame(list1)

as.data.frame(list2)

# 데이터프레임 관련 함수
# 앞줄, 끝줄 요약 보기
head(d1,2)   # head(데이터프레임, 행_수)

tail(d1,2)   # tail(데이터프레임, 행_수)

# 변수명 출력, 변수명 지정
names(d1)

names(d1)[3]

nrow(d1)  # 행 수

dim(d1) # 차원 (행수, 열수)

ncol(d1) # 열 수

head(iris,3)

names(iris)

dim(iris)
nrow(iris); ncol(iris)

# 2.6 연습문제
