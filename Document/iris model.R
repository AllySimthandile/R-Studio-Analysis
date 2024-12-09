install.packages("neuralnet")
library(neuralnet)
install.packages("Rserve")
library(Rserve)
Rserve()
# Load the iris dataset
data(iris)

# Train a neural network model to predict Petal.Length based on other features
nn <- neuralnet(Petal.Length ~ Sepal.Length + Sepal.Width + Petal.Width, data = iris, hidden = c(3), linear.output = TRUE)

# Save the trained model as an RDS file
saveRDS(nn, "D:/My Documents/Document/iris_model.rds")
