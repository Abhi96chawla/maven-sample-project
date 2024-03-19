FROM tomcat:9.0-jdk17-openjdk-slim AS build
WORKDIR /usr/local/tomcat/webapps/
ADD pom.xml .
#COPY . .

# Build the Maven project
RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package
COPY /usr/local/tomcat/target/* /usr/local/tomcat/webapps/
EXPOSE 8000
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
