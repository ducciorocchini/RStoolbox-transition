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

# Classification

# data import
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

plotRGB(so, 1, 2, 3, stretch="lin")
plotRGB(so, 1, 2, 3, stretch="hist")

# Classifying the solar data

# https://rspatial.org/raster/rs/4-unsupclassification.html

# 1. Get all the single values
singlenr <- getValues(so)
singlenr
#
# set.seed(99)

# 2. Classify
kcluster <- kmeans(singlenr, centers = 3)
kcluster

# 3. Set values to a raster on the basis of so
soclass <- setValues(so[[1]], kcluster$cluster) # assign new values to a raster object

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soclass, col=cl)

# set.seed can be used for repeating the experiment in the same manner for N times
# http://rfunction.com/archives/62

####

# day 2 Grand Canyon

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc

# rosso = 1
# verde = 2
# blu = 3

plotRGB(gc, r=1, g=2, b=3, stretch="lin")

# change the stretch to histogram stretching
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# classification

# 1. Get values
singlenr <- getValues(gc)
singlenr

# 2. Classify
kcluster <- kmeans(singlenr, centers = 3)
kcluster

# 3. Set values
gcclass <- setValues(gc[[1]], kcluster$cluster) # assign new values to a raster object

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(gcclass, col=cl)

frequencies <- freq(gcclass)

# Exercise: classify the map with 4 classes






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
