FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn package && \
    cp target/java-server-*-jar-with-dependencies.jar app.jar


FROM eclipse-temurin:17-jre

WORKDIR /app

COPY docker-entrypoint.sh .

RUN chmod +x docker-entrypoint.sh

USER 65534

COPY --from=build /app/app.jar /app/app.jar

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["java", "-jar", "app.jar"]




