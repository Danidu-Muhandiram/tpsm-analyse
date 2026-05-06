data <- read.csv("filtered_farmers_data.csv")

install.packages("readxl")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")
install.packages("car")

library(readxl)
library(ggplot2)
library(dplyr)
library(tidyr)
library(car)


# check missing values
colSums(is.na(data))

# remove missing values
data_clean <- na.omit(data)

# remove duplicates
data_clean <- distinct(data_clean)

# check structure again
str(data_clean)
summary(data_clean)


# X = Market Price Awareness
data_clean$Awareness_Score <- rowMeans(data_clean[, c(
  "Know_Current_Price",
  "Know_Future_Price",
  "Understand_Price_Trend",
  "Compare_Spot_Future",
  "Know_Price_Risk"
)], na.rm = TRUE)

# Y = Selling Decision Behavior
data_clean$Decision_Score <- rowMeans(data_clean[, c(
  "Holding_Decision",
  "Price_Strategy"
)], na.rm = TRUE)


# Check new variables
summary(data_clean$Awareness_Score)
summary(data_clean$Decision_Score)

# Basic checks
head(data_clean)
dim(data_clean)
names(data_clean)
str(data_clean)
summary(data_clean)



#descriptive analyse
# Frequency tables and percentages
table(data_clean$Know_Current_Price)
prop.table(table(data_clean$Know_Current_Price)) * 100

table(data_clean$Know_Future_Price)
prop.table(table(data_clean$Know_Future_Price)) * 100

table(data_clean$Understand_Price_Trend)
prop.table(table(data_clean$Understand_Price_Trend)) * 100

table(data_clean$Compare_Spot_Future)
prop.table(table(data_clean$Compare_Spot_Future)) * 100

table(data_clean$Know_Price_Risk)
prop.table(table(data_clean$Know_Price_Risk)) * 100

table(data_clean$Holding_Decision)
prop.table(table(data_clean$Holding_Decision)) * 100

# Bar charts
ggplot(data_clean, aes(x = factor(Know_Current_Price))) +
  geom_bar(fill = "steelblue", color = "black") +
  labs(title = "Distribution of Knowing Current Price",
       x = "Response Category", y = "Frequency")

ggplot(data_clean, aes(x = factor(Know_Future_Price))) +
  geom_bar(fill = "steelblue", color = "black") +
  labs(title = "Distribution of Knowing Future Price",
       x = "Response Category", y = "Frequency")

ggplot(data_clean, aes(x = factor(Understand_Price_Trend))) +
  geom_bar(fill = "steelblue", color = "black") +
  labs(title = "Distribution of Understanding Price Trend",
       x = "Response Category", y = "Frequency")

ggplot(data_clean, aes(x = factor(Compare_Spot_Future))) +
  geom_bar(fill = "steelblue", color = "black") +
  labs(title = "Distribution of Comparing Spot and Future Prices",
       x = "Response Category", y = "Frequency")

ggplot(data_clean, aes(x = factor(Know_Price_Risk))) +
  geom_bar(fill = "steelblue", color = "black") +
  labs(title = "Distribution of Knowing Price Risk",
       x = "Response Category", y = "Frequency")

ggplot(data_clean, aes(x = factor(Holding_Decision))) +
  geom_bar(fill = "darkgreen", color = "black") +
  labs(title = "Distribution of Holding Decision",
       x = "Response Category", y = "Frequency")

ggplot(data_clean, aes(x = factor(Price_Strategy))) +
  geom_bar(fill = "darkgreen", color = "black") +
  labs(title = "Distribution of Price Strategy",
       x = "Response Category", y = "Frequency")

# Score statistics
mean(data_clean$Awareness_Score, na.rm = TRUE)
median(data_clean$Awareness_Score, na.rm = TRUE)
sd(data_clean$Awareness_Score, na.rm = TRUE)
min(data_clean$Awareness_Score, na.rm = TRUE)
max(data_clean$Awareness_Score, na.rm = TRUE)
summary(data_clean$Awareness_Score)

mean(data_clean$Decision_Score, na.rm = TRUE)
median(data_clean$Decision_Score, na.rm = TRUE)
sd(data_clean$Decision_Score, na.rm = TRUE)
min(data_clean$Decision_Score, na.rm = TRUE)
max(data_clean$Decision_Score, na.rm = TRUE)
summary(data_clean$Decision_Score)

# All numeric variable means and SDs
numeric_cols <- data_clean[, sapply(data_clean, is.numeric)]
colMeans(numeric_cols, na.rm = TRUE)
apply(numeric_cols, 2, sd, na.rm = TRUE)

# Summary table
summary_table <- data.frame(
  Variable = c("Awareness_Score", "Decision_Score"),
  Mean = c(mean(data_clean$Awareness_Score), mean(data_clean$Decision_Score)),
  Median = c(median(data_clean$Awareness_Score), median(data_clean$Decision_Score)),
  SD = c(sd(data_clean$Awareness_Score), sd(data_clean$Decision_Score)),
  Min = c(min(data_clean$Awareness_Score), min(data_clean$Decision_Score)),
  Max = c(max(data_clean$Awareness_Score), max(data_clean$Decision_Score))
)

summary_table

# Histograms
ggplot(data_clean, aes(x = Awareness_Score)) +
  geom_histogram(bins = 10, fill = "skyblue", color = "black") +
  labs(title = "Histogram of Awareness Score",
       x = "Awareness Score", y = "Frequency")

ggplot(data_clean, aes(x = Decision_Score)) +
  geom_histogram(bins = 8, fill = "lightgreen", color = "black") +
  labs(title = "Histogram of Decision Score",
       x = "Decision Score", y = "Frequency")

# Boxplots
ggplot(data_clean, aes(y = Awareness_Score)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Boxplot of Awareness Score",
       y = "Awareness Score")

ggplot(data_clean, aes(y = Decision_Score)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Boxplot of Decision Score",
       y = "Decision Score")

# Scatter plot
ggplot(data_clean, aes(x = Awareness_Score, y = Decision_Score)) +
  geom_point(alpha = 0.5) +
  labs(title = "Scatter Plot of Awareness Score vs Decision Score",
       x = "Awareness Score", y = "Decision Score")

# Scatter plot with trend line
ggplot(data_clean, aes(x = Awareness_Score, y = Decision_Score)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Awareness Score vs Decision Score",
       x = "Awareness Score", y = "Decision Score")

all_summary <- data.frame(
  Variable = names(numeric_cols),
  Mean = sapply(numeric_cols, mean, na.rm = TRUE),
  Median = sapply(numeric_cols, median, na.rm = TRUE),
  SD = sapply(numeric_cols, sd, na.rm = TRUE),
  Min = sapply(numeric_cols, min, na.rm = TRUE),
  Max = sapply(numeric_cols, max, na.rm = TRUE)
)

all_summary






#inferential analyse
# Correlation analysis
cor_matrix <- cor(numeric_cols, use = "complete.obs")
cor_matrix

cor(data_clean$Awareness_Score, data_clean$Decision_Score)

cor_test <- cor.test(data_clean$Awareness_Score, data_clean$Decision_Score)
cor_test


# Convert Holding_Decision to factor (separate column to keep numeric version intact)
data_clean$Holding_Decision_f <- as.factor(data_clean$Holding_Decision)

str(data_clean$Holding_Decision_f)
table(data_clean$Holding_Decision_f)


# ANOVA
anova_model <- aov(Decision_Score ~ Holding_Decision_f, data = data_clean)
summary(anova_model)

TukeyHSD(anova_model)


# Assumption checking
shapiro.test(data_clean$Decision_Score)

leveneTest(Decision_Score ~ Holding_Decision_f, data = data_clean)


# Regression
model <- lm(Decision_Score ~ Awareness_Score, data = data_clean)
summary(model)

confint(model)

# Regression ANOVA (model significance)
anova(model)

# Diagnostic plots
plot(model)

# Visualization

# Boxplot
ggplot(data_clean, aes(x = Holding_Decision_f, y = Decision_Score)) +
  geom_boxplot(
    fill = "#66BB6A",
    color = "#1B5E20",
    outlier.color = "#004D40"
  ) +
  labs(
    title = "Decision Score by Holding Decision",
    x = "Holding Decision",
    y = "Decision Score"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    axis.title = element_text(face = "bold")
  )

# Scatter plot with regression line
ggplot(data_clean, aes(x = Awareness_Score, y = Decision_Score)) +
  geom_point(
    color = "#2E7D32",
    alpha = 0.6
  ) +
  geom_smooth(
    method = "lm",
    se = TRUE,
    color = "#1B5E20",
    fill = "#A5D6A7"
  ) +
  labs(
    title = "Relationship between Awareness Score and Decision Score",
    x = "Awareness Score",
    y = "Decision Score"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    axis.title = element_text(face = "bold")
  )






#predictive analyse
# Check structure
head(data_clean)
str(data_clean)

# Create scatter plot of Awareness Score vs Decision Score
plot(data_clean$Awareness_Score, data_clean$Decision_Score,
     main="Awareness vs Decision",
     xlab="Awareness Score",
     ylab="Decision Score")

# Add linear regression line to the scatter plot
abline(lm(Decision_Score ~ Awareness_Score, data=data_clean), col="red", lwd=2)

# Decision Score predicted by Awareness Score
pred_model <- lm(Decision_Score ~ Awareness_Score, data = data_clean)
summary(pred_model)

str(data_clean)

#check summery separately
summary(data_clean$Awareness_Score)
summary(data_clean$Decision_Score)

# Calculate Pearson correlation coefficient
cor(data_clean$Awareness_Score, data_clean$Decision_Score)
# Test whether the correlation is statistically significant
cor.test(data_clean$Awareness_Score, data_clean$Decision_Score)

# Q-Q plot to check normality of Decision Score
qqnorm(data_clean$Awareness_Score)
qqline(data_clean$Awareness_Score, col = "red")

qqnorm(data_clean$Decision_Score)
qqline(data_clean$Decision_Score, col = "blue")

# Find median of Awareness Score
median(data_clean$Awareness_Score)

# Create high awareness group
high <- subset(data_clean, Awareness_Score >= median(data_clean$Awareness_Score))
# Create low awareness group
low  <- subset(data_clean, Awareness_Score < median(data_clean$Awareness_Score))

# Number of observations in each group
nrow(high)
nrow(low)

# Regression model for high awareness group
high_model <- lm(Decision_Score ~ Awareness_Score, data = high)
summary(high_model)

# Regression model for low awareness group
low_model <- lm(Decision_Score ~ Awareness_Score, data = low)
summary(low_model)

# Regression coefficients
coef(high_model)
coef(low_model)
