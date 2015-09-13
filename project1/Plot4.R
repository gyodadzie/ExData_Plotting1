
if (!file.exists("./household_power_consumption.txt")) {
 download.file("https://d396qusza40orc.clouplotdataront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./power_data.zip", method = "wget")
  unzip("./power_data.zip", overwrite = T, exdir = "./")
} 


rawfile <- "./household_power_consumption.txt" 
data <- read.table(rawfile, sep = ";", header = T, na.strings = "?") 

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
plotdata <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]
plotdata <- transform(plotdata, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

plot4 <- function() {
  par(mfrow=c(2,2))
  
  ##PLOT 1
  plot(plotdata$timestamp,plotdata$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  ##PLOT 2
  plot(plotdata$timestamp,plotdata$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  ##PLOT 3
  plot(plotdata$timestamp,plotdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(plotdata$timestamp,plotdata$Sub_metering_2,col="red")
  lines(plotdata$timestamp,plotdata$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
  
  #PLOT 4
  plot(plotdata$timestamp,plotdata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  #OUTPUT
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
  cat("plot4.png has been saved in", getwd())
}
plot4()