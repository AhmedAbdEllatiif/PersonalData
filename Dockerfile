FROM  arm64v8/ubuntu

# Arguments and environment variables
ARG BUILD_TOOLS_VERSION=30.0.3
ARG PLATFORM_VERSION=33
ARG COMMAND_LINE_VERSION=3.0

# To expose port
EXPOSE 8080

# Installing necessary dependencies
RUN apt update
RUN apt install -y curl git unzip openjdk-8-jdk wget

# Configuring the working directory and user to use
ARG USER=root
USER $USER
WORKDIR /home/$USER

# Prepare environment
ENV ANDROID_HOME Android/sdk
ENV ANDROID_SDK_TOOLS $ANDROID_HOME/tools

# Creating Android directories
RUN mkdir -p $ANDROID_HOME
RUN mkdir -p /root/.android && touch /root/.android/repositories.cfg

# Download Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools $ANDROID_SDK_TOOLS

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git


# Download sdk build tools and platform tools
#WORKDIR $ANDROID_SDK_TOOLS/bin
#RUN yes | ./sdkmanager --licenses
#RUN ./sdkmanager "build-tools;${BUILD_TOOLS_VERSION}" "platform-tools" "platforms;android-${PLATFORM_VERSION}" "sources;android-${PLATFORM_VERSION}"
#RUN ./sdkmanager --install "cmdline-tools;${COMMAND_LINE_VERSION}"

# Setup PATH environment variable
ENV PATH $PATH:/home/$USER/$ANDROID_HOME/platform-tools:/home/$USER/flutter/bin

# Verify the status licenses
RUN yes | flutter doctor --android-licenses

WORKDIR /home/$USER/workspace/

RUN git clone https://github.com/AhmedAbdEllatiif/PersonalData.git

WORKDIR /home/$USER/workspace/PersonalData/

RUN flutter pub get

RUN flutter config --enable-web

#RUN flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080

CMD ["flutter","run", "-d" , "web-server", "--web-hostname", "0.0.0.0","--web-port","8080"]

# Start the adb daemon
#RUN adb start-server

# Prerequisites
#RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget

# Set up new user
#RUN useradd -ms /bin/bash developer
#USER developer
#WORKDIR /home/developer

# Prepare Android directories and system variables
#RUN mkdir -p Android/sdk
#ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
#RUN mkdir -p .android && touch .android/repositories.cfg
#
## Set up Android SDK
#RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
#RUN unzip sdk-tools.zip && rm sdk-tools.zip
#RUN mv tools Android/sdk/tools
#RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
#RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;30.0.3" "patcher;v4" "platform-tools" "platforms;android-33" "sources;android-33"
#ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"
#
## Download Flutter SDK
#RUN git clone https://github.com/flutter/flutter.git
#ENV PATH "$PATH:/home/developer/flutter/bin"
#
## Run basic check to download Dark SDK
#RUN flutter doctor


#FROM  mobiledevops/flutter-sdk-image:3.7.12
#
#WORKDIR /app
#
#COPY . .
#
#RUN flutter pub get
#
#CMD ["run", "-d" , "chrome"]