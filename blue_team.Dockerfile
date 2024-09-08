FROM quay.io/jupyter/datascience-notebook:latest
# Reference:
    # https://github.com/mikebirdgeneau/jupyterlab-docker/blob/master/docker-compose.yml
    # https://dev.to/juanbelieni/how-to-run-jupyterlab-on-docker-4n80
    # https://github.com/jupyter/docker-stacks
# Another option for base image: nvidia/cuda:12.6.0-cudnn-devel-ubuntu20.04

# Install system dependencies and Compliance Masonry for Debian-based systems
USER root

# Install required system packages
RUN apt-get update && \
    apt-get install -y wget curl lsb-release rpm apt-transport-https && \
    rm -rf /var/lib/apt/lists/*

# Download the Compliance Masonry DEB package
RUN wget https://github.com/opencontrol/compliance-masonry/releases/download/v1.1.6/compliance-masonry_1.1.6_linux_amd64.deb -O /tmp/compliance-masonry.deb

# Install the Compliance Masonry DEB package
RUN apt install -y /tmp/compliance-masonry.deb && \
    rm /tmp/compliance-masonry.deb

# Create a directory for OpenControl projects
#RUN mkdir /opt/opencontrol

WORKDIR /home/blueteam_nb

COPY ./blue_team_requirements.txt .
RUN pip install --upgrade -r ./blue_team_requirements.txt

# Add a JupyterLab extension for version control if needed
RUN jupyter labextension install @jupyterlab/git

EXPOSE 8899

CMD jupyter lab --ip=* --port=8899 --no-browser --notebook-dir=/home/blueteam_nb --allow-root