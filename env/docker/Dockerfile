# We use the centos7 base image
FROM centos:7

# All building is done in the /opt directory
WORKDIR /opt
COPY ./deps.sh /opt
COPY ./GHepUtils.cxx /opt
COPY ./gcc-setup.sh /opt

# We run the deps.sh script to install the dependencies
RUN /bin/bash -c "source /opt/deps.sh"