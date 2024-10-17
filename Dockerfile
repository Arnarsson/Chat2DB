FROM maven:3.8-openjdk-17 AS build
WORKDIR /app

# Copy project files
COPY . .

# Use custom Maven settings to handle mirrors and timeout settings
COPY settings.xml /root/.m2/settings.xml

# Install dependencies first to cache them
RUN mvn dependency:go-offline -B

# Run the build with skip tests to save time
RUN mvn clean package -DskipTests -X

# Use a slim JDK for running the application
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy the built jar file from the build stage
COPY --from=build /app/chat2db-server/target/chat2db-server-1.0.0.jar .

# Expose the port
EXPOSE 3000

# Command to run the application
CMD ["java", "-jar", "chat2db-server-1.0.0.jar"]
