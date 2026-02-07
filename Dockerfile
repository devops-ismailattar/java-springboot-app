FROM maven:3.9.9-eclipse-temurin-17 AS BUILDER

WORKDIR	/app

COPY pom.xml ./

COPY src ./src

RUN mvn -B clean package



#RUNTIME STAGE----------------

FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

COPY --from=BUILDER /app/target/demo-app-1.0.0.jar ./app.jar
COPY --from=BUILDER /app/src/ ./src


EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
