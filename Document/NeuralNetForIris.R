data(iris)
iris <- iris[, c("Sepal.Length","Sepal.Width", "Petal.Length", "Petal.Width", "Species")]
#Perform K-means clustering (with 3 clusters, as Iris dataset has 3 species)
set.seed(123)  # Set seed for reproducibility
kmeans_result <- kmeans(iris[, 1:4], centers = 3)

# Add the cluster assignment to the Iris dataset
iris$Cluster <- as.factor(kmeans_result$cluster)

# View the cluster centers
kmeans_result$centers

# Extract the cluster centers for Petal Width
iris$petal_width_centers <- kmeans_result$centers[, "Petal.Width"]
print(petal_width_centers)

# Extract the cluster centers for Petal Length
iris$petal_length_centers <- kmeans_result$centers[, "Petal.Length"]
print(petal_length_centers)
install.packages("Rserve")
library(Rserve)
Rserve()
write.csv(iris,"irisClustering2.csv",row.names = FALSE, fileEncoding = "UTF-8")