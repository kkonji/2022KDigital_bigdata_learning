# 연관 분석 (장바구니 분석) : 어떤 물건들이 장바구니에 잘 나타나는가?

# 3.1 데이터 시각화의 이해
# 가치있는 정보를 의미있게 전달

library(tidyverse)

str(diamonds)
str(mpg)

anscombe

ans <- anscombe

mean(ans$x1)
mean(ans$x2)
mean(ans$x3)
mean(ans$x4)

mean(ans$y1)
mean(ans$y2)
mean(ans$y3)
mean(ans$y4)

cor(ans$x1, ans$y1)
cor(ans$x2, ans$y2)
cor(ans$x3, ans$y3)
cor(ans$x4, ans$y4)

lm(y1~x1,data=ans)
lm(y2~x2,data=ans)
lm(y3~x3,data=ans)
lm(y4~x4,data=ans)

# 평균과 상관관계, 회귀계수가 모두 일치
par(mfrow=c(2,2))
plot(ans$x1,ans$y1, col='coral', pch=19)
abline(lm(y1~x1, data=ans), col='steelblue')

plot(ans$x2,ans$y2, col='coral', pch=19)
abline(lm(y2~x2, data=ans), col='steelblue')

plot(ans$x3,ans$y3, col='coral', pch=19)
abline(lm(y3~x3, data=ans), col='steelblue')

plot(ans$x4,ans$y4, col='coral', pch=19)
abline(lm(y4~x4, data=ans), col='steelblue')
par(mfrow=c(1,1))

?mpg
# ggplot 그리기
# aes -> aesthetic, geom_point -> 산점도
ggplot(data= mpg, 
       mapping = aes(x=displ, y=hwy)) +
  geom_point() 
  
p <- ggplot(data= mpg, 
       mapping = aes(x=displ, y=hwy))
p + geom_point()
p + geom_point(mapping=aes(color=class))
p + geom_point(mapping=aes(color=21))  # 컬러값으로 숫자를 줘야함

table(mpg$class) # size, shape, alpha
p + geom_point(mapping=aes(color=class, size=class))
p + geom_point(mapping=aes(color=class, shape=class))
p + geom_point(mapping=aes(color=class, size=class, alpha=0.3))

# PLOT을 면 분할(facet)
# facet_wrap : 범주형 한 컬럼을 기준으로 그래프 쪼개기
# facet_grid : 범주형 두 컬럼 이상을 기준으로 그래프 쪼개기
p + geom_point(mapping=aes(color=class)) + facet_wrap(~class, nrow=2)
p + geom_point(mapping=aes(color=class)) + facet_grid(drv ~ cyl)

p + geom_point(color='tomato') + facet_wrap(~class, nrow=4)

# geom : geometric object, geom_jitter : 흔들기
# geom_smooth : 추세선 -> 회귀 종류 결정 가능
p + geom_point(color='blue') + geom_smooth(color='cyan')

# 다이아몬드 셋 실습
str(diamonds)
head(diamonds)

# 막대그래프 그리기 (x축만 주면, 카운트 개수를 y축으로 자동으로 그려준다.)
p <- ggplot(data=diamonds, mapping=aes(x=cut))
p + geom_bar()

# stacked_bar 그래프 그리기 
p + geom_bar(mapping = aes(fill=clarity))

# 비율로 비교 -> position ='fill' 추가 
p + geom_bar(mapping = aes(fill=clarity),position='fill')

# 여러막대그래프로 그리기 -? position='dodge'
p + geom_bar(mapping = aes(fill=clarity),position='dodge')


# 데이터 사우루스 -> 기술적 통계량에 의존하는 것을 넘어 데이터 시각화를 통해
# 더 넓은 시야를 확보할 수 있다.
library(tidyverse)
library(datasauRus)

data(package = 'datasauRus')

dd <- datasaurus_dozen
str(dd)
unique(dd$dataset)

plot(y~x, data=subset(dd, dataset== 'dino'), pch=19, col='tomato')

p <- ggplot(data=dd, mapping = aes(x=x, y=y))
p + geom_point(mapping=aes(color=dataset)) + facet_wrap(~dataset, nrow=4)
p + geom_point(color='#EF3366')

# 분류(classification) <-> 클러스터링(clustering)
# 지도학습            <-> 비지도학습

# 정형 : 숫자형, 범주형 등의 일정한 형식으로 표현할 수 있는 데이터
# ex. 키,나이,성별,혈액형 등
# 비정형 : 숫자형, 범주형 등의 일정한 형식이 없는 데이터
# ex. 텍스트, 이미지, 동영상, 사운드 또는 이런 데이터들의 혼합
# 반정형 : 일정한 형식이 없지만, 구조적으로 표현할 수 있는 데이터
# ex. HTML / XML 문서, JSON 포맷 등

# R: ggplot, python: matplotlib, Javascript: D3.js
# tableau, Microsoft Power BI : 비즈니스 인텔리전스 도구

# 인포그래픽 infographic : 정보 + 그래픽 
# 복잡한 정보, 자료, 지식 등을 빠르고 명확하게 시각적으로 표현하는 것

# 정보형 메시지 vs 설득형 메시지

# 대시보드 Dashboard : 현재 상황을 모니터링하거나 이해하기 위한 (한 페이지의) 시각적 데이터 표현

# 실습 
# 박스플롯 geom_boxplot
# coord_flip(): 그래프 뒤집음
p <- ggplot(data=mpg, aes(x=displ, y=hwy))
p + geom_boxplot(mapping=aes(color=class), fill='tomato') +
  coord_flip()

# 막대그래프 geom_bar 
p <- ggplot(diamonds, aes(x=cut, fill=cut))
p + geom_bar(show.legend=F, width=1)

p + geom_bar(show.legend=F, width=1) + coord_polar() + labs(x=NULL, y=NULL)

# 지도 그리기 
world <- map_data('world')
Asia <- world[world$region %in% c('South Korea', 'North Korea', 'Japan', 'Mongolia', 'China', 'Indonesia', 'Vietnam', 'Thailand', 'Laos', 'India', 'Cambodia', 'Myanmar', 'Taiwan', 'Afghanistan', 'Pakistan', 'Nepal', 'Bhutan', 'Bangladesh', 'Philippines', 'Kazakhstan', 'Sri Lanka', 'Kyrgyzstan','Turkmenistan', 'Uzbekistan', 'Tajikistan', 'Malaysia', 'Iran'),] 

ggplot(Asia, aes(long, lat, group=group))+ geom_polygon(fill='steelblue', color = 'blue')

ggplot(world, aes(long, lat, group=group))+ geom_polygon(fill='steelblue', color = 'blue')

# ggplot(data=<DATA>) + 
# <GEOM_FUNCTION> ( mapping = aes(<MAPPINGS>) , stat = <STAT>, position = <POSITION>) 
# + <coordinate_function> + <facet_function>

# p + labs(title=, subtitle=, caption=, x=, y=, color=, )

str(mpg)
sd(mpg[mpg$hwy > mean(mpg$hwy), c(1,2,9,11)]$hwy)

v <- c(10, 30, 50, 20, 40)
sort(v)

# 파이프라인 연산자
# 클래스 별로 어떤게 연비가 제일 작은지 표시
v <- mpg %>% 
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)
v

p <- ggplot(mpg, aes(x=displ, y=hwy))
p + geom_point(aes(color=class)) + geom_text(mapping=aes(label=model), data=v)

# nudge_y, alpha 사용
p + geom_point(aes(color=class)) + geom_label(mapping=aes(label=model), data=v, nudge_y = 2, alpha=0.5)

# 범례 옮기기 theme 사용
p + geom_point(aes(color=class)) + geom_label(mapping=aes(label=model), data=v, nudge_y = 2, alpha=0.5) + theme(legend.position = 'top')

p + geom_point(aes(color=class)) + geom_label(mapping=aes(label=model), data=v, nudge_y = 2, alpha=0.5) + theme(legend.position = 'bottom')

# 범례 한줄로 나오게 하기
p + geom_point(aes(color=class)) + geom_label(mapping=aes(label=model), data=v, nudge_y = 2, alpha=0.5) + theme(legend.position = 'bottom') + guides(color=guide_legend(nrow=1, override.aes = list(size=4)))

# 그림 간소화
p + geom_point(aes(color=class)) + geom_label(mapping=aes(label=model), data=v, nudge_y = 2, alpha=0.5) + theme(legend.position = 'bottom') + theme_minimal()

# 코드로 그림 다운받기(가장 마지막에 그린 그림 다운로드)
ggsave(file='./figures/myplot.png', width=1920, height=1080, units='px')
ggsave(file='./figures/myplot.pdf', width=1920, height=1080, units='px')

# 사이트에서 그래프 받아오기

# library
library(ggplot2)
library(dplyr)
library(hrbrthemes)

# Build dataset with different distributions
data <- data.frame(
  type = c( rep("variable 1", 1000), rep("variable 2", 1000) ),
  value = c( rnorm(1000), rnorm(1000, mean=4) )
)
data 
library(palmerpenguins)
pg <- data.frame(penguins)
str(pg)
pg <- na.omit(pg)

colnames(pg)
# Represent it 
# 펭귄 - 성별로 히스토그램
p <- pg %>%
  ggplot( aes(x=flipper_length_mm, fill=sex)) +
  geom_histogram( color="#e9ecef", alpha=0.6, position = 'identity') +
  scale_fill_manual(values=c("#69b3a2", "#404080")) +
  theme_ipsum() +
  labs(fill="")
p

# 펭귄 - 종별로 히스토그램
p <- pg %>%
  ggplot( aes(x=flipper_length_mm, fill=species)) +
  geom_histogram( color="#e9ecef", alpha=0.6, position = 'identity') +
  scale_fill_manual(values=c("#69b3a2", "#404080", "#503040")) +
  theme_ipsum() +
  labs(fill="")
p


# Library
library(igraph)

# Create data
set.seed(1)
data <- matrix(sample(0:1, 100, replace=TRUE, prob=c(0.9,0.1)), nc=10)
network <- graph_from_adjacency_matrix(data , mode='undirected', diag=F )

data

# Default network
par(mar=c(0,0,0,0))
plot(network)

# ggplot gui형태로 그리는 라이브러리 : esquisse
library(esquisse)

library(gapminder)
gp <- gapminder
library(ggplot2)

ggplot(gp) +
 aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop) +
 geom_point(shape = "circle") +
 scale_color_hue(direction = 1) +
 labs(x = "수입", y = "기대수명", title = "Gapminder 따라하기", 
 subtitle = "나", caption = "figure1. 한스 로슬링 표절") +
 theme_classic() +
 facet_wrap(vars(year))


# 데이터시각화 2
# 전주의적 속성 : 주의를 기울이지 않아도, 직관적으로 정보를 처리할 수 있는 시각적 속성
# length, width, orientation, size, shape, enclosure, position, grouping, color hue, color intensity 등

# 게슈탈트 법칙 Gestalt Principles : 
# 1. 근접성의 법칙 : 위치적으로 서로 근접한 객체들은 같은 그룹으로 인지
# 2. 유사성의 법칙 : 같은 시각적 속성(색,모양 등)을 갖는 물체는 같은 그룹으로 인지
# 3. 폐쇄성의 법칙 : 일부가 빠지거나 생략된 객체는 부족한 부분을 보충해서 인지
# 4. 연속성의 법칙 : 서로 연결된 객체들은 하나의 그룹으로 인지
# 5. 전경/배경의 법칙 : 전경과 배경의 조화를 통해 시각적 자극에 대해서 인지

# 다양한 시각화의 방식
# 수량의 시각화
# 분포의 시각화
# 비율의 시각화
# x-y 관계 시각화
# 지리공간 데이터 시각화
# 불확실성 시각화

# 데이터 잉크
# 1. 배경, 범례, 테두리, 색깔, 특수효과, 굵은 글씨 지워라
# 2. 라벨을 흐리게 처리, 보조선을 흐리게 처리 하거나 지워라
# 3. 라벨을 직접 표시



