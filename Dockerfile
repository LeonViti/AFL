FROM tensorflow/tensorflow:latest-gpu

WORKDIR /AFL  

RUN apt-get update && apt-get install -y git

COPY requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip uninstall -y jupyterlab && \
    pip install --upgrade -r requirements.txt

# install R
RUN apt-get update && apt-get install -y r-base 

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

# Install IRkernel and set up the kernel for Jupyter
RUN Rscript -e "install.packages('IRkernel')" \
    -e "IRkernel::installspec(user = FALSE)" \
    -e "install.packages('fitzRoy')" \
    -e "install.packages('jsonlite')" \
    -e "install.packages('tidyverse')" \
    -e "install.packages('lubridate')" 

EXPOSE 8000
ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root","--no-browser"]