#FROM openjdk:17-alpine


#RUN mvn clean install -DskipTests


#COPY target/spring-boot-docker.jar spring-boot-docker.jar


#EXPOSE 8085

#ENTRYPOINT ["java","-jar","-Dserver.port=8085","/spring-boot-docker.jar"]


# Docker Build Stage
FROM maven:3-eclipse-temurin-17-alpine AS build


# Build Stage
WORKDIR /opt/app

COPY ./ /opt/app
RUN mvn clean install -DskipTests



# Docker Build Stage
FROM eclipse-temurin:17-jdk-alpine

COPY --from=build /opt/app/target/*.jar spring-boot-docker.jar

ENV PORT 8081
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Xmx1024M","-Dserver.port=${PORT}","spring-boot-docker.jar"]