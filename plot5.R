#Question 5

#reading both files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subsetting data for Baltimore City based on fips value
marylandset <- NEI[NEI$fips=="24510",]

#subsetting SCC data to identify motor vehicles categories. 
##The SCC codes are narrowed down to below set based on details 
## from EPA National Emissions Inventory web site
SCCdata <- SCC[grep(pattern = "22010|22300", x= SCC$SCC),]

#cleaning Baltimore city data filtering it for motor vehicle sources
finaldata <- marylandset[marylandset$SCC %in% SCCdata$SCC,]

#aggregating the data to view how the emissions trend is formed for the city
#calculating total emission for available year in dataset
totalEmission <- aggregate(finaldata$Emissions ~ finaldata$year, data= finaldata, FUN=sum)

#renaming column names for readability
colnames(totalEmission)[1] <- "year"
colnames(totalEmission)[2] <- "totalemission"

library(ggplot2)
#plotting a trend graph and adding a linear regression line
g <- ggplot(totalEmission, aes(year,totalemission))
g + geom_point(size= 3) +
    geom_smooth(method= "lm") + 
    labs(title= "Emission trend in Baltimore City for Motor Vehicles") + 
    labs(x="year", y="Sum of PM2.5 Emission")

#saving plot as png file
dev.copy(png, file = "plot5.png")

#closing png device
dev.off()

