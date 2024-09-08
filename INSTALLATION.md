# OllaDeck Installation Guide
OllaDeck is a purple technology stack for Generative AI (text modality).
Set up is verified with AMD64 architecture, Docker for Desktop on Windows, WSL2 with Ubuntu, local storage. You may have to make changes to the setup files if you are using ARM-based architecture, cloud-based storage, etc.

## Prerequisites
1. Network connection
2. Basic knowledge about CLIs (command line interfaces)
3. Git or GitHub installed
4. Docker installed
5. Nvidia drivers and toolkit installed OR the Docker Compose files modified (see the below pre-installation steps)

## Pre-installation Steps for GPU System
To avoid OllaDeck installation failure due to GPU or CPU conflicts, you need to install the needed gpu supports or modify the installation files to support CPU. The details are as follows.
### GPU Pre-installation Steps
The below steps assume you have nVidia-based GPUs and run Ubuntu 24.04. For full setup details, you may check out (NVIDIA CUDA Installation Guide for Linux)[https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html], (NVIDIA CUDA Post-installation Guide)[https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#post-installation-actions],(Installing NVIDIA Container Toolkit)[https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-the-nvidia-container-toolkit]
1. Check your Linux distro, your computer architecture, and whether GCC is installed
```
lsb_release -a
gcc --version
```
2. Update apt and install GCC as needed
```
sudo apt update
sudo apt install gcc
```
3. Installing CUDA keyring
```
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
```
4. Update apt-get and install CUDA toolkit
```
sudo apt-get update
sudo apt-get install cuda-toolkit
```
5. Install nVidia GDS as needed. NVIDIA GDS (GPU Direct Storage) is a technology designed to optimize data transfer between storage devices and NVIDIA GPUs. By bypassing the CPU and system memory, GDS reduces latency and increases throughput for data-intensive applications, particularly in fields like high-performance computing (HPC), data analytics, and artificial intelligence.
```
sudo apt-get install nvidia-gds
```
6. Reboot the host and then remove the local repo
```
sudo reboot
sudo apt-get remove --purge "cuda-repo-<distro>-X-Y-local*"
```
7. Environment setup
```
export PATH=/usr/local/cuda-12.6/bin${PATH:+:${PATH}}
```
8. Configure nVidia container toolkit repository
```
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```
9. Update apt-get and install the container toolkit
```
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
```
10. Configure Docker container runtime
```
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```
11. If you use Docker Desktop on Windows, go to the settings, choose "Docker Engine", and add the following to the json then reboot Docker Desktop
```
"runtimes": {
    "nvidia": {
      "path": "nvidia-container-runtime",
      "runtimeArgs": []
    }
  }
```
12. Test the nVidia driver/toolkit installation with the following. You should be able to see basic information about your nVidia GPU.
```
sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```
Sample output
```
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 560.31.01              Driver Version: 560.81         CUDA Version: 12.6     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce RTX 3080 Ti     On  |   00000000:01:00.0  On |                  N/A |
|  0%   43C    P8             18W /  350W |     605MiB /  12288MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|  No running processes found                                                             |
+-----------------------------------------------------------------------------------------+
```
13. If you run into issues, please follow the previously shared links to the full nVidia documentation and troubleshoot.

### Pre-installation Steps for CPU System
tba

### PrPre-installation - Triming Default Instances
tba

### Pre-installation - Nvidia Model Download for Triton Server
Please execute the following steps if you plan to use the Triton Server in OllaDeck.
1. Register an account at ngc.nvidia.com
2. Generate an NGC API key at [Nvidia NGC Personal Key Setup](https://org.ngc.nvidia.com/setup/personal-keys). Make sure to choose **"NGC Catalog"** for the "Service Include" selection box. Record the API key to a safe place.
3. Install [Nvidia NGC CLI](https://org.ngc.nvidia.com/setup/installers/cli)
4. Configure Nvidia NGC CLI with the API key using the below command. Sample values to enter include: Enter CLI output format type [ascii]. Enter org [ID]. Enter team [no-team]. Enter ace [no-ace].
```
ngc config set
```
5. Browse models at [Nvidia NGC Model Catalog](https://catalog.ngc.nvidia.com/models)
6. For a selected model, click the "Download" button and choose "CLI" to copy the cli command to download the selected model. For example, the command for downloading Nvidia NGC Meta Llama 3.1 8B is
```
ngc registry model download-version "nvidia/nemo/llama-3_1-8b-nemo:1.0"
```
7. Download the model to the cloned respository folder's **\volumes\triton-model-repository** folder by navigating to the folder and executing the command. Please note that during the later OllaDeck setup, the downloaded model(s) will be copied to the Triton instance for Nvidia Triton server. Please also note that Docker may expand its virtual disks and will not shrink the disks automatically. Hence, the host's disk storage must have enough free space.


## Installation
1. Test if Docker and Docker Compose are running
```
docker --version
docker info
docker-compose --version
```
2. Clean up Docker cache (optional). All things related to non-running instances will be deleted.
```
docker system prune -f
```
3. Clone this repository to your selected current working folder ($PWD)
git clone <repository url>
```
4. Change the default password/token/secret/salt values in the ***docker-compose.yml*** file
5. Build the Docker Compose project

with cache
```
docker-compose build
```
or without cache
```
docker-compose build --no-cache
```
6. Run the Docker Compose project
```
docker-compose up
```