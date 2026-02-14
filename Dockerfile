FROM xldevops/jdk17-alpine
ENV java_opts=""
ENV java_args=""
LABEL maintainer="Ahmad Zulfadli"
WORKDIR /app
COPY target/*.jar /app/app.jar
ENTRYPOINT exec java $java_opts -jar app.jar $java_args
EXPOSE 8080