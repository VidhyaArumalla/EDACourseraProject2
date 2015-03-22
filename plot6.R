#Question 6

#reading both files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subsetting data for Baltimore City and Los Angeles County based on fips value
cityset <- NEI[NEI$fips=="24510" | NEI$fips == "06037",]

#subsetting SCC data to identify motor vehicles categories. 
##The SCC codes are narrowed down to below set based on details 
## from EPA National Emissions Inventory web site
SCCdata <- SCC[grep(pattern = "22010|22300", x= SCC$SCC),]

#cleaning both cities data to filter for motor vehicle sources
finaldata <- cityset[cityset$SCC %in% SCCdata$SCC,]

#aggregating the data on yearly basis and motor vehicle sources
newdata <- group_by(finaldata, year)
vehicledata <- aggregate(newdata$Emissions, by= list(newdata$year, newdata$fips), FUN= sum)

#creating a new column to label the rows against LA County and Baltimore City
vehicledata$city <- gl(2,4, labels=c("Los Angeles County","Baltimore City"))


#renaming the columns under final dataset
names(vehicledata)[1] = "year"
names(vehicledata)[2] = "fips"
names(vehicledata)[3] = "Sum.Emission"
names(vehicledata)[4] = "city"

library(lattice)
#plotting graph with panels to compare 2 cities data
qplot(year, Sum.Emission, data=vehicledata, geom=c("point", "smooth"), 
      method="lm", color=city,
      main= "Motor Vehicle Emissions in 2 cities",
      xlab="Year", ylab="Sum of PM2.5 Emission")

#saving plot as png file
dev.copy(png, file = "plot6.png")

#closing png device
dev.off()


