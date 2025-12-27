# =====================
# Pre Stage
# =====================

#  mvn -N wrapper:wrapper

# =====================
# Build Stage
# =====================
FROM --platform=linux/amd64 ghcr.io/graalvm/graalvm-community:21.0.2-ol9-20240116 AS build-aot

RUN microdnf install -y unzip zip gzip curl

ENV TZ=Asia/Jakarta
ENV MAVEN_OPTS="-Xmx8g"

WORKDIR /app

COPY .mvn .mvn
COPY mvnw .
RUN chmod +x mvnw

COPY pom.xml .
RUN ./mvnw -B -DskipTests dependency:go-offline

COPY src ./src

RUN ./mvnw clean package -Pnative -DskipTests


# =====================
# Runtime Stage
# =====================
FROM --platform=linux/amd64 alpine:3.19
RUN apk add --no-cache gcompat libstdc++ zlib
RUN addgroup -g 1000 spring && adduser -u 1000 -G spring -s /bin/sh -D spring

ENV TZ=Asia/Jakarta

WORKDIR /app
COPY --from=build-aot --chown=spring:spring /app/target/demo ./app

USER spring
EXPOSE 8080
ENTRYPOINT ["./app"]
