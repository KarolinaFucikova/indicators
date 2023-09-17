library(indicspecies)
# tutorial: 
# https://cran.r-project.org/web/packages/indicspecies/vignettes/IndicatorSpeciesAnalysis.html
#example dataset:
data(wetland)

# species are in columns
#otherwise:
#wetland <- read.csv("data/INSERTNAME.csv", row.names = 1)

# sites need to be classified by the user, should be done independently of species composition
# classifications should come in a vector, e.g.:
groups = c(rep(1, 17), rep(2, 14), rep(3,10))
groups
# this example is completely arbitrary, just to show how the vector can be made
# or, nonhierarchical clustering into three categories (not user-generated):
wetkm = kmeans(wetland, centers=3)
groupskm = wetkm$cluster
groupskm

# indicator analysis - will determine indicator values for each species
# i.e., how strongly the species is associated with a particular group/category
indval = multipatt(wetland, groups, 
                   control = how(nperm=999)) 
summary(indval) 

#################
# Harriman data
harriman <- read.csv("data/Harriman_species.csv", row.names=1)

# replace NAs with 0s
harriman[is.na(harriman)] <- 0
# transpose next so that species are in columns
harriman <- t(harriman)

# could try grouping into natural vs. artificial lakes

# or nonhierarchical clustering
harkm = kmeans(harriman, centers=3)
groupskm = harkm$cluster
groupskm
# indicator analysis - will determine indicator values for each species
# i.e., how strongly the species is associated with a particular group/category
indval = multipatt(harriman, groupskm, 
                   control = how(nperm=999)) 
summary(indval) 

