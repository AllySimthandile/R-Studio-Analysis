#Modeling in R
#Firstly, we need to call the libraries that we need:

library(rpart)
library(rpart.plot)
library(caret)
library(e1071)
library(arules)
#Next, let's load in the data, which will be in the AdultUCI variable:

library(readr)
train_data <- read_csv("C:/Users/Student/Desktop/My Project/adult.data.csv" , col_names = FALSE)
View(train_data)
# Assign column names (based on UCI dataset specification)
colnames(train_data) <- c('age', 'workclass', 'fnlwgt', 'education', 'education.num', 'marital.status', 
                              'occupation', 'relationship', 'race', 'sex', 'capital.gain', 'capital.loss', 
                              'hours.per.week', 'nativecountry', 'income')

nrow(train_data)
## 75% of the sample size
sample_size <- floor(0.80 * nrow(train_data))
## set the seed to make your partition reproductible
set.seed(123)
## Set a variable to have the sample size
training.indicator <- sample(seq_len(nrow(train_data)), size =
                               sample_size)

# Set up the training and test sets of data
adult.training <- train_data[training.indicator, ]
adult.test <- train_data[-training.indicator, ]
# Convert categorical variables to factors if necessary
adult.training$workclass <- factor(adult.training$workclass)
adult.training$marital.status <- factor(adult.training$marital.status)
adult.training$occupation <- factor(adult.training$occupation)
adult.training$relationship <- factor(adult.training$relationship)
adult.training$race <- factor(adult.training$race)
adult.training$sex <- factor(adult.training$sex)

## set up the most important features
features <- train_data$income ~
  train_data$age+train_data$education+train_data$"education.num"
newdata<-adult.test
newdata <- na.omit(newdata)
# Let's use the training data to test the model
model<-rpart(features,data=adult.training) #Recursive Partitioning and Regression Trees.
       # This should show 5210 rows, assuming this is the data for prediction
# Now, let's use the test data to predict the model's efficiency
pred<-predict(model, newdata ,type="class")
# Let's print the model
print(model)
train_data$pred<-model$fitted.values
# Results
#1) root 32561 7841 small (0.7591904 0.2408096)
#2) AdultUCI$"education-num"< 12.5 24494 3932 small (0.8394709
#0.1605291) *
  # 3) AdultUCI$"education-num">=12.5 8067 3909 small (0.5154332
  #0.4845668)
#6) AdultUCI$age< 29.5 1617 232 small (0.8565244 0.1434756) *
# 7) AdultUCI$age>=29.5 6450 2773 large (0.4299225 0.5700775) *
printcp(model)
plotcp(model)
summary(model)
print(pred)
summary(pred)
# plot tree
plot(model, uniform=TRUE,
     main="Decision Tree for Adult data")
text(model, use.n=TRUE, all=TRUE, cex=.8)
prp(model, faclen = 0, cex = 0.5, extra = 1)
# Save the decision tree plot as an image
png("C:/Users/Student/Desktop/My Project/decision_tree_plot.png", width = 800, height = 600)
rpart.plot(model, main = "Decision Tree for Adult Data")
dev.off()
install.packages("Rserve")
library(Rserve)
Rserve()

save(train_data,file="modeling.rdata")
# Save the model for later use in Tableau
saveRDS(model, "adult_income_model.rds")
