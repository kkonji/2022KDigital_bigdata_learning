plot(faithful)

eruptions.long <- with(faithful, faithful[eruptions >3,])
points(eruptions.long, col="red", pch=19)
# 고수준 그래픽 함수
# plot() -> 제네릭 그래프 생성, boxplot() -> 상자도표 생성, hist() -> 히스토그램 생성
# qqnorm() -> Q-Q도표 생성, curve() -> 사용자 지정함수로부터 그래프 생성


# 저수준 그래픽 함수 (고수준 그래픽 함수가 있어야 이용가능)
# points() -> 점 추가, lines() -> 선 추가, abline() -> 직선 추가
# segments() -> 꺾은선 추가, polygon() -> 다각형 추가, text() -> 텍스트 추가

dev.off() # 그래프 닫는 함수

faithful.lm <- lm(waiting ~ eruptions, data=faithful) # 회귀모델 추정

plot(faithful)
eruptions.long <- with(faithful, faithful[eruptions >3,])
points(eruptions.long, col="red", pch=19)
lines(x=faithful$eruptions, y=fitted(faithful.lm), col='blue')  # 회귀선 생성

# abline
abline(v=3, col="purple") # v=수직선
abline(h=mean(faithful$waiting), col='green')  # h = 수평선

# abline(a,b) -> y=a+bx 에 대응
abline(a=coef(faithful.lm)[1], b=coef(faithful.lm)[2], col='blue')

# boxplot 예시
str(ToothGrowth)
class(ToothGrowth)
plot(ToothGrowth$supp, ToothGrowth$len)

# 산점도행렬 Scatterplot matrix
str(iris)
plot(iris[,1:4])
plot(iris[,5],iris[,1])

# 시계열 데이터 -> 시계열도표 time series plot
str(nhtemp)
plot(nhtemp)

# 테이블 형식 -> 모자이크 도표 mosaic plot
str(UCBAdmissions)

plot(UCBAdmissions)


# 회귀모델에 관한 진단도표 diagnostic plot
str(faithful)
faithful.lm <- lm(waiting ~ eruptions, data=faithful)
class(faithful.lm)
plot(faithful.lm)

