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
  
  # Group data by year and type of factoredNEIBalt
  aggregateEmmissions  <- aggregate(Emissions ~ year+type,
                                    data=factoredNEIBalt,
                                    FUN=sum)
    
  head(aggregateEmmissions)
  
  if (!require("ggplot2")) {
    install.packages("ggplot2")
  }
  
  require("ggplot2")
  a <- ggplot(data = aggregateEmmissions, aes(x = year, y = Emissions, col = type, group = type))
  a <- a + geom_point()
  a <- a + geom_line() 
  a <- a + xlab("Year") + ylab("Emmisions") + ggtitle("Total emissions from 1999-2008") + 
    scale_color_discrete(name = "Type")
  #a<-qplot(year, Emissions, data = aggregateEmmissions, geom = c("point", "line"), colour = type)
 

  print(a)
  
 
}
