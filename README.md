# 使用Docker-ArchLinux实现QQ和微信

docker run -dit --name wechat \
    --device /dev/snd --ipc="host"\
    -v "$HOME/Documents/WeChat Files":'/home/user/WeChat Files' \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e XMODIFIERS=@im=fcitx \
    -e QT_IM_MODULE=fcitx \
    -e GTK_IM_MODULE=fcitx \
    -e DISPLAY=unix$DISPLAY \
    -e AUDIO_GID=`getent group audio | cut -d: -f3` \
    -e VIDEO_GID=`getent group video | cut -d: -f3` \
    -e GID=`id -g` \
    -e UID=`id -u` \
    -e TZ=Asia/Shanghai \
    --net host \
    --restart unless-stopped \
    registry.cn-shanghai.aliyuncs.com/clansty/deepin-wine-wechat:latest
