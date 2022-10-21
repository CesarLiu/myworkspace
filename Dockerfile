# Configuration: UBUNTU 18.04, CUDA 11.4, PYTHON3.8, SSH-server
FROM nvidia/cuda:11.4.0-devel-ubuntu18.04
MAINTAINER Zhiwei Han <han@fortiss.org>

# COPY installers /opt/st_docker/installers
# Some dirty fix of nvidia error
RUN rm /etc/apt/sources.list.d/cuda.list
# RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub

# Install OpenSSH, X server and libgtk (for NVIDIA Visual Profiler)
RUN apt-get update && apt-get install -y\
  software-properties-common \
  openssh-server \
  xdm \
  libgtk2.0-0 \
  git \
  screen \
  nano \
  htop \
  zip \
  unzip \
  g++ \
  gcc
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install -y python3.8 python3-pip python3.8-dev
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 2
RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir pillow numpy sklearn matplotlib tqdm pandas opencv-python
RUN pip3 install --no-cache-dir torch torchvision torchaudio \
    --extra-index-url https://download.pytorch.org/whl/cu113
WORKDIR /myworkspace
# RUN bash /opt/st_docker/installers/install_bazel.sh
# RUN bash /opt/st_docker/installers/install_boost.sh
# RUN bash /opt/st_docker/installers/install_cmake.sh
# RUN bash /opt/st_docker/installers/install_opencv.sh
# RUN bash /opt/st_docker/installers/install_pcl.sh
# RUN bash /opt/st_docker/installers/protobuf.sh

