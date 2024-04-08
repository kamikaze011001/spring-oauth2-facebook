FROM maven as build
WORKDIR /app
COPY pom.xml /app/pom.xml
COPY src /app/src
RUN mvn clean install

FROM openjdk:8-slim
COPY --from=build app/target/ProductManager*.jar .
RUN mv ./ProductManager*.jar  ./ProductManager.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]