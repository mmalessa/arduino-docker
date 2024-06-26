FROM ubuntu:24.04

# install necessary packages here
RUN apt-get update \
    && apt-get install -y \
        wget unzip xz-utils \
        # Arduino runtime libs
        libglib2.0-0t64 libnss3 libatk1.0-0t64 libatk-bridge2.0-0t64 libcups2t64 libdrm2 libgtk-3-0t64 libgbm1 libasound2t64

# delete default 'ubuntu' user
RUN userdel ubuntu

# create developer user
ARG DEVELOPER_UID=1000
ARG DEVELOPER_GID=1000
RUN groupadd -g ${DEVELOPER_GID} developer \
    && useradd -u ${DEVELOPER_UID} -g ${DEVELOPER_GID} -m developer \
    && usermod -a -G adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev developer

WORKDIR /home/developer

# Legacy IDE
ENV ARDUINO_BASE_NAME arduino-1.8.19-linux64
RUN wget https://downloads.arduino.cc/${ARDUINO_BASE_NAME}.tar.xz \
    && tar Jxf ${ARDUINO_BASE_NAME}.tar.xz -C ./ \
    && chown developer:developer arduino-1.8.19 -R \
    && rm ${ARDUINO_BASE_NAME}.tar.xz \
    && ln -s arduino-1.8.19/arduino ./

# Current version doesn't work here ...yet
# ENV ARDUINO_BASE_NAME arduino-ide_2.3.2_Linux_64bit
# RUN wget https://downloads.arduino.cc/arduino-ide/${ARDUINO_BASE_NAME}.zip \
#     && unzip ${ARDUINO_BASE_NAME}.zip \
#     && rm ${ARDUINO_BASE_NAME}.zip \
#     && chown developer:developer ${ARDUINO_BASE_NAME} -R \
#     && cd ${ARDUINO_BASE_NAME} \
#     && chmod u+x arduino-ide \
#     && chown root:root chrome-sandbox \
#     && chmod 4755 chrome-sandbox

USER developer
WORKDIR /home/developer