plot5 <- function() {
  
  #How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
  
  #read each of the two files using the readRDS() function in R.
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  
  
  #subset data by vehicle
  vehicleSubset <- subset(SCC, 
                       grepl('Vehicle',EI.Sector),ignore.case = TRUE)
  
    
  NEIBalt <- subset(NEI, fips=='24510')
  
  
  #merge the data
  mergedData <- merge(NEIBalt, vehicleSubset, by=c("SCC"))
  
 
  #establish factors
  factoredNEIBalt<-transform(mergedData,type=factor(type),year=factor(year))
  
  
  # Group data by year and type of factoredNEIBalt
  aggregateEmmissions  <- aggregate(Emissions ~ year,
                                    data=factoredNEIBalt,
                                    FUN=sum)
  
  
  if (!require("ggplot2")) {
    install.packages("ggplot2")
  }
  
  require("ggplot2")
  a <- ggplot(data = aggregateEmmissions, aes(x = year, y = Emissions,group = 1))
  a <- a + geom_point(position=position_jitter(w=0.1,h=0))
  a <- a + geom_smooth() 
  a <- a + xlab("Year") + ylab("Emmisions") + ggtitle("Baltimore Vehicle Emmisions 1999-2008") 
  
  print(a)
  
}
