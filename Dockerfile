FROM tomcat:9.0-jdk17-openjdk-slim AS build

ADD pom.xml .
#COPY . .

# Build the Maven project
RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package
#COPY /usr/local/tomcat/target/* /usr/local/tomcat/webapps/
EXPOSE 8000
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]


FROM openjdk:8
ADD pom.xml .
RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package
    
ADD target/javaparser-maven-sample-1.0-SNAPSHOT.jar javaparser-maven-sample-1.0-SNAPSHOT.jar
ADD target/javaparser-maven-sample-1.0-SNAPSHOT-shaded.jar javaparser-maven-sample-1.0-SNAPSHOT-shaded.jar
ENTRYPOINT ["java", "-jar","javaparser-maven-sample-1.0-SNAPSHOT.jar"]
EXPOSE 8000
