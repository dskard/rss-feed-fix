FROM rocker/r-ver:3.6.2

# install build dependencies
RUN set -ex; \
    \
    buildDeps=" \
        curl \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        wget \
    " ; \
    \
    apt-get update; \
    apt-get install -y $buildDeps --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*;

# install renv
ENV RENV_VERSION 0.10.0-14
RUN R -e "install.packages('remotes', repos='http://cran.rstudio.com');"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

WORKDIR /project
COPY renv.lock renv.lock
RUN R -e 'renv::restore()'

# copy the program into the container
COPY rss_feed_fix.R /project/rss_feed_fix.R

# set the default command to run when the container starts
CMD ["Rscript", "/project/rss_feed_fix.R"]
