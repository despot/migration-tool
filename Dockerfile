FROM openjdk:11-jre
ADD target/migration-tool-1.0-SNAPSHOT.jar app.jar
EXPOSE 1111
EXPOSE 2222
# ENTRYPOINT ["java","-jar","/app.jar","country"]
