data(iris)

iris <- iris[, c("Sepal.Length","Sepal.Width", "Petal.Length", "Petal.Width", "Species")]
install.packages("Rserve")
library(Rserve)
Rserve()
write.csv(iris,"irisClustering3.csv",row.names = FALSE, fileEncoding = "UTF-8")