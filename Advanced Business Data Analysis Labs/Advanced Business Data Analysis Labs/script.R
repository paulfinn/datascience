
correl_data = read.csv("CorrelationData.csv", head = TRUE, sep = ",")
correl_data

cor(correl_data$Test_Score, correl_data$Attitude)
plot(correl_data$Test_Score, correl_data$Attitude)

plot(correl_data$Test_Score, correl_data$Attitude, main = "Correlation ", xlab = "Attitude ", ylab = "Test Score ", pch = 19)



data1 <- c(48.5, 54.5, 61.25, 69, 74.5, 85, 89, 99, 112, 123, 134, 142)
 data2 <- c(8, 9.44, 10.08, 11.81, 12.28, 13.61, 15.13, 15.47, 17.36, 18.07, 20.79, 16.06)
 plot(data2, data1)
 fit2 <- lm(data1 ~ data2)
 fit2
lm(formula = data1 ~ data2)

res <- signif(residuals(fit2), 5)
pre <- predict(fit2)
plot(data2, data1)
segments(data2, data1, data2, pre, col = "red")


fit2.stdRes = rstandard(fit2)
plot(fit2.stdRes, col = "red")
abline(0, 0)

hist(fit2.stdRes, col = "red")


qqnorm(fit2.stdRes, ylab = "Standardized Residuals", xlab = "Normal Scores", main = "Normality Plot", col = "red")
qqline(fit2.stdRes)
