##### Set up database connection

require(RODBC)
con <- odbcConnect("Recognizer", uid = "loganm", pwd = "raildude")
# sqlTables(con)

##### Connect to the appropriate tables from the Recognizer Database. For now we need the recognizer outputs and the full list of files.

recog <- sqlFetch(con, "tbl Revised Recognizer Output")
allfiles <- sqlFetch(con, "tbl Revised ALLFILES")

##### GET JULIAN DATE FROM FILENAME

#I had to go into access and do find/replace to get rid of $'s from gps unit recordings.
#Another problem was with recordings including _0+1_. I had to replace the '_0+1_' with '_'.

require(lubridate)

splitname <- strsplit(as.character(recog$ShortName), '_')
# write.csv(splitname, file = splitname.csv)
parsedname <- matrix(unlist(splitname), ncol = 3, byrow = TRUE)

my_year <- substr(parsedname[,2], 1, 4)
my_month <- substr(parsedname[,2], 5, 6)
my_day <- substr(parsedname[,2], 7,8)

my_date <- paste(my_year, my_month, my_day, sep ="-")

all_splitname <- strsplit(as.character(allfiles$ShortName), '_')
# write.csv(all_splitname, file = all_splitname.csv)
all_parsedname <- matrix(unlist(all_splitname), ncol = 3, byrow = TRUE)

all_my_year <- substr(all_parsedname[,2], 1, 4)
all_my_month <- substr(all_parsedname[,2], 5, 6)
all_my_day <- substr(all_parsedname[,2], 7,8)

all_my_date <- paste(all_my_year, all_my_month, all_my_day, sep ="-")

allfiles$JulianDate <- yday(as.Date(all_my_date))
recog$JulianDate <- yday(as.Date(my_date))

##### MAKE A NICE DATAFRAME

recog$SiteStnName <- parsedname[,1]
recog$sYEAR <- substr(parsedname[,2], 1,4)

df <- data.frame(allfiles$SiteStnName, allfiles$sYEAR, allfiles$JulianDate, allfiles$HOURofDAY)
df2 <- data.frame(recog$SiteStnName, recog$sYEAR, recog$JulianDate, recog$HOURofDAY)

df$Detection <- 0
df2$Detection <- 1

names(df) <- c("SiteStnName", "sYEAR", "JulianDate", "HOURofDAY")
names(df2) <- c("SiteStnName", "sYEAR", "JulianDate", "HOURofDAY")


fulldf <-rbind(df, df2)