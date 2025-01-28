FROM ubuntu:latest

LABEL maintainer="@lr-m"

# Combine timezone settings
RUN echo "Europe/London" > /etc/timezone && \
    echo "tzdata tzdata/Areas select Europe" | debconf-set-selections && \
    echo "tzdata tzdata/Zones/Europe select London" | debconf-set-selections

# Install system packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    bison \
    build-essential \
    curl \
    flex \
    g++ \
    gcc \
    git \
    make \
    python3 \
    python3-pip \
    software-properties-common \
    unzip \
    wget \
    xvfb && \
    add-apt-repository ppa:openjdk-r/ppa -y && \
    apt-get update && \
    apt-get install -y openjdk-21-jdk && \
    rm -rf /var/lib/apt/lists/*

# Set up Gradle in system location first
RUN mkdir -p /opt/gradle && \
    wget https://services.gradle.org/distributions/gradle-8.5-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-*.zip && \
    rm /tmp/gradle-*.zip && \
    chmod -R 755 /opt/gradle

ENV GRADLE_HOME=/opt/gradle/gradle-8.5
ENV PATH=$GRADLE_HOME/bin:$PATH

# Create user
RUN groupadd -g 1001 dockerbot && useradd -g 1001 -u 1001 -m dockerbot

# Switch to dockerbot user
USER dockerbot

# Set up gradle configuration for user
RUN mkdir -p $HOME/.gradle/init.d/ && \
    echo "\
ext.HOME = System.getProperty('user.home')\n\
\n\
allprojects {\n\
 repositories {\n\
 mavenCentral()\n\
 jcenter()\n\
 flatDir name:'flat', dirs:[\"$HOME/flatRepo\"]\n\
 }\n\
}\n\
" > $HOME/.gradle/init.d/repos.gradle