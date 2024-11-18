FROM openjdk:17-alpine
EXPOSE 8085
COPY target/spring-boot-docker.jar spring-boot-docker.jar
ENTRYPOINT ["java","-jar","/spring-boot-docker.jar"]