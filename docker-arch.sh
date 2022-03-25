#!/usr/bin/env bash

# Date: 2022-03-25 12:58:42
# Author: WXZhao
# Description: run the docker conviniently


# allow local connection
xhost +local: > /dev/null 2>&1

docker run -dit --rm  \
    -e GID=$(id -g) \
    -e UID=$(id -u) \
    -e TZ=Asia/Shanghai \
    -e DISPLAY=$DISPLAY \
    -e XMODIFIERS=@im=ibus \
    -e QT_IM_MODULE=ibus \
    -e GTK_IM_MODULE=ibus \
    -e AUDIO_GID=$(getent group audio | cut -d: -f3) \
    -e VIDEO_GID=$(getent group video | cut -d: -f3) \
    -h arch \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.Xauthority:/root/.Xauthority \
    -v "$HOME/Documents/WeChat":'/home/user/WeChat Files' \
    -v $HOME:$HOME\
    -v /media:/media\
    -v /mnt:/mnt\
    --device /dev/snd --ipc="host" \
    --net host \
    --restart unless-stopped \
    --name $USER-arch \
    docker-arch
    # -u $(id -u):$(id -g) \
# --rm: Automatically remove the container when it exits
# -d: show the ID of container
# --net host: allow local network connection
# --restart unless-stopped: autostart