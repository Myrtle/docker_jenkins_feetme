FROM ubuntu:15.04

RUN apt-get update

# Misc libraries
RUN apt-get install -y wget curl git xvfb build-essential libavahi-compat-libdnssd-dev libbluetooth-dev libnotify-bin software-properties-common python-software-properties

# Python
RUN apt-get install -y python python-dev python-pip python-virtualenv

# Nodejs
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash

# Jenkins
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" >> /etc/apt/sources.list
RUN apt-key update
RUN apt-get update
RUN apt-get install -y jenkins

# Lettuce & Selenium
RUN pip install lettuce==0.2.21
RUN pip install selenium==2.52.0
RUN pip install --upgrade six>=1.70

# Chromium
RUN apt-get install -y chromium-browser

RUN apt-get install -y patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev

RUN touch /var/lib/jenkins/init.feetme

RUN chown -R jenkins.jenkins /var/lib/jenkins

# Android SDK
RUN cd /opt && wget -q https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN cd /opt && tar xzf android-sdk_r24.4.1-linux.tgz
RUN cd /opt && rm -f android-sdk_r24.4.1-linux.tgz
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
RUN echo "y" | android update sdk --all --filter platform-tools --no-ui --force
RUN echo "y" | android update sdk --all --filter android-23 --no-ui --force
RUN echo "y" | android update sdk --all --filter build-tools-23.0.2 --no-ui --force
RUN echo "y" | android update sdk --all --filter extra-android-m2repository --no-ui --force
RUN echo "y" | android update sdk --all --filter extra-android-support --no-ui --force
RUN echo "y" | android update sdk --all --filter extra-google-google_play_services --no-ui --force
RUN echo "y" | android update sdk --all --filter extra-google-m2repository --no-ui --force

RUN gem install calabash-android

RUN apt-get install -y lib32stdc++6 lib32z1
RUN chown -R jenkins.jenkins /opt/android-sdk-linux

# JAVA 8
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk

# AWS CLI
RUN pip install awscli

# Scipy & Numpy
RUN apt-get install -y python-numpy python-scipy
RUN apt-get install -y python-crypto

#PyTest
RUN pip install pytest

RUN rm -rf /var/lib/apt/lists/*

ENV ENV feature

VOLUME /var/lib/jenkins

EXPOSE 8080

CMD service jenkins start && tail -F /var/log/jenkins/jenkins.log
