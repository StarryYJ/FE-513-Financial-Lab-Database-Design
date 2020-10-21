library(DBI)
library(RPostgreSQL)
library(twitteR)


setup_twitter_oauth("hMXVGuj8ejzvYnaV5VoKzRfNY", 
                    "3ywTblsfg8DkixsSiv29aaVYqWJ2hH6a3R8TZTCQ68hVAEfGYT", 
                    "1199940215470743552-QtSvHy4VbCOTrhf8ai2ZnBVwUWTMnC", 
                    "376jGsjosUqfMgYMZCe6QerSTLNoS1Q2Tzw8QGEo87JfP")


data <- searchTwitter("NASA", n = 50)


data.df <- twListToDF(data)
for (i in 1:5) {
  cat(paste0("[", i, "] "))
  writeLines(strwrap(data.df$text[i], 60))
}

