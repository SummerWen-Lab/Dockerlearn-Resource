# 使用 Pachyderm 的 OpenCV 2.6.0 作为基础镜像
# FROM pachyderm/opencv:2.6.0
FROM osrf/ros:humble-desktop-full

# 定义用户和用户组
ARG USERNAME=summer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# 更新包列表并安装必要软件
RUN apt-get update \
    && apt-get install -y net-tools nautilus bash-completion gdb sudo

# 创建用户组和用户
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # 配置用户密码
    && echo "$USERNAME:'" | chpasswd \
    # 允许用户使用 sudo
    && usermod -aG sudo $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo 'source /opt/ros/humble/setup.bash' >> /home/$USERNAME/.bashrc \
    # 使新用户的 .bashrc 文件生效
    && chown $USERNAME:$USERNAME /home/$USERNAME/.bashrc


# 切换到新用户
USER $USERNAME
WORKDIR /home/$USERNAME/opencv

# 切换回 root 用户
USER root

# 复制gitkraken.deb安装包
COPY ./packages/gitkraken-amd64.deb /home/summer/opencv/packages/gitkraken-amd64.deb 

# 更改环境变量（不然会报错）+ 安装gitkraken
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ./packages/gitkraken-amd64.deb

USER $USERNAME

CMD ["/bin/bash"]
