library(quantmod)
a <- as.data.frame(getSymbols("SPY", from = "2019-01-01", to = "2019-04-01", auto.assign = F))

player_id <- sample(1:3, 10, replace = T)
device_id <- sample(100:999, 10)
event_date <- sample(rownames(a), 10)
games_played <- sample(0:10, 10)

random.sample <- as.data.frame(cbind(player_id, device_id, event_date, games_played))

write.csv(random.sample, "C:\\Users\\DELL\\Desktop\\FE513\\A3\\sample.csv", row.names = F)


