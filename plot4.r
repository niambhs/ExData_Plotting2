plot4 <- function() {
  
  #Across the United States, how have emissions from coal combustion-related 
  #sources changed from 1999-2008?

  #read each of the two files using the readRDS() function in R.
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  #subset data by coal
  coalSubset <- subset(SCC, 
                         grepl('Coal',Short.Name),ignore.case = TRUE)
 
  #merge the data
  mergedData <- merge(NEI, coalSubset, by=c("SCC"))
  
   
  #establish factors
  factoredNEIBalt<-transform(mergedData,type=factor(type),year=factor(year))
  
   
  # Group data by year and type of factoredNEIBalt
  aggregateEmmissions  <- aggregate(Emissions ~ year,
                                    data=factoredNEIBalt,
                                    FUN=sum)
  
  head(aggregateEmmissions)
  
  
  if (!require("ggplot2")) {
    install.packages("ggplot2")
  }
  
  require("ggplot2")
  a <- ggplot(data = aggregateEmmissions, aes(x = year, y = Emissions,group = 1))
  a <- a + geom_point(position=position_jitter(w=0.1,h=0))
  a <- a + geom_smooth() 
  a <- a + xlab("Year") + ylab("Emmisions") + ggtitle("Coal emissions from 1999-2008") 
  
  print(a)
  
}
