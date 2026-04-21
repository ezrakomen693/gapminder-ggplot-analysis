# load package
library(ggplot2)
library(gapminder)
library(dplyr)
library(scales)

# Load data
glimpse(gapminder)

# Filter data
gapminder_2007 <- gapminder %>% filter(year == 2007)

# Basic scatter plot
ggplot(data = gapminder_2007,
       aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
# this gives a basic scatter plot. aes() maps columns and axes. geom_point() draws the plot.

# Add color,size, and a log scale
ggplot(gapminder_2007,
       aes(x = gdpPercap, y = lifeExp,
           color = continent,              # color by continent
           size = pop)) +                  # size by population
  geom_point(alpha = 0.7) +                # alpha = transparency
  scale_x_log10(labels =scales::comma) +   # log scale on x
  scale_size(range = c(2, 15), guide = "none")    # control dot sizes
# alpha,size,colr inside aes() map to data. Outside aes() (like alpha = 0.7), they are fixed constants.

# Add labels and theme
ggplot(gapminder_2007,
       aes(x = gdpPercap, y = lifeExp,
           color = continent,              
           size = pop)) +                  
  geom_point(alpha = 0.7) +                
  scale_x_log10(labels =scales::comma) +   
  scale_size(range = c(2, 15), guide = "none") +
  scale_color_brewer(palette = "Dark2") +
  labs(
    title = "Wealth vs. Life Expectancy (2007)",
    subtitle = "Bubble size = population",
    x = "GDP per Capita (log scale, USD)",
    y = "Life Expectancy (years)",
    color = "Continent",
    caption = "Source: Gapminder (gapminder.org), 2007"
  ) +
  theme_minimal(base_size = 13)

# Faceting ; one panel per continent
ggplot(gapminder_2007,
       aes(x = gdpPercap, y = lifeExp,
           color = continent,              
           size = pop)) +                  
  geom_point(alpha = 0.6, color = "steelblue") +                
  scale_x_log10(labels =scales::comma) +   
  scale_size(range = c(1, 10), guide = "none") +
  facet_wrap(~ continent) +                         # one panel per continent
  labs(
    title = "GDP vs. Life Expectancy by continent (2007)",
    subtitle = "Bubble size = population",
    x = "GDP per Capita (log)",
    y = "Life Expectancy",
  ) +
  theme_bw()
# facet(~ continent) splits into 5 panels automatically

# Add a trend line
ggplot(gapminder_2007,
       aes(x = gdpPercap, y = lifeExp,
  )) +                  
  geom_point(aes(color = continent), alpha = 0.7, size = 3) +
  geom_smooth(method = "lm", se = TRUE,          # linear fit + CI ribbon
              color = "firebrick", linetype = "dashed", linewidth = 0.8) +
  geom_smooth(method = "loess", se = FALSE,         
              color = "black", linewidth = 0.8) +
  scale_x_log10(labels =scales::comma) +   
  scale_size(range = c(2, 15), guide = "none") +
  labs(
    title = "GDP vs. Life Expectancy with Linear Trend",
    x = "GDP per Capita (log)",
    y = "Life Expectancy",
  ) +
  theme_classic()
# geom_smooth() fits a model and draws the line + confidence ribbon automatically

# Linnear Model
model1 <- lm(lifeExp ~ log(gdpPercap), data = gapminder_2007)
summary(model1)    # Simple regression
# It assumes same relationship across all continents

# Adjusted for continent (Confounding control)
model2 <- lm(lifeExp ~ log(gdpPercap) + continent, data = gapminder_2007)
summary(model2)
# Continents act as a categorical confounder

# Interaction Model
model3 <- lm(lifeExp ~ log(gdpPercap) * continent, data = gapminder_2007)
summary(model3)

# Diagnostics
par(mfrow = c(2, 2))
plot(model2)

# Showing linearity, collinearity, and normality all at once.
check_model(model2)

