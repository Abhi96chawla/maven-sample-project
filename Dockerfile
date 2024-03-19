FROM tomcat:9.0-jdk17-openjdk-slim AS build
WORKDIR /usr/local/tomcat/webapps/
ADD pom.xml .
COPY . .

# Build the Maven project
RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package
EXPOSE 8000
CMD ["catalina.sh", "run"]
