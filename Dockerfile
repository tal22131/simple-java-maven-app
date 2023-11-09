# Build stage
FROM maven:3.8.6-openjdk-11-slim AS build
WORKDIR /app
COPY ./src /app
COPY pom.xml /app
RUN mvn package

# Production stage
FROM adoptopenjdk:11-jre-hotspot
WORKDIR /app
COPY --from=build /app/target/*.jar /app/my-app.jar
CMD ["java", "-jar", "my-app.jar"]

