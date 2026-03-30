library(tidyverse)

power <- read.csv2("household_power_consumption.txt", 
          sep = ";", dec = ".", na.strings = "?") |> 
    filter(grepl("^[12]/2/2007", Date)) |> 
    mutate(DateTime = str_c(Date, Time, sep=" "), 
           .before=everything(), .keep = "unused",
           DateTime = as.POSIXct(DateTime, "%d/%m/%Y %H:%M:%S",
                                 tz = "UTC"),
           Global_active_power = as.numeric(Global_active_power),
           Global_reactive_power = as.numeric(Global_reactive_power),
           Voltage = as.numeric(Voltage),
           Global_intensity = as.numeric(Global_intensity),
           Sub_metering_1 = as.numeric(Sub_metering_1),
           Sub_metering_2 = as.numeric(Sub_metering_2),
           Sub_metering_3 = as.numeric(Sub_metering_3))

png(file = "plot4.png", height = 480, width = 480)

par(mfrow = c(2,2), cex = 0.8, oma = c(1,1,1,1), col = "black")

plot(power$DateTime, power$Global_active_power, 
     type = "l", xaxt = "n",
     xlab=NA, ylab="Global Active Power")
axis(1, at = c(min(power$DateTime), mean(power$DateTime), 
               max(power$DateTime)), 
              labels=c("Thu", "Fri", "Sat"))

plot(power$DateTime, power$Voltage, type = "l", xaxt = "n",
     xlab = "datetime", ylab = "Voltage")
axis(1, at = c(min(power$DateTime), mean(power$DateTime), 
               max(power$DateTime)), 
     labels=c("Thu", "Fri", "Sat"))

plot(power$DateTime, power$Sub_metering_1, type = "l", xaxt = "n",
     xlab=NA, ylab="Energy sub metering", col="black")
lines(power$DateTime, power$Sub_metering_2, col="red")
lines(power$DateTime, power$Sub_metering_3, col="blue")
axis(1, at = c(min(power$DateTime), mean(power$DateTime), 
               max(power$DateTime)), 
     labels=c("Thu", "Fri", "Sat"))
par(cex = 0.3)
legend(x = "topright", legend = c("Sub_metering_1", 
                                  "Sub_metering_2",
                                  "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

par(cex = 0.8)
plot(power$DateTime, power$Global_reactive_power, 
     type = "l", xaxt = "n", xlab = "datetime",
     ylab = "Global reactive power")
axis(1, at = c(min(power$DateTime), mean(power$DateTime), 
               max(power$DateTime)), 
     labels=c("Thu", "Fri", "Sat"))

dev.off()

print("Output is in file plot4.png")
