FROM maven:3.8-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mkdir -p ~/.m2
COPY settings.xml ~/.m2/
RUN mvn clean package -DskipTests -f chat2db-server/pom.xml

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/chat2db-server/chat2db-server-web-start/target/*.jar ./
EXPOSE 8080
CMD ["java", "-jar", "chat2db-server-web-start.jar"]
