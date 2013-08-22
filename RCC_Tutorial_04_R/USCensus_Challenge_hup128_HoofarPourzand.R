#Hoofar_Ben_Pourzand_hup128_US Mail Return Challenge_Kaggle2012


setwd("/home/hoofar/Documents/Census")
 
###########################################################################################
##Loading the Data
###########################################################################################

train <- read.csv("agg_impute_train.csv")
test <- read.csv("agg_impute_test.csv")
names(train)
###########################################################################################
## DATA Preparation
###########################################################################################


zeros = data.frame(Mail_Return_Rate_CEN_2010 = rep(0, nrow(test)))
means = data.frame(Mail_Return_Rate_CEN_2010 = rep(mean(train$Mail_Return_Rate_CEN_2010), nrow(test)))
medians = data.frame(Mail_Return_Rate_CEN_2010 = rep(median(train$Mail_Return_Rate_CEN_2010), nrow(test)))


str(train)
summary(train)


library(MASS)
library(randomForest)
set.seed(2012)
indices =cbind(x =c(2, 6 ,10:35 ))  #= c(1, 2 ,3 ) 35 instead of 40 for default rf v. to run
#choose some columns to use:
indices_to_use = apply(indices, 1, function(i) sum(is.na(train[,i])) == 0 & sum(is.na(test[,i])) == 0 & class(train[,i]) == "integer")
which(indices_to_use)
#read the Readme file for this part
indices_to_use = c( 2,   6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16 ,17 ,18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30) #,1, 33, 34,35,172,163, 168,169)

rf = randomForest(train[,(indices_to_use)], y=train$Mail_Return_Rate_CEN_2010, ntree=800, importance=TRUE,do.trace=T)
rf_preds = predict(rf, train[,indices_to_use])
#end of the hack
print(rf)
rf$confusion
importance(rf, type=2)
varImpPlot(rf)
#for validation data (t's testing in fact )

rf.test = randomForest(test[,(indices_to_use)], y=test$Mail_Return_Rate_CEN_2010, ntree=800, do.trace=T, importance=TRUE
rf_preds.test = predict(rf, test[,indices_to_use])
print(rf.test)
rf.test$confusion
importance(rf.test, type=2)
varImpPlot(rf.test)
 



#write.csv(zeros, file = "./submissions/zeros.csv", row.names = FALSE)
#write.csv(means, file = "./submissions/means.csv", row.names = FALSE)
#write.csv(medians, file = "./submissions/medians.csv", row.names = FALSE)
write.csv(rf_preds, file = "./submissions/rf.csv", row.names = FALSE)

