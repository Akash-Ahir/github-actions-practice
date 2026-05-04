FROM eclipse-temurin:21-jdk-jammy AS builder
WORKDIR /app
COPY . .
RUN chmod +x mvnw && ./mvnw clean package -DskipTests -B
From eclipse-temurin:21-jdk-jammy
WORKDIR /app
RUN groupadd -r devsecops && useradd -r -g devsecops devsecops
USER devsecops
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
