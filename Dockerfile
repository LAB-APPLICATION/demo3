FROM xldevops/jdk17-alpine
ENV java_opts=""
ENV java_args=""
LABEL maintainer="Ahmad Zulfadli"
WORKDIR /app
COPY target/*.jar /app/app.jar
# ADD --chmod=755 https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v2.17.0/opentelemetry-javaagent.jar .
# ENV JAVA_TOOL_OPTIONS "-javaagent:./opentelemetry-javaagent.jar"
ENTRYPOINT exec java $java_opts -jar app.jar $java_args
EXPOSE 8080