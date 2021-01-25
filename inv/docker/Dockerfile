FROM ubuntu:16.04
RUN apt-get update && apt-get install -y \
        git build-essential libsdl1.2-dev texinfo gawk chrpath diffstat

RUN apt-get install -y \
        python3-minimal
RUN apt-get install -y \
        python3
RUN apt-get install -y \
        sudo \
        cpio \
        wget \
        locales

RUN apt-get install -y \
        vim

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8   


ARG user
ARG uid
ARG guid

ENV ACCOUNT $user
ENV GUID $guid
ENV UID $uid
RUN groupadd -f -r -g $guid $user
RUN useradd $user -l -u $uid -g $guid -d /home/$user -m -s /bin/bash
# Add user to sudoers
RUN  echo "$ACCOUNT ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers
RUN export http_proxy=http://10.6.141.27:3128
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN apt-get update
RUN apt-get install gcc-6 g++-6 -y
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6


COPY .gitconfig /home/$ACCOUNT/.gitconfig




USER ${user}
