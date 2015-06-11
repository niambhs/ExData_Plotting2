plot1 <- function() {
  
  #Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
  #Using the base plotting system, make a plot showing the total PM2.5 emission from
  #all sources for each of the years 1999, 2002, 2005, and 2008.
  
  #read each of the two files using the readRDS() function in R.
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
 
  # Calculate total PM2.5 emissions by year
  totalEmissions <- tapply(NEI$Emissions, NEI$year, sum)
  head(totalEmissions)
  
  if (!require("reshape2")) {
    install.packages("reshape2")
  }
  
  require("reshape2")
  
  longTotalEmissions <- melt(totalEmissions) 
  names(longTotalEmissions)<-c("Year","PMEmissions")
  
  #Question 1
  
  # plot total PM2.5 emission from all sources for each of the years 1999 , 2002, 2005, and 2008.
  plot(longTotalEmissions$Year, longTotalEmissions$PMEmissions,
       main = paste("Total PM2.5 Emission"), 
       col="red", ylab = "PM2.5 Emission", xlab = "Year")
  lines(longTotalEmissions$Year, longTotalEmissions$PMEmissions, type="l") 
  axis(2)
  dev.copy(png, file="plot1.png", width=500, height=500)
  dev.off()
}
