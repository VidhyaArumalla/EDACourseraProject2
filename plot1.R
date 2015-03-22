#Course2_Question1
rm(list=ls())
setwd('C:/Users/Vidhya/Documents/GitHub/EDACourseraProject2')
#reading both files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#calculating total emission by year
yearlyEmission <- aggregate(NEI$Emissions ~ NEI$year, data= NEI, FUN=sum)

#renaming column names for readability
colnames(yearlyEmission)[1] <- "year"
colnames(yearlyEmission)[2] <- "yearlyEmission"

#setting graphical parameters
par(mar=c(5,4.1,2,2))
par(mfrow=c(1,1))

#plotting base plot
plot(yearlyEmission$year, yearlyEmission$yearlyEmission, type="l", lwd= 5, xlab="Year", 
     ylab="PM2.5 Emissions(in Tons)", main="Yearly PM2.5 Emission Trend")

#saving plot as png file
dev.copy(png, file = "plot1.png")

#closing png device
dev.off()


