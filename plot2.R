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

png(file="plot2.png", width=480, height=480)
plot(power$DateTime, power$Global_active_power, type = "l", xaxt = "n",
           xlab=NA, ylab="Global Active Power (kilowatts)")
axis(1, at = c(min(power$DateTime), mean(power$DateTime), 
               max(power$DateTime)), 
     labels=c("Thu", "Fri", "Sat"))
dev.off()

print("Output is in file plot2.png")
