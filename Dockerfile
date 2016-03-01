FROM ubuntu:15.04

RUN apt-get update

# Misc libraries
RUN apt-get install -y wget curl git xvfb build-essential libavahi-compat-libdnssd-dev libbluetooth-dev libnotify-bin software-properties-common python-software-properties

# Python
RUN apt-get install -y python python-dev python-pip python-virtualenv

# Nodejs
RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get install -y nodejs

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

# Ruby
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get install -y ruby2.1 ruby2.1-dev
RUN gem install bundler
RUN touch /var/lib/jenkins/init.feetme

RUN chown -R jenkins.jenkins /var/lib/jenkins

# Because I don't know how to install ruby for a specific user...
RUN usermod -G root jenkins
RUN chmod -R 775 /usr/local/bin
RUN chmod -R 775 /var/lib/gems

RUN rm -rf /var/lib/apt/lists/*

ENV ENV feature

VOLUME /var/lib/jenkins

EXPOSE 8080

CMD service jenkins start && tail -F /var/log/jenkins/jenkins.log
