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

png(file="plot1.png", width=480, height=480)
hist(power$Global_active_power, 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power",
     col = "red")
dev.off()

