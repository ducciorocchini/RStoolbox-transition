# Original code from: 
# https://rspatial.org/raster/rs/3-basicmath.html#principal-component-analysis

###### RStoolbox transition

# gplot

library(raster)
library(ggplot2)
library(viridis)
library(patchwork)

test <- brick("~/Documents/lectures_and_seminars/images/andrew6.png")

testd <- as.data.frame(test, xy=T)
ggplot() + geom_raster(testd, mapping = aes(x=x, y=y, fill=andrew6_2)) + scale_fill_viridis(option='viridis')


# PCA
# random sample
set.seed(1)
sr <- sampleRandom(test, 10000)
# plot(sr[,c(4,5)], main = "NIR-Red plot")

pca <- prcomp(sr)

# variance explained
summary(pca)

# correlation with original bands
pca

# pc map
pci <- predict(test, pca, index = 1:2)
plot(pci[[1]])

testdp <- as.data.frame(pci[[1]], xy=T)
ggplot() + geom_raster(testdp, mapping = aes(x = x, y = y, fill = PC1)) + scale_fill_viridis()

p1 <- ggplot() + geom_raster(testdp, mapping = aes(x = x, y = y, fill = PC1)) + scale_fill_viridis(option="magma")

testdp2 <- as.data.frame(pci[[2]], xy=T)
p2 <- ggplot() + geom_raster(testdp2, mapping = aes(x = x, y = y, fill = PC2)) + scale_fill_viridis(option="magma")

p1 + p2 

#Classification
library(raster)

# https://rspatial.org/raster/rs/4-unsupclassification.html

# convert to matrix
nr <- getValues(test)
nr

set.seed(99)
# kmncluster <- kmeans(na.omit(nr), centers = 3, iter.max = 500, nstart = 5, algorithm="Lloyd")

kmncluster <- kmeans(na.omit(nr), centers = 3)
kmncluster
str(kmncluster) # to see where the clusters are created

# Use the ndvi object to set the cluster values to a new raster
knr <- setValues(test, kmncluster$cluster) # assign new values to a raster object
# You can also do it like this
knr <- raster(test)
values(knr) <- kmncluster$cluster
knr

plot(knr)


##### Interesting functions of terra
# autocorrelation
# barplot
# boxplot -> basta fare boxplot dell immagine
# cartogram
# click -> restituisce valori
# focal
# gdal
# graticule
# plot
# plotRGB
# plot_graticule
# rast
# RGB
# zonal

# Nice analyses here:
https://rspatial.org/raster/rs/3-basicmath.html#principal-component-analysis
