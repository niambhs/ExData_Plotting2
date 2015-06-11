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
  
  factoredNEIBalt<-transform(NEIBalt,type=factor(type),year=factor(year))
  
  # Group data by year and type of the source
  aggregateEmmissions  <- aggregate(Emissions ~ year+type,
                                    data=factoredNEIBalt,
                                    FUN=sum)
    
  head(aggregateEmmissions)
  
  if (!require("ggplot2")) {
    install.packages("ggplot2")
  }
  
  require("ggplot2")
  ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar()
  
  
 
}
