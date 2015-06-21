plot6 <- function() {
  
  #Compare emissions from motor vehicle sources in Baltimore City with emissions 
  #from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
  #Which city has seen greater changes over time in motor vehicle emissions?
  
  #read each of the two files using the readRDS() function in R.
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  
  
  #subset data by vehicle
  vehicleSubset <- subset(SCC, 
                          grepl('Vehicle',EI.Sector),ignore.case = TRUE)
  
  
  NEIBaltLA <- subset(NEI, (fips=="06037" | fips=="24510") & type =="ON-ROAD")
  
  
  NEIBaltLA$fips <- replace(NEIBaltLA$fips, NEIBaltLA$fips == "24510", 
                                    "Baltimore") 
  
  
  NEIBaltLA$fips <- replace(NEIBaltLA$fips, NEIBaltLA$fips == "06037", 
                                    "Los Angeles") 
  
  #establish factors
  factoredNEIBaltLA<-transform(NEIBaltLA,type=factor(type),year=factor(year))
      
  # Group data by year and type of factoredNEIBalt
  aggregateEmmissions  <- aggregate(Emissions ~ year+ fips,
                                    data=factoredNEIBaltLA,
                                    FUN=sum)
  
  if (!require("ggplot2")) {
   install.packages("ggplot2")
  }
  
  require("ggplot2")
  
  a <- ggplot(data=aggregateEmmissions, aes(x = year, y = Emissions,colour=fips, group=fips))
  a <- a + geom_line() 
  a <- a +facet_grid(.~fips)
  a <- a + xlab("Year") + ylab("Emmisions") + ggtitle("Baltimore  and Los Angeles Emmisions 1999-2008") 
  print(a)
  dev.copy(a, file="plot6.png", width=500, height=500)
  dev.off()
  
}
