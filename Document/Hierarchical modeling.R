data(iris)
# Select 40 random rows
IrisSample <- sample(1:dim(iris)[1], 40)

# Remove the Species column
IrisSample <- iris[IrisSample, ]
IrisSample$Species <- NULL
#Perform hierarchical clustering
dim(IrisSample)
hc <- hclust(dist(IrisSample), method="ave")
hc
# Convert to character vector
species <- as.character(iris$Species)
head(species)

plot(hc, hang = -1, labels=iris$species[IrisSample])