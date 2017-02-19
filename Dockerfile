FROM openhab/openhab:2.1.0-snapshot-amd64

# Install Addon Packages

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      hping3 \
      perl \
      liblwp-protocol-https-perl \
      libjson-perl \
      libgetopt-long-descriptive-perl \
      && rm -rf /var/lib/apt/lists/*

# Expose volume with configuration and userdata dir
VOLUME ${APPDIR}/conf ${APPDIR}/userdata ${APPDIR}/addons

# Execute command
WORKDIR ${APPDIR}
EXPOSE 8080 8443 5555
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD
