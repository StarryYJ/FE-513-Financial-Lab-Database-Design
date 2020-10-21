get.data <- function(ticker.name, time.interval){
  library(quantmod)
  stock.data <- getSymbols(as.character(ticker.name), from = "2017-01-01", to = "2017-12-31", auto.assign = F)
  adj.close <- as.numeric(stock.data[, 6])
  if (length(adj.close) %% time.interval != 0){
    adj.close <- c(adj.close, rep(NA, time.interval - length(adj.close) %% time.interval))
  }
  origData <- as.data.frame(matrix(adj.close, ncol = time.interval, 
                                     nrow = ceiling(length(adj.close)/time.interval), byrow = T))
  return(origData)
}

a <- get.data("AAPL", 9)
a
