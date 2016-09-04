require(unmarked)

detection2013 <- read.csv("~/DetectabilityAnalysis/detection2013.csv")
hours2013 <- read.csv("~/DetectabilityAnalysis/hours2013.csv")
julian2013 <- read.csv("~/DetectabilityAnalysis/julian2013.csv")

detection2014 <- read.csv("~/DetectabilityAnalysis/detection2014.csv")
hours2014 <- read.csv("~/DetectabilityAnalysis/hours2014.csv")
julian2014 <- read.csv("~/DetectabilityAnalysis/julian2014.csv")

detection2015 <- read.csv("~/DetectabilityAnalysis/detection2015.csv")
hours2015 <- read.csv("~/DetectabilityAnalysis/hours2015.csv")
julian2015 <- read.csv("~/DetectabilityAnalysis/julian2015.csv")


y2013 <- detection2013[,2:1102]
covariates2013 <- data.frame(station = detection2013[,1]) 
columns2013 <- colnames(hours2013[,2:length(hours2013)])
observer2013 <- list(hours = hours2013[,columns2013], days = julian2013[,columns2013])

umf2013 <- unmarkedFrameOccu(y = y2013, siteCovs = covariates2013, obsCovs = observer2013)
summary(umf2013)

intercept2013 <- occu(~1 ~1, umf2013)
summary(intercept2013)

det2013 <- backTransform(intercept2013, "det")

det2013

psi2013 <- backTransform(intercept2013, "state")

psi2013

y2014 <- detection2014[,2:792]
covariates2014 <- data.frame(station = detection2014[,1]) 
columns2014 <- colnames(hours2014[,2:length(hours2014)])
observer2014 <- list(hours = hours2014[,columns2014], days = julian2014[,columns2014])

umf2014 <- unmarkedFrameOccu(y = y2014, siteCovs = covariates2014, obsCovs = observer2014)
summary(umf2014)

intercept2014 <- occu(~1 ~1, umf2014)
summary(intercept2014)

det2014 <- backTransform(intercept2014, "det")

det2014

psi2014 <- backTransform(intercept2014, "state")

psi2014

y2015 <- detection2015[,2:784]
covariates2015 <- data.frame(station = detection2015[,1]) 
columns2015 <- colnames(hours2015[,2:length(hours2015)])
observer2015 <- list(hours = hours2015[,columns2015], days = julian2015[,columns2015])

umf2015 <- unmarkedFrameOccu(y = y2015, siteCovs = covariates2015, obsCovs = observer2015)
summary(umf2015)

intercept2015 <- occu(~1 ~1, umf2015)
summary(intercept2015)

det2015 <- backTransform(intercept2015, "det")

det2015

psi2015 <- backTransform(intercept2015, "state")

psi2015


newdata2 <- data.frame(hours = factor(c(0:24)), days = 0)
test <- predict(intercept2013, newdata = newdata2, type = "det")


fm2 <- occu(~hours + I(hours^2) + I(hours^3) + I(hours^4) + I(days^2) ~1, umf)
summary(fm2)

lc <- linearComb(fm2, c(1,0,0,0,0,22500), type = "det")

p_det <- backTransform(lc)
p_det

fms <- fitList(m1 = fm2)


p <- predict(fms, type= "det", newdata = newdata2, appendData = TRUE)

exp(-0.0964*hours + -0.0176*days + 2.0595)/(1 + exp(-0.0964*hours + -0.0176*days + 2.0595))
