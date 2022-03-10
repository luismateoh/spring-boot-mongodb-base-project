FROM gradle AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY build.gradle /workspace
COPY settings.gradle /workspace
COPY src /workspace/src
RUN gradle build -DskipTests


FROM openjdk:8-jdk-alpine as prod
MAINTAINER lucho
COPY --from=build /workspace/build/libs/spring-boot-mongodb-base-project-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
LABEL Name="app.jar"
