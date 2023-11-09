# Build stage
FROM maven:3.8.6-openjdk-11-slim AS build
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package

# Production stage
FROM openjdk:11-jre-slim AS production
WORKDIR /app
COPY --from=build /app/target/*.jar ./app.jar
CMD ["java", "-jar", "app.jar"]
