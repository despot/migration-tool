# migration-tool

Clone it and either load into your favorite IDE or use maven/gradle directly.

## Using an IDE

You can run the system in your IDE by running the three server classes in order: _RegistrationServer_, _CountryServer_ and _WebServer_.  Each is a Spring Boot application using embedded Tomcat.  
In Spring Tool Suite use `Run As ... Spring Boot App` otherwise just run each as a Java application - each has a static `main()` entry point.

Open the Eureka dashboard [http://localhost:1111](http://localhost:1111) in your browser to see that the `COUNTRY-SERVICE` applications have registered. Next you can open [/countries/getAll](http://localhost:2222/countries/getAll) to get a response list of countries.

## Using Docker

This application can also be run using 2 docker containers. See [here](use-docker.md).
