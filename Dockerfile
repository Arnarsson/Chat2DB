FROM maven:3.8-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/chat2db-server/target/chat2db-server-1.0.0.jar .
EXPOSE 3000
CMD ["java", "-jar", "chat2db-server-1.0.0.jar"]
