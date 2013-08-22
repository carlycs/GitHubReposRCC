An error messege while running r script on linux ubuntu,  version:R .173 The randomForest Version 4.6-7 was built under R version 2.15.2
> rf = randomForest(train[,which(indices_to_use)], y=train$Mail_Return_Rate_CEN_2010, ntree=800, do.trace=T, sampsize=7000)
Error in randomForest.default(train[, which(indices_to_use)], y = train$Mail_Return_Rate_CEN_2010,  : 
  Can not handle categorical predictors with more than 32 categories.
Here are those two variable names:
> which(sapply(train, function(y) nlevels(y) > 32)) 
 State_name County_name 
          3           5 
removing the variable 3 and 5 from the list, solved the prolem. still with he added five variables 172, 155,33 and 32 wR crashes for the size of the vector:
rf = randomForest(train[,(indices_to_use)], y=train$Mail_Return_Rate_CEN_2010, ntree=800, importance=TRUE,classwt=c(5,1,1),do.trace=T)
Error: cannot allocate vector of size 1.5 Gb
