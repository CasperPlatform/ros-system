FROM hominidae/armhf-ubuntu

RUN update-locale LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX \
&& echo "deb http://packages.ros.org/ros/ubuntu trusty main" \
> /etc/apt/sources.list.d/ros-latest.list \
&& apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 0xB01FA116 
RUN apt-get update && apt-get -y install \
	ros-indigo-ros-base \
	python-rosdep \
    cmake \
    git \
    libboost-system-dev \
    libboost-thread-dev \
    build-essential 

RUN rosdep fix-permissions \
	&& rosdep init \
    && rosdep update

COPY .bashrc /root/
COPY entrypoint.sh /
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
USER root
RUN source /root/.bashrc && chmod -R 711 /opt && ./opt/ros/indigo/setup.sh \
&& mkdir -p /src/ros && chmod -R 755 /src && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
