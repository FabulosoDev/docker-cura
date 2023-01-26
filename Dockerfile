# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-20.04

# Define arguments.
ARG CURA_VERSION

# Install xterm.
RUN add-pkg xterm sudo wget curl sed fuse libegl1

# Create directories.
RUN mkdir -p /usr/share/cura
RUN mkdir /storage
RUN mkdir /output
RUN chmod 777 /output

# Download Ultimaker Cura AppImage by CURA_VERSION.
RUN wget -O /usr/share/cura/Ultimaker_Cura.AppImage $(curl -s https://api.github.com/repos/Ultimaker/Cura/releases | grep browser_download_url | grep $CURA_VERSION'.AppImage' | head -n 1 | cut -d '"' -f 4)
RUN chmod a+x /usr/share/cura/Ultimaker_Cura.AppImage

# Copy the start script.
COPY startapp.sh /startapp.sh

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/storage"]
VOLUME ["/output"]

# Metadata.
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="Ultimaker Cura"
LABEL org.label-schema.description="Docker container for Ultimaker Cura"
LABEL org.label-schema.vcs-url="https://github.com/FabulosoDev/docker-cura"
LABEL org.label-schema.version=$CURA_VERSION

# Set the window name so full screen plugins (like Thingibrowser) can be closed
RUN sed-patch 's/<application type="normal">/<application type="normal" title="Ultimaker Cura">/' /etc/xdg/openbox/rc.xml

# Set the name of the application.
ENV APP_NAME="Ultimaker Cura"
