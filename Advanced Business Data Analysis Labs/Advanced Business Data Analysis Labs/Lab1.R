
# Set working Directory
#
#Eugene's default R folder in NCI: D:\Google Drive\Documents\2015-2016 Lecture Notes\HDSDA-BSHTM4 - Advanced Business Data Analysis
#
#setwd(file.path("D:", "Google Drive", "Documents", "2015-2016 Lecture Notes", "HDSDA-BSHTM4 - Advanced Business Data Analysis", "R")) 

setwd(file.path("C:", "DATASCIENCE", "Advanced Business Data Analysis Labs", "Advanced Business Data Analysis Labs"))
#
# Code to execute this script: source("BasicStatsTests.R", echo=TRUE) # path must be set above
#
# Use R for simple descriptive statistics
#
# Check for what packages are loaded
search()
#
install.packages("stats")
install.packages("ggplot2")
install.packages("rms") #replaces "design" package which has been removed from CRAN
install.packages("moments")
#
library(stats)
library(ggplot2)
library(rms)
library(moments) # contains skewness and Kurtosis functions (not included in R)
#
# Iris Dataset from R Library (datasets package - included with R)
#
library(datasets) # import datasets
data(iris)
#
# display Sepal.Length data
#
iris$Sepal.Length
#
##############################################################################################################
#                                  Descriptives for Iris Sepal Length variable
##############################################################################################################
#
mean(iris$Sepal.Length) # Mean
median(iris$Sepal.Length) # Median
max(iris$Sepal.Length) # Maximum
min(iris$Sepal.Length) # Minimum
range(iris$Sepal.Length) # Range
diff(range(iris$Sepal.Length)) # Difference
var(iris$Sepal.Length) # Variance
sd(iris$Sepal.Length) # Standard deviation
kurtosis(iris$Sepal.Length) # Kurtosis
skewness(iris$Sepal.Length) # Skewness
summary(iris$Sepal.Length) # Quartiles
summary(iris) # Spread of data
#
# Draw some charts
#
boxplot(iris$Sepal.Length)
boxplot(iris$Sepal.Length, horizontal = TRUE)
boxplot.stats(iris$Sepal.Length)
boxplot(iris[1:4])
hist(iris$Sepal.Length) #Histogram
hist(iris$Sepal.Length, main = "Histogram of Sepal Length", xlab = "Sepal length") #add custom labels
#
# some scatter plots
#
plot(iris$Petal.Length, iris$Petal.Width, pch = 21, bg = c("red", "green3", "blue")[unclass(iris$Species)], main = "Edgar Anderson's Iris Data")
pairs(iris[1:4], main = "Edgar Anderson's Iris Data", pch = 22, bg = c("red", "green3", "blue")[unclass(iris$Species)])
#
#
##############################################################################################################
#                                           t Test - Independent/Unpaired
##############################################################################################################
#
# Iris data
#
t.test(iris$Sepal.Length, iris$Petal.Length, alternative = "less")
#
# Read in data file (from Salkind, p203)
#
data_p203 <- read.csv(file = "Salkind-t-Test-p203.csv", head = TRUE, sep = ",")
#
data_p203 # display data
#
t.test(data_p203$Group.1, data_p203$Group.2, alternative = "two.sided", paired = FALSE) # run test (should give result t = -0.1371, df = 47.635, p-value = 0.8915)
#
##############################################################################################################
#                                           t Test - Dependent/Paired
##############################################################################################################
#
# Read in data file
#
data_paired <- read.csv(file = "t-Test-Paired-Example.csv", head = TRUE, sep = ",")
#
data_paired # display data
#
t.test(data_paired$Sample.A, data_paired$Sample.B, alternative = "two.sided", paired = TRUE) # run test (should give result t = -2.3781, df = 14, p-value = 0.03219)
#
##############################################################################################################
#                                              One-way ANOVA
##############################################################################################################
#
# Example taken from http://www.stat.columbia.edu/~martin/W2024/R3.pdf
#
# A drug company tested three formulations of a pain relief medicine for
# migraine headache sufferers. For the experiment 27 volunteers were selected
# and 9 were randomly assigned to one of three drug formulations. The subjects
# were instructed to take the drug during their next migraine headache episode and
# to report their pain on a scale of 1 to 10 (10 being most pain). 
#
# Drug A 4 5 4 3 2 4 3 4 4
# Drug B 6 8 4 5 4 6 5 8 6
# Drug C 6 7 6 6 7 5 6 5 5
#
# Read in data
#
pain = c(4, 5, 4, 3, 2, 4, 3, 4, 4, 6, 8, 4, 5, 4, 6, 5, 8, 6, 6, 7, 6, 6, 7, 5, 6, 5, 5) # 
drug = c(rep("A", 9), rep("B", 9), rep("C", 9)) # constructs a list of nine A's in a row, followed by nine B's, and then none C's
migraine = data.frame(pain, drug)
#
plot(pain ~ drug, data = migraine) # make the boxplots of above data
#
results = aov(pain ~ drug, data = migraine) # run ANOVA test - should give result F = 11.91
#
summary(results) # display ANOVA table
#
# Do same test reading data from a file - "ANOVA-Drugs-Test2.csv"
#
data_drugs <- read.csv(file = "ANOVA-Drugs-Test-2.csv", head = TRUE, sep = ",")
#
data_drugs # display data
#
# Use anova function
#
anova(lm(Values ~ Group, data_drugs)) # Run the test should give result F = 11.906
#
# Use aov function
#
results2 = aov(Values ~ Group, data = data_drugs) # run test - should get same result
summary(results2) # display ANOVA table
#
##############################################################################################################
# Jer Hayes code from Lecture 4 
#
# Draw a simple Scatter Pot
#
x <- c(1, 2, 3, 4, 5)
y <- c(1, 2, 1.3, 3.75, 2.25)
plot(x, y)
plot(x, y, main = "Quick Example", xlab = "X Variable", ylab = "Y Variable", col = "blue")
#
# Pearsons' Correllation Coefficient (r)
#
cor(x, y) # should get r = 0.6268327
#
# Some more examples using different coefficients
#
cor(x, y, method = "pearson")
cor(x, y, method = "pearson")
cor(x, y, method = "kendall")
cor(x, y, method = "spearman")
#
##############################################################################################################
#                                               Correlation
##############################################################################################################
#
correl_data <- read.csv(file = "CorrelationData.csv", head = TRUE, sep = ",")
#
correl_data # Display data
#
cor(correl_data$Test_Score, correl_data$Attitude) # Calculate r
#
plot(correl_data$Test_Score, correl_data$Attitude, main = "Correlation ", xlab = "Attitude ", ylab = "Test Score ", pch = 19)
#
# Add trend line
abline(lm(correl_data$Test_Score ~ correl_data$Attitude)$coefficients, col = "black")
iris$Sepal.Length
#
# NUmber of Cricket Chirps and Temperature - is there a correlation?
#
chirp_nums = c(18, 20, 21, 23, 27, 30, 34, 39)
temp_f = c(57, 60, 64, 65, 68, 71, 74, 77)
plot(chirp_nums, temp_f)
cor(chirp_nums, temp_f)
#
fit <- lm(chirp_nums ~ temp_f)
plot(temp_f, chirp_nums)
abline(fit)
summary(fit)
#
# Check Iris Sepal data for relationship
#
cor(iris$Sepal.Length, iris$Petal.Length) # r = 0.8717538
#
# Read data from a CSV file
#
data_correl <- read.csv(file = "CorrelationData.csv", head = TRUE, sep = ",") # Data source - Salkind (2015)
#
data_correl # display data
#
cor(data_correl$Test_Score, data_correl$Attitude) # Run test - result should be r = 0.5960948
#
# plot simple scattergram + labels
plot.default(data_correl$Test_Score, data_correl$Attitude, main = "Salkind Data (Test Score vs Attitude)", xlab = "Test Score", ylab = "Attitude to Tests ")
#
# Plot an image
#
jpeg("SampleChart.jpg")
plot(x)
dev.off()
