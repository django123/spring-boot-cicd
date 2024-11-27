FROM openjdk:17-alpine


RUN mvn clean install -DskipTests
# Docker Build Stage
FROM eclipse-temurin:17-jdk-alpine
COPY target/spring-boot-docker.jar spring-boot-docker.jar

ENV PORT 8085
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Dserver.port=${PORT}","/spring-boot-docker.jar"]