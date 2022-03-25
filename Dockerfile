# Date: 2022-03-25 12:51:37
# Author: WXZhao
# Description: Run WeChat and QQ with deepin-wine-wechat-arch and deepin-wine-qq-arch

# build the image
# docker build --network=host -t docker-arch-wine:latest .
FROM archlinux:latest
LABEL maintainer="wxzhao7@gmail.com"

# creat new user: temp
RUN sed -i '1i\Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist
RUN pacman -Sy binutils fakeroot sudo git base-devel --noconfirm --needed
RUN useradd temp && mkdir /home/temp && chown -R temp:temp /home/temp
RUN echo 'temp ALL=NOPASSWD: ALL' >> /etc/sudoers
# prepare
# add Multilib repository
RUN echo "[multilib]" >> /etc/pacman.conf && echo "Include =/etc/pacman.d/mirrorlist" >> /etc/pacman.conf && pacman -Sy
USER temp
WORKDIR /home/temp
ENV GO111MODULE=on GOPROXY=https://goproxy.cn
RUN git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si --noconfirm
RUN yay -S deepin-wine-wechat deepin-wine-qq --noconfirm

# clean
# RUN yay -Yc --noconfirm && sudo pacman -Scc --noconfirm

CMD ["/usr/bin/bash"]