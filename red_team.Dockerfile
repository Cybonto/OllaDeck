FROM quay.io/jupyter/datascience-notebook:latest
# Reference:
    # https://github.com/mikebirdgeneau/jupyterlab-docker/blob/master/docker-compose.yml
    # https://dev.to/juanbelieni/how-to-run-jupyterlab-on-docker-4n80
    # https://github.com/jupyter/docker-stacks
    # https://github.com/Azure/PyRIT/blob/main/doc/setup/install_pyrit.md
    # https://github.com/QData/TextAttack?tab=readme-ov-file#setup
    # https://github.com/Trusted-AI/adversarial-robustness-toolbox/wiki/Get-Started#setup
    # https://docs.garak.ai/garak/llm-scanning-basics/setting-up/installing-garak

# Another option for base image: nvidia/cuda:12.6.0-cudnn-devel-ubuntu20.04

WORKDIR /home/redteam_nb
COPY ./red_team_requirements.txt .

RUN pip install --upgrade -r ./red_team_requirements.txt

# Add a JupyterLab extension for version control if needed
RUN jupyter labextension install @jupyterlab/git

EXPOSE 8888

CMD jupyter lab --ip=* --port=8888 --no-browser --notebook-dir=/home/redteam_nb --allow-root