FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
RUN echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure -p critical dash

RUN apt-get update && apt-get install -y \
        gawk wget git-core diffstat unzip texinfo gcc-multilib \
        build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
        xz-utils debianutils python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev python3-subunit mesa-common-dev \
        libsdl1.2-dev xterm curl locales iputils-ping \
        openjdk-8-jdk flex bison antlr3 libantlr3c-dev maven python3-dev \
        libcurl4 screen xvfb zstd liblz4-tool ostree ostree-push file \
        cython3 libjson-c-dev libcurl4-openssl-dev libacl1 libgnutls28-dev

RUN pip3 install toml click dicttoxml pyyaml \
         build mypy==0.910 types-setuptools pylint==2.9.3 typing-extensions==4.3.0 packaging==20.9 pyparsing==2.3.1 cython==3.0.2

RUN wget -qO - https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key | apt-key add -
RUN echo "deb https://releases.jfrog.io/artifactory/jfrog-debs focal contrib" | tee -a /etc/apt/sources.list;
RUN apt-get update && apt install -y jfrog-cli

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo

RUN locale-gen en_US.UTF-8 && \
        update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

RUN mkdir -p /home/worker && \
    mkdir -p /home/worker/building && \
    echo "worker:x:1000:1000:worker,,,:/home/worker:/bin/bash" >> /etc/passwd && \
    echo "worker:x:1000:" >> /etc/group && \
    echo "worker ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && \
    chown worker:worker -R /home/worker

RUN ln -sfn /usr/share/zoneinfo/Asia/Kolkata /etc/localtime

USER worker
ENV HOME /home/worker
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"
WORKDIR /home/worker/building
CMD /bin/bash
