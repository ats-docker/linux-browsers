# Dockerfile
# syntax=docker/dockerfile:1
FROM actiontestscript/linux-base

#Install Latest google-Chrome stable
RUN wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && apt-get update \
  && apt-get install -y /tmp/chrome.deb \
  && mv /usr/bin/google-chrome /usr/bin/google-chrome-ok \
  && echo '#!/bin/bash\nif [[ "$@" == *"--version"* ]]; then\n/usr/bin/google-chrome-ok --version\nelif [[ "$@" == *"--help"* ]]; then\n/usr/bin/google-chrome-ok --help\nelse  /usr/bin/google-chrome-ok --disable-gpu --headless --no-sandbox --disable-dev-shm-usage "$@"\nfi' > /usr/bin/google-chrome \
  && chmod +x /usr/bin/google-chrome \
  && rm -rf /tmp/* \
  && apt-get autoremove -y\
  && apt-get clean

#Install Latest firefox stable
RUN apt-get update \
  && apt-get install -y libdbus-glib-1-2 \
  #libgtk-3-dev libasound2-dev \
  && wget -O /tmp/firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=fr" \
  && tar -xjvf /tmp/firefox.tar.bz2 -C /opt/ \
  && ln -s /opt/firefox/firefox /usr/bin/firefox \
  && chmod 755 /usr/bin/firefox \
  && rm -rf /tmp/* \
  && apt-get autoremove -y\
  && apt-get clean

#Install latest Brave stable
RUN curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" > /etc/apt/sources.list.d/brave-browser-release.list \
  && apt-get update \
  && apt-get install -y brave-browser \
  && mv /usr/bin/brave-browser /usr/bin/brave-browser-ok \
  && echo '#!/bin/bash\nif [[ "$@" == *"--version"* ]]; then\n/usr/bin/brave-browser-ok --version\nelif [[ "$@" == *"--help"* ]]; then\n/usr/bin/brave-browser-ok --help\nelse  /usr/bin/brave-browser-ok --disable-gpu --headless --no-sandbox --disable-dev-shm-usage "$@"\nfi' > /usr/bin/brave-browser \
  && chmod +x /usr/bin/brave-browser \
  && rm -rf /tmp/* \
  && apt-get autoremove -y\
  && apt-get clean

#Install latest microsoft edge stable
RUN apt-get update \
  && apt-get install -y gpg \
  && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg  && install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ \
  && echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list \
  && apt-get update \
  && apt-get install -y microsoft-edge-stable \
  && mv /usr/bin/microsoft-edge /usr/bin/microsoft-edge-ok \
  && echo '#!/bin/bash\nif [[ "$@" == *"--version"* ]]; then\n/usr/bin/microsoft-edge-ok --version\nelif [[ "$@" == *"--help"* ]]; then\n/usr/bin/microsoft-edge-ok --help\nelse  /usr/bin/microsoft-edge-ok --disable-gpu --headless --no-sandbox --disable-dev-shm-usage "$@"\nfi' > /usr/bin/microsoft-edge \
  && chmod +x /usr/bin/microsoft-edge \
  && rm -rf /tmp/* \
  && apt-get remove -y gpg \
  && apt-get autoremove -y \
  && apt-get clean

#install latest opera stable
RUN wget -O /tmp/opera.deb https://download3.operacdn.com/pub/opera/desktop/$(wget -qO- "https://download3.operacdn.com/pub/opera/desktop/" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -n 1)/linux/Opera_$(wget -qO- "https://download3.operacdn.com/pub/opera/desktop/" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -n 1)_amd64.deb \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y /tmp/opera.deb\
  && mv /usr/bin/opera /usr/bin/opera-ok \
  && echo '#!/bin/bash\nif [[ "$@" == *"--version"* ]]; then\n/usr/bin/opera-ok --version\nelif [[ "$@" == *"--help"* ]]; then\n/usr/bin/opera-ok --help\nelse  /usr/bin/opera-ok --disable-gpu --headless --no-sandbox --disable-dev-shm-usage "$@"\nfi' > /usr/bin/opera \
  && chmod +x /usr/bin/opera \
  && rm -rf /tmp/* \
  && apt-get autoremove -y\
  && apt-get clean