# gapminder-ggplot-analysis

GDP vs Life Expectancy Analysis (Gapminder 2007)

Project Overview

This project explores the relationship between economic development (GDP per capita) and population health outcomes (life expectancy) using the Gapminder dataset for the year 2007.

The analysis combines data visualization, statistical modeling, and diagnostic evaluation to understand:

- How wealth influences life expectancy
- Whether this relationship varies across continents
- The role of confounding and interaction effects in global health data

Objectives

- Visualize the association between GDP per capita and life expectancy
- Apply log transformation to address skewness in income data
- Fit and interpret regression models
- Control for confounding (continent)
- Test for interaction effects
- Evaluate model assumptions using diagnostics

 Dataset

- Source: Gapminder
- Year: 2007
- Variables:
  - "country" – Country name
  - "continent" – Continent classification
  - "year" – Year of observation
  - "lifeExp" – Life expectancy (years)
  - "gdpPercap" – GDP per capita (USD)
  - "pop" – Population size

Methodology

1. Data Preparation

- Filter dataset to 2007 only
- Inspect structure using "glimpse()"

2. Exploratory Data Analysis (EDA)

- Scatter plots of GDP vs life expectancy
- Bubble plots with population size
- Log transformation of GDP ("log10 scale") to handle skewness
- Faceting by continent

3. Statistical Modeling

Model 1: Simple Linear Regression

lm(lifeExp ~ log(gdpPercap))

- Assumes a global relationship
- Ignores continental differences

Model 2: Adjusted Model (Confounding Control)

lm(lifeExp ~ log(gdpPercap) + continent)

- Controls for continent as a categorical confounder
- Interprets GDP effect holding continent constant

Model 3: Interaction Model

lm(lifeExp ~ log(gdpPercap) * continent)

- Tests whether the GDP–life expectancy relationship differs by continent

Key Visualizations

- Basic scatter plot (GDP vs Life Expectancy)
- Bubble plot (size = population)
- Faceted plots by continent
- Regression lines:
  - Linear model (LM)
  - LOESS smoother

Results Interpretation

Objective

To assess the effect of GDP per capita on life expectancy globally and across continents.

Findings

- A positive association exists: higher GDP → higher life expectancy
- The relationship is non-linear, justifying log transformation
- Significant variation exists across continents
- Adjusting for continent reduces bias from confounding
- Interaction model suggests heterogeneity of effects

Conclusion

Economic growth is strongly associated with improved health outcomes, but geographical and structural differences modify this relationship. Policy interventions should therefore be context-specific, not global averages.

 Model Diagnostics

Performed using:

plot(model2)
check_model(model2)

Assumptions Checked

- Linearity
- Homoscedasticity
- Normality of residuals
- Influential observations

Observations

- Log transformation improves linearity
- Some heteroscedasticity may remain
- Outliers (e.g., very high-income countries) may influence fit

Limitations

- Cross-sectional data → cannot infer causality
- GDP is an imperfect proxy for development
- Potential omitted variables:
  - Healthcare access
  - Education
  - Inequality

Key Concepts Demonstrated

- Data visualization with "ggplot2"
- Log transformation for skewed predictors
- Linear regression modeling
- Confounding adjustment
- Interaction effects
- Model diagnostics

Reproducibility

Requirements

install.packages(c("ggplot2", "gapminder", "dplyr", "scales"))

Run Analysis

1. Clone repository
2. Open R script
3. Execute sequentially

 Future Work

- Extend analysis to time series (1960–2010)
- Use multilevel models (countries nested within continents)
- Incorporate additional predictors (education, healthcare spending)
- Apply causal inference methods (e.g., DAGs, propensity scores)

Author

Ezra Komen Kipyegon — Biostatistics & Data Science Enthusiast
