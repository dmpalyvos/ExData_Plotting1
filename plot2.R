library(dplyr)

# Load Data
houseData <- read.csv('household_power_consumption.txt', 
                      sep = ';', header = TRUE, na.strings = "?")

# Merge Date and Time and Convert to POSIXct
houseData <- houseData %>% mutate(DateTime = paste(Date, Time))
houseData$Date  <- as.POSIXct(strptime(houseData$DateTime, format = "%d/%m/%Y %T"))

# Subset required data
startTime <- as.POSIXct(strptime("01/02/2007 00:00:00", format = "%d/%m/%Y %T"))
endTime <- as.POSIXct(strptime("02/02/2007 23:59:59", format = "%d/%m/%Y %T"))
houseData <- houseData %>% filter(Date >= startTime & Date <= endTime) %>%
    select(-Time,-DateTime)

# Plot
with(houseData, 
     plot(Date, Global_active_power, type = "l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"
     ))

dev.copy(png, "plot2.png")
dev.off()
