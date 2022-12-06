
?median

args(median)

example(median)

apropos()

install.packages('sos')

history()
.Last.value

search()

library('ggplot2')

df <- mtcars
str(df)
df$am <- factor(df$am, levels=c(0,1), labels=c('auto', 'manual'))
g <- split(x=df$mpg, f=df$am)
g
with(df, split(x=mpg, f=am))
split(x=df, f=df$am)
unstack(data.frame(df$mpg, df$am))

unstack(data.frame(iris$Sepal.Length, iris$Species))
summary(unstack(data.frame(iris$Sepal.Length, iris$Species)))

tapply(X=iris$Sepal.Length, INDEX=iris$Species, FUN=mean)
tapply(X=iris$Sepal.Width, INDEX=iris$Species, FUN=mean)
tapply(X=iris$Petal.Length, INDEX=iris$Species, FUN=mean)

with(iris, tapply(X=Petal.Length, Species, mean))

with(df, tapply(mpg, list(Cylinder=cyl, Transmission = am), mean))
with(df, aggregate(x= mpg, by=list(Cylinder=cyl, Transmission = am), FUN= mean))
df[c(1:6)]
df$cyl
aggregate(df[c(1:6)], list(Group.cy1=df$cyl, Group.am=df$am), mean)

with(df, aggregate(df[c(1:6)], list(Group.cy1=cyl, Group.am=am), mean))

by(data=iris, INDICES=iris$Species, FUN=summary)
by(iris, iris$Species, function(x) mean(x$Sepal.Length))

rowsum(x=iris[-5], group=iris$Species)

table(df$gear)

table(df$am, df$gear)

mpg.cut <- cut(df$mpg, breaks=5, include.lowest = T)
table(mpg.cut)

xtabs(formula=~am+gear, data=df)
