# FROM tomcat:9.0-jdk17-openjdk-slim AS build

# ADD pom.xml .
# #COPY . .

# # Build the Maven project
# RUN apt-get update && \
#     apt-get install -y maven && \
#     mvn clean package
# #COPY /usr/local/tomcat/target/* /usr/local/tomcat/webapps/
# EXPOSE 8000
# CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]


# FROM openjdk:8


# ADD pom.xml .
# RUN apt-get update && \
#     apt-get install -y maven && \
#     mvn clean package
    
# #ADD target/javaparser-maven-sample-1.0-SNAPSHOT.jar javaparser-maven-sample-1.0-SNAPSHOT.jar
# #ADD target/javaparser-maven-sample-1.0-SNAPSHOT-shaded.jar javaparser-maven-sample-1.0-SNAPSHOT-shaded.jar
# #ENTRYPOINT ["java", "-jar","javaparser-maven-sample-1.0-SNAPSHOT.jar"]
# EXPOSE 8000


FROM maven:3.8.5-openjdk-17 as builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ ./src/
RUN mvn clean package -DskipTests=true

FROM eclipse-temurin:17-jdk-alpine as prod
RUN mkdir /app
COPY --from=builder /app/target/*.jar /app/app.jar
ENV SERVER_PORT=6060
WORKDIR /app
EXPOSE 6060
ENTRYPOINT ["java","-jar","/app.jar"]
