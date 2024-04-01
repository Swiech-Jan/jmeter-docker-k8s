# Use an OpenJDK image
FROM openjdk:8-jdk

# Set environment variables for JMeter version
ENV JMETER_VERSION 5.6.2

# Install wget, unzip, and nano
RUN apt-get update && \
    apt-get -y install wget unzip nano && \
    apt-get clean

# Download and Extract JMeter
RUN wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz && \
    tar -xzf apache-jmeter-${JMETER_VERSION}.tgz -C /opt && \
    rm apache-jmeter-${JMETER_VERSION}.tgz

# Set JMeter Home
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV PATH $JMETER_HOME/bin:$PATH

# Customize JVM arguments for JMeter, adjusting heap size
ENV JVM_ARGS="-Xms2g -Xmx2g -XX:MaxMetaspaceSize=256m"

# Copy your JMeter test script into the container
COPY ./scripts/loadScript.jmx /scripts/loadScript.jmx

# Copy your CSV Data Set Config into the container
COPY ./scripts-config/config.csv /scripts-config/config.csv

# Define volume for results
VOLUME /results

# Start container with a Bash shell
ENTRYPOINT ["/bin/bash"]

