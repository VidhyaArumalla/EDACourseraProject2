#Course2_Question3

#reading both files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetiing Data for Baltimore City
BaltimoreSet <- NEI[NEI$fips=="24510",]


# importing ggplot2 library
library("ggplot2", lib.loc="~/R/win-library/3.1")

#plotting PM2.5 Emissions by type
g <- ggplot(BaltimoreSet, aes(year, Emissions))
g + geom_point(size= 3) + facet_grid(type~.) + 
    geom_smooth(method= "lm") + 
    labs(title= "Emission trend in Baltimore City") + 
    labs(x="year", y="PM2.5 Emission") 


#saving plot as png file
dev.copy(png, file = "plot3.png")

#closing png device
dev.off()


