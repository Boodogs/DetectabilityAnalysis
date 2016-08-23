require(unmarked)

y <- detectiondf[,2:1101]
covariates <- data.frame(station = detectiondf[,1]) 
columns <- colnames(hoursdf[,2:length(hoursdf)])
observer <- list(hours = hoursdf[,columns], days = juliandatedf[,columns])

umf <- unmarkedFrameOccu(y = y, siteCovs = covariates, obsCovs = observer)
summary(umf)

fm1 <- occu(~1 ~1, umf)
summary(fm1)


fm2 <- occu(~hours + days ~1, umf)
summary(fm2)

fms <- fitList(m1 = fm2)

exp(-0.0964*hours + -0.0176*days + 2.0595)/(1 + exp(-0.0964*hours + -0.0176*days + 2.0595))
