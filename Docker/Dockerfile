FROM jlesage/baseimage-gui:debian-11-v3.5.8

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=

# Metadata.
LABEL \
  org.label-schema.name="MadreSteam" \
  org.label-schema.description="Docker container for playing Steam" \
  org.label-schema.version="${DOCKER_IMAGE_VERSION:-unknown}" \
  org.label-schema.vcs-url="https://github.com/akrista/madrestam" \
  org.label-schema.schema-version="1.0"

ENV APP_NAME="MadreSteam" \
  DARK_MODE=1 \
  XDG_CACHE_HOME=/steam/xdg/cache \
  XDG_CONFIG_HOME=/steam/xdg/config \
  XDG_DATA_HOME=/steam/xdg/data \
  XDG_RUNTIME_DIR=/tmp/run/user/app

# Generate and install favicons.
RUN \
  APP_ICON_URL=https://raw.githubusercontent.com/Akrista/madresteam/master/Docker_Original.svg && \
  install_app_icon.sh "$APP_ICON_URL"

RUN echo "========== Updating Packages ==========" && \
  set -x && \
  dpkg --add-architecture i386 && \
  apt-get update -y && \
  apt-get install -y --no-install-recommends \
  sudo \
  xterm \
  curl

RUN echo "========== Setup sudoers ==========" && \
  echo "app    ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN echo "========== Installing Dependencies ==========" && \
  apt-get install -y --no-install-recommends \
  make \
  gnupg \
  xz-utils \
  libc6-i386 \
  libgl1:i386 \
  libxtst6:i386 \
  libxrandr2:i386 \
  libglib2.0-0:i386 \
  libgtk2.0-0:i386 \
  libpulse0:i386 \
  libva2:i386 \
  libbz2-1.0:i386 \
  libvdpau1:i386 \
  libva-x11-2:i386 \
  libcurl4-gnutls-dev:i386 \
  libopenal1:i386 \
  libsm6:i386 \
  libice6:i386 \
  libasound2-plugins:i386 \
  libsdl2-image-2.0-0:i386 \
  dbus \
  dbus-x11 \
  file \
  pulseaudio \
  pciutils \
  zenity

RUN echo "========== Installing sTEAM ==========" && \
  mkdir -p /src && \
  cd /src && \
  curl -O http://repo.steampowered.com/steam/archive/precise/steam_latest.tar.gz && \
  tar xzvf steam_latest.tar.gz && \
  cd /src/steam-launcher && \
  make install

RUN echo "========== Clean up ==========" && \
  rm /var/lib/dpkg/statoverride && \
  apt-get remove -y make && \
  apt-get autoremove -y && \
  rm -rf /tmp/* && \
  rm -rf /var/lib/apt/lists/*

COPY rootfs/ /

# Define mountable directories.
VOLUME ["/steam"]