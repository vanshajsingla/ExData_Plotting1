
library("data.table")

setwd("~/Desktop/datasciencecoursera/4_Exploratory_Data_Analysis/project/data")

#Reading data from file 
df <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents from printing in scientific notation
df[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Changing date column to Date Type
df[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
df <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

########## Plot 1
hist(df[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
