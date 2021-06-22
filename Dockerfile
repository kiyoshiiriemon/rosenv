#FROM ros:melodic-robot-bionic
FROM nvidia/cudagl:10.2-devel-ubuntu18.04
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y curl lsb-release tzdata && rm -rf /var/lib/apt/lists/*
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add --yes
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-get update && apt-get install -y ros-melodic-desktop-full && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y vim-nox ros-melodic-jsk-visualization ros-melodic-pcl-ros \
    vim-nox screen git wget \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 rosuser && \
    useradd -m -s /bin/bash -u 1000 -g 1000 -G sudo,root rosuser
RUN echo 'rosuser:rosuser' | chpasswd
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY exa /usr/local/bin

USER rosuser
WORKDIR /home/rosuser
COPY --chown=rosuser:rosuser _screenrc /home/rosuser/.screenrc

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
