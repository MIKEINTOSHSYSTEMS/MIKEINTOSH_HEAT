# Use rocker/rstudio as the base image for RStudio Server
FROM rocker/rstudio:4.0.5

# Install additional R packages or system dependencies if needed for RStudio Server

# Expose port 8787 for RStudio Server
EXPOSE 8787

# Use rocker/shiny as the base image for Shiny Server
FROM rocker/shiny:4.0.5

# Install system dependencies for Shiny Server
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

# Install R packages needed for the app
RUN R -e "install.packages(c('shiny', 'shinydashboard', 'shinyWidgets', 'shinyjs', 'leaflet', 'leaflet.extras', 'sf', 'dplyr', 'ggplot2', 'plotly', 'htmltools', 'DT', 'pkgload', 'yonder'))"

# Copy the app directory into the container
COPY ./app /srv/shiny-server/app

# Expose port 3838 for Shiny Server
EXPOSE 3838

# Command to run the Shiny app
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/app', host = '0.0.0.0', port = 3838)"]
