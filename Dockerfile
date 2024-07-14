FROM rbanffy/simh-base:latest

LABEL maintainer="Ricardo Bánffy <rbanffy@gmail.com>"

ARG USERNAME=mpm
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ARG TARGETARCH

COPY *.dsk mpm-docker /

RUN DEBIAN_FRONTEND=noninteractive \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    cd /home/$USERNAME && \
    # Bring the disk images and simh config into the user's home directory.
    mv -v /*.dsk /mpm-docker . && \
    chown -R $USERNAME:$USERNAME /home/$USERNAME && \
    ls -lha .

USER $USERNAME
WORKDIR /home/$USERNAME

EXPOSE 8823/TCP

CMD ["altairz80", "mpm-docker"]