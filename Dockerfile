FROM mcr.microsoft.com/devcontainers/base:jammy
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install git software-properties-common wget libffi-dev sqlite3 h5utils gnupg2 libsqlite3-dev
# install python 3.11.6
RUN wget https://www.python.org/ftp/python/3.11.6/Python-3.11.6.tar.xz
RUN tar -xf Python-3.11.6.tar.xz
RUN cd Python-3.11.6 && ./configure --enable-optimizations && make install && cd ..
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3 get-pip.py
#install git-annex
RUN cp /etc/apt/sources.list /etc/apt/sources.list~
RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt-get update
RUN apt-get build-dep -y git-annex
RUN cabal update
RUN git clone git://git-annex.branchable.com/ git-annex
RUN cd git-annex && make install PREFIX=/usr/local && cd ..
# install just
RUN wget -qO - 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
# update
RUN apt-get update
RUN apt upgrade -y
RUN apt-get -y install just
# install additional packages
RUN pip install pyyaml datalad ipykernel pyerrors
