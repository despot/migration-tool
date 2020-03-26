# Run Using Docker

We are going to run the Migration Tool Microservice application available at https://github.com/despot/migration-tool using 2 docker containers, one for the Eureka registration server and one for each microservice.

## Build the Image

1. Fetch the code using git clone `https://github.com/despot/migration-tool`

1. Build using either `mvn package`.

   This will create the jar: `target/migration-tool-1.0-SNAPSHOT.jar`

1. Here is the Dockerfile:

    ```sh
    FROM openjdk:11-jre
    ADD target/migration-tool-1.0-SNAPSHOT.jar app.jar
    EXPOSE 1111
    EXPOSE 2222
    ```

    What this does:

    * Use the OpenJDK 11 docker image (freely available at Docker hub) as a starting point. This image defines a minimal Linux system with OpenJDK 11 preinstalled.
    * Copy the demo jar into the container and rename it to `app.jar` to save typing later.  By default, `app.jar` will be copied into the root of the container file system.
    * Expose ports 1111, 2222.

1. To build the container 
   
   **Prerequisites:** 
   1. In your docker toolbox console, go to the folder containing Dockerfile (example:cd /c/Users/Despot/IdeaProjects/migration-tool)
   2. the `.` at the end, indicating to use the current directory as its working directory; 
   3. make sure you have setup an account in dockerhub and you have changed the part despotjakimovski to your account.

    ```sh
    docker build -t despotjakimovski/migration-tool .
    ```
      
1. Check it worked. You should see `despotjakimovski/migration-tool` listed.

    ```sh
    docker images
    ```

## Running the Application

We will run the container 2 times, each time running the Java application in a different mode.

TBD: an example diagram of the microservices communication. 

1. They need to talk to each other, so let's give them a network ('docker network ls' to check for available networks):

    ```sh
    docker network create mt-net
    ```

1. Now run the first container. This runs up the Eureka registration server, which will allow the other microservices to find each other:

    ```sh
    docker run --name reggo --hostname reggo --network mt-net -p 1111:1111 despotjakimovski/migration-tool java -jar app.jar reg
    ```

    The `-d` (detach) flag is missing so all output will stream to the console so we can see what is happening.
    
    As soon as the application starts up, it displays its IP address. Remember this for later.

1. In your browser, go to http://localhost:1111 (If you're using docker-toolbox, then you might need to use 'docker-machine ip default' to get the IP instead of localhost. Ex: http://192.168.99.100:1111/) and you should see the Eureka dashboard. There are no instances registered.

1. _In a new CMD/Terminal window_, run a second container for the country microservice. This holds a database of couple of available countries (stored using an embedded MySQL database)

    ```sh
    docker run --name country --hostname country --network mt-net -p 2222:2222 --rm despotjakimovski/migration-tool java -jar app.jar country  --registration.server.hostname=<reg server ip addr>
    ```

    Replace `<eg server ip addr>` with the IP address you determined earlier. Or to find the reg server ip, you can do: 
    ```
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name_or_id
    ```
    Ex: 172.18.0.2

1. Return to the Eureka Dashboard in your browser and refresh the screen.  You should see that `COUNTRY-SERVICE` is now registered.

1. In a second browser tab, go to http://192.168.99.100:2222/countries/getAll.  This is the web interface you just deployed and you should be able to view the countries information.
