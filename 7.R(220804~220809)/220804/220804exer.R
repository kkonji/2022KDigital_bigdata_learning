# exer 3.1
x ** 2
r <-5
2 * pi * r

# exer 3.2 함수화
deliver <- function(n) {
  if (n %% 15 == 0) "pizzanarachickengongjoo"
  else if (n %% 3 == 0) "pizza"
  else if (n %% 5 == 0) "chicken"
  else "diet"
  }

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
