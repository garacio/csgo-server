# syntax=docker/dockerfile:1
FROM debian:buster

RUN useradd -m steam \
      && export DEBIAN_FRONTEND=noninteractive \
      && apt-get update \ 
      && apt-get install wget -y \
      && dpkg --add-architecture i386 \
      && apt-get update \
      && apt-get install lib32gcc1 -y

USER steam

WORKDIR /home/steam

ADD --chown=steam:steam https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz /home/steam/

COPY --chown=steam:steam csgo_install.txt /home/steam/

RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
  && tar xvf steamcmd_linux.tar.gz

RUN /bin/bash /home/steam/steamcmd.sh +runscript /home/steam/csgo_install.txt

COPY --chown=steam:steam entry.sh /home/steam/

EXPOSE 27015/udp

CMD ["/home/steam/entry.sh"]

