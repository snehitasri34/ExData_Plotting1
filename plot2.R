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
#plot2
png(file="plot2.png", width=480, height=480)
plot(data1$Date, data1$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", main = "Plot 2")
dev.off()



