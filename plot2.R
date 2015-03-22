#Course2_Question2

#reading both files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetiing Data for Baltimore City
BaltimoreSet <- NEI[NEI$fips=="24510",]

#calculating total emission for available year in dataset
yearlyEmission <- aggregate(BaltimoreSet$Emissions ~ BaltimoreSet$year, data= BaltimoreSet, FUN=sum)

#renaming column names for readability
colnames(yearlyEmission)[1] <- "year"
colnames(yearlyEmission)[2] <- "Emission"

#setting graphical parameters
par(mar=c(5,4.1,2,2))
par(mfrow=c(1,1))

#plotting base plot
plot(yearlyEmission$year, yearlyEmission$Emission, type="l", lwd= 4, col= "blue",xlab="Year", 
     ylab="PM2.5 Emissions(in Tons)", main="Baltimore City Yearly PM2.5 Emissions Trend")

#saving plot as png file
dev.copy(png, file = "plot2.png")

#closing png device
dev.off()


