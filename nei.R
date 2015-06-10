nei_research <- function() {
  
  if (!require("sqldf")) {
    install.packages("sqldf")
  }
  
  require("sqldf")
  
  if (!require("tcltk2")) {
    install.packages("tcltk2")
  }
  
  require("tcltk2")
  
  
  file<-"household_power_consumption.txt"
  
  mySql <- "select * from file where Date in ('1/2/2007','2/2/2007')"
  householdpower <-read.csv.sql(file,sql = mySql,header=T,sep=";")
  householdpower$Date <- as.Date(householdpower$Date, format="%d/%m/%Y")
  householdpower$Global_active_power<-as.numeric(as.character(householdpower$Global_active_power))
  householdpower$Global_reactive_power<-as.numeric(as.character(householdpower$Global_reactive_power))
  householdpower$Voltage<-as.numeric(as.character(householdpower$Voltage))
  householdpower$Global_intensity<-as.numeric(as.character(householdpower$Global_intensity))
  householdpower$Sub_metering_1<-as.numeric(as.character(householdpower$Sub_metering_1))
  householdpower$Sub_metering_2<-as.numeric(as.character(householdpower$Sub_metering_2))
  householdpower$Sub_metering_3<-as.numeric(as.character(householdpower$Sub_metering_3))
  
  householdpower[,'timestamp'] <-as.POSIXct(paste(householdpower$Date, householdpower$Time), format="%Y-%m-%d %H:%M:%S")
  
  old.par <- par(mfrow=c(2, 2))  
  
  #plot Global Active Power (kilowatts)
  plot(householdpower$timestamp,householdpower$Global_active_power,
       ylab="Global Active Power (kilowatts)",xlab=" ",pch=".")
  lines(householdpower$timestamp,householdpower$Global_active_power, type="l") 
  
  #plot Voltage
  plot(householdpower$timestamp,householdpower$Voltage,
       ylab="Voltage",xlab=" ",pch=".")
  lines(householdpower$timestamp,householdpower$Voltage, type="l") 
  
  
  
  #plot Energy Sub Metering
  with(householdpower, plot(householdpower$timestamp, householdpower$Sub_metering_1, type = "n", 
                            ylab="Energy Sub Metering",xlab=" "))
  with(householdpower, lines(householdpower$timestamp, householdpower$Sub_metering_1, col = "black"))
  with(householdpower, lines(householdpower$timestamp, householdpower$Sub_metering_2, col = "red"))
  with(householdpower, lines(householdpower$timestamp, householdpower$Sub_metering_3, col = "blue"))
  
  legend(x="topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         cex=.5,lty=c(1,1), col=c("black","red","blue"),bty = "n")
  
  #plot Global Reactive Power
  plot(householdpower$timestamp,householdpower$Global_reactive_power,
       ylab="Global Reactive Power",xlab=" Date Time ",pch=".")
  lines(householdpower$timestamp,householdpower$Global_reactive_power, type="l") 
  
  
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
  
}
