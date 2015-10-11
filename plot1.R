library(dplyr)

houseData <- read.csv('household_power_consumption.txt', 
                 sep = ';', header = TRUE, na.strings = "?")

houseData <- houseData %>% mutate(DateTime = paste(Date, Time))
houseData$Date  <- as.Date(houseData$DateTime, format = "%d/%m/%Y %T")

houseData <- houseData %>% filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")) %>%
                select(-Time,-DateTime)

with(houseData, 
     hist(Global_active_power, col = "red",
          xlab = "Global Active Power (kilowatts)",
          main = "Global Active Power"))

dev.copy(png, "plot1.png")
dev.off()
