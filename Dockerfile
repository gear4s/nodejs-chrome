FROM node:20-slim as node

# Installs latest Chromium package.
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && (dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install; rm google-chrome-stable_current_amd64.deb; apt-get clean; rm -rf /var/lib/apt/lists/* ) \
    && mv /usr/bin/google-chrome /usr/bin/google-chrome.real  \
    && mv /opt/google/chrome/chrome /opt/google/chrome/google-chrome.real  \
    && rm /etc/alternatives/google-chrome \
    && ln -s /opt/google/chrome/google-chrome.real /etc/alternatives/google-chrome \
    && ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome \
    && ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser \
    && ln -s /usr/lib/x86_64-linux-gnu/libOSMesa.so.6 /opt/google/chrome/libosmesa.so


COPY local.conf /etc/fonts/local.conf

# Add Chrome as a user
RUN mkdir -p /usr/src/app \
    && adduser --disabled-password chrome \
    && chown -R chrome:chrome /usr/src/app
# Run Chrome as non-privileged
USER chrome
WORKDIR /usr/src/app

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

# Autorun chrome headless
ENV CHROMIUM_FLAGS="--disable-software-rasterizer --disable-dev-shm-usage"
