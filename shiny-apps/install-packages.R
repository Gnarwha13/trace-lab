# Trace Lab - R package dependencies
# Run once on the server: sudo Rscript /srv/shiny-server/install-packages.R

packages <- c(
  # Core
  "shiny",
  "rmarkdown",
  "knitr",

  # Data manipulation
  "dplyr",
  "tidyr",
  "readr",
  "tibble",

  # Visualization
  "ggplot2",
  "plotly",
  "ggpubr",

  # EEG / Neuroscience
  "eegUtils",

  # Stats
  "lme4",        # mixed effects models
  "emmeans",     # estimated marginal means
  "effectsize",

  # Reporting
  "papaja",      # APA-style R Markdown papers
  "gt",          # publication-quality tables
  "kableExtra"
)

install.packages(
  packages[!(packages %in% installed.packages()[,"Package"])],
  repos = "https://cran.rstudio.com/",
  dependencies = TRUE
)

cat("✓ All packages installed\n")
