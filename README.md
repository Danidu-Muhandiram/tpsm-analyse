# Market Price Awareness and Farmer Selling Decision Analysis

This project investigates how **market price awareness** influences **farmers’ selling decision behavior** using statistical analysis and predictive modeling in **R**.

The study uses survey-based farmer data to examine whether knowledge of current prices, future prices, market trends, and price risks affects farmers’ selling decisions.

---

## Project Objective

The primary objective of this project is to analyze the relationship between:

- **Market Price Awareness** *(Independent Variable)*
- **Selling Decision Behavior** *(Dependent Variable)*

This analysis includes:

- Data cleaning
- Descriptive analysis
- Inferential analysis
- Predictive modeling

---

## Dataset

**File used:** `filtered_farmers_data.csv`

### Variables Used

### Market Price Awareness
- `Know_Current_Price`
- `Know_Future_Price`
- `Understand_Price_Trend`
- `Compare_Spot_Future`
- `Know_Price_Risk`

### Selling Decision Behavior
- `Holding_Decision`
- `Price_Strategy`

---

## Methodology

### 1. Data Preparation

The dataset was preprocessed by:

- Checking missing values
- Removing incomplete records
- Removing duplicate observations
- Inspecting structure and summary statistics

---

### 2. Composite Score Construction

Two new variables were created.

#### Awareness Score

Computed as the average of:

- Current price knowledge
- Future price knowledge
- Price trend understanding
- Spot vs future comparison
- Price risk awareness

#### Decision Score

Computed as the average of:

- Holding decision
- Price strategy

---

## Analysis Performed

### Descriptive Analysis

- Frequency tables
- Percentages
- Summary statistics
- Histograms
- Bar charts
- Boxplots
- Scatter plots

### Inferential Analysis

- Pearson correlation
- Correlation significance test
- ANOVA
- Tukey post-hoc test
- Levene’s test
- Shapiro-Wilk normality test
- Linear regression

### Predictive Analysis

- Regression-based prediction
- Median split subgroup analysis
- High-awareness vs low-awareness model comparison

---

## R Packages Used

```r
install.packages(c("readxl", "ggplot2", "dplyr", "tidyr", "car"))
