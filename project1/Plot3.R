
if (!file.exists("./household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.clouplotdataront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./power_data.zip", method = "wget")
  unzip("./power_data.zip", overwrite = T, exdir = "./")
} 


rawfile <- "./household_power_consumption.txt" 
data <- read.table(rawfile, sep = ";", header = T, na.strings = "?") 

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
plotdata <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]
plotdata <- transform(plotdata, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

plot3 <- function() {
  plot(plotdata$timestamp,plotdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(plotdata$timestamp,plotdata$Sub_metering_2,col="red")
  lines(plotdata$timestamp,plotdata$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
  cat("plot3.png has been saved in", getwd())
}
plot3()