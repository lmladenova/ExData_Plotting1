# For the script to work, the zip file should be downloaded in your working directory
# unzip the folder
unzip("./exdata_data_household_power_consumption.zip", exdir = "exdata_data_household_power_consumption")
# read only the lines for the measurements for 02-01-2007 to 02-02-2007
data <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt", 
                   sep = ";", na.strings = "?", stringsAsFactors = FALSE, 
                   skip = grep("31/1/2007;23:59:00", readLines("household_power_consumption.txt")), nrow = 2880, 
                   col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# convert the Date character type into Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
# add a new column with combined Date and Time in POXITlt format
data$datetime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")
# open PNG device and create plot1.png file with dimensions 480X480px
png(file = "plot4.png", width = 480, height = 480, units = "px")
# set the dimensions of the plot area, 2x2 plots
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
# create plot1
with(data, plot(datetime, Global_active_power, type = "l", 
                xlab = "", ylab = "Global Active Power", cex.axis = 0.8, cex.lab = 0.8))
        box(which = "plot", col = "gray")
        axis(1, at=c(1170306000, 1170392400, 1170478740), labels = c("Thu", "Fri", "Sat"), cex.axis = 0.8)
        axis(2, cex.axis = 0.8)
# create plot2
with(data, plot(datetime, Voltage, type = "l", 
                xlab = "datetime", ylab = "Voltage", cex.axis = 0.8, cex.lab = 0.8))
        box(which = "plot", col = "gray")
        axis(1, at=c(1170306000, 1170392400, 1170478740), labels = c("Thu", "Fri", "Sat"), cex.axis = 0.8)
        axis(2, cex.axis = 0.8)
# create plot3
with(data, {
        plot(datetime, Sub_metering_1, type = "n", axes = FALSE, 
             xlab = "", ylab = "Energy sub metering", cex.lab = 0.8, cex.axis = 0.8)
        lines(datetime, Sub_metering_1, type = "l", col = "black")
        lines(datetime, Sub_metering_2, type = "l", col = "red")
        lines(datetime, Sub_metering_3, type = "l", col = "blue")
        box(which = "plot", col = "gray")
        axis(1, at=c(1170306000, 1170392400, 1170478740), labels = c("Thu", "Fri", "Sat"), cex.axis = 0.8)
        axis(2, cex.axis = 0.8)
        legend("topright", lty = "solid", bty = "n", col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.7)
})
#create plot4
with(data, plot(datetime, Global_reactive_power, type = "l", 
                xlab = "datetime", ylab = "Global Reactive Power", cex.axis = 0.8, cex.lab = 0.8))
        box(which = "plot", col = "gray")
        axis(1, at=c(1170306000, 1170392400, 1170478740), labels = c("Thu", "Fri", "Sat"), cex.axis = 0.8)
        axis(2, cex.axis = 0.8)
# close the PNG device
dev.off()