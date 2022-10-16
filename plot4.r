library("data.table")

setwd("~/Desktop/datasciencecoursera/4_Exploratory_Data_Analysis/project/data")

#Reading  data from file 
df <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents from Scientific Notation
df[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered 
df[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
df <- df[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(df[, dateTime], df[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(df[, dateTime],df[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(df[, dateTime], df[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(df[, dateTime], df[, Sub_metering_2], col="red")
lines(df[, dateTime], df[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(df[, dateTime], df[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
