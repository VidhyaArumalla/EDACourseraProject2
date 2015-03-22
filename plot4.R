#Course2_Question4

#reading both files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subsetting SCC to find rows that has only coal combustion-related sources
#finding strings that starts with Fuel Comb and ends with Coal
Coaldata <- SCC[grep(pattern = "^[Ff]uel Comb - (.*) - [Cc]oal$", x = SCC$EI.Sector, ignore.case = "TRUE"),]

#filtering NEI data where the SCC codes are available under Coaldata dataframe
#i.e: require only data that have coal combustion source
NEIdata <- NEI[NEI$SCC %in% Coaldata$SCC,]

#adding new column under NEIdata to identify the source name
NEIdata$EI.Sector <- " "
NEIdata[,7] = Coaldata[Coaldata$SCC %in% NEIdata$SCC, 4]

library("dplyr", lib.loc="~/R/win-library/3.1")
#Aggregating the data on yearly basis and coal combustion source basis
newdata <- group_by(NEIdata, year)
coalcombustiondata <- aggregate(newdata$Emissions, by= list(newdata$year, newdata$EI.Sector), FUN= sum)

#renaming the columns under final dataset
names(coalcombustiondata)[1] = "year"
names(coalcombustiondata)[2] = "CoalSource"
names(coalcombustiondata)[3] = "Sum.Emission"

library("ggplot2", lib.loc="~/R/win-library/3.1")

#creating and saving as png file
png("plot4.png", width = 700)

#plotting graph to identify yearly emissions variation from each coal combustion source
g <- ggplot(coalcombustiondata, aes(year, Sum.Emission))
g + geom_point(size= 3) + facet_grid(.~CoalSource) + 
    geom_smooth(method= "lm") + 
    labs(title= "US coal combustion sources Emission yearly trend") + 
    labs(x="year", y="Sum of PM2.5 Emission") 


#closing png device
dev.off()
