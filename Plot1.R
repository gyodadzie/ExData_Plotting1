
if (!file.exists("./household_power_consumption.txt")) {
 download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./power_data.zip", method = "wget")
  unzip("./power_data.zip", overwrite = T, exdir = "./")
} 


rawfile <- "./household_power_consumption.txt" 
data <- read.table(rawfile, sep = ";", header = T, na.strings = "?") 

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
plotdata <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]

plot1 <- function() {
  hist(plotdata$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  cat("Plot1.png has been saved in", getwd())
}
plot1()