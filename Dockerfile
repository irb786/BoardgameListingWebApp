FROM openjdk:21-ea-17-slim-bullseye

EXPOSE 8080

ENV APP_HOME /usr/src/app

COPY target/*.jar $APP_HOME/app.jar

WORKDIR $APP_HOME

ENTRYPOINT exec java -jar app.jar
