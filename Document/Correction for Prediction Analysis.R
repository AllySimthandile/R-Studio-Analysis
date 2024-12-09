# Load the training and test data
library(readr)
adult.training <- read_csv("C:/Users/Student/Desktop/My Project/adult.data.csv" , col_names = FALSE)
View(adult.training)
adult.test <-  read_csv("C:/Users/Student/Desktop/My Project/adult.test.csv", col_names = FALSE)
View(adult.test)

# Clean column names
colnames(adult.test) <- trimws(colnames(adult.test))

# Check the cleaned column names
names(adult.test)
# Check the number of columns in the loaded datasets
print(dim(adult.training))  # Should return (32561, 15)
print(dim(adult.test))      # Should return (16281, 15)

# Assign column names (based on UCI dataset specification)
colnames(adult.training) <- c('age', 'workclass', 'fnlwgt', 'education', 'educationnum', 'maritalstatus', 
                              'occupation', 'relationship', 'race', 'sex', 'capitalgain', 'capitalloss', 
                              'hoursperweek', 'nativecountry', 'class')

colnames(adult.test) <- colnames(adult.training)  # Apply the same column names to the test data

# Create the binary response variable y for the training data
N.obs <- dim(adult.training)[1]
y <- rep(0, N.obs)
y[adult.training$class == '>50K'] <- 1  # Class >50K is encoded as 1, <=50K as 0
# Get a summary of the training dataset
summary(adult.training)

# Get the column names of the dataset
names(adult.training)

# View the first few rows of the dataset
head(adult.training)

# Convert categorical variables to factors if necessary
adult.training$workclass <- factor(adult.training$workclass)
adult.training$maritalstatus <- factor(adult.training$maritalstatus)
adult.training$occupation <- factor(adult.training$occupation)
adult.training$relationship <- factor(adult.training$relationship)
adult.training$race <- factor(adult.training$race)
adult.training$sex <- factor(adult.training$sex)
# Fit a logistic regression model
adultdatamodel <- glm(y ~ age + educationnum + hoursperweek + workclass + maritalstatus + 
                        occupation + relationship + race + sex, 
                      family = binomial("logit"), data = adult.training)
# Get model coefficients
resultstable <- summary(adultdatamodel)$coefficients

# Sort the coefficients by p-value (4th column)
sorter <- order(resultstable[, 4])
resultstable <- resultstable[sorter, ]
# Make predictions on the test data
pred <- predict(adultdatamodel, adult.test, type = "response")
N.test <- length(pred)

if (!is.factor(adult.test$class)) {
  adult.test$class <- factor(adult.test$class)
}

# Convert probabilities to binary predictions (0 or 1) with a threshold of 0.5
y.hat <- rep(0, N.test)
y.hat[pred >= 0.5] <- 1

# Get the true outcome for the test data
outcome <- levels(adult.test$class)
print(outcome)
N.test <- nrow(adult.test)  # Number of rows in the test dataset
y.test <- rep(0, N.test)
y.test[adult.test$class == outcome[2]] <- 1  # True labels in test data
head(y.test)
# Create the confusion table
confusion.table <- table(y.hat, y.test)

# Rename rows and columns for clarity
colnames(confusion.table) <- c(paste("Actual", outcome[1]), outcome[2])
rownames(confusion.table) <- c(paste("Predicted", outcome[1]), outcome[2])

# Print the confusion matrix
print(confusion.table)
write.csv(confusion.table, "C:/Users/Student/Desktop/My Project/confusion_matrix.csv")
