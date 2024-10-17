FROM maven:3.8-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mkdir -p ~/.m2
COPY settings.xml ~/.m2/
RUN mvn clean package -DskipTests
RUN mvn clean package -DskipTests -f chat2db-server/pom.xml

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/chat2db-server/target/*.jar ./
EXPOSE 8080
HEALTHCHECK CMD curl --fail http://localhost:8080/actuator/health || exit 1
CMD ["java", "-jar", "chat2db-server-web-start.jar"]
