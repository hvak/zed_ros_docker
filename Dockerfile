FROM osrf/ros:noetic-desktop-full

ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
ENV TERM=linux

SHELL ["/bin/bash", "-c"]

RUN apt update
RUN apt install -y wget zstd git cmake curl

WORKDIR /root/catkin_ws
RUN mkdir -p /root/catkin_ws/src
RUN curl -LJo ZED_SDK_Ubuntu20_cuda11.8_v4.0.1.zstd.run  https://download.stereolabs.com/zedsdk/4.0/cu118/ubuntu20 && chmod +x ZED_SDK_Ubuntu20_cuda11.8_v4.0.1.zstd.run && ./ZED_SDK_Ubuntu20_cuda11.8_v4.0.1.zstd.run -- silent
RUN mkdir -p /root/catkin_ws/src
RUN source /opt/ros/noetic/setup.bash && cd /root/catkin_ws/src && git clone --recursive https://github.com/stereolabs/zed-ros-wrapper.git && cd .. && \
    rosdep install --from-paths src --ignore-src -r -y

RUN rm -rf /var/lib/apt/lists/*
