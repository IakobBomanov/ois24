if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")
if (!require(patchwork)) install.packages("patchwork")

library(ggplot2)
library(dplyr)
library(patchwork)

set.seed(42)
n <- 100
data <- data.frame(
  x = rnorm(n),
  y = 2 * rnorm(n) + 3,
  category = sample(c("A", "B", "C"), n, replace = TRUE)
)

print(head(data))

scatter_plot <- ggplot(data, aes(x = x, y = y, color = category)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(title = "Graphique de dispersion avec régression non linéaire",
       x = "Variable X",
       y = "Variable Y",
       color = "Catégorie") +
  theme_minimal()

boxplot_y <- ggplot(data, aes(x = category, y = y, fill = category)) +
  geom_boxplot() +
  labs(title = "Boîtes à moustaches de Y par catégorie",
       x = "Catégorie",
       y = "Variable Y",
       fill = "Catégorie") +
  theme_minimal()

boxplot_x <- ggplot(data, aes(x = category, y = x, fill = category)) +
  geom_boxplot() +
  labs(title = "Boîtes à moustaches de X par catégorie",
       x = "Catégorie",
       y = "Variable X",
       fill = "Catégorie") +
  theme_minimal()

combined_plot <- scatter_plot / (boxplot_x | boxplot_y)

print(combined_plot)
