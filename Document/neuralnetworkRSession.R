install.packages("Rserve")
library(Rserve)
Rserve()
install.packages("neuralnet")
library(neuralnet)

# Using the Iris dataset as an example
data(iris)

# Train a neural network model
nn <- neuralnet(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, 
                data = iris, 
                hidden = c(5, 3),  # Example of a hidden layer structure (5 neurons in the first layer, 3 in the second)
                linear.output = FALSE)  # Set to FALSE for classification

# Save or export the model if needed, or use it directly in the R script