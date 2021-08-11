#FROM openjdk:8-alpine

#COPY C:\Program Files (x86)\Jenkins\workspace\Qpathways Services\target\otc-0.0.2-SNAPSHOT otcservice.jar
#EXPOSE 80/tcp
#ENTRYPOINT ["java","-jar","otcservice.jar"]


FROM maven:3.5-jdk-8-slim AS build
WORKDIR /home/app
COPY src /home/app/src

COPY pom.xml /home/app/

RUN mvn clean package -DskipTests 

FROM openjdk:8-alpine
COPY --from=0 /home/app/target/otc.jar /tmp/otcservice.jar

#COPY --from=build /home/app/target/otc-0.0.2-SNAPSHOT.jar /tmp/otcservice.jar

EXPOSE 80/tcp
ENTRYPOINT ["java","-jar","/tmp/otcservice.jar"]

