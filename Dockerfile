FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install curl unzip wget expect openjdk-8-jdk -y

ENV ANDROID_HOME /opt/android-sdk-linux
# See: https://developer.android.com/studio/index.html
ENV ANDROID_SDK_ZIP_FILE sdk-tools-linux-3859397.zip

RUN mkdir -p ${ANDROID_HOME}
RUN wget -q https://dl.google.com/android/repository/${ANDROID_SDK_ZIP_FILE} -P ${ANDROID_HOME}
RUN cd ${ANDROID_HOME}; unzip ${ANDROID_SDK_ZIP_FILE}
RUN chmod -R 775 ${ANDROID_HOME}
RUN rm -f ${ANDROID_HOME}/${ANDROID_SDK_ZIP_FILE}

ENV PATH $PATH:$ANDROID_HOME/tools/bin
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/emulator

ADD package_file /tmp/package_file
ADD ./tools/expectable-sdkmanager /usr/local/bin/expectable-sdkmanager

RUN expectable-sdkmanager --package_file=/tmp/package_file --sdk_root=$ANDROID_HOME
