FROM fedora:40
RUN dnf install -y git-2.45.2-2.fc40.x86_64 wget2-2.1.0-9.fc40.x86_64 sqlite-3.45.1-2.fc40.x86_64 hdf5-
1.12.1-15.fc40.x86_64 gnupg2-2.4.4-1.fc40.x86_64
RUN dnf install -y python3-3.12.3-2.fc40.x86_64 python3-pip-23.3.2-1.fc40.noarch python3-datalad-1.0.1-
1.fc40.noarch
RUN dnf install -y just-1.25.2-1.fc40.x86_64
RUN dnf install -y vim

ARG user=researcher
ARG group=researcher
ARG uid=1000
ARG gid=1000
RUN groupadd -g ${gid} ${group}
RUN useradd -u ${uid} -g ${group} -m ${user}

# Switch to user
USER ${uid}:${gid}

WORKDIR /home/${user}

RUN pip3 install numpy==2.1.1 matplotlib==3.9.0 pyerrors==2.12.0 ipykernel==6.29.4 pyyaml==6.0.1
