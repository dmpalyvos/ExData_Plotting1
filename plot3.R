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
with(houseData, {
     plot(Date, Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
     lines(Date, Sub_metering_2, type = "l", col = "red")
     lines(Date, Sub_metering_3, type = "l", col = "blue")
     legend("topright",legend = colnames(houseData[6:8]), col = c("black","red","blue"), lty = 1)}
)

dev.copy(png, "plot3.png")
dev.off()
