# Ubuntu latest
FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

# Owner
LABEL Wendell Jacinto Pereira <wendelljpereira@gmail.com>
SHELL ["/bin/bash", "-c"]

# Set workdir
WORKDIR /app
COPY www /app/www
COPY R /app/R

## Install R
# update indices
RUN apt update -y -qq
RUN apt -y dist-upgrade

COPY ./apt_pkgs.txt . 

RUN cat apt_pkgs.txt | xargs apt-get install -y -qq
RUN add-apt-repository -y ppa:c2d4u.team/c2d4u4.0+
RUN apt update -y -qq
RUN apt install -y --no-install-recommends r-base=4.1.2-1ubuntu2

COPY ./rpkgs.r .

## cores for install.packages
RUN echo 'options(Ncpus = 4)' >> ~/.Rprofile

# Install R packages
RUN Rscript rpkgs.r

## Dynoverse
RUN for i in `echo https://github.com/dynverse/{babelwhale,dyn{utils,wrap,feature,plot,methods,guidelines,o}}`; do echo "cloning " $i; git clone $i;done
RUN find * -maxdepth 0 -type d -name "dyn*" -o -name "babel*"  | while read line; do tar czf $line.tar.gz $line; done;
RUN R CMD INSTALL dynutils babelwhale dynwrap dynfeature dynguidelines dynmethods dynplot dyno
RUN find *  -maxdepth 0 -type f -o -type d -name "dyn*" -o -name "babel*" | xargs rm -rf 

RUN apt-get clean

# Copy edited Seurat and install it
COPY ./Seurat.tar.gz .
RUN Rscript -e 'install.packages("Seurat.tar.gz")'

# # Configuring Docker
RUN usermod -aG docker root

#  # Get server files
COPY global.R /app/global.R
COPY server.R /app/server.R
COPY ui.R /app/ui.R
COPY /scripts/bscripts/init_app.sh /app/init_app.sh

# # expose port
EXPOSE 3838

# Fix permissions
RUN chmod a+rwx -R /app/*
RUN chmod a+rwx -R /app

# Init image
CMD ./init_app.sh
