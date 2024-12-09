install.packages("Rserve")
library(Rserve)
Rserve()

# Load required libraries
install.packages("caret")
install.packages("rpart")
library(rpart)
library(caret)

# Load the iris dataset
data(iris)

# Train a Decision Tree model
model <- train(Species ~ ., data = iris, method = "rpart")

# Make predictions on the dataset
predictions <- predict(model, iris)

# Return predictions
predictions