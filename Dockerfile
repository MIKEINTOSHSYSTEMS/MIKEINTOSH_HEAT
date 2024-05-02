# Use rocker/verse image with a specific R version (optional)
# Example: For R 4.2.0
FROM rocker/verse:4.2.0

# Set working directory (optional, but good practice)
WORKDIR /home/app

# Install any additional system dependencies (if needed)
# Modify as required 
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev 

# Install DT and highcharter packages directly from CRAN within the container (recommended)
RUN R -e "install.packages(c('shiny', 'ggplot2', 'grid', 'gridExtra', 'RColorBrewer', 'dplyr', 'DT', 'data.table', 'readxl', 'tidyr', 'stringr', 'broom', 'fst', 'purrr', 'htmltools', 'scales', 'highcharter', 'shinyBS', 'viridis'), repos='https://cran.r-project.org')"

# Copy your application code
COPY app .

# Expose port for Shiny app
EXPOSE 3838

# Run Shiny app
CMD ["R", "-e", "shiny::runApp('/home/app')"]

# Additional considerations (optional)
# - Set environment variables for your app
# - Use multi-stage builds for smaller image size

# LABEL maintainer (optional, for informational purposes)
# LABEL maintainer="Your Name <your_email@example.com>"
