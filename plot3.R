plot3 <- function() {
  
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
  totalEmissions <- data.frame(tapply(NEIBalt$Emissions, list(NEIBalt$year,NEIBalt$type), sum))
  colnames(totalEmissions)[1]="Year"
  
  head(totalEmissions)
  
}
