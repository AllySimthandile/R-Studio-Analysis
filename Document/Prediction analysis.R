library(readr)
adult_data <- read_csv("C:/Users/Student/Desktop/My Project/adult.data.csv" ,col_names = FALSE)
View(adult_data)

colnames(adult_data) <- c("age", "workclass", "fnlwgt", "education", "education.num", 
                          "marital.status", "occupation", "relationship", "race", "sex", 
                          "capital.gain", "capital.loss", "hours.per.week", "native.country", "income")

# Set a seed for reproducibility
set.seed(123)

# Sample 80% of the data for training, and the remaining 20% for testing
train_indices <- sample(1:nrow(adult_data), size = 0.8 * nrow(adult_data))
# Create the training and test sets
train_data <- adult_data[train_indices, ]
test_data <- adult_data[-train_indices, ]
# Save the data
write.csv(train_data, "train_data.csv", row.names = FALSE)
write.csv(test_data, "test_data.csv", row.names = FALSE)

# Length of the training data (number of rows)
length(train_data)  # This returns the number of rows in the training data
#Length of the test data (number of rows)
length(test_data)  # This returns the number of rows in the test data
# Number of rows in the training set
nrow(train_data)

# Number of rows in the test set
nrow(test_data)


# Get the number of observations in the training set
N.obs <- dim(train_data)[1]

# Create a binary response variable y
y <- rep(0, N.obs)
y[train_data$income== ">50K"] <- 1
#Or use the following method
#y[class==levels(class)[2]]<-1
# Get a summary of the training data
summary(train_data)
# Get column names
names(train_data)
# View the first few rows of the training data
head(train_data)

#Now, you will use the glm function to create a logistic regression model using the selected independent variables. Ensure that the independent variables are selected correctly based on the dataset structure.

# Fit the GLM model
adultdatamodel <- glm(y ~ age + education.num + hours.per.week +
                        workclass + marital.status + occupation + relationship + race + sex,
                      family=binomial("logit"), data = train_data)
#adultdatamodel <- glm(y ~ X1 + X2 + X6 + X5 + X7 + X8 + X9 + X10 + X13, 
#family = binomial("logit"), 
#data = adult.training)
# Get the summary of the model
resultstable <- summary(adultdatamodel)$coefficients
# Sort the coefficients by their p-values
sorter <- order(resultstable[, 4])
resultstable <- resultstable[sorter,]

# View the sorted results
print(resultstable)


#Now, use the predict() function to make predictions on the test dataset. The predictions will be probabilities, so you will threshold them at 0.5 to get the binary outcomes.


# Make predictions on the test data
pred <- predict(adultdatamodel, test_data, type = "response")
N.test <- length(pred)

# Convert probabilities to binary outcomes
y.hat <- rep(0, N.test)
y.hat[pred >= 0.5] <- 1
#Extract the true outcomes from the test data and convert them into binary form as well.
# Get the true outcomes from the test data
outcome <- levels(test_data$income)  # Adjust the column index if needed
y.test <- rep(0, N.test)
y.test[test_data$income == outcome[2]] <- 1
#Use the table() function to create a confusion matrix to compare predicted vs actual outcomes.
# Create the confusion table
confusion.table <- table(y.hat, y.test)
colnames(confusion.table) <- c(paste("Actual", outcome[1]), outcome[2])
if (length(outcome) == 0) {
  # Dynamically create outcome from confusion.table columns (if available)
  outcome <- colnames(confusion.table)
}
rownames(confusion.table) <- c(paste("Predicted", outcome[1]), outcome[2])

# Print the confusion table
print(confusion.table)