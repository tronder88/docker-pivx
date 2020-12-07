#
# Pivx Dockerfile
#

# Pull base image.
FROM dockerfile/ubuntu

ENV PIVX_USER=pivx
ENV PIVX_CONF=/home/$PIVX_USER/.pivx/pivx.conf

# Install Pivx.
RUN \
  add-apt-repository -y ppa:pivx/pivx && \
  apt-get update && \
  apt-get install -y pivx && \
  rm -rf /var/lib/apt/lists/* && \
  adduser --uid 1000 --system ${PIVX_USER} && \
  mkdir -p /home/${PIVX_USER}/.pivx/ && \
  chown -R ${PIVX_USER} /home/${PIVX_USER} && \
  echo "success: $PIVX_CONF"

# Define mountable directories.

USER pivx
RUN echo "rpcuser=pivx" > ${PIVX_CONF} && \
        echo "rpcpassword=`pwgen 32 1`" >> ${PIVX_CONF} && \
        echo "Success"

EXPOSE 51472

VOLUME ["/home/pivx/.pivx"]

WORKDIR /home/pivx

ENTRYPOINT ["/usr/local/bin/pivxd"]
