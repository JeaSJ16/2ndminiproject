#Jea Juanillo
#BS in Statistics
#CMSC197
#Second Mini Project

#Set the working directory
setwd("D:/Users/Personal Computer/Desktop/CMSC-197/specdata")
#unzip the file
unzip(zipfile="household_power_consumption_data.zip", exdir=getwd())


#Read the file household_power_consumption.txt in table format and creating a data frame. 
house_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

#Extracting data according to dates. 
house_data$Date <- as.Date(house_data$Date, "%d/%m/%Y")

#Sub-setting data from the dates 2007-02-01 and 2007-02-02 only. 
house_data <- subset(house_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#Return logical vectors with cases. 
house_data <- house_data[complete.cases(house_data),]

#Combine Date and Time.  
Date_Time <- paste(house_data$Date, house_data$Time)

#Set the name of vector Date_Time. 
Date_Time <- setNames(Date_Time, "DateTime")

#Remove Date and Time and add the Date_Time column. 
house_data <- house_data[ ,!(names(house_data) %in% c("Date","Time"))]
house_data <- cbind(Date_Time, house_data)

#Format the Date_Time column.
house_data$Date_Time <- as.POSIXct(Date_Time)

#Create plot1.
hist(house_data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="yellow")

#Save file as plot1.png.
dev.copy(png,"plot1.png", width=720, height=720)
dev.off()

#Create Plot 2. 
#The Global Active Power (kilowatts) as y-axis and use type 1 graph.
plot(house_data$Global_active_power~house_data$Date_Time, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#Save file as plot2.png.
dev.copy(png,"plot2.png", width=720, height=720)
dev.off()


#Create Plot3
with(house_data, {
  plot(Sub_metering_1~Date_Time, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Date_Time,col='Blue')
  lines(Sub_metering_3~Date_Time,col='Yellow')
})
legend("topright", col=c("black", "blue", "yellow"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Save file as plot3.png.
dev.copy(png, file="plot3.png", height=720, width=720)
dev.off()

#Create Plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(house_data, {
  plot(Global_active_power~Date_Time, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Date_Time, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Date_Time, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Date_Time,col='Blue')
  lines(Sub_metering_3~Date_Time,col='Yellow')
  legend("topright", col=c("black", "blue", "yellow"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Date_Time, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

#Save file as plot4.png.
dev.copy(png, file="plot4.png", height=720, width=720)
dev.off()

