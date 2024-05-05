# Dockerfile
# syntax=docker/dockerfile:1
FROM actiontestscript/linux-base

#Install Latest google-Chrome stable
RUN curl -L -o /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && apt-get update \
  && apt-get install -y /tmp/chrome.deb \
  && rm -rf /tmp/* \
  && apt-get autoremove -y\
  && apt-get clean

#Install Latest firefox stable
RUN apt-get update \
  && apt-get install -y libdbus-glib-1-2 \
  && curl -L -o /tmp/firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=fr" \
  && tar -xjvf /tmp/firefox.tar.bz2 -C /opt/ \
  && ln -s /opt/firefox/firefox /usr/bin/firefox \
  && chmod 755 /usr/bin/firefox \
  && rm -rf /tmp/* \
  && apt-get autoremove -y \
  && apt-get clean 

#Install latest Brave stable
RUN curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" > /etc/apt/sources.list.d/brave-browser-release.list \
  && apt-get update \
  && apt-get install -y brave-browser \
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
  && rm -rf /tmp/* \
  && apt-get remove -y gpg \
  && apt-get autoremove -y \
  && apt-get clean

#install latest opera stable
RUN apt-get update\
  && apt-get install -y gnupg \
  && cd /tmp \
  && curl https://deb.opera.com/archive.key | gpg --dearmor > opera.gpg && install -o root -g root -m 644 opera.gpg /etc/apt/trusted.gpg.d/ \
  && echo "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free" > /etc/apt/sources.list.d/opera-stable.list \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y opera-stable \
  && rm -rf /tmp/* \
  && apt-get remove -y gnupg \
  && apt-get autoremove -y\
  && apt-get clean
  
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install opera-stable

# don t turn when directory linux not in latest version
#RUN curl -L -o /tmp/opera.deb https://download3.operacdn.com/pub/opera/desktop/$(wget -qO- "https://download3.operacdn.com/pub/opera/desktop/" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -n 1)/linux/Opera_$(wget -qO- "https://download3.operacdn.com/pub/opera/desktop/" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -n 1)_amd64.deb 
# && apt-get update 
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y /tmp/opera.deb
#RUN   rm -rf /tmp/* \
#  && apt-get remove -y gpg \
#  && apt-get autoremove -y\
#  && apt-get clean
