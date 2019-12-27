FROM ubuntu:18.04
LABEL name=chips-base

# Install chips-base software requirements using apt
RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    apt-get update && add-apt-repository universe && \
    apt-get install -y --no-install-recommends libgsl-dev wget tar git dpkg-dev \
        cmake g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev python-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install chips-base software using the setup.sh script
COPY setup.sh /opt
RUN chmod +x /opt/setup.sh && ./opt/setup.sh

# When the container is run we call the start script
COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh
ENTRYPOINT ["start.sh"]
    