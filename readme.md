# AFL Modelling Project

This project uses Python and R for modelling Australian Football League (AFL) data.

## Project Structure

- `.github/workflows/docker-image.yml`: GitHub Actions workflow for building a Docker image.
- `Dockerfile`: Dockerfile for creating a Docker image with the necessary environment for the project.
- `afl_modelling.ipynb`: Jupyter notebook for AFL modelling.
- `build.sh`: Shell script for building the Docker image.
- `data_preprocessing.r`: R script for preprocessing the data.
- `docker-compose.yaml`: Docker Compose file for defining and running multi-container Docker applications.
- `fitzRoy_Data.ipynb`: Jupyter notebook for working with FitzRoy data.
- `fixture.csv`: CSV file with fixture data.
- `requirements.txt`: Python requirements file.
- `run.sh`: Shell script for running the Docker Compose application.

## Getting Started
Install docker https://dev.to/bowmanjd/install-docker-on-windows-wsl-without-docker-desktop-34m9

You have two options to get the Docker image for this project:
1. **Build the Docker image locally:**

```sh
./build.sh
```
2. **Pull the Docker image from GitHub Container Registry:**
```sh
docker pull ghcr.io/DanJarAka/AFL/afl-stats:latest
```

After creating the image run the Docker Compose application:
```sh
./run.sh
```
If you are facing NVIDA driver issues you can take the following steps:
```sh
# Remove all old NVIDIA docker installation, if any.
sudo apt-get remove -y nvidia-docker
# Setup the stable repository and the GPG key:
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -

distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# Update the package lists and install the docker-ce and nvidia-docker2 packages:
sudo apt-get update
sudo apt-get install -y docker-ce nvidia-docker2
# Restart the Docker daemon to complete the installation
sudo systemctl restart docker

# Update CUDA drivers
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-3
```
## Data Preprocessing
Data preprocessing is done in R. The data_preprocessing.r script reads the raw data, cleans it, and outputs processed data.

AFL Modelling
AFL modelling is done in Python. The afl_modelling.ipynb Jupyter notebook reads the processed data and performs modelling.