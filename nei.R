nei_research <- function() {
  
  #Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
  #Using the base plotting system, make a plot showing the total PM2.5 emission from
  #all sources for each of the years 1999, 2002, 2005, and 2008.
  
  #read each of the two files using the readRDS() function in R.
  #NEI <- readRDS("C:/DataScience/module 4/week3/project/summarySCC_PM25.rds")
  #SCC <- readRDS("C:/DataScience/module 4/week3/project/Source_Classification_Code.rds")
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
 
  # Calculate total PM2.5 emissions by year
  totalEmissions <- tapply(NEI$Emissions, NEI$year, sum)
  head(totalEmissions)
  
  # plot total PM2.5 emission from all sources for each of the years 1999 , 2002, 2005, and 2008.
  plot(totalEmissions,
       ylab=" ",xlab=" ",pch=".")
  lines(totalEmissions, type="l") 
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
}
