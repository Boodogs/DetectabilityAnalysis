fulldf <- read.csv("~/DetectabilityAnalysis/fulldf.csv")
head(fulldf)

fulldf$TEMP_RANK <- 1:nrow(fulldf)
aggregate()

yeardfs <- split(fulldf, f = fulldf$sYEAR)
str(yeardfs) 

df2013 <- yeardfs$`2013`
df2014 <- yeardfs$`2014`
df2015 <- yeardfs$`2015`

sites2013 <- length(df2013$SiteStnName)
visits2013 <- max(aggregate((df2013), list(df2013$SiteStnName), length)$value)

data.wide(
)

sapply(yeardfs, function(x) mean(x$JulianDate))
