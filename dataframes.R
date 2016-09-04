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

years <- levels(fulldf$sYEAR)

require(reshape)
df2013 <- subset(fulldf, sYEAR == 2013)
df2014 <- subset(fulldf, sYEAR == 2014)
df2015 <- subset(fulldf, sYEAR == 2015)

#data.by.station <- split(df2013, df2013$SiteStnName)

write.csv(df2013, "df2013.csv")
write.csv(df2014, "df2014.csv")
write.csv(df2015, "df2015.csv")

### Rearrange the year csv's to produce detection / date / hour wide format csvs
