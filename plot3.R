plot2 <- function() {
  
  #Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
  #variable, which of these four sources have seen decreases in emissions from 1999-2008
  #for Baltimore City? Which have seen increases in emissions from 1999-2008? 
  
  #read each of the two files using the readRDS() function in R.
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  #Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
  #sub set the data
  NEIBalt <- subset(NEI, fips=='24510')
  
  # Calculate total PM2.5 emissions by year
  totalEmissions <- tapply(NEIBalt$Emissions, NEIBalt$year, sum)
  head(totalEmissions)
  
  if (!require("reshape2")) {
    install.packages("reshape2")
  }
  
  require("reshape2")
  
  longTotalEmissions <- melt(totalEmissions) 
  names(longTotalEmissions)<-c("Year","PMEmissions")
  
  # plot total PM2.5 emission from Baltimore for each of the years 1999 , 2002, 2005, and 2008.
  plot(longTotalEmissions$Year, longTotalEmissions$PMEmissions,
       main = paste("Total PM2.5 Emission Baltimore"), 
       col="red", ylab = "PM2.5 Emission", xlab = "Year")
  lines(longTotalEmissions$Year, longTotalEmissions$PMEmissions, type="l") 
  axis(2)
  dev.copy(png, file="plot2.png", width=500, height=500)
  dev.off()
  
}
