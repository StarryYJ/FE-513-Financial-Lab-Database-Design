# Exercise 1
# Vector Part
FN <- c("Yuwen")
LN <- c("Jin")
FullN <- c(FN, LN)
typeof(FullN)
is.vector(FullN)
FullN.camID <- c(FullN, "10455173") 
FullN.camID.2 <- append(FullN, "10455173")# Another way
df.Name.ID <- as.data.frame(FullN.camID)
rownames(df.Name.ID) <- c("First name", "Last name", "Campus ID")
df.Name.ID
# Missing value will be shown as "NA".

# Matrix Part
vec1 <- 1:10
M <- matrix(vec1, ncol = 2)
M
M <- t(M)
M
M[2,1]

X <- c(3,2,4)
Y <- c(1,2)
Z <- X*Y
Z
# We do have output Z as (3,4,4) if define Z as X*Y here but it's kind of tricky.
# Because X and Y have different length, only the first 2 elements in each vector will be multipled,
# while the third element showed in Z is X[3]*Y[1], Y is repeated when there is not enough element.

# Function Part
# "With()" means limit operation to certain range. For example, with(SIT, students) means call the "students" items in data "SIT".
# "By()" function applies a function to a data frame split by factors

# "lapply" we may regard it as "list apply", and "sapply" stands for simplified lapply.
# When output can be simplified, sapply will give us a more simple result. (output vector instead of list)
# For example:
a <- rep(1:3, 3)
b <- rep(2:4, 3)
lapp <- lapply(cbind(a,b), mean)
sapp <- sapply(cbind(a,b), mean)

# We can read a csv file like the following:
read.csv("C:\\Users\\DELL\\Desktop\\FE513\\A1\\AAPL1.csv")

# Application
# Fibonacci numbers
Feb.Seq <- function(x){
  feb.seq <- NULL
  i <- 0 # First time it stands for the first number
  k <- 1 # At the beginning it stands for the second number
  m <- 0 # help to mark nmbers
  while (i >= 0){
    if (length(feb.seq) >= x){
      print(feb.seq)
      break
    }
    feb.seq <-c(feb.seq, i)
    m <- k
    k <- k + i
    i <- m
  }  
}
Feb.Seq(10)# To show how long a Feb.seq depends on you

# My own max function to pick the largest number in a vector.
pick.max <- function(x){
  for (i in 1:length(x)) {
    a <- (x[i]-x >= 0)+0
    if (sum(a) == length(x)){
      print(paste("The largest number among the input is", x[i]))
      break
    }
  }
}
test.num <- rnorm(100, 9, 9)
pick.max(test.num)
max(test.num)# Only for check

# locker function
Log.in <- function(x){
  Password <- readline("Please set your password: ")
  Check <- readline("Please enter your password again: ")
  if (Check == Password){
    cat("Access\n")
  } else{
    cat("Denied\n")
  }
}
Log.in()

# Exercise 2
# Sub-question 2-1:
library(quantmod)
Apple <- getSymbols(Symbols = "AAPL", from = "2009-01-01", to = "2019-01-01", auto.assign = F)
Apple <- data.frame(Apple)
write.csv(Apple, "C:\\Users\\DELL\\Desktop\\FE513\\A1\\AAPL1.csv")
# Also we can read the csv as follow:
read.csv("C:\\Users\\DELL\\Desktop\\FE513\\A1\\AAPL1.csv")

# Sub-question 2-2:
r.t <- as.data.frame(matrix(data = NA, nrow = (nrow(Apple)-1), ncol = 3))
for (i in 2:nrow(Apple)) {
  r.t[i-1, 1] <- rownames(Apple)[i]
  r.t[i-1, 2] <- log(Apple$AAPL.Adjusted[i]) - log(Apple$AAPL.Adjusted[i-1])
  r.t[i-1, 3] <- sum(r.t[1:(i-1), 2])
}
names(r.t) <- c("Date", "Single L.r", "multiple time interval L.r")
daily.log.return <- r.t[, 2]

# Sub-question 2-3:
median(r.t$`Single L.r`)
mean(r.t$`Single L.r`)
sd(r.t$`Single L.r`)

# Sub-question 2-4:
nrow(r.t[r.t$`Single L.r` > 0.01 & r.t$`Single L.r` < 0.015,])

# Sub-question 2-5:
hist <- hist(r.t$`Single L.r`, breaks = 20, xlab = "Daily log return", main = "Daily log return")








