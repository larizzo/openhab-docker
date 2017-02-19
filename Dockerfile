FROM openhab/openhab:2.1.0-snapshot-amd64

# Set variables
ENV OPENHAB_VERSION="2.1.0-snapshot"
ENV \
    APPDIR="/openhab" \
    DEBIAN_FRONTEND=noninteractive \
    EXTRA_JAVA_OPTS="" \
    JAVA_HOME='/usr/lib/java-8' \
    OPENHAB_HTTP_PORT="8080" \
    OPENHAB_HTTPS_PORT="8443"

# Set locales
ENV \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

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
CMD ["gosu", "openhab", "./start.sh"]
