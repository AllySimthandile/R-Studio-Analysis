#Neural network in R
#install the neauralnet package
install.packages("neuralnet")
#load it into your R environment using the library function:

library(neuralnet)
data(iris)
#check the data , if it is loaded by using head function
head(iris)
#Let's look and see how many rows and columns we have for the wine dataset. This
#will help later, when we look at how many rows we want in the training and the test
#set:
dim(iris)
#we then plot
plot(iris)
#This visualization is quite difficult to read. Let's move forward with the issue of
#adding more contexts to the data. The following code creates a new column for each
#of the iris types, and populates the corresponding column with TRUE if the iris is
#of the given type. So, for example, if the iris type is setosa, then the code returns
#TRUE in the setosa column:

iris$setosa <- c(iris$Species == 'setosa')
iris$versicolor <- c(iris$Species == 'versicolor')
iris$virginica <- c(iris$Species == 'virginica')
head(iris)     
#We could normalize the data before we use it for the neural net. In theory, we don't
#always need to standardize the inputs to the neural net. The reason for this is that any
#rescaling of an input could be undone, or redone by any amendment of the
#corresponding weights and biases. In practice, however, standardizing inputs can
#make R faster. Therefore, normalizing is one technique that you could consider,
#particularly when we are handling a lot of data.
#Let's start producing Train and Test datasets. We can use the following formula to
#count the number of rows. Then, we can create an index, which will be used to
#assign data to either the test or training sets.
#Now, we will train the data using set.seed, which allows us to reproduce a
#particular sequence of random numbers. The seed itself carries no inherent meaning;
#it's simply a way of telling the random number generator where to start. Here, we are
#going to set the seed to make the partition reproducible

set.seed(123)

#Next, we will work out the training and test set. Firstly, we calculate the total number
#of rows and then we sample the data so that 75 percent of the data is training, and the
#remainder is test data:
totalrows <- nrow(iris)
totalrows
samplesize <- floor(0.75 * nrow(iris))
iris.indicator <- sample(seq_len(nrow(iris)), size =
                               samplesize)

#The samples are indexed separately, using the marker iris_ind. Data with the
#marker iris_ind goes to the training dataset, and rest of the data goes to the test
#dataset.
#We can assign the data to the training swt or the test set
train <- iris[iris.indicator, ]
test <- iris[-iris.indicator, ]
#Now, we will call the neuralnet function to create a neural network. We are training
#the data, so we are going to use the training set of data. As a starting point, we are
#going to work with three hidden layers. The neural network is going to be assigned
#to the variable nn:
names(iris)
nn <- neuralnet(setosa + versicolor + virginica ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
                data = train, hidden = c(3), linear.output = FALSE)

plot(nn)

#Now we've created the model, let's try to use it with the test data. To do this, we use
#the predict command, specifying the first four columns:

predict <- predict(nn, test[1:4])
predict <- max.col(predict) - 1  # Convert to species labels
# Ensure predicted_species is of the correct length
predicted_species <- rep(predict, length.out = nrow(iris))
# Assign it to the dataframe
iris$predicted_species <- predicted_species
write.csv(iris, "iris_with_predictions.csv", row.names = FALSE)
#Now, let's test use this model to predict our results with the test data. In the
#neuralnet package, this method is used to predict objects of class nn, typically
#produced by neuralnet.

#Firstly, the dataframe is changed by a mean response value, and the data error is
#worked out between the original response and the new mean response. Then, all
#duplicate rows are removed to clarify the data.

#Eventually, we get our predictions, and we can start to visualize the predicted results
#of the neural network using Tableau.
