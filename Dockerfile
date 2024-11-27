FROM openjdk:17-alpine


RUN mvn clean install -DskipTests
# Docker Build Stage
FROM eclipse-temurin:17-jdk-alpine
COPY target/spring-boot-docker.jar spring-boot-docker.jar


EXPOSE 8085

ENTRYPOINT ["java","-jar","-Dserver.port=8085","/spring-boot-docker.jar"]