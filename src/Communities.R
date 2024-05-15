library(vegan)
library(ggplot2)
library(ggdendro)
library(dendextend)

# load Harriman data
harriman <- read.csv("data/Harriman_species.csv", row.names=1)
har.env <- read.csv("data/Harriman_env.csv", row.names=1)

# replace NAs with 0s
harriman[is.na(harriman)] <- 0
# transpose next so that species are in columns
harriman <- t(harriman)

# basic diversity metrics
diversity(harriman, index = "simpson")
diversity(harriman, index = "shannon")
specnumber(harriman)

#find the the Bray-Curtis dissimilarities This creates the dissimilarity matrix. The rows must be the samples (the sites). Type vegdist(data, method="bray"). Assign the results of the Bray-Curtis dissimilarity to an object.
bray <- vegdist(harriman, method = "bray")
#create a dendrogram from the Bray-Curtis dissimilarity values
#create the hierarchical cluster object, which will be the basis of the dendrogram.Type hclust(objectwithBray-Curtisdissimilaritydata) and assign it to an object.
bray_hc <- hclust(bray) 
#create the dendrogram with plot(hierarchicalclusterobject)
plot(bray_hc)
bray_hc

#color labeling attempt with the dendextend package
dend <- as.dendrogram(bray_hc)
colorCodes <- c(Artificial="#FC4E07", Natural="#00AFBB")
#values = c("#00AFBB", "#E7B800", "#FC4E07")

# Assigning the labels of dendrogram object with new colors:
labels_colors(dend) <- colorCodes[har.env$Origin][order.dendrogram(dend)]
# Plotting the new dendrogram
plot(dend, horiz=TRUE, main="Plant and algal community similarity")

#fixing cut-off labels with par by adjusting the plot margins 
# mar=c(bottom, left, top, right). (Defaults are c(5, 4, 4, 2) + 0.1).

par(mar=c(5, 4, 4, 10) + 0.1)
plot(dend, horiz=TRUE, main="Plant and algal community similarity")


### ordination
pcoa <- capscale (log1p (harriman) ~ 1, distance = 'bray', sqrt.dist = TRUE, scaling = 1)
plot (pcoa, main = 'PCoA (MDS)', type = 'n')
points (pcoa, display = 'si', pch = har.env$Origin)

