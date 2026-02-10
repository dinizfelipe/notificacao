# ========================
# BUILD
# ========================
FROM gradle:9.3.0-jdk17 AS build
WORKDIR /app
COPY . .
RUN gradle clean build --no-daemon -x test

# ========================
# RUNTIME
# ========================
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

COPY --from=build /app/build/libs/*.jar /app/notificacao.jar

EXPOSE 8082

CMD ["java", "-jar", "/app/notificacao.jar"]
