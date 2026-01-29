#-------------Stage 1---3.9.4--------------
FROM maven:3.9.8-eclipse-temurin-21-slim AS builder

WORKDIR /src

COPY . /src

#This Maven flag skips running unit/integration tests during mvn clean install
RUN mvn clean install -DskipTests=true

#-------------Stage 2-----------------
FROM gcr.io/distroless/java21-debian12  

# jar will get after /src build
COPY --from=builder /src/target/*.jar /src/target/bankapp.jar   

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/src/target/bankapp.jar"]
