movie <- read.csv("C:\\Users\\DELL\\Desktop\\FE513\\A2\\Movie_DATA-1-1.csv")
directors <- c("Steven Spielberg", "Martin Scorsese", "Alfred Hitchcock", "Stanley Kubrick", "Quentin Tarantino", "Orson Welles", "Francis Ford Coppola", "Ridley Scott",
               "Akira Kurosawa", "Joel Coen", "Ethan Coen", "John Ford", "Sergio Leone", "Woody Allen", "Billy Wilder")
library(plyr)
count(movie$Movie)
count(movie$Reviewer)# To see if there are replicated items
movie$Movie <- as.character(movie$Movie)
movie$Reviewer <- as.character(movie$Reviewer)

Movie <- as.data.frame(matrix(NA, ncol = 4, nrow = 96))
colnames(Movie) <- c("mID", "title", "year", "director")
Reviewer <- as.data.frame(matrix(NA, ncol = 2, nrow = 95))
colnames(Reviewer) <- c("rID", "name")
Rating <- as.data.frame(matrix(NA, ncol = 4, nrow = 96))
colnames(Rating) <- c("rID", "mID", "stars", "ratingDate")

Movie$title <- movie$Movie
Movie$mID <- sample(1000:9999, 96)
Movie$year <- sample(1970:2019, 96, replace = T)
Movie$director <- sample(directors, 96, replace = T)


Reviewer$name <- as.character(unique(movie$Reviewer))
Reviewer$rID <- sample(100:999, 95)

Rating$mID <- Movie$mID# Because no replicated movie here, I checked.
Rating$stars <- movie$Rating
for(i in 1:96){
  Rating$rID[i] <- Reviewer$rID[which(movie$Reviewer[i] == Reviewer$name)]
}

null.date <- sample(1:96, sample(1:96))# Choose some items without rating date
Rating$ratingDate[-null.date] <- as.character(as.Date("1970-01-01") + sample(as.Date("2019-01-01"):as.Date("2019-10-01"), 96-length(null.date), replace = T))

write.csv(Movie, "C:\\Users\\DELL\\Desktop\\FE513\\A2\\Movie.csv", row.names = F, na = '')
write.csv(Reviewer, "C:\\Users\\DELL\\Desktop\\FE513\\A2\\Reviewer.csv", row.names = F, na = '')
write.csv(Rating, "C:\\Users\\DELL\\Desktop\\FE513\\A2\\Rating.csv", row.names = F, na = '')
