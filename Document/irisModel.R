library(neuralnet)
install.packages("Rserve")
library(Rserve)
Rserve()
# Load the iris dataset
data(iris)

# We will train a neural network to predict Petal.Length based on other features
nn <- neuralnet(Petal.Length ~ Sepal.Length + Sepal.Width + Petal.Width, data = iris, hidden = c(3), linear.output = TRUE)

# Save the trained neural network model
save(nn, file = "iris_nn_model.RData")
# Load the trained model
load("D:/My Documents/Document/iris_nn_model.RData")
print(nn)