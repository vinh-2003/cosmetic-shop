FROM openjdk:21

COPY target/cosmetic-shop-0.0.1-SNAPSHOT.jar cosmetic-shop-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java", "-jar", "/cosmetic-shop-0.0.1-SNAPSHOT.jar"]