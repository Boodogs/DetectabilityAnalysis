fulldf <- read.csv("~/DetectabilityAnalysis/fulldf.csv")
head(fulldf)

fulldf$TEMP_RANK <- 1:nrow(fulldf)
fulldf$site.key <- paste(fulldf$sYEAR, fulldf$SiteStnName)
colnames(fulldf)[5] <- "Detection"
##### Create a unique index for stations * year

sites <- unique(fulldf$site.key)

#loop through sites
for(i in sites){
  fulldf[fulldf$site.key == i, 'TEMP_RANK'] <- 1:length(fulldf[fulldf$site.key == i, 'TEMP_RANK'])
}

require(reshape)
df2013 <- subset(fulldf, sYEAR == 2013)
fulldf2013 <- cast(df2013, SiteStnName ~ TEMP_RANK, value = fulldf$Detection)

###require(dplyr)

#test <- fulldf %>%
#    group_by(SiteStnName) %>%
#    group_by(sYEAR) %>%
#    slice(which.min(TEMP_RANK))

    

##test <- aggregate(TEMP_RANK ~ SiteStnName + sYEAR, fulldf, function(x) min(x))

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
