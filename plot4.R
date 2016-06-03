#Reading data into R
setwd("/Users/Snehita/Desktop/R_Material/Data_Science_course/3Exploratory_Data_Analysis/Assignment1")
library("RSQLite")
library(DBI)
library(lubridate)
con <- dbConnect(RSQLite::SQLite(), dbname = "uci.sqlite")
dbWriteTable(con, name = "uci1", value="household_power_consumption.txt", row.names=F, header=T, sep=";")
data <- dbGetQuery(con, "SELECT * FROM uci1")
dbDisconnect(con)

#Converting into Date and Time variables
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data1 <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]
data1$Time <- strptime(data1$Time, "%H:%M:%S")
data1$Date <- update(data1$Date, hour = hour(data1$Time), minute = minute(data1$Time), second=second(data1$Time))

#Constructing plots
#plot4
png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(data1, {
  plot(Date, Global_active_power, ylab="Global Active Power", xlab="", type="l")
  plot(Date, Voltage, ylab="Voltage", xlab="datetime", type="l")
  plot(Date, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
  lines(Date, Sub_metering_2, col="red")
  lines(Date, Sub_metering_3, col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lwd=2, cex=0.25, col=c("black", "red", "blue"))
  plot(Date, Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")
})
dev.off()





