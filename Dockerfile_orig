FROM proboter/indigo-ros-base-armv7

RUN apt-get update && apt-get -y install \
    cmake \
    git \
    libboost-system-dev \
    libboost-thread-dev \
    build-essential
COPY .bashrc /root/
COPY entrypoint.sh /
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
USER root
RUN source /root/.bashrc && chmod -R 711 /opt && ./opt/ros/indigo/setup.sh \
&& mkdir -p /src/ros && chmod -R 755 /src && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
