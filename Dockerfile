# Stage 1: build the JAR with Gradle on a full JDK
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copy Gradle files first so dependencies are cached between builds
COPY gradlew settings.gradle build.gradle ./
COPY gradle ./gradle
RUN chmod +x gradlew && ./gradlew dependencies --no-daemon > /dev/null

COPY src ./src
RUN ./gradlew bootJar --no-daemon -x test

# Stage 2: small runtime image with only the JRE and the JAR
FROM eclipse-temurin:21-jre
LABEL maintainer="Kim Vladislav" \
      org.opencontainers.image.title="kim-vladislav-student-api"
WORKDIR /app

RUN useradd --system --uid 1001 spring
COPY --from=build /app/build/libs/kim-vladislav-student-api.jar app.jar
USER spring

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
