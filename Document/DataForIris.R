data(iris)
iris <- iris[, c("Sepal.Length","Sepal.Width", "Petal.Length", "Petal.Width", "Species")]
# Extract only the numerical features (ignoring the species)
#iris_data <- iris[, 1:4]

# Calculate the Total Sum of Squares (TSS) for each feature
#tss <- apply(iris_data, 2, function(x) sum((x - mean(x))^2))

# Print the TSS for each feature
#print(tss)

# Optionally, calculate the overall TSS (sum of TSS for all features)
##total_tss <- sum(tss)
#print(total_tss
# Extract the petal length column
petal_length <- iris$Petal.Length

# Calculate the mean of petal length
mean_petal_length <- mean(petal_length)

# Calculate the Total Sum of Squares (TSS) for petal length
iris$tss_petal_length <- sum((petal_length - mean_petal_length)^2)

# Print the result

# Select only the numerical features (excluding the species column)
iris_data <- iris[, 1:4]

# Apply K-means clustering with 3 clusters (since we know there are 3 species in the Iris dataset)
set.seed(123)  # For reproducibility
kmeans_result <- kmeans(iris_data, centers = 3)

# Print the clustering result
print(kmeans_result)

# Add the cluster assignments to the original dataset
iris$Cluster <- as.numeric(kmeans_result$cluster)
iris

write.csv(iris,"irisData3.csv",row.names = FALSE, fileEncoding = "UTF-8")