# Packages
install.packages(c('tidyverse','vtable'))
# One at a time!
library(tidyverse)

# Getting data
# From packages
data(storms, package = 'dplyr')
# From files
# d <- read_csv('exampledata.csv')

# R objects
a <- 1
b <- 'hello'

# Vectors
a <- 11:20
a[1]
b <- c(1, 1, 4, 4, 2, 3, 6)

# Logicals
b == 1
sum(b == 1)
mean(b == 1)
(b == 1) | (b == 4)
(b >= 1) & (b < 4)

# Variable types
as.character(a)
factor(b)
b

# Data frames / tibbles
storms
summary(storms)
str(storms)
names(storms)
vtable::vt(storms)
library(vtable)
sumtable(storms)
storms$category
table(storms$category)
storms[['category']]
table(storms[['category']])


# Functions
mean(b)
table(b)
mean(b, na.rm = TRUE)
sumtable(storms, vars = names(storms)[5:8])

# Autocomplete
# data(
# mea

# Help
help(mean)
??mean
# help pane

# Rstudio notes
# Working directory
# Environment pane and broom
# Viewer and file pane, and export

# Swirl
# install.packages('swirl')
swirl()
# Note the base package 4 on EDA! also 1 on basic programming
# See https://github.com/swirldev/swirl_courses for more

# Troubleshooting
mean(c('a','b'))
sumtable(mean)
feols(Y~X)
