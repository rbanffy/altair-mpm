FROM debian:testing-slim

LABEL maintainer="Ricardo Bánffy <rbanffy@gmail.com>"

ARG USERNAME=mpm
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ARG TARGETARCH

COPY *.dsk mpm-docker /

RUN DEBIAN_FRONTEND=noninteractive \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends simh unzip && \
    cd /home/$USERNAME && \
    # Bring the disk images and simh config into the user's home directory.
    mv -v /*.dsk /mpm-docker . && \
    # Remove unwanted files.
    apt purge -y wget unzip && \
    apt -y autoremove && \
    rm -rf /var/lib/apt/lists/* mpm.zip mpm && \
    chown -R $USERNAME:$USERNAME /home/$USERNAME && \
    ls -lha .

USER $USERNAME
WORKDIR /home/$USERNAME

EXPOSE 8823/TCP

CMD ["altairz80", "mpm-docker"]